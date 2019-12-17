#include <a_samp>
#include <Dini>
#define COLOR_BLUE 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
forward ShowMenu1(playerid);
forward ShowMenu2(playerid);
forward ShowMenu3(playerid);
forward HideMenuAll(playerid);
new Text:Number1, Text:Number2, Text:Number3, Text:Number4, Text:Number5, Text:Number6, Text:Number7, Text:Number8, Text:Number9;
new Text:Text1, Text:Text2, Text:Text3, Text:Text4, Text:Text5, Text:Text6, Text:Text7, Text:Text8, Text:Text9;
new MenuS[MAX_PLAYERS] = 0, ChatS[MAX_PLAYERS] = 0;
new configname[256], Language;
new Menu1LangRU[6][32] = {
	"МPЕKPOЖПE ЦEHХ!",
	"ИAЖЦЕПE УПOП МYHKП",
	"YГEPДЕBAЖПE УПY МOИЕЙЕФ",
	"МEPEВPYММЕPYЖПECТ",
	"CЗEГYЖПE ИA ЦHOЖ",
	"AПAKYФП...HYДHA МOЦOКТ!"
};
new Menu2LangRU[6][32] = {
	"МOОЗЕ",
	"OПXOГЕЦ",
	"KOЦAHГA ГEPДЕЦCХ BЦECПE",
	"ИAHХПТ МOИЕЙЕФ",
	"ОПYPЦYEЦ БPOHOП!",
	"ГOЗOДЕПТ"
};
new Menu3LangRU[9][32] = {
	"ПAK ПOНHO/BAC МOHХЗ",
	"BЕДY BPAВA",
	"HYДHA МOЦOКТ",
	"CEKПOP НЕCП",
	"Х HA МOИЕЙЕЕ",
	"ГOKЗAГСBAФ",
	"YXOГЕЦ! CEЖНAC PBAHEП!",
	"HЕKAK HEП",
	"МPOПЕBHЕK YАЕП"
};
new Menu1LangEN[6][32] = {
	"Cover Me",
	"You Take the Point",
	"Hold This Position",
	"Regroup Team",
	"Follow Me",
	"Taking Fire, Need Assistance"
};
new Menu2LangEN[6][32] = {
	"Go",
	"Fall Back",
	"Stick Together Team",
	"Get in Position",
	"Storm the Front",
	"Report In"
};
new Menu3LangEN[9][32] = {
	"Affirmative/Roger",
	"Enemy Spotted",
	"Need Backup",
	"Sector Clear",
	"I'm in Position",
	"Reporting In",
	"She's gonna Blow",
	"Negative",
	"Enemy Down"
};
new Send1LangEN[6][32] = {
	"Cover Me",
	"You Take the Point",
	"Hold This Position",
	"Regroup Team",
	"Follow Me",
	"Taking Fire, Need Assistance"
};
new Send1LangRU[6][32] = {
	"ѕрикройте мен€!",
	"«аймите этот пункт",
	"”держивайте эту позицию",
	"ѕерегруппируйтесь",
	"—ледуйте за мной",
	"јтакуют...Ќужна помощь!"
};
new Send2LangEN[6][32] = {
	"Go! Go! Go!",
	"Fall Back",
	"Stick Together Team",
	"Get in Position",
	"Storm the Front",
	"Report In"
};
new Send2LangRU[6][32] = {
	"ѕошли! ѕошли! ѕошли!",
	"ќтходим",
	" оманда держимс€ вместе",
	"«ан€ть позицию",
	"Ўтурмуем фронт!",
	"ƒоложить"
};
new Send3LangEN[9][32] = {
	"Affirmative/Roger",
	"Enemy Spotted",
	"Need Backup",
	"Sector Clear",
	"I'm in Position",
	"Reporting In",
	"She's gonna Blow",
	"Negative",
	"Enemy Down"
};
new Send3LangRU[9][32] = {
	"“ак точно/¬ас пон€л",
	"¬ижу врага",
	"Ќужна помощь",
	"—ектор чист",
	"я на позиции",
	"ƒокладываю",
	"”ходим! —ейчас рванет!",
	"Ќикак нет",
	"ѕротивник убит"
};
public OnFilterScriptInit(){
	print("=====================================");
	print("|                                   |");
	print("|           CS Radio v.1.0          |");
	print("|             by Eragon             |");
	print("|           -------------           |");
	print("|    http://eragon-studio.3dn.ru    |");
	print("|                                   |");
	print("=====================================");
	format(configname,sizeof(configname),"CSRadio.txt");
    if (!dini_Exists(configname)){
		print("Not found 'CSRadio.txt'");
   		dini_Create(configname);
   		print("File 'CSRadio.txt' created");
   		dini_IntSet(configname, "Lang", 0); // 0-russian, 1-english
   		print("Line 'Lang' created, parametr '0'");
	}
	else{
		Language = dini_Int(configname, "Lang");
	}
	Number1 = TextDrawCreate(1.000000,251.000000,"1.");
	TextDrawAlignment(Number1,0);
	TextDrawBackgroundColor(Number1,0x000000ff);
	TextDrawFont(Number1,3);
	TextDrawLetterSize(Number1,0.499999,1.000000);
	TextDrawColor(Number1,0xffffffff);
	TextDrawSetOutline(Number1,1);
	TextDrawSetProportional(Number1,1);
	TextDrawSetShadow(Number1,1);
	Number2 = TextDrawCreate(1.000000,261.000000,"2.");
	TextDrawAlignment(Number2,0);
	TextDrawBackgroundColor(Number2,0x000000ff);
	TextDrawFont(Number2,3);
	TextDrawLetterSize(Number2,0.499999,1.000000);
	TextDrawColor(Number2,0xffffffff);
	TextDrawSetOutline(Number2,1);
	TextDrawSetProportional(Number2,1);
	TextDrawSetShadow(Number2,1);
	Number3 = TextDrawCreate(1.000000,271.000000,"3.");
	TextDrawAlignment(Number3,0);
	TextDrawBackgroundColor(Number3,0x000000ff);
	TextDrawFont(Number3,3);
	TextDrawLetterSize(Number3,0.499999,1.000000);
	TextDrawColor(Number3,0xffffffff);
	TextDrawSetOutline(Number3,1);
	TextDrawSetProportional(Number3,1);
	TextDrawSetShadow(Number3,1);
	Number4 = TextDrawCreate(1.000000,281.000000,"4.");
	TextDrawAlignment(Number4,0);
	TextDrawBackgroundColor(Number4,0x000000ff);
	TextDrawFont(Number4,3);
	TextDrawLetterSize(Number4,0.499999,1.000000);
	TextDrawColor(Number4,0xffffffff);
	TextDrawSetOutline(Number4,1);
	TextDrawSetProportional(Number4,1);
	TextDrawSetShadow(Number4,1);
	Number5 = TextDrawCreate(1.000000,291.000000,"5.");
	TextDrawAlignment(Number5,0);
	TextDrawBackgroundColor(Number5,0x000000ff);
	TextDrawFont(Number5,3);
	TextDrawLetterSize(Number5,0.499999,1.000000);
	TextDrawColor(Number5,0xffffffff);
	TextDrawSetOutline(Number5,1);
	TextDrawSetProportional(Number5,1);
	TextDrawSetShadow(Number5,1);
	Number6 = TextDrawCreate(1.000000,301.000000,"6.");
	TextDrawAlignment(Number6,0);
	TextDrawBackgroundColor(Number6,0x000000ff);
	TextDrawFont(Number6,3);
	TextDrawLetterSize(Number6,0.499999,1.000000);
	TextDrawColor(Number6,0xffffffff);
	TextDrawSetOutline(Number6,1);
	TextDrawSetProportional(Number6,1);
	TextDrawSetShadow(Number6,1);
	Number7 = TextDrawCreate(1.000000,311.000000,"7.");
	TextDrawAlignment(Number7,0);
	TextDrawBackgroundColor(Number7,0x000000ff);
	TextDrawFont(Number7,3);
	TextDrawLetterSize(Number7,0.499999,1.000000);
	TextDrawColor(Number7,0xffffffff);
	TextDrawSetOutline(Number7,1);
	TextDrawSetProportional(Number7,1);
	TextDrawSetShadow(Number7,1);
	Number8 = TextDrawCreate(1.000000,321.000000,"8.");
	TextDrawAlignment(Number8,0);
	TextDrawBackgroundColor(Number8,0x000000ff);
	TextDrawFont(Number8,3);
	TextDrawLetterSize(Number8,0.499999,1.000000);
	TextDrawColor(Number8,0xffffffff);
	TextDrawSetOutline(Number8,1);
	TextDrawSetProportional(Number8,1);
	TextDrawSetShadow(Number8,1);
	Number9 = TextDrawCreate(1.000000,331.000000,"9.");
	TextDrawAlignment(Number9,0);
	TextDrawBackgroundColor(Number9,0x000000ff);
	TextDrawFont(Number9,3);
	TextDrawLetterSize(Number9,0.499999,1.000000);
	TextDrawColor(Number9,0xffffffff);
	TextDrawSetOutline(Number9,1);
	TextDrawSetProportional(Number9,1);
	TextDrawSetShadow(Number9,1);
	Text1 = TextDrawCreate(16.000000,249.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text1,1);
	TextDrawBackgroundColor(Text1,0x000000ff);
	TextDrawFont(Text1,1);
	TextDrawLetterSize(Text1,0.399999,1.300000);
	TextDrawColor(Text1,0xffffffff);
	TextDrawSetOutline(Text1,1);
	TextDrawSetProportional(Text1,1);
	TextDrawSetShadow(Text1,1);
	Text2 = TextDrawCreate(16.000000,259.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text2,1);
	TextDrawBackgroundColor(Text2,0x000000ff);
	TextDrawFont(Text2,1);
	TextDrawLetterSize(Text2,0.399999,1.300000);
	TextDrawColor(Text2,0xffffffff);
	TextDrawSetOutline(Text2,1);
	TextDrawSetProportional(Text2,1);
	TextDrawSetShadow(Text2,1);
	Text3 = TextDrawCreate(16.000000,269.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text3,1);
	TextDrawBackgroundColor(Text3,0x000000ff);
	TextDrawFont(Text3,1);
	TextDrawLetterSize(Text3,0.399999,1.300000);
	TextDrawColor(Text3,0xffffffff);
	TextDrawSetOutline(Text3,1);
	TextDrawSetProportional(Text3,1);
	TextDrawSetShadow(Text3,1);
	Text4 = TextDrawCreate(16.000000,279.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text4,1);
	TextDrawBackgroundColor(Text4,0x000000ff);
	TextDrawFont(Text4,1);
	TextDrawLetterSize(Text4,0.399999,1.300000);
	TextDrawColor(Text4,0xffffffff);
	TextDrawSetOutline(Text4,1);
	TextDrawSetProportional(Text4,1);
	TextDrawSetShadow(Text4,1);
	Text5 = TextDrawCreate(16.000000,289.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text5,1);
	TextDrawBackgroundColor(Text5,0x000000ff);
	TextDrawFont(Text5,1);
	TextDrawLetterSize(Text5,0.399999,1.300000);
	TextDrawColor(Text5,0xffffffff);
	TextDrawSetOutline(Text5,1);
	TextDrawSetProportional(Text5,1);
	TextDrawSetShadow(Text5,1);
	Text6 = TextDrawCreate(16.000000,299.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text6,1);
	TextDrawBackgroundColor(Text6,0x000000ff);
	TextDrawFont(Text6,1);
	TextDrawLetterSize(Text6,0.399999,1.300000);
	TextDrawColor(Text6,0xffffffff);
	TextDrawSetOutline(Text6,1);
	TextDrawSetProportional(Text6,1);
	TextDrawSetShadow(Text6,1);
	Text7 = TextDrawCreate(16.000000,309.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text7,1);
	TextDrawBackgroundColor(Text7,0x000000ff);
	TextDrawFont(Text7,1);
	TextDrawLetterSize(Text7,0.399999,1.300000);
	TextDrawColor(Text7,0xffffffff);
	TextDrawSetOutline(Text7,1);
	TextDrawSetProportional(Text7,1);
	TextDrawSetShadow(Text7,1);
	Text8 = TextDrawCreate(16.000000,319.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text8,1);
	TextDrawBackgroundColor(Text8,0x000000ff);
	TextDrawFont(Text8,1);
	TextDrawLetterSize(Text8,0.399999,1.300000);
	TextDrawColor(Text8,0xffffffff);
	TextDrawSetOutline(Text8,1);
	TextDrawSetProportional(Text8,1);
	TextDrawSetShadow(Text8,1);
	Text9 = TextDrawCreate(16.000000,329.000000,"Taking Fire, Need Assistance");
	TextDrawAlignment(Text9,1);
	TextDrawBackgroundColor(Text9,0x000000ff);
	TextDrawFont(Text9,1);
	TextDrawLetterSize(Text9,0.399999,1.300000);
	TextDrawColor(Text9,0xffffffff);
	TextDrawSetOutline(Text9,1);
	TextDrawSetProportional(Text9,1);
	TextDrawSetShadow(Text9,1);

	return 1;
}
ShowMenu1(playerid){
	TextDrawShowForPlayer(playerid,Text1);
	TextDrawShowForPlayer(playerid,Text2);
	TextDrawShowForPlayer(playerid,Text3);
	TextDrawShowForPlayer(playerid,Text4);
	TextDrawShowForPlayer(playerid,Text5);
	TextDrawShowForPlayer(playerid,Text6);
	TextDrawShowForPlayer(playerid,Number1);
	TextDrawShowForPlayer(playerid,Number2);
	TextDrawShowForPlayer(playerid,Number3);
	TextDrawShowForPlayer(playerid,Number4);
	TextDrawShowForPlayer(playerid,Number5);
	TextDrawShowForPlayer(playerid,Number6);
}
ShowMenu2(playerid){
	TextDrawShowForPlayer(playerid,Text1);
	TextDrawShowForPlayer(playerid,Text2);
	TextDrawShowForPlayer(playerid,Text3);
	TextDrawShowForPlayer(playerid,Text4);
	TextDrawShowForPlayer(playerid,Text5);
	TextDrawShowForPlayer(playerid,Text6);
	TextDrawShowForPlayer(playerid,Number1);
	TextDrawShowForPlayer(playerid,Number2);
	TextDrawShowForPlayer(playerid,Number3);
	TextDrawShowForPlayer(playerid,Number4);
	TextDrawShowForPlayer(playerid,Number5);
	TextDrawShowForPlayer(playerid,Number6);
}
ShowMenu3(playerid){
	TextDrawShowForPlayer(playerid,Text1);
	TextDrawShowForPlayer(playerid,Text2);
	TextDrawShowForPlayer(playerid,Text3);
	TextDrawShowForPlayer(playerid,Text4);
	TextDrawShowForPlayer(playerid,Text5);
	TextDrawShowForPlayer(playerid,Text6);
	TextDrawShowForPlayer(playerid,Text7);
	TextDrawShowForPlayer(playerid,Text8);
	TextDrawShowForPlayer(playerid,Text9);
	TextDrawShowForPlayer(playerid,Number1);
	TextDrawShowForPlayer(playerid,Number2);
	TextDrawShowForPlayer(playerid,Number3);
	TextDrawShowForPlayer(playerid,Number4);
	TextDrawShowForPlayer(playerid,Number5);
	TextDrawShowForPlayer(playerid,Number6);
	TextDrawShowForPlayer(playerid,Number7);
	TextDrawShowForPlayer(playerid,Number8);
	TextDrawShowForPlayer(playerid,Number9);
}
HideMenuAll(playerid){
	TextDrawHideForPlayer(playerid,Text1);
	TextDrawHideForPlayer(playerid,Text2);
	TextDrawHideForPlayer(playerid,Text3);
	TextDrawHideForPlayer(playerid,Text4);
	TextDrawHideForPlayer(playerid,Text5);
	TextDrawHideForPlayer(playerid,Text6);
	TextDrawHideForPlayer(playerid,Text7);
	TextDrawHideForPlayer(playerid,Text8);
	TextDrawHideForPlayer(playerid,Text9);
	TextDrawHideForPlayer(playerid,Number1);
	TextDrawHideForPlayer(playerid,Number2);
	TextDrawHideForPlayer(playerid,Number3);
	TextDrawHideForPlayer(playerid,Number4);
	TextDrawHideForPlayer(playerid,Number5);
	TextDrawHideForPlayer(playerid,Number6);
	TextDrawHideForPlayer(playerid,Number7);
	TextDrawHideForPlayer(playerid,Number8);
	TextDrawHideForPlayer(playerid,Number9);
}
public OnPlayerText(playerid, text[]){
	new Count[9][5] = {"1","2","3","4","5","6","7","8","9"};
	switch(Language){
	    case 0: {
			switch(ChatS[playerid]){
				case 1: {
					new str[256], nick[128];
					if (text[0] == Count[0][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[0]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[1][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[1]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[2][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[2]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[3][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[3]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[4][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[4]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[5][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangRU[5]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
				}
				case 2: {
					new str[256], nick[128];
					if (text[0] == Count[0][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[0]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[1][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[1]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[2][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[2]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[3][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[3]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[4][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[4]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[5][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangRU[5]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
				}
				case 3: {
					new str[256], nick[128];
					if (text[0] == Count[0][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[0]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[1][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[1]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[2][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[2]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[3][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[3]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[4][0])
						{
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[4]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[5][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[5]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[6][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[6]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[7][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[7]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
                    if (text[0] == Count[8][0]){
						GetPlayerName(playerid,nick,128);
						format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangRU[8]);
						SendClientMessageToAll (COLOR_BLUE,str);
						for(new i=0; i<MAX_PLAYERS; i++) {
							if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
						}
	                    ChatS[playerid] = 0;
	                    MenuS[playerid] = 0;
	                    HideMenuAll(playerid);
	                    return 0;
					}
				}
			}
		}
	    case 1: switch(ChatS[playerid]){
			case 1: {
				new str[256], nick[128];
				if (text[0] == Count[0][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[0]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[1][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[1]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[2][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[2]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[3][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[3]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[4][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[4]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
 						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[5][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send1LangEN[5]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
			}
			case 2: {
				new str[256], nick[128];
				if (text[0] == Count[0][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[0]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[1][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[1]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[2][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[2]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[3][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[3]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[4][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[4]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[5][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send2LangEN[5]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
			}
			case 3: {
				new str[256], nick[128];
				if (text[0] == Count[0][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[0]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[1][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[1]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[2][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[2]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[3][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[3]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[4][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[4]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[5][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[5]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[6][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[6]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[7][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[7]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
                if (text[0] == Count[8][0]){
					GetPlayerName(playerid,nick,128);
					format(str,256,"%s (ID: %d): %s",nick,playerid,Send3LangEN[8]);
					SendClientMessageToAll (COLOR_BLUE,str);
					for(new i=0; i<MAX_PLAYERS; i++) {
						if (IsPlayerConnected(i)) PlayerPlaySound(i,1056,0,0,0);
					}
	                ChatS[playerid] = 0;
	                MenuS[playerid] = 0;
	                HideMenuAll(playerid);
	                return 0;
				}
			}
		}
	}
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys == KEY_CROUCH+KEY_SPRINT){
		switch(Language){
		    case 0: {
		        switch(MenuS[playerid]){
		            case 0: {
		                TextDrawSetString(Text1,Menu1LangRU[0]);
		                TextDrawSetString(Text2,Menu1LangRU[1]);
		                TextDrawSetString(Text3,Menu1LangRU[2]);
		                TextDrawSetString(Text4,Menu1LangRU[3]);
		                TextDrawSetString(Text5,Menu1LangRU[4]);
		                TextDrawSetString(Text6,Menu1LangRU[5]);
		                ShowMenu1(playerid);
						MenuS[playerid] = 1;
						ChatS[playerid] = 1;
					}
		            case 1: {
		                TextDrawSetString(Text1,Menu2LangRU[0]);
		                TextDrawSetString(Text2,Menu2LangRU[1]);
		                TextDrawSetString(Text3,Menu2LangRU[2]);
		                TextDrawSetString(Text4,Menu2LangRU[3]);
		                TextDrawSetString(Text5,Menu2LangRU[4]);
		                TextDrawSetString(Text6,Menu2LangRU[5]);
		                ShowMenu2(playerid);
						MenuS[playerid] = 2;
						ChatS[playerid] = 2;
					}
		            case 2: {
		                TextDrawSetString(Text1,Menu3LangRU[0]);
		                TextDrawSetString(Text2,Menu3LangRU[1]);
		                TextDrawSetString(Text3,Menu3LangRU[2]);
		                TextDrawSetString(Text4,Menu3LangRU[3]);
		                TextDrawSetString(Text5,Menu3LangRU[4]);
		                TextDrawSetString(Text6,Menu3LangRU[5]);
		                TextDrawSetString(Text7,Menu3LangRU[6]);
		                TextDrawSetString(Text8,Menu3LangRU[7]);
		                TextDrawSetString(Text9,Menu3LangRU[8]);
		                ShowMenu3(playerid);
						MenuS[playerid] = 3;
						ChatS[playerid] = 3;
					}
		            case 3: {
		                HideMenuAll(playerid);
						MenuS[playerid] = 0;
						ChatS[playerid] = 0;
					}
				}
			}
		    case 1: {
				switch(MenuS[playerid]){
		            case 0: {
		                TextDrawSetString(Text1,Menu1LangEN[0]);
		                TextDrawSetString(Text2,Menu1LangEN[1]);
		                TextDrawSetString(Text3,Menu1LangEN[2]);
		                TextDrawSetString(Text4,Menu1LangEN[3]);
		                TextDrawSetString(Text5,Menu1LangEN[4]);
		                TextDrawSetString(Text6,Menu1LangEN[5]);
		                ShowMenu1(playerid);
						MenuS[playerid] = 1;
						ChatS[playerid] = 1;
					}
		            case 1: {
		                TextDrawSetString(Text1,Menu2LangEN[0]);
		                TextDrawSetString(Text2,Menu2LangEN[1]);
		                TextDrawSetString(Text3,Menu2LangEN[2]);
		                TextDrawSetString(Text4,Menu2LangEN[3]);
		                TextDrawSetString(Text5,Menu2LangEN[4]);
		                TextDrawSetString(Text6,Menu2LangEN[5]);
		                ShowMenu2(playerid);
						MenuS[playerid] = 2;
						ChatS[playerid] = 2;
					}
		            case 2: {
		                TextDrawSetString(Text1,Menu3LangEN[0]);
		                TextDrawSetString(Text2,Menu3LangEN[1]);
		                TextDrawSetString(Text3,Menu3LangEN[2]);
		                TextDrawSetString(Text4,Menu3LangEN[3]);
		                TextDrawSetString(Text5,Menu3LangEN[4]);
		                TextDrawSetString(Text6,Menu3LangEN[5]);
		                TextDrawSetString(Text7,Menu3LangEN[6]);
		                TextDrawSetString(Text8,Menu3LangEN[7]);
		                TextDrawSetString(Text9,Menu3LangEN[8]);
		                ShowMenu3(playerid);
						MenuS[playerid] = 3;
						ChatS[playerid] = 3;
					}
		            case 3: {
		                HideMenuAll(playerid);
						MenuS[playerid] = 0;
						ChatS[playerid] = 0;
					}
				}
			}
		}
	}
    if(newkeys == KEY_WALK+KEY_SPRINT){
        HideMenuAll(playerid);
		MenuS[playerid] = 0;
		ChatS[playerid] = 0;
	}
}
public OnPlayerCommandText(playerid, cmdtext[]){
	dcmd(cslanguage, 10, cmdtext);
	return 0;
}
dcmd_cslanguage(playerid, params[]){
	new LanguageID;
	if ((sscanf(params, "d",LanguageID))&&(LanguageID<0)&&(LanguageID>1)) SendClientMessage(playerid, COLOR_WHITE, " »спользование: \"/cslanguage [LanguageID(0-1)]\"");
	else{
		if (IsPlayerAdmin(playerid)){
			dini_IntSet(configname, "Lang", LanguageID);
			Language = dini_Int(configname, "Lang");
			new str[256];
			new LangT[128];
			if (LanguageID == 0) {
				LangT = "–усский";
			}
			else {
				LangT = "English";
			}
		   	format (str,256," язык был изменен на %s (ID: %d)",LangT,Language);
		   	SendClientMessage(playerid, COLOR_WHITE, str);
		}
	}
	return 1;
}
public OnFilterScriptExit(){
	print("=====================================");
	print("|----UNLOAD---------------UNLOAD----|");
	print("|           CS Radio v.1.0          |");
	print("|             by Eragon             |");
	print("|           -------------           |");
	print("|----http://eragon-studio.3dn.ru----|");
	print("=====================================");
	TextDrawHideForAll(Text1);
	TextDrawHideForAll(Text2);
	TextDrawHideForAll(Text3);
	TextDrawHideForAll(Text4);
	TextDrawHideForAll(Text5);
	TextDrawHideForAll(Text6);
	TextDrawHideForAll(Text7);
	TextDrawHideForAll(Text8);
	TextDrawHideForAll(Text9);
	TextDrawHideForAll(Number1);
	TextDrawHideForAll(Number2);
	TextDrawHideForAll(Number3);
	TextDrawHideForAll(Number4);
	TextDrawHideForAll(Number5);
	TextDrawHideForAll(Number6);
	TextDrawHideForAll(Number7);
	TextDrawHideForAll(Number8);
	TextDrawHideForAll(Number9);
	TextDrawDestroy(Text1);
	TextDrawDestroy(Text2);
	TextDrawDestroy(Text3);
	TextDrawDestroy(Text4);
	TextDrawDestroy(Text5);
	TextDrawDestroy(Text6);
	TextDrawDestroy(Text7);
	TextDrawDestroy(Text8);
	TextDrawDestroy(Text9);
	TextDrawDestroy(Number1);
	TextDrawDestroy(Number2);
	TextDrawDestroy(Number3);
	TextDrawDestroy(Number4);
	TextDrawDestroy(Number5);
	TextDrawDestroy(Number6);
	TextDrawDestroy(Number7);
	TextDrawDestroy(Number8);
	TextDrawDestroy(Number9);
	return 1;
}
stock sscanf(string[], format[], {Float,_}:...){
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos]){
		switch (format[formatPos++]){
			case '\0':{
				return 0;
			}
			case 'i', 'd':{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-'){
					neg = -1;
					ch = string[++stringPos];
				}
				do{
					stringPos++;
					if (ch >= '0' && ch <= '9'){
						num = (num * 10) + (ch - '0');
					}
					else{
						return 1;
					}
				}
				while ((ch = string[stringPos]) && ch != ' ');
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':{
				new
					ch,
					num = 0;
				while ((ch = string[stringPos++])){
					switch (ch){
						case 'x', 'X':{
							num = 0;
							continue;
						}
						case '0' .. '9':{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':{
							num = (num << 4) | (ch - ('A' - 10));
						}
						case ' ':{
							break;
						}
						default:{
							return 1;
						}
					}
				}
				setarg(paramPos, 0, num);
			}
			case 'c':{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':{
				new tmp[25];
				strmid(tmp, string, stringPos, stringPos+sizeof(tmp)-2);
				setarg(paramPos, 0, _:floatstr(tmp));
			}
			case 's', 'z':{
				new
					i = 0,
					ch;
				if (format[formatPos]){
					while ((ch = string[stringPos++]) && ch != ' '){
						setarg(paramPos, i++, ch);
					}
					if (!i) return 1;
				}
				else{
					while ((ch = string[stringPos++])){
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != ' '){
			stringPos++;
		}
		while (string[stringPos] == ' '){
			stringPos++;
		}
		paramPos++;
	}
	while (format[formatPos] == 'z') formatPos++;
	return format[formatPos];
}
