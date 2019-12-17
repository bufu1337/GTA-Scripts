#include <a_samp>
#include <audio>

enum
	pLangInfo
	{
		Language[24],
		Path[8]
	}
;

new
	languages[][pLangInfo] =
	{
	    { "English", 				"en" },
	    { "Turkish", 				"tr" },
		{ "Croatian", 				"hr" },
		{ "African", 				"af" },
		{ "Albanian", 				"sq" },
		{ "Armenian", 				"hy" },
		{ "Azerbaijani", 			"az" },
		{ "Catalonian", 			"ca" },
		{ "Traditional Chinese", 	"zh-TW" },
		{ "Simplified Chinese", 	"zh-CN" },
		{ "Danish", 				"da" },
		{ "German", 				"de" },
		{ "Finnish", 				"fi" },
		{ "French", 				"fr" },
		{ "Greek", 					"el" },
		{ "Haitian Creole", 		"ht" },
		{ "Hindu", 					"hi" },
		{ "Hungarian", 				"hu" },
		{ "Icelandic", 				"is" },
		{ "Indonesian", 			"id" },
		{ "Italian", 				"it" },
		{ "Latvian", 				"lv" },
		{ "Macedonian", 			"mk" },
		{ "Dutch", 					"nl" },
		{ "Norwegian", 				"no" },
		{ "Polish", 				"pl" },
		{ "Portuguese", 			"pt" },
		{ "Romanesque", 			"ro" },
		{ "Russian", 				"ru" },
		{ "Serbian", 				"sr" },
		{ "Slovak", 				"sk" },
		{ "Spannish",				"es" },
		{ "Swahili", 				"sw" },
		{ "Czech", 					"cs" },
		{ "Vietnamese", 			"vi" },
		{ "Welsh", 					"cy" },
		{ "Swedisch", 				"sv" }
	},
	soundID[MAX_PLAYERS]
;

public OnPlayerText(playerid, text[])
{
	new
	    string[256],
	    Float: pPos[3][2]
	;
	GetPlayerPos(playerid, pPos[0][0], pPos[1][0], pPos[2][0]);
	format(string, sizeof(string), "http://translate.google.com/translate_tts?tl=%s&q=%s", languages[GetPVarInt(playerid, "pLanguage")][Path], text);
	
	for(new i; i != GetMaxPlayers(); i++)
	{
	    if(IsPlayerConnected(i) && !IsPlayerNPC(i))
	    {
	        if(IsPlayerInRangeOfPoint(i, 100.0, pPos[0][0], pPos[1][0], pPos[2][0]))
	        {
	            GetPlayerPos(i, pPos[0][1], pPos[1][1], pPos[2][1]);
        		soundID[i] = Audio_PlayStreamed(i, string);
        		Audio_SetVolume(i, soundID[i], 100 - floatround(floatsqroot(floatpower(floatabs(pPos[0][1] - pPos[0][0]), 2) + floatpower(floatabs(pPos[1][1] - pPos[1][0]), 2) + floatpower(floatabs(pPos[2][1] - pPos[2][0]), 2)), floatround_ceil));
	        }
	    }
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp(cmdtext, "/language", true))
	{
	    new
	        string[768]
		;
		for(new x; x != sizeof(languages); x++)
		{
			format(string, sizeof(string), "%s%s\n", string, languages[x][Language]);
		}
		ShowPlayerDialog(playerid, 500, DIALOG_STYLE_LIST, "Choose your language", string, "Choose", "Close");
	    return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
	    switch(dialogid)
	    {
	        case 500:
	        {
				switch(listitem)
				{
				    case 0..sizeof(languages):
				    {
				        new
				            string[128]
						;
						SetPVarInt(playerid, "pLanguage", listitem);
						format(string, sizeof(string), "[!] Speech language has been set to %s (ID: %d)", languages[GetPVarInt(playerid, "pLanguage")][Language], GetPVarInt(playerid, "pLanguage"));
						SendClientMessage(playerid, 0xFFFFFFF, string);
				    }
				}
	        }
	    }
	}
	return 1;
}
