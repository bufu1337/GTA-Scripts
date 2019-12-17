//-------------------------------------------------
//
// Seifanimations - Perfect for role playing servers
// Based on kyeman's vactions script
//
//-------------------------------------------------

#include <a_samp>
#include <core>
#include <float>

#define GREEN 0x21DD00FF
#define RED 0xE60000FF
#define ADMIN_RED 0xFB0000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define LIGHTRED 0xFF8080FF
#define LIGHTBLUE 0x00C2ECFF
#define PURPLE 0xB360FDFF
#define PLAYER_COLOR 0xFFFFFFFF
#define BLUE 0x1229FAFF
#define LIGHTGREEN 0x38FF06FF
#define DARKPINK 0xE100E1FF
#define DARKGREEN 0x008040FF
#define ANNOUNCEMENT 0x6AF7E1FF
#define COLOR_SYSTEM 0xEFEFF7AA
#define GREY 0xCECECEFF
#define PINK 0xD52DFFFF
#define DARKGREY    0x626262FF
#define AQUAGREEN   0x03D687FF
#define NICESKY 0x99FFFFAA
#define WHITE 			0xFFFFFFFF

#define SPECIAL_ACTION_PISSING      68
//#define DISALLOW_ANIMS_INVEHICLES   //Uncomment if you don't want animations inside vehicles

new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];
new animation[200];
new Text:txtAnimHelper;

//-------------------------------------------------

// ********** INTERNAL FUNCTIONS **********

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

//------------------------------------------------

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

//-------------------------------------------------

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
	animation[playerid]++;
}

//-------------------------------------------------

LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
    gPlayerUsingLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp);
    TextDrawShowForPlayer(playerid,txtAnimHelper);
    animation[playerid]++;
}

//-------------------------------------------------

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
}

//-------------------------------------------------

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

//-------------------------------------------------

// ********** CALLBACKS **********

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gPlayerUsingLoopingAnim[playerid]) return;

	//SendClientInt(playerid, RED, "ID: %d", newkeys);

	if(IsKeyJustDown(KEY_HANDBRAKE,newkeys,oldkeys)) {
	    StopLoopingAnim(playerid);
        TextDrawHideForPlayer(playerid,txtAnimHelper);
        animation[playerid] = 0;
    }
}

//------------------------------------------------
public OnPlayerDeath(playerid, killerid, reason)
{
	// if they die whilst performing a looping anim, we should reset the state
	if(gPlayerUsingLoopingAnim[playerid]) {
        gPlayerUsingLoopingAnim[playerid] = 0;
        TextDrawHideForPlayer(playerid,txtAnimHelper);
	}
 	return 1;
}
//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(!gPlayerAnimLibsPreloaded[playerid]) {
   		PreloadAnimLib(playerid,"BOMBER");
   		PreloadAnimLib(playerid,"RAPPING");
    	PreloadAnimLib(playerid,"SHOP");
   		PreloadAnimLib(playerid,"BEACH");
   		PreloadAnimLib(playerid,"SMOKING");
    	PreloadAnimLib(playerid,"FOOD");
    	PreloadAnimLib(playerid,"ON_LOOKERS");
    	PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		PreloadAnimLib(playerid,"PED");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

//-------------------------------------------------

public OnPlayerConnect(playerid)
{
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	return 1;
}

//-------------------------------------------------

public OnFilterScriptInit()
{
	// Init our text display
	txtAnimHelper = TextDrawCreate(610.0, 400.0,
	"~b~~k~~PED_LOCK_TARGET~ ~w~to stop the animation");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0); // no shadow
    TextDrawSetOutline(txtAnimHelper,1); // thickness 1
    TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
    TextDrawColor(txtAnimHelper,0xFFFFFFFF);
    TextDrawAlignment(txtAnimHelper,3); // align right
}

public OnFilterScriptExit()
{
	TextDrawDestroy(txtAnimHelper);
}

//-------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new tmp[256];
	new idx;
	new dancestyle;
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd,"/animlist",true)==0)
	{
	    SendClientMessage(playerid, YELLOW, "________________________________________________________________________________________________________________________");
		SendClientMessage(playerid,RED,"-Available Animations:");
	    SendClientMessage(playerid,WHITE,"/fall - /fallback - /injured - /akick - /push - /lowbodypush - /handsup - /bomb - /drunk - /getarrested - /laugh - /sup");
        SendClientMessage(playerid,WHITE," /basket - /headbutt - /medic - /spray - /robman - /taichi - /lookout - /kiss - /cellin - /cellout - /crossarms - /lay");
        SendClientMessage(playerid,WHITE,"/deal - /crack - /smoke - /groundsit - /chat - /dance - /fucku - /strip - /hide - /vomit - /eat - /chairsit - /reload");
        SendClientMessage(playerid,WHITE,"/koface - /kostomach - /rollfall - /carjacked1 - /carjacked2 - /rcarjack1 - /rcarjack2 - /lcarjack1 - /lcarjack2 - /bat");
        SendClientMessage(playerid,WHITE,"/lifejump - /exhaust - /leftslap - /carlock - /hoodfrisked - /lightcig - /tapcig - /box - /lay2 - /chant - finger");
        SendClientMessage(playerid,WHITE,"/shouting - /knife - /cop - /elbow - /kneekick - /airkick - /gkick - /gpunch - /fstance - /lowthrow - /highthrow - /aim");
        SendClientMessage(playerid,WHITE,"/pee - /lean - /run");
        SendClientMessage(playerid, YELLOW, "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
        return true;
	}

	// carjacked
    if(strcmp(cmd, "/carjacked1", true) == 0) {
		 LoopingAnim(playerid,"PED","CAR_jackedLHS",4.0,0,1,1,1,0);
         return 1;
    }

    // carjacked
    if(strcmp(cmd, "/carjacked2", true) == 0) {
		 LoopingAnim(playerid,"PED","CAR_jackedRHS",4.0,0,1,1,1,0);
         return 1;
    }

	#if defined DISALLOW_ANIMS_INVEHICLES
	    if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, RED, "You are not allowed to use animations inside a vehicle");
	#endif

	// HANDSUP
 	if(strcmp(cmd, "/handsup", true) == 0) {
		//SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
		LoopingAnim(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
        return 1;
    }

    // CELLPHONE IN
 	if(strcmp(cmd, "/cellin", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
        return 1;
    }

    // CELLPHONE OUT
 	if(strcmp(cmd, "/cellout", true) == 0) {
		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
        return 1;
    }

    // Drunk
    if(strcmp(cmd, "/drunk", true) == 0) {
		LoopingAnim(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
		return 1;
    }

	// Place a Bomb
    if (strcmp("/bomb", cmdtext, true) == 0) {
		ClearAnimations(playerid);
		LoopingAnim(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0); // Place Bomb
		return 1;
	}
	// Police Arrest
    if (strcmp("/getarrested", cmdtext, true) == 0) {
	      LoopingAnim(playerid,"ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1); // Gun Arrest
		  return 1;
    }
	// Laugh
    if (strcmp("/laugh", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0); // Laugh
		  return 1;
	}
	// Rob Lookout
    if (strcmp("/lookout", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0); // Rob Lookout
		  return 1;
	}
	// Rob Threat
    if (strcmp("/robman", cmdtext, true) == 0) {
          LoopingAnim(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0); // Rob
		  return 1;
	}
	// Arms crossed
    if (strcmp("/crossarms", cmdtext, true) == 0) {
          LoopingAnim(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1); // Arms crossed
		  return 1;
	}
	// Lay Down
    if (strcmp("/lay", cmdtext, true) == 0) {
          LoopingAnim(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0); // Lay down
		  return 1;
    }
	// Take Cover
    if (strcmp("/hide", cmdtext, true) == 0) {
          LoopingAnim(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0); // Taking Cover
		  return 1;
	}
	// Vomit
    if (strcmp("/vomit", cmdtext, true) == 0) {
	      OnePlayAnim(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0); // Vomit BAH!
		  return 1;
	}
	// Eat Burger
    if (strcmp("/eat", cmdtext, true) == 0) {
	      OnePlayAnim(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0); // Eat Burger
		  return 1;
	}
	// Wave
    if (strcmp("/wave", cmdtext, true) == 0) {
	      LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0); // Wave
		  return 1;
	}
	// Slap Ass
    if (strcmp("/slapass", cmdtext, true) == 0) {
   		OnePlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0); // Ass Slapping
 		return 1;
	}
	// Dealer
    if (strcmp("/deal", cmdtext, true) == 0) {
          OnePlayAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0); // Deal Drugs
		  return 1;
	}
	// Crack Dieing
    if (strcmp("/crack", cmdtext, true) == 0) {
          LoopingAnim(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0); // Dieing of Crack
		  return 1;
	}
	// Smoking animations
	if(strcmp(cmd, "/smoke", true) == 0)
    {
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /smoke [1-4]");
    	switch (cmdtext[7])
    	{
        	case '1': LoopingAnim(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0); // male
        	case '2': LoopingAnim(playerid,"SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0); //female
        	case '3': LoopingAnim(playerid,"SMOKING","M_smkstnd_loop", 4.0, 1, 0, 0, 0, 0); // standing-fucked
        	case '4': LoopingAnim(playerid,"SMOKING","M_smk_out", 4.0, 1, 0, 0, 0, 0); // standing
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /smoke [1-4]");
    	}
    	return 1;
    }
	// Sit
    if (strcmp("/groundsit", cmdtext, true) == 0 || strcmp("/gro", cmdtext, true) == 0) {
          LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0); // Sit
		  return 1;
    }
    // Idle Chat
    if(strcmp(cmd, "/chat", true) == 0) {
		 LoopingAnim(playerid,"PED","IDLE_CHAT",4.0,1,0,0,1,1);
         return 1;
    }
    // Fucku
    if(strcmp(cmd, "/fucku", true) == 0) {
		 OnePlayAnim(playerid,"PED","fucku",4.0,0,0,0,0,0);
         return 1;
    }
    // TaiChi
    if(strcmp(cmd, "/taichi", true) == 0) {
		 LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
         return 1;
    }

    // ChairSit
    if(strcmp(cmd, "/chairsit", true) == 0) {
		 LoopingAnim(playerid,"PED","SEAT_down",4.1,0,1,1,1,0);
         return 1;
    }

    // Fall on the ground
    if(strcmp(cmd, "/fall", true) == 0) {
		 LoopingAnim(playerid,"PED","KO_skid_front",4.1,0,1,1,1,0);
         return 1;
    }

    // Fall
    if(strcmp(cmd, "/fallback", true) == 0) {
		 LoopingAnim(playerid, "PED","FLOOR_hit_f", 4.0, 1, 0, 0, 0, 0);
         return 1;
    }

    // kiss
    if(strcmp(cmd, "/kiss", true) == 0) {
		 LoopingAnim(playerid, "KISSING", "Playa_Kiss_02", 3.0, 1, 1, 1, 1, 0);
         return 1;
    }

    // Injujred
    if(strcmp(cmd, "/injured", true) == 0) {
		 LoopingAnim(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0);
         return 1;
    }

    // Homie animations
    if(strcmp(cmd, "/sup", true) == 0)
    {
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /sup [1-3]");
    	switch (cmdtext[5])
    	{
        	case '1': OnePlayAnim(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
         	case '2': OnePlayAnim(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
         	case '3': OnePlayAnim(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /sup [1-3]");
    	}
    	return 1;
    }

    // Rap animations
    if(strcmp(cmd, "/rap", true) == 0)
    {
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /rap [1-4]");
    	switch (cmdtext[5])
    	{
    	    case '1': LoopingAnim(playerid,"RAPPING","RAP_A_Loop",4.0,1,0,0,0,0);
        	case '2': LoopingAnim(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
        	case '3': LoopingAnim(playerid,"GANGS","prtial_gngtlkD",4.0,1,0,0,0,0);
        	case '4': LoopingAnim(playerid,"GANGS","prtial_gngtlkH",4.0,1,0,0,1,1);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /rap [1-4]");
    	}
    	return 1;
    }

    // Violence animations
    if(strcmp(cmd, "/push", true) == 0) {
		 OnePlayAnim(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
         return 1;
    }

    if(strcmp(cmd, "/akick", true) == 0) {
		 OnePlayAnim(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
         return 1;
    }

    if(strcmp(cmd, "/lowbodypush", true) == 0) {
		 OnePlayAnim(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
         return 1;
    }

    // Spray
    if(strcmp(cmd, "/spray", true) == 0) {
		 OnePlayAnim(playerid,"SPRAYCAN","spraycan_full",4.0,0,0,0,0,0);
         return 1;
    }

    // Headbutt
    if(strcmp(cmd, "/headbutt", true) == 0) {
		 OnePlayAnim(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
         return 1;
    }

    // Medic
    if(strcmp(cmd, "/medic", true) == 0) {
		 OnePlayAnim(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
         return 1;
    }

    // KO Face
    if(strcmp(cmd, "/koface", true) == 0) {
		 LoopingAnim(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
         return 1;
    }

    // KO Stomach
    if(strcmp(cmd, "/kostomach", true) == 0) {
		 LoopingAnim(playerid,"PED","KO_shot_stom",4.0,0,1,1,1,0);
         return 1;
    }

    // Jump for your life!
    if(strcmp(cmd, "/lifejump", true) == 0) {
		 LoopingAnim(playerid,"PED","EV_dive",4.0,0,1,1,1,0);
         return 1;
    }

    // Exhausted
    if(strcmp(cmd, "/exhaust", true) == 0) {
		 LoopingAnim(playerid,"PED","IDLE_tired",3.0,1,0,0,0,0);
         return 1;
    }

    // Left big slap
    if(strcmp(cmd, "/leftslap", true) == 0) {
		 OnePlayAnim(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
         return 1;
    }

    // Big fall
    if(strcmp(cmd, "/rollfall", true) == 0) {
		 LoopingAnim(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,0);
         return 1;
    }

    // Locked
    if(strcmp(cmd, "/carlock", true) == 0) {
		 OnePlayAnim(playerid,"PED","CAR_doorlocked_LHS",4.0,0,0,0,0,0);
         return 1;
    }

    // carjack
    if(strcmp(cmd, "/rcarjack1", true) == 0) {
		 OnePlayAnim(playerid,"PED","CAR_pulloutL_LHS",4.0,0,0,0,0,0);
         return 1;
    }

    // carjack
    if(strcmp(cmd, "/lcarjack1", true) == 0) {
		 OnePlayAnim(playerid,"PED","CAR_pulloutL_RHS",4.0,0,0,0,0,0);
         return 1;
    }

    // carjack
    if(strcmp(cmd, "/rcarjack2", true) == 0) {
		 OnePlayAnim(playerid,"PED","CAR_pullout_LHS",4.0,0,0,0,0,0);
         return 1;
    }

    // carjack
    if(strcmp(cmd, "/lcarjack2", true) == 0) {
		 OnePlayAnim(playerid,"PED","CAR_pullout_RHS",4.0,0,0,0,0,0);
         return 1;
    }

    // Hood frisked
    if(strcmp(cmd, "/hoodfrisked", true) == 0) {
		 LoopingAnim(playerid,"POLICE","crm_drgbst_01",4.0,0,1,1,1,0);
         return 1;
    }

    // Lighting cigarette
    if(strcmp(cmd, "/lightcig", true) == 0) {
		 OnePlayAnim(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0);
         return 1;
    }

    // Tap cigarette
    if(strcmp(cmd, "/tapcig", true) == 0) {
		 OnePlayAnim(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0);
         return 1;
    }

    // Bat stance
    if(strcmp(cmd, "/bat", true) == 0) {
		 LoopingAnim(playerid,"BASEBALL","Bat_IDLE",4.0,1,1,1,1,0);
         return 1;
    }

    // Boxing
    if(strcmp(cmd, "/box", true) == 0) {
		 LoopingAnim(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
         return 1;
    }

    // Lay 2
    if(strcmp(cmd, "/lay2", true) == 0) {
		 LoopingAnim(playerid,"SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0);
         return 1;
    }

    // Gogogo
    if(strcmp(cmd, "/chant", true) == 0) {
		 LoopingAnim(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
         return 1;
    }

    // Finger
    if(strcmp(cmd, "/finger", true) == 0) {
		 OnePlayAnim(playerid,"RIOT","RIOT_FUKU",2.0,0,0,0,0,0);
         return 1;
    }

    // Shouting
    if(strcmp(cmd, "/shouting", true) == 0) {
		 LoopingAnim(playerid,"RIOT","RIOT_shout",4.0,1,0,0,0,0);
         return 1;
    }

    // Cop stance
    if(strcmp(cmd, "/cop", true) == 0) {
		 OnePlayAnim(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
         return 1;
    }

    // Elbow
    if(strcmp(cmd, "/elbow", true) == 0) {
		 OnePlayAnim(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
         return 1;
    }

    // Knee kick
    if(strcmp(cmd, "/kneekick", true) == 0) {
		 OnePlayAnim(playerid,"FIGHT_D","FightD_2",4.0,0,1,1,0,0);
         return 1;
    }

    // Fight stance
    if(strcmp(cmd, "/fstance", true) == 0) {
		 LoopingAnim(playerid,"FIGHT_D","FightD_IDLE",4.0,1,1,1,1,0);
         return 1;
    }

    // Ground punch
    if(strcmp(cmd, "/gpunch", true) == 0) {
		 OnePlayAnim(playerid,"FIGHT_B","FightB_G",4.0,0,0,0,0,0);
         return 1;
    }

    // Air kick
    if(strcmp(cmd, "/airkick", true) == 0) {
		 OnePlayAnim(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
         return 1;
    }

    // Ground kick
    if(strcmp(cmd, "/gkick", true) == 0) {
		 OnePlayAnim(playerid,"FIGHT_D","FightD_G",4.0,0,0,0,0,0);
         return 1;
    }

    // Low throw
    if(strcmp(cmd, "/lowthrow", true) == 0) {
		 OnePlayAnim(playerid,"GRENADE","WEAPON_throwu",3.0,0,0,0,0,0);
         return 1;
    }

    // Ground kick
    if(strcmp(cmd, "/highthrow", true) == 0) {
		 OnePlayAnim(playerid,"GRENADE","WEAPON_throw",4.0,0,0,0,0,0);
         return 1;
    }

    // Deal stance
    if(strcmp(cmd, "/dealstance", true) == 0) {
		 LoopingAnim(playerid,"DEALER","DEALER_IDLE",4.0,1,0,0,0,0);
         return 1;
    }

    // Deal stance
    if(strcmp(cmd, "/pee", true) == 0) {
		 SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);
         return 1;
    }

    // Knife animations
    if(strcmp(cmd, "/knife", true) == 0)
    {
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /knife [1-4]");
    	switch (cmdtext[7])
    	{
    	    case '1': LoopingAnim(playerid,"KNIFE","KILL_Knife_Ped_Damage",4.0,0,1,1,1,0);
        	case '2': LoopingAnim(playerid,"KNIFE","KILL_Knife_Ped_Die",4.0,0,1,1,1,0);
        	case '3': OnePlayAnim(playerid,"KNIFE","KILL_Knife_Player",4.0,0,0,0,0,0);
        	case '4': LoopingAnim(playerid,"KNIFE","KILL_Partial",4.0,0,1,1,1,1);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /knife [1-4]");
    	}
    	return 1;
    }

    // Basket-ball
    if(strcmp(cmd, "/basket", true) == 0)
    {
        if (!strlen(cmdtext[8])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /basket [1-6]");
    	switch (cmdtext[8])
    	{
        	case '1': LoopingAnim(playerid,"BSKTBALL","BBALL_idleloop",4.0,1,0,0,0,0);
        	case '2': OnePlayAnim(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
        	case '3': OnePlayAnim(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
        	case '4': LoopingAnim(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
        	case '5': LoopingAnim(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
        	case '6': LoopingAnim(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /basket [1-6]");
    	}
    	return 1;
    }

    // Reloading guns
    if(strcmp(cmd, "/reload", true) == 0)
    {
        if (!strlen(cmdtext[8])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /reload [deagle/smg/ak/m4]");
       	if (strcmp("deagle",cmdtext[8],true) == 0)
   	    {
   			OnePlayAnim(playerid,"COLT45","colt45_reload",4.0,0,0,0,0,1);
 	    }
 	    else if (strcmp("smg",cmdtext[8],true) == 0 || strcmp("ak",cmdtext[8],true) == 0 || strcmp("m4",cmdtext[8],true) == 0)
   	    {
   			OnePlayAnim(playerid,"UZI","UZI_reload",4.0,0,0,0,0,0);
 	    }
       	else SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /reload [deagle/smg/ak/m4]");
    	return 1;
    }

    if(strcmp(cmd, "/gwalk", true) == 0)
    {
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /gwalk [1/2]");
        new style = strval(cmdtext[6]);
       	if (style == 1)
   	    {
   			LoopingAnim(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
 	    }
 	    else if (style == 2)
   	    {
   			LoopingAnim(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
 	    }
       	else SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /gwalk [1/2]");
    	return 1;
    }

    //Aiming animation
    if(strcmp(cmd, "/aim", true) == 0)
    {
        if (!strlen(cmdtext[5])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /aim [1-.]");
    	switch (cmdtext[5])
    	{
        	case '1': LoopingAnim(playerid,"PED","gang_gunstand",4.0,1,1,1,1,1);
        	case '2': LoopingAnim(playerid,"PED","Driveby_L",4.0,0,1,1,1,1);
        	case '3': LoopingAnim(playerid,"PED","Driveby_R",4.0,0,1,1,1,1);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /aim [1-3]");
    	}
    	return 1;
    }

    // Leaning animation
    if(strcmp(cmd, "/lean", true) == 0)
    {
        if (!strlen(cmdtext[6])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /lean [1-2]");
    	switch (cmdtext[6])
    	{
        	case '1': LoopingAnim(playerid,"GANGS","leanIDLE",4.0,0,1,1,1,0);
        	case '2': LoopingAnim(playerid,"MISC","Plyrlean_loop",4.0,0,1,1,1,0);
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /lean [1-2]");
    	}
    	return 1;
    }

    if(strcmp(cmd, "/run", true) == 0)
    {
		LoopingAnim(playerid,"PED","sprint_civi",floatstr(cmdtext[5]),1,1,1,1,1);
		printf("%f",floatstr(cmdtext[5]));
    	return 1;
    }

    // Clear
    if(strcmp(cmd, "/clear", true) == 0) {
		 //ClearAnimations(playerid);
		 ApplyAnimation(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
         return 1;
    }

    // Strip
    if(strcmp(cmd, "/strip", true) == 0)
    {
        if (!strlen(cmdtext[7])) return SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /strip [A-G]");
    	switch (cmdtext[7])
    	{
        	case 'a', 'A': LoopingAnim(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1 );
        	case 'b', 'B': LoopingAnim(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1 );
        	case 'c', 'C': LoopingAnim(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1 );
        	case 'd', 'D': LoopingAnim(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1 );
        	case 'e', 'E': LoopingAnim(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1 );
        	case 'f', 'F': LoopingAnim(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1 );
        	case 'g', 'G': LoopingAnim(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1 );
        	default: SendClientMessage(playerid,0xEFEFF7AA,"USAGE: /strip [A-G]");
    	}
    	return 1;
    }

    /* Would allow people to troll... but would be cool as a script
	   controlled function
    // Bed Sleep R
    if(strcmp(cmd, "/inbedright", true) == 0) {
		 LoopingAnim(playerid,"INT_HOUSE","BED_Loop_R",4.0,1,0,0,0,0);
         return 1;
    }
    // Bed Sleep L
    if(strcmp(cmd, "/inbedleft", true) == 0) {
		 LoopingAnim(playerid,"INT_HOUSE","BED_Loop_L",4.0,1,0,0,0,0);
         return 1;
    }*/


	// START DANCING
 	if(strcmp(cmd, "/dance", true) == 0) {

			// Get the dance style param
      		tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)) {
				SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
				return 1;
			}

			dancestyle = strval(tmp);
			if(dancestyle < 1 || dancestyle > 4) {
			    SendClientMessage(playerid,0xFF0000FF,"USAGE: /dance [style 1-4]");
			    return 1;
			}

			if(dancestyle == 1) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
			} else if(dancestyle == 2) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
			} else if(dancestyle == 3) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
			} else if(dancestyle == 4) {
			    SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
			}
 	  		return 1;
	}

	return 0;
}