/*
Seifader - SA-MP screen fader by Seif

*-----------------------------------------------*
| This include allows you to fade players'              |
| screens from a color or to a color. Also,     |
| it calls a callback when the fading finishes  |
| so you can do whatever when the fading ends.  |
| 'OnPlayerScreenFade & OnPlayerScreenColorFade'|
*-----------------------------------------------*
*/
/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
//**PRAGMAS**//

//**MISC**//
#define function%0(%1) forward%0(%1); public%0(%1)

#if defined MAX_PLAYERS
#undef MAX_PLAYERS
#define MAX_PLAYERS     40     // CHANGE IT TO YOUR PLAYER SLOTS IN YOUR SERVER
#endif
/*x---------------------------------Defining-------------------------------------x*/
//**COLORS*//

//Some colors I made
/*#define GREEN                         0x21DD00FF
#define RED                     0xE60000FF
#define ADMIN_RED               0xFB0000FF
#define YELLOW                  0xFFFF00FF
#define ORANGE                  0xF97804FF
#define LIGHTRED                0xFF8080FF
#define LIGHTBLUE               0x00C2ECFF
#define PURPLE                  0xB360FDFF
#define BLUE                    0x1229FAFF
#define LIGHTGREEN              0x38FF06FF
#define DARKPINK                0xE100E1FF
#define DARKGREEN               0x008040FF
#define ANNOUNCEMENT    0x6AF7E1FF
#define GREY                    0xCECECEFF
#define PINK                    0xD52DFFFF
#define DARKGREY        0x626262FF
#define AQUAGREEN       0x03D687FF
#define WHITE                   0xFFFFFFFF*/
//**MISC**//
#define MAX_FADES       1      // max fades that a player can have at the same time.
//**VARIABLES**//
new colorfade[MAX_PLAYERS][MAX_FADES];
new FadeAvailability[MAX_PLAYERS][MAX_FADES];
new Text:PlayerFadeText[MAX_PLAYERS][MAX_FADES];
new bool:FlashFade[MAX_PLAYERS][MAX_FADES];
new FlashFadeTimes[MAX_PLAYERS][MAX_FADES];
// **FORWARDS** //
forward OnPlayerScreenFade(playerid, color, speed);
forward OnPlayerScreenColorFade(playerid, color, speed);
forward OnPlayerFadeFlashed(playerid, color, speed);
// **NATIVES** //
/*
native Seifader_OnExit();
native RemovePlayerColorFade(playerid);
native FadePlayerScreen(playerid, color, speed);
native FadePlayerScreenToColor(playerid, color, speed);
native FlashPlayerScreen(playerid, color, speed, times);
native IsValidPlayerFade(playerid, fadeid);
*/
/*x---------------------------------Functions-------------------------------------x*/
/*
---[FadePlayerScreen]---
ýplayerid: the target
ýcolor: the color you want his screen to fade from
ýspeed: from 1-255 where 255 is the fastest(instant)
ýwipe_other_colorfades: (optional) we want no bug to occur, so this will make sure there's
no other fade that could've messed with it and thus maybe causing
a player's screen to be stuck at a color. It's random but you always
want to prevent it. I've fully tested this include and rarely
encountered that issue. Unfortunately, nothing is bug-free.
*Return: id of the fade
*-----------------------------------------------*
| Fades the player's screen from a color.               |
*-----------------------------------------------*
*/
stock FadePlayerScreen(playerid, color, speed, bool:wipe_other_colorfades = true)
{
	if (wipe_other_colorfades == true) RemovePlayerColorFade(playerid);
	new fadeid = FindFadeID(playerid);
	new maxalpha = GetAlpha(color);
	PlayerFadeText[playerid][fadeid] = TextDrawCreate(0.0, 0.0, "_");
	TextDrawFont(PlayerFadeText[playerid][fadeid], 1);
	TextDrawLetterSize(PlayerFadeText[playerid][fadeid], 0.0, 50.0);
	TextDrawUseBox(PlayerFadeText[playerid][fadeid], true);
	TextDrawColor(PlayerFadeText[playerid][fadeid], 0);
	colorfade[playerid][fadeid] = color;
	TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
	TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
	FadeAvailability[playerid][fadeid] = 1;
	FlashFade[playerid][fadeid] = false;
	SetTimerEx("ScreenFade", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	return fadeid;
}

/*
---[FadePlayerScreenToColor]---
ýplayerid: the target
ýcolor: the color you want his screen to fade TO
ýspeed: from 1-255 where 255 is the fastest(instant)
*Return: id of the fade
*-----------------------------------------------*
| Fades the player's screen to a color.                 |
*-----------------------------------------------*
*/
function FadePlayerScreenToColor(playerid, color, speed)
{
	new fadeid = FindFadeID(playerid);
	new maxalpha = GetAlpha(color);
	PlayerFadeText[playerid][fadeid] = TextDrawCreate(0.0, 0.0, "_");
	TextDrawFont(PlayerFadeText[playerid][fadeid], 1);
	TextDrawLetterSize(PlayerFadeText[playerid][fadeid], 0.0, 50.0);
	TextDrawUseBox(PlayerFadeText[playerid][fadeid], true);
	TextDrawColor(PlayerFadeText[playerid][fadeid], 0);
	color -= maxalpha;
	colorfade[playerid][fadeid] = color;
	TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
	TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
	FadeAvailability[playerid][fadeid] = 1;
	FlashFade[playerid][fadeid] = false;
	SetTimerEx("ScreenFadeColor", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	return fadeid;
}

/*
---[FlashPlayerScreen]---
ýplayerid: the target
ýcolor: the color you want his screen to flash to
ýspeed: from 1-255 where 1 is the fastest(instant)
ýtimes: amount of flashes
*Return: id of the fade
*-----------------------------------------------*
| Flashes the player's screen. Basically, this  |
| is a mix of FadePlayerScreen and ToColor              |
| together to make your screen flash.                   |
*-----------------------------------------------*
*/
function FlashPlayerScreen(playerid, color, speed, times)
{
	new fadeid = FindFadeID(playerid);
	new maxalpha = GetAlpha(color);
	PlayerFadeText[playerid][fadeid] = TextDrawCreate(0.0, 0.0, "_");
	TextDrawFont(PlayerFadeText[playerid][fadeid], 1);
	TextDrawLetterSize(PlayerFadeText[playerid][fadeid], 0.0, 50.0);
	TextDrawUseBox(PlayerFadeText[playerid][fadeid], true);
	TextDrawColor(PlayerFadeText[playerid][fadeid], 0);
	color -= maxalpha;
	colorfade[playerid][fadeid] = color;
	TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
	TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
	FadeAvailability[playerid][fadeid] = 1;
	FlashFade[playerid][fadeid] = true;
	FlashFadeTimes[playerid][fadeid] = times;
	SetTimerEx("ScreenFadeColor", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	return fadeid;
}

/*
---[RemovePlayerColorFade]---
ýplayerid: the target
*-----------------------------------------------*
| Removes every fade made to a player.                  |
*-----------------------------------------------*
*/
function RemovePlayerColorFade(playerid) // This function is used to erase every fade made for the player. Should be used before FadePlayerScreen to make sure there's no bug
{
	for(new i; i < MAX_FADES; i++)
	{
		TextDrawDestroy(PlayerFadeText[playerid][i]);
		FadeAvailability[playerid][i] = 0;
		FlashFade[playerid][i] = false;
		FlashFadeTimes[playerid][i] = 0;
	}
}

/*
---[IsValidPlayerFade]---
ýplayerid: the target
ýfadeid: the fade id you want to check
*Return: 1 if valid, 0 if invalid
*-----------------------------------------------*
| Checks if the fade id is valid, meaning               |
| if it's being used by the player or not.              |
*-----------------------------------------------*
*/
function IsValidPlayerFade(playerid, fadeid) return FadeAvailability[playerid][fadeid];

//------------------------------------------------: Script functions :---------------------------------------------------//
Seifader_OnExit()
{
	for(new all, m = GetMaxPlayers(); all < m; all++)
	{
		if (IsPlayerNPC(all) || !IsPlayerConnected(all)) continue;
		for(new f; f < MAX_FADES; f++)
		{
			TextDrawDestroy(PlayerFadeText[all][f]);
			FadeAvailability[all][f] = 0;
			FlashFade[all][f] = false;
			FlashFadeTimes[all][f] = 0;
		}
	}
}

function ScreenFade(playerid, color, speed, maxalpha, fadeid)
{
	if (color <= (colorfade[playerid][fadeid] - maxalpha))
	{
		FADECOLOR_FINISH:
		TextDrawDestroy(PlayerFadeText[playerid][fadeid]);
		OnPlayerScreenFade(playerid, color, speed);
		FadeAvailability[playerid][fadeid] = 0;
	}
	else
	{
		if (!FadeAvailability[playerid][fadeid]) return 1;
		color -= speed;
		if (color <= (colorfade[playerid][fadeid] - maxalpha)) goto FADECOLOR_FINISH; //color = (colorfade[playerid][fadeid] - maxalpha);
		TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
		TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
		SetTimerEx("ScreenFade", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	}
	return 1;
}

function ScreenFade_Flash(playerid, color, speed, maxalpha, fadeid)
{
	if (color <= colorfade[playerid][fadeid])
	{
		FADECOLOR_FINISH:
		if (FlashFade[playerid][fadeid] == true)
		{
			if (!FlashFadeTimes[playerid][fadeid])
			{
				TextDrawDestroy(PlayerFadeText[playerid][fadeid]);
				OnPlayerFadeFlashed(playerid, color, speed);
				FadeAvailability[playerid][fadeid] = 0;
				return 1;
			}
			TextDrawBoxColor(PlayerFadeText[playerid][fadeid], colorfade[playerid][fadeid]);
			TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
			SetTimerEx("ScreenFadeColor", 100, 0, "ddddd", playerid, colorfade[playerid][fadeid], speed, maxalpha, fadeid);
			return 1;
		}
		TextDrawDestroy(PlayerFadeText[playerid][fadeid]);
		OnPlayerScreenFade(playerid, color, speed);
		FadeAvailability[playerid][fadeid] = 0;
	}
	else
	{
		if (!FadeAvailability[playerid][fadeid]) return 1;
		color -= speed;
		if (color <= colorfade[playerid][fadeid]) goto FADECOLOR_FINISH; //color = (colorfade[playerid][fadeid] - maxalpha);
		TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
		TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
		SetTimerEx("ScreenFade_Flash", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	}
	return 1;
}

function ScreenFadeColor(playerid, color, speed, maxalpha, fadeid)
{
	if (color >= (colorfade[playerid][fadeid] + maxalpha))
	{
		FADE_FINISH:
		if (FlashFade[playerid][fadeid] == true)
		{
			FlashFadeTimes[playerid][fadeid]--;
			TextDrawBoxColor(PlayerFadeText[playerid][fadeid], colorfade[playerid][fadeid]+maxalpha);
			TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
			SetTimerEx("ScreenFade_Flash", 100, 0, "ddddd", playerid, colorfade[playerid][fadeid]+maxalpha, speed, maxalpha, fadeid);
			return 1;
		}
		OnPlayerScreenColorFade(playerid, color, speed);
		FadeAvailability[playerid][fadeid] = 0;
	}
	else
	{
		if (!FadeAvailability[playerid][fadeid]) return 1;
		color += speed;
		if (color >= (colorfade[playerid][fadeid] + maxalpha)) goto FADE_FINISH;
		TextDrawBoxColor(PlayerFadeText[playerid][fadeid], color);
		TextDrawShowForPlayer(playerid, PlayerFadeText[playerid][fadeid]);
		SetTimerEx("ScreenFadeColor", 100, 0, "ddddd", playerid, color, speed, maxalpha, fadeid);
	}
	return 1;
}

function FindFadeID(playerid)
{
	for(new f; f < MAX_FADES; f++)
	{
		if (FadeAvailability[playerid][f] == 0)
		{
//printf("found fade id: %d", f);
			return f;
		}
	}
	return -1;
}

function GetAlpha(color)
{
	return color&0xFF;
}
