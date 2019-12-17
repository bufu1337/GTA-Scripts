#include <a_samp>
#define MAX_CARDS 36
#define MAX_DURAK_PLAYERS 6
#define MAX_DURAK_GAMES 250
#define MAX_CARDSETS 1000
enum cardenum{
	name[10],
	typ,
	wert
};
enum selectenum{
	menuselect,
	card
};
new cardnames[MAX_CARDS][cardenum]={
	{KARO_6,1,6},
	{KARO_7,1,7},
	{KARO_8,1,8},
	{KARO_9,1,9},
	{KARO_10,1,10},
	{KARO_BUBE,1,11},
	{KARO_DAME,1,12},
	{KARO_KING,1,13},
	{KARO_ASS,1,14},
	{PIK_6,2,6},
	{PIK_7,2,7},
	{PIK_8,2,8},
	{PIK_9,2,9},
	{PIK_10,2,10},
	{PIK_BUBE,2,11},
	{PIK_DAME,2,12},
	{PIK_KING,2,13},
	{PIK_ASS,2,14},
	{CROSS_6,3,6},
	{CROSS_7,3,7},
	{CROSS_8,3,8},
	{CROSS_9,3,9},
	{CROSS_10,3,10},
	{CROSS_BUBE,3,11},
	{CROSS_DAME,3,12},
	{CROSS_KING,3,13},
	{CROSS_ASS,3,14},
	{HEART_6,4,6},
	{HEART_7,4,7},
	{HEART_8,4,8},
	{HEART_9,4,9},
	{HEART_10,4,10},
	{HEART_BUBE,4,11},
	{HEART_DAME,4,12},
	{HEART_KING,4,13},
	{HEART_ASS,4,14},
};
new cardset[MAX_CARDSETS][MAX_CARDS];
new playercardset[MAX_PLAYERS][2];
new durakgame[MAX_DURAK_GAMES][MAX_DURAK_PLAYERS];
new playingdurak[MAX_PLAYERS];
new durakstatus[MAX_PLAYERS];
new durakselect[MAX_PLAYERS][selectenum];
new durakcards[MAX_PLAYERS][MAX_CARDS];
public OnFilterScriptInit(){
	for (new i = 0; i < MAX_DURAK_GAMES; i++){
		for (new j = 0; j < MAX_DURAK_PLAYERS; j++){
			durakgame[i][j]=-1;
		}
	}
	return 1;
}
public OnPlayerConnect(playerid){
	playingdurak[playerid]=-1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	if (strcmp("/cardgame", cmd, true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp)){
			SendClientMessage(playerid, COLOR_WHITE, "Benutze: /cardgame [Name of Cardgame]");
			return 1;
		}
		if ( playercardset[playerid][] ){

		}
		if (playingdurak[playerid]>=0){
			SendClientMessage(playerid, COLOR_WHITE, "You already playing Durak");
			return 1;
		}
		if (strcmp("Durak", tmp, true) == 0){
			new j=0;
			while (durakgame[j][0]>-1){
				j++;
			}
			durakgame[j][0]=playerid;
			playingdurak[playerid]=j;
		}
		return 1;
	}
	if (strcmp("/joincardgame", cmd, true) == 0){
		return 1;
	}
	return 0;
}
public MixCards(cardsetid){


}
public GetCards(cardsetid,playerid,quant){


}
public DealCards(durakid){


}
