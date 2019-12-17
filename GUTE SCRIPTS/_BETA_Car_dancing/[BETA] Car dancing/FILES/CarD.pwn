//------------------------------------------------------------------------------
//
//   DancingCars miniMission Filter Script v1.0
//   Designed for SA-MP v0.2.2
//
//   Created by zeruel_angel
//
//------------------------------------------------------------------------------
#include <a_samp>
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_BLUE 0xAA33AA33
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define KEY_CAR_CHANGE 2
#define KEY_CAR_JUMP 512
#define KEY_CAR_UP 2048
#define KEY_CAR_DOWN 4096
#define KEY_CAR_LEFT 8192
#define KEY_CAR_RIGHT 16384
#define MAX_GOOD_SPEECH 9
#define MAX_EARLY_SPEECH 9
#define MAX_LATE_SPEECH 9
#define MAX_BAD_SPEECH 9
forward UpdatePasos();
new PlayerIsDancing[MAX_PLAYERS];
new currentKey;
new lateKey;
new nextKey;
new allow[MAX_PLAYERS];
new host;
new MoneyBet;
new prize;
new Text:Baile;
//new pasos[]={"____U____D____L____R____U____D____L____R____U____D____L____R____U____D____L____R______________"};
new pasos[]={"_______________U_U__D_D__L_L__R_R__U_L__D____L____R__L_U_L_R_D__L_L_L__R_U__U_U__D_R__L_U__R_L_R_L_R_L________________"};
new paso;
new TimerBaile;
new cadena[256];
new score[MAX_PLAYERS];
new GoodSpeech[9][]={
	{"~b~Perfect!"},
 	{"~b~Good!!!"},
 	{"~b~Great!"},
 	{"~b~Go on!"},
 	{"~w~You are the~n~~b~best!"},
 	{"~b~Excellect!"},
 	{"~b~Yeah man!"},
 	{"~b~Yahoo!"},
 	{"~w~You are ~n~~b~the man!"}
	};
new EarlySpeech[9][]={
	{"~r~Not so fast!"},
 	{"~r~Relax man!"},
 	{"~r~Ouch! just for a second!"},
 	{"~r~Come on you can do it!"},
 	{"~r~Are you sure~n~~b~YOU ~w~can do this? "},
 	{"~r~Are you aweake?"},
 	{"~r~Just wait to the right time"},
 	{"~r~Not again!"},
 	{"~r~You are to fast!"}
	};
new LateSpeech[9][]={
	{"~r~No man!"},
 	{"~r~To late!"},
 	{"~r~Ouch! just for a second!"},
 	{"~r~FASTER! FASTER! FASTER!"},
 	{"~r~what are you? ~n~ a ~w~tortoise~r~?"},
 	{"~r~Are you aweake?"},
 	{"~r~Just wait to the right time"},
 	{"~r~Not again!"},
 	{"~r~You are to slow!"}
	};
new BadSpeech[9][]={
	{"~r~No man!"},
 	{"~r~you sucks!"},
 	{"~r~you know what you have to do right?!"},
 	{"~r~hahaha!"},
 	{"~r~ROLF!"},
 	{"~r~LMAO! you are a shame!"},
 	{"~r~come on guy! are you there?"},
 	{"~r~are you pressing random keys?"},
 	{"~r~Say bye to your cash!"}
	};
public OnFilterScriptInit(){
	print("\n DancingCars Filter Script v1.0 Loading...\n***********************************\n      (Zeruel_Angel)\n");
	host=-1;
	Baile = TextDrawCreate(75.0, 200.0, "Vamos");
	print("DancingCars Filter Script fully Loaded\n**********************************\n\n");
}
public OnFilterScriptExit(){
    print("\n DancingCars Script UnLoaded\n********************************************\n\n");
	return 1;
}
FinalizarBaile(){
    new winner=199;
    score[winner]=-1;
    new tie=0;
    new name2[MAX_PLAYER_NAME];
    for (new i=0;i<MAX_PLAYERS;i++){
        if  ((IsPlayerConnected(i))&&(PlayerIsDancing[i]==1)){
            if  (score[i]>score[winner]){
                winner=i;
                tie=0;
			}
			else{
			    if  (score[i]==score[winner]){
                	tie=1;
				}
			}
		}
	}
	if	(tie==0){
	    GetPlayerName(winner,name2,sizeof(name2));
	    GivePlayerMoney(winner,prize);
        PlayerIsDancing[winner]=0;
		GameTextForPlayer(winner,"~w~YOU ARE THE ~b~WINNER!",5000,4);
		PlayerIsDancing[winner]=0;
	    format(cadena,sizeof(cadena),"~w~The ~b~winner ~w~is: ~g~%s~n~ ~w~He wins $~b~%d ~w~you loose $~r~%d",name2,prize,MoneyBet);
	    for (new i=0;i<MAX_PLAYERS;i++){
	        if  ((IsPlayerConnected(i))&&(PlayerIsDancing[i]!=0)){
	            PlayerIsDancing[i]=0;
				GameTextForPlayer(i,cadena,5000,4);
			}
		}
   		host=-1;
		paso=0;
	}
	else{
	    format(cadena,sizeof(cadena),"~w~There is a ~b~tie!.~n~~w~ But you are a looser... ~n~You loose $~r~%d",MoneyBet);
	    for (new i=0;i<MAX_PLAYERS;i++){
	        if  ((IsPlayerConnected(i))&&(PlayerIsDancing[i]==1)&&(score[i]<score[winner])){
	            PlayerIsDancing[i]=0;
				GameTextForPlayer(i,cadena,5000,4);
			}
			else{
		        if  ((IsPlayerConnected(i))&&(PlayerIsDancing[i]==1)){
					GameTextForPlayer(i,"~w~There is a ~b~tie!.~n~~w~You need to untie!",5000,4);
					score[i]=0;
					TextDrawShowForPlayer(i, Baile);
				}
			}
		}
        paso=0;
		TimerBaile=SetTimer("UpdatePasos",500,1);
	}
}
public UpdatePasos(){
	TextDrawDestroy(Baile);
	new paso2=paso+11;
	strmid(cadena,pasos,paso,paso2);
	paso++;
	new strAux[256]="12345678901";
	for (new i=0;i<sizeof(cadena);i++){
	    strAux[i]=cadena[i];
	}
	if	((cadena[4]=='_')&&(cadena[5]!='_')&&(cadena[6]=='_')){
		strAux[4]='[';
		strAux[6]=']';
	}
    Baile = TextDrawCreate(100.0, 250.0, strAux);
   	TextDrawLetterSize(Baile, 2, 2.66);
	TextDrawTextSize(Baile, 100.0, 170.0);
	TextDrawSetOutline(Baile,1);
	lateKey=getKey(cadena[4]);
	currentKey=getKey(cadena[5]);
	nextKey=getKey(cadena[6]);
	for (new i=0;i<MAX_PLAYERS;i++){
		if	((IsPlayerConnected(i))&&(PlayerIsDancing[i]==1))
	        {
	        TextDrawShowForPlayer(i, Baile);
	        allow[i]++;
	        }
	    }
	if  (paso+12>strlen(pasos))
	    {
	    KillTimer(TimerBaile);
		TextDrawHideForAll(Baile);
		FinalizarBaile();
	    }
	}
  getGoodSpeech(){
	  new msg[256];
	  format(msg,sizeof(msg),"%s",GoodSpeech[random(MAX_GOOD_SPEECH)]);
	  return msg;
  }
  getEarlySpeech(){
	  new msg[256];
	  format(msg,sizeof(msg),"%s",EarlySpeech[random(MAX_EARLY_SPEECH)]);
	  return msg;
  }
  getLateSpeech(){
	  new msg[256];
	  format(msg,sizeof(msg),"%s",LateSpeech[random(MAX_LATE_SPEECH)]);
	  return msg;
  }
  getBadSpeech(){
	  new msg[256];
	  format(msg,sizeof(msg),"%s",BadSpeech[random(MAX_BAD_SPEECH)]);
	  return msg;
  }
getKey(letra){
	switch (letra){
	    case 85 : return KEY_CAR_UP;
	    case 68 : return KEY_CAR_DOWN;
	    case 76 : return KEY_CAR_LEFT;
	    case 82 : return KEY_CAR_RIGHT;
	    case 83 : return KEY_CAR_CHANGE;
	    case 67 : return KEY_CAR_JUMP;
	    default : return -1;
	}
 	return -1;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if 	((newstate==PLAYER_STATE_ONFOOT)&&((PlayerIsDancing[playerid]==1))){
	    GameTextForPlayer(playerid,"~w~You ~r~quit ~w~competition",3000,4);
	    PlayerIsDancing[playerid]=0;
	}
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if  ((PlayerIsDancing[playerid]==1)&&(allow[playerid]>1)){
		if 	(newkeys == currentKey){
		    GameTextForPlayer(playerid,getGoodSpeech(),500,3);
		    allow[playerid]=0;
		    score[playerid]++;
		}
		else{
  			if 	(newkeys == lateKey){
			    GameTextForPlayer(playerid,getLateSpeech(),1000,3);
			    allow[playerid]=0;
			}
			else{
				if 	(newkeys == nextKey){
				    GameTextForPlayer(playerid,getEarlySpeech(),1000,3);
				    allow[playerid]=0;
				}
				else{
					if  (newkeys != 0){
				    	GameTextForPlayer(playerid,getBadSpeech(),1000,3);
				    	allow[playerid]=0;
					}
				}
			}
		}
	}
}
public OnPlayerDisconnect(playerid){
 	PlayerIsDancing[playerid]=0;
 	score[playerid]=0;
	return 1;
}
Float:GetDistanceBetweenPlayers(player1,player2){
    new Float:x1,Float:y1,Float:z1;
    new Float:x2,Float:y2,Float:z2;
	GetPlayerPos(player1,x1,y1,z1);
	GetPlayerPos(player2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x1,x2)),2)+floatpower(floatabs(floatsub(y1,y2)),2)+floatpower(floatabs(floatsub(z1,z2)),2));
}
public OnPlayerCommandText(playerid,cmdtext[]){
	new cmd[256];
	new tmp[256];
	new idx;
    cmd = strtok(cmdtext, idx);
 	if 	(strcmp(cmd, "/cardance", true)==0){
        if	(host!=-1){
            new name2[MAX_PLAYER_NAME];
	        GetPlayerName(host,name2,sizeof(name2));
	        format(tmp,sizeof(tmp),"Player %s (id:%d) have already organiced a party. He bets $%d ",name2,playerid,MoneyBet);
	        SendClientMessage(playerid,COLOR_YELLOW,tmp);
	        SendClientMessage(playerid,COLOR_YELLOW,"If you wants to challenge him, find him.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if	(!strlen(tmp)){
			SendClientMessage(playerid, COLOR_WHITE, "USO:/cardance [BET]");
			return 1;
		}
		MoneyBet = strval(tmp);
		if	(!IsPlayerInAnyVehicle(playerid)){
			SendClientMessage(playerid, COLOR_WHITE, "You must be in a car to be able to organizate a car dance competition...");
			return 1;
		}
		host = playerid;
		score[playerid]=0;
        new name2[MAX_PLAYER_NAME];
        GetPlayerName(playerid,name2,sizeof(name2));
        format(tmp,sizeof(tmp),"Player %s (id:%d) whants to CAR DANCE! he bets $%d ",name2,playerid,MoneyBet);
		SendClientMessageToAll(COLOR_YELLOW,tmp);
        SendClientMessageToAll(COLOR_YELLOW,"If you wants to challenge him, find him");
        SendClientMessage(playerid,COLOR_GREEN,"To start DANCE use /start and everyone in 25 mts around you will be in the contest");
        return 1;
	}
 	if 	(strcmp(cmd, "/start", true)==0){
		if  (host!=playerid){
		    SendClientMessage(playerid,COLOR_RED,"You are not the organizer of the competition, you can start it.");
		    return 1;
		}
		if	(!IsPlayerInAnyVehicle(playerid)){
			SendClientMessage(playerid, COLOR_WHITE, "You must be in a car to be able to start the car dance competition...");
			return 1;
		}
		host=-2;
		prize=0;
		paso=0;
		for (new i=0;i<MAX_PLAYERS;i++){
		    if  (IsPlayerConnected(i)){
		        if  ((GetDistanceBetweenPlayers(playerid,i)<25.0)&&(GetPlayerState(i)==PLAYER_STATE_DRIVER)){
			        GivePlayerMoney(i,-MoneyBet);
			        prize=prize+MoneyBet;
			        score[i]=0;
			        GameTextForPlayer(i,"~g~GET READY... ~n~~b~GO!!!",2000,3);
			        PlayerIsDancing[i]=1;
		        }
		    }
		}
        TimerBaile=SetTimer("UpdatePasos",500,1);
		return 1;
	}
 	if 	(strcmp(cmd, "/pasarsec", true)==0){
		TimerBaile=SetTimer("UpdatePasos",250,1);
		PlayerIsDancing[playerid]=1;
		return 1;
	}
    return 0;
}
strtok(const string[], &index){
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' ')){
		index++;
	}
	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))){
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
