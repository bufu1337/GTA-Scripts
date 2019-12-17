#include <a_samp>

#define LGreenColor   0x00FF04FF
#define RedColor      0xE81010FF

new Text:GiveDamage[MAX_PLAYERS];
new Text:TakeDamage[MAX_PLAYERS];

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Damage Filterscript");
	print("Scripted by [UG]Daniel");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else
#endif

public OnGameModeInit()
{
    for(new i; i < MAX_PLAYERS; ++i)
    {
	    GiveDamage[i] = TextDrawCreate(171.000000, 388.000000, " ");
	    TextDrawAlignment(GiveDamage[i], 2);
	    TextDrawBackgroundColor(GiveDamage[i], 255);
	    TextDrawFont(GiveDamage[i], 2);
	    TextDrawLetterSize(GiveDamage[i], 0.160000, 0.599999);
	    TextDrawColor(GiveDamage[i], 0x00FF04FF);
	    TextDrawSetOutline(GiveDamage[i], 1);
	    TextDrawSetProportional(GiveDamage[i], 1);
    }

    for(new i; i < MAX_PLAYERS; ++i)
    {
	    TakeDamage[i] = TextDrawCreate(440.000000,388.000000, " ");
	    TextDrawAlignment(TakeDamage[i], 2);
	    TextDrawBackgroundColor(TakeDamage[i], 255);
	    TextDrawFont(TakeDamage[i], 2);
	    TextDrawLetterSize(TakeDamage[i], 0.160000, 0.599999);
	    TextDrawColor(TakeDamage[i], 0xE81010FF);
	    TextDrawSetOutline(TakeDamage[i], 1);
	    TextDrawSetProportional(TakeDamage[i], 1);
    }
    return 1;
}

public OnGameModeExit()
{
	return 1;
}

forward OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid);
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid)
{
    new s[20];
    format(s, 20, "+Damage %.0f", amount);
    TextDrawSetString(GiveDamage[playerid], s);
    TextDrawShowForPlayer(playerid, GiveDamage[playerid]);
    PlayerPlaySound(playerid,17802,0.0,0.0,0.0);
    SetTimerEx("DestruirTextoDraw", 1000, false, "i", playerid);
    return 1;
}

forward OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid);
public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
    new s[20];
    format(s, 20, "-Damage %.0f", amount);
    TextDrawSetString(TakeDamage[playerid], s);
    TextDrawShowForPlayer(playerid, TakeDamage[playerid]);
    SetTimerEx("DestruirTextoDraw", 1000, false, "i", playerid);
    return 1;
}

forward DestruirTextoDraw(playerid);
public DestruirTextoDraw(playerid)
{
    TextDrawHideForPlayer(playerid, GiveDamage[playerid]);
    TextDrawHideForPlayer(playerid, TakeDamage[playerid]);
    return 1;
}
