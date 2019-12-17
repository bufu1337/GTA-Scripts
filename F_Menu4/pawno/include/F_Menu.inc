#include <a_samp>
forward F_OnPlayerSelectedMenuRow(playerid, menuid, row);
forward F_OnPlayerExitedMenu(playerid, menuid);
forward F_PressKeyDetection();
forward F_HoldKey(playerid);
#define MAX_TEXTDRAW 10000
#define F_MAX_MENUS 50
#define F_MAX_MENU_ROWS 20
enum mInfo{
	Rows,
	bool:Shown[MAX_PLAYERS],
	bool:UsedMenu,
	SelectedRow[MAX_PLAYERS],
	menu_id,
	menu_row[F_MAX_MENU_ROWS],
	SelectedRowTextColor,
	SelectedRowBgColor,
	SelectedRowBoxColor,
	ItemTextColor,
	ItemBgColor,
	ItemBoxColor,
}
enum pInfo{
	//$ region F_menu
	  	bool:AKeyPressed,
		F_HoldKeyt,
	//$ endregion F_menu
}
enum tInfo{
	TAlign,
	BgColor,
	BColor,
	TColor,
	TFont,
	Float:TPos[2],
	Float:LSize[2],
	Float:TSize[2],
	TOutL,
	TProp,
	TShadow,
	TString[256],
	TBox,
	Text:DrawId;
	TCreated,
	TLoaded,
	TShown[MAX_PLAYERS],
}
new MenuInfo[F_MAX_MENUS][mInfo];
new TextInfo[MAX_TEXTDRAW][tInfo];
new PlayerInfo[MAX_PLAYERS][pInfo];
//$ region Textdraw-Streamer
stock TextDrawStreamPos(textdid,Float:x, Float:y){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TPos][0] = x;
		TextInfo[textdid][TPos][1] = y;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamTextSize(textdid, Float:x, Float:y){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TSize][0] = x;
		TextInfo[textdid][TSize][1] = y;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamLetterSize(textdid, Float:x, Float:y){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][LSize][0] = x;
		TextInfo[textdid][LSize][1] = y;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamSetOutline(textdid, size){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][OutL] = size;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;

}
stock TextDrawStreamSetProportional(textdid, set){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][Prop] = set;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;

}
stock TextDrawStreamSetShadow(textdid, size){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TShadow] = size;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;

}
stock TextDrawStreamSetString(textdid, string[]){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TString] = string;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamAlignment(textdid,align){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TAlign] = align;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamUseBox(textdid, use){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][Box] = use;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamFont(textdid, font){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TFont] = font;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamBackgroundColor(textdid,color){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][BgColor] = color;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamBoxColor(textdid,color){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][BColor] = color;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;

}
stock TextDrawStreamColor(textdid,color){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TColor] = color;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
stock TextDrawStreamCreate(Float:x, Float:y, Float:TdSizeX, Float:TdSizeY, Float:LeSizeX, Float:LeSizeY, String[], BackGColor, BoxColor, Color, font, outline, align, proportional, shadow, usebox){
	new i;
	while ( TextInfo[i][TCreated] == 1) {
		i++;
	}
	TextInfo[i][TPos][0] = x;
	TextInfo[i][TPos][1] = y;
	TextInfo[i][TSize][0] = TdSizeX;
	TextInfo[i][TSize][1] = TdSizeY;
	TextInfo[i][LSize][0] = LeSizeX;
	TextInfo[i][LSize][1] = LeSizeY;
	TextInfo[i][TString] = String;
	TextInfo[i][BgColor] = BackGColor;
	TextInfo[i][BColor] = BoxColor;
	TextInfo[i][TColor] = Color;
	TextInfo[i][TFont] = font;
	TextInfo[i][OutL] = outline;
	TextInfo[i][TAlign] = align;
	TextInfo[i][Prop] = proportional;
	TextInfo[i][Shadow] = shadow;
	TextInfo[i][Box] = usebox;
	TextInfo[i][TCreated] = 1;
	return i;
}
stock TextDrawStreamDestroy(textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		if ( TextInfo[textid][TLoaded] == 1 ){
			TextDrawStreamUnload(textdid);
		}
		TextInfo[textdid][TPos][0] = 0;
		TextInfo[textdid][TPos][1] = 0;
		TextInfo[textdid][TSize][0] = 0;
		TextInfo[textdid][TSize][1] = 0;
		TextInfo[textdid][LSize][0] = 0;
		TextInfo[textdid][LSize][1] = 0;
		format(TextInfo[textdid][TString],sizeof(TextInfo[textdid][TString]),"");
		TextInfo[textdid][BgColor] = 0;
		TextInfo[textdid][BColor] = 0;
		TextInfo[textdid][TColor] = 0;
		TextInfo[textdid][TFont] = 0;
		TextInfo[textdid][OutL] = 0;
		TextInfo[textdid][TAlign] = 0;
		TextInfo[textdid][Prop] = 0;
		TextInfo[textdid][Shadow] = 0;
		TextInfo[textdid][Box] = 0;
		TextInfo[textdid][TCreated] = 0;
		return 1;
	}
}
stock TextDrawStreamLoad(textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		if ( TextInfo[textdid][TLoaded] == 0 ){
			TextInfo[textdid][DrawId]=TextDrawCreate(TextInfo[textdid][TPos][0],TextInfo[textdid][TPos][1],TextInfo[textdid][TString]);
			TextDrawLetterSize(TextInfo[textdid][DrawId],TextInfo[textdid][LSize][0],TextInfo[textdid][LSize][1]);
			TextDrawTextSize(TextInfo[textdid][DrawId],TextInfo[textdid][TSize][0],TextInfo[textdid][TSize][1]);
			TextDrawBackgroundColor (TextInfo[textdid][DrawId],TextInfo[textdid][BgColor]);
			TextDrawBoxColor(TextInfo[textdid][DrawId],TextInfo[textdid][BColor]);
			TextDrawColor(TextInfo[textdid][DrawId],TextInfo[textdid][TColor]);
			TextDrawFont(TextInfo[textdid][DrawId],TextInfo[textdid][TFont]);
			TextDrawAlignment(TextInfo[textdid][DrawId],TextInfo[textdid][TAlign]);
			TextDrawSetOutline(TextInfo[textdid][DrawId],TextInfo[textdid][TOutL]);
			TextDrawSetProportional(TextInfo[textdid][DrawId],TextInfo[textdid][TProp]);
			TextDrawSetShadow(TextInfo[textdid][DrawId],TextInfo[textdid][TShadow]);
			TextDrawUseBox(TextInfo[textdid][DrawId],TextInfo[textdid][TBox]);
			TextInfo[textdid][TLoaded] = 1;
			return 1;
		}
	}
	return 0;
}
stock TextDrawStreamUnload(textdid){
	if ( TextInfo[textdid][TCreated] == 1 && TextInfo[textdid][TLoaded] == 1 ){
		TextDrawStreamHideForAll(textdid);
		TextDrawDestroy(TextInfo[textdid][DrawId]);
		TextInfo[textdid][TLoaded] = 0;
		return 1;
	}
	return 0;
}
stock TextDrawStreamReload(textdid){
	if ( TextInfo[textdid][TCreated] == 1 && TextInfo[textdid][TLoaded] == 1){
		new j[MAX_PLAYERS];
		for (new h = 0; h < ; h++){
			j[h] = TextInfo[textdid][TShown][h];
		}
		TextDrawStreamUnload(textdid);
		for (new i = 0; i < MAX_PLAYERS; i++){
			if ( j[i] == 1){
				TextDrawStreamShowForPlayer(i, textdid);
			}
		}
		return 1;
	}
	return 0;
}
stock TextDrawStreamShowForAll(textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		if ( TextInfo[textdid][TLoaded] == 0 ){
			TextDrawStreamLoad(textdid);
		}
		TextDrawShowForAll(TextInfo[textdid][DrawId]);
		for (new i = 0; i < MAX_PLAYERS; i++){
			TextInfo[textdid][TShown][i] = 1;
		}
		return 1;
	}
	return 0;
}
stock TextDrawStreamHideForAll(textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		for (new i = 0; i < MAX_PLAYERS; i++){
			if ( TextInfo[textdid][TShown][i] == 1){
				TextInfo[textdid][TShown][i] = 0;
			}
		}
		TextDrawHideForAll(TextInfo[textdid][DrawId]);
		return 1;
	}
	return 0;
}
stock TextDrawStreamShowForPlayer(playerid, textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		if ( TextInfo[textdid][TLoaded] == 0 ){
			TextDrawStreamLoad(textdid);
		}
		if ( TextInfo[textdid][TShown][playerid] == 0){
			TextInfo[textdid][TShown][playerid] = 1;
			TextDrawShowForPlayer(playerid, TextInfo[textdid][DrawId]);
		}
		return 1;
	}
	return 0;
}
stock TextDrawStreamHideForPlayer(playerid, textdid){
	if ( TextInfo[textdid][TCreated] == 1 ){
		if ( TextInfo[textdid][TShown][playerid] == 1){
			TextInfo[textdid][TShown][playerid] = 0;
			TextDrawHideForPlayer(playerid, TextInfo[textdid][DrawId]);
		}
		return 1;
	}
	return 0;
}
stock TextDrawStreamSet(textdid, Float:x, Float:y, Float:TdSizeX, Float:TdSizeY, Float:LeSizeX, Float:LeSizeY, String[], BackGColor, BoxColor, Color, font, outline, align, proportional, shadow, usebox){
	if ( TextInfo[textdid][TCreated] == 1 ){
		TextInfo[textdid][TPos][0] = x;
		TextInfo[textdid][TPos][1] = y;
		TextInfo[textdid][TSize][0] = TdSizeX;
		TextInfo[textdid][TSize][1] = TdSizeY;
		TextInfo[textdid][LSize][0] = LeSizeX;
		TextInfo[textdid][LSize][1] = LeSizeY;
		TextInfo[textdid][TString] = String;
		TextInfo[textdid][BgColor] = BackGColor;
		TextInfo[textdid][BColor] = BoxColor;
		TextInfo[textdid][TColor] = Color;
		TextInfo[textdid][TFont] = font;
		TextInfo[textdid][OutL] = outline;
		TextInfo[textdid][TAlign] = align;
		TextInfo[textdid][Prop] = proportional;
		TextInfo[textdid][Shadow] = shadow;
		TextInfo[textdid][Box] = usebox;
		TextDrawStreamReload(textdid);
		return 1;
	}
	return 0;
}
//$ endregion Textdraw-Streamer
//$ region MenuCreator
stock F_CreateMenu(title[], Float:x, Float:y, Float:boxlength){
	new id;
	while(MenuInfo[id][UsedMenu] == true) id++;
	MenuInfo[id][menu_id] = TextDrawStreamCreate(x, y, boxlength, 0.000000, 0.399999, 1.100000, title, 0x000000ff, 0x000000CC, 0xffffffff, 0, 1, 0, 1, 1, 1);
    MenuInfo[id][Rows] = 0;
    MenuInfo[id][SelectedRowTextColor] = 0xffffffff;
    MenuInfo[id][SelectedRowBgColor] = 0x000000ff;
    MenuInfo[id][SelectedRowBoxColor] = 0xffffff99;
	MenuInfo[id][ItemTextColor] = 0xffffffff;
	MenuInfo[id][ItemBgColor] = 0x000000ff;
	MenuInfo[id][ItemBoxColor] = 0x00000099;
    for(new i=0; i<MAX_PLAYERS; i++){
    	MenuInfo[id][Shown][i] = false;
    }
    MenuInfo[id][UsedMenu] = true;
    return id;
}
stock F_LoadMenu(menuid){
	TextDrawStreamLoad(MenuInfo[menuid][menu_id]);
	for (new i = 0; i < MenuInfo[menuid][Rows]; i++){
		TextDrawStreamLoad(MenuInfo[menuid][menu_row][i]);
	}
	return 1;
}
stock F_UnloadMenu(menuid){
	TextDrawStreamUnload(MenuInfo[menuid][menu_id]);
	for (new i = 0; i < MenuInfo[menuid][Rows]; i++){
		TextDrawStreamUnload(MenuInfo[menuid][menu_row][i]);
	}
	for(new i=0; i<MAX_PLAYERS; i++){
		if(MenuInfo[menuid][Shown][i] == true){
			MenuInfo[menuid][Shown][i] = false;
		}
	}
	return 1;
}
stock F_AddMenuItem(menuid, title[]){
	if(MenuInfo[menuid][UsedMenu] == true && MenuInfo[menuid][Rows] < F_MAX_MENU_ROWS){
		MenuInfo[menuid][menu_row][MenuInfo[menuid][Rows]] = TextDrawStreamCreate(TextInfo[MenuInfo[menuid][menu_id]][TPos][0], floatadd(TextInfo[MenuInfo[menuid][menu_id]][TPos][1], floatmul(MenuInfo[menuid][Rows]+1, 13.4)), TextInfo[MenuInfo[menuid][menu_id]][TSize][0], 0.0, 0.299999, 1.100000, title, MenuInfo[menuid][ItemBgColor], MenuInfo[menuid][ItemBoxColor], MenuInfo[menuid][ItemTextColor], 1, 1, 0, 1, 1, 1);
    	MenuInfo[menuid][Rows] ++;
    	return MenuInfo[menuid][Rows] -1;
	}
	return 0;
}
stock F_SetMenuTitleTextColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
		TextDrawStreamColor(MenuInfo[menuid][menu_id], color);
		return 1;
	}
	return 0;
}
stock F_SetMenuTitleBgColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
		TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_id], color);
		return 1;
	}
	return 0;
}
stock F_SetMenuTitleBoxColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
		TextDrawStreamBoxColor(MenuInfo[menuid][menu_id], color);
		return 1;
	}
	return 0;
}
stock F_SetMenuItemTextColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
	    for(new i=0; i<F_MAX_MENU_ROWS; i++){
		    if(i < MenuInfo[menuid][Rows]){
				TextDrawStreamColor(MenuInfo[menuid][menu_row][i], color);
				MenuInfo[menuid][ItemTextColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}
stock F_SetMenuItemBgColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
	    for(new i=0; i<F_MAX_MENU_ROWS; i++){
		    if(i < MenuInfo[menuid][Rows]){
				TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][i], color);
				MenuInfo[menuid][ItemBgColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}
stock F_SetMenuItemBoxColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
	    for(new i=0; i<F_MAX_MENU_ROWS; i++){
		    if(i < MenuInfo[menuid][Rows]){
				TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][i], color);
				MenuInfo[menuid][ItemBoxColor] = color;
		    }
		}
		return 1;
	}
	return 0;
}
stock F_SetMenuSelectedItemTextColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
        MenuInfo[menuid][SelectedRowTextColor] = color;
		return 1;
	}
	return 0;
}
stock F_SetMenuSelectedItemBgColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
        MenuInfo[menuid][SelectedRowBgColor] = color;
		return 1;
	}
	return 0;
}
stock F_SetMenuSelectedItemBoxColor(menuid, color){
    if(MenuInfo[menuid][UsedMenu] == true){
        MenuInfo[menuid][SelectedRowBoxColor] = color;
		return 1;
	}
	return 0;
}
stock F_DestroyMenu(menuid){
	if(MenuInfo[menuid][UsedMenu] == true){
		TextDrawStreamDestroy(MenuInfo[menuid][menu_id]);
		for (new h = 0; h < MenuInfo[menuid][Rows]; h++){
			TextDrawStreamDestroy(MenuInfo[menuid][menu_row][h]);
		}
	    for(new i=0; i<MAX_PLAYERS; i++){
			if(MenuInfo[menuid][Shown][i] == true){
			    MenuInfo[menuid][Shown][i] = false;
			}
		}
		MenuInfo[menuid][UsedMenu] = false;
    	return 1;
	}
	return 0;
}
stock F_ShowMenuForPlayer(menuid, playerid){
	if(IsPlayerConnected(playerid)){
		for(new m=0; m<F_MAX_MENUS; m++){
			F_HideMenuForPlayer(m, playerid);
		}
		if(MenuInfo[menuid][Shown][playerid] == false && MenuInfo[menuid][UsedMenu] == true){
		    TextDrawStreamShowForPlayer(playerid, MenuInfo[menuid][menu_id]);
			TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowBoxColor]);
			TextDrawStreamColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowTextColor]);
			TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][0], MenuInfo[menuid][SelectedRowBgColor]);
			for(new i=0; i<F_MAX_MENU_ROWS; i++){
			    if(i < MenuInfo[menuid][Rows]){
					if(i != 0){
						TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemBoxColor]);
						TextDrawStreamColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemTextColor]);
						TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][i], MenuInfo[menuid][ItemBgColor]);
					}
					TextDrawStreamShowForPlayer(playerid, Text:MenuInfo[menuid][menu_row][i]);
			    }
			}
		    MenuInfo[menuid][Shown][playerid] = true;
		    MenuInfo[menuid][SelectedRow][playerid] = 0;
	    	return 1;
		}
	}
	return 0;
}
stock F_ShowMenuForAll(menuid){
	for(new all=0; all<MAX_PLAYERS; all++){
	    F_ShowMenuForPlayer(menuid, all);
	}
}
stock F_HideMenuForPlayer(menuid, playerid){
	if(IsPlayerConnected(playerid)){
		if(MenuInfo[m][Shown][playerid] == true){
			TextDrawStreamHideForPlayer(playerid, MenuInfo[m][menu_id]);
			for(new i=0; i<F_MAX_MENU_ROWS; i++){
				if(i < MenuInfo[m][Rows]){
					TextDrawStreamHideForPlayer(playerid, MenuInfo[m][menu_row][i]);
				}
			}
			MenuInfo[m][Shown][playerid] = false;
		}
	}
	return 0;
}
stock F_HideMenuForAll(menuid, playerid){
	for(new all=0; all<MAX_PLAYERS; all++){
	    F_HideMenuForPlayer(menuid, playerid)
	}
}
stock F_SelectMenuRow(playerid, updown){
	if(IsPlayerConnected(playerid)){
		for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
			if(MenuInfo[menuid][Shown][i] == true){
				TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemTextColor]);
				TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBgColor]);
				TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][ItemBoxColor]);
				switch (updown){
					case 0:{
						if(MenuInfo[menuid][SelectedRow][i] > 0){
							MenuInfo[menuid][SelectedRow][i] --;
						}
						else{
							MenuInfo[menuid][SelectedRow][i] = MenuInfo[menuid][Rows]-1;
						}
						PlayerPlaySound(i, 1053, 0.0, 0.0, 0.0);
					}
					case 1:{
						if(MenuInfo[menuid][SelectedRow][i] < MenuInfo[menuid][Rows]-1){
							MenuInfo[menuid][SelectedRow][i] ++;
						}
						else{
							MenuInfo[menuid][SelectedRow][i] = 0;
						}
						PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
					}
				}
				MenuInfo[menuid][SelectedRow][playerid] = row;
				TextDrawStreamColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowTextColor]);
				TextDrawStreamBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBgColor]);
				TextDrawStreamBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][playerid]], MenuInfo[menuid][SelectedRowBoxColor]);
				return 1;
			}
		}
	}
	return 0;
}
public F_PressKeyDetection(){
    new keys, updown, leftright;
    for(new i=0; i<MAX_PLAYERS; i++){
        if(IsPlayerConnected(i)){
            GetPlayerKeys(i, keys, updown, leftright);
            new bool:Pressed;
            if(updown == KEY_UP){
                Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
        			PlayerInfo[i][F_HoldKeyt] = SetTimerEx("F_HoldKey", 800, 0, "i", i);
					F_SelectMenuRow(i, 0);
				}
            }
            if(updown == KEY_DOWN){
                Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
        			PlayerInfo[i][F_HoldKeyt] = SetTimerEx("F_HoldKey", 800, 0, "i", i);
					F_SelectMenuRow(i, 1);
				}
            }
			if(keys == KEY_LEFT){
                Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][i] == true){
			 		 		CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i], 1);
							PlayerPlaySound(i, 1053, 0.0, 0.0, 0.0);
						}
					}
				}
            }
			if(keys == KEY_RIGHT){
                Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][i] == true){
			 		 		CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i], 2);
							PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
						}
					}
				}
            }
            if(keys == KEY_SPRINT){
                Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][i] == true){
							TextDrawColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemTextColor]);
							TextDrawBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBgColor]);
							TextDrawBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBoxColor]);
			        		F_HideMenuForPlayer(menuid, i);
			 		 		CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i], 0);
							PlayerPlaySound(i, 1083, 0.0, 0.0, 0.0);
							return 1;
						}
					}
				}
            }
            if(keys == KEY_SECONDARY_ATTACK){
				Pressed = true;
                if(PlayerInfo[i][AKeyPressed] == false){
	                PlayerInfo[i][AKeyPressed] = true;
					for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
						if(MenuInfo[menuid][Shown][i] == true){
							TextDrawColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemTextColor]);
							TextDrawBackgroundColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBgColor]);
							TextDrawBoxColor(MenuInfo[menuid][menu_row][MenuInfo[menuid][SelectedRow][i]], MenuInfo[menuid][ItemBoxColor]);
			        		F_HideMenuForPlayer(menuid, i);
			        		CallRemoteFunction("F_OnPlayerExitedMenu", "ii", i, menuid);
							PlayerPlaySound(i, 1084, 0.0, 0.0, 0.0);
						}
					}
				}
            }
            if(Pressed == false){
                PlayerInfo[i][AKeyPressed] = false;
                KillTimer(PlayerInfo[i][F_HoldKeyt]);
            }
        }
    }
    return 1;
}
public F_HoldKey(playerid){
	if(IsPlayerConnected(playerid)){
	    new keys, updown, leftright;
	    GetPlayerKeys(playerid, keys, updown, leftright);
	    new bool:Pressed;
	    if(updown == KEY_UP){
	        Pressed = true;
			F_SelectMenuRow(playerid, 0);
	    }
	    if(updown == KEY_DOWN){
	        Pressed = true;
			F_SelectMenuRow(playerid, 1);
	    }
		if(keys == KEY_LEFT){
			Pressed = true;
			for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
				if(MenuInfo[menuid][Shown][i] == true){
					CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i], 1);
					PlayerPlaySound(i, 1053, 0.0, 0.0, 0.0);
				}
			}
		}
		if(keys == KEY_RIGHT){
			Pressed = true;
			for(new menuid=0; menuid<F_MAX_MENUS; menuid++){
				if(MenuInfo[menuid][Shown][i] == true){
					CallRemoteFunction("F_OnPlayerSelectedMenuRow", "iii", i, menuid, MenuInfo[menuid][SelectedRow][i], 2);
					PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
				}
			}
		}
	    if(Pressed == true){
	        SetTimerEx("F_HoldKey", 200, 0, "i", playerid);
		}
    	return 1;
	}
    return 0;
}
//$ endregion MenuCreator
stock F_Menu_OnInit(){
	SetTimer("F_PressKeyDetection", 200, 1);
	return 1;
}
F_OnPlayerSelectedMenuRow(playerid, menuid, row, leftright){
	// leftright = 0 == Sprinttaste
	// leftright = 1 == Links
	// leftright = 2 == Rechts
	return 1;
}
F_OnPlayerExitedMenu(playerid, menuid){

	return 1;
}