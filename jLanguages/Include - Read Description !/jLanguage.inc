
#include <a_samp>
#include <float>

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