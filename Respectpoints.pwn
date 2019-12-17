// // // // // // // // // // // // // // // // // // // // // // // // // // // //
//            `:yh:                                        .sho-                 //
//         ``oNMd.           .:oyhmNMMMMMMMmdhs+-`           :mMm: -             //
//      `sm-dMNs         .+hNNyoyMMMMMMMMMMMMd+shNmy/`        `hMMy/m/           //
//     -NM+hNy/s      `+mNy+.  -MMMMMMMMMMMMMM+   -odNh/`     :s/dMosMy          //
//   .`hMN.o+hN/    -yMh:`     +MMMMMMMMMMMMMMs      `+dNo`    oNs+o.MMo:`       //
//  :N-MM/sNMy`   .hMy.        `dMMMMMMMMMMMMN-         :dNo    /NMm+dMh+d`      //
// .NM.MNNNs-    /Nd.            sMMMMMMMMMMh`            /Nm-   `+yNNMh.Mh      //
// oMM.MN+/d/   sMs             `:yMMMMMMMMm:.             `dM/  `ms:yMh+MM.     //
// oMM/o+mMh   yM+            .dMMMMMMMMMMMMMMd-             hM/  `mMy++yMM-     //
// oMM+yMMy   oMs             `oNMMMMMMMMMMMMNs               dM-  `dMN/hMM..    //
//m.MMhMm/-  .Mm                 -/hMMMMMMd/-                 .Mm   :sMMNMy:d    //
//M-:MMm`ds  sM:                    MMMMMm                     yM:  m:/MMN`sM    //
//Md`ym.dM:  mN                     MMMMMm                     -Ms  sN//M/:MM    //
//MMd-.hMN   mm                    +MMMMMM+                    -Ms  -MM+-:NMd    //
//yMMyoMM-   mm                   -NMMMMMMM-                   -Ms   dMM-dMM:    //
//.NMNyMy-o  dN`                 `dMMMMMMMMN-                  /Mo `o-MMmMMo-    //
//h.yMNN.sN` +Mo                .dMMMMMMMMMMN-                 dM. +N`yMMN/:N    //
//Nm-:mm NM: `mN.            -shNMMMMMMMMMMMMMhs:             /My  hM:+Md.+Ny    //
///MMh-s-MMs  :Md`          +MMMMMMMMMMMMMMMMMMMMo           .Nm`  NMs:o/mMm`    //
// +MMNo-MMy:o /Mh`        -dMMMMMMMMMMMMMMMMMMMMm:         -Nm.-o.MMs-dMMd`     //
//  .yMMhmMd`Ny.:Nm.     `hMMMMMMMMMMMMMMMMMMMMMMMMm-      /Nd.:M:/MNsMMN+`      //
//  +s.sNMMM.hMd .hMo`   dMMMMMMMMMMMMMMMMMMMMMMMMMMN-   .hMo /MM dMMMh/.y.      //
//   smo.:sNs+MMs  /dNo` mMMMMMMMMMMMMMMMMMMMMMMMMMMM: .yMy- .MMy/Md+.:hN:       //
//    /NMds:/`mMM-o- /dNyNMMMMMMMMMMMMMMMMMMMMMMMMMMMyhNy-.s.NMN-::+hMMy.        //
//     `+mMMMh+hMd-Nm/ .odMMMMMMMMMMMMMMMMMMMMMMMMMMMh+`-yN/sMmoyNMMMy.          //
//        -ohNMMmMh:mMm-  `/sdNMMMMMMMMMMMMMMMMMNho:` -hMM+sMMmMMmh/`            //
//        .so:-::/oo.oNMh/`    .:+oyyyyyyyys+/-`    -hMNd:/s+/:-:+y+             //
//          :yMMNNmdddymMMNy+` .-////-..-:///:.` +yNMMmhhdddNNNMdo`              //
//             -+oyyyyso+:-:sdNMNy++yNhyNmo/yNMMdy/--/osyyyyso/`                 //
//              .oo++++symMMMNh+-smd/`   :yNs-:yNMMMNhs++/+o+.                   //
//                `/ohdmmdho:`:dNs.        .yMmo`:oyhmmmhs+.                     //
//                           yMh-            .yMh`                               //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
#include                                                             <  a_samp > // http://www.sa-mp.com/
#include                                                             <   zcmd  > // http://forum.sa-mp.com/showthread.php?t=91354
#include                                                             <   dini  > // http://forum.sa-mp.com/showthread.php?t=50
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
#define SPD                                                     ShowPlayerDialog //
#define SCM                                                    SendClientMessage //
#define OPC                                                      OnPlayerConnect //
#define OPD                                                   OnPlayerDisconnect //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
#define RespectFile                                                 "RPS/%s.ini" //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
enum PLAYER_MAIN                                                                 //
{                                                                                //
   GRespect,                                                                     //
   BRespect                                                                      //
}                                                                                //
new pInfo       [MAX_PLAYERS][PLAYER_MAIN];                                      //
new ChosenPlayer[MAX_PLAYERS];                                                   //
new timer       [MAX_PLAYERS];                                                   //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
public OPC ( playerid )         { LoadPlayerRespect( playerid ) ; return 1 ; }   //
public OPD ( playerid , reason) { SavePlayerRespect( playerid ) ; return 1 ; }   //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
public OnPlayerClickPlayer ( playerid, clickedplayerid, source ) {               //
    if(timer[playerid] > 0) return SCM( playerid , 0xFFFFFFFF ,                  //
	                       "You can give just one reputation point at 1 hour."); //
	new drespect[ 128 ];                                                         //
	strcat ( drespect , "Add respect point to clicked player.\n" ) ;             //
	strcat ( drespect , "Select the type of respect point:" ) ;                  //
	SPD ( playerid , 1 , DIALOG_STYLE_MSGBOX , " " , drespect , "+" , "-" ) ;    //
	ChosenPlayer[playerid] = clickedplayerid;                                    //
	return 1; }                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
public OnDialogResponse (playerid, dialogid, response, listitem, inputtext[] ) { //
	if(dialogid == 1) {                                                          //
		if(response) {                                                           //
		  pInfo[ChosenPlayer[playerid]][GRespect] += 1;                          //
		  timer[playerid] = SetTimerEx("timer1",86400000,true,"i",playerid);     //
		} else {                                                                 //
          pInfo[ChosenPlayer[playerid]][BRespect] -= 1;                          //
          timer[playerid] = SetTimerEx("timer1",86400000,true,"i",playerid);     //
		}                                                                        //
		return 1;                                                                //
	}                                                                            //
	return 0; }                                                                  //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
stock LoadPlayerRespect ( playerid ) {                                           //
    new file [ 128 ] , name [ MAX_PLAYER_NAME ] ;                                //
	GetPlayerName ( playerid , name , sizeof(name)) ;                            //
    format ( file , sizeof(file) , RespectFile,name) ;                           //
    if(!dini_Exists(file)) {                                                     //
    dini_Create(file) ;                                                          //
    dini_IntSet(file,"GRespect", pInfo[playerid][GRespect]) ;                    //
	dini_IntSet(file,"BRespect", pInfo[playerid][BRespect]) ; }                  //
    pInfo[playerid][GRespect] = dini_Int(file,"GRespect") ;                      //
    pInfo[playerid][BRespect] = dini_Int(file,"BRespect") ;                      //
    return 1 ; }                                                                 //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
stock SavePlayerRespect ( playerid ) {                                           //
    new file [ 128 ] , name[ MAX_PLAYER_NAME ] ;                                 //
	GetPlayerName ( playerid , name , sizeof(name)) ;                            //
	format ( file , sizeof(file) , RespectFile,name) ;                           //
	dini_IntSet(file,"GRespect", pInfo[playerid][GRespect]) ;                    //
	dini_IntSet(file,"BRespect", pInfo[playerid][BRespect]) ;                    //
	return 1 ; }                                                                 //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
CMD:myrespect( playerid , params[] ) {                                           //
	new mrespect[126];                                                           //
	format ( mrespect , sizeof(mrespect) , "Respect: +%d/%d" ,                   //
                                                     pInfo[playerid][GRespect] , //
                                                     pInfo[playerid][BRespect]); //
	SCM(playerid, 0xFFFFFFFF, mrespect);                                         //
	return 1 ; }                                                                 //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
forward timer1 ( playerid ) ;                                                    //
public timer1( playerid ) {                                                      //
        timer[playerid] = 0;                                                     //
        return 1; }                                                              //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //
// (C) 2013 - Pawno Legacy Team                                                  //
// (C) 2013 - DarkyTheAngel & Hardwell                                           //
// // // // // // // // // // // // // // // // // // // // // // // // // // // //