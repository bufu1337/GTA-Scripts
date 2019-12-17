forward IsABoat(carid);
forward IsAtFishPlace(playerid);
forward ClearFishID(playerid, fish);
forward FishCost(playerid, fish);
forward ClearFishes(playerid);
enum pFishing {
	pFish1[20],
	pFish2[20],
	pFish3[20],
	pFish4[20],
	pFish5[20],
	pWeight1,
	pWeight2,
	pWeight3,
	pWeight4,
	pWeight5,
	pFid1,
	pFid2,
	pFid3,
	pFid4,
	pFid5,
	pLastFish,
	pFishID,
	pLastWeight,
};
enum pInfo {
	pFishes,
	pFishSkill,
	pBiggestFish,
};
new Fishes[MAX_PLAYERS][pFishing];
new PlayerInfo[MAX_PLAYERS][pInfo];
new FishNamesNumber = 22;
new FishNames[22][20] = {
{"Jacket"},
{"Amberjack"},
{"Grouper"},
{"Red Snapper"},
{"Pants"},
{"Trout"},
{"Blue Marlin"},
{"Can"},
{"Mackeral"},
{"Sea Bass"},
{"Shoes"},
{"Pike"},
{"Sail Fish"},
{"Garbage"},
{"Tuna"},
{"Eel"},
{"Dolphin"},
{"Shark"},
{"Turtle"},
{"Catfish"},
{"Money Bag"},
{"Swordfish"}
};
public FishCost(playerid, fish){
	if(IsPlayerConnected(playerid)){
		new cost = 0;
		switch (fish){
		    case 1:
		    {
		        cost = 1;
		    }
		    case 2:
		    {
		        cost = 3;
		    }
		    case 3:
		    {
		        cost = 3;
		    }
		    case 5:
		    {
		        cost = 5;
		    }
		    case 6:
		    {
		        cost = 2;
		    }
		    case 8:
		    {
		        cost = 8;
		    }
		    case 9:
		    {
		        cost = 12;
		    }
		    case 11:
		    {
		        cost = 9;
		    }
		    case 12:
		    {
		        cost = 7;
		    }
		    case 14:
		    {
		        cost = 12;
		    }
		    case 15:
		    {
		        cost = 9;
		    }
		    case 16:
		    {
		        cost = 7;
		    }
		    case 17:
		    {
		        cost = 7;
		    }
		    case 18:
		    {
		        cost = 10;
		    }
		    case 19:
		    {
		        cost = 4;
		    }
		    case 21:
		    {
		        cost = 3;
		    }
		}
		return cost;
	}
	return 0;
}
public ClearFishes(playerid){
	if(IsPlayerConnected(playerid)){
	    Fishes[playerid][pFid1] = 0; Fishes[playerid][pFid2] = 0; Fishes[playerid][pFid3] = 0;
		Fishes[playerid][pFid4] = 0; Fishes[playerid][pFid5] = 0;
		Fishes[playerid][pWeight1] = 0; Fishes[playerid][pWeight2] = 0; Fishes[playerid][pWeight3] = 0;
		Fishes[playerid][pWeight4] = 0; Fishes[playerid][pWeight5] = 0;
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "None");
		strmid(Fishes[playerid][pFish1], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish2], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish3], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish4], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish5], string, 0, strlen(string), 255);
	}
	return 1;
}
public ClearFishID(playerid, fish){
	if(IsPlayerConnected(playerid)){
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "None");
		switch (fish){
		    case 1: {
		        strmid(Fishes[playerid][pFish1], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight1] = 0;
		        Fishes[playerid][pFid1] = 0;
		    }
		    case 2: {
		        strmid(Fishes[playerid][pFish2], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight2] = 0;
		        Fishes[playerid][pFid2] = 0;
		    }
		    case 3: {
		        strmid(Fishes[playerid][pFish3], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight3] = 0;
		        Fishes[playerid][pFid3] = 0;
		    }
		    case 4: {
		        strmid(Fishes[playerid][pFish4], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight4] = 0;
		        Fishes[playerid][pFid4] = 0;
		    }
		    case 5: {
		        strmid(Fishes[playerid][pFish5], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight5] = 0;
		        Fishes[playerid][pFid5] = 0;
		    }
		}
	}
	return 1;
}
public IsABoat(carid){
	if(carid >= 86 && carid <=90){
		return 1;
	}
	return 0;
}
public IsAtFishPlace(playerid){
	if(IsPlayerConnected(playerid)){
	    if(PlayerToPoint(1.0,playerid,403.8266,-2088.7598,7.8359) || PlayerToPoint(1.0,playerid,398.7553,-2088.7490,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,396.2197,-2088.6692,7.8359) || PlayerToPoint(1.0,playerid,391.1094,-2088.7976,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,383.4157,-2088.7849,7.8359) || PlayerToPoint(1.0,playerid,374.9598,-2088.7979,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,369.8107,-2088.7927,7.8359) || PlayerToPoint(1.0,playerid,367.3637,-2088.7925,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,362.2244,-2088.7981,7.8359) || PlayerToPoint(1.0,playerid,354.5382,-2088.7979,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
	}
	return 0;
}
public OnPlayerConnect(playerid){
    Fishes[playerid][pLastFish] = 0;
	Fishes[playerid][pFishID] = 0;
    PlayerInfo[playerid][pFishes] = 0;
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	if(strcmp(cmd, "/sell", true) == 0){
	    if(IsPlayerConnected(playerid)){
			new x_nr[256];
			x_nr = strtok(cmdtext, idx);
			if(!strlen(x_nr)){
				SendClientMessage(playerid, COLOR_WHITE, "|__________________ Selling __________________|");
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sell [name]");
		  		SendClientMessage(playerid, COLOR_GREY, "Available names: Fish");
				SendClientMessage(playerid, COLOR_WHITE, "|_____________________________________________|");
				return 1;
			}
		    if(strcmp(x_nr,"fish",true) == 0){
			    if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53)){
				//centerpoint 24-7
					SendClientMessage(playerid, COLOR_GRAD2, "   You are not in a 24-7 !");
					return 1;
				}
			    tmp = strtok(cmdtext, idx);
				if(!strlen(tmp)){
					SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sell fish [fish]");
					return 1;
				}
				new price;
				new fishid = strval(tmp);
				if(fishid < 1 || fishid > 5) { SendClientMessage(playerid, COLOR_GREY, "   Fish number cant be below 1 or above 5 !"); return 1; }
				else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(1) !"); return 1; }
				else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(2) !"); return 1; }
				else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(3) !"); return 1; }
				else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(4) !"); return 1; }
				else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(5) !"); return 1; }
				ConsumingMoney[playerid] = 1;
				switch (fishid){
				    case 1: {
				        if(Fishes[playerid][pWeight1] < 20){
				            SendClientMessage(playerid, COLOR_WHITE, "We are only interested in Fishes weighting 20 LBS or more.");
				            return 1;
				        }
                        price = FishCost(playerid, Fishes[playerid][pFid1]);
                        price = price * Fishes[playerid][pWeight1];
                        if(PlayerInfo[playerid][pTraderPerk] > 0){
				            new skill = price / 100;
				            new payout = (skill)*(5);
				            price += payout;
				        }
                        GameTextForPlayer(playerid, "~g~Fish~n~~r~Sold", 3000, 1);
                        format(string, sizeof(string), "* You have sold your %s that weights %d, for $%d.", Fishes[playerid][pFish1],Fishes[playerid][pWeight1],price);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						GivePlayerMoney(playerid, price);
						ClearFishID(playerid, 1);
				    }
				    case 2: {
				        if(Fishes[playerid][pWeight2] < 20){
				            SendClientMessage(playerid, COLOR_WHITE, "We are only interested in Fishes weighting 20 LBS or more.");
				            return 1;
				        }
            			price = FishCost(playerid, Fishes[playerid][pFid2]);
                        price = price * Fishes[playerid][pWeight2];
                        if(PlayerInfo[playerid][pTraderPerk] > 0){
				            new skill = price / 100;
				            new payout = (skill)*(5);
				            price += payout;
				        }
                        GameTextForPlayer(playerid, "~g~Fish~n~~r~Sold", 3000, 1);
                        format(string, sizeof(string), "* You have sold your %s that weights %d, for $%d.", Fishes[playerid][pFish2],Fishes[playerid][pWeight2],price);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						GivePlayerMoney(playerid, price);
						ClearFishID(playerid, 2);
				    }
				    case 3: {
				        if(Fishes[playerid][pWeight3] < 20){
				            SendClientMessage(playerid, COLOR_WHITE, "We are only interested in Fishes weighting 20 LBS or more.");
				            return 1;
				        }
            			price = FishCost(playerid, Fishes[playerid][pFid3]);
                        price = price * Fishes[playerid][pWeight3];
                        if(PlayerInfo[playerid][pTraderPerk] > 0){
				            new skill = price / 100;
				            new payout = (skill)*(5);
				            price += payout;
				        }
                        GameTextForPlayer(playerid, "~g~Fish~n~~r~Sold", 3000, 1);
                        format(string, sizeof(string), "* You have sold your %s that weights %d, for $%d.", Fishes[playerid][pFish3],Fishes[playerid][pWeight3],price);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						GivePlayerMoney(playerid, price);
						ClearFishID(playerid, 3);
				    }
				    case 4: {
				        if(Fishes[playerid][pWeight4] < 20){
				            SendClientMessage(playerid, COLOR_WHITE, "We are only interested in Fishes weighting 20 LBS or more.");
				            return 1;
				        }
            			price = FishCost(playerid, Fishes[playerid][pFid4]);
                        price = price * Fishes[playerid][pWeight4];
                        if(PlayerInfo[playerid][pTraderPerk] > 0){
				            new skill = price / 100;
				            new payout = (skill)*(5);
				            price += payout;
				        }
                        GameTextForPlayer(playerid, "~g~Fish~n~~r~Sold", 3000, 1);
                        format(string, sizeof(string), "* You have sold your %s that weights %d, for $%d.", Fishes[playerid][pFish4],Fishes[playerid][pWeight4],price);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						GivePlayerMoney(playerid, price);
						ClearFishID(playerid, 4);
				    }
				    case 5: {
				        if(Fishes[playerid][pWeight5] < 20){
				            SendClientMessage(playerid, COLOR_WHITE, "We are only interested in Fishes weighting 20 LBS or more.");
				            return 1;
				        }
            			price = FishCost(playerid, Fishes[playerid][pFid5]);
                        price = price * Fishes[playerid][pWeight5];
                        if(PlayerInfo[playerid][pTraderPerk] > 0){
				            new skill = price / 100;
				            new payout = (skill)*(5);
				            price += payout;
				        }
                        GameTextForPlayer(playerid, "~g~Fish~n~~r~Sold", 3000, 1);
                        format(string, sizeof(string), "* You have sold your %s that weights %d, for $%d.", Fishes[playerid][pFish5],Fishes[playerid][pWeight5],price);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						GivePlayerMoney(playerid, price);
						ClearFishID(playerid, 5);
				    }
				}
				Fishes[playerid][pLastFish] = 0;
				Fishes[playerid][pFishID] = 0;
				return 1;
			}
		}
	}
	if(strcmp(cmd,"/fish",true)==0){
        if(IsPlayerConnected(playerid)){
	        if(PlayerInfo[playerid][pFishes] > 5){
	            SendClientMessage(playerid, COLOR_GREY, "   Caught to many fish, wait till its reduced !");
	            return 1;
	        }
	        if(Fishes[playerid][pWeight1] > 0 && Fishes[playerid][pWeight2] > 0 && Fishes[playerid][pWeight3] > 0 && Fishes[playerid][pWeight4] > 0 && Fishes[playerid][pWeight5] > 0){
	            SendClientMessage(playerid, COLOR_GREY, "   You already caught 5 Fishes, sell / eat / release them first !");
	            return 1;
	        }
	        new Veh = GetPlayerVehicleID(playerid);
	        if((IsAtFishPlace(playerid)) || IsABoat(Veh)){
	            new Caught;
	            new rand;
	            new fstring[MAX_PLAYER_NAME];
	            new Level = PlayerInfo[playerid][pFishSkill];
	            if(Level >= 0 && Level <= 50) { Caught = random(20)-7; }
	            else if(Level >= 51 && Level <= 100) { Caught = random(50)-20; }
	            else if(Level >= 101 && Level <= 200) { Caught = random(100)-50; }
	            else if(Level >= 201 && Level <= 400) { Caught = random(160)-60; }
	            else if(Level >= 401) { Caught = random(180)-70; }
	            rand = random(FishNamesNumber);
	            if(Caught <= 0){
	                SendClientMessage(playerid, COLOR_GREY, "   Line snapped !");
	                return 1;
	            }
	            else if(rand == 0){
	                SendClientMessage(playerid, COLOR_GREY, "   You caught a Jacket and threw it away !");
	                return 1;
	            }
	            else if(rand == 4){
	                SendClientMessage(playerid, COLOR_GREY, "   You caught a Pants and threw it away !");
	                return 1;
	            }
	            else if(rand == 7){
	                SendClientMessage(playerid, COLOR_GREY, "   You caught a Can and threw it away !");
	                return 1;
	            }
	            else if(rand == 10){
	                SendClientMessage(playerid, COLOR_GREY, "   You caught a pair of Shoes and threw it away !");
	                return 1;
	            }
	            else if(rand == 13){
	                SendClientMessage(playerid, COLOR_GREY, "   You caught some Garbage and threw it away !");
	                return 1;
	            }
	            else if(rand == 20){
	                new mrand = random(500);
	                format(string, sizeof(string), "* You caught a Money Bag, containing $%d.", mrand);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	                GivePlayerMoney(playerid, mrand);
	                return 1;
	            }
		        if(PlayerInfo[playerid][pFishLic] < 1){
	            	WantedPoints[playerid] += 1;
					SetPlayerCriminal(playerid,255, "Illegal Fishing");
				}
		        if(Fishes[playerid][pWeight1] == 0){
		        	PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish1], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight1] = Caught;
					format(string, sizeof(string), "* You have caught a %s, which weights %d Lbs.", Fishes[playerid][pFish1], Caught);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 1;
					Fishes[playerid][pFid1] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish]){
					    format(string, sizeof(string), "* Your old record of %d Lbs has been passed, your new Biggest Fish is: %d Lbs.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
     			}
		        else if(Fishes[playerid][pWeight2] == 0){
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish2], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight2] = Caught;
					format(string, sizeof(string), "* You have caught a %s, which weights %d Lbs.", Fishes[playerid][pFish2], Caught);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 2;
					Fishes[playerid][pFid2] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish]){
					    format(string, sizeof(string), "* Your old record of %d Lbs has been passed, your new Biggest Fish is: %d Lbs.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight3] == 0){
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish3], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight3] = Caught;
					format(string, sizeof(string), "* You have caught a %s, which weights %d Lbs.", Fishes[playerid][pFish3], Caught);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 3;
					Fishes[playerid][pFid3] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish]){
					    format(string, sizeof(string), "* Your old record of %d Lbs has been passed, your new Biggest Fish is: %d Lbs.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight4] == 0){
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish4], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight4] = Caught;
					format(string, sizeof(string), "* You have caught a %s, which weights %d Lbs.", Fishes[playerid][pFish4], Caught);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 4;
					Fishes[playerid][pFid4] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish]){
					    format(string, sizeof(string), "* Your old record of %d Lbs has been passed, your new Biggest Fish is: %d Lbs.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else if(Fishes[playerid][pWeight5] == 0){
		            PlayerInfo[playerid][pFishes] += 1;
		            PlayerInfo[playerid][pFishSkill] += 1;
		            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
					strmid(Fishes[playerid][pFish5], fstring, 0, strlen(fstring), 255);
					Fishes[playerid][pWeight5] = Caught;
					format(string, sizeof(string), "* You have caught a %s, which weights %d Lbs.", Fishes[playerid][pFish5], Caught);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					Fishes[playerid][pLastWeight] = Caught;
					Fishes[playerid][pLastFish] = 5;
					Fishes[playerid][pFid5] = rand;
					Fishes[playerid][pFishID] = rand;
					if(Caught > PlayerInfo[playerid][pBiggestFish]){
					    format(string, sizeof(string), "* Your old record of %d Lbs has been passed, your new Biggest Fish is: %d Lbs.", PlayerInfo[playerid][pBiggestFish], Caught);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						PlayerInfo[playerid][pBiggestFish] = Caught;
					}
		        }
		        else {
		            SendClientMessage(playerid, COLOR_GREY, "   You dont have any space for your Fish !");
		            return 1;
		        }
	            if(PlayerInfo[playerid][pFishSkill] == 50)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Your Fishing Skill is now Level 2, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 250)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Your Fishing Skill is now Level 3, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 500)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Your Fishing Skill is now Level 4, you can now catch Heavier Fishes."); }
				else if(PlayerInfo[playerid][pFishSkill] == 1000)
				{ SendClientMessage(playerid, COLOR_YELLOW, "* Your Fishing Skill is now Level 5, you can now catch Heavier Fishes."); }
	        }
	        else {
	            SendClientMessage(playerid, COLOR_GREY, "   You are not at a Fishing Place (Big Wheel Rods) or on a Fishing Boat !");
	            return 1;
	        }
	    }
	    return 1;
 	}
	if(strcmp(cmd,"/fishes",true)==0){
        if(IsPlayerConnected(playerid)){
	        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Fishes __________________|");
	        format(string, sizeof(string), "** (1) Fish: %s.   Weight: %d.", Fishes[playerid][pFish1], Fishes[playerid][pWeight1]);
			SendClientMessage(playerid, COLOR_GREY, string);
			format(string, sizeof(string), "** (2) Fish: %s.   Weight: %d.", Fishes[playerid][pFish2], Fishes[playerid][pWeight2]);
			SendClientMessage(playerid, COLOR_GREY, string);
			format(string, sizeof(string), "** (3) Fish: %s.   Weight: %d.", Fishes[playerid][pFish3], Fishes[playerid][pWeight3]);
			SendClientMessage(playerid, COLOR_GREY, string);
			format(string, sizeof(string), "** (4) Fish: %s.   Weight: %d.", Fishes[playerid][pFish4], Fishes[playerid][pWeight4]);
			SendClientMessage(playerid, COLOR_GREY, string);
			format(string, sizeof(string), "** (5) Fish: %s.   Weight: %d.", Fishes[playerid][pFish5], Fishes[playerid][pWeight5]);
			SendClientMessage(playerid, COLOR_GREY, string);
			SendClientMessage(playerid, COLOR_WHITE, "|____________________________________________|");
		}
	    return 1;
 	}
 	if(strcmp(cmd,"/releasefish",true)==0){
	    if(IsPlayerConnected(playerid)){
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp)){
				SendClientMessage(playerid, COLOR_WHITE, "USAGE: /releasefish [fish]");
				return 1;
			}
			new fishid = strval(tmp);
			if(fishid < 1 || fishid > 5) { SendClientMessage(playerid, COLOR_GREY, "   Fish number cant be below 1 or above 5 !"); return 1; }
			else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(1) !"); return 1; }
			else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(2) !"); return 1; }
			else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(3) !"); return 1; }
			else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(4) !"); return 1; }
			else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   You didnt even catch a Fish at that number(5) !"); return 1; }
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
   			Fishes[playerid][pFishID] = 0;
		}
		return 1;
	}
 	if(strcmp(cmd,"/throwback",true)==0){
        if(IsPlayerConnected(playerid)){
	        if(Fishes[playerid][pLastFish] > 0){
	            ClearFishID(playerid, Fishes[playerid][pLastFish]);
	            Fishes[playerid][pLastFish] = 0;
	            Fishes[playerid][pFishID] = 0;
	        }
	        else {
	            SendClientMessage(playerid, COLOR_GREY, "   You haven't even catched a Fish yet !");
	            return 1;
	        }
	    }
	    return 1;
 	}
 	if(strcmp(cmd,"/throwbackall",true)==0){
        if(IsPlayerConnected(playerid)){
	        if(Fishes[playerid][pWeight1] > 0 || Fishes[playerid][pWeight2] > 0 || Fishes[playerid][pWeight3] > 0 || Fishes[playerid][pWeight4] > 0 || Fishes[playerid][pWeight5] > 0){
	            ClearFishes(playerid);
				Fishes[playerid][pLastFish] = 0;
				Fishes[playerid][pFishID] = 0;
	        }
	        else {
	            SendClientMessage(playerid, COLOR_GREY, "   You haven't even catched a Fish yet !");
	            return 1;
	        }
	    }
	    return 1;
 	}
	return 0;
}



