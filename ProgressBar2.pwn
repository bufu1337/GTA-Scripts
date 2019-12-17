/**
 *  Progress Bar 1.3.1.0
 *  Copyright 2007-2010 Infernus' Group,
 *  Flávio Toribio (flavio_toribio@hotmail.com)
 */

#if defined _progress_included
	#endinput
#endif

include <a_samp>



#define _progress_included
#define _progress_version	0x1310

#define MAX_BARS				(MAX_TEXT_DRAWS / 3)
#define INVALID_BAR_VALUE		(Float:0xFFFFFFFF)
#define INVALID_BAR_ID			(-1)
#define pb_percent(%1,%2,%3,%4)	((%1 - 6.0) + ((((%1 + 6.0 + %2 - 2.0) - %1) / %3) * %4))
//pb_percent(x, width, max, value)
forward CreateProgressBar(Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0);
forward Float:GetProgressBarValue(barid);
enum e_bar{
	Float:pb_x,
	Float:pb_y,
	Float:pb_w,
	Float:pb_h,
	Float:pb_m,
	Float:pb_v,
	pb_t1,
	pb_t2,
	pb_t3,
	pb_color,
	bool:pb_created
}
new Bars[MAX_BARS][e_bar];

//$ region ProgressBar
//Flávio Toribio
stock CreateProgressBar(Float:x, Float:y, Float:width=55.5, Float:height=3.2, color, Float:max=100.0){
	new	barid;
	for(barid = 0; barid < sizeof Bars; ++barid)
		if(!Bars[barid][pb_created]) break;

	if(Bars[barid][pb_created] || barid == sizeof Bars)
		return INVALID_BAR_ID;

	Bars[barid][pb_t1] = TextDrawStreamCreate(x, y, "_");
	TextDrawStreamUseBox		(Bars[barid][pb_t1], 1);
	TextDrawStreamTextSize	(Bars[barid][pb_t1], x + width, 0.0);
	TextDrawStreamLetterSize	(Bars[barid][pb_t1], 1.0, height / 10);
	TextDrawStreamBoxColor	(Bars[barid][pb_t1], 0x00000000 | (color & 0x000000FF));

	Bars[barid][pb_t2] = TextDrawStreamCreate(x + 1.2, y + 2.15, "_");
	TextDrawStreamUseBox		(Bars[barid][pb_t2], 1);
	TextDrawStreamTextSize	(Bars[barid][pb_t2], x + width - 2.0, 0.0);
	TextDrawStreamLetterSize	(Bars[barid][pb_t2], 1.0, height / 10 - 0.35);
	TextDrawStreamBoxColor	(Bars[barid][pb_t2], (color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));

	Bars[barid][pb_t3] = TextDrawStreamCreate(x + 1.2, y + 2.15, "_");
	TextDrawStreamTextSize	(Bars[barid][pb_t3], pb_percent(x, width, max, 1.0), 0.0);
	TextDrawStreamLetterSize	(Bars[barid][pb_t3], 1.0, height / 10 - 0.35);
	TextDrawStreamBoxColor	(Bars[barid][pb_t3], color);

	Bars[barid][pb_x] = x;
	Bars[barid][pb_y] = y;
	Bars[barid][pb_w] = width;
	Bars[barid][pb_h] = height;
	Bars[barid][pb_m] = max;
	Bars[barid][pb_color] = color;
	Bars[barid][pb_created] = true;
	return barid;
}
stock DestroyProgressBar(barid){
	if(barid != INVALID_BAR_ID && -1 < barid < MAX_BARS){
		if(!Bars[barid][pb_created])
			return 0;

		TextDrawStreamDestroy(Bars[barid][pb_t1]);
		TextDrawStreamDestroy(Bars[barid][pb_t2]);
		TextDrawStreamDestroy(Bars[barid][pb_t3]);

		Bars[barid][pb_t1] = -1;
		Bars[barid][pb_t2] = -1;
		Bars[barid][pb_t3] = -1;
		Bars[barid][pb_x] = 0.0;
		Bars[barid][pb_y] = 0.0;
		Bars[barid][pb_w] = 0.0;
		Bars[barid][pb_h] = 0.0;
		Bars[barid][pb_m] = 0.0;
		Bars[barid][pb_v] = 0.0;
		Bars[barid][pb_color] = 0;
		Bars[barid][pb_created] = false;
		return 1;
	}
	return 0;
}
stock ShowProgressBarForPlayer(playerid, barid){
	if(IsPlayerConnected(playerid) && barid != INVALID_BAR_ID && -1 < barid < MAX_BARS){
		if(!Bars[barid][pb_created])
			return 0;

		TextDrawStreamShowForPlayer(playerid, Bars[barid][pb_t1]);
		TextDrawStreamShowForPlayer(playerid, Bars[barid][pb_t2]);
		TextDrawStreamShowForPlayer(playerid, Bars[barid][pb_t3]);
		return 1;
	}
	return 0;
}
stock HideProgressBarForPlayer(playerid, barid){
	if(IsPlayerConnected(playerid) && barid != INVALID_BAR_ID && -1 < barid < MAX_BARS){
		if(!Bars[barid][pb_created])
			return 0;

		TextDrawStreamUnload(playerid, Bars[barid][pb_t1]);
		TextDrawStreamUnload(playerid, Bars[barid][pb_t2]);
		TextDrawStreamUnload(playerid, Bars[barid][pb_t3]);
		return 1;
	}
	return 0;
}
stock SetProgressBarValue(barid, Float:value){
	if(barid == INVALID_BAR_ID || MAX_BARS < barid < -1)
		return 0;
	if(Bars[barid][pb_created]){
		value =	(value < 0.0) ? (0.0) : (value > Bars[barid][pb_m]) ? (Bars[barid][pb_m]) : (value);
		TextDrawStreamUseBox(Bars[barid][pb_t3], value > 0.0);
        Bars[barid][pb_v] = value;
		TextDrawStreamTextSize(Bars[barid][pb_t3],pb_percent(Bars[barid][pb_x], Bars[barid][pb_w], Bars[barid][pb_m], value), 0.0);
		return 1;
	}
	return 0;
}
stock Float:GetProgressBarValue(barid){
	if(barid == INVALID_BAR_ID || MAX_BARS < barid < -1)
		return INVALID_BAR_VALUE;
	if(Bars[barid][pb_created])
		return Bars[barid][pb_v];
	return INVALID_BAR_VALUE;
}
stock SetProgressBarMaxValue(barid, Float:max){
	if(barid == INVALID_BAR_ID || MAX_BARS < barid < -1)
		return 0;
	if(Bars[barid][pb_created]){
		Bars[barid][pb_m] = max;
		SetProgressBarValue(barid, Bars[barid][pb_v]);
		return 1;
	}
	return 0;
}
stock SetProgressBarColor(barid, color){
	if(barid == INVALID_BAR_ID || MAX_BARS < barid < -1)
		return 0;
	if(Bars[barid][pb_created]){
		Bars[barid][pb_color] = color;
		TextDrawStreamBoxColor(Bars[barid][pb_t1], 0x00000000 | (color & 0x000000FF));
		TextDrawStreamBoxColor(Bars[barid][pb_t2],(color & 0xFFFFFF00) | (0x66 & ((color & 0x000000FF) / 2)));
		TextDrawStreamBoxColor(Bars[barid][pb_t3], color);
		return 1;
	}
	return 0;
}
stock ShowProgressBarForAll(barid){
	#if defined _foreach_included
	foreach(Player, i)
	#else
	for(new i = 0; i < MAX_PLAYERS; ++i)
		if(IsPlayerConnected(i))
	#endif
	#if defined IsPlayerNPC
		if(!IsPlayerNPC(i))
	#endif
	{
		ShowProgressBarForPlayer(i, barid);
	}
	return 1;
}
stock HideProgressBarForAll(barid){
	#if defined _foreach_included
	foreach(Player, i)
	#else
	for(new i = 0; i < MAX_PLAYERS; ++i)
		if(IsPlayerConnected(i))
	#endif
	#if defined IsPlayerNPC
		if(!IsPlayerNPC(i))
	#endif
	{
		HideProgressBarForPlayer(i, barid);
	}
	return 1;
}
stock UpdateProgressBar(barid, playerid=INVALID_PLAYER_ID){
	if(playerid == INVALID_PLAYER_ID){
		return ShowProgressBarForAll(barid);
	}
	else {
		return ShowProgressBarForPlayer(playerid, barid);
	}
}
//$ endregion ProgressBar
