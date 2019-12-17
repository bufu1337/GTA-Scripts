#include <a_samp>
#define FILTERSCRIPT
#define ColoredTextKey '*'

#define MESSAGE_COLOR 0xEEEEEEFF
#define COLOR_AQUA 0x00FFFFFF

public OnFilterScriptInit()
{
	print("K's Colored Chat FilterScript Successfully Loaded");
	return 1;
}

public OnFilterScriptExit()
{
    print("K's Colored Chat FilterScript Successfully Unloaded");
	return 1;
}

enum ColorEnum
{
        ColorName[16],
        ColorID[7]
};

new String[200];
new ColorsTag[][ColorEnum] =
{
        {"Green",  "00FF00"},
        {"Red",    "FF0000"},
        {"White",  "FFFFFF"},
        {"Blue",   "0000FF"},
        {"Yellow", "FFFB00"},
        {"Orange", "FFA600"},
        {"Grey",   "B8B8B8"},
        {"Purple", "7340DB"},
        {"Pink",   "FF00EE"},
	{"Cyan",   "00FFFF"},
	{"Black",  "000000"},
	{"Brown",  "800000"},
	{"Lime",   "00FF00"}
};

stock ColouredText(text[])
{
    new tString[16], I = -1;
    strmid(String, text, 0, 128, sizeof(String));
    for(new C = 0; C != sizeof(ColorsTag); C ++)
    {
        format(tString, sizeof(tString), "<%s>", ColorsTag[C][ColorName]);
        while((I = strfind(String, tString, true, (I + 1))) != -1)
        {
            new tLen = strlen(tString);
            format(tString, sizeof(tString), "{%s}", ColorsTag[C][ColorID]);
            if(tLen < 8) for(new C2 = 0; C2 != (8 - tLen); C2 ++) strins(String, " ", I);
            for(new tVar; ((String[I] != 0) && (tVar != 8)); I ++, tVar ++) String[I] = tString[tVar];
            if(tLen > 8) strdel(String, I, (I + (tLen - 8)));
        }
    }
    return String;
}

stock GetName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof(Name));
	return Name;
}

public OnPlayerText(playerid, text[])
{
    new ChatBubble[MAX_CHATBUBBLE_LENGTH+1]; //Chatbubble function credits goes to gl_chatbubble <3..

    if(text[0] == ColoredTextKey)
    {
        new cText[128];
        format(cText, sizeof(cText), "*[VIP] %s(%d): %s", GetName(playerid), playerid, ColouredText(text[1]), playerid);
        format(ChatBubble,MAX_CHATBUBBLE_LENGTH,"%s",  ColouredText(text[1]));
        SetPlayerChatBubble(playerid, ChatBubble, MESSAGE_COLOR,35.0,10000);
        SendClientMessageToAll(COLOR_AQUA, cText);
        return 0;
    }
    return 0;
}