//FS de Facebook By davidxxx Version 2.0
//Gracias al fs de zamaroth
//Gracias a chaoz por codigo de obtener jugadores
//Gracias a josta por sugerencias y color del facebook
//Gracias a Nick123 por la idea del chat y tester
//Gracias a SuperMarioRol por la idea del chat solo para los que tengan activo el facebook
//Gracias a TiNcH010 por explicacion y enseñanza de algunos codigos
//Gracias a Edugta por beta tester


/*
===================================================================================================================
DDDD                 AAA      VV               VV  IIIIIIIIIIIIII   DDDD
DD   DD             AA AA      VV             VV   IIIIIIIIIIIIII   DD   DD
DD      DD         AA   AA      VV           VV          II         DD      DD    XX    XX  XX    XX  XX    XX
DD       DD       AA AAA AA      VV         VV           II         DD       DD    XX  XX    XX  XX    XX  XX
DD       DD      AA AAAAA AA      VV       VV            II         DD       DD     XXXX      XXXX      XXXX
DD       DD     AA         AA      VV     VV             II         DD       DD      XX        XX        XX
DD      DD     AA           AA      VV   VV              II         DD      DD      XXXX      XXXX      XXXX
DD   DD       AA             AA      VV VV         IIIIIIIIIIIIII   DD   DD        XX  XX    XX  XX    XX  XX
DDDD         AA               AA      VVV          IIIIIIIIIIIIII   DDDD          XX    XX  XX    XX  XX    XX
===================================================================================================================
*/


#define FILTERSCRIPT

#include <a_samp>

//news
new ver[MAX_PLAYERS];
new msj[MAX_PLAYERS];

new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3[MAX_PLAYERS];
new Text:Textdraw4;
new Text:Textdraw5;
new Text:Textdraw6;
new Text:Textdraw7;
new Text:Textdraw8;
new Text:Textdraw9;
new Text:Textdraw10;
new Text:Textdraw11;
new Text:Textdraw12;
new Text:Textdraw14;
//logo
new Text:Textdraw15;
new Text:Textdraw16;
new Text:Textdraw17;
//fin

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
print("\n--------------------------------------");
print(" FS Facebook by Davidxxx");
print("--------------------------------------\n");

Textdraw0 = TextDrawCreate(130.000000, 1.000000, "facebook");
TextDrawBackgroundColor(Textdraw0, 255);
TextDrawFont(Textdraw0, 1);
TextDrawLetterSize(Textdraw0, 0.439999, 2.000001);
TextDrawColor(Textdraw0, -1);
TextDrawSetOutline(Textdraw0, 0);
TextDrawSetProportional(Textdraw0, 1);
TextDrawSetShadow(Textdraw0, 1);
TextDrawUseBox(Textdraw0, 1);
TextDrawBoxColor(Textdraw0, 0x3b5998ff);
TextDrawTextSize(Textdraw0, 643.000000, -56.000000);

Textdraw1 = TextDrawCreate(-3.000000, -5.000000, "_");
TextDrawBackgroundColor(Textdraw1, 255);
TextDrawFont(Textdraw1, 1);
TextDrawLetterSize(Textdraw1, 0.519999, 3.099999);
TextDrawColor(Textdraw1, -1);
TextDrawSetOutline(Textdraw1, 0);
TextDrawSetProportional(Textdraw1, 1);
TextDrawSetShadow(Textdraw1, 1);
TextDrawUseBox(Textdraw1, 1);
TextDrawBoxColor(Textdraw1, 0x3b5998ff);
TextDrawTextSize(Textdraw1, 643.000000, 0.000000);

Textdraw2 = TextDrawCreate(222.000000, 7.000000, "Buscar");
TextDrawBackgroundColor(Textdraw2, 255);
TextDrawFont(Textdraw2, 1);
TextDrawLetterSize(Textdraw2, 0.239999, 1.199999);
TextDrawColor(Textdraw2, -236);
TextDrawSetOutline(Textdraw2, 0);
TextDrawSetProportional(Textdraw2, 1);
TextDrawSetShadow(Textdraw2, 1);
TextDrawUseBox(Textdraw2, 1);
TextDrawBoxColor(Textdraw2, -1);
TextDrawTextSize(Textdraw2, 336.000000, 0.000000);

Textdraw4 = TextDrawCreate(505.000000, 2.000000, "l");
TextDrawBackgroundColor(Textdraw4, 255);
TextDrawFont(Textdraw4, 1);
TextDrawLetterSize(Textdraw4, 0.150000, 2.299998);
TextDrawColor(Textdraw4, -1);
TextDrawSetOutline(Textdraw4, 0);
TextDrawSetProportional(Textdraw4, 1);
TextDrawSetShadow(Textdraw4, 1);

Textdraw5 = TextDrawCreate(546.000000, 2.000000, "l");
TextDrawBackgroundColor(Textdraw5, 255);
TextDrawFont(Textdraw5, 1);
TextDrawLetterSize(Textdraw5, 0.150000, 2.299998);
TextDrawColor(Textdraw5, -1);
TextDrawSetOutline(Textdraw5, 0);
TextDrawSetProportional(Textdraw5, 1);
TextDrawSetShadow(Textdraw5, 1);

Textdraw6 = TextDrawCreate(513.000000, 7.000000, "Inicio");
TextDrawBackgroundColor(Textdraw6, 255);
TextDrawFont(Textdraw6, 1);
TextDrawLetterSize(Textdraw6, 0.310000, 1.299999);
TextDrawColor(Textdraw6, -1);
TextDrawSetOutline(Textdraw6, 0);
TextDrawSetProportional(Textdraw6, 1);
TextDrawSetShadow(Textdraw6, 1);

Textdraw7 = TextDrawCreate(554.000000, 9.000000, "v");
TextDrawBackgroundColor(Textdraw7, 255);
TextDrawFont(Textdraw7, 3);
TextDrawLetterSize(Textdraw7, 0.269999, 1.100000);
TextDrawColor(Textdraw7, -1);
TextDrawSetOutline(Textdraw7, 0);
TextDrawSetProportional(Textdraw7, 1);
TextDrawSetShadow(Textdraw7, 1);

Textdraw10 = TextDrawCreate(519.000000, 431.000000, "Conectados");
TextDrawBackgroundColor(Textdraw10, 255);
TextDrawFont(Textdraw10, 1);
TextDrawLetterSize(Textdraw10, 0.370000, 1.600000);
TextDrawColor(Textdraw10, -1);
TextDrawSetOutline(Textdraw10, 0);
TextDrawSetProportional(Textdraw10, 1);
TextDrawSetShadow(Textdraw10, 1);
TextDrawUseBox(Textdraw10, 1);
TextDrawBoxColor(Textdraw10, -926365496);
TextDrawTextSize(Textdraw10, 622.000000, -8.000000);

Textdraw12 = TextDrawCreate(503.000000, 431.000000, "_");
TextDrawBackgroundColor(Textdraw12, 255);
TextDrawFont(Textdraw12, 1);
TextDrawLetterSize(Textdraw12, 0.370000, 1.600000);
TextDrawColor(Textdraw12, -1);
TextDrawSetOutline(Textdraw12, 0);
TextDrawSetProportional(Textdraw12, 1);
TextDrawSetShadow(Textdraw12, 1);
TextDrawUseBox(Textdraw12, 1);
TextDrawBoxColor(Textdraw12, -926365496);
TextDrawTextSize(Textdraw12, 622.000000, -8.000000);

Textdraw11 = TextDrawCreate(501.000000, 414.000000, ".");
TextDrawBackgroundColor(Textdraw11, 255);
TextDrawFont(Textdraw11, 1);
TextDrawLetterSize(Textdraw11, 1.040001, 3.799997);
TextDrawColor(Textdraw11, 16711935);
TextDrawSetOutline(Textdraw11, 0);
TextDrawSetProportional(Textdraw11, 0);
TextDrawSetShadow(Textdraw11, 1);

Textdraw14 = TextDrawCreate(591.000000, 430.000000, "()");
TextDrawBackgroundColor(Textdraw14, 255);
TextDrawFont(Textdraw14, 1);
TextDrawLetterSize(Textdraw14, 0.370000, 1.600000);
TextDrawColor(Textdraw14, -1);
TextDrawSetOutline(Textdraw14, 0);
TextDrawSetProportional(Textdraw14, 1);
TextDrawSetShadow(Textdraw14, 1);

//logo facebook
Textdraw16 = TextDrawCreate(580.000000, 31.000000, "_");
TextDrawBackgroundColor(Textdraw16, 255);
TextDrawFont(Textdraw16, 1);
TextDrawLetterSize(Textdraw16, 0.689998, 3.299998);
TextDrawColor(Textdraw16, -1);
TextDrawSetOutline(Textdraw16, 0);
TextDrawSetProportional(Textdraw16, 1);
TextDrawSetShadow(Textdraw16, 1);
TextDrawUseBox(Textdraw16, 1);
TextDrawBoxColor(Textdraw16, 23240);
TextDrawTextSize(Textdraw16, 563.000000, 10.000000);

Textdraw15 = TextDrawCreate(580.000000, 31.000000, "f");
TextDrawBackgroundColor(Textdraw15, 255);
TextDrawFont(Textdraw15, 1);
TextDrawLetterSize(Textdraw15, 0.689998, 3.299998);
TextDrawColor(Textdraw15, -1);
TextDrawSetOutline(Textdraw15, 0);
TextDrawSetProportional(Textdraw15, 1);
TextDrawSetShadow(Textdraw15, 1);
TextDrawUseBox(Textdraw15, 1);
TextDrawBoxColor(Textdraw15, 23240);
TextDrawTextSize(Textdraw15, 592.000000, 10.000000);

Textdraw17 = TextDrawCreate(595.000000, 51.000000, "_");
TextDrawBackgroundColor(Textdraw17, 255);
TextDrawFont(Textdraw17, 1);
TextDrawLetterSize(Textdraw17, 0.689998, 0.799998);
TextDrawColor(Textdraw17, -1);
TextDrawSetOutline(Textdraw17, 0);
TextDrawSetProportional(Textdraw17, 1);
TextDrawSetShadow(Textdraw17, 1);
TextDrawUseBox(Textdraw17, 1);
TextDrawBoxColor(Textdraw17, 65360);
TextDrawTextSize(Textdraw17, 565.000000, -19.000000);
return 1;
}



public OnFilterScriptExit()
{
TextDrawHideForAll(Textdraw0);
TextDrawDestroy(Textdraw0);
TextDrawHideForAll(Textdraw1);
TextDrawDestroy(Textdraw1);
TextDrawHideForAll(Textdraw2);
TextDrawDestroy(Textdraw2);
TextDrawHideForAll(Textdraw4);
TextDrawDestroy(Textdraw4);
TextDrawHideForAll(Textdraw5);
TextDrawDestroy(Textdraw5);
TextDrawHideForAll(Textdraw6);
TextDrawDestroy(Textdraw6);
TextDrawHideForAll(Textdraw7);
TextDrawDestroy(Textdraw7);
TextDrawHideForAll(Textdraw8);
TextDrawDestroy(Textdraw8);
TextDrawHideForAll(Textdraw9);
TextDrawDestroy(Textdraw9);
TextDrawHideForAll(Textdraw10);
TextDrawDestroy(Textdraw10);
TextDrawHideForAll(Textdraw11);
TextDrawDestroy(Textdraw11);
TextDrawHideForAll(Textdraw12);
TextDrawDestroy(Textdraw12);
TextDrawHideForAll(Textdraw14);
TextDrawDestroy(Textdraw14);
//logo facebook
TextDrawHideForAll(Textdraw15);
TextDrawDestroy(Textdraw15);
TextDrawHideForAll(Textdraw16);
TextDrawDestroy(Textdraw16);
TextDrawHideForAll(Textdraw17);
TextDrawDestroy(Textdraw17);
return 1;
}

#else

main()
{
print("\n----------------------------------");
print(" FS Facebook by Davidxxx");
print("----------------------------------\n");
}

#endif

public OnPlayerConnect(playerid)
{
msj[playerid] = 0;
Textdraw3[playerid] = TextDrawCreate(380.000000, 6.000000, "nombre");
TextDrawBackgroundColor(Textdraw3[playerid], 255);
TextDrawFont(Textdraw3[playerid], 1);
TextDrawLetterSize(Textdraw3[playerid], 0.300000, 1.399999);
TextDrawColor(Textdraw3[playerid], -1);
TextDrawSetOutline(Textdraw3[playerid], 0);
TextDrawSetProportional(Textdraw3[playerid], 1);
TextDrawSetShadow(Textdraw3[playerid], 1);
return 1;
}



public OnPlayerDisconnect(playerid, reason)
{
TextDrawHideForPlayer(playerid, Textdraw0);
TextDrawHideForPlayer(playerid, Textdraw1);
TextDrawHideForPlayer(playerid, Textdraw2);
TextDrawHideForPlayer(playerid, Textdraw3[playerid]);
TextDrawHideForPlayer(playerid, Textdraw4);
TextDrawHideForPlayer(playerid, Textdraw5);
TextDrawHideForPlayer(playerid, Textdraw6);
TextDrawHideForPlayer(playerid, Textdraw7);
TextDrawHideForPlayer(playerid, Textdraw8);
TextDrawHideForPlayer(playerid, Textdraw9);
TextDrawHideForPlayer(playerid, Textdraw10);
TextDrawHideForPlayer(playerid, Textdraw11);
TextDrawHideForPlayer(playerid, Textdraw12);
TextDrawHideForPlayer(playerid, Textdraw14);
TextDrawHideForPlayer(playerid, Textdraw15);
TextDrawHideForPlayer(playerid, Textdraw16);
TextDrawHideForPlayer(playerid, Textdraw17);
StopAudioStreamForPlayer(playerid);
ver[playerid] = 0;
return 1;
}





public OnPlayerCommandText(playerid, cmdtext[])
{
//actualizar conteo
new str[100];
format(str,sizeof(str),"(%i)",PlayersInFacebook());
TextDrawSetString(Textdraw14, str);//conteo

//comando
if (strcmp("/facebook", cmdtext, true, 10) == 0)
{
if(ver[playerid] == 0)
{
ShowPlayerDialog(playerid,20,DIALOG_STYLE_MSGBOX,"Bienvenid@ A {0000FF}Facebook","Hola usuario bienvenido\nal sistema de facebook\nusa /stop para parar la musica\nespero que lo disfrutes =)","Gracias","");
TextDrawSetString(Textdraw3[playerid], NombreJugador(playerid));//nombre
//logo
TextDrawShowForPlayer(playerid, Textdraw15);
TextDrawShowForPlayer(playerid, Textdraw17);
TextDrawShowForPlayer(playerid, Textdraw16);
//fin
TextDrawShowForPlayer(playerid, Textdraw0);
TextDrawShowForPlayer(playerid, Textdraw1);
TextDrawShowForPlayer(playerid, Textdraw2);
TextDrawShowForPlayer(playerid, Textdraw3[playerid]);
TextDrawShowForPlayer(playerid, Textdraw4);//actualizacion para todos lo que esten conectados
TextDrawShowForPlayer(playerid, Textdraw5);
TextDrawShowForPlayer(playerid, Textdraw6);
TextDrawShowForPlayer(playerid, Textdraw7);
TextDrawShowForPlayer(playerid, Textdraw8);
TextDrawShowForPlayer(playerid, Textdraw9);
TextDrawShowForPlayer(playerid, Textdraw12);
TextDrawShowForPlayer(playerid, Textdraw10);
TextDrawShowForPlayer(playerid, Textdraw11);
TextDrawShowForPlayer(playerid, Textdraw14);
ver[playerid] = 1;
PlayAudioStreamForPlayer(playerid,"http://dc197.4shared.com/img/804769884/b598b320/dlink__2Fdownload_2F8n4fIdYS_3Ftsid_3D00000000-000000-00000000/preview.mp3");
SetTimer("actualizar",1000,true);
}
else
{
TextDrawHideForPlayer(playerid, Textdraw0);
TextDrawHideForPlayer(playerid, Textdraw1);
TextDrawHideForPlayer(playerid, Textdraw2);
TextDrawHideForPlayer(playerid, Textdraw3[playerid]);
TextDrawHideForPlayer(playerid, Textdraw4);
TextDrawHideForPlayer(playerid, Textdraw5);
TextDrawHideForPlayer(playerid, Textdraw6);
TextDrawHideForPlayer(playerid, Textdraw7);
TextDrawHideForPlayer(playerid, Textdraw8);
TextDrawHideForPlayer(playerid, Textdraw9);
TextDrawHideForPlayer(playerid, Textdraw10);
TextDrawHideForPlayer(playerid, Textdraw11);
TextDrawHideForPlayer(playerid, Textdraw12);
TextDrawHideForPlayer(playerid, Textdraw14);
//logo
TextDrawHideForPlayer(playerid, Textdraw15);
TextDrawHideForPlayer(playerid, Textdraw16);
TextDrawHideForPlayer(playerid, Textdraw17);
//fin
ver[playerid] = 0;
StopAudioStreamForPlayer(playerid);
}
return 1;
}

if(strcmp(cmdtext, "/stop",true) == 0)
{
StopAudioStreamForPlayer(playerid);
return 1;
}
return 0;
}





forward actualizar();
public actualizar()
{
new str[100];
format(str,sizeof(str),"(%i)",PlayersInFacebook());
TextDrawSetString(Textdraw14, str);//conteo
return 1;
}





//texto
public OnPlayerText(playerid, text[])
{
if(text[0] == '&')
{
if(ver[playerid] == 1)
{
if(msj[playerid] == 1)
{
SendClientMessage(playerid, -1, "{FB1D1D}ERROR{FFFFFF}: Solo puedes poner un mensaje cada 2 segundo");
SetTimer("TimeText",2000,false);
return 0;
}
new string[126];
GetPlayerName(playerid,string,sizeof(string));
format(string,sizeof(string),"{1353DB}Chat Facebook{FFFFFF}: %s{0C53BC}: %s",string,text[1]);
MsgToFa(0x0000FFFF,string);
msj[playerid] = 1;
}else{
SendClientMessage(playerid,-1,"{FB1D1D}ERROR{FFFFFF}: Debes Tener Activado Facebook");
}
return 0;
}
return 1;
}




forward TimeText(playerid);
public TimeText(playerid)
{
if(msj[playerid] == 1)
{
msj[playerid] = 0;
}
return 1;
}




//texto a conectados en facebook
forward MsgToFa(color,const string[]);
public MsgToFa(color,const string[])
{
for(new i=0;i<MAX_PLAYERS;i++)
{
if(IsPlayerConnected(i)) if(ver[i] == 1) SendClientMessage(i,-1,string),PlayAudioStreamForPlayer(i,"http://k003.kiwi6.com/hotlink/u97j3w1vb6/facebook_chat_sound.mp3");
}
return 1;
}



//responder dialogo
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
switch(dialogid)
{
case 20:
{
if(!response)
{
return 1;
}
}
}
return 1;
}





//obtener nombre gracias a TiNcH010
stock NombreJugador(playerid)
{
    new Nombre[24];
    GetPlayerName(playerid,Nombre,24);
    new N[24];
    strmid(N,Nombre,0,strlen(Nombre),24);
    for(new i = 0; i < MAX_PLAYER_NAME; i++)
    {
        if (N [i] == '_') N[i] = ' ';
    }
    return N;
}

//funcion gracias a davidxxx xD
PlayersInFacebook()
{
new obt;
for(new d=0;d<MAX_PLAYERS;d++)if(ver[d]== 1)obt++;
return obt--;
}

//funcion obtiene jugadores conectados opcional borrarla

GetConnectedPlayers()// gracias a chaoz por este codigo
{
new count;
for(new i, j=GetMaxPlayers(); i<j; i++)if(IsPlayerConnected(i))count++;
return count;
}