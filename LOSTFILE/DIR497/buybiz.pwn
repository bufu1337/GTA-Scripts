#define BIZ_AMOUNT 1
new propcost[MAX_PLAYERS];
new playerbiz[MAX_PLAYERS];
new profit[MAX_PLAYERS];
new propowned[MAX_PLAYERS];
new totalprofit[MAX_PLAYERS];
new bizid[MAX_PLAYERS];
new biznum[MAX_PLAYERS];
new propactive[MAX_PLAYERS];
new cttmp[256];
new tmpname[256];
new ownername[256];
new playername2[256];
new name[256];
new miniskill[MAX_PLAYERS];
new maxiskill[MAX_PLAYERS];
new minibet[MAX_PLAYERS];
new maxibet[MAX_PLAYERS];
new bizpick[1] = {0, ...};
new Business1;
new Float:bizlocations[BIZ_AMOUNT][3] = {
{2027.5,1414.5,10.6},
}
public OnGameModeInit()
{
    	SetTimer("profitup",300000,1); //FUNCTION profitup wird jede volle stunde angewendet
    	SetTimer("bizup",60000,1);
    	Business1 = AddAreaCheck(2026.5, 2028.5, 1413.5, 1415.5, 10.0, 12.0);
		for(new tempb=1;tempb<=BIZ_AMOUNT;tempb++) { //für jedes biz
		new bizpickid = CreatePickup(1274, 2,bizlocations[tempb-1][0], bizlocations[tempb-1][1], bizlocations[tempb-1][2]); //ein DollarSymbol mit den dazugehörigen ko
		bizpick[bizpickid]=true; //mit dem wert erkennt er die switch funktion wenn man das pickup nimmt
		}
	return 1;
}
public bizup(){ //wird jede minute augeführt
	new h, m, s;
	new playername[256];
	new lastowner[256];
	new lastowned;
	new currentown;
	new oldbuysum;
	new oldbuy;
	new totalprofit;
	new bizbet;
	gettime(h, m, s); //Zeit
	if (m == 30){ //Wenn die minute 30 kommt
	for(new tempa=1;tempa<=BIZ_AMOUNT;tempa++) { // Für jedes biz
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);  //-wird eine "BIZnummer" erstellt und mit tmpname festgelegt
    	lastowner = dini_get(tmpname,"owner");
		playername = dini_get(tmpname,"oldbetor");
		lastowned = dini_Int(udb_encode(lastowner), "bizowned");
		currentown = dini_Int(udb_encode(playername), "bizowned");
		oldbuysum = dini_Int(tmpname,"oldbet");
		oldbuy = dini_Int(tmpname,"oldbuy");
		totalprofit = dini_Int(tmpname,"totalprofit");
		bizbet =
		if(lastowner="server"){dini_IntSet(tmpname, "bought",0);}
		else {dini_IntSet(tmpname, "bought",1);}
		dini_IntSet(udb_encode(lastowner), "bizowned", lastowned - 1);
		dini_IntSet(udb_encode(playername), "bizowned", currentown + 1);
	 //Hier wird festgelegt, welches biz der spieler besitzt, und die biznummer festgehalten
		dUserSetINT(lastowner).("bet",oldbuy + dUserINT(lastowner).("bet") + totalprofit);
		dini_Set(tmpname,"owner", playername); //der neue besitzer wird festgelegtdini_IntSet(tmpname, "bought", 1);
		dini_IntSet(tmpname,"oldbuy", oldbuysum);
		dini_IntSet(cttmp, "totalprofit", 0);
		dini_Unset(tmpname,"oldbetorid");
		dini_Unset(tmpname,"oldbetor");
		dini_Unset(tmpname,"oldbet");
		dini_IntSet(tmpname, "propcost", 0);
	} //das biz wurde gekauft, der totalprofit steigt
	for(new i=0;i<=MAX_PLAYERS;i++) { //jeder spieler der
	    if(IsPlayerConnected(i)) { //wenn der spieler online ist
	    	new ownera[MAX_PLAYERS],playername[256];
		   	GetPlayerName(i, playername, sizeof(playername)); //jeder playername
		    ownera[i] = dini_Int(udb_encode(playername),"bizowned"); //hier wird gecheckt welcher dieser playernamen ein biz besitzt
	    	if(ownera[i] > currentown) { //wenn jemand ein biz beistzt
				format(propmess, sizeof(propmess), "You just bought %d business.", ownera[i] - currentown);
				SendClientMessage(i, COLOR_GREEN, propmess);
				SendClientMessage(i, COLOR_LIGHTBLUE, "You may return to the checkpoint at any time to collect your earnings by typing /getprofit and");
				SendClientMessage(i, COLOR_LIGHTBLUE, "your property will continue to make money at regular intervals even when you are offline!");return 1;}
			}
		}
	}
return 1;
}
public profitup() //wird jede volle stunde angewendet
{
	for(new tempa=1;tempa<=BIZ_AMOUNT;tempa++) { // Für jedes biz
		format(tmpname,sizeof(tmpname),"BIZ%d",tempa);  //-wird eine "BIZnummer" erstellt und mit tmpname festgelegt
	 	propowned[tempa] = dini_Int(tmpname, "bought"); //-wird eine 1 ausgegeben wenn jemand es gekauft hat
		if (propowned[tempa] == 1) { //wenn das biz gekauft ist
		    new tmp[256];   //totalprofit und profit zusammen
			totalprofit[tempa] = dini_Int(tmpname, "totalprofit"); //Der totalProfit von biz der schon gegeben ist
			profit[tempa] = dini_Int(tmpname, "profit"); // Der Profit den das biz verdient
			tmp[tempa] = profit[tempa]+totalprofit[tempa]; //beides zusammen
			dini_IntSet(tmpname, "totalprofit", tmp[tempa]); //der neue totalprofit
    	}else{
			new tmp[256];   //govermentprofit FÜR DIE REGIERUNG
			totalprofit[tempa] = dini_Int(tmpname, "govermentprofit"); //Der totalProfit von biz der schon gegeben ist
			profit[tempa] = dini_Int(tmpname, "profit"); // Der Profit den das biz verdient
			tmp[tempa] = profit[tempa]+totalprofit[tempa]; //beides zusammen
			dini_IntSet(tmpname, "govermentprofit", tmp[tempa]); //der neue totalprofit
			}
	}
	for(new i=0;i<=MAX_PLAYERS;i++) { //jeder spieler der
	    if(IsPlayerConnected(i)) { //wenn der spieler online ist
	    	new ownera[MAX_PLAYERS],playername[256];
		   	GetPlayerName(i, playername, sizeof(playername)); //jeder playername
		    ownera[i] = dini_Int(udb_encode(playername),"bizowned"); //hier wird gecheckt welcher dieser playernamen ein biz besitzt
	    	if(ownera[i] > 0) { //wenn jemand ein biz beistzt
				SendClientMessage(i,COLOR_LIGHTBLUE,"The profit for your property has been updated. Return to your owned property");
    			SendClientMessage(i,COLOR_LIGHTBLUE,"checkpoint and type /getprofit to claim your business's takings.");
			}
		}
	}
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid) //wenn der spieler ein pickup auhebt
{
	switch(bizpick[pickupid]) //die Dollarbizpickups
	{

		for(new tempb=1;tempb<=BIZ_AMOUNT;tempb++) { //Für jedes biz wird mit tempb ein -ä-
			if(tempb == 1) {
        	minibet[tempb] = 100000; //minimalgebot,
        	maxibet[tempb] = 300000; //maximalgebot,
        	miniskill[tempb] = 0; //minimalskill,
        	maxiskill[tempb] = 3; //maximalskill,
			profit[tempb] = 750; //profit
			format(bizname,sizeof(bizname),"First Business"); //bizname wird festgelegt
        	if (dini_Get(tmpname,"propcost") > (minibet[tempb])){ //wenn das Höchstgebot größer ist als das minimalgebot
			propcost[tempb] = dini_Get(tmpname,"propcost");} //dann kann er die Höchstgebot aus dem biz nehmen
			else { propcost[tempb] = minibet[tempb];} //ansonsten ist es das minimalgebot
    	}
//		if(tempb >= 3 && tempb <=4) {
// 			propcost[tempb] = 11000000;
// 			profit[tempb] = 4750;
//		}
		format(tmpname,sizeof(tmpname),"BIZ%d", tempb); //name der Dateien
		if (!dini_Exists(tmpname)) { //wenn noch keine daten für diese biznummer existieren
    	    	dini_Create(tmpname); //erstellt eine datei und setzt ihre variablen
    	    	dini_IntSet(tmpname, "propcost", minibet[tempb]);
				dini_IntSet(tmpname, "profit", profit[tempb]);
   				dini_IntSet(tmpname, "minibet", minibet[tempb]);
				dini_IntSet(tmpname, "maxibet", maxibet[tempb]);
				dini_IntSet(tmpname, "miniskill", miniskill[tempb]);
				dini_IntSet(tmpname, "maxiskill", maxiskill[tempb]);
				dini_Set(tmpname, "owner", "server");
				dini_Set(tmpname, "name", bizname);
				dini_IntSet(tmpname, "totalprofit", 0);
				dini_IntSet(tmpname, "bought", 0);
				dini_IntSet(tmpname, "idnumber", tempb);
    	}
		else{ dini_IntSet(tmpname, "propcost", propcost[tempb]);} // -ä- werden die jeweiligen Kosten in der biznummer gespeichert
	 	}

 		case 0: { //Wenn ich in das 0te bizpickup gehe
		if(propactive[playerid] == 0) { // Damit kann ich buybiz machen -ü-
				format(cttmp, sizeof(cttmp), "%s%d","BIZ1"); //die biznummer für das biz um mit cttmp die daten zu hohlen
				biznum[playerid] = dini_Int(cttmp,"idnumber"); //die biznummer wird hier festgelegt um sie später zu indetifizieren
				ownername = dini_Get(cttmp,"owner"); //der besitzername, wenn einer existiert
 				GetPlayerName(playerid, playernameh, MAX_PLAYER_NAME); //der jetzt in dem symbol steht
				propcost[playerid] = dini_Int(cttmp,"propcost"); //holt die jeweiligen Kosten, cttmp ist die biznummer für den spieler
        		profit[playerid] = dini_Int(cttmp,"profit");
				totalprofit[playerid] = dini_Int(cttmp,"totalprofit");
           		name = dini_Get(cttmp,"name"); // " den namen
        		propactive[playerid] = 1; // -ü- buybiz wird hier nicht FALSE und geht weiter
	  			if(strcmp(ownername,server,false) == 0) //wenn das business frei ist
	   			{
	   	    		format(propmess,sizeof(propmess),"The %s is currently vacant. U can bet for it by typing /bet. The minimalbet is $%d. This business earns $%d every hour", name, propcost[playerid],profit[playerid]);
		 			SendClientMessage(playerid,COLOR_YELLOW,propmess);
		 			return 1;
	   			}
	   			if(strcmp(ownername,playernameh,false) == 0) { //ist der in dem symbol der besitzer?
	   				format(propmess,sizeof(propmess),"Welcome back to your %s, %s. Type /getprofit to collect the earnings ($ %d) your business has made since your last collection.", name, ownername, totalprofit[playerid]);
   		       		SendClientMessage(playerid,COLOR_LIGHTBLUE,propmess);
   		       		return 1;
				}
				else { //Wenn nicht dann
               		format(propmess,sizeof(propmess),"The %s belongs to %s, type /bet and every 60min at half o'clock u win with the highest bet", name, ownername);
               		SendClientMessage(playerid,COLOR_BRIGHTRED,propmess);
               		return 1;
				}}}
   }
   return 0;
}
public OnPlayerCommandText(playerid, cmdtext[]) //Wenn der Spieler ein Text schreibt
{
   	if(strcmp(cmd, "/bet", true) == 0) { //wenn man /bet schreibt
   	    new tmp;
   		new cash[MAX_PLAYERS];
		new bizbet;
		cash[playerid] = GetPlayerMoney(playerid); //geld
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME); //name
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]); //Um das buisness zu identifizieren wird cttmp verwendet und die biznum die vorher festgelegt wurde wenn man das pickup aufhebt
	    ownername = dini_Get(cttmp,"owner"); //Der name des besitzers
	    bizid[playerid] = dini_Int(cttmp,"idnumber"); //Die idnumber des des jeweiligen biz
		minibet[playerid] = dini_Int(cttmp,"minibet"); //minimalgebot " " " "
 		maxibet[playerid] = dini_Int(cttmp,"maxibet"); //maximalgebot " " " "
		miniskill[playerid] = dini_Int(cttmp,"miniskill"); //minimalgebot " " " "
 		maxiskill[playerid] = dini_Int(cttmp,"maxiskill"); //maximalgebot " " " "
 		propcost[playerid] = dini_Int(cttmp,"propcost");
 		name = dini_Get(cttmp,"name");
        tmp = strtok(cmdtext, idx); //nimm das wort nach /bet als tmp
       	if (!strlen(tmp)){ //wenn keine summe angegeben ist nicht weiter !!!
	 		SendClientMessage(playerid,COLOR_GREEN,"Usage: /bet [amount]'");
	 		return 1;}
		if(propactive[playerid] == 0) { //Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to buy a business/house!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {//wenn in einem vehicle bin nicht weiter !!!
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to purchase a business!");
			return 1;
		}
		if(minibet[playerid] > tmp || tmp > maxibet[playerid]){ //wenn gebot unter oder über der grenze liegt nicht weiter !!!
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "The Minimalbet is %d. The Maximalbet is %d. Give a bet between this.", minibet[playerid], maxibet[playerid]);
	  		return 1;}
		if(miniskill[playerid] > Playerlevel[playerid] || Playerlevel[playerid] > maxibet[playerid]){ //wenn gebot unter oder über der grenze liegt nicht weiter !!!
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "U don't have the neccessary Level", miniskill[playerid], maxiskill[playerid]);
	  		return 1;}
		if(cash[playerid] >= tmp && tmp > propcost[playerid]) { //wenn das geld auf der hand größer ist als das gebot und das gebot größer ist als das Höchstgebot nicht weiter !!!
                dini_IntSet(cttmp, "propcost", tmp); //die kosten werden auf dem server aktualisiert
				GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
				oldid = dini_Int(cttmp,"oldbetorid");
				oldname = dini_Get(cttmp,"oldbetor");
				oldbet = dini_Int(cttmp,"oldbet");
				bizbet = dUserINT(oldname).("bizbet");
				GetPlayerName(oldid, playername2, MAX_PLAYER_NAME);
                GivePlayerMoney(playerid, -tmp); //
                if(strcmp(playername2,oldname,false) == 0) {
                GivePlayerMoney(oldid, +oldbet);
				SendClientMessage(oldid, COLOR_BRIGHTRED, "U have been overbet by %s!", playername);}
				else{ dUserSetINT(oldname).("bizbet",oldbet + bizbet);} //
                dini_IntSet(cttmp,"oldbetorid", playerid);
				dini_Set(cttmp,"oldbetor", playername);
				dini_IntSet(cttmp, "oldbet", tmp);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, "Your bet is the highest bet for the %s, the bizowner changes every Hour at half o'clock. U will loose the biz if  ", name);
				return 1;
			}
		if(cash[playerid] < tmp) { //wenn das geld weniger ist als das gebot
				format(propmess, sizeof(propmess), "You do not have enough cash to cover ur bet and cannot afford the %s!", name);
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
			}
		if(tmp <= propcost[playerid]) { //wenn das gebot kleiner oder gleich ist als das Höchstgebot nicht weiter !!!
				format(propmess, sizeof(propmess), "Your bet is under the highest bet.", name);
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/sellbiz", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME); //spielername
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]); //Um das buisness zu identifizieren wird cttmp verwendet und die biznum die vorher festgelegt wurde wenn man das pickup aufhebt
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
		ownername = dini_Get(cttmp,"owner");

		if(propactive[playerid] == 0) { //Wenn ich in keinem Dollarsymbol stehe nicht weiter !!!
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a property checkpoint in order to sell a business!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {//wenn in einem vehicle bin nicht weiter !!!
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to sell a business!");
			return 1;
		}
		if (strcmp(server,ownername,false) == 0) { //wenn das biz keinem gehört dann nicht weiter !!!
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "Nobody has bought this business yet and you are prohibited from selling it!");
			return 1;
		}
		if(playerbiz[playerid] == 0) { //wenn der spieler kein biz hat
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if (strcmp(playername,ownername,false) == 0) { //wenn der spielername gleich dem Besitzernamen ist
			new cash[MAX_PLAYERS];
			cash[playerid] = GetPlayerMoney(playerid); //geld
			GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
			dini_Set(cttmp,"owner", "server");
			dini_IntSet(udb_encode(playername), "bizowned", 0);
			dini_IntSet(cttmp, "bought", 0);
			dini_IntSet(cttmp, "totalprofit", 0);
			GivePlayerMoney(playerid, propcost[playerid]);
			format(propmess, sizeof(propmess), "You just sold your business for $%d.", propcost[playerid]);
			SendClientMessage(playerid, COLOR_GREEN, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "You do not own this business, %s owns it and only they can sell it!", ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}
		if(strcmp(cmd, "/getprofit", true) == 0) {
	    GetPlayerName(playerid, playername, MAX_PLAYER_NAME);
	    format(cttmp,sizeof(cttmp),"BIZ%d",biznum[playerid]);
	    ownername = dini_Get(cttmp,"owner");
	    playerbiz[playerid] = dini_Int(udb_encode(playername), "bizowned");
	    bizid[playerid] = dini_Int(cttmp,"idnumber");
		name = dini_Int(cttmp, "name");
		if(propactive[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be in a business checkpoint in order to collect your earnings!");
			return 1;
		}
		if(IsPlayerInAnyVehicle(playerid) == 1) {
			SendClientMessage(playerid, COLOR_BRIGHTRED, "You must be on foot to collect your earnings!");
			return 1;
		}
		if(strcmp(ownername,server,false) == 0) {
				format(propmess, sizeof(propmess), "Nobody has bought this business yet, what are you trying to pull punk!");
				SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
				return 1;
		}
		if(playerbiz[playerid] == 0) {
		    SendClientMessage(playerid, COLOR_BRIGHTRED, "You do not yet own any business, nice try loser!");
		    return 1;
		}
		if(strcmp(ownername,playername,false) == 0) {
			totalprofit[playerid] = dini_Int(cttmp, "totalprofit");
			
			if(totalprofit[playerid] == 0) {
				SendClientMessage(playerid,COLOR_BRIGHTRED,"Your business has not yet made any earnings since your last visit. Please wait for notification of updated earnings!");
				return 1;
			}
			GivePlayerMoney(playerid,totalprofit[playerid]);
			dini_IntSet(cttmp, "totalprofit", 0);
			format(propmess, sizeof(propmess), "You have collected $%d of earnings from your %d, %s! Enjoy!", totalprofit[playerid], name, ownername);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, propmess);
			return 1;
		}
		format(propmess, sizeof(propmess), "This business belongs to %s, nice try loser! Stop trying to steal other peoples business earnings!",ownername);
		SendClientMessage(playerid, COLOR_BRIGHTRED, propmess);
		return 1;
	}}



OnPlayerLeaveArea(playerid)
{
if (areaid==Business1){
	propactive[playerid] = 0;
}
}




