// See Copyright Notice in core\LICENSE.txt
#define MAX_TEXT_DRAWS							(1024)
#define INVALID_TEXT_DRAW						(0xFFFF)

new Text:TEXTDRAW_item[MAX_TEXT_DRAWS];
new TEXTDRAW_max_id=-1;
new TEXTDRAW_visible_for[MAX_TEXT_DRAWS][MAX_PLAYERS];
new TEXTDRAW_used[MAX_TEXT_DRAWS];

native Text:SAMP_TextDrawCreate(Float:x, Float:y, text[])=TextDrawCreate;
stock Text:TextDrawCreate(Float:x, Float:y, text[]) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (!TEXTDRAW_used[t]) {
			TEXTDRAW_used[t]=1;
			if (strlen(text)!=0) {
				TEXTDRAW_item[t]=SAMP_TextDrawCreate(x,y,text);
			} else {
				TEXTDRAW_item[t]=SAMP_TextDrawCreate(x,y," ");
			}
			if (t>=TEXTDRAW_max_id) TEXTDRAW_max_id++;
			return TEXTDRAW_item[t];
		}
	}
	// if we are here, we need to increase the max_id by one and use it.
	TEXTDRAW_max_id++;
	TEXTDRAW_used[TEXTDRAW_max_id]=1;
	if (strlen(text)!=0) {
		TEXTDRAW_item[TEXTDRAW_max_id]=SAMP_TextDrawCreate(x,y,text);
	} else {
		TEXTDRAW_item[TEXTDRAW_max_id]=SAMP_TextDrawCreate(x,y," ");
	}
	return TEXTDRAW_item[TEXTDRAW_max_id];
}

native SAMP_TextDrawDestroy(Text:text)=TextDrawDestroy;
stock TextDrawDestroy(Text:text) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			SAMP_TextDrawDestroy(TEXTDRAW_item[t]);
			TEXTDRAW_used[t]=0;
			for (new p;p<MAX_PLAYERS;p++) {
				TEXTDRAW_visible_for[t][p]=0;
			}
			return 1;
		}
	}
	return 0;
}

native TextDrawLetterSize(Text:text, Float:x, Float:y);
native TextDrawTextSize(Text:text, Float:x, Float:y);
native TextDrawAlignment(Text:text, alignment);
native TextDrawColor(Text:text, color);
native TextDrawUseBox(Text:text, use);
native TextDrawBoxColor(Text:text, color);
native TextDrawSetShadow(Text:text, size);
native TextDrawSetOutline(Text:text, size);
native TextDrawBackgroundColor(Text:text, color);
native TextDrawFont(Text:text, font);
native TextDrawSetProportional(Text:text, set);

native SAMP_TextDrawShowForPlayer(playerid, Text:text)=TextDrawShowForPlayer;
stock TextDrawShowForPlayer(playerid, Text:text) {
	if (!IsPlayerConnected(playerid)) return 0;
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			if (!TEXTDRAW_visible_for[t][playerid]) {
				SAMP_TextDrawShowForPlayer(playerid,TEXTDRAW_item[t]);
				TEXTDRAW_visible_for[t][playerid]=1;
				return 1;
			}
			return 0;
		}
	}
	return 0;
}

native SAMP_TextDrawHideForPlayer(playerid, Text:text)=TextDrawHideForPlayer;
stock TextDrawHideForPlayer(playerid, Text:text) {
	if (!IsPlayerConnected(playerid)) return 0;
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			if (TEXTDRAW_visible_for[t][playerid]) {
				SAMP_TextDrawHideForPlayer(playerid,TEXTDRAW_item[t]);
				TEXTDRAW_visible_for[t][playerid]=0;
				return 1;
			}
			return 0;
		}
	}
	return 0;
}

native SAMP_TextDrawShowForAll(Text:text)=TextDrawShowForAll;
stock TextDrawShowForAll(Text:text) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			for (new p;p<MAX_PLAYERS;p++) if (IsPlayerConnected(p) && !TEXTDRAW_visible_for[t][p]) {
				SAMP_TextDrawShowForPlayer(p,TEXTDRAW_item[t]);
				TEXTDRAW_visible_for[t][p]=1;
			}
			return 1;
		}
	}
	return 0;
}

native SAMP_TextDrawHideForAll(Text:text)=TextDrawHideForAll;
stock TextDrawHideForAll(Text:text) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			for (new p;p<MAX_PLAYERS;p++) if (TEXTDRAW_visible_for[t][p]) {
				SAMP_TextDrawHideForPlayer(p,TEXTDRAW_item[t]);
				TEXTDRAW_visible_for[t][p]=0;
			}
			return 1;
		}
	}
	return 0;
}

native SAMP_TextDrawSetString(Text:text, string[])=TextDrawSetString;
stock TextDrawSetString(Text:text, string[]) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			if (strlen(string)==0) {
				SAMP_TextDrawSetString(TEXTDRAW_item[t]," ");
			} else {
				SAMP_TextDrawSetString(TEXTDRAW_item[t],string);
			}
			return 1;
		}
	}
	return 0;
}

stock IsTextDrawVisibleToPlayer(Text:text,playerid) {
	if (TEXTDRAW_max_id>-1) {
		for (new t;t<TEXTDRAW_max_id+1;t++) if (TEXTDRAW_used[t] && (TEXTDRAW_item[t]==text)) {
			return TEXTDRAW_visible_for[t][playerid];
		}
	}
	return 0;
}

textdraw_Connect(playerid) {
	for (new t;t<TEXTDRAW_max_id+1;t++) TEXTDRAW_visible_for[t][playerid]=0;
}

textdraw_Disconnect(playerid,reason) {
#pragma unused reason
	for (new t;t<TEXTDRAW_max_id+1;t++) TEXTDRAW_visible_for[t][playerid]=0;
}