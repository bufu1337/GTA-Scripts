#include <a_samp> // Load Anim Lib + LMB Sets /animhelp

#define ALLOW_VEHICLES 1        // Allow animations in vehicle?
#define COLOR_ANIM 0xDDDD2357   // COLOR
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new Text: anim1, Text: anim2, Text: anim3, Text: anim4, Text: anim5, Text: anim6, Text: anim7, Text: anim8;
new bool: iSeeAnimations[MAX_PLAYERS] = {false,...};
new Float:fifa[MAX_PLAYERS] = {4.1,...};
new bool: O1[MAX_PLAYERS] = {false,...};
new bool: O2[MAX_PLAYERS] = {true,...};
new bool: O3[MAX_PLAYERS] = {true,...};
new bool: O4[MAX_PLAYERS] = {true,...};
new O5[MAX_PLAYERS] = {true,...};
new bool: Freeze[MAX_PLAYERS];
new lang = 1;
new notf = 1;
new aid;

public OnFilterScriptInit() {
	print("[FS] All Animations 0.4 by Psycho loaded.");
	anim1 = TextDrawCreate(70.000000,120.000000,"~r~[FS]All Animations v0.4 by Psycho. Press LMB to hide list.~n~~y~/animair~n~/animattr~n~/animbar~n~/animbball~n~/animbdfire~n~/animbeach~n~/animbpress~n~/animbfinf~n~/animbiked~n~/animbikeh~n~/animbikeleap~n~/animbikes~n~/animbikev~n~/animbikedbz~n~/animbmx~n~/animbomber~n~/animbox");
	TextDrawAlignment(anim1,0); TextDrawBackgroundColor(anim1,0x000000ff); TextDrawFont(anim1,1); TextDrawLetterSize(anim1,0.2,1.1); TextDrawColor(anim1,0xffffffff); TextDrawSetOutline(anim1,1); TextDrawSetProportional(anim1,1); TextDrawSetShadow(anim1,1);
 	anim2 = TextDrawCreate(130.000000,120.000000,"~y~~n~/animbasket~n~/animbuddy~n~/animbus~n~/animcamera~n~/animcar~n~/animcarry~n~/animcarchat~n~/animcasino~n~/animchainsaw~n~/animcho~n~/animclo~n~/animcoach~n~/animcolt~n~/animcopamb~n~/animcopdv~n~/animcrack~n~/animcrib");
	TextDrawAlignment(anim2,0); TextDrawBackgroundColor(anim2,0x000000ff); TextDrawFont(anim2,1); TextDrawLetterSize(anim2,0.2,1.1); TextDrawColor(anim2,0xffffffff); TextDrawSetOutline(anim2,1); TextDrawSetProportional(anim2,1); TextDrawSetShadow(anim2,1);
 	anim3 = TextDrawCreate(190.000000,120.000000,"~y~~n~/animdamj~n~/animdealer~n~/animdildo~n~/animdodge~n~/animdozer~n~/animdrivebys~n~/animfat~n~/animfightb~n~/animfightc~n~/animfightd~n~/animfighte~n~/animfin~n~/animfintwo~n~/animflame~n~/animflowers~n~/animfood~n~/animfwe");
	TextDrawAlignment(anim3,0); TextDrawBackgroundColor(anim3,0x000000ff); TextDrawFont(anim3,1); TextDrawLetterSize(anim3,0.2,1.1); TextDrawColor(anim3,0xffffffff); TextDrawSetOutline(anim3,1); TextDrawSetProportional(anim3,1); TextDrawSetShadow(anim3,1);
 	anim4 = TextDrawCreate(250.000000,120.000000,"~y~~n~/animgangs~n~/animghands~n~/animghettodb~n~/animgoggles~n~/animgraf~n~/animgraveyard~n~/animgrenade~n~/animgym~n~/animhair~n~/animheist~n~/animinthouse~n~/animintoff~n~/animintshop~n~/animjstb~n~/animkart~n~/animkiss~n~/animknife");
	TextDrawAlignment(anim4,0); TextDrawBackgroundColor(anim4,0x000000ff); TextDrawFont(anim4,1); TextDrawLetterSize(anim4,0.2,1.1); TextDrawColor(anim4,0xffffffff); TextDrawSetOutline(anim4,1); TextDrawSetProportional(anim4,1); TextDrawSetShadow(anim4,1);
 	anim5 = TextDrawCreate(310.000000,120.000000,"~y~~n~/animlapdan~n~/animlowrider~n~/animdchase~n~/animdend~n~/animmedic~n~/animmisc~n~/animtb~n~/animmcar~n~/animnevada~n~/animlookers~n~/animotb~n~/animpara~n~/animpark~n~/animpamac~n~/animped~n~/animpdvbys~n~/animplayidles");
	TextDrawAlignment(anim5,0); TextDrawBackgroundColor(anim5,0x000000ff); TextDrawFont(anim5,1); TextDrawLetterSize(anim5,0.2,1.1); TextDrawColor(anim5,0xffffffff); TextDrawSetOutline(anim5,1); TextDrawSetProportional(anim5,1); TextDrawSetShadow(anim5,1);
 	anim6 = TextDrawCreate(370.000000,120.000000,"~y~~n~/animpolice~n~/animpool~n~/animpoor~n~/animpython~n~/animquad~n~/animquadbz~n~/animrifle~n~/animriot~n~/animrobbank~n~/animrocket~n~/animryder~n~/animscratching~n~/animshamal~n~/animshop~n~/animshotgun~n~/animsilenced~n~/animskate");
	TextDrawAlignment(anim6,0); TextDrawBackgroundColor(anim6,0x000000ff); TextDrawFont(anim6,1); TextDrawLetterSize(anim6,0.2,1.1); TextDrawColor(anim6,0xffffffff); TextDrawSetOutline(anim6,1); TextDrawSetProportional(anim6,1); TextDrawSetShadow(anim6,1);
	anim7 = TextDrawCreate(430.000000,120.000000,"~y~~n~/animsmoking~n~/animsniper~n~/animsex~n~/animspraycan~n~/animstrip~n~/animsunbathe~n~/animswat~n~/animsweet~n~/animswim~n~/animsword~n~/animtank~n~/animtattoo~n~/animtec~n~/animtrain~n~/animtruck~n~/animuzi~n~/animvan");
	TextDrawAlignment(anim7,0); TextDrawBackgroundColor(anim7,0x000000ff); TextDrawFont(anim7,1); TextDrawLetterSize(anim7,0.2,1.1); TextDrawColor(anim7,0xffffffff); TextDrawSetOutline(anim7,1); TextDrawSetProportional(anim7,1); TextDrawSetShadow(anim7,1);
	anim8 = TextDrawCreate(490.000000,120.000000,"~y~~n~/animvedding~n~/animvortex~n~/animwayfarer~n~/animweapons~n~/animwuzi~n~/animblowjob~n~~n~~n~~n~~n~~g~Settings~n~~r~/animcpo1~n~/animcpo2~n~/animcpo3~n~/animcpo4~n~/animcpo5~n~/standard");
	TextDrawAlignment(anim8,0); TextDrawBackgroundColor(anim8,0x000000ff); TextDrawFont(anim8,1); TextDrawLetterSize(anim8,0.2,1.1); TextDrawColor(anim8,0xffffffff); TextDrawSetOutline(anim8,1); TextDrawSetProportional(anim8,1); TextDrawSetShadow(anim8,1);
	return 1; }

public OnFilterScriptExit() {
	print("[FS] All Animations 0.4 by Psycho unloaded.");
	TextDrawDestroy(anim1);
	TextDrawDestroy(anim2);
	TextDrawDestroy(anim3);
	TextDrawDestroy(anim4);
	TextDrawDestroy(anim5);
	TextDrawDestroy(anim6);
	TextDrawDestroy(anim7);
	TextDrawDestroy(anim8);
	return 1; }

public OnPlayerDeath(playerid,killerid,reason) { Freeze[playerid] = false; return 1; }
public OnPlayerDisconnect(playerid,reason) { Freeze[playerid] = false; OnPlayerCommandText(playerid,"/standart"); return 1; }


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if (newkeys == KEY_FIRE) {
		TextDrawHideForPlayer(playerid,anim1); TextDrawHideForPlayer(playerid,anim2);
		TextDrawHideForPlayer(playerid,anim3); TextDrawHideForPlayer(playerid,anim4);
		TextDrawHideForPlayer(playerid,anim5); TextDrawHideForPlayer(playerid,anim6);
		TextDrawHideForPlayer(playerid,anim7); TextDrawHideForPlayer(playerid,anim8);
		iSeeAnimations[playerid] = false;
	} return 1; }

public OnPlayerCommandText(playerid, cmdtext[]) {
    dcmd(standard,8,cmdtext);
    dcmd(animcpo1,8,cmdtext);
    dcmd(animcpo2,8,cmdtext);
    dcmd(animcpo3,8,cmdtext);
    dcmd(animcpo4,8,cmdtext);
	dcmd(animcpo5,8,cmdtext);
	dcmd(animfloat,9,cmdtext);
	dcmd(animair,7,cmdtext);
	dcmd(animattr,8,cmdtext);
	dcmd(animbar,7,cmdtext);
	dcmd(animbball,9,cmdtext);
	dcmd(animbdfire,10,cmdtext);
	dcmd(animbeach,9,cmdtext);
	dcmd(animbpress,10,cmdtext);
	dcmd(animbfinf,9,cmdtext);
	dcmd(animbiked,9,cmdtext);
	dcmd(animbikeh,9,cmdtext);
	dcmd(animbikeleap,12,cmdtext);
	dcmd(animbikes,9,cmdtext);
	dcmd(animbikev,9,cmdtext);
	dcmd(animbikedbz,11,cmdtext);
	dcmd(animbmx,7,cmdtext);
	dcmd(animbomber,10,cmdtext);
	dcmd(animbox,7,cmdtext);
	dcmd(animbasket,10,cmdtext);
	dcmd(animbuddy,9,cmdtext);
	dcmd(animbus,7,cmdtext);
	dcmd(animcamera,10,cmdtext);
	dcmd(animcar,7,cmdtext);
	dcmd(animcarry,9,cmdtext);
	dcmd(animcarchat,11,cmdtext);
	dcmd(animcasino,10,cmdtext);
	dcmd(animchainsaw,12,cmdtext);
	dcmd(animcho,7,cmdtext);
	dcmd(animclo,7,cmdtext);
	dcmd(animcoach,9,cmdtext);
	dcmd(animcolt,8,cmdtext);
	dcmd(animcopamb,10,cmdtext);
	dcmd(animcopdv,9,cmdtext);
	dcmd(animcrack,9,cmdtext);
	dcmd(animcrib,8,cmdtext);
	dcmd(animdamj,8,cmdtext);
	dcmd(animdancer,10,cmdtext);
	dcmd(animdealer,10,cmdtext);
	dcmd(animdildo,9,cmdtext);
	dcmd(animdodge,9,cmdtext);
	dcmd(animdozer,9,cmdtext);
	dcmd(animdrivebys,12,cmdtext);
	dcmd(animfat,7,cmdtext);
	dcmd(animfightb,10,cmdtext);
	dcmd(animfightc,10,cmdtext);
	dcmd(animfightd,10,cmdtext);
	dcmd(animfighte,10,cmdtext);
	dcmd(animfin,7,cmdtext);
	dcmd(animfintwo,10,cmdtext);
	dcmd(animflame,9,cmdtext);
	dcmd(animflowers,11,cmdtext);
	dcmd(animfood,8,cmdtext);
	dcmd(animfwe,7,cmdtext);
	dcmd(animgangs,9,cmdtext);
	dcmd(animghands,10,cmdtext);
	dcmd(animghettodb,12,cmdtext);
	dcmd(animgoggles,11,cmdtext);
	dcmd(animgraf,8,cmdtext);
	dcmd(animgraveyard,13,cmdtext);
	dcmd(animgrenade,11,cmdtext);
	dcmd(animgym,7,cmdtext);
	dcmd(animhair,8,cmdtext);
	dcmd(animheist,9,cmdtext);
	dcmd(animinthouse,12,cmdtext);
	dcmd(animintoff,10,cmdtext);
	dcmd(animintshop,11,cmdtext);
	dcmd(animjstb,8,cmdtext);
	dcmd(animkart,8,cmdtext);
	dcmd(animkiss,8,cmdtext);
	dcmd(animknife,9,cmdtext);
	dcmd(animlapdan,10,cmdtext);
	dcmd(animlowrider,11,cmdtext);
	dcmd(animdchase,10,cmdtext);
	dcmd(animdend,8,cmdtext);
	dcmd(animmedic,9,cmdtext);
	dcmd(animmisc,8,cmdtext);
	dcmd(animmisc,8,cmdtext);
	dcmd(animtb,7,cmdtext);
	dcmd(animmcar,8,cmdtext);
	dcmd(animnevada,10,cmdtext);
	dcmd(animlookers,11,cmdtext);
	dcmd(animotb,7,cmdtext);
	dcmd(animpara,8,cmdtext);
	dcmd(animpark,8,cmdtext);
	dcmd(animpamac,9,cmdtext);
	dcmd(animped,7,cmdtext);
	dcmd(animpdvbys,10,cmdtext);
	dcmd(animplayidles,13,cmdtext);
	dcmd(animpolice,10,cmdtext);
	dcmd(animpool,8,cmdtext);
	dcmd(animpoor,8,cmdtext);
	dcmd(animpython,10,cmdtext);
	dcmd(animquad,8,cmdtext);
	dcmd(animquadbz,10,cmdtext);
	dcmd(animrifle,9,cmdtext);
	dcmd(animriot,8,cmdtext);
	dcmd(animrobbank,11,cmdtext);
	dcmd(animrocket,10,cmdtext);
	dcmd(animrustler,11,cmdtext);
	dcmd(animryder,9,cmdtext);
	dcmd(animscratching,14,cmdtext);
	dcmd(animshamal,10,cmdtext);
	dcmd(animshop,8,cmdtext);
	dcmd(animshotgun,11,cmdtext);
	dcmd(animsilenced,12,cmdtext);
	dcmd(animskate,9,cmdtext);
	dcmd(animsmoking,11,cmdtext);
	dcmd(animsniper,10,cmdtext);
	dcmd(animsex,7,cmdtext);
	dcmd(animspraycan,12,cmdtext);
	dcmd(animstrip,9,cmdtext);
	dcmd(animsunbathe,12,cmdtext);
	dcmd(animswat,8,cmdtext);
	dcmd(animsweet,9,cmdtext);
	dcmd(animswim,8,cmdtext);
	dcmd(animsword,9,cmdtext);
    dcmd(animtank,8,cmdtext);
    dcmd(animtattoo,10,cmdtext);
    dcmd(animtec,7,cmdtext);
    dcmd(animtrain,9,cmdtext);
    dcmd(animtruck,9,cmdtext);
    dcmd(animuzi,7,cmdtext);
    dcmd(animvan,7,cmdtext);
    dcmd(animvedding,11,cmdtext);
    dcmd(animvortex,10,cmdtext);
    dcmd(animwayfarer,12,cmdtext);
    dcmd(animweapons,11,cmdtext);
    dcmd(animwuzi,8,cmdtext);
    dcmd(animblowjob,11,cmdtext);
    dcmd(animlist,8,cmdtext);
	return 0;
}

stock ErrorMessage(p,cmd[32],min,max,a) {
	if(Freeze[p]) {
		if(lang == 0) { SendClientMessage(p,COLOR_ANIM,"Нельзя использовать анимации во время заморозки."); return 0; }
		if(lang == 1) { SendClientMessage(p,COLOR_ANIM,"You can't use animations then you freezed."); return 0; }
	}
	if(ALLOW_VEHICLES && IsPlayerInAnyVehicle(p)) {
		if(lang == 0) { SendClientMessage(p,COLOR_ANIM,"Запрещено использовать анимации в машинах."); return 0; }
		if(lang == 1) { SendClientMessage(p,COLOR_ANIM,"You can't use animations in vehicle."); return 0; }
		return 0; }
	new string[64];
	if(a < min || a > max) {
	 	if(lang == 0) { format(string,64,"Пишите: %s < %d - %d >",cmd,min,max); SendClientMessage(p,COLOR_ANIM,string); return 0; }
		if(lang == 1) { format(string,64,"USAGE: %s < %d - %d >",cmd,min,max); SendClientMessage(p,COLOR_ANIM,string); return 0; }
	} return 1; }

forward FreezePlayer(playerid,bool:a); // Change your standart functions on this. And players can't use animations in freeze.
public FreezePlayer(playerid,bool:a) {
	TogglePlayerControllable(playerid,a);
	Freeze[playerid] = a;
	return 1; }

forward Float: fparam ( const source[], delimiter = ' ', substrIndex = 0 );
stock Float: fparam ( const source[], delimiter = ' ', substrIndex = 0 )  {
	new dest[40], cur, pre, i = -1;
	for ( ; ; cur++ ) {
		if ( source[cur] == 0 ) {
		if ( ++i == substrIndex )
		strmid( dest, source, pre, cur, 40 );
		goto fparam_end; }
		if ( source[cur] == delimiter ) {
			if ( ++i == substrIndex ) {
				strmid( dest, source, pre, cur, 40 );
				goto fparam_end;
			} pre = cur + 1; } } fparam_end:
	return floatstr(dest); }

stock iparam (const source[],delimiter = ' ',substrIndex = 0) {
    new dest[12], cur, pre, i = -1;
    for ( ; ; cur++) {
        if (source[cur] == 0) {
            if(++i == substrIndex)
            strmid(dest, source, pre, cur, 12);
            goto iparam_end; }
        if(source[cur] == delimiter ) {
            if(++i == substrIndex) {
                strmid(dest, source, pre, cur, 12);
                goto iparam_end;
            } pre = cur + 1; } } iparam_end:
    return strval(dest); }

IsNumeric(const string[]) {
	new i;
	while(string[i] != '\0') {
	if (string[i] > '9' || string[i] < '0')
	{
	return 0;
	} i++;
	} return 1; }

stock ApplyAnimationEx(playerid,alib[32],aname[32],Float:param1,o1,o2,o3,o4,o5) {
	if(notf) {
		new string[128];
		if(lang == 0) { format(string,128,"Сейчас проигрывается анимация %s из библиотеки %s.",aname,alib); }
		if(lang == 1) { format(string,128,"Currently playing animation %s from library %s.",aname,alib); }
        SendClientMessage(playerid,COLOR_ANIM,string);
	}
	ApplyAnimation(playerid,alib,aname,param1,o1,o2,o3,o4,o5);
	return 1; }

dcmd_standard(playerid,p[]) {
    #pragma unused p
	fifa[playerid] = 4.1,O1[playerid] = false,O2[playerid] = true,O3[playerid] = true,O4[playerid] = true,O5[playerid] = true,iSeeAnimations[playerid] = false;
	if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. Все настройки анимаций сброшены на стандартные."); }
	if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. All animations settings now standard."); }
	return 1; }

dcmd_animcpo1(playerid,p[]) {
    #pragma unused p
	if(O1[playerid]) {
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. Loop установлен на 0."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. Loop setted as 0."); }
		O1[playerid] = false;
	}else{
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. Loop установлен на 1."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. Loop setted as 1."); }
    	O1[playerid] = true;
	} return 1; }

dcmd_animlist(playerid,p[]) {
	#pragma unused p
	TextDrawShowForPlayer(playerid,anim1); TextDrawShowForPlayer(playerid,anim2);
	TextDrawShowForPlayer(playerid,anim3); TextDrawShowForPlayer(playerid,anim4);
	TextDrawShowForPlayer(playerid,anim5); TextDrawShowForPlayer(playerid,anim6);
	TextDrawShowForPlayer(playerid,anim7); TextDrawShowForPlayer(playerid,anim8);
	iSeeAnimations[playerid] = true;
	return 1; }

dcmd_animcpo2(playerid,p[]) {
    #pragma unused p
	if(O2[playerid]) {
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. LockX установлен на 0."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. LockX setted as 0."); }
		O2[playerid] = false;
	}else{
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. LockX установлен на 1."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. LockX setted as 1."); }
    	O2[playerid] = true;
	} return 1; }

dcmd_animcpo3(playerid,p[]) {
    #pragma unused p
	if(O3[playerid]) {
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. LockY установлен на 0."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. LockY setted as 0."); }
		O3[playerid] = false;
	}else{
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. LockY установлен на 1."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. LockY setted as 1."); }
    	O3[playerid] = true;
	} return 1; }

dcmd_animcpo4(playerid,p[]) {
    #pragma unused p
	if(O4[playerid]) {
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. Freeze on animation finish установлен на 0."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. Freeze on animation finish as 0."); }
		O4[playerid] = false;
	}else{
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Готово. Freeze on animation finish установлен на 1."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Done. Freeze on animation finish setted as 1."); }
    	O4[playerid] = true;
	} return 1; }

dcmd_animcpo5(playerid,p[]) {
    if(IsNumeric(p)) {
		new string[64];
		if(lang == 0) { format(string,64,"Готово. Animation Timer установлен на %d ms",strval(p)); }
		if(lang == 1) { format(string,64,"Done. Animation Timer setted on %d ms",strval(p)); }
		SendClientMessage(playerid,COLOR_ANIM,string);
		O5[playerid] = strval(p);
	} else {
  		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Ошибка. Введите параметры."); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"Error. Enter a params."); }
	} return 1; }



dcmd_animfloat(playerid,p[]) {
    new Float:f = fparam(p,' ',0);
	if(f <= 0.1 || f > 100.0) {
		if(lang == 0) { SendClientMessage(playerid,COLOR_ANIM,"Пишите: /animfloat < 0.1 - 100.0 >"); }
		if(lang == 1) { SendClientMessage(playerid,COLOR_ANIM,"USAGE: /animfloat < 0.1 - 100.0 >"); }
		return 1;
	}
	new string[64];
	fifa[playerid] = f;
	if(lang == 0) { format(string,64,"Готово. Скорость анимации установлена на %0.3f",f); }
	if(lang == 1) { format(string,64,"Done. Animation speed setted on %0.3f",f); }
	SendClientMessage(playerid,COLOR_ANIM,string);
	return 1; }

dcmd_animair(playerid,p[]) {
    #pragma unused p
    ApplyAnimationEx(playerid,"AIRPORT","thrw_barl_thrw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]);
	return 1; }

dcmd_animattr(playerid,p[]) {
    aid = iparam(p,' ',0); ErrorMessage(playerid,"/animattr",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"Attractors","Stepsit_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
    	case 2: { ApplyAnimationEx(playerid,"Attractors","Stepsit_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
    	case 3: { ApplyAnimationEx(playerid,"Attractors","Stepsit_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbar(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbar",1,12,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BAR","Barcustom_get",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BAR","Barcustom_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BAR","Barcustom_order",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BAR","BARman_idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BAR","Barserve_bottle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BAR","Barserve_give",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BAR","Barserve_glass",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BAR","Barserve_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BAR","Barserve_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BAR","Barserve_order",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BAR","dnk_stndF_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BAR","dnk_stndM_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbball(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbball",1,11,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BASEBALL","Bat_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BASEBALL","Bat_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BASEBALL","Bat_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BASEBALL","Bat_4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BASEBALL","Bat_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BASEBALL","Bat_Hit_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BASEBALL","Bat_Hit_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BASEBALL","Bat_Hit_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BASEBALL","Bat_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BASEBALL","Bat_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
    	case 11: { ApplyAnimationEx(playerid,"BASEBALL","BAT_PART",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbdfire(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbdfire",1,13,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Fire1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }    // Bit Buggy
	    case 2: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Fire2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }    // Bit Buggy
	    case 3: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Fire3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }    // Bit Buggy
	    case 4: { ApplyAnimationEx(playerid,"BD_FIRE","BD_GF_Wave",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Panic_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Panic_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Panic_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Panic_04",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BD_FIRE","BD_Panic_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BD_FIRE","Grlfrd_Kiss_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BD_FIRE","M_smklean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BD_FIRE","Playa_Kiss_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BD_FIRE","wash_up",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbeach(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbeach",1,5,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BEACH","bather",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BEACH","Lay_Bac_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BEACH","ParkSit_M_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BEACH","ParkSit_W_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BEACH","SitnWait_loop_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbpress(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbpress",1,7,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"benchpress","gym_bp_celebrate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"benchpress","gym_bp_down",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"benchpress","gym_bp_getoff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"benchpress","gym_bp_geton",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"benchpress","gym_bp_up_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
        case 6: { ApplyAnimationEx(playerid,"benchpress","gym_bp_up_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"benchpress","gym_bp_up_smooth",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbfinf(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbfinf",1,4,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BF_injection","BF_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BF_injection","BF_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BF_injection","BF_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BF_injection","BF_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbiked(playerid,p[])  {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbiked",1,19,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BIKED","BIKEd_Back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKED","BIKEd_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKED","BIKEd_drivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKED","BIKEd_drivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BIKED","BIKEd_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BIKED","BIKEd_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BIKED","BIKEd_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BIKED","BIKEd_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BIKED","BIKEd_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BIKED","BIKEd_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BIKED","BIKEd_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BIKED","BIKEd_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BIKED","BIKEd_left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"BIKED","BIKEd_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 15: { ApplyAnimationEx(playerid,"BIKED","BIKEd_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 16: { ApplyAnimationEx(playerid,"BIKED","BIKEd_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 17: { ApplyAnimationEx(playerid,"BIKED","BIKEd_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"BIKED","BIKEd_shuffle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 19: { ApplyAnimationEx(playerid,"BIKED","BIKEd_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbikeh(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbikeh",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_Back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_drivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_drivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 15: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 16: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 17: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 18: { ApplyAnimationEx(playerid,"BIKEH","BIKEh_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbikeleap(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbikeleap",1,9,aid);
	switch(aid)
	{
	    case 1: { ApplyAnimationEx(playerid,"BIKELEAP","bk_blnce_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKELEAP","bk_blnce_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKELEAP","bk_jmp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKELEAP","bk_rdy_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BIKELEAP","bk_rdy_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BIKELEAP","struggle_cesar",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BIKELEAP","struggle_driver",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BIKELEAP","truck_driver",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BIKELEAP","truck_getin",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbikes(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbikes",1,20,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BIKES","BIKes_Back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKES","BIKEs_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKES","BIKEs_drivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKES","BIKEs_drivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BIKES","BIKEs_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BIKES","BIKEs_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BIKES","BIKEs_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BIKES","BIKEs_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BIKES","BIKEs_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BIKES","BIKEs_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BIKES","BIKEs_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BIKES","BIKEs_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BIKES","BIKEs_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"BIKES","BIKEs_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 15: { ApplyAnimationEx(playerid,"BIKES","BIKEs_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 16: { ApplyAnimationEx(playerid,"BIKES","BIKEs_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 17: { ApplyAnimationEx(playerid,"BIKES","BIKEs_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 18: { ApplyAnimationEx(playerid,"BIKES","BIKes_Snatch_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
        case 19: { ApplyAnimationEx(playerid,"BIKES","BIKes_Snatch_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 20: { ApplyAnimationEx(playerid,"BIKES","BIKes_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbikev(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbikev",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BIKEv","BIKev_Back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_drivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_drivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 15: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 16: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 17: { ApplyAnimationEx(playerid,"BIKEv","BIKEv_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 18: { ApplyAnimationEx(playerid,"BIKEv","BIKev_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbikedbz(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbikedbz",1,4,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"BIKE_DBZ","Pass_Driveby_BWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BIKE_DBZ","Pass_Driveby_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BIKE_DBZ","Pass_Driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BIKE_DBZ","Pass_Driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbmx(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbmx",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BMX","BMX_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BMX","BMX_bunnyhop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BMX","BMX_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BMX","BMX_driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BMX","BMX_driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BMX","BMX_fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BMX","BMX_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BMX","BMX_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BMX","BMX_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"BMX","BMX_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"BMX","BMX_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"BMX","BMX_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"BMX","BMX_pedal",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"BMX","BMX_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 15: { ApplyAnimationEx(playerid,"BMX","BMX_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 16: { ApplyAnimationEx(playerid,"BMX","BMX_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 17: { ApplyAnimationEx(playerid,"BMX","BMX_sprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 18: { ApplyAnimationEx(playerid,"BMX","BMX_still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbomber(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbomber",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_2Idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Crouch_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Crouch_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BOMBER","BOM_Plant_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbox(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbox",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BOX","boxhipin",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BOX","boxhipup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BOX","boxshdwn",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BOX","boxshup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BOX","bxhipwlk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BOX","bxhwlki",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BOX","bxshwlk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BOX","bxshwlki",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BOX","bxwlko",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
        case 10: { ApplyAnimationEx(playerid,"BOX","catch_box",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbasket(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbasket",1,41,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_jump_shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_stepL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_def_stepR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_Gli",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_Gli_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_Lnch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_Lnch_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_Lnd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Dnk_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idle2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idle2_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idleloop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idleloop_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_idle_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Cancel",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Cancel_0",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Jump_Shot_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_Net_Dnk_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_pickup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_pickup_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_react_miss",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_react_score",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_run",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_run_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_SkidStop_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_SkidStop_L_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_SkidStop_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_SkidStop_R_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 34: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_walk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 35: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_WalkStop_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 36: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_WalkStop_L_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 37: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_WalkStop_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 38: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_WalkStop_R_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 39: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_walk_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 40: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_walk_start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 41: { ApplyAnimationEx(playerid,"BSKTBALL","BBALL_walk_start_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbuddy(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbuddy",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BUDDY","buddy_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BUDDY","buddy_crouchreload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BUDDY","buddy_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BUDDY","buddy_fire_poor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BUDDY","buddy_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animbus(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animbus",1,9,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BUS","BUS_close",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"BUS","BUS_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"BUS","BUS_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"BUS","BUS_geout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"BUS","BUS_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"BUS","BUS_jacked_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"BUS","BUS_open",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"BUS","BUS_open_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"BUS","BUS_pullout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcamera(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcamera",1,14,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"CAMERA","camcrch_cmon",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"CAMERA","camcrch_idleloop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"CAMERA","camcrch_stay",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"CAMERA","camcrch_to_camstnd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"CAMERA","camstnd_cmon",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"CAMERA","camstnd_idleloop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"CAMERA","camstnd_lkabt",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"CAMERA","camstnd_to_camrcrch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"CAMERA","piccrch_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"CAMERA","picccrch_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 11: { ApplyAnimationEx(playerid,"CAMERA","piccrch_take",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 12: { ApplyAnimationEx(playerid,"CAMERA","picstnd_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 13: { ApplyAnimationEx(playerid,"CAMERA","picstnd_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
     	case 14: { ApplyAnimationEx(playerid,"CAMERA","picstnd_take",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcar(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcar",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CAR","Fixn_Car_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"CAR","Fix_Car_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"CAR","flag_drop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"CAR","Sit_relaxed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"CAR","Tyd2car_bump",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"CAR","Tyd2car_high",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"CAR","Tyd2car_low",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 8: { ApplyAnimationEx(playerid,"CAR","Tyd2car_med",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 9: { ApplyAnimationEx(playerid,"CAR","Tyd2car_TurnL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 10: { ApplyAnimationEx(playerid,"CAR","Tyd2Car_TurnR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcarry(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcarry",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CARRY","crry_prtial",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 2: { ApplyAnimationEx(playerid,"CARRY","liftup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"CARRY","liftup05",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"CARRY","liftup105",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"CARRY","putdwn",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 6: { ApplyAnimationEx(playerid,"CARRY","putdwn05",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 7: { ApplyAnimationEx(playerid,"CARRY","putdwn105",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcarchat(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcarchat",1,21,aid);
	switch(aid)
	{
		case 1: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_loopA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_loopA_to_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_loopB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_loopB_to_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CAR_CHAT","carfone_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc1_BL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc1_BR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc1_FL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc1_FR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc2_FL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc3_BR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc3_FL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc3_FR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc4_BL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc4_BR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc4_FL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"CAR_CHAT","CAR_Sc4_FR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"CAR_CHAT","car_talkm_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"CAR_CHAT","car_talkm_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"CAR_CHAT","car_talkm_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcasino(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcasino",1,25,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CASINO","cards_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CASINO","cards_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CASINO","cards_lose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CASINO","cards_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CASINO","cards_pick_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CASINO","cards_pick_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CASINO","cards_raise",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CASINO","cards_win",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CASINO","dealone",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CASINO","manwinb",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"CASINO","manwind",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"CASINO","Roulette_bet",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"CASINO","Roulette_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"CASINO","Roulette_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"CASINO","Roulette_lose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"CASINO","Roulette_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"CASINO","Roulette_win",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"CASINO","Slot_bet_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"CASINO","Slot_bet_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"CASINO","Slot_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"CASINO","Slot_lose_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"CASINO","Slot_Plyr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"CASINO","Slot_wait",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"CASINO","Slot_win_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"CASINO","wof",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animchainsaw(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animchainsaw",1,11,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_Hit_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_Hit_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CHAINSAW","CSAW_Hit_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CHAINSAW","csaw_part",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CHAINSAW","IDLE_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CHAINSAW","WEAPON_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"CHAINSAW","WEAPON_csawlo",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcho(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcho",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_bunnyhop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_pedal",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_Pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_sprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"CHOPPA","CHOPPA_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animclo(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animclo",1,13,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Buy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CLOTHES","CLO_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Hat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Legs",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Shoes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Torso",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"CLOTHES","CLO_Pose_Watch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcoach(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcoach",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"COACH","COACH_inL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"COACH","COACH_inR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"COACH","COACH_opnL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"COACH","COACH_opnR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"COACH","COACH_outL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"COACH","COACH_outR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcolt(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcolt",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"COLT45","2guns_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"COLT45","colt45_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"COLT45","colt45_crouchreload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"COLT45","colt45_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"COLT45","colt45_fire_2hands",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"COLT45","colt45_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"COLT45","sawnoff_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcopamb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcopamb",1,12,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_nod",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"COP_AMBIENT","Copbrowse_shake",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_nod",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_shake",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_think",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"COP_AMBIENT","Coplook_watch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcopdv(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcopdv",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"COP_DVBYZ","COP_Dvby_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"COP_DVBYZ","COP_Dvby_FT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"COP_DVBYZ","COP_Dvby_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"COP_DVBYZ","COP_Dvby_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcrack(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcrack",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CRACK","Bbalbat_Idle_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CRACK","Bbalbat_Idle_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CRACK","crckdeth1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CRACK","crckdeth2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CRACK","crckdeth3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"CRACK","crckdeth4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"CRACK","crckidle1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"CRACK","crckidle2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"CRACK","crckidle3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"CRACK","crckidle4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animcrib(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animcrib",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"CRIB","CRIB_Console_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"CRIB","CRIB_Use_Switch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"CRIB","PED_Console_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"CRIB","PED_Console_Loose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"CRIB","PED_Console_Win",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdamj(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdamj",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DAM_JUMP","DAM_Dive_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DAM_JUMP","DAM_Land",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DAM_JUMP","DAM_Launch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DAM_JUMP","Jump_Roll",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DAM_JUMP","SF_JumpWall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdancer(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdancer",1,13,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DANCING","bd_clap",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DANCING","bd_clap1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DANCING","dance_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DANCING","DAN_Down_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DANCING","DAN_Left_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"DANCING","DAN_Loop_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"DANCING","DAN_Right_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"DANCING","DAN_Up_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"DANCING","dnce_M_a",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"DANCING","dnce_M_b",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"DANCING","dnce_M_c",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"DANCING","dnce_M_d",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"DANCING","dnce_M_e",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdealer(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdealer",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DEALER","DEALER_DEAL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DEALER","DEALER_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DEALER","DEALER_IDLE_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DEALER","DEALER_IDLE_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DEALER","DEALER_IDLE_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"DEALER","DRUGS_BUY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"DEALER","shop_pay",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdildo(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdildo",1,9,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DILDO","DILDO_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DILDO","DILDO_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DILDO","DILDO_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DILDO","DILDO_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DILDO","DILDO_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"DILDO","DILDO_Hit_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"DILDO","DILDO_Hit_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"DILDO","DILDO_Hit_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"DILDO","DILDO_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdodge(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdodge",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DODGE","Cover_Dive_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DODGE","Cover_Dive_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DODGE","Crushed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	 	case 4: { ApplyAnimationEx(playerid,"DODGE","Crush_Jump",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdozer(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdozer",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DOZER","DOZER_Align_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DOZER","DOZER_Align_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DOZER","DOZER_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DOZER","DOZER_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DOZER","DOZER_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"DOZER","DOZER_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"DOZER","DOZER_Jacked_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"DOZER","DOZER_Jacked_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"DOZER","DOZER_pullout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"DOZER","DOZER_pullout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdrivebys(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdrivebys",1,8,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyLHS_Bwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyLHS_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyRHS_Bwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyRHS_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyTop_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"DRIVEBYS","Gang_DrivebyTop_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfat(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfat",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FAT","FatIdle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FAT","FatIdle_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FAT","FatIdle_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FAT","FatIdle_Rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FAT","FatRun",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FAT","FatRun_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FAT","FatRun_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FAT","FatRun_Rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FAT","FatSprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FAT","FatWalk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"FAT","FatWalkstart",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"FAT","FatWalkstart_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"FAT","FatWalkSt_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"FAT","FatWalkSt_Rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"FAT","FatWalk_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"FAT","FatWalk_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"FAT","FatWalk_Rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
 		case 18: { ApplyAnimationEx(playerid,"FAT","IDLE_tired",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfightb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfightb",1,10,aid);
	switch(aid)
	{
		case 1: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FIGHT_B","FightB_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FIGHT_B","HitB_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FIGHT_B","HitB_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FIGHT_B","HitB_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfightc(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfightc",1,12,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_blocking",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FIGHT_C","FightC_Spar",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FIGHT_C","HitC_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"FIGHT_C","HitC_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"FIGHT_C","HitC_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfightd(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfightd",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FIGHT_D","FightD_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FIGHT_D","HitD_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FIGHT_D","HitD_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FIGHT_D","HitD_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfighte(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfighte",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FIGHT_E","FightKick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FIGHT_E","FightKick_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FIGHT_E","Hit_fightkick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FIGHT_E","Hit_fightkick_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfin(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfin",1,16,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FINALE","FIN_Climb_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FINALE","FIN_Cop1_ClimbOut2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FINALE","FIN_Cop1_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FINALE","FIN_Cop1_Stomp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FINALE","FIN_Hang_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FINALE","FIN_Hang_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FINALE","FIN_Hang_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FINALE","FIN_Hang_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FINALE","FIN_Jump_On",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FINALE","FIN_Land_Car",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"FINALE","FIN_Land_Die",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"FINALE","FIN_LegsUp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"FINALE","FIN_LegsUp_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"FINALE","FIN_LegsUp_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"FINALE","FIN_LegsUp_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"FINALE","FIN_Let_Go",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfintwo(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfintwo",1,16,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop1_ClimbOut",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop1_Fall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop1_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop1_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop1_Swing",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FINALE2","FIN_Cop2_ClimbOut",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FINALE2","FIN_Switch_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FINALE2","FIN_Switch_S",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animflame(playerid,p[]) {
    #pragma unused p
    ApplyAnimationEx(playerid,"FLAME","FLAME_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]);
	return 1; }

dcmd_animflowers(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animflowers",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"Flowers","Flower_attack",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"Flowers","Flower_attack_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"Flowers","Flower_Hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfood(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfood",1,33,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"FOOD","EAT_Burger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"FOOD","EAT_Chicken",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"FOOD","EAT_Pizza",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"FOOD","EAT_Vomit_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"FOOD","EAT_Vomit_SK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"FOOD","FF_Dam_Bkw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"FOOD","FF_Dam_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"FOOD","FF_Dam_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"FOOD","FF_Dam_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"FOOD","FF_Die_Bkw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"FOOD","FF_Die_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"FOOD","FF_Die_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"FOOD","FF_Die_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Eat1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Eat2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Eat3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_In_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_In_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Look",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Out_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Out_L_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"FOOD","FF_Sit_Out_R_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"FOOD","SHP_Thank",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Lift",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Lift_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Lift_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Lift_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Pose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"FOOD","SHP_Tray_Return",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animfwe(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animfwe",1,9,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"Freeweights","gym_barbell",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"Freeweights","gym_free_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"Freeweights","gym_free_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"Freeweights","gym_free_celebrate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"Freeweights","gym_free_down",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"Freeweights","gym_free_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"Freeweights","gym_free_pickup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"Freeweights","gym_free_putdown",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"Freeweights","gym_free_up_smooth",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animgangs(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animgangs",1,33,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GANGS","DEALER_DEAL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GANGS","DEALER_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GANGS","drnkbr_prtl",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"GANGS","drnkbr_prtl_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"GANGS","DRUGS_BUY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"GANGS","hndshkaa",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"GANGS","hndshkba",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"GANGS","hndshkca",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"GANGS","hndshkcb",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"GANGS","hndshkda",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"GANGS","hndshkea",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"GANGS","hndshkfa",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"GANGS","hndshkfa_swt",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"GANGS","Invite_No",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"GANGS","Invite_Yes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"GANGS","leanIDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"GANGS","leanIN",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"GANGS","leanOUT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkCt",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkF",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkG",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"GANGS","prtial_gngtlkH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"GANGS","prtial_hndshk_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"GANGS","prtial_hndshk_biz_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"GANGS","shake_cara",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"GANGS","shake_carK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"GANGS","shake_carSH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"GANGS","smkcig_prtl",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"GANGS","smkcig_prtl_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animghands(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animghands",1,20,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GHANDS","gsign1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GHANDS","gsign1LH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GHANDS","gsign2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"GHANDS","gsign2LH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"GHANDS","gsign3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"GHANDS","gsign3LH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"GHANDS","gsign4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"GHANDS","gsign4LH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"GHANDS","gsign5",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"GHANDS","gsign5LH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"GHANDS","LHGsign1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"GHANDS","LHGsign2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"GHANDS","LHGsign3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"GHANDS","LHGsign4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"GHANDS","LHGsign5",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"GHANDS","RHGsign1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"GHANDS","RHGsign2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"GHANDS","RHGsign3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"GHANDS","RHGsign4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"GHANDS","RHGsign5",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animghettodb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animghettodb",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car2_PLY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car2_SMO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car2_SWE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car_PLY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car_RYD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car_SMO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"GHETTO_DB","GDB_Car_SWE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animgoggles(playerid,p[]) {
    #pragma unused p
    ApplyAnimationEx(playerid,"goggles","goggles_put_on",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]);
	return 1; }

dcmd_animgraf(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animgraf",1,2,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GRAFFITI","graffiti_Chkout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GRAFFITI","spraycan_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animgraveyard(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animgraveyard",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GRAVEYARD","mrnF_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GRAVEYARD","mrnM_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GRAVEYARD","prst_loopa",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animgrenade(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animgrenade",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GRENADE","WEAPON_start_throw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GRENADE","WEAPON_throw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GRENADE","WEAPON_throwu",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animgym(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animgym",1,24,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"GYMNASIUM","GYMshadowbox",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_celebrate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_fast",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_faster",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_getoff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_geton",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_pedal",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_bike_still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_jog_falloff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_shadowbox",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_celebrate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_falloff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_getoff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_geton",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_jog",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_sprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_tired",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_tread_walk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"GYMNASIUM","gym_walk_falloff",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"GYMNASIUM","Pedals_fast",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"GYMNASIUM","Pedals_med",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"GYMNASIUM","Pedals_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"GYMNASIUM","Pedals_still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animhair(playerid,p[]) {
	aid = iparam(p,' ',0);	ErrorMessage(playerid,"/animhair",1,13,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Beard_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Buy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Cut",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Cut_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Cut_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Hair_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Hair_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Sit_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Sit_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"HAIRCUTS","BRB_Sit_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animheist(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animheist",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"HEIST9","CAS_G2_GasKO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"HEIST9","swt_wllpk_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"HEIST9","swt_wllpk_L_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"HEIST9","swt_wllpk_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"HEIST9","swt_wllpk_R_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"HEIST9","swt_wllshoot_in_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"HEIST9","swt_wllshoot_in_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"HEIST9","swt_wllshoot_out_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"HEIST9","swt_wllshoot_out_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"HEIST9","Use_SwipeCard",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animinthouse(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animinthouse",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_In_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_In_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_Loop_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_Loop_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_Out_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"INT_HOUSE","BED_Out_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"INT_HOUSE","LOU_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"INT_HOUSE","LOU_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"INT_HOUSE","LOU_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"INT_HOUSE","wash_up",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
 	} return 1; }

dcmd_animintoff(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animintoff",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"INT_OFFICE","FF_Dam_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_2Idle_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Bored_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Crash",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Drink",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Idle_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Read",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Type_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"INT_OFFICE","OFF_Sit_Watch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animintshop(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animintshop",1,8,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"INT_SHOP","shop_cashier",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"INT_SHOP","shop_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"INT_SHOP","shop_lookA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"INT_SHOP","shop_lookB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"INT_SHOP","shop_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"INT_SHOP","shop_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"INT_SHOP","shop_pay",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"INT_SHOP","shop_shelf",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animjstb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animjstb",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"JST_BUISNESS","girl_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"JST_BUISNESS","girl_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"JST_BUISNESS","player_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"JST_BUISNESS","smoke_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animkart(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animkart",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"KART","KART_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"KART","KART_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"KART","KART_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"KART","KART_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animkiss(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animkiss",1,15,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"KISSING","BD_GF_Wave",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"KISSING","gfwave2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"KISSING","GF_CarArgue_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"KISSING","GF_CarArgue_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"KISSING","GF_CarSpot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"KISSING","GF_StreetArgue_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"KISSING","GF_StreetArgue_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"KISSING","gift_get",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"KISSING","gift_give",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"KISSING","Grlfrd_Kiss_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"KISSING","Grlfrd_Kiss_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"KISSING","Grlfrd_Kiss_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"KISSING","Playa_Kiss_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"KISSING","Playa_Kiss_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"KISSING","Playa_Kiss_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animknife(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animknife",1,16,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"KNIFE","KILL_Knife_Ped_Damage",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"KNIFE","KILL_Knife_Ped_Die",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"KNIFE","KILL_Knife_Player",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"KNIFE","KILL_Partial",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"KNIFE","knife_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"KNIFE","knife_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"KNIFE","knife_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"KNIFE","knife_4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"KNIFE","knife_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"KNIFE","Knife_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"KNIFE","knife_hit_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"KNIFE","knife_hit_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"KNIFE","knife_hit_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"KNIFE","knife_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"KNIFE","knife_part",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"KNIFE","WEAPON_knifeidle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animlapdan(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animlapdan",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"LAPDAN1","LAPDAN_D",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"LAPDAN1","LAPDAN_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"LAPDAN2","LAPDAN_D",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"LAPDAN2","LAPDAN_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"LAPDAN3","LAPDAN_D",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"LAPDAN3","LAPDAN_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animlowrider(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animlowrider",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"LOWRIDER","F_smklean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_bdbnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_hair",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_hurry",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_idleloop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_idle_to_l0",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l0_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l0_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l0_to_l1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l12_to_l0",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l1_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l1_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l1_to_l2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l2_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l2_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l2_to_l3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l345_to_l1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l3_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l3_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l3_to_l4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l4_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l4_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l4_to_l5",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l5_bnce",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"LOWRIDER","lrgirl_l5_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"LOWRIDER","M_smklean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"LOWRIDER","M_smkstnd_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkC",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkF",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkG",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 34: { ApplyAnimationEx(playerid,"LOWRIDER","prtial_gngtlkH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 35: { ApplyAnimationEx(playerid,"LOWRIDER","RAP_A_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 36: { ApplyAnimationEx(playerid,"LOWRIDER","RAP_B_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 37: { ApplyAnimationEx(playerid,"LOWRIDER","RAP_C_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 38: { ApplyAnimationEx(playerid,"LOWRIDER","Sit_relaxed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 39: { ApplyAnimationEx(playerid,"LOWRIDER","Tap_hand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdchase(playerid,p[])
{
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdchase",1,25,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"MD_CHASE","Carhit_Hangon",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"MD_CHASE","Carhit_Tumble",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"MD_CHASE","donutdrop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_L1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_L2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_L3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_R1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_R2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"MD_CHASE","Fen_Choppa_R3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"MD_CHASE","Hangon_Stun_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"MD_CHASE","Hangon_Stun_Turn",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_2_HANG",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Jmp_BL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Jmp_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_BL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_Die_BL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_Die_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_Roll",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Lnd_Roll_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Punch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Punch_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"MD_CHASE","MD_BIKE_Shot_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"MD_CHASE","MD_HANG_Lnd_Roll",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"MD_CHASE","MD_HANG_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animdend(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animdend",1,8,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"MD_END","END_SC1_PLY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"MD_END","END_SC1_RYD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"MD_END","END_SC1_SMO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"MD_END","END_SC1_SWE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"MD_END","END_SC2_PLY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"MD_END","END_SC2_RYD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"MD_END","END_SC2_SMO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"MD_END","END_SC2_SWE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animmedic(playerid,p[]) {
    #pragma unused p
  	ApplyAnimationEx(playerid,"MEDIC","CPR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]);
  	return 1; }

dcmd_animmisc(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animmisc",1,41,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"MISC","bitchslap",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"MISC","BMX_celebrate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"MISC","BMX_comeon",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"MISC","bmx_idleloop_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"MISC","bmx_idleloop_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"MISC","bmx_talkleft_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"MISC","bmx_talkleft_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"MISC","bmx_talkleft_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"MISC","bmx_talkright_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"MISC","bmx_talkright_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"MISC","bmx_talkright_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"MISC","bng_wndw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"MISC","bng_wndw_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"MISC","Case_pickup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"MISC","door_jet",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"MISC","GRAB_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"MISC","GRAB_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"MISC","Hiker_Pose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"MISC","Hiker_Pose_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"MISC","Idle_Chat_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"MISC","KAT_Throw_K",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"MISC","KAT_Throw_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"MISC","KAT_Throw_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"MISC","PASS_Rifle_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"MISC","PASS_Rifle_Ped",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"MISC","PASS_Rifle_Ply",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"MISC","pickup_box",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"MISC","Plane_door",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"MISC","Plane_exit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"MISC","Plane_hijack",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"MISC","Plunger_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"MISC","Plyrlean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"MISC","plyr_shkhead",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 34: { ApplyAnimationEx(playerid,"MISC","Run_Dive",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 35: { ApplyAnimationEx(playerid,"MISC","Scratchballs_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 36: { ApplyAnimationEx(playerid,"MISC","SEAT_LR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 37: { ApplyAnimationEx(playerid,"MISC","Seat_talk_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 38: { ApplyAnimationEx(playerid,"MISC","Seat_talk_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 39: { ApplyAnimationEx(playerid,"MISC","SEAT_watch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 40: { ApplyAnimationEx(playerid,"MISC","smalplane_door",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 41: { ApplyAnimationEx(playerid,"MISC","smlplane_door",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtb",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"MTB","MTB_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"MTB","MTB_bunnyhop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"MTB","MTB_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"MTB","MTB_driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"MTB","MTB_driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"MTB","MTB_fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"MTB","MTB_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"MTB","MTB_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"MTB","MTB_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"MTB","MTB_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"MTB","MTB_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"MTB","MTB_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"MTB","MTB_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"MTB","MTB_pedal",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"MTB","MTB_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"MTB","MTB_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"MTB","MTB_sprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"MTB","MTB_still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animmcar(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animmcar",1,17,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"MUSCULAR","MscleWalkst_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"MUSCULAR","MscleWalkst_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"MUSCULAR","Mscle_rckt_run",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"MUSCULAR","Mscle_rckt_walkst",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"MUSCULAR","Mscle_run_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleIdle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleIdle_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleIdle_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleIdle_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleRun",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleRun_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleSprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalkstart",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"MUSCULAR","MuscleWalk_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"MUSCULAR","Musclewalk_Csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"MUSCULAR","Musclewalk_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
 	} return 1; }

dcmd_animnevada(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animnevada",1,2,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"NEVADA","NEVADA_getin",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"NEVADA","NEVADA_getout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animlookers(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animlookers",1,29,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkaround_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkaround_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkaround_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkup_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkup_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkup_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"ON_LOOKERS","lkup_point",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_cower",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_hide",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_point",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"ON_LOOKERS","panic_shout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"ON_LOOKERS","Pointup_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"ON_LOOKERS","Pointup_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"ON_LOOKERS","Pointup_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"ON_LOOKERS","Pointup_shout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"ON_LOOKERS","point_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"ON_LOOKERS","point_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"ON_LOOKERS","point_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"ON_LOOKERS","shout_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"ON_LOOKERS","shout_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"ON_LOOKERS","shout_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"ON_LOOKERS","shout_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"ON_LOOKERS","shout_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"ON_LOOKERS","wave_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"ON_LOOKERS","wave_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"ON_LOOKERS","wave_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animotb(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animotb",1,11,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"OTB","betslp_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"OTB","betslp_lkabt",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"OTB","betslp_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"OTB","betslp_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"OTB","betslp_tnk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"OTB","wtchrace_cmon",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"OTB","wtchrace_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"OTB","wtchrace_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"OTB","wtchrace_lose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"OTB","wtchrace_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"OTB","wtchrace_win",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpara(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpara",1,22,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PARACHUTE","FALL_skyDive",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PARACHUTE","FALL_SkyDive_Accel",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PARACHUTE","FALL_skyDive_DIE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"PARACHUTE","FALL_SkyDive_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"PARACHUTE","FALL_SkyDive_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_decel",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_decel_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_float",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_float_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Land",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Land_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Land_Water",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Land_Water_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_open",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_open_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Rip_Land_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Rip_Loop_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_Rip_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_steerL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_steerL_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_steerR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"PARACHUTE","PARA_steerR_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpark(playerid,p[])
{
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpark",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PARK","Tai_Chi_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PARK","Tai_Chi_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PARK","Tai_Chi_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpamac(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpamac",1,12,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PAULNMAC","Piss_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PAULNMAC","Piss_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PAULNMAC","Piss_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Argue1_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Argue1_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Argue2_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Argue2_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Loop_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"PAULNMAC","PnM_Loop_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"PAULNMAC","wank_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"PAULNMAC","wank_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"PAULNMAC","wank_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animped(playerid,p[])
{
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animped",1,295,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PED","abseil",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PED","ARRESTgun",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PED","ATM",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"PED","BIKE_elbowL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"PED","BIKE_elbowR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"PED","BIKE_fallR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"PED","BIKE_fall_off",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"PED","BIKE_pickupL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"PED","BIKE_pickupR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"PED","BIKE_pullupL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"PED","BIKE_pullupR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"PED","bomber",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"PED","CAR_alignHI_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"PED","CAR_alignHI_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"PED","CAR_align_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"PED","CAR_align_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"PED","CAR_closedoorL_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"PED","CAR_closedoorL_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"PED","CAR_closedoor_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"PED","CAR_closedoor_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"PED","CAR_close_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"PED","CAR_close_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"PED","CAR_crawloutRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"PED","CAR_dead_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"PED","CAR_dead_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"PED","CAR_doorlocked_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"PED","CAR_doorlocked_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"PED","CAR_fallout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"PED","CAR_fallout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"PED","CAR_getinL_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"PED","CAR_getinL_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"PED","CAR_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"PED","CAR_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 34: { ApplyAnimationEx(playerid,"PED","CAR_getoutL_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 35: { ApplyAnimationEx(playerid,"PED","CAR_getoutL_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 36: { ApplyAnimationEx(playerid,"PED","CAR_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 37: { ApplyAnimationEx(playerid,"PED","CAR_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 38: { ApplyAnimationEx(playerid,"PED","car_hookertalk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 39: { ApplyAnimationEx(playerid,"PED","CAR_jackedLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 40: { ApplyAnimationEx(playerid,"PED","CAR_jackedRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 41: { ApplyAnimationEx(playerid,"PED","CAR_jumpin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 42: { ApplyAnimationEx(playerid,"PED","CAR_LB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 43: { ApplyAnimationEx(playerid,"PED","CAR_LB_pro",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 44: { ApplyAnimationEx(playerid,"PED","CAR_LB_weak",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 45: { ApplyAnimationEx(playerid,"PED","CAR_LjackedLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 46: { ApplyAnimationEx(playerid,"PED","CAR_LjackedRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 47: { ApplyAnimationEx(playerid,"PED","CAR_Lshuffle_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 48: { ApplyAnimationEx(playerid,"PED","CAR_Lsit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 49: { ApplyAnimationEx(playerid,"PED","CAR_open_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 50: { ApplyAnimationEx(playerid,"PED","CAR_open_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 51: { ApplyAnimationEx(playerid,"PED","CAR_pulloutL_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 52: { ApplyAnimationEx(playerid,"PED","CAR_pulloutL_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 53: { ApplyAnimationEx(playerid,"PED","CAR_pullout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 54: { ApplyAnimationEx(playerid,"PED","CAR_pullout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 55: { ApplyAnimationEx(playerid,"PED","CAR_Qjacked",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 56: { ApplyAnimationEx(playerid,"PED","CAR_rolldoor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 57: { ApplyAnimationEx(playerid,"PED","CAR_rolldoorLO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 58: { ApplyAnimationEx(playerid,"PED","CAR_rollout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 59: { ApplyAnimationEx(playerid,"PED","CAR_rollout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 60: { ApplyAnimationEx(playerid,"PED","CAR_shuffle_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 61: { ApplyAnimationEx(playerid,"PED","CAR_sit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 62: { ApplyAnimationEx(playerid,"PED","CAR_sitp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 63: { ApplyAnimationEx(playerid,"PED","CAR_sitpLO",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 64: { ApplyAnimationEx(playerid,"PED","CAR_sit_pro",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 65: { ApplyAnimationEx(playerid,"PED","CAR_sit_weak",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 66: { ApplyAnimationEx(playerid,"PED","CAR_tune_radio",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 67: { ApplyAnimationEx(playerid,"PED","CLIMB_idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 68: { ApplyAnimationEx(playerid,"PED","CLIMB_jump",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 69: { ApplyAnimationEx(playerid,"PED","CLIMB_jump2fall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 70: { ApplyAnimationEx(playerid,"PED","CLIMB_jump_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 71: { ApplyAnimationEx(playerid,"PED","CLIMB_Pull",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 72: { ApplyAnimationEx(playerid,"PED","CLIMB_Stand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 73: { ApplyAnimationEx(playerid,"PED","CLIMB_Stand_finish",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 74: { ApplyAnimationEx(playerid,"PED","cower",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 75: { ApplyAnimationEx(playerid,"PED","Crouch_Roll_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 76: { ApplyAnimationEx(playerid,"PED","Crouch_Roll_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 77: { ApplyAnimationEx(playerid,"PED","DAM_armL_frmBK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 78: { ApplyAnimationEx(playerid,"PED","DAM_armL_frmFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 79: { ApplyAnimationEx(playerid,"PED","DAM_armL_frmLT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 80: { ApplyAnimationEx(playerid,"PED","DAM_armR_frmBK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 81: { ApplyAnimationEx(playerid,"PED","DAM_armR_frmFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 82: { ApplyAnimationEx(playerid,"PED","DAM_armR_frmRT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 83: { ApplyAnimationEx(playerid,"PED","DAM_LegL_frmBK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 84: { ApplyAnimationEx(playerid,"PED","DAM_LegL_frmFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 85: { ApplyAnimationEx(playerid,"PED","DAM_LegL_frmLT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 86: { ApplyAnimationEx(playerid,"PED","DAM_LegR_frmBK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 87: { ApplyAnimationEx(playerid,"PED","DAM_LegR_frmFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 88: { ApplyAnimationEx(playerid,"PED","DAM_LegR_frmRT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 89: { ApplyAnimationEx(playerid,"PED","DAM_stomach_frmBK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 90: { ApplyAnimationEx(playerid,"PED","DAM_stomach_frmFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 91: { ApplyAnimationEx(playerid,"PED","DAM_stomach_frmLT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 92: { ApplyAnimationEx(playerid,"PED","DAM_stomach_frmRT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 93: { ApplyAnimationEx(playerid,"PED","DOOR_LHinge_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 94: { ApplyAnimationEx(playerid,"PED","DOOR_RHinge_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 95: { ApplyAnimationEx(playerid,"PED","DrivebyL_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 96: { ApplyAnimationEx(playerid,"PED","DrivebyL_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 97: { ApplyAnimationEx(playerid,"PED","Driveby_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 98: { ApplyAnimationEx(playerid,"PED","Driveby_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 99: { ApplyAnimationEx(playerid,"PED","DRIVE_BOAT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 100: { ApplyAnimationEx(playerid,"PED","DRIVE_BOAT_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 101: { ApplyAnimationEx(playerid,"PED","DRIVE_BOAT_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 102: { ApplyAnimationEx(playerid,"PED","DRIVE_BOAT_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 103: { ApplyAnimationEx(playerid,"PED","Drive_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 104: { ApplyAnimationEx(playerid,"PED","Drive_LO_l",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 105: { ApplyAnimationEx(playerid,"PED","Drive_LO_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 106: { ApplyAnimationEx(playerid,"PED","Drive_L_pro",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 107: { ApplyAnimationEx(playerid,"PED","Drive_L_pro_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 108: { ApplyAnimationEx(playerid,"PED","Drive_L_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 109: { ApplyAnimationEx(playerid,"PED","Drive_L_weak",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 110: { ApplyAnimationEx(playerid,"PED","Drive_L_weak_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 111: { ApplyAnimationEx(playerid,"PED","Drive_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 112: { ApplyAnimationEx(playerid,"PED","Drive_R_pro",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 113: { ApplyAnimationEx(playerid,"PED","Drive_R_pro_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 114: { ApplyAnimationEx(playerid,"PED","Drive_R_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 115: { ApplyAnimationEx(playerid,"PED","Drive_R_weak",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 116: { ApplyAnimationEx(playerid,"PED","Drive_R_weak_slow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 117: { ApplyAnimationEx(playerid,"PED","Drive_truck",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 118: { ApplyAnimationEx(playerid,"PED","DRIVE_truck_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 119: { ApplyAnimationEx(playerid,"PED","DRIVE_truck_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 120: { ApplyAnimationEx(playerid,"PED","DRIVE_truck_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 121: { ApplyAnimationEx(playerid,"PED","Drown",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 122: { ApplyAnimationEx(playerid,"PED","DUCK_cower",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 123: { ApplyAnimationEx(playerid,"PED","endchat_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 124: { ApplyAnimationEx(playerid,"PED","endchat_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 125: { ApplyAnimationEx(playerid,"PED","endchat_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 126: { ApplyAnimationEx(playerid,"PED","EV_dive",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 127: { ApplyAnimationEx(playerid,"PED","EV_step",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 128: { ApplyAnimationEx(playerid,"PED","facanger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 129: { ApplyAnimationEx(playerid,"PED","facanger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 130: { ApplyAnimationEx(playerid,"PED","facgum",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 131: { ApplyAnimationEx(playerid,"PED","facsurp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 132: { ApplyAnimationEx(playerid,"PED","facsurpm",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 133: { ApplyAnimationEx(playerid,"PED","factalk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 134: { ApplyAnimationEx(playerid,"PED","facurios",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 135: { ApplyAnimationEx(playerid,"PED","FALL_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 136: { ApplyAnimationEx(playerid,"PED","FALL_collapse",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 137: { ApplyAnimationEx(playerid,"PED","FALL_fall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 138: { ApplyAnimationEx(playerid,"PED","FALL_front",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 139: { ApplyAnimationEx(playerid,"PED","FALL_glide",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 140: { ApplyAnimationEx(playerid,"PED","FALL_land",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 141: { ApplyAnimationEx(playerid,"PED","FALL_skyDive",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 142: { ApplyAnimationEx(playerid,"PED","Fight2Idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 143: { ApplyAnimationEx(playerid,"PED","FightA_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 144: { ApplyAnimationEx(playerid,"PED","FightA_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 145: { ApplyAnimationEx(playerid,"PED","FightA_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 146: { ApplyAnimationEx(playerid,"PED","FightA_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 147: { ApplyAnimationEx(playerid,"PED","FightA_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 148: { ApplyAnimationEx(playerid,"PED","FightA_M",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 149: { ApplyAnimationEx(playerid,"PED","FIGHTIDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 150: { ApplyAnimationEx(playerid,"PED","FightShB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 151: { ApplyAnimationEx(playerid,"PED","FightShF",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 152: { ApplyAnimationEx(playerid,"PED","FightSh_BWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 153: { ApplyAnimationEx(playerid,"PED","FightSh_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 154: { ApplyAnimationEx(playerid,"PED","FightSh_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 155: { ApplyAnimationEx(playerid,"PED","FightSh_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 156: { ApplyAnimationEx(playerid,"PED","flee_lkaround_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 157: { ApplyAnimationEx(playerid,"PED","FLOOR_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 158: { ApplyAnimationEx(playerid,"PED","FLOOR_hit_f",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 159: { ApplyAnimationEx(playerid,"PED","fucku",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 160: { ApplyAnimationEx(playerid,"PED","gang_gunstand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 161: { ApplyAnimationEx(playerid,"PED","gas_cwr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 162: { ApplyAnimationEx(playerid,"PED","getup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 163: { ApplyAnimationEx(playerid,"PED","getup_front",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 164: { ApplyAnimationEx(playerid,"PED","gum_eat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 165: { ApplyAnimationEx(playerid,"PED","GunCrouchBwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 166: { ApplyAnimationEx(playerid,"PED","GunCrouchFwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 167: { ApplyAnimationEx(playerid,"PED","GunMove_BWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 168: { ApplyAnimationEx(playerid,"PED","GunMove_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 169: { ApplyAnimationEx(playerid,"PED","GunMove_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 170: { ApplyAnimationEx(playerid,"PED","GunMove_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 171: { ApplyAnimationEx(playerid,"PED","Gun_2_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 172: { ApplyAnimationEx(playerid,"PED","GUN_BUTT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 173: { ApplyAnimationEx(playerid,"PED","GUN_BUTT_crouch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 174: { ApplyAnimationEx(playerid,"PED","Gun_stand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 175: { ApplyAnimationEx(playerid,"PED","handscower",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 176: { ApplyAnimationEx(playerid,"PED","handsup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 177: { ApplyAnimationEx(playerid,"PED","HitA_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 178: { ApplyAnimationEx(playerid,"PED","HitA_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 179: { ApplyAnimationEx(playerid,"PED","HitA_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 180: { ApplyAnimationEx(playerid,"PED","HIT_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 181: { ApplyAnimationEx(playerid,"PED","HIT_behind",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 182: { ApplyAnimationEx(playerid,"PED","HIT_front",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 183: { ApplyAnimationEx(playerid,"PED","HIT_GUN_BUTT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 184: { ApplyAnimationEx(playerid,"PED","HIT_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 185: { ApplyAnimationEx(playerid,"PED","HIT_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 186: { ApplyAnimationEx(playerid,"PED","HIT_walk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 187: { ApplyAnimationEx(playerid,"PED","HIT_wall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 188: { ApplyAnimationEx(playerid,"PED","Idlestance_fat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 189: { ApplyAnimationEx(playerid,"PED","idlestance_old",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 190: { ApplyAnimationEx(playerid,"PED","IDLE_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 191: { ApplyAnimationEx(playerid,"PED","IDLE_chat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 192: { ApplyAnimationEx(playerid,"PED","IDLE_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 193: { ApplyAnimationEx(playerid,"PED","Idle_Gang1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 194: { ApplyAnimationEx(playerid,"PED","IDLE_HBHB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 195: { ApplyAnimationEx(playerid,"PED","IDLE_ROCKET",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 196: { ApplyAnimationEx(playerid,"PED","IDLE_stance",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 197: { ApplyAnimationEx(playerid,"PED","IDLE_taxi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 198: { ApplyAnimationEx(playerid,"PED","IDLE_tired",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 199: { ApplyAnimationEx(playerid,"PED","Jetpack_Idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 200: { ApplyAnimationEx(playerid,"PED","JOG_femaleA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 201: { ApplyAnimationEx(playerid,"PED","JOG_maleA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 202: { ApplyAnimationEx(playerid,"PED","JUMP_glide",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 203: { ApplyAnimationEx(playerid,"PED","JUMP_land",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 204: { ApplyAnimationEx(playerid,"PED","JUMP_launch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 205: { ApplyAnimationEx(playerid,"PED","JUMP_launch_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 206: { ApplyAnimationEx(playerid,"PED","KART_drive",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 207: { ApplyAnimationEx(playerid,"PED","KART_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 208: { ApplyAnimationEx(playerid,"PED","KART_LB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 209: { ApplyAnimationEx(playerid,"PED","KART_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 210: { ApplyAnimationEx(playerid,"PED","KD_left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 211: { ApplyAnimationEx(playerid,"PED","KD_right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 212: { ApplyAnimationEx(playerid,"PED","KO_shot_face",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 213: { ApplyAnimationEx(playerid,"PED","KO_shot_front",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 214: { ApplyAnimationEx(playerid,"PED","KO_shot_stom",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 215: { ApplyAnimationEx(playerid,"PED","KO_skid_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 216: { ApplyAnimationEx(playerid,"PED","KO_skid_front",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 217: { ApplyAnimationEx(playerid,"PED","KO_spin_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 218: { ApplyAnimationEx(playerid,"PED","KO_spin_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 219: { ApplyAnimationEx(playerid,"PED","pass_Smoke_in_car",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 220: { ApplyAnimationEx(playerid,"PED","phone_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 221: { ApplyAnimationEx(playerid,"PED","phone_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 222: { ApplyAnimationEx(playerid,"PED","phone_talk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 223: { ApplyAnimationEx(playerid,"PED","Player_Sneak",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 224: { ApplyAnimationEx(playerid,"PED","Player_Sneak_walkstart",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 225: { ApplyAnimationEx(playerid,"PED","roadcross",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 226: { ApplyAnimationEx(playerid,"PED","roadcross_female",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 227: { ApplyAnimationEx(playerid,"PED","roadcross_gang",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 228: { ApplyAnimationEx(playerid,"PED","roadcross_old",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 229: { ApplyAnimationEx(playerid,"PED","run_1armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 230: { ApplyAnimationEx(playerid,"PED","run_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 231: { ApplyAnimationEx(playerid,"PED","run_civi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 232: { ApplyAnimationEx(playerid,"PED","run_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 233: { ApplyAnimationEx(playerid,"PED","run_fat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 234: { ApplyAnimationEx(playerid,"PED","run_fatold",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 235: { ApplyAnimationEx(playerid,"PED","run_gang1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 236: { ApplyAnimationEx(playerid,"PED","run_left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 237: { ApplyAnimationEx(playerid,"PED","run_old",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 238: { ApplyAnimationEx(playerid,"PED","run_player",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 239: { ApplyAnimationEx(playerid,"PED","run_right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 240: { ApplyAnimationEx(playerid,"PED","run_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 241: { ApplyAnimationEx(playerid,"PED","Run_stop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 242: { ApplyAnimationEx(playerid,"PED","Run_stopR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 243: { ApplyAnimationEx(playerid,"PED","Run_Wuzi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 244: { ApplyAnimationEx(playerid,"PED","SEAT_down",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 245: { ApplyAnimationEx(playerid,"PED","SEAT_idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 246: { ApplyAnimationEx(playerid,"PED","SEAT_up",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 247: { ApplyAnimationEx(playerid,"PED","SHOT_leftP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 248: { ApplyAnimationEx(playerid,"PED","SHOT_partial",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 249: { ApplyAnimationEx(playerid,"PED","SHOT_partial_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 250: { ApplyAnimationEx(playerid,"PED","SHOT_rightP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 251: { ApplyAnimationEx(playerid,"PED","Shove_Partial",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 252: { ApplyAnimationEx(playerid,"PED","Smoke_in_car",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 253: { ApplyAnimationEx(playerid,"PED","sprint_civi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 254: { ApplyAnimationEx(playerid,"PED","sprint_panic",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 255: { ApplyAnimationEx(playerid,"PED","Sprint_Wuzi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 256: { ApplyAnimationEx(playerid,"PED","swat_run",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 257: { ApplyAnimationEx(playerid,"PED","Swim_Tread",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 258: { ApplyAnimationEx(playerid,"PED","Tap_hand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 259: { ApplyAnimationEx(playerid,"PED","Tap_handP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 260: { ApplyAnimationEx(playerid,"PED","turn_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 261: { ApplyAnimationEx(playerid,"PED","Turn_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 262: { ApplyAnimationEx(playerid,"PED","Turn_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 263: { ApplyAnimationEx(playerid,"PED","WALK_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 264: { ApplyAnimationEx(playerid,"PED","WALK_civi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 265: { ApplyAnimationEx(playerid,"PED","WALK_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 266: { ApplyAnimationEx(playerid,"PED","Walk_DoorPartial",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 267: { ApplyAnimationEx(playerid,"PED","WALK_drunk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 268: { ApplyAnimationEx(playerid,"PED","WALK_fat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 269: { ApplyAnimationEx(playerid,"PED","WALK_fatold",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 270: { ApplyAnimationEx(playerid,"PED","WALK_gang1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 271: { ApplyAnimationEx(playerid,"PED","WALK_gang2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 272: { ApplyAnimationEx(playerid,"PED","WALK_old",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 273: { ApplyAnimationEx(playerid,"PED","WALK_player",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 274: { ApplyAnimationEx(playerid,"PED","WALK_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 275: { ApplyAnimationEx(playerid,"PED","WALK_shuffle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 276: { ApplyAnimationEx(playerid,"PED","WALK_start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 277: { ApplyAnimationEx(playerid,"PED","WALK_start_armed",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 278: { ApplyAnimationEx(playerid,"PED","WALK_start_csaw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 279: { ApplyAnimationEx(playerid,"PED","WALK_start_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 280: { ApplyAnimationEx(playerid,"PED","Walk_Wuzi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 281: { ApplyAnimationEx(playerid,"PED","WEAPON_crouch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 282: { ApplyAnimationEx(playerid,"PED","woman_idlestance",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 283: { ApplyAnimationEx(playerid,"PED","woman_run",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 284: { ApplyAnimationEx(playerid,"PED","WOMAN_runbusy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 285: { ApplyAnimationEx(playerid,"PED","WOMAN_runfatold",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 286: { ApplyAnimationEx(playerid,"PED","woman_runpanic",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 287: { ApplyAnimationEx(playerid,"PED","WOMAN_runsexy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 288: { ApplyAnimationEx(playerid,"PED","WOMAN_walkbusy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 289: { ApplyAnimationEx(playerid,"PED","WOMAN_walkfatold",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 290: { ApplyAnimationEx(playerid,"PED","WOMAN_walknorm",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 291: { ApplyAnimationEx(playerid,"PED","WOMAN_walkold",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 292: { ApplyAnimationEx(playerid,"PED","WOMAN_walkpro",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 293: { ApplyAnimationEx(playerid,"PED","WOMAN_walksexy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 294: { ApplyAnimationEx(playerid,"PED","WOMAN_walkshop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 295: { ApplyAnimationEx(playerid,"PED","XPRESSscratch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpdvbys(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpdvbys",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PLAYER_DVBYS","Plyr_DrivebyBwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PLAYER_DVBYS","Plyr_DrivebyFwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PLAYER_DVBYS","Plyr_DrivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"PLAYER_DVBYS","Plyr_DrivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animplayidles(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animplayidles",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"PLAYIDLES","shift",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PLAYIDLES","shldr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"PLAYIDLES","stretch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"PLAYIDLES","strleg",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"PLAYIDLES","time",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpolice(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpolice",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"POLICE","CopTraf_Away",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"POLICE","CopTraf_Come",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"POLICE","CopTraf_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"POLICE","CopTraf_Stop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"POLICE","COP_getoutcar_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"POLICE","Cop_move_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"POLICE","crm_drgbst_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"POLICE","Door_Kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"POLICE","plc_drgbst_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"POLICE","plc_drgbst_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpool(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpool",1,21,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"POOL","POOL_ChalkCue",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"POOL","POOL_Idle_Stance",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"POOL","POOL_Long_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"POOL","POOL_Long_Shot_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"POOL","POOL_Long_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"POOL","POOL_Long_Start_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"POOL","POOL_Med_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"POOL","POOL_Med_Shot_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"POOL","POOL_Med_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"POOL","POOL_Med_Start_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"POOL","POOL_Place_White",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"POOL","POOL_Short_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"POOL","POOL_Short_Shot_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"POOL","POOL_Short_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"POOL","POOL_Short_Start_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"POOL","POOL_Walk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"POOL","POOL_Walk_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"POOL","POOL_XLong_Shot",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"POOL","POOL_XLong_Shot_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"POOL","POOL_XLong_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"POOL","POOL_XLong_Start_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpoor(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpoo",1,2,aid);
	switch(aid) {
		    case 1: { ApplyAnimationEx(playerid,"POOR","WINWASH_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		    case 2: { ApplyAnimationEx(playerid,"POOR","WINWASH_Wash2Beg",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animpython(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animpython",1,5,aid);
	switch(aid) {
	    case 1: { ApplyAnimationEx(playerid,"PYTHON","python_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"PYTHON","python_crouchreload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 3: { ApplyAnimationEx(playerid,"PYTHON","python_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 4: { ApplyAnimationEx(playerid,"PYTHON","python_fire_poor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	    case 5: { ApplyAnimationEx(playerid,"PYTHON","python_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animquad(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animquad",1,17,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"QUAD","QUAD_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"QUAD","QUAD_driveby_FT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"QUAD","QUAD_driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"QUAD","QUAD_driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"QUAD","QUAD_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"QUAD","QUAD_getoff_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"QUAD","QUAD_getoff_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"QUAD","QUAD_getoff_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"QUAD","QUAD_geton_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"QUAD","QUAD_geton_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"QUAD","QUAD_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"QUAD","QUAD_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"QUAD","QUAD_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"QUAD","QUAD_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"QUAD","QUAD_reverse",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"QUAD","QUAD_ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"QUAD","QUAD_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animquadbz(playerid,p[]) {
	aid = iparam(p,' ',0);ErrorMessage(playerid,"/animquadbz",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"QUAD_DBZ","Pass_Driveby_BWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"QUAD_DBZ","Pass_Driveby_FWD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"QUAD_DBZ","Pass_Driveby_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"QUAD_DBZ","Pass_Driveby_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animrifle(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animrifle",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"RIFLE","RIFLE_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"RIFLE","RIFLE_crouchload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"RIFLE","RIFLE_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"RIFLE","RIFLE_fire_poor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"RIFLE","RIFLE_load",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animriot(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animriot",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"RIOT","RIOT_ANGRY",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"RIOT","RIOT_ANGRY_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"RIOT","RIOT_challenge",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"RIOT","RIOT_CHANT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"RIOT","RIOT_FUKU",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"RIOT","RIOT_PUNCHES",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"RIOT","RIOT_shout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animrobbank(playerid,p[]) {
	aid = iparam(p,' ',0);	ErrorMessage(playerid,"/animrobbank",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"ROB_BANK","CAT_Safe_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"ROB_BANK","CAT_Safe_Open",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"ROB_BANK","CAT_Safe_Open_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"ROB_BANK","CAT_Safe_Rob",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"ROB_BANK","SHP_HandsUp_Scr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animrocket(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animrocket",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"ROCKET","idle_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"ROCKET","RocketFire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"ROCKET","run_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"ROCKET","walk_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"ROCKET","WALK_start_rocket",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animrustler(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animrustler",1,5,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"RUSTLER","Plane_align_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"RUSTLER","Plane_close",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"RUSTLER","Plane_getin",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"RUSTLER","Plane_getout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"RUSTLER","Plane_open",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animryder(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animryder",1,16,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"RYDER","RYD_Beckon_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"RYDER","RYD_Beckon_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"RYDER","RYD_Beckon_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"RYDER","RYD_Die_PT1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"RYDER","RYD_Die_PT2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"RYDER","Van_Crate_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"RYDER","Van_Crate_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"RYDER","Van_Fall_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"RYDER","Van_Fall_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"RYDER","Van_Lean_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"RYDER","Van_Lean_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"RYDER","VAN_PickUp_E",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"RYDER","VAN_PickUp_S",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"RYDER","Van_Stand",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"RYDER","Van_Stand_Crate",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"RYDER","Van_Throw",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animscratching(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animscratching",1,12,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"SCRATCHING","scdldlp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SCRATCHING","scdlulp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SCRATCHING","scdrdlp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SCRATCHING","scdrulp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SCRATCHING","sclng_l",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SCRATCHING","sclng_r",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SCRATCHING","scmid_l",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SCRATCHING","scmid_r",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"SCRATCHING","scshrtl",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"SCRATCHING","scshrtr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"SCRATCHING","sc_ltor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"SCRATCHING","sc_rtol",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animshamal(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animshamal",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SHAMAL","SHAMAL_align",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SHAMAL","SHAMAL_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SHAMAL","SHAMAL_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SHAMAL","SHAMAL_open",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animshop(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animshop",1,25,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"SHOP","ROB_2Idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SHOP","ROB_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SHOP","ROB_Loop_Threat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SHOP","ROB_Shifty",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SHOP","ROB_StickUp_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SHOP","SHP_Duck",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SHOP","SHP_Duck_Aim",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SHOP","SHP_Duck_Fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Aim",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Duck",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Grab",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"SHOP","SHP_Gun_Threat",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"SHOP","SHP_HandsUp_Scr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"SHOP","SHP_Jump_Glide",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"SHOP","SHP_Jump_Land",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"SHOP","SHP_Jump_Launch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"SHOP","SHP_Rob_GiveCash",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"SHOP","SHP_Rob_HandsUp",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"SHOP","SHP_Rob_React",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"SHOP","SHP_Serve_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"SHOP","SHP_Serve_Idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"SHOP","SHP_Serve_Loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"SHOP","SHP_Serve_Start",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"SHOP","Smoke_RYD",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animshotgun(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animshotgun",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SHOTGUN","shotgun_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SHOTGUN","shotgun_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SHOTGUN","shotgun_fire_poor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsilenced(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsilenced",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SILENCED","CrouchReload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SILENCED","SilenceCrouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SILENCED","Silence_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SILENCED","Silence_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animskate(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animskate",1,3,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SKATE","skate_idle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SKATE","skate_run",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SKATE","skate_sprint",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsmoking(playerid,p[]) {
	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsmoking",1,8,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SMOKING","F_smklean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SMOKING","M_smklean_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SMOKING","M_smkstnd_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SMOKING","M_smk_drag",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SMOKING","M_smk_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SMOKING","M_smk_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SMOKING","M_smk_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SMOKING","M_smk_tap",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsniper(playerid,p[]) {
    #pragma unused p
    ApplyAnimationEx(playerid,"SNIPER","WEAPON_sniper",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]);
	return 1; }

dcmd_animspraycan(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animspraycan",1,2,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SPRAYCAN","spraycan_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SPRAYCAN","spraycan_full",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animstrip(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animstrip",1,20,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"STRIP","PLY_CASH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"STRIP","PUN_CASH",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"STRIP","PUN_HOLLER",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"STRIP","PUN_LOOP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"STRIP","strip_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"STRIP","strip_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"STRIP","strip_C",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"STRIP","strip_D",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"STRIP","strip_E",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"STRIP","strip_F",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"STRIP","strip_G",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"STRIP","STR_A2B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"STRIP","STR_B2A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"STRIP","STR_B2C",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"STRIP","STR_C1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"STRIP","STR_C2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"STRIP","STR_C2B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"STRIP","STR_Loop_A",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"STRIP","STR_Loop_B",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"STRIP","STR_Loop_C",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsunbathe(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsunbathe",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SUNBATHE","batherdown",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SUNBATHE","batherup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SUNBATHE","Lay_Bac_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SUNBATHE","Lay_Bac_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_M_IdleA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_M_IdleB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_M_IdleC",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_M_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_M_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_W_idleA",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_W_idleB",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_W_idleC",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_W_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"SUNBATHE","ParkSit_W_out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"SUNBATHE","SBATHE_F_LieB2Sit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"SUNBATHE","SBATHE_F_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"SUNBATHE","SitnWait_in_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"SUNBATHE","SitnWait_out_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animswat(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animswat",1,23,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SWAT","gnstwall_injurd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SWAT","JMP_Wall1m_180",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SWAT","Rail_fall",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SWAT","Rail_fall_crawl",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SWAT","swt_breach_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SWAT","swt_breach_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SWAT","swt_breach_03",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SWAT","swt_go",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"SWAT","swt_lkt",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"SWAT","swt_sty",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"SWAT","swt_vent_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"SWAT","swt_vent_02",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"SWAT","swt_vnt_sht_die",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"SWAT","swt_vnt_sht_in",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"SWAT","swt_vnt_sht_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"SWAT","swt_wllpk_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"SWAT","swt_wllpk_L_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"SWAT","swt_wllpk_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"SWAT","swt_wllpk_R_back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"SWAT","swt_wllshoot_in_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"SWAT","swt_wllshoot_in_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"SWAT","swt_wllshoot_out_L",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"SWAT","swt_wllshoot_out_R",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsweet(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsweet",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SWEET","ho_ass_slapped",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SWEET","LaFin_Player",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SWEET","LaFin_Sweet",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SWEET","plyr_hndshldr_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SWEET","sweet_ass_slap",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SWEET","sweet_hndshldr_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SWEET","Sweet_injuredloop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }


dcmd_animswim(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animswim",1,7,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SWIM","Swim_Breast",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SWIM","SWIM_crawl",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SWIM","Swim_Dive_Under",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SWIM","Swim_Glide",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SWIM","Swim_jumpout",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SWIM","Swim_Tread",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SWIM","Swim_Under",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsword(playerid,p[])
{
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsword",1,10,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SWORD","sword_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SWORD","sword_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SWORD","sword_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SWORD","sword_4",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SWORD","sword_block",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SWORD","Sword_Hit_1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SWORD","Sword_Hit_2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SWORD","Sword_Hit_3",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"SWORD","sword_IDLE",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"SWORD","sword_part",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtank(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtank",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"TANK","TANK_align_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"TANK","TANK_close_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"TANK","TANK_doorlocked",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"TANK","TANK_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"TANK","TANK_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"TANK","TANK_open_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtattoo(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtattoo",1,57,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Pose_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Pose_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmL_Pose_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Pose_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Pose_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"TATTOOS","TAT_ArmR_Pose_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 19: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 20: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 21: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 22: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 23: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 24: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 25: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Pose_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 26: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Pose_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 27: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Pose_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 28: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Sit_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 29: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Sit_Loop_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 30: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Back_Sit_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 31: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 32: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 33: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 34: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 35: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_Pose_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 36: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Bel_Pose_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 37: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 38: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 39: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 40: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 41: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 42: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 43: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Pose_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 44: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Pose_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 45: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Che_Pose_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 46: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Drop_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 47: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Idle_Loop_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 48: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Idle_Loop_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 49: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_In_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 50: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_In_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 51: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_In_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 52: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Loop_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 53: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Loop_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 54: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Loop_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 55: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Out_O",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 56: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Out_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 57: { ApplyAnimationEx(playerid,"TATTOOS","TAT_Sit_Out_T",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtec(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtec",1,4,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"TEC","TEC_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"TEC","TEC_crouchreload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"TEC","TEC_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"TEC","TEC_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtrain(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtrain",1,4,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"TRAIN","tran_gtup",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"TRAIN","tran_hng",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"TRAIN","tran_ouch",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"TRAIN","tran_stmb",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animtruck(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animtruck",1,17,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_ALIGN_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_ALIGN_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_closedoor_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_closedoor_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_close_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_close_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_getin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_getin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_jackedLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_jackedRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_open_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_open_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_pullout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_pullout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"TRUCK","TRUCK_Shuffle",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animuzi(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animuzi",1,5,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"UZI","UZI_crouchfire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"UZI","UZI_crouchreload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"UZI","UZI_fire",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"UZI","UZI_fire_poor",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"UZI","UZI_reload",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animvan(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animvan",1,8,aid);
	switch(aid)	{
		case 1: { ApplyAnimationEx(playerid,"VAN","VAN_close_back_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"VAN","VAN_close_back_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"VAN","VAN_getin_Back_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"VAN","VAN_getin_Back_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"VAN","VAN_getout_back_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"VAN","VAN_getout_back_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"VAN","VAN_open_back_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"VAN","VAN_open_back_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animvedding(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animvedding",1,6,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"VENDING","VEND_Drink2_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"VENDING","VEND_Drink_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"VENDING","vend_eat1_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"VENDING","VEND_Eat_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"VENDING","VEND_Use",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"VENDING","VEND_Use_pt2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animvortex(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animvortex",1,4,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"VORTEX","CAR_jumpin_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"VORTEX","CAR_jumpin_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"VORTEX","vortex_getout_LHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"VORTEX","vortex_getout_RHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animwayfarer(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animwayfarer",1,18,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"WAYFARER","WF_Back",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"WAYFARER","WF_drivebyFT",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"WAYFARER","WF_drivebyLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"WAYFARER","WF_drivebyRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"WAYFARER","WF_Fwd",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"WAYFARER","WF_getoffBACK",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"WAYFARER","WF_getoffLHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"WAYFARER","WF_getoffRHS",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"WAYFARER","WF_hit",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"WAYFARER","WF_jumponL",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"WAYFARER","WF_jumponR",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"WAYFARER","WF_kick",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"WAYFARER","WF_Left",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"WAYFARER","WF_passenger",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"WAYFARER","WF_pushes",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"WAYFARER","WF_Ride",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"WAYFARER","WF_Right",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 18: { ApplyAnimationEx(playerid,"WAYFARER","WF_Still",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animweapons(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animweapons",1,17,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"WEAPONS","SHP_1H_Lift",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"WEAPONS","SHP_1H_Lift_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"WEAPONS","SHP_1H_Ret",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"WEAPONS","SHP_1H_Ret_S",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"WEAPONS","SHP_2H_Lift",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"WEAPONS","SHP_2H_Lift_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"WEAPONS","SHP_2H_Ret",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"WEAPONS","SHP_2H_Ret_S",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Ar_Lift",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Ar_Lift_End",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Ar_Ret",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Ar_Ret_S",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 13: { ApplyAnimationEx(playerid,"WEAPONS","SHP_G_Lift_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 14: { ApplyAnimationEx(playerid,"WEAPONS","SHP_G_Lift_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 15: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Tray_In",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 16: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Tray_Out",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 17: { ApplyAnimationEx(playerid,"WEAPONS","SHP_Tray_Pose",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animwuzi(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animwuzi",1,12,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"WUZI","CS_Dead_Guy",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"WUZI","CS_Plyr_pt1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"WUZI","CS_Plyr_pt2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"WUZI","CS_Wuzi_pt1",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"WUZI","CS_Wuzi_pt2",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"WUZI","Walkstart_Idle_01",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"WUZI","Wuzi_follow",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"WUZI","Wuzi_Greet_Plyr",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"WUZI","Wuzi_Greet_Wuzi",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"WUZI","Wuzi_grnd_chk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"WUZI","Wuzi_stand_loop",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"WUZI","Wuzi_Walk",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animsex(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animsex",1,8,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"SNM","SPANKING_IDLEW",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"SNM","SPANKING_IDLEP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"SNM","SPANKINGW",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"SNM","SPANKINGP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"SNM","SPANKEDW",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"SNM","SPANKEDP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"SNM","SPANKING_ENDW",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"SNM","SPANKING_ENDP",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }

dcmd_animblowjob(playerid,p[]) {
   	aid = iparam(p,' ',0); ErrorMessage(playerid,"/animblowjob",1,12,aid);
	switch(aid) {
		case 1: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_START_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 2: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_START_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 3: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 4: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 5: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_END_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 6: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_COUCH_END_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 7: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_START_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 8: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_START_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 9: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_LOOP_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 10: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_LOOP_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 11: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_END_P",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
		case 12: { ApplyAnimationEx(playerid,"BLOWJOBZ","BJ_STAND_END_W",fifa[playerid],O1[playerid],O2[playerid],O3[playerid],O4[playerid],O5[playerid]); }
	} return 1; }
