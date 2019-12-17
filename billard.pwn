#include <a_samp>
#define NO_BALL 403
#define CALA 0
#define POL 1
#define WHITE 14
#define BLACK 15
#define TABLE 16
#define POLYGONS 6
forward Float:GetVectorAngle(obj, obj2);
forward Float:GetVectorAngle_XY(Float:fx, Float:fy, Float:tx, Float:ty);
forward Float:GetVectorDistance_PL(playerid, obj);
forward Float:GetVectorDistance_OB(obj, obj2);
forward Float:GetDistance(Float:fx, Float:fy, Float:tx, Float:ty);
forward Float:GetDistancePointToLong(Float:px,Float:py, Float:px1,Float:py1, Float:px2,Float:py2);
forward OnEndBilliard();
forward OnBallInHole(ballid);
forward OnTimer();
forward BallProperties();
forward OnShowedTD(playerid);
enum GameEnum{
	bool:Waiting,
	bool:Running,
	bool:WhiteInHole,
	bool:BlackInHole,
    Timer,
	Timer2,
	Player1,
	Player2,
	LastBall
};
enum BallEnum{
	ObjID,
	Float:x,
	Float:y,
	Float:z,
	Float:a,
	Float:speed,
	TouchID
};
enum EnumVertices{
	Float:x,
	Float:y
};
enum PolygonInfo{
	bool:Progress,
	Vertices
};
enum EnumPlayer{
	bool:Sighting,
	bool:AfterSighting,
	bool:Turn,
	BBall,
	Points,
	SelectLR,
	SelectUD,
	Float:a,
	Text:T1,
	Text:T2,
	Text:T3,
	Text:T4,
	Text:T5,
	Text:T6,
	TDTimer
};
new Game[GameEnum];
new Ball[17][BallEnum];
new Polygon[POLYGONS][2][EnumVertices];
new PolyResult[POLYGONS][PolygonInfo];
new Player[20][EnumPlayer];
new Float:Hole[6][4] ={
	{2495.6413,-1670.6297, 2495.5415,-1670.7099}, // 1  12
	{2496.4323,-1670.6297, 2496.5825,-1670.6398}, // 2  3
	{2497.3632,-1670.6297, 2497.4433,-1670.7299}, // 4  5
	{2497.4633,-1671.5506, 2497.3732,-1671.6607}, // 6  7
	{2496.5725,-1671.6607, 2496.4323,-1671.6607}, // 8  9
	{2495.6315,-1671.6607, 2495.5415,-1671.5606}  // 10 11
};
new Char[2][] ={
	{"(0)"},
	{"(-)"}
};
public OnFilterScriptInit(){
	for(new i = 0; i < 20; i++){
	    Player[i][T1] = TextDrawCreate(481.000000,353.000000," ");
    	TextDrawUseBox(Player[i][T1],1);
    	TextDrawTextSize(Player[i][T1],602.000000,0.000000);
    	TextDrawLetterSize(Player[i][T1],0.359999,1.100000);
    	TextDrawSetShadow(Player[i][T1],1);
    	TextDrawColor(Player[i][T1],227275519);
    	TextDrawBoxColor(Player[i][T1],227275314);
		Player[i][T2] = TextDrawCreate(475.000000,344.000000," ");
		TextDrawColor(Player[i][T2],4294967295);
	    TextDrawSetShadow(Player[i][T2],1);
	    Player[i][T3] = TextDrawCreate(481.000000,313.000000," ");
    	TextDrawUseBox(Player[i][T3],1);
    	TextDrawTextSize(Player[i][T3],635.000000,0.000000);
    	TextDrawLetterSize(Player[i][T3],0.359999,1.100000);
    	TextDrawSetShadow(Player[i][T3],1);
    	TextDrawColor(Player[i][T3],227275519);
    	TextDrawBoxColor(Player[i][T3],227275314);
		Player[i][T4] = TextDrawCreate(475.000000,304.000000," ");
		TextDrawColor(Player[i][T4],4294967295);
	    TextDrawSetShadow(Player[i][T4],1);
	    Player[i][T5] = TextDrawCreate(481.000000,273.000000," ");
    	TextDrawUseBox(Player[i][T5],1);
    	TextDrawTextSize(Player[i][T5],635.000000,0.000000);
    	TextDrawLetterSize(Player[i][T5],0.359999,1.100000);
    	TextDrawSetShadow(Player[i][T5],1);
    	TextDrawColor(Player[i][T5],227275519);
    	TextDrawBoxColor(Player[i][T5],227275314);
		Player[i][T6] = TextDrawCreate(475.000000,264.000000," ");
		TextDrawColor(Player[i][T6],4294967295);
	    TextDrawSetShadow(Player[i][T6],1);
	}
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
    if (strcmp("/bilard", cmdtext, true, 10) == 0){
	    SetPlayerPos(playerid,2499.3174,-1683.8401,13.4014);
	    return 1;
	}
	if (strcmp("/bilard-start", cmdtext, true, 10) == 0){
		if(Game[Waiting] == false && Game[Running] == false){
			Game[Waiting] = true;
			Game[Player1] = playerid;
			Game[LastBall] = -1;
			Player[playerid][Points] = 7;
			TextDrawSetString(Player[playerid][T1],"na przeciwnika...");
	    	TextDrawShowForPlayer(playerid,Player[playerid][T1]);
	   		TextDrawSetString(Player[playerid][T2],"Oczekiwanie");
	    	TextDrawShowForPlayer(playerid,Player[playerid][T2]);
	    	GivePlayerWeapon(playerid,7,1);
	    	new name[24];
	    	new str[100];
			name = GetName(playerid);
			format(str,sizeof(str),"%s oczekuje na przeciwnika. Wpisz /bilard-dolacz, aby rywalizowac z gospodarzem.",name);
	    	for(new i = 0; i < 20; i++){
	    	    if(IsPlayerConnected(i) == 1 && playerid != i){
	    	        TextDrawSetString(Player[i][T1],str);
					TextDrawShowForPlayer(i,Player[i][T1]);
					TextDrawSetString(Player[i][T2],"Bilard");
	    			TextDrawShowForPlayer(i,Player[i][T2]);
	    	    }
	    	    Player[i][BBall] = NO_BALL;
	    	}
		    Ball[0][ObjID] = CreateObject(3100, 2497.0749511719, -1670.9591064453, 13.199293525696, 0, 0, 0); //CALA
			Ball[1][ObjID] = CreateObject(3101, 2497.0034179688, -1671.01171875, 13.199293525696, 0, 0, 0); //CALA
			Ball[2][ObjID] = CreateObject(3102, 2497.0034179688, -1671.1900634766, 13.199293525696, 0, 0, 0); //CALA
			Ball[3][ObjID] = CreateObject(3103, 2496.8696289063, -1671.1865234375, 13.199293525696, 0, 0, 0); //CALA
			Ball[4][ObjID] = CreateObject(3104, 2496.9370117188, -1671.0673828125, 13.199293525696, 0, 0, 0); //CALA
			Ball[5][ObjID] = CreateObject(3105, 2497.072265625, -1671.2313232422, 13.199293525696, 0, 0, 0); //CALA
			Ball[6][ObjID] = CreateObject(3002, 2496.8068847656, -1671.1413574219, 13.199293525696, 0, 0, 0); //CALA
			Ball[7][ObjID] = CreateObject(2995, 2496.8703613281, -1671.0987548828, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[8][ObjID] = CreateObject(2996, 2497.0031738281, -1671.2750244141, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[9][ObjID] = CreateObject(2997, 2497.0705566406, -1671.3179931641, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[10][ObjID] = CreateObject(2998, 2497.0759277344, -1671.0457763672, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[11][ObjID] = CreateObject(2999, 2497.0063476563, -1671.1011962891, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[12][ObjID] = CreateObject(3000, 2497.0734863281, -1671.1456298828, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[13][ObjID] = CreateObject(3001, 2496.9333496094, -1671.2292480469, 13.199293525696, 0, 0, 0); //POLOWKA
			Ball[WHITE][ObjID] = CreateObject(3003, 2495.8618164063, -1671.1704101563, 13.209293525696, 0, 0, 0); //Biala
			Ball[BLACK][ObjID] = CreateObject(3106, 2496.9375, -1671.1451416016, 13.199293525696, 0, 0, 0); //Czarna
			Ball[TABLE][ObjID] = CreateObject(2964, 2496.4970703125, -1671.1528320313, 12.265947036743, 0, 0, 0); //Stol
			CreatePolygon(2495.6413,-1670.6297, 2496.4323,-1670.6297);
			CreatePolygon(2496.5825,-1670.6398, 2497.3632,-1670.6297);
			CreatePolygon(2497.4433,-1670.7299, 2497.4633,-1671.5506);
			CreatePolygon(2497.3732,-1671.6607, 2496.5725,-1671.6607);
			CreatePolygon(2496.4323,-1671.6607, 2495.6315,-1671.6607);
			CreatePolygon(2495.5415,-1671.5606, 2495.5415,-1670.7099);
		}
		return 1;
	}
	if (strcmp("/stop", cmdtext, true, 10) == 0){
	    if(Game[Waiting] == true || Game[Running] == true){
			KillTimer(Game[Timer]);
			KillTimer(Game[Timer2]);
			for(new i = 0; i < 17; i++){
	    		DestroyObject(Ball[i][ObjID]);
 	    	}
 	    	if(Game[Waiting] == true)
 	    	    Game[Waiting] = false;
 	    	if(Game[Running] == true)
 	    	    Game[Running] = false;

			Game[WhiteInHole] = false;
			Game[BlackInHole] = false;
 	    	Player[Game[Player1]][Sighting] = false;
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T1]);
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T2]);
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T3]);
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T4]);
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T5]);
 	    	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T6]);
 	    	Player[Game[Player2]][Sighting] = false;
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T1]);
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T2]);
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T3]);
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T4]);
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T5]);
 	    	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T6]);
	    }
	    return 1;
	}
	if (strcmp("/bilard-dolacz", cmdtext, true, 10) == 0){
	    if(Game[Waiting] == true){
	        if(Game[Player1] != playerid){
	        	Game[Waiting] = false;
	        	Game[Running] = true;
	        	Game[Player2] = playerid;
	        	TextDrawHideForPlayer(playerid,Player[Game[Player1]][T1]);
	        	TextDrawHideForPlayer(playerid,Player[Game[Player1]][T2]);
	    		new str[50];
	    		new name[24];
	    		GivePlayerWeapon(playerid,7,1);
	    		new rand = random(2);
				if(rand == 0){
				    name = GetName(Game[Player1]);
				    Player[Game[Player1]][Turn] = true;
				    Player[Game[Player2]][Turn] = false;
				}
				else if(rand == 1){
				    name = GetName(Game[Player2]);
				    Player[Game[Player1]][Turn] = false;
				    Player[Game[Player2]][Turn] = true;
    			}
    			for(new i = 0; i < 20; i++){
	    		    if(IsPlayerConnected(i) == 1 && Game[Player1] != i && Game[Player2] != i){
					    ShowMessage(i,"Bilard","Nie zdazyles zapisac sie do rozgrywki. Mozesz zaczekac do nastepnej rundy.");
					}
	 			}
				Player[playerid][Points] = 7;
				format(str,sizeof(str),"rozgrywke rozpoczyna %s",name);
	    		ShowMessage(Game[Player1],"Rozgrywka",str);
	    		ShowMessage(Game[Player2],"Rozgrywka",str);
				new string[80];
				format(string,sizeof(string),"%s %d~n~%s %d",GetName(Game[Player1]),Player[Game[Player1]][Points],GetName(Game[Player2]),Player[Game[Player2]][Points]);
	    		TextDrawSetString(Player[Game[Player1]][T3],string);
	    		TextDrawSetString(Player[Game[Player1]][T4],"Bilard");
	    		TextDrawSetString(Player[Game[Player2]][T3],string);
	    		TextDrawSetString(Player[Game[Player2]][T4],"Bilard");
	    		TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T3]);
	    		TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T4]);
	    		TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T3]);
	    		TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T4]);
	        	for(new i = 0; i < 16; i++){
					Ball[i][TouchID] = -1;
	        	}
	        }
	    }
	    return 1;
	}
	return 0;
}
public OnEndBilliard(){
	for(new i = 0; i < 17; i++){
	    DestroyObject(Ball[i][ObjID]);
    }
   	Game[Waiting] = false;
 	Game[Running] = false;
 	Game[WhiteInHole] = false;
    Game[BlackInHole] = false;
	Player[Game[Player1]][Sighting] = false;
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T1]);
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T2]);
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T3]);
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T4]);
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T5]);
	TextDrawHideForPlayer(Game[Player1],Player[Game[Player1]][T6]);
 	Player[Game[Player2]][Sighting] = false;
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T1]);
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T2]);
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T3]);
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T4]);
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T5]);
 	TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T6]);
}
public OnBallInHole(ballid){
	if(ballid != WHITE){
    	DestroyObject(Ball[ballid][ObjID]);
    	Ball[ballid][speed] = 0;
    }
    else{
	     Ball[WHITE][speed] = 0.2;
         SetObjectPos(Ball[WHITE][ObjID],2495.8618164063, -1671.1704101563, 13.209293525696);
	     StopObject(Ball[WHITE][ObjID]);
	     Ball[WHITE][x] = 2495.8618164063;
	     Ball[WHITE][y] = -1671.1704101563;
	     Ball[WHITE][z] = 13.209293525696;
    }
	Game[LastBall] = ballid;
	for(new i = 0; i < 16; i++){
	    if(ballid == i){
	        if(ballid <= 6){
			    if(Player[Game[Player1]][Turn] == true && Player[Game[Player1]][BBall] == NO_BALL){
			        Player[Game[Player1]][BBall] = CALA;
			        Player[Game[Player2]][BBall] = POL;
       			}
       			else if(Player[Game[Player2]][Turn] == true && Player[Game[Player2]][BBall] == NO_BALL){
       			    Player[Game[Player1]][BBall] = POL;
			        Player[Game[Player2]][BBall] = CALA;
       			}
				if(Player[Game[Player1]][BBall] == CALA)
				    Player[Game[Player1]][Points]--;
				else if(Player[Game[Player2]][BBall] == CALA)
				    Player[Game[Player2]][Points]--;
   			}
	        else if(6 < ballid <= 13)        {
                if(Player[Game[Player1]][Turn] == true && Player[Game[Player1]][BBall] == NO_BALL){
			        Player[Game[Player1]][BBall] = POL;
			        Player[Game[Player2]][BBall] = CALA;
       			}
       			else if(Player[Game[Player2]][Turn] == true && Player[Game[Player2]][BBall] == NO_BALL){
       			    Player[Game[Player1]][BBall] = CALA;
			        Player[Game[Player2]][BBall] = POL;
				}
	            if(Player[Game[Player1]][BBall] == POL)
				    Player[Game[Player1]][Points]--;
				else if(Player[Game[Player2]][BBall] == POL)
				    Player[Game[Player2]][Points]--;
         	}
			else if(ballid == WHITE)
				Game[WhiteInHole] = true;
			else if(ballid == BLACK)
			    Game[BlackInHole] = true;

	        break;
	    }
	}
	if(ballid != WHITE && ballid != BLACK){
		new str[80];
		format(str,sizeof(str),"%s %s %d~n~%s %s %d",GetName(Game[Player1]),Char[Player[Game[Player1]][BBall]],Player[Game[Player1]][Points], GetName(Game[Player2]),Char[Player[Game[Player2]][BBall]],Player[Game[Player2]][Points]);
		TextDrawSetString(Player[Game[Player1]][T3],str);
		TextDrawSetString(Player[Game[Player2]][T3],str);
		TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T3]);
		TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T3]);
	}
}
public BallProperties(){
	for(new i = 0; i < 16; i++){
		if(Ball[i][speed] > 0.1){
    		Ball[i][speed] = Ball[i][speed] / 1.4;
     		SetObjectSpeed(i,Ball[i][speed]);
    	}
   		else{
    	    Ball[i][speed] = 0;
	        StopObject(Ball[i][ObjID]);
	        if(CheckAllBalls() == 1){
	            KillTimer(Game[Timer]);
	            KillTimer(Game[Timer2]);
	            if(Game[LastBall] != - 1){
	                if(Game[LastBall] <= 6){
					    if(Player[Game[Player1]][BBall] == CALA){
					        Player[Game[Player1]][Turn] = true;
				   			Player[Game[Player2]][Turn] = false;
					    }
					    else if(Player[Game[Player2]][BBall] == CALA){
					        Player[Game[Player1]][Turn] = false;
				   			Player[Game[Player2]][Turn] = true;
					    }
					}
				    else if(6 < Game[LastBall] <= 13){
	                    if(Player[Game[Player1]][BBall] == POL){
					        Player[Game[Player1]][Turn] = true;
				   			Player[Game[Player2]][Turn] = false;
					    }
					    else if(Player[Game[Player2]][BBall] == POL){
					        Player[Game[Player1]][Turn] = false;
				   			Player[Game[Player2]][Turn] = true;
					    }
	                }
	            }
	            else{
					if(Player[Game[Player1]][Turn] == true){
				    	Player[Game[Player1]][Turn] = false;
				   		Player[Game[Player2]][Turn] = true;
					}
					else if(Player[Game[Player2]][Turn] == true){
				   		Player[Game[Player1]][Turn] = true;
				   		Player[Game[Player2]][Turn] = false;
					}
	            }
				TextDrawSetString(Player[Game[Player1]][T6],"Kolejka");
				TextDrawSetString(Player[Game[Player2]][T6],"Kolejka");
				TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T6]);
				TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T6]);
				if(Game[BlackInHole] == false){
				    if(Game[WhiteInHole] == false){
    					if(Player[Game[Player1]][Turn] == true){
				    		TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player1]));
				    		TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player1]));
						}
						else if(Player[Game[Player2]][Turn] == true){
				    		TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player2]));
				    		TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player2]));
						}
					}
					else{
					    if(Player[Game[Player1]][Turn] == true){
			        		Player[Game[Player1]][Turn] = false;
			        		Player[Game[Player2]][Turn] = true;
			        		TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player2]));
				    		TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player2]));
			    		}
			   			else if(Player[Game[Player2]][Turn] == true){
			        		Player[Game[Player1]][Turn] = true;
			        		Player[Game[Player2]][Turn] = false;
			        		TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player1]));
				    		TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player1]));
			    		}
			    		Game[WhiteInHole] = false;
			    		ShowMessage(Game[Player1],"Bilard","Wpadla biala bila");
			    		ShowMessage(Game[Player2],"Bilard","Wpadla biala bila");
					}
					TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T5]);
					TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T5]);
				}
				else{
 	    	   		Game[Waiting] = true;
 	    	   		Player[Game[Player1]][Sighting] = false;
 	    	   		Player[Game[Player2]][Sighting] = false;
 	    	   		TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T1]);
 	    			TextDrawHideForPlayer(Game[Player2],Player[Game[Player2]][T2]);
 	    			TextDrawSetString(Player[Game[Player1]][T4],"Rozgrywka");
 	    			TextDrawSetString(Player[Game[Player2]][T4],"Rozgrywka");
 	    			TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T4]);
 	    			TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T4]);
 	    			TextDrawSetString(Player[Game[Player1]][T3],"Wpadla czarna bila");
 	    			TextDrawSetString(Player[Game[Player2]][T3],"Wpadla czarna bila");
 	    			TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T3]);
 	   				TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T3]);
 	   				TextDrawSetString(Player[Game[Player1]][T6],"Wygrywa");
 	   				TextDrawSetString(Player[Game[Player2]][T6],"Wygrywa");
 	   				TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T6]);
 	   				TextDrawShowForPlayer(Game[Player2],Player[Game[Player2]][T6]);
				    if(Player[Game[Player1]][Points] == 0 || Player[Game[Player2]][Points] == 0){
				        if(Player[Game[Player1]][Turn] == true){
				            TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player1]));
			       		    TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player1]));
				        }
				        else if(Player[Game[Player2]][Turn] == true){
				            TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player2]));
			       		    TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player2]));
				        }
				    }
				    else{
      					if(Player[Game[Player1]][Turn] == true){
			       			TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player2]));
			       		    TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player2]));
			    		}
			    		else if(Player[Game[Player2]][Turn] == true){
			       			TextDrawSetString(Player[Game[Player1]][T5],GetName(Game[Player1]));
			       			TextDrawSetString(Player[Game[Player2]][T5],GetName(Game[Player1]));
			   			}
					}
					Player[Game[Player1]][Turn] = false;
			    	Player[Game[Player2]][Turn] = false;
			    	Game[BlackInHole] = false;
			    	TextDrawShowForPlayer(Game[Player1],Player[Game[Player1]][T5]);
 	    			TextDrawShowForPlayer(Game[Player2],Player[Game[Player1]][T5]);
 	    			SetTimer("OnEndBilliard",10000,0);
				}
				Game[LastBall] = -1;
				break;
	        }
		}
	}
}
public OnTimer(){
	new temp[2];
	for(new i = 0; i < 16; i++){
	    for(new j = 0; j < 16; j++){
	        if(i != j){
        		if(GetVectorDistance_OB(Ball[i][ObjID],Ball[j][ObjID]) < 0.09){
			    	if(Ball[i][TouchID] != j && Ball[j][TouchID] != i){
        				if(Ball[i][speed] > 0.1){
        		    		new Float:pos[6];
        		    		GetObjectPos(Ball[i][ObjID],pos[0],pos[1],pos[2]);
        		    		GetObjectPos(Ball[j][ObjID],pos[3],pos[4],pos[5]);
        		    		Ball[j][TouchID] = i;
        		   		    Ball[i][TouchID] = j;
        		    		temp[0] = i;
        		    		temp[1] = j;
        		    		Ball[j][a] = GetVectorAngle(Ball[i][ObjID],Ball[j][ObjID]);
        		    		Ball[j][speed] = Ball[i][speed];
        		    		if(Ball[i][speed] < 3){
        		       			Ball[i][a] = GetVectorAngle(Ball[i][ObjID],Ball[j][ObjID]) + 180;
        		    			Ball[i][speed] = Ball[i][speed] / 1.15; //1.5
        		    			pos[0] += 5 * floatsin(-Ball[i][a],degrees); //(Ball[i][speed] / 1.1)
        		    			pos[1] += 5 * floatcos(-Ball[i][a],degrees); //(Ball[i][speed] / 1.1)
        		    			MoveObject(Ball[i][ObjID],pos[0],pos[1],pos[2],Ball[i][speed]);
        		   			}
        		    		else if(Ball[i][speed] >= 3){
        		        		Ball[i][speed] = Ball[i][speed] / 1.15; //2
        		        		pos[0] += 5 * floatsin(-Ball[i][a],degrees); //Ball[i][speed] / 2) + random(25)
        		        		pos[1] += 5 * floatcos(-Ball[i][a],degrees); //Ball[i][speed] / 2) - random(25)
        		        		MoveObject(Ball[i][ObjID],pos[0],pos[1],pos[2],Ball[i][speed]);
        		    		}
							Ball[j][speed] = Ball[j][speed] / 1.1;
							pos[3] += 5 * floatsin(-Ball[j][a],degrees); //Ball[j][speed] / 1.3
							pos[4] += 5 * floatcos(-Ball[j][a],degrees); //Ball[j][speed] / 1.3
							MoveObject(Ball[j][ObjID],pos[3],pos[4],pos[5],Ball[j][speed]);
			    			Ball[i][x] = pos[0];
							Ball[i][y] = pos[1];
							Ball[i][z] = Ball[WHITE][z];
							Ball[j][x] = pos[3];
							Ball[j][y] = pos[4];
							Ball[j][z] = Ball[WHITE][z];
						}
        		    }
        		}
        	}
		}
  		new Float:pos[5];
		GetObjectPos(Ball[i][ObjID],pos[0],pos[1],pos[2]);
		for(new h = 0; h < 6; h++){
		    if(PointInLong(0.04,pos[0],pos[1],Hole[h][0],Hole[h][1],Hole[h][2],Hole[h][3]) == 1){
		        CallRemoteFunction("OnBallInHole","d",i);
		        break;
		    }
		}
		for(new k = 0; k < POLYGONS; k++){
  		    if(PointInPolygon(pos[0],pos[1],k) == 1){
  		        new Float:tmp[4];
  		        tmp[0] = pos[0];
  		        tmp[1] = pos[1];
  		        tmp[2] = pos[0];
  		        tmp[3] = pos[1];
  		        pos[0] += floatsin(-Ball[i][a] + 180,degrees) / 5;
				pos[1] += floatcos(-Ball[i][a] + 180,degrees) / 5;
				new Float:angle[2];
				angle[0] = GetVectorAngle_XY(tmp[0],tmp[1],Polygon[k][0][x],Polygon[k][0][y]);
				if(angle[0] > 0){
				    angle[1] = angle[0] + 180;
				    if(angle[1] > 360)
				        angle[1] = angle[1] - 360;
				}
				else{
                    angle[1] = GetVectorAngle_XY(tmp[0],tmp[1],Polygon[k][0][x],Polygon[k][0][y]);
					angle[0] = angle[1] + 180;
					if(angle[0] > 360)
					    angle[0] = angle[0] - 360;
					if(angle[1] < 0)
					    angle[1] = angle[0] + 180;
				}
				new Float:stop = Ball[i][a] + 180;
				if(stop > 360)
				    stop = stop - 360;
				if(angle[0] < angle[1]){
				    if(angle[0] < stop < angle[1])
						angle[0] = angle[0] + 90;
					else if(angle[1] < stop < 360 || 0 < stop < angle[0]){
						angle[0] = angle[1] + 90;
						if(angle[0] > 360)
				  			angle[0] = angle[0] - 360;
				    }
				}
				else if(angle[0] > angle[1]){
				    if(angle[0] > stop > angle[1])
				        angle[0] = angle[1] + 90;
					else if(angle[1] > stop > 0){
					    angle[0] = angle[1] - 90;
					    if(angle[0] > 360)
			      			angle[0] = angle[0] - 360;
					}
					else if(360 > stop > angle[0]){
					    angle[0] = angle[0] + 90;
					    if(angle[0] > 360)
			      			angle[0] = angle[0] - 360;
					}
				}
				new Float:sraka[2];
				sraka[0] = tmp[0];
				sraka[1] = tmp[1];
				sraka[0] += floatsin(-angle[0],degrees) / 50;
				sraka[1] += floatcos(-angle[0],degrees) / 50;
				tmp[0] += floatsin(-angle[0],degrees) / 7;
				tmp[1] += floatcos(-angle[0],degrees) / 7;
				SetObjectPos(Ball[i][ObjID],sraka[0],sraka[1],13.199293525696);
				new Float:ang;
				new Float:dist;
				ang = GetVectorAngle_XY(pos[0],pos[1],tmp[0],tmp[1]);
				dist = GetDistance(pos[0],pos[1],tmp[0],tmp[1]);
				pos[0] += (dist * floatsin(-ang,degrees)) * 2;
				pos[1] += (dist * floatcos(-ang,degrees)) * 2;
				new Float:ang2;
				ang2 = GetVectorAngle_XY(pos[0],pos[1],tmp[2],tmp[3]);
				ang2 = ang2 + 180;
				tmp[2] += 5 * floatsin(-ang2,degrees);
				tmp[3] += 5 * floatcos(-ang2,degrees);
				MoveObject(Ball[i][ObjID],tmp[2],tmp[3],13.199293525696,Ball[i][speed]);
				Ball[i][x] = tmp[2];
				Ball[i][y] = tmp[3];
				if(ang2 > 360)
				    ang2 = ang2 - 360;

				Ball[i][a] = ang2;
  		        break;
  		    }
  		}
	}
	Ball[temp[0]][TouchID] = -1;
	Ball[temp[1]][TouchID] = -1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
	if(newkeys & 128){
	    if(Player[playerid][Sighting] == false && CheckAllBalls() == 1 && Game[Running] == true && Player[playerid][Turn] == true){
	        new Float:dist = GetVectorDistance_PL(playerid,Ball[WHITE][ObjID]);
	    	if(GetPlayerWeapon(playerid) == 7 && dist < 1.6){
	        	new Float:pos[7];
	        	GetObjectPos(Ball[WHITE][ObjID],pos[0],pos[1],pos[2]);
				GetPlayerPos(playerid,pos[3],pos[4],pos[5]);
				pos[6] = GetVectorAngle_XY(pos[3],pos[4],pos[0],pos[1]);
				Player[playerid][Sighting] = true;
				Player[playerid][AfterSighting] = true;
				Player[playerid][SelectLR] = 0;
				Player[playerid][SelectUD] = 5;
				TextDrawSetString(Player[playerid][T2],"Predkosc");
	    	    TextDrawShowForPlayer(playerid,Player[playerid][T2]);
	    	    TextDrawSetString(Player[playerid][T1],"60 cm~w~/s");
	    	    TextDrawShowForPlayer(playerid,Player[playerid][T1]);
				if(0.9 <= dist <= 1.2){
				    pos[3] += floatsin(-pos[6] + 180,degrees) * 0.3;
				    pos[4] += floatcos(-pos[6] + 180,degrees) * 0.3;
				}
				else if(dist < 0.9){
				    pos[3] += floatsin(-pos[6] + 180,degrees) * 0.6;
				    pos[4] += floatcos(-pos[6] + 180,degrees) * 0.6;
				}
				SetPlayerPos(playerid,pos[3],pos[4],pos[5]);
				SetPlayerFacingAngle(playerid,pos[6] - 2.2);
				Player[playerid][a] = pos[6] - 2.2;
    			pos[3] += floatsin(-pos[6] - 10,degrees) * 0.2;
		  		pos[4] += floatcos(-pos[6] - 10,degrees) * 0.2;
		    	SetPlayerCameraPos(playerid,pos[3],pos[4],pos[2] + 0.5);
			    SetPlayerCameraLookAt(playerid,pos[0],pos[1],pos[2]);
			    ApplyAnimation(playerid,"POOL","POOL_Med_Start",1,0,0,0,1,0,1);
	    	}
   		}
	}
	else if(oldkeys & 128){
	    if(Player[playerid][AfterSighting] == true){
	    	SetCameraBehindPlayer(playerid);
	    	ApplyAnimation(playerid,"POOL","POOL_Med_Shot_O",4.1,0,1,1,1,1,1);
     		TextDrawHideForPlayer(playerid,Player[playerid][T1]);
	   		TextDrawHideForPlayer(playerid,Player[playerid][T2]);
	   		Player[playerid][AfterSighting] = false;
	   		if(Player[playerid][Sighting] == true)
	   		    Player[playerid][Sighting] = false;
	   	}
	}
	if(newkeys & KEY_FIRE){
	    if(Player[playerid][Sighting] == true){
	        new Float:pos[7];
	    	GetObjectPos(Ball[WHITE][ObjID],pos[0],pos[1],pos[2]);
	    	Game[Timer] = SetTimer("OnTimer",10,1);
	    	Game[Timer2] = SetTimer("BallProperties",200,1);
	    	TextDrawHideForPlayer(playerid,Player[playerid][T1]);
	        TextDrawHideForPlayer(playerid,Player[playerid][T2]);
	        Player[playerid][Sighting] = false;
	    	if(Player[playerid][a] > 360)
				Player[playerid][a] = Player[playerid][a] - 360;
			else if(Player[playerid][a] < 0)
			    Player[playerid][a] = 360 + Player[playerid][a];

			Ball[WHITE][a] = Player[playerid][a];
	    	pos[0] += 5 * floatsin(-Ball[WHITE][a],degrees);
	    	pos[1] += 5 * floatcos(-Ball[WHITE][a],degrees);
			Ball[WHITE][x] = pos[0];
			Ball[WHITE][y] = pos[1];
			Ball[WHITE][z] = pos[2];
			Ball[WHITE][speed] = Player[playerid][SelectUD] / 1.5;
			new Float:pp[4];
			GetPlayerPos(playerid,pp[0],pp[1],pp[2]);
			GetPlayerFacingAngle(playerid,pp[3]);
			pp[0] += floatsin(-pp[3] - 90,degrees) * 0.3;
			pp[1] += floatcos(-pp[3] - 90,degrees) * 0.3;
			SetPlayerPos(playerid,pp[0],pp[1],pp[2]);
			SetPlayerCameraPos(playerid,2496.4970703125, -1671.1528320313, 12.275947036743 + 5);
			SetPlayerCameraLookAt(playerid,2496.4970703125, -1671.1528320313, 12.275947036743);
			ApplyAnimation(playerid,"POOL","POOL_Med_Shot",4.1,0,1,1,1,1,1);
	    }
	}
	return 1;
}
public OnPlayerUpdate(playerid){
	if(Player[playerid][Sighting] == true){
	    if(GetVectorDistance_PL(playerid,Ball[WHITE][ObjID]) < 1.6){
	    	new key[3];
	    	new Float:pos[3];
	    	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
    		GetPlayerKeys(playerid,key[0],key[1],key[2]);
	    	if(key[2] == KEY_LEFT && Player[playerid][SelectLR] < 10){
	    	    new Float:angle;
	    	    new Float:angXY;
				GetPlayerFacingAngle(playerid,angle);
				Player[playerid][SelectLR]++;
				pos[0] += floatsin(-angle - 90,degrees) / 20;
				pos[1] += floatcos(-angle - 90,degrees) / 20;
				new Float:dist = GetVectorDistance_PL(playerid,Ball[WHITE][ObjID]);
				new Float:pp[3];
				GetObjectPos(Ball[WHITE][ObjID],pp[0],pp[1],pp[2]);
				angXY = GetVectorAngle_XY(pos[0],pos[1],pp[0],pp[1]);
				if(0.9 <= dist <= 1.2){
					pos[0] += floatsin(-angXY + 180,degrees) * 0.3;
					pos[1] += floatcos(-angXY + 180,degrees) * 0.3;
				}
				else if(dist < 0.9){
					pos[0] += floatsin(-angXY + 180,degrees) * 0.6;
					pos[1] += floatcos(-angXY + 180,degrees) * 0.6;
				}
				SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
				SetPlayerFacingAngle(playerid,angXY - 2.2);
				Player[playerid][a] = angXY - 2.2;
				pos[0] += floatsin(-angXY - 10,degrees) * 0.2;
 				pos[1] += floatcos(-angXY - 10,degrees) * 0.2;
		   	 	SetPlayerCameraPos(playerid,pos[0],pos[1],pp[2] + 0.5);
	       		SetPlayerCameraLookAt(playerid,pp[0],pp[1],pp[2]);
	        	ApplyAnimation(playerid,"POOL","POOL_Med_Start",1,0,0,0,1,0,1);
	    	}
	    	else if(key[2] == KEY_RIGHT && Player[playerid][SelectLR] > -10){
	    	    new Float:angle;
	    	    new Float:angXY;
				GetPlayerFacingAngle(playerid,angle);
				pos[0] += floatsin(-angle + 90,degrees) / 20;
				pos[1] += floatcos(-angle + 90,degrees) / 20;
				Player[playerid][SelectLR]--;
				new Float:dist = GetVectorDistance_PL(playerid,Ball[WHITE][ObjID]);
				new Float:pp[3];
				GetObjectPos(Ball[WHITE][ObjID],pp[0],pp[1],pp[2]);
				angXY = GetVectorAngle_XY(pos[0],pos[1],pp[0],pp[1]);
				if(0.9 <= dist <= 1.2){
					pos[0] += floatsin(-angXY + 180,degrees) * 0.3;
					pos[1] += floatcos(-angXY + 180,degrees) * 0.3;
				}
				else if(dist < 0.9){
					pos[0] += floatsin(-angXY + 180,degrees) * 0.6;
					pos[1] += floatcos(-angXY + 180,degrees) * 0.6;
				}
				SetPlayerPos(playerid,pos[0],pos[1],pos[2]);
				SetPlayerFacingAngle(playerid,angXY - 2.2);
				Player[playerid][a] = angXY - 2.2;
				pos[0] += floatsin(-angXY - 10,degrees) * 0.2;
 				pos[1] += floatcos(-angXY - 10,degrees) * 0.2;
		    	SetPlayerCameraPos(playerid,pos[0],pos[1],pp[2] + 0.5);
	        	SetPlayerCameraLookAt(playerid,pp[0],pp[1],pp[2]);
	        	ApplyAnimation(playerid,"POOL","POOL_Med_Start",1,0,0,0,1,0,1);
	    	}
	    	else if(key[1] == KEY_UP || key[1] == KEY_DOWN){
	    	    if(key[1] == KEY_UP && 0 < Player[playerid][SelectUD] < 8){
					Player[playerid][SelectUD]++;
					if(Player[playerid][TDTimer] != 0){
	    	        	KillTimer(Player[playerid][TDTimer]);
	    				Player[playerid][TDTimer] = 0;
	    	    	}
	    	    	TextDrawSetString(Player[playerid][T2],"Predkosc");
	    	    	TextDrawShowForPlayer(playerid,Player[playerid][T2]);
	    	    	new str[20];
	    	    	new length = (Player[playerid][SelectUD] / 2) * 30;
	    	    	if(length == 0)
						length = 15;

	    	   		format(str,sizeof(str),"%d cm~w~/s",length);
	    	    	TextDrawSetString(Player[playerid][T1],str);
	    	    	TextDrawShowForPlayer(playerid,Player[playerid][T1]);
				}
	    	    else if(key[1] == KEY_DOWN && 1 < Player[playerid][SelectUD] <= 8){
	    	        Player[playerid][SelectUD]--;
	    	        if(Player[playerid][TDTimer] != 0){
	    	        	KillTimer(Player[playerid][TDTimer]);
	    				Player[playerid][TDTimer] = 0;
	    	    	}
	    	    	TextDrawSetString(Player[playerid][T2],"Predkosc");
	    	    	TextDrawShowForPlayer(playerid,Player[playerid][T2]);
	    	    	new str[20];
					new length = (Player[playerid][SelectUD] / 2) * 30;
					if(length == 0)
						length = 15;

	    	   		format(str,sizeof(str),"%d cm~w~/s",length);
	    	    	TextDrawSetString(Player[playerid][T1],str);
	    	    	TextDrawShowForPlayer(playerid,Player[playerid][T1]);
      			}
	    	}
		}
    }
	return 1;
}
public OnShowedTD(playerid){
	TextDrawHideForPlayer(playerid,Player[playerid][T1]);
	TextDrawHideForPlayer(playerid,Player[playerid][T2]);
	Player[playerid][TDTimer] = 0;
}
stock SetObjectSpeed(sysobj, Float:speedy){
	MoveObject(Ball[sysobj][ObjID],Ball[sysobj][x],Ball[sysobj][y],Ball[sysobj][z],speedy);
}
stock CheckAllBalls(){
	for(new i = 0; i < 16; i++){
	    if(Ball[i][speed] != 0)
	        return 0;
	    else if(i == 15){
	        if(Ball[i][speed] == 0)
	            return 1;
	    }
	}
	return 0;
}
stock Float:GetVectorAngle(obj, obj2){
	new Float:vector[3];
	new Float:pos[6];
	GetObjectPos(obj,pos[0],pos[1],pos[2]);
	GetObjectPos(obj2,pos[3],pos[4],pos[5]);
	vector[0] = pos[3] - pos[0];
	vector[1] = pos[4] - pos[1];
	vector[2] = atan(-(vector[0] / vector[1]));
	if(vector[1] < 0)
	    vector[2] = vector[2] >= 180 ? vector[2] - 180 : vector[2] + 180;

	return vector[2];
}
stock Float:GetVectorAngle_XY(Float:fx, Float:fy, Float:tx, Float:ty){
	new Float:vector[3];
	vector[0] = tx - fx;
	vector[1] = ty - fy;
	vector[2] = atan(-(vector[0] / vector[1]));
	if(vector[1] < 0)
	    vector[2] = vector[2] >= 180 ? vector[2] - 180 : vector[2] + 180;

	return vector[2];
}
stock Float:GetVectorDistance_PL(playerid, obj){
    new Float:pos[6];
	GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
	GetObjectPos(obj,pos[3],pos[4],pos[5]);
	return floatsqroot(floatpower(pos[3] - pos[0],2) + floatpower(pos[4] - pos[1],2) + floatpower(pos[5] - pos[2],2));
}
stock Float:GetVectorDistance_OB(obj, obj2){
	new Float:pos[6];
	GetObjectPos(obj,pos[0],pos[1],pos[2]);
	GetObjectPos(obj2,pos[3],pos[4],pos[5]);
	return floatsqroot(floatpower(pos[3] - pos[0],2) + floatpower(pos[4] - pos[1],2) + floatpower(pos[5] - pos[2],2));
}
stock Float:GetDistance(Float:fx, Float:fy, Float:tx, Float:ty){
	return floatsqroot(floatpower(tx - fx,2) + floatpower(ty - fy,2));
}
stock Float:GetDistancePointToLong(Float:px,Float:py, Float:px1,Float:py1, Float:px2,Float:py2){
    new Float:vec[3];
	vec[0] = GetDistance(px1,py1,px2,py2);
	if((vec[1] = GetDistance(px,py,px1,py1)) < vec[0] && (vec[2] = GetDistance(px,py,px2,py2)) < vec[0]){
	    new Float:opt[2];
		opt[0] = (vec[0] + vec[1] + vec[2]) / 2;
	    opt[1] = floatsqroot(opt[0] * (opt[0] - vec[0]) * (opt[0] - vec[1]) * (opt[0] - vec[2]));
		opt[1] = ((opt[1] * 2) / vec[0]);
		return opt[1];
	}
	return 0.0;
}
stock PointInLong(Float:size, Float:px,Float:py, Float:px1,Float:py1, Float:px2,Float:py2){
	new Float:vec[3];
	vec[0] = GetDistance(px1,py1,px2,py2);
	if((vec[1] = GetDistance(px,py,px1,py1)) < vec[0] && (vec[2] = GetDistance(px,py,px2,py2)) < vec[0]){
	    new Float:opt[2];
		opt[0] = (vec[0] + vec[1] + vec[2]) / 2;
	    opt[1] = floatsqroot(opt[0] * (opt[0] - vec[0]) * (opt[0] - vec[1]) * (opt[0] - vec[2]));
		opt[1] = ((opt[1] * 2) / vec[0]) * 2;
		if(opt[1] < size)
		    return 1;
	}
	return 0;
}
stock CreatePolygon(Float:px1,Float:py1, Float:px2,Float:py2){
	for(new i = 0; i < POLYGONS; i++){
	    if(PolyResult[i][Progress] == false){
			PolyResult[i][Progress] = true;
			PolyResult[i][Vertices] = 2;
			Polygon[i][0][x] = px1;
			Polygon[i][0][y] = py1;
			Polygon[i][1][x] = px2;
			Polygon[i][1][y] = py2;
			return i;
	    }
	}
	return 0;
}

stock ShowMessage(playerid, message1[], message2[]){
	if(Player[playerid][TDTimer] != 0){
	    KillTimer(Player[playerid][TDTimer]);
	    Player[playerid][TDTimer] = 0;
	}
		TextDrawHideForPlayer(playerid,Player[playerid][T1]);
    TextDrawHideForPlayer(playerid,Player[playerid][T2]);
	TextDrawSetString(Player[playerid][T2],message1);
	TextDrawSetString(Player[playerid][T1],message2);
	TextDrawShowForPlayer(playerid,Player[playerid][T1]);
	TextDrawShowForPlayer(playerid,Player[playerid][T2]);
		new space;
	for(new i = 0; i < strlen(message2); i++){
		if(message2[i] == ' ')
		    space++;
	}
		if(space != 0)
		Player[playerid][TDTimer] = SetTimerEx("OnShowedTD",space * 3000,0,"d",playerid);
	else
	    Player[playerid][TDTimer] = SetTimerEx("OnShowedTD",3000,0,"d",playerid);
}
stock PointInPolygon(Float:px, Float:py, polygonid){
	if(PolyResult[polygonid][Progress] == true){
		for(new i = 0; i < PolyResult[polygonid][Vertices]; i++){
			if(i == PolyResult[polygonid][Vertices] - 1){
			    if(PointInLong(0.06,px,py,Polygon[polygonid][i][x],Polygon[polygonid][i][y],Polygon[polygonid][0][x],Polygon[polygonid][0][y]) == 1)
		        	return 1;
			}
			else{
				if(PointInLong(0.06,px,py,Polygon[polygonid][i][x],Polygon[polygonid][i][y],Polygon[polygonid][i + 1][x],Polygon[polygonid][i + 1][y]) == 1)
		      		return 1;
   			}
		}
	}
	return 0;
}
stock GetName(playerid){
	new name[24];
	GetPlayerName(playerid,name,24);
	return name;
}
stock Release(){
	for(new i = 0; i < 20; i++){
	    TextDrawHideForPlayer(i,Player[i][T1]);
	    TextDrawHideForPlayer(i,Player[i][T2]);
	    TextDrawHideForPlayer(i,Player[i][T3]);
	    TextDrawHideForPlayer(i,Player[i][T4]);
	    TextDrawHideForPlayer(i,Player[i][T5]);
	    TextDrawHideForPlayer(i,Player[i][T6]);
	    TextDrawDestroy(Player[i][T1]);
     	TextDrawDestroy(Player[i][T2]);
     	TextDrawDestroy(Player[i][T3]);
     	TextDrawDestroy(Player[i][T4]);
     	TextDrawDestroy(Player[i][T5]);
     	TextDrawDestroy(Player[i][T6]);
	}
	if(Game[Running] == true || Game[Waiting] == true){
		KillTimer(Game[Timer]);
		KillTimer(Game[Timer2]);
		for(new i = 0; i < 17; i++){
	    	DestroyObject(Ball[i][ObjID]);
 	    }
	}
}
