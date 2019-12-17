/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
/*x---------------------------------Defining-------------------------------------x*/
//**VARIABLES**//
new Text:Text[100];
new gametextdrawforplayer;
new gametextdraw;
//**FORWARDS**//
forward GameTextRemoval(textid);
//**NATIVES**//
/*
native DisplayTextForPlayer(playerid, text[], time, font, style);
native DisplayTextForAll(text[], time, font, style);
*/
/*x---------------------------------CallBacks-------------------------------------x*/
stock DisplayTextForPlayer(playerid, text[], time, font, style) // Max Fonts: 3(0-3)   <->   Max Styles: 4(1-4)
{
	if (gametextdrawforplayer >= 99) gametextdrawforplayer = 0;
	gametextdrawforplayer++;
	new Float:TEXTX,Float:TEXTY;
    if (style == 1) TEXTX = 231, TEXTY = 61;
    else if (style == 2) TEXTX = 246, TEXTY = 142;
    else if (style == 3) TEXTX = 401, TEXTY = 376;
    else if (style == 4) TEXTX = 1, TEXTY = 373;
    else TEXTX = 246, TEXTY = 142;
    Text[gametextdrawforplayer] = TextDrawCreate(TEXTX,TEXTY,text);
	TextDrawAlignment(Text[gametextdrawforplayer],0);
	TextDrawBackgroundColor(Text[gametextdrawforplayer],0x000000ff);
	TextDrawFont(Text[gametextdrawforplayer],font);
	TextDrawLetterSize(Text[gametextdrawforplayer],0.500000,2.000000);
	TextDrawColor(Text[gametextdrawforplayer],0xffffffff);
	TextDrawSetOutline(Text[gametextdrawforplayer],1);
	TextDrawSetProportional(Text[gametextdrawforplayer],1);
	TextDrawSetShadow(Text[gametextdrawforplayer],1);
	TextDrawShowForPlayer(playerid,Text[gametextdrawforplayer]);
	SetTimerEx("GameTextRemoval",time*1000,false,"d",gametextdrawforplayer);
}

stock DisplayTextForAll(text[], time, font, style) // Max Fonts: 3(0-3)   <->   Max Styles: 4(1-4)
{
	if (gametextdraw >= 99) gametextdraw = 0;
	gametextdraw++;
	new Float:TEXTX,Float:TEXTY;
	if (style == 1) TEXTX = 231, TEXTY = 142;
    else if (style == 2) TEXTX = 246, TEXTY = 142;
    else if (style == 3) TEXTX = 401, TEXTY = 376;
    else if (style == 4) TEXTX = 1, TEXTY = 376;
    else TEXTX = 246, TEXTY = 142;
    Text[gametextdraw] = TextDrawCreate(TEXTX,TEXTY,text);
	TextDrawAlignment(Text[gametextdraw],0);
	TextDrawBackgroundColor(Text[gametextdraw],0x000000ff);
	TextDrawFont(Text[gametextdraw],font);
	TextDrawLetterSize(Text[gametextdraw],0.500000,2.000000);
	TextDrawColor(Text[gametextdraw],0xffffffff);
	TextDrawSetOutline(Text[gametextdraw],1);
	TextDrawSetProportional(Text[gametextdraw],1);
	TextDrawSetShadow(Text[gametextdraw],1);
	TextDrawShowForAll(Text[gametextdraw]);
	SetTimerEx("GameTextRemoval",time*1000,false,"d",gametextdraw);
}

public GameTextRemoval(textid)
{
	TextDrawDestroy(Text[textid]);
	return true;
}
