#include <a_samp>
#define AllowDoubleLines
new playerColors[100] ={
	0xFF8C13FF,0xC715FFFF,0x20B2AAFF,0xDC143CFF,0x6495EDFF,0xf0e68cFF,0x778899FF,0xFF1493FF,0xF4A460FF,0xEE82EEFF,0xFFD720FF,
	0x8b4513FF,0x4949A0FF,0x148b8bFF,0x14ff7fFF,0x556b2fFF,0x0FD9FAFF,0x10DC29FF,0x534081FF,0x0495CDFF,0xEF6CE8FF,0xBD34DAFF,
	0x247C1BFF,0x0C8E5DFF,0x635B03FF,0xCB7ED3FF,0x65ADEBFF,0x5C1ACCFF,0xF2F853FF,0x11F891FF,0x7B39AAFF,0x53EB10FF,0x54137DFF,
	0x275222FF,0xF09F5BFF,0x3D0A4FFF,0x22F767FF,0xD63034FF,0x9A6980FF,0xDFB935FF,0x3793FAFF,0x90239DFF,0xE9AB2FFF,0xAF2FF3FF,
	0x057F94FF,0xB98519FF,0x388EEAFF,0x028151FF,0xA55043FF,0x0DE018FF,0x93AB1CFF,0x95BAF0FF,0x369976FF,0x18F71FFF,0x4B8987FF,
	0x491B9EFF,0x829DC7FF,0xBCE635FF,0xCEA6DFFF,0x20D4ADFF,0x2D74FDFF,0x3C1C0DFF,0x12D6D4FF,0x48C000FF,0x2A51E2FF,0xE3AC12FF,
	0xFC42A8FF,0x2FC827FF,0x1A30BFFF,0xB740C2FF,0x42ACF5FF,0x2FD9DEFF,0xFAFB71FF,0x05D1CDFF,0xC471BDFF,0x94436EFF,0xC1F7ECFF,
	0xCE79EEFF,0xBD1EF2FF,0x93B7E4FF,0x3214AAFF,0x184D3BFF,0xAE4B99FF,0x7E49D7FF,0x4C436EFF,0xFA24CCFF,0xCE76BEFF,0xA04E0AFF,
	0x9F945CFF,0xDCDE3DFF,0x10C9C5FF,0x70524DFF,0x0BE472FF,0x8A2CD7FF,0x6152C2FF,0xCF72A9FF,0xE59338FF,0xEEDC2DFF,0xD8C762FF,
	0x3FE65CFF
};
#if defined AllowDoubleLines
new Text:Message[15];
new MessageStr[15][128];
new MessageColor[15] = 0xFFFFFFFF;
#else
new Text:Message[30];
new MessageStr[30][128];
new MessageColor[30] = 0xFFFFFFFF;
#endif
public OnFilterScriptInit(){
	#if defined AllowDoubleLines
    for(new line; line<15; line++)
	{
    	format(MessageStr[line], 128, " ");
	}
    Message[0] = TextDrawCreate(450, 210, MessageStr[0]);
    Message[1] = TextDrawCreate(450, 225, MessageStr[1]);
    Message[2] = TextDrawCreate(450, 240, MessageStr[2]);
    Message[3] = TextDrawCreate(450, 255, MessageStr[3]);
    Message[4] = TextDrawCreate(450, 270, MessageStr[4]);
    Message[5] = TextDrawCreate(450, 285, MessageStr[5]);
    Message[6] = TextDrawCreate(450, 300, MessageStr[6]);
    Message[7] = TextDrawCreate(450, 315, MessageStr[7]);
    Message[8] = TextDrawCreate(450, 330, MessageStr[8]);
    Message[9] = TextDrawCreate(450, 345, MessageStr[9]);
    Message[10] = TextDrawCreate(450, 360, MessageStr[10]);
    Message[11] = TextDrawCreate(450, 375, MessageStr[11]);
    Message[12] = TextDrawCreate(450, 390, MessageStr[12]);
    Message[13] = TextDrawCreate(450, 405, MessageStr[13]);
    Message[14] = TextDrawCreate(450, 420, MessageStr[14]);
    for(new line; line<15; line++)
	{
    	TextDrawLetterSize(Message[line], 0.20, 0.70);
    	TextDrawSetShadow(Message[line], 0);
		TextDrawAlignment(Message[line], 1);
    	TextDrawFont(Message[line], 1);
    	TextDrawShowForAll(Message[line]);
	}
	#else
    for(new line; line<30; line++)
	{
    	format(MessageStr[line], 128, " ");
	}
    Message[0] = TextDrawCreate(450, 210, MessageStr[0]);
    Message[1] = TextDrawCreate(450, 217, MessageStr[1]);
    Message[2] = TextDrawCreate(450, 224, MessageStr[2]);
    Message[3] = TextDrawCreate(450, 231, MessageStr[3]);
    Message[4] = TextDrawCreate(450, 238, MessageStr[4]);
    Message[5] = TextDrawCreate(450, 245, MessageStr[5]);
    Message[6] = TextDrawCreate(450, 252, MessageStr[6]);
    Message[7] = TextDrawCreate(450, 259, MessageStr[7]);
    Message[8] = TextDrawCreate(450, 266, MessageStr[8]);
    Message[9] = TextDrawCreate(450, 273, MessageStr[9]);
    Message[10] = TextDrawCreate(450, 280, MessageStr[10]);
    Message[11] = TextDrawCreate(450, 287, MessageStr[11]);
    Message[12] = TextDrawCreate(450, 294, MessageStr[12]);
    Message[13] = TextDrawCreate(450, 301, MessageStr[13]);
    Message[14] = TextDrawCreate(450, 308, MessageStr[14]);
    Message[15] = TextDrawCreate(450, 315, MessageStr[15]);
    Message[16] = TextDrawCreate(450, 322, MessageStr[16]);
    Message[17] = TextDrawCreate(450, 329, MessageStr[17]);
    Message[18] = TextDrawCreate(450, 336, MessageStr[18]);
    Message[19] = TextDrawCreate(450, 343, MessageStr[19]);
    Message[20] = TextDrawCreate(450, 350, MessageStr[20]);
    Message[21] = TextDrawCreate(450, 357, MessageStr[21]);
    Message[22] = TextDrawCreate(450, 364, MessageStr[22]);
    Message[23] = TextDrawCreate(450, 371, MessageStr[23]);
    Message[24] = TextDrawCreate(450, 378, MessageStr[24]);
    Message[25] = TextDrawCreate(450, 385, MessageStr[25]);
    Message[26] = TextDrawCreate(450, 392, MessageStr[26]);
    Message[27] = TextDrawCreate(450, 399, MessageStr[27]);
    Message[28] = TextDrawCreate(450, 406, MessageStr[28]);
    Message[29] = TextDrawCreate(450, 413, MessageStr[29]);
    for(new line; line<30; line++)
	{
    	TextDrawLetterSize(Message[line], 0.20, 0.70);
    	TextDrawSetShadow(Message[line], 0);
		TextDrawAlignment(Message[line], 1);
    	TextDrawFont(Message[line], 1);
    	TextDrawSetOutline(Message[line], 1);
    	TextDrawShowForAll(Message[line]);
	}
	#endif
    //TextDrawShowForAll(Box);
    for(new line; line<15; line++)	{
    	TextDrawLetterSize(Message[line], 0.20, 0.70);
    	TextDrawSetShadow(Message[line], 0);
		TextDrawAlignment(Message[line], 1);
    	TextDrawTextSize(Message[line], 640, 480);
    	TextDrawBoxColor(Message[line], 0x000000FF);
    	//TextDrawUseBox(Message[line], 1);
    	TextDrawFont(Message[line], 1);
    	TextDrawSetOutline(Message[line], 1);
    	TextDrawShowForAll(Message[line]);
	}
	print("--------------------------------------");
	print(" Second Chatbox created by =>Sandra<= ");
	print("          Loaded succesfully          ");
	print("--------------------------------------");
	return 1;
}
public OnFilterScriptExit(){
	#if defined AllowDoubleLines
    for(new line; line<15; line++){
	    TextDrawDestroy(Message[line]);
	}
	#else
	for(new line; line<30; line++){
	    TextDrawDestroy(Message[line]);
	}
	#endif
	return 1;
}
public OnPlayerConnect(playerid){
    #if defined AllowDoubleLines
    for(new line; line<15; line++)
	{
	    TextDrawShowForPlayer(playerid, Message[line]);
	}
	#else
	for(new line; line<30; line++)
	{
	    TextDrawShowForPlayer(playerid, Message[line]);
	}
	#endif
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	return 1;
}
public OnPlayerText(playerid, text[]){
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, sizeof(pName));
	new Namelen = strlen(pName);
	new len = strlen(text);
	if(strcmp(text[len-1], " ", true)==0)
	{
	    text[len-1] = '\0';
	}
	#if defined AllowDoubleLines
	if(strlen(text) > (105-Namelen))
	{
		new str[128];
		format(str, 128, "Text too long! You can write max %d characters", 105-Namelen);
	    SendClientMessage(playerid, 0xFF0000AA, str);
		return 0;
	}
	#else
	if(strlen(text) > (45-Namelen))
	{
		new str[128];
		format(str, 128, "Text too long! You can write max %d characters", 55-Namelen);
	    SendClientMessage(playerid, 0xFF0000AA, str);
		return 0;
	}
	#endif
    SendChatMessage(playerid, text);
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	if(strcmp(cmdtext, "/clearchat", true) ==0)
	{
		if(!IsPlayerAdmin(playerid)) return 0;
	    #if defined AllowDoubleLines
		for(new i; i<15; i++)
		{
		    SendChatMessage(-1, " ");
		}
		#else
		for(new i; i<30; i++)
		{
		    SendChatMessage(-1, " ");
		}
		#endif
		return 1;
	}
	return 0;
}
stock SendChatMessage(senderID, const message[]){
	new pName[MAX_PLAYER_NAME];
	if(senderID == -1)
	{
	    format(pName, sizeof(pName), " ");
	}
	else
	{
		GetPlayerName(senderID, pName, sizeof(pName));
	}
	#if defined AllowDoubleLines
	for(new line; line<15; line++)
	{
    	TextDrawHideForAll(Message[line]);
    	if(line < 14)
		{
		    MessageStr[line] = MessageStr[line+1];
    		MessageColor[line] = MessageColor[line+1];
    		TextDrawSetString(Message[line], MessageStr[line]);
 		}
	}
	format(MessageStr[14], 128, "%s: %s", pName, message);
	TextDrawSetString(Message[14], MessageStr[14]);
	MessageColor[14] = playerColors[senderID];
	for(new line; line<15; line++)
	{
		TextDrawColor(Message[line], MessageColor[line]);
     	TextDrawShowForAll(Message[line]);
	}
	#else
	for(new line; line<30; line++)
	{
    	TextDrawHideForAll(Message[line]);
    	if(line < 29)
		{
		    MessageStr[line] = MessageStr[line+1];
    		MessageColor[line] = MessageColor[line+1];
    		TextDrawSetString(Message[line], MessageStr[line]);
		}
	}
	format(MessageStr[29], 128, "%s: %s", pName, message);
	TextDrawSetString(Message[29], MessageStr[ID]);
	MessageColor[29] = playerColors[senderID];
	for(new line; line<30; line++)
	{
		TextDrawColor(Message[line], MessageColor[line]);
     	TextDrawShowForAll(Message[line]);
	}
	#endif
	return 0;
}

