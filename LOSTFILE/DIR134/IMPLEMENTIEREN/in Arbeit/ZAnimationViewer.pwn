#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>

// ---

#define AV_COMMAND "/av"

//this is a required file
#define ANIMS_FILE "animslist.txt"

//this will be created automatically
#define FAVOURITES_FILE "anims_favs.txt"

// ---

//Animation Library will be AL shortly

new gNumALs = 0;
new gALNames[256][32];//I've found 128 anim libraries, so 256 would be enough
new gALFirstAnimIndex[256];
new gALNumAnims[256];

new gAnimNames[3000][32];//There are 2096 lines in animslist.txt

// ---

//Animation Viewer will be AV shortly

new gAVIsUsed = false;
new gAVUserId = INVALID_PLAYER_ID;

// ---
enum eAVTextBlock { Float:avtbPos[2], /*Float:avtbLetterSize[2],*/
	avtbAlignment, avtbColor, avtbUseBox, avtbBoxColor, avtbShadow, avtbOutline, avtbBgColor, avtbFont };

new gAVTextBlocks[][eAVTextBlock] = {
	{{320.0, 10.0}, 2, 0xfffff0ff, false, 0x00000090, 1, 1, 0x606000ff, 2 },//help message
	{{7.0, 130.0}, 1, 0xffffffff, false, 0x000000ff, 0, 1, 0x000000ff, 1 },
	{{7.0, 150.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 170.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 190.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 210.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 230.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 250.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 },
	{{7.0, 270.0}, 1, 0xffffffff, false, 0x000000ff, 0, 0, 0x000000ff, 1 }
};
new Text:gAVTextBlockObjects[10];
//block 0 is help block

new gAVCurrentProperty = 0;//there are 8 of them: indices 0-7
new gAVCurrentAL = 0;
new gAVCurrentAnim = 0;//not absolute index, but relative to a library's index range
new gAVLastAnim = 0;
new Float:gAVfSpeed = 4.0;
new gAVLooping = false;
new gAVLock[3] = { 1, 1, 1 };
new gAVOpt5 = -1;

new gAVOldKeys, gAVOldUpDown, gAVOldLeftRight;

// ---

forward zStripNewLine(string[]);
forward copy(dst[],const src[],count);

forward avTimer();

public zStripNewLine(string[])
{
	if(string[0] == 0)
		return;
	new len = strlen(string);
	if(string[len - 1] == '\n' || string[len - 1] == '\r')
		string[len - 1] = 0;
	if(len < 2)
		return;
	if(string[len - 2] == '\n' || string[len - 2] == '\r')
		string[len - 2] = 0;
}

public copy(dst[],const src[],count)
{
	dst[0] = 0;
	if(count < 0)
		return false;
	new srclen = strlen(src);
	if(count > srclen)
		count = srclen;
	for(new i = 0; i < count; i++)
	{
		dst[i] = src[i];
		if(src[i] == 0)
			return true;
	}
	dst[count] = 0;
	return true;
}

//the function is not quite safe. it relys hardly on the correctness of the input file
stock avLoadAnimNames()
{
	printf("AV loader is loading animations list... ");
	
	new File:f = fopen(ANIMS_FILE, io_read);
	
	if(!f)
		return false;
	
	new num_anims = 0;
	new in_library = false;
	new run = true;
	new str[256];
	
	while(run)
	{
		fread(f, str, sizeof(str));
		
		zStripNewLine(str);
		
		if(strlen(str) == 0)
			break;
		
		if(!in_library)
		{
			if(str[0] == '{')
			{
				in_library = true;
				continue;
			}

			copy(gALNames[gNumALs], str, 32);
			gALFirstAnimIndex[gNumALs] = num_anims;
			gALNumAnims[gNumALs] = 0;
			gNumALs++;
		}
		else
		{
			if(str[0] == '}')
			{
				//printf("%d ", gALNumAnims[gNumALs - 1]);
				in_library = false;
				continue;
			}
			
			copy(gAnimNames[num_anims], str, 32);
			num_anims++;
			gALNumAnims[gNumALs - 1]++;
		}
	}
	
	printf("Totally %d animation names", num_anims);
	
	fclose(f);
	
	return true;
}

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

avRefreshTextBlock(blockid, free = true)
{
	if(free)
		TextDrawDestroy(gAVTextBlockObjects[blockid]);
	
	new str[256];
	
	switch(blockid)
	{
		case 0://help
			format(str, sizeof(str), "~w~Use arrows to change props~n~~y~~k~~PED_SPRINT~ ~w~to play animation~n~~y~~k~~PED_JUMPING~ ~w~ to clear animation~n~~y~~k~~PED_ANSWER_PHONE~ ~w~to save to favs file");
		case 1:
			format(str, sizeof(str), "Library #%d: %s (%d anims)",
				gAVCurrentAL, gALNames[gAVCurrentAL], gALNumAnims[gAVCurrentAL]);
		case 2:
			format(str, sizeof(str), "Anim #%d: %s",
				gAVCurrentAnim, gAnimNames[gALFirstAnimIndex[gAVCurrentAL] + gAVCurrentAnim]);
		case 3:
			format(str, sizeof(str), "fSpeed: %.3f", gAVfSpeed);
		case 4:
			format(str, sizeof(str), "Looping: %d", gAVLooping);
		case 5:
			format(str, sizeof(str), "X Lock: %d", gAVLock[0]);
		case 6:
			format(str, sizeof(str), "Y Lock: %d", gAVLock[1]);
		case 7:
			format(str, sizeof(str), "Z Lock: %d", gAVLock[2]);
		case 8:
			format(str, sizeof(str), "opt5: %d", gAVOpt5);
	}
	
	new tb[eAVTextBlock];
	tb = gAVTextBlocks[blockid];
	
	//Float:avtbPos[2], /*Float:avtbLetterSize[2],*/
	//avtbAlignment, avtbColor, avtbUseBox, avtbBoxColor, avtbShadow, avtbOutline, avtbBgColor, avtbFont };
	
	gAVTextBlockObjects[blockid] = TextDrawCreate(tb[avtbPos][0], tb[avtbPos][1], str);
	//TextDrawLetterSize(Text:text, Float:x, Float:y);
	//TextDrawTextSize(Text:text, Float:x, Float:y);
	TextDrawAlignment		(gAVTextBlockObjects[blockid], tb[avtbAlignment]);
	TextDrawColor			(gAVTextBlockObjects[blockid], tb[avtbColor]);
	TextDrawUseBox			(gAVTextBlockObjects[blockid], tb[avtbUseBox]);
	TextDrawBoxColor		(gAVTextBlockObjects[blockid], tb[avtbBoxColor]);
	TextDrawSetShadow		(gAVTextBlockObjects[blockid], tb[avtbShadow]);
	TextDrawSetOutline		(gAVTextBlockObjects[blockid], tb[avtbOutline]);
	TextDrawBackgroundColor	(gAVTextBlockObjects[blockid], tb[avtbBgColor]);
	TextDrawFont			(gAVTextBlockObjects[blockid], tb[avtbFont]);
	
	TextDrawShowForPlayer(gAVUserId, gAVTextBlockObjects[blockid]);
}

stock avEnterAV(playerid)
{
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	
	gAVIsUsed = true;
	gAVUserId = playerid;
	
	for(new i = 0; i < 9; i++)
		avRefreshTextBlock(i, false);
}

stock avLeaveAV(playerid)
{
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	
	gAVIsUsed = false;
	
	for(new i = 0; i < 9; i++)
		TextDrawDestroy(gAVTextBlockObjects[i]);
}

stock avAlterProperty(delta)//delta == +1 or -1
{
	switch(gAVCurrentProperty)
	{
	case 0://library
		{
			gAVCurrentAL += delta;
			
			if(gAVCurrentAL > gNumALs - 1)
				gAVCurrentAL = 0;
			else if(gAVCurrentAL < 0)
				gAVCurrentAL = gNumALs - 1;
			
			gAVCurrentAnim = 0;
			
			avRefreshTextBlock(2);//anim name
		}
	case 1://anim name
		{
			gAVCurrentAnim += delta;
			if(gAVCurrentAnim > gALNumAnims[gAVCurrentAL] - 1)
				gAVCurrentAnim = 0;
			else if(gAVCurrentAnim < 0)
				gAVCurrentAnim = gALNumAnims[gAVCurrentAL] - 1;
		}
	case 2:
		gAVfSpeed += 0.1 * float(delta);
	case 3:
		gAVLooping = !gAVLooping;
	case 4:
		gAVLock[0] = !gAVLock[0];
	case 5:
		gAVLock[1] = !gAVLock[1];
	case 6:
		gAVLock[2] = !gAVLock[2];
	case 7:
		{
			gAVOpt5 = gAVOpt5 < 0 ? 0 : gAVOpt5 + delta * 500;
			if(gAVOpt5 < 0)
				gAVOpt5 = -1;
		}
	}
	
	avRefreshTextBlock(1 + gAVCurrentProperty);
}

public OnPlayerDeath(playerid, killerid, reason)
{
 	return 1;
}

public OnPlayerDisconnect(playerid)
{
	if(gAVIsUsed && gAVUserId == playerid)
		avLeaveAV(playerid);
	return 1;
}

public OnFilterScriptInit()
{
	printf("\r\n---\r\nZAnimationViewer is loading... ");
	if(!avLoadAnimNames())
		printf("Error: failed to load anim names\r\n---");
	else
		printf("seems to succeed ;)\r\n---");
	
	SetTimer("avTimer", 50, true);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, AV_COMMAND, true, strlen(AV_COMMAND)) == 0)
	{
		if(!gAVIsUsed)
		{
			avEnterAV(playerid);
			SendClientMessage(playerid, 0x00aa00ff, "* You've entered AV mode");
		}
		else if(gAVIsUsed && gAVUserId == playerid)
		{
			avLeaveAV(playerid);
			SendClientMessage(playerid, 0x00aa00ff, "* You've left AV mode");
		}
		else
		{
			SendClientMessage(playerid, 0xdd0000ff, "Sorry, AV is used now by another player");
		}
		
		return 1;//whether i return 1 or 0 it always says "unknown command", fuck it
	}

	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gAVIsUsed || playerid != gAVUserId)
		return 1;
	
	if(IsKeyJustDown(KEY_SPRINT, newkeys, gAVOldKeys))
	{
		if(gAVLastAnim == gALFirstAnimIndex[gAVCurrentAL] + gAVCurrentAnim)
			ClearAnimations(gAVUserId);//clear them to re-run the same animation properly
		
		ApplyAnimation(gAVUserId, gALNames[gAVCurrentAL],
			gAnimNames[gALFirstAnimIndex[gAVCurrentAL] + gAVCurrentAnim],
			gAVfSpeed, gAVLooping, gAVLock[0], gAVLock[1], gAVLock[2], gAVOpt5);
		
		gAVLastAnim = gALFirstAnimIndex[gAVCurrentAL] + gAVCurrentAnim;
	}
	else if(IsKeyJustDown(KEY_JUMP, newkeys, gAVOldKeys))
		ClearAnimations(gAVUserId);
	else if(IsKeyJustDown(KEY_ACTION, newkeys, gAVOldKeys))
	{
		new File:f = fopen(FAVOURITES_FILE, io_append);
		
		if(!f)// || random(100) > 70) //lol ;)
		{
			PlayerPlaySound(gAVUserId, 1009, 0.0, 0.0, 0.0);//crash
			GameTextForPlayer(gAVUserId, "~r~Error!~n~~w~Unable to open favs file.", 2000, 4);
		}
		else
		{
			new str[256];
			format(str, sizeof(str), "ApplyAnimation(playerid, \"%s\", \"%s\", %.6f, %d, %d, %d, %d, %d);\r\n",
				gALNames[gAVCurrentAL],	gAnimNames[gALFirstAnimIndex[gAVCurrentAL] + gAVCurrentAnim],
				gAVfSpeed, gAVLooping, gAVLock[0], gAVLock[1], gAVLock[2], gAVOpt5);
			fwrite(f, str);
			fclose(f);
			
			PlayerPlaySound(gAVUserId, 1132, 0.0, 0.0, 0.0);//camera click
			GameTextForPlayer(gAVUserId, "~w~Success!~n~Animation saved.", 750, 4);
		}
	}
	
	gAVOldKeys = newkeys;
	
	return 1;
}

public avTimer()
{
	if(!gAVIsUsed)
		return;
	
	new keys, updown, leftright;
	
	GetPlayerKeys(gAVUserId, keys, updown, leftright);
	
	new ud_delta = 0, rl_delta = 0;
	
	if(updown == KEY_DOWN && gAVOldUpDown != KEY_DOWN)
		ud_delta = 1;
	if(updown == KEY_UP && gAVOldUpDown != KEY_UP)
		ud_delta = -1;
	
	if(leftright == KEY_RIGHT && gAVOldLeftRight != KEY_RIGHT)
		rl_delta = 1;
	if(leftright == KEY_LEFT && gAVOldLeftRight != KEY_LEFT)
		rl_delta = -1;
	
	if(ud_delta != 0)
	{
		new oldindex = gAVCurrentProperty;
		gAVCurrentProperty += ud_delta;
		if(gAVCurrentProperty > 7)
			gAVCurrentProperty = 0;
		else if(gAVCurrentProperty < 0)
			gAVCurrentProperty = 7;
		
		//I understand the case where oldindex == newindex. I don't care about it...
		gAVTextBlocks[1 + oldindex][avtbOutline] = 0;
		gAVTextBlocks[1 + gAVCurrentProperty][avtbOutline] = 1;
		
		avRefreshTextBlock(1 + oldindex);
		avRefreshTextBlock(1 + gAVCurrentProperty);
	}
	
	if(rl_delta != 0)
		avAlterProperty(rl_delta);
	
	gAVOldUpDown = updown;
	gAVOldLeftRight = leftright;
}
