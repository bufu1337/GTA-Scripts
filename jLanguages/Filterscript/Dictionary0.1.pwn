/*Translation Filterscript by Jason Gregory

English - Portugues - German

Every unknown Word gets Translated, if u want to add some
more words, u can put them under

new Translations[54][LanguageModul] = {

Dont forget to change [54] if u add more words

Don´t remove the Credits
*/


#include <a_samp>
#include <float>

new LanguageCheck[MAX_PLAYERS];
new German[MAX_PLAYERS];
new English[MAX_PLAYERS];
new Portugues[MAX_PLAYERS];
new Menu:LanguageMenu;
new realchat = 1;

forward LanguageRadiusDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);

#define LanguageConfig    0x21DD00FF
#define RadiusDetector1 0xE6E6E6E6
#define RadiusDetector2 0xC8C8C8C8
#define RadiusDetector3 0xAAAAAAAA
#define RadiusDetector4 0x8C8C8C8C
#define RadiusDetector5 0x6E6E6E6E

enum LanguageModul
{
	LanguageDeutsch[128],
	LanguageEnglish[128],
	LanguagePortugues[128],
};

new Translations[54][LanguageModul] = {
	{"Hallo", "Hello", "Ola"},
	{"Was", "What", "Que"},
	{"Eins", "One", "Uno"},
	{"Zwei", "Two", "Due"},
	{"Drei", "Three", "Tre"},
	{"Vier", "Four", "Quatro"},
	{"Fünf", "Five", "Sinqo"},
	{"Sechs", "Six", "Seys"},
	{"Sieben", "Seven", "Setche" },
	{"Acht", "Eight", "Outo"},
	{"Neun", "Nine", "Nove"},
	{"Zehn", "Ten", "Dez"},
	{"Wie", "How", "Como"},
	{"Uhr", "Watch", "Heloscho"},
	{"Polizei", "Police", "Policia"},
	{"Auto", "Vehicle", "Carro"}, // -> 16
	{"Motorad", "Motorbike", "Motocycleta"},
	{"Fahrrad", "Bike", "Bycycleta"},
	{"Alter", "Age", "Ano"},
	{"Du", "You", "Voce"}, // -> 20
	{"Los", "Go", "Vamos"},
	{"Auto", "Vehicle", "Carro"},
	{"Flugzeug", "Plane", "Aviou"},
	{"Boot", "Boat", "Barque"},
	{"Geld", "Money", "Dinhero"},
	{"Essen", "Eat", "Comher"},
	{"Etwas", "Something", "-"},
	{"Komm", "Come", "Venhe"},
	{"Wo", "Where", "Onde"}, //-> 30
	{"Nummer", "Number", "Nummero"},
	{"Drucken", "Print", "Printar"},
	{"Uhrzeit", "Time", "Horas"},
	{"Zug", "Train", "-"},
	{"Schnell", "Fast", "Rapido"},
	{"Nitro", "NOS", "-"},
	{"Fesseln", "Tie", "Amahar"},
	{"Gib", "Give", "Da"},
	{"From", "Von", "De"},
	{"Mikro", "Headset", "Microphon"}, //-> 40
	{"Spieler", "Player", "Jugador"},
	{"Panzer", "Tank", "Tanque"},
	{"Hilfe", "Help", "Ajuda"},
	{"Ruf", "Call", "Telephonar"},
	{"Bezahle", "Pay", "Pagar"},
	{"Handy", "Cellphone", "Cerular"},
	{"Heute", "Today", "Hoje"},
	{"Morgen", "Tomorow", "Amonja"},
	{"Was zur Hölle", "Wtf", "Porra"},
	{"Stufe", "Level", "-"}, //-> 50
	{"Leben","Health", "Vida"},
	{"Krankenhaus", "Hospital", "Hospital"},
	{"Langsam", "Slow", "Divagar"},
	{"Tankstelle", "Petrol Station", "Tanque Petrol"},
	{"Musik", "Music", "Musica"} //-> 54
	/*Pls edit the  [54] +1 if u add a line
	Optional u can use the Include - jLanguages*/
};

public OnPlayerConnect(playerid)
{
   SendClientMessage(playerid, LanguageConfig, "Interlingual Filterscript by Jason Gregory");
   LanguageCheck[playerid] = 0;
}

public OnPlayerSpawn(playerid)
{
    if(LanguageCheck[playerid] == 0)
    {
        ShowMenuForPlayer(LanguageMenu, playerid);
    }
	else
	{
		if(German[playerid] == 1 || English[playerid] == 0 || Portugues[playerid] == 1){
        	SendClientMessage(playerid, LanguageConfig, "Du hast die deutsche Sprache gewählt");}
		else if(German[playerid] == 0 || English[playerid] == 1 || Portugues[playerid] == 1){
		   SendClientMessage(playerid, LanguageConfig, "U have choosen the English Language");}
		else if(German[playerid] == 0 || English[playerid] == 0 || Portugues[playerid] == 1){
		   SendClientMessage(playerid, LanguageConfig, "Voce pego a Ligua Portuguesa");}
	}
}

public OnFilterScriptInit()
{
    LanguageMenu = CreateMenu("~b~ Language/Sprache/Lingua:",1,50,220,200,200);
	AddMenuItem(LanguageMenu, 0, "Deutsch/Alemangne/German");
	AddMenuItem(LanguageMenu, 0, "English/Englisch/Ingles");
	AddMenuItem(LanguageMenu, 0, "Portugues/Portugues/Portugisisch");
}

public LanguageRadiusDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:Candidatex, Float:Candidatey, Float:Candidatez;
		new Float:oldCandidatex, Float:oldCandidatey, Float:oldCandidatez;
		new Float:tempCandidatex, Float:tempCandidatey, Float:tempCandidatez;
		GetPlayerPos(playerid, oldCandidatex, oldCandidatey, oldCandidatez);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
					GetPlayerPos(i, Candidatex, Candidatey, Candidatez);
					tempCandidatex = (oldCandidatex -Candidatex);
					tempCandidatey = (oldCandidatey -Candidatey);
					tempCandidatez = (oldCandidatez -Candidatez);
					if (((tempCandidatex < radi/16) && (tempCandidatex > -radi/16)) && ((tempCandidatey < radi/16) && (tempCandidatey > -radi/16)) && ((tempCandidatez < radi/16) && (tempCandidatez > -radi/16))){
						SendClientMessage(i, col1, string);}
					else if (((tempCandidatex < radi/8) && (tempCandidatex > -radi/8)) && ((tempCandidatey < radi/8) && (tempCandidatey > -radi/8)) && ((tempCandidatez < radi/8) && (tempCandidatez > -radi/8))){
						SendClientMessage(i, col2, string);}
					else if (((tempCandidatex < radi/4) && (tempCandidatex > -radi/4)) && ((tempCandidatey < radi/4) && (tempCandidatey > -radi/4)) && ((tempCandidatez < radi/4) && (tempCandidatez > -radi/4))){
						SendClientMessage(i, col3, string);}
					else if (((tempCandidatex < radi/2) && (tempCandidatex > -radi/2)) && ((tempCandidatey < radi/2) && (tempCandidatey > -radi/2)) && ((tempCandidatez < radi/2) && (tempCandidatez > -radi/2))){
						SendClientMessage(i, col4, string);}
					else if (((tempCandidatex < radi) && (tempCandidatex > -radi)) && ((tempCandidatey < radi) && (tempCandidatey > -radi)) && ((tempCandidatez < radi) && (tempCandidatez > -radi))){
						SendClientMessage(i, col5, string);}
				}
				else{
					SendClientMessage(i, col1, string);}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
    new sendername[MAX_PLAYER_NAME];
	new string[64];
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));

    if (realchat)
	{
	    if(German[playerid] == 0 && English[playerid] == 0 && Portugues[playerid] == 0)
	    {
	        return 0;
      	}
      	else if(German[playerid] == 1)
      	{
            GetPlayerName(playerid, sendername, sizeof(sendername));
	    	format(string, sizeof(string), "%s sagt: %s", sendername, text);
	    	LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
	    }
	    else if(English[playerid] == 1)
	    {
            GetPlayerName(playerid, sendername, sizeof(sendername));
	    	format(string, sizeof(string), "%s says: %s", sendername, text);
	    	LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
	    }
	    else if(Portugues[playerid] == 1)
	    {
            GetPlayerName(playerid, sendername, sizeof(sendername));
	    	format(string, sizeof(string), "%s esta disendo: %s", sendername, text);
	    	LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
	    }

   	}
   	//==========================================================================
   	new idx; new tmp[256];
   	tmp = strtok(text, idx);
   	
    if(Translations[idx][LanguageDeutsch])
   	{
       if(German[playerid] == 1)
       {
          return 1;
       }
       else if(English[playerid] == 1)
       {
		   SendClientMessage(playerid, RadiusDetector2, "| - Englische Übersetzung - |");
           format(string, sizeof(string), "%s", Translations[idx][LanguageEnglish]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
       else if(Portugues[playerid] == 1)
       {
           SendClientMessage(playerid, RadiusDetector2, "| - Portugisische Übersetzung - |");
           format(string, sizeof(string), "%s",Translations[idx][LanguagePortugues]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
   	}
   	else if(Translations[idx][LanguageEnglish])
   	{
       if(German[playerid] == 1)
       {
           SendClientMessage(playerid, RadiusDetector2, "| - German Translation - |");
           format(string, sizeof(string), "%s", Translations[idx][LanguageEnglish]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
       else if(English[playerid] == 1)
       {
           return 1;
       }
       else if(Portugues[playerid] == 1)
       {
           SendClientMessage(playerid, RadiusDetector2, "| - Portugues Translation - |");
           format(string, sizeof(string), "%s",Translations[idx][LanguagePortugues]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
   	}
   	else if(Translations[idx][LanguageEnglish])
   	{
       if(German[playerid] == 1)
       {
           SendClientMessage(playerid, RadiusDetector2, "| - Lingua Alemangne - |");
           format(string, sizeof(string), "%s", Translations[idx][LanguageEnglish]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
       else if(English[playerid] == 1)
       {
           SendClientMessage(playerid, RadiusDetector2, "| - Lingua Inglatera - |");
           format(string, sizeof(string), "%s", Translations[idx][LanguageEnglish]);
           LanguageRadiusDetector(20.0, playerid, string,RadiusDetector1,RadiusDetector2,RadiusDetector3,RadiusDetector4,RadiusDetector5);
       }
       else if(Portugues[playerid] == 1)
       {
           return 1;
       }
   	}
   	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
