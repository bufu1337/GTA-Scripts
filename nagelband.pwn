#include <a_samp>

/*
-------------------------- C R E D I T S --------------------------------------
########################## Script Original by Trooper #########################
########################## Dank geht an [FoD]Marciii  #########################

-------------------------- E D I T    C R E D I T S ---------------------------
########################## Übernommen von -dein name- #########################
########################## Editiert von -dein name-   #########################

------------------------- C O P Y R I G H T -----------------------------------
############ Copyright by Nicksoft (Nicolas.Giese@web.de) #####################
######################## Webseite www.Nicksoft.tk     #########################
######################## Blog http://nicksoft.blogmonster.de/ #################
######################## Twitter www.twitter.com/Blasium ######################
######################## ICQ Support 255070270        #########################

------------------------- B E D I N G U N G -----------------------------------
##### Script darf verändert , nicht kommerziell benutzt werden und muss #######
############# unter denselben Bedingungen weitergegeben werden ################
################### Sollte das Script ohne Credits benutzt werden #############
################### hat das eine Sperrung des Quellcodes zufolge ##############

------------------------- B E F E H L E ---------------------------------------
######### /nagelband -> Legt nagelband (erfordert Regierungsskin) #############
######### /bandweg [ID] -> ENtfernt Nagelband (erfordert Regierungsskin) ######
######### /setskin -> Gibt Regierungsskin (erfordert testing = 1) #############
######### /resetband -> Entfernt Nagelbänder (erfordert RCON Admin) ###########
######### /reifenersetzen -> Heilt Wagen (erfordert spezielle pay`n`spray) ####
*/


//--------------------- Server Einstellungen ----------------------------------

// _________________________ Testmodus ________________________________________
new testing = 1; //wenn "testing = 1;", kann man den Befehl /setskin benutzen, um sich sofort zu einem Polizisten zu verwandeln
// _________________________ Performance ______________________________________
new checkms = 50; //wie oft soll nach nagelbändern geprüft werden (in MS), je höher desto schnellere Autos werden erkannt, 50 schien aber in Testen ausreichend
new ruckelms = 200; //wie oft bei kaputten Reifen die Lenkung blockiert (in MS)
new checkmssparend = 500; // wenn reifen bereits kaputt, wie oft soll nach nagelbändern geprüft werden (kann recht hoch gestellt werden)
// _________________________ Reperatur ________________________________________
new kosten = 200; //kosten einer reifen flickerei (man bedenke, die 100$ vom PaynSpray sind ausgenommen)
new moeglichradius = 4; //radius der pay`n`sprays, wo man /reifenersetzen benutzen kann

/*
########################### Wichtig !!!! ####################################
Wenn Sie nicht Scripten können, lassen Sie den Teil unterhalb dieser Zeilen  bitte so.
Editieren Sie lediglich, wovon Sie wissen, wie es funktioniert !
Ich gebe keinen Support für Dinge, die im Scripteigenen Teil falsch editiert wurden !

Wenn Sie mehr Nagelbänder einbauen wollen, suchen Sie bitte alle CreateObject & switch befehle !
Dazumal müssen die Variablen erhöht werden !
Wollen Sie mehr Nagelbänder einbauen, bedenken Sie bitte auch, dass ab einer bestimmten Anzahl von
Bändern ein Streamer unabdingbar ist !
*/
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFFF
new countgelegte = 0;
new output[48];
forward IsACop(playerid);
new Float:placedx[21];//maximum + 1
new Float:placedy[21];//maximum + 1
new Float:placedz[21];//maximum + 1
forward restore(id,playerid);
forward check(playerid);
forward reifenschrottkeys(playerid);
new blocked[MAX_PLAYERS];
new reifenheil[MAX_VEHICLES]; //1 = heil, 0 = kaputt
new checktimer[MAX_PLAYERS];
new found = 0;
new nagelband0;
new nagelband1;
new nagelband2;
new nagelband3;
new nagelband4;
new nagelband5;
new nagelband6;
new nagelband7;
new nagelband8;
new nagelband9;
new nagelband10;
new nagelband11;
new nagelband12;
new nagelband13;
new nagelband14;
new nagelband15;
new nagelband16;
new nagelband17;
new nagelband18;
new nagelband19;
new nagelband20;
new nagelindex[21]=0;//maximum + 1
public OnFilterScriptInit(){
    AntiDeAMX();
	for(new i; i<MAX_VEHICLES; i++)
	{
	    reifenheil[i] = 1;
	}
	for(new i;i<MAX_PLAYERS; i++)
	{
		checktimer[i] = SetTimerEx("check",5000,0,"i",i);
	}
    nagelband0 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband1 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband2 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband3 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband4 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband5 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband6 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband7 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband8 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband9 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband10 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband11 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband12 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband13 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband14 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband15 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband16 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband17 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband18 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband19 = CreateObject(1593,0,0,-3000,0,0,0);
    nagelband20 = CreateObject(1593,0,0,-3000,0,0,0);
	print("\n--------------------------------------");
	print(" Nagelband Serveraddon (c) Trooper 2009");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit(){
    for(new d;d<MAX_PLAYERS; d++)
	{
	    if(IsPlayerConnected(d) && IsACop(d))
	    {
	        SendClientMessage(d,COLOR_YELLOW,"Alle Nagelbänder wurden entfernt, da das Script neugeladen wurde !");
	    }
	}
	DestroyObject(nagelband0);
	DestroyObject(nagelband1);
	DestroyObject(nagelband2);
	DestroyObject(nagelband3);
	DestroyObject(nagelband4);
	DestroyObject(nagelband5);
	DestroyObject(nagelband6);
	DestroyObject(nagelband7);
	DestroyObject(nagelband8);
	DestroyObject(nagelband9);
	DestroyObject(nagelband10);
	DestroyObject(nagelband11);
	DestroyObject(nagelband12);
	DestroyObject(nagelband13);
	DestroyObject(nagelband14);
	DestroyObject(nagelband15);
	DestroyObject(nagelband16);
	DestroyObject(nagelband17);
	DestroyObject(nagelband18);
	DestroyObject(nagelband19);
	DestroyObject(nagelband20);
	print("\n----------------------------------");
	print(" Nagelband Serveraddon deaktiviert");
	print("----------------------------------\n");
	return 1;
}

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

public OnPlayerConnect(playerid){
	blocked[playerid] = 0;
	checktimer[playerid] = SetTimerEx("check",12000,0,"i",playerid); //extra hoch, da wohl kaum spieler, die grad connected sind, in ein auto steigen und sofort über n nagelband fahren :D
	return 1;
}

public OnPlayerDisconnect(playerid, reason){
	KillTimer(checktimer[playerid]);
	return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
	blocked[playerid] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[]){
    dcmd(nagelband , 9 , cmdtext);
    dcmd(setskin , 7 , cmdtext);
    dcmd(resetband , 9 , cmdtext);
    dcmd(reifenersetzen , 14 , cmdtext);
    new   idx,
	    cmd[128];
	cmd=strtok(cmdtext,idx);
	if(!strcmp(cmd,"/bandweg",true,5))
	{
		new
		    sID[128],
		    pID;
		sID=strtok(cmdtext,idx);
		if(!strlen(sID))
		{
		    return SendClientMessage(playerid,COLOR_RED,"Syntax: /bandweg [ID]");
		}
		if(!IsACop(playerid))
		{
		    return SendClientMessage(playerid,COLOR_RED,"Du bist kein Polizist !");
		}
		pID=strval(sID);
		if(pID < 0 || pID > 20)
	    {
	        return SendClientMessage(playerid,COLOR_RED,"Soviele Nagelbänder gibt es (noch) nicht !");
	    }
		if(nagelindex[pID] != 1)
		{
		    return SendClientMessage(playerid,COLOR_RED,"Nagelband wurde noch nicht gelegt !");
		}
		switch(pID)
		{
	    	case 0:SetObjectPos(nagelband0,0,0,-1000);
	    	case 1:SetObjectPos(nagelband1,0,0,-1000);
	    	case 2:SetObjectPos(nagelband2,0,0,-1000);
	    	case 3:SetObjectPos(nagelband3,0,0,-1000);
	    	case 4:SetObjectPos(nagelband4,0,0,-1000);
	    	case 5:SetObjectPos(nagelband5,0,0,-1000);
	    	case 6:SetObjectPos(nagelband6,0,0,-1000);
	    	case 7:SetObjectPos(nagelband7,0,0,-1000);
	    	case 8:SetObjectPos(nagelband8,0,0,-1000);
	    	case 9:SetObjectPos(nagelband9,0,0,-1000);
	    	case 10:SetObjectPos(nagelband10,0,0,-1000);
	    	case 11:SetObjectPos(nagelband11,0,0,-1000);
	    	case 12:SetObjectPos(nagelband12,0,0,-1000);
	    	case 13:SetObjectPos(nagelband13,0,0,-1000);
	    	case 14:SetObjectPos(nagelband14,0,0,-1000);
	    	case 15:SetObjectPos(nagelband15,0,0,-1000);
	    	case 16:SetObjectPos(nagelband16,0,0,-1000);
	    	case 17:SetObjectPos(nagelband17,0,0,-1000);
	    	case 18:SetObjectPos(nagelband18,0,0,-1000);
	    	case 19:SetObjectPos(nagelband19,0,0,-1000);
	    	case 20:SetObjectPos(nagelband20,0,0,-1000);
	    }
	    nagelindex[pID] = 0;
	    placedx[pID] = 0;
	    placedy[pID] = 0;
	    placedz[pID] = -1000;
	    SendClientMessage(playerid,COLOR_GREEN,"Nagelband erfolgreich entfernt !");
		return 1;
	}
	return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
	if((newstate == 3 || newstate == 2) && reifenheil[GetPlayerVehicleID(playerid)] == 0)
    {
        SendClientMessage(playerid,COLOR_RED,"Dieses Fahrzeug hat zerstochene Reifen !");
    	SetTimerEx("reifenschrottkeys",ruckelms,0,"i",playerid);
	}
	return 1;
}
public IsACop(playerid){
	if(GetPlayerSkin(playerid) == 280 || GetPlayerSkin(playerid) == 281 || GetPlayerSkin(playerid) == 282 || GetPlayerSkin(playerid) == 283 || GetPlayerSkin(playerid) == 284 || GetPlayerSkin(playerid) == 285 || GetPlayerSkin(playerid) == 286 || GetPlayerSkin(playerid) == 287 || GetPlayerSkin(playerid) == 288)
	{
		return true;
	}
	else
	{
		return false;
	}
}
dcmd_nagelband(playerid,params[]){
    #pragma unused params
	if(IsACop(playerid))
	{
	    new Float: X;
		new Float: Y;
		new Float: Z;
		new Float: A; //Angle
		GetPlayerPos(playerid, X, Y ,Z);
		Z = Z - 0.8; //damits aufm boden liegt
		GetPlayerFacingAngle(playerid, A);
		X += (5 * floatsin(-A, degrees));
		Y += (5 * floatcos(-A, degrees));
        if(countgelegte != 20+1)
        {
			switch(countgelegte)
			{
		    	case 0:SetObjectPos(nagelband0,X,Y,Z);
		    	case 1:SetObjectPos(nagelband1,X,Y,Z);
		    	case 2:SetObjectPos(nagelband2,X,Y,Z);
		    	case 3:SetObjectPos(nagelband3,X,Y,Z);
		    	case 4:SetObjectPos(nagelband4,X,Y,Z);
		    	case 5:SetObjectPos(nagelband5,X,Y,Z);
		    	case 6:SetObjectPos(nagelband6,X,Y,Z);
		    	case 7:SetObjectPos(nagelband7,X,Y,Z);
		    	case 8:SetObjectPos(nagelband8,X,Y,Z);
		    	case 9:SetObjectPos(nagelband9,X,Y,Z);
		    	case 10:SetObjectPos(nagelband10,X,Y,Z);
		    	case 11:SetObjectPos(nagelband11,X,Y,Z);
		    	case 12:SetObjectPos(nagelband12,X,Y,Z);
		    	case 13:SetObjectPos(nagelband13,X,Y,Z);
		    	case 14:SetObjectPos(nagelband14,X,Y,Z);
		    	case 15:SetObjectPos(nagelband15,X,Y,Z);
		    	case 16:SetObjectPos(nagelband16,X,Y,Z);
		    	case 17:SetObjectPos(nagelband17,X,Y,Z);
		    	case 18:SetObjectPos(nagelband18,X,Y,Z);
		    	case 19:SetObjectPos(nagelband19,X,Y,Z);
		    	case 20:SetObjectPos(nagelband20,X,Y,Z);
		    }
		    new Float:tempx,Float:tempy; //eig. hatte ich nur GetPlayerPos vergessen, ging aber so super
		    switch(countgelegte)
		    {
		        case 0:SetObjectRot(nagelband0,tempx,tempy,A);
		        case 1:SetObjectRot(nagelband1,tempx,tempy,A);
		        case 2:SetObjectRot(nagelband2,tempx,tempy,A);
		        case 3:SetObjectRot(nagelband3,tempx,tempy,A);
		        case 4:SetObjectRot(nagelband4,tempx,tempy,A);
		        case 5:SetObjectRot(nagelband5,tempx,tempy,A);
		        case 6:SetObjectRot(nagelband6,tempx,tempy,A);
		        case 7:SetObjectRot(nagelband7,tempx,tempy,A);
		        case 8:SetObjectRot(nagelband8,tempx,tempy,A);
		        case 9:SetObjectRot(nagelband9,tempx,tempy,A);
		        case 10:SetObjectRot(nagelband10,tempx,tempy,A);
		        case 11:SetObjectRot(nagelband11,tempx,tempy,A);
		        case 12:SetObjectRot(nagelband12,tempx,tempy,A);
		        case 13:SetObjectRot(nagelband13,tempx,tempy,A);
		        case 14:SetObjectRot(nagelband14,tempx,tempy,A);
		        case 15:SetObjectRot(nagelband15,tempx,tempy,A);
		        case 16:SetObjectRot(nagelband16,tempx,tempy,A);
		        case 17:SetObjectRot(nagelband17,tempx,tempy,A);
		        case 18:SetObjectRot(nagelband18,tempx,tempy,A);
		        case 19:SetObjectRot(nagelband19,tempx,tempy,A);
		        case 20:SetObjectRot(nagelband20,tempx,tempy,A);
		    }
		}
	    if(countgelegte == 20+1) //Maximum + 1
	    {
	        found = 0;
	        for(new n; n<20; n++)
	        {
	            if(nagelindex[n] == 0)
	            {
	                found = 1;
	                switch(n)
					{
				    	case 0:SetObjectPos(nagelband0,X,Y,Z);
				    	case 1:SetObjectPos(nagelband1,X,Y,Z);
				    	case 2:SetObjectPos(nagelband2,X,Y,Z);
				    	case 3:SetObjectPos(nagelband3,X,Y,Z);
				    	case 4:SetObjectPos(nagelband4,X,Y,Z);
				    	case 5:SetObjectPos(nagelband5,X,Y,Z);
				    	case 6:SetObjectPos(nagelband6,X,Y,Z);
				    	case 7:SetObjectPos(nagelband7,X,Y,Z);
				    	case 8:SetObjectPos(nagelband8,X,Y,Z);
				    	case 9:SetObjectPos(nagelband9,X,Y,Z);
				    	case 10:SetObjectPos(nagelband10,X,Y,Z);
				    	case 11:SetObjectPos(nagelband11,X,Y,Z);
				    	case 12:SetObjectPos(nagelband12,X,Y,Z);
				    	case 13:SetObjectPos(nagelband13,X,Y,Z);
				    	case 14:SetObjectPos(nagelband14,X,Y,Z);
				    	case 15:SetObjectPos(nagelband15,X,Y,Z);
				    	case 16:SetObjectPos(nagelband16,X,Y,Z);
				    	case 17:SetObjectPos(nagelband17,X,Y,Z);
				    	case 18:SetObjectPos(nagelband18,X,Y,Z);
				    	case 19:SetObjectPos(nagelband19,X,Y,Z);
				    	case 20:SetObjectPos(nagelband20,X,Y,Z);
				    }
				    new Float:tempx,Float:tempy; //eig. hatte ich nur GetPlayerPos vergessen, ging aber so super
				    switch(n)
				    {
				        case 0:SetObjectRot(nagelband0,tempx,tempy,A);
				        case 1:SetObjectRot(nagelband1,tempx,tempy,A);
				        case 2:SetObjectRot(nagelband2,tempx,tempy,A);
				        case 3:SetObjectRot(nagelband3,tempx,tempy,A);
				        case 4:SetObjectRot(nagelband4,tempx,tempy,A);
				        case 5:SetObjectRot(nagelband5,tempx,tempy,A);
				        case 6:SetObjectRot(nagelband6,tempx,tempy,A);
				        case 7:SetObjectRot(nagelband7,tempx,tempy,A);
				        case 8:SetObjectRot(nagelband8,tempx,tempy,A);
				        case 9:SetObjectRot(nagelband9,tempx,tempy,A);
				        case 10:SetObjectRot(nagelband10,tempx,tempy,A);
				        case 11:SetObjectRot(nagelband11,tempx,tempy,A);
				        case 12:SetObjectRot(nagelband12,tempx,tempy,A);
				        case 13:SetObjectRot(nagelband13,tempx,tempy,A);
				        case 14:SetObjectRot(nagelband14,tempx,tempy,A);
				        case 15:SetObjectRot(nagelband15,tempx,tempy,A);
				        case 16:SetObjectRot(nagelband16,tempx,tempy,A);
				        case 17:SetObjectRot(nagelband17,tempx,tempy,A);
				        case 18:SetObjectRot(nagelband18,tempx,tempy,A);
				        case 19:SetObjectRot(nagelband19,tempx,tempy,A);
				        case 20:SetObjectRot(nagelband20,tempx,tempy,A);
				    }
                    placedx[n] = X;
				    placedy[n] = Y;
				    placedz[n] = Z;
					nagelindex[n] = 1;
					//nagelbandpickupid[n] = CreatePickup(1593,14,X,Y,Z);
					format(output,sizeof(output),"Das gelegte Nagelband hat die ID %d",n);
					SendClientMessage(playerid,COLOR_GREY,output);
					return 1;
	            }
	        }
	        if(found == 0)
	        {
	            SendClientMessage(playerid,COLOR_RED,"Kein Nagelband frei !");
	        	return 1;
			}
	    }
	    placedx[countgelegte] = X;
	    placedy[countgelegte] = Y;
	    placedz[countgelegte] = Z;
		nagelindex[countgelegte] = 1;
		format(output,sizeof(output),"Das gelegte Nagelband hat die ID %d",countgelegte);
		SendClientMessage(playerid,COLOR_GREY,output);
		countgelegte = countgelegte + 1;
		return 1;
	}
 	return 0;
}
dcmd_setskin(playerid,params[]){
	#pragma unused params
	if(testing == 1)
	{
 		SetPlayerSkin(playerid,288);
 		return 1;
	}
	else
	{
		return 0;
	}
}
strtok(const string[], &index){
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
stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z){
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}
public check(playerid){
 	found = 0;
	if(IsPlayerInAnyVehicle(playerid) && reifenheil[GetPlayerVehicleID(playerid)] == 1)
	{
	    for(new c; c<20; c++)
	    {
	        if(nagelindex[c] == 1)
	        {
			 	if(PlayerToPoint(2,playerid,placedx[c],placedy[c],placedz[c]))
			 	{
					found = 1;
					break;
			 	}
	        }
	    }
	}
	if(found == 0 && reifenheil[GetPlayerVehicleID(playerid)] == 1)
	{
    	checktimer[playerid] = SetTimerEx("check",checkms,0,"i",playerid);
	}
	if(found == 0 && reifenheil[GetPlayerVehicleID(playerid)] == 0)
	{
    	checktimer[playerid] = SetTimerEx("check",checkmssparend,0,"i",playerid);
	}
	if(found == 1 && reifenheil[GetPlayerVehicleID(playerid)] == 1)
	{
		SendClientMessage(playerid,COLOR_RED,"Du bist in ein Nagelband gefahren !");
	    reifenheil[GetPlayerVehicleID(playerid)] = 0;
	    SetTimerEx("reifenschrottkeys",ruckelms,0,"i",playerid);
	    checktimer[playerid] = SetTimerEx("check",checkmssparend,0,"i",playerid); //ressourcen sparen für andre func
	}
	return 1;
}
public reifenschrottkeys(playerid){
	if(reifenheil[GetPlayerVehicleID(playerid)] == 0 && IsPlayerInAnyVehicle(playerid))
	{
	    new keys, updown, leftright;
		GetPlayerKeys(playerid,keys,updown,leftright);
  		if((keys == 8 || keys == 32 || keys == 264 || keys == 288 || keys == 72 || keys == 96 || keys == 328 || keys == 352) && blocked[playerid] == 0) // 8 = vorwärts fahren, 32 = rückwarts, editiert: seiten- & rückblick
  		{
  		    blocked[playerid] = 1;
  		    TogglePlayerControllable(playerid,0);
  		}
  		if((keys != 8 && keys != 32 && keys != 264 && keys != 288 && keys != 72 && keys != 96 || keys == 328 || keys != 352) && blocked[playerid] == 1)
  		{
  		    blocked[playerid] = 0;
  		    TogglePlayerControllable(playerid,1);
  		}
  		SetTimerEx("reifenschrottkeys",ruckelms * 2,0,"i",playerid); // multiplikator 2, damit es nicht sofort blockiert ;) ist ja schließlich noch luft innen reifen
	}
	if(blocked[playerid] == 1 && !IsPlayerInAnyVehicle(playerid))
	{
		blocked[playerid] = 0;
	 	TogglePlayerControllable(playerid,1);
	}
	return 1;
}
public OnVehicleDeath(vehicleid, killerid){
	reifenheil[vehicleid] = 1;
	return 1;
}
dcmd_resetband(playerid,params[]){
	#pragma unused params
	if(!IsPlayerAdmin(playerid))
	{
	    return 0;
	}
	for(new d;d<MAX_PLAYERS; d++)
	{
	    if(IsPlayerConnected(d) && IsACop(d))
	    {
	        SendClientMessage(d,COLOR_YELLOW,"Alle Nagelbänder wurden entfernt, da das Script neugeladen wurde !");
	    }
	}
	for(new g; g<21; g++)
	{
	    nagelindex[g] = 0;
	    placedx[g] = 0;
	    placedy[g] = 0;
	    placedz[g] = -1000;
		switch(g)
		{
	    	case 0:SetObjectPos(nagelband0,0,0,-1000);
	    	case 1:SetObjectPos(nagelband1,0,0,-1000);
	    	case 2:SetObjectPos(nagelband2,0,0,-1000);
	    	case 3:SetObjectPos(nagelband3,0,0,-1000);
	    	case 4:SetObjectPos(nagelband4,0,0,-1000);
	    	case 5:SetObjectPos(nagelband5,0,0,-1000);
	    	case 6:SetObjectPos(nagelband6,0,0,-1000);
	    	case 7:SetObjectPos(nagelband7,0,0,-1000);
	    	case 8:SetObjectPos(nagelband8,0,0,-1000);
	    	case 9:SetObjectPos(nagelband9,0,0,-1000);
	    	case 10:SetObjectPos(nagelband10,0,0,-1000);
	    	case 11:SetObjectPos(nagelband11,0,0,-1000);
	    	case 12:SetObjectPos(nagelband12,0,0,-1000);
	    	case 13:SetObjectPos(nagelband13,0,0,-1000);
	    	case 14:SetObjectPos(nagelband14,0,0,-1000);
	    	case 15:SetObjectPos(nagelband15,0,0,-1000);
	    	case 16:SetObjectPos(nagelband16,0,0,-1000);
	    	case 17:SetObjectPos(nagelband17,0,0,-1000);
	    	case 18:SetObjectPos(nagelband18,0,0,-1000);
	    	case 19:SetObjectPos(nagelband19,0,0,-1000);
	    	case 20:SetObjectPos(nagelband20,0,0,-1000);
	    }
	}
	countgelegte = 0;
	return 1;
}
dcmd_reifenersetzen(playerid,params[]){
	#pragma unused params
	if(PlayerToPoint(moeglichradius,playerid,2064.6389,-1831.4257,13.5469) || PlayerToPoint(moeglichradius,playerid,1973.6438,2161.4021,11.0703) || PlayerToPoint(moeglichradius,playerid,-2425.4065,1024.5908,50.3977))
	{
	    if(!IsPlayerInAnyVehicle(playerid))
	    {
	        return SendClientMessage(playerid,COLOR_RED,"Fußgänger haben keine Reifen !");
	    }
	    if(reifenheil[GetPlayerVehicleID(playerid)] == 1)
	    {
	        return SendClientMessage(playerid,COLOR_RED,"Das Vehikle braucht keine neuen Reifen !");
	    }
		GivePlayerMoney(playerid,-kosten);
		reifenheil[GetPlayerVehicleID(playerid)] = 1;
		TogglePlayerControllable(playerid,1);
		SendClientMessage(playerid,COLOR_GREEN,"Reifen ausgetauscht !");
	}
	else
	{
	    SendClientMessage(playerid,COLOR_RED,"Hier kannst du deine Reifen nicht reparieren lassen !");
	}
	return 1;
}
AntiDeAMX(){
	new a[][] =
	{
		"Unarmed (Fist)",
		"Brass K"
	};
	#pragma unused a
}