//$ region carmod-textdrawupdate
DestroyCarMenu(playerid){
	for(new i = 0; i < 33; i++){
	     TextDrawDestroy(menuDraws[playerid][i]);	}}
DestroyMenuGas(playerid){
	for(new i = 0; i < MAX_MENUG_ITEMS+1; i++){
	     TextDrawDestroy(menuDraws2[playerid][i]);	}}
DestroyMenuColor(){
	for(new i = 0; i < TOTAL_COLORS+1; i++){
	    TextDrawDestroy(colordraw[i]);}}
HideMenuColor(playerid){
	for(new g=0; g < 64; g++){
		TextDrawHideForPlayer(playerid,colordraw[g]);}}
HideMenuColor2(playerid){
	for(new i=64; i < TOTAL_COLORS; i++){
		TextDrawHideForPlayer(playerid,colordraw[i]);}}
ShowMenuColor(playerid){
TextDrawSetString(menuDraws[playerid][32],"Colors - Page 1");
for(new g=0; g < 64; g++){
TextDrawShowForPlayer(playerid,colordraw[g]);}}
ShowMenuColor2(playerid){
TextDrawSetString(menuDraws[playerid][32],"Colors - Page 2");
for(new i=64; i < TOTAL_COLORS; i++){
TextDrawShowForPlayer(playerid,colordraw[i]);}}
UpdateColSel(playerid){
}
UpdateCarmMenu(playerid){
  		TextDrawSetString(menuDraws[playerid][32],menuNames[playerid][0]);
		for(new i = itemStart[playerid][menuPlace[playerid]]; i < totalItems[playerid][menuPlace[playerid]]; i++){
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]]);
     	TextDrawSetString(menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]], carDefines[i][namec]);
	    if(itemPlace[playerid][menuPlace[playerid]] == i){
			TextDrawColor( menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]] , COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i-itemStart[playerid][menuPlace[playerid]]]);
		}
}
UpdatecartypeMenu(playerid){
	for(new i = 0; i < MAX_TYPE_ITEMS; i++){
		//strmid(menutypeNames[playerid][i], carType[i][typeName], 0, 40);
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i]);
		format(menutypeNames[playerid][i], 40, "%s", carType[i][typeName]);
     	TextDrawSetString(menuDraws[playerid][i], menutypeNames[playerid][i]);
	    if(itemPlace[playerid][menuPlace[playerid]] == i){
			TextDrawColor( menuDraws[playerid][i] , COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i]);
	}
}
UpdatespideyMenu(playerid){
//	strmid(menuNames[playerid][0], carType[itemPlace[playerid][0]][typeName], 0, 40, 40);
	TextDrawSetString(menuDraws[playerid][32], "Autohaus");
	format(menuNames[playerid][0], 40, "%s", carType[itemPlace[playerid][0]][typeName]);
	format(menuNames[playerid][1], 40, "%s", carDefines[itemPlace[playerid][1]][namec]);
	format(menuNames[playerid][2], 40, "COLOR1 - %d", itemPlace[playerid][2]);
	format(menuNames[playerid][3], 40, "COLOR2 - %d", itemPlace[playerid][3]);
	format(menuNames[playerid][4], 40, "Buy It!");
	format(menuNames[playerid][5], 40, "Exit");
	for(new i = 0; i < MAX_MENU_ITEMS; i++){
		TextDrawHideForPlayer(playerid , menuDraws[playerid][i]);
		TextDrawSetString(menuDraws[playerid][i], menuNames[playerid][i]);
	    if(menuPlace[playerid] == i){
			TextDrawColor(menuDraws[playerid][i], COLOR_WHITE);}
		else {
			TextDrawColor(menuDraws[playerid][i], COLOR_LIGHTBLUE);}
		TextDrawShowForPlayer(playerid , menuDraws[playerid][i]);
	}
}
ClearCarMenu(playerid){
	for (new i = 0; i < 30; i++){
		TextDrawSetString(menuDraws[playerid][i], " ");}}
CreateCarSMenu(playerid){
if ( carsmenucreated==0 ){
	carsmenucreated=carsmenucreated+1;
    colordraw[0] = TextDrawCreate(47.500000,140.000000,"  ");
    colordraw[1] = TextDrawCreate(65.000000,140.000000,"  ");
    colordraw[2] = TextDrawCreate(82.500000,140.000000,"  ");
    colordraw[3] = TextDrawCreate(100.000000,140.000000,"  ");
    colordraw[4] = TextDrawCreate(117.500000,140.000000,"  ");
    colordraw[5] = TextDrawCreate(135.000000,140.000000,"  ");
    colordraw[6] = TextDrawCreate(152.500000,140.000000,"  ");
    colordraw[7] = TextDrawCreate(170.000000,140.000000,"  ");
    colordraw[8] = TextDrawCreate(47.500000, 157.500000,"  ");
    colordraw[9] = TextDrawCreate(65.000000, 157.500000,"  ");
    colordraw[10] = TextDrawCreate(82.500000, 157.500000,"  ");
    colordraw[11] = TextDrawCreate(100.000000, 157.500000,"  ");
    colordraw[12] = TextDrawCreate(117.500000, 157.500000,"  ");
    colordraw[13] = TextDrawCreate(135.000000, 157.500000,"  ");
    colordraw[14] = TextDrawCreate(152.500000, 157.500000,"  ");
    colordraw[15] = TextDrawCreate(170.000000, 157.500000,"  ");
    colordraw[16] = TextDrawCreate(47.500000, 175.000000,"  ");
    colordraw[17] = TextDrawCreate(65.000000, 175.000000,"  ");
    colordraw[18] = TextDrawCreate(82.500000, 175.000000,"  ");
    colordraw[19] = TextDrawCreate(100.000000, 175.000000,"  ");
    colordraw[20] = TextDrawCreate(117.500000, 175.000000,"  ");
    colordraw[21] = TextDrawCreate(135.000000, 175.000000,"  ");
    colordraw[22] = TextDrawCreate(152.500000, 175.000000,"  ");
    colordraw[23] = TextDrawCreate(170.000000, 175.000000,"  ");
    colordraw[24] = TextDrawCreate(47.500000, 192.500000,"  ");
    colordraw[25] = TextDrawCreate(65.000000, 192.500000,"  ");
    colordraw[26] = TextDrawCreate(82.500000, 192.500000,"  ");
    colordraw[27] = TextDrawCreate(100.000000, 192.500000,"  ");
    colordraw[28] = TextDrawCreate(117.500000, 192.500000,"  ");
    colordraw[29] = TextDrawCreate(135.000000, 192.500000,"  ");
    colordraw[30] = TextDrawCreate(152.500000, 192.500000,"  ");
    colordraw[31] = TextDrawCreate(170.000000, 192.500000,"  ");
    colordraw[32] = TextDrawCreate(47.500000, 210.000000,"  ");
    colordraw[33] = TextDrawCreate(65.000000, 210.000000,"  ");
    colordraw[34] = TextDrawCreate(82.500000, 210.000000,"  ");
    colordraw[35] = TextDrawCreate(100.000000, 210.000000,"  ");
    colordraw[36] = TextDrawCreate(117.500000, 210.000000,"  ");
    colordraw[37] = TextDrawCreate(135.000000, 210.000000,"  ");
    colordraw[38] = TextDrawCreate(152.500000, 210.000000,"  ");
    colordraw[39] = TextDrawCreate(170.000000, 210.000000,"  ");
    colordraw[40] = TextDrawCreate(47.500000, 227.500000,"  ");
    colordraw[41] = TextDrawCreate(65.000000, 227.500000,"  ");
    colordraw[42] = TextDrawCreate(82.500000, 227.500000,"  ");
    colordraw[43] = TextDrawCreate(100.000000, 227.500000,"  ");
    colordraw[44] = TextDrawCreate(117.500000, 227.500000,"  ");
    colordraw[45] = TextDrawCreate(135.000000, 227.500000,"  ");
    colordraw[46] = TextDrawCreate(152.500000, 227.500000,"  ");
    colordraw[47] = TextDrawCreate(170.000000, 227.500000,"  ");
    colordraw[48] = TextDrawCreate(47.500000, 245.000000,"  ");
    colordraw[49] = TextDrawCreate(65.000000, 245.000000,"  ");
    colordraw[50] = TextDrawCreate(82.500000, 245.000000,"  ");
    colordraw[51] = TextDrawCreate(100.000000, 245.000000,"  ");
    colordraw[52] = TextDrawCreate(117.500000, 245.000000,"  ");
    colordraw[53] = TextDrawCreate(135.000000, 245.000000,"  ");
    colordraw[54] = TextDrawCreate(152.500000, 245.000000,"  ");
    colordraw[55] = TextDrawCreate(170.000000, 245.000000,"  ");
    colordraw[56] = TextDrawCreate(47.500000, 262.500000,"  ");
    colordraw[57] = TextDrawCreate(65.000000, 262.500000,"  ");
    colordraw[58] = TextDrawCreate(82.500000, 262.500000,"  ");
    colordraw[59] = TextDrawCreate(100.000000, 262.500000,"  ");
    colordraw[60] = TextDrawCreate(117.500000, 262.500000,"  ");
    colordraw[61] = TextDrawCreate(135.000000, 262.500000,"  ");
    colordraw[62] = TextDrawCreate(152.500000, 262.500000,"  ");
    colordraw[63] = TextDrawCreate(170.000000, 262.500000,"  ");
    colordraw[64] = TextDrawCreate(47.500000,140.000000,"  ");
    colordraw[65] = TextDrawCreate(65.000000,140.000000,"  ");
    colordraw[66] = TextDrawCreate(82.500000,140.000000,"  ");
    colordraw[67] = TextDrawCreate(100.000000,140.000000,"  ");
    colordraw[68] = TextDrawCreate(117.500000,140.000000,"  ");
    colordraw[69] = TextDrawCreate(135.000000,140.000000,"  ");
    colordraw[70] = TextDrawCreate(152.500000,140.000000,"  ");
    colordraw[71] = TextDrawCreate(170.000000,140.000000,"  ");
    colordraw[72] = TextDrawCreate(47.500000, 157.500000,"  ");
    colordraw[73] = TextDrawCreate(65.000000, 157.500000,"  ");
    colordraw[74] = TextDrawCreate(82.500000, 157.500000,"  ");
    colordraw[75] = TextDrawCreate(100.000000, 157.500000,"  ");
    colordraw[76] = TextDrawCreate(117.500000, 157.500000,"  ");
    colordraw[77] = TextDrawCreate(135.000000, 157.500000,"  ");
    colordraw[78] = TextDrawCreate(152.500000, 157.500000,"  ");
    colordraw[79] = TextDrawCreate(170.000000, 157.500000,"  ");
    colordraw[80] = TextDrawCreate(47.500000, 175.000000,"  ");
    colordraw[81] = TextDrawCreate(65.000000, 175.000000,"  ");
    colordraw[82] = TextDrawCreate(82.500000, 175.000000,"  ");
    colordraw[83] = TextDrawCreate(100.000000, 175.000000,"  ");
    colordraw[84] = TextDrawCreate(117.500000, 175.000000,"  ");
    colordraw[85] = TextDrawCreate(135.000000, 175.000000,"  ");
    colordraw[86] = TextDrawCreate(152.500000, 175.000000,"  ");
    colordraw[87] = TextDrawCreate(170.000000, 175.000000,"  ");
    colordraw[88] = TextDrawCreate(47.500000, 192.500000,"  ");
    colordraw[89] = TextDrawCreate(65.000000, 192.500000,"  ");
    colordraw[90] = TextDrawCreate(82.500000, 192.500000,"  ");
    colordraw[91] = TextDrawCreate(100.000000, 192.500000,"  ");
    colordraw[92] = TextDrawCreate(117.500000, 192.500000,"  ");
    colordraw[93] = TextDrawCreate(135.000000, 192.500000,"  ");
    colordraw[94] = TextDrawCreate(152.500000, 192.500000,"  ");
    colordraw[95] = TextDrawCreate(170.000000, 192.500000,"  ");
    colordraw[96] = TextDrawCreate(47.500000, 210.000000,"  ");
    colordraw[97] = TextDrawCreate(65.000000, 210.000000,"  ");
    colordraw[98] = TextDrawCreate(82.500000, 210.000000,"  ");
    colordraw[99] = TextDrawCreate(100.000000, 210.000000,"  ");
    colordraw[100] = TextDrawCreate(117.500000, 210.000000,"  ");
    colordraw[101] = TextDrawCreate(135.000000, 210.000000,"  ");
    colordraw[102] = TextDrawCreate(152.500000, 210.000000,"  ");
    colordraw[103] = TextDrawCreate(170.000000, 210.000000,"  ");
    colordraw[104] = TextDrawCreate(47.500000, 227.500000,"  ");
    colordraw[105] = TextDrawCreate(65.000000, 227.500000,"  ");
    colordraw[106] = TextDrawCreate(82.500000, 227.500000,"  ");
    colordraw[107] = TextDrawCreate(100.000000, 227.500000,"  ");
    colordraw[108] = TextDrawCreate(117.500000, 227.500000,"  ");
    colordraw[109] = TextDrawCreate(135.000000, 227.500000,"  ");
    colordraw[110] = TextDrawCreate(152.500000, 227.500000,"  ");
    colordraw[111] = TextDrawCreate(170.000000, 227.500000,"  ");
    colordraw[112] = TextDrawCreate(47.500000, 245.000000,"  ");
    colordraw[113] = TextDrawCreate(65.000000, 245.000000,"  ");
    colordraw[114] = TextDrawCreate(82.500000, 245.000000,"  ");
    colordraw[115] = TextDrawCreate(100.000000, 245.000000,"  ");
    colordraw[116] = TextDrawCreate(117.500000, 245.000000,"  ");
    colordraw[117] = TextDrawCreate(135.000000, 245.000000,"  ");
    colordraw[118] = TextDrawCreate(152.500000, 245.000000,"  ");
    colordraw[119] = TextDrawCreate(170.000000, 245.000000,"  ");
    colordraw[120] = TextDrawCreate(47.500000, 262.500000,"  ");
    colordraw[121] = TextDrawCreate(65.000000, 262.500000,"  ");
    colordraw[122] = TextDrawCreate(82.500000, 262.500000,"  ");
    colordraw[123] = TextDrawCreate(100.000000, 262.500000,"  ");
    colordraw[124] = TextDrawCreate(117.500000, 262.500000,"  ");
    colordraw[125] = TextDrawCreate(135.000000, 262.500000,"  ");
    colordraw[126] = TextDrawCreate(152.500000, 262.500000,"  ");
    colordraw[127] = TextDrawCreate(170.000000, 262.500000,"  ");
	colordraw[128] = TextDrawCreate(32.500000,130.000000,"                                                                                                                                                                                                                        ");
	TextDrawBackgroundColor(colordraw[128], 0x000000ff);
	TextDrawSetProportional(colordraw[128],1);
	TextDrawFont(colordraw[128], 0);
	TextDrawAlignment(colordraw[128],0);
	TextDrawColor(colordraw[128], 0x0000ffcc);
	TextDrawLetterSize(colordraw[128], 1.000000, 1.000000);
	TextDrawSetShadow(colordraw[128],1);
	TextDrawTextSize(colordraw[128],172.500000,180.000000);
	TextDrawUseBox(colordraw[128],1);
	TextDrawBoxColor(colordraw[128], 0x00000066);
	for(new i=0; i < TOTAL_COLORS; i++){
		TextDrawAlignment(colordraw[i],2);
		TextDrawBackgroundColor(colordraw[i], 0x000000ff);
		TextDrawBoxColor(colordraw[i], CarColors[i][0]);
		TextDrawColor(colordraw[i], 0xffffffff);
		TextDrawFont(colordraw[i], 1);
		TextDrawLetterSize(colordraw[i], 1.000000, 1.000000);
		TextDrawSetOutline(colordraw[i],1);
		TextDrawSetProportional(colordraw[i],1);
		TextDrawSetShadow(colordraw[i],1);
		TextDrawTextSize(colordraw[i],10.000000,10.000000);
		TextDrawUseBox(colordraw[i],1);}
}
menuDraws[playerid][30] = TextDrawCreate(200.000000,127.500000,"    ");
TextDrawUseBox(menuDraws[playerid][30],1);
TextDrawBoxColor(menuDraws[playerid][30],0x00000099);
TextDrawTextSize(menuDraws[playerid][30],40.000000,0.000000);
TextDrawAlignment(menuDraws[playerid][30],0);
TextDrawBackgroundColor(menuDraws[playerid][30],0x000000ff);
TextDrawFont(menuDraws[playerid][30],3);
TextDrawLetterSize(menuDraws[playerid][30],1.000000,2.95);
TextDrawColor(menuDraws[playerid][30],0xffffffff);
TextDrawSetOutline(menuDraws[playerid][30],0);
TextDrawSetProportional(menuDraws[playerid][30],1);
TextDrawSetShadow(menuDraws[playerid][30],1);
TextDrawShowForPlayer(playerid , menuDraws[playerid][30]);
menuDraws[playerid][31] = TextDrawCreate(360.000000,127.500000,"    ");
TextDrawUseBox(menuDraws[playerid][31],1);
TextDrawBoxColor(menuDraws[playerid][31],0x00000099);
TextDrawTextSize(menuDraws[playerid][31],40.000000,0.000000);
TextDrawAlignment(menuDraws[playerid][31],0);
TextDrawBackgroundColor(menuDraws[playerid][31],0x000000ff);
TextDrawFont(menuDraws[playerid][31],3);
TextDrawLetterSize(menuDraws[playerid][31],1.000000,6.9);
TextDrawColor(menuDraws[playerid][31],0xffffffff);
TextDrawSetOutline(menuDraws[playerid][31],0);
TextDrawSetProportional(menuDraws[playerid][31],1);
TextDrawSetShadow(menuDraws[playerid][31],1);
menuDraws[playerid][32] = TextDrawCreate(45.000000,115.000000,"Autohaus");
TextDrawBackgroundColor(menuDraws[playerid][31], 0x000000ff);
TextDrawColor(menuDraws[playerid][32], 0xffffffff);
TextDrawAlignment(menuDraws[playerid][32],0);
TextDrawFont(menuDraws[playerid][32], 0);
TextDrawSetOutline(menuDraws[playerid][32],1);
TextDrawSetProportional(menuDraws[playerid][32],1);
TextDrawLetterSize(menuDraws[playerid][32], 1.300000, 1.600000);
TextDrawSetShadow(menuDraws[playerid][32],1);
TextDrawUseBox(menuDraws[playerid][32],0);
TextDrawTextSize( menuDraws[playerid][32] , 300, 50);
TextDrawShowForPlayer(playerid , menuDraws[playerid][32]);
for (new k = 0; k < 15; k++){
	menuDraws[playerid][k] = TextDrawCreate(50, (135+(k*12)),"  ");
	TextDrawUseBox( menuDraws[playerid][k] , 0);
	TextDrawAlignment(menuDraws[playerid][k],1);
	TextDrawBackgroundColor(menuDraws[playerid][k], 0x000000ff);
	TextDrawFont(menuDraws[playerid][k], 1);
	TextDrawSetShadow(menuDraws[playerid][k],1);
	TextDrawSetProportional(menuDraws[playerid][k],1);
	TextDrawSetOutline(menuDraws[playerid][k],1);
	TextDrawLetterSize(menuDraws[playerid][k], 0.8, 0.8);
	TextDrawTextSize( menuDraws[playerid][k] , MENU_WIDTH, MENU_HEIGHT);}
for (new l = 15; l < 30; l++){
	menuDraws[playerid][l] = TextDrawCreate(200, (135+((l-15)*12)),"  ");
	TextDrawUseBox(menuDraws[playerid][l] , 0);
	TextDrawAlignment(menuDraws[playerid][l],1);
	TextDrawBackgroundColor(menuDraws[playerid][l], 0x000000ff);
	TextDrawFont(menuDraws[playerid][l], 1);
	TextDrawSetShadow(menuDraws[playerid][l],1);
	TextDrawSetOutline(menuDraws[playerid][l],1);
	TextDrawSetProportional(menuDraws[playerid][l],1);
	TextDrawLetterSize(menuDraws[playerid][l], 0.8, 0.8);
	TextDrawTextSize( menuDraws[playerid][l] , MENU_WIDTH, MENU_HEIGHT);}
for(new j = 0; j < 30; j++){
	TextDrawShowForPlayer(playerid , menuDraws[playerid][j]);}
}
UpdateNextCar( playerid ){
	if(playerCar[playerid][CURRENT] == MAX_PLAYER_CARS -1 ){
	    playerCar[playerid][CURRENT] = 0;

	}
	else{
	    playerCar[playerid][CURRENT]++;
	}

	if(playerCar[playerid][END_CAR] == MAX_PLAYER_CARS -1){
	    playerCar[playerid][END_CAR] = 0;
 	}
 	else{
		playerCar[playerid][END_CAR]++;
	}
}
UpdateCar( playerid ){
	if(carSelect[playerid]==0){
		while ( VehicleInfo[playerCar[playerid]][model]!=0 ) {
			playerCar[playerid]++;}
		if (vehcount<playerCar[playerid]){
			vehcount=playerCar[playerid]+1;}
		VehicleInfo[playerCar[playerid]][x_spawn] = PlayerPos[playerid][0];
		VehicleInfo[playerCar[playerid]][y_spawn] = PlayerPos[playerid][1];
		VehicleInfo[playerCar[playerid]][z_spawn] = PlayerPos[playerid][2];
		VehicleInfo[playerCar[playerid]][za_spawn] = PlayerPos[playerid][3];
		VehicleInfo[playerCar[playerid]][color_1] = itemPlace[playerid][2];
		VehicleInfo[playerCar[playerid]][color_2] = itemPlace[playerid][3];
		VehicleInfo[playerCar[playerid]][mod1] = 0;
		VehicleInfo[playerCar[playerid]][mod2] = 0;
		VehicleInfo[playerCar[playerid]][mod3] = 0;
		VehicleInfo[playerCar[playerid]][mod4] = 0;
		VehicleInfo[playerCar[playerid]][mod5] = 0;
		VehicleInfo[playerCar[playerid]][mod6] = 0;
		VehicleInfo[playerCar[playerid]][mod7] = 0;
		VehicleInfo[playerCar[playerid]][mod8] = 0;
		VehicleInfo[playerCar[playerid]][mod9] = 0;
		VehicleInfo[playerCar[playerid]][mod10] = 0;
		VehicleInfo[playerCar[playerid]][mod11] = 0;
		VehicleInfo[playerCar[playerid]][mod12] = 0;
		VehicleInfo[playerCar[playerid]][mod13] = 0;
		VehicleInfo[playerCar[playerid]][mod14] = 0;
		VehicleInfo[playerCar[playerid]][mod15] = 0;
		VehicleInfo[playerCar[playerid]][mod16] = 0;
		VehicleInfo[playerCar[playerid]][mod17] = 0;
		VehicleInfo[playerCar[playerid]][paintjob] = 0;
		VehicleInfo[playerCar[playerid]][security] = 1;
		VehicleInfo[playerCar[playerid]][priority] = 0;
		VehicleInfo[playerCar[playerid]][spawned] = 1;
	}
	if( destroyCar[playerid][1] == true ){
		DestroyVehicle( VehicleInfo[playerCar[playerid]][idnum]); // Destroy the Car in menu and creates the next one
	}
	VehicleInfo[playerCar[playerid]][model]=carDefines[itemPlace[playerid][1]][ID];
	VehicleInfo[playerCar[playerid]][idnum] = CreateVehicle( VehicleInfo[playerCar[playerid]][model], PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], PlayerPos[playerid][3], itemPlace[playerid][2], itemPlace[playerid][3],-1);
	VehStreamid[VehicleInfo[playerCar[playerid]][idnum]]=playerCar[playerid];
	LockCarForAll( VehicleInfo[playerCar[playerid]][idnum], true );
	TogglePlayerSpectating(playerid, 1);
	PlayerSpectateVehicle(playerid, VehicleInfo[playerCar[playerid]][idnum], SPECTATE_MODE_NORMAL);
	destroyCar[playerid][1] = true;
}

//$ endregion carmod-textdrawupdate
public Menutimer(){
	new Keys[3];
	new string3[256];
	for (new i = 0; i < MAX_PLAYERS; i++){
	if ( carSelect[i]>0 ){
	GetPlayerKeys(i, Keys[0], Keys[1], Keys[2]);
//	format(string3, 256, "%d %d %d", Keys[0],Keys[1],Keys[2]);
//	SendClientMessage(i, COLOR_RED, string3);
	if(carSelect[i]==1){
	    if(Keys[1] == KEY_UP){
	        menuPlace[i] = menuPlace[i]-1;
	        if(menuPlace[i] < 0){ menuPlace[i] = MAX_MENU_ITEMS-1;}
	        UpdatespideyMenu(i);
		 }
		if(Keys[1] == KEY_DOWN  ){
	        menuPlace[i] = menuPlace[i]+1;
			if(menuPlace[i] > MAX_MENU_ITEMS-1){ menuPlace[i] = 0;}
	        UpdatespideyMenu(i);
		 }
		if(Keys[0] == KEY_SPRINT){
		if (menuPlace[i]==0){
				carSelect[i] = 2;
		    	ClearCarMenu(i);
				TextDrawSetString(menuDraws[i][32],"Car Types");
				TextDrawHideForPlayer(i , menuDraws[i][30]);
				TextDrawShowForPlayer(i , menuDraws[i][31]);
				UpdatecartypeMenu(i);}
		else if (menuPlace[i]==1){
		    	carSelect[i] = 3;
		    	ClearCarMenu(i);
				TextDrawHideForPlayer(i , menuDraws[i][30]);
				if ( totalItems[i][menuPlace[i]]-itemStart[i][menuPlace[i]]<=15 ){
					TextDrawLetterSize(menuDraws[i][30],1.000000,(0.7+(0.45*(totalItems[i][menuPlace[i]]-itemStart[i][menuPlace[i]]))));
					TextDrawShowForPlayer(i , menuDraws[i][30]);
					colorpage[i]=2;}
				else{
					TextDrawShowForPlayer(i , menuDraws[i][31]);
					colorpage[i]=3;}
				TextDrawSetString(menuDraws[i][32],menuNames[i][0]);
				UpdateCarmMenu(i);}
		else if (menuPlace[i]==2 || menuPlace[i]==3){
		    	carSelect[i] = 4;
		    	ClearCarMenu(i);
				ShowMenuColor(i);}
		else if (menuPlace[i]==4){
		    carSelect[i] = 0;
		    menuPlace[i]=0;
			playerCar[i]=0;
			DestroyCarMenu(i);
			carsmenucreated=carsmenucreated-1;
			if ( carsmenucreated==0 ){
			DestroyMenuColor();}
			TogglePlayerSpectating(i, 0);
			PutPlayerInVehicle(i, VehicleInfo[playerCar[i]][idnum], 0);
			LockCarForAll( VehicleInfo[playerCar[i]][idnum], false );
			VehicleInfo[playerCar[i]][owner] = PlayerName(i);
			VehicleInfo[playerCar[i]][ownerid] = i;
			destroyCar[i][1] = false;
			destroyCar[i][0] = true;			}
		else if (menuPlace[i]==5){
		    carSelect[i] = 0;
		    menuPlace[i]=0;
			playerCar[i]=0;
			DestroyCarMenu(i);
			carsmenucreated=carsmenucreated-1;
			if ( carsmenucreated==0 ){
			DestroyMenuColor();}
			TogglePlayerSpectating(i, 0);
			DestroyVehicle(VehicleInfo[playerCar[i]][idnum]);
			VehicleInfo[playerCar[i]][model] = 0;
			VehicleInfo[playerCar[i]][x_spawn] = 0;
			VehicleInfo[playerCar[i]][y_spawn] = 0;
			VehicleInfo[playerCar[i]][z_spawn] = 0;
			VehicleInfo[playerCar[i]][za_spawn] = 0;
			VehicleInfo[playerCar[i]][color_1] = 0;
			VehicleInfo[playerCar[i]][color_2] = 0;
			VehicleInfo[playerCar[i]][mod1] = 0;
			VehicleInfo[playerCar[i]][mod2] = 0;
			VehicleInfo[playerCar[i]][mod3] = 0;
			VehicleInfo[playerCar[i]][mod4] = 0;
			VehicleInfo[playerCar[i]][mod5] = 0;
			VehicleInfo[playerCar[i]][mod6] = 0;
			VehicleInfo[playerCar[i]][mod7] = 0;
			VehicleInfo[playerCar[i]][mod8] = 0;
			VehicleInfo[playerCar[i]][mod9] = 0;
			VehicleInfo[playerCar[i]][mod10] = 0;
			VehicleInfo[playerCar[i]][mod11] = 0;
			VehicleInfo[playerCar[i]][mod12] = 0;
			VehicleInfo[playerCar[i]][mod13] = 0;
			VehicleInfo[playerCar[i]][mod14] = 0;
			VehicleInfo[playerCar[i]][mod15] = 0;
			VehicleInfo[playerCar[i]][mod16] = 0;
			VehicleInfo[playerCar[i]][mod17] = 0;
			VehicleInfo[playerCar[i]][paintjob] = 0;
			VehicleInfo[playerCar[i]][security] = 0;
			VehicleInfo[playerCar[i]][priority] = 0;
			VehicleInfo[playerCar[i]][spawned] = 0;
			SetPlayerPos(i, PlayerPos[i][0],  PlayerPos[i][1], PlayerPos[i][2]);
			destroyCar[i][1] = false;
			destroyCar[i][0] = true;
		}
		}
		if(Keys[0] == KEY_SECONDARY_ATTACK){
		    carSelect[i] = 0;
		    menuPlace[i]=0;
			playerCar[i]=0;
			DestroyCarMenu(i);
			carsmenucreated=carsmenucreated-1;
			if ( carsmenucreated==0 ){
			DestroyMenuColor();}
			TogglePlayerSpectating(i, 0);
			DestroyVehicle(VehicleInfo[playerCar[i]][idnum]);
			VehicleInfo[playerCar[i]][model] = 0;
			VehicleInfo[playerCar[i]][x_spawn] = 0;
			VehicleInfo[playerCar[i]][y_spawn] = 0;
			VehicleInfo[playerCar[i]][z_spawn] = 0;
			VehicleInfo[playerCar[i]][za_spawn] = 0;
			VehicleInfo[playerCar[i]][color_1] = 0;
			VehicleInfo[playerCar[i]][color_2] = 0;
			VehicleInfo[playerCar[i]][mod1] = 0;
			VehicleInfo[playerCar[i]][mod2] = 0;
			VehicleInfo[playerCar[i]][mod3] = 0;
			VehicleInfo[playerCar[i]][mod4] = 0;
			VehicleInfo[playerCar[i]][mod5] = 0;
			VehicleInfo[playerCar[i]][mod6] = 0;
			VehicleInfo[playerCar[i]][mod7] = 0;
			VehicleInfo[playerCar[i]][mod8] = 0;
			VehicleInfo[playerCar[i]][mod9] = 0;
			VehicleInfo[playerCar[i]][mod10] = 0;
			VehicleInfo[playerCar[i]][mod11] = 0;
			VehicleInfo[playerCar[i]][mod12] = 0;
			VehicleInfo[playerCar[i]][mod13] = 0;
			VehicleInfo[playerCar[i]][mod14] = 0;
			VehicleInfo[playerCar[i]][mod15] = 0;
			VehicleInfo[playerCar[i]][mod16] = 0;
			VehicleInfo[playerCar[i]][mod17] = 0;
			VehicleInfo[playerCar[i]][paintjob] = 0;
			VehicleInfo[playerCar[i]][security] = 0;
			VehicleInfo[playerCar[i]][priority] = 0;
			VehicleInfo[playerCar[i]][spawned] = 0;
			SetPlayerPos(i, PlayerPos[i][0],  PlayerPos[i][1], PlayerPos[i][2]);
			destroyCar[i][1] = false;
			destroyCar[i][0] = true;}
			}
	else if(carSelect[i]==2){
	    if(Keys[1] == KEY_UP ){
	        itemPlace[i][menuPlace[i]] = (itemPlace[i][menuPlace[i]] == itemStart[i][menuPlace[i]] ) ? totalItems[i][menuPlace[i]]-1:itemPlace[i][menuPlace[i]]-1;
	        itemStart[i][1] = carType[itemPlace[i][0]][typeStart];
			totalItems[i][1] = carType[itemPlace[i][0]][typeEnd];
			itemPlace[i][1] = itemStart[i][1];
			UpdateCar(i);
	        UpdatecartypeMenu(i);}
		if(Keys[1] == KEY_DOWN ){
	        itemPlace[i][menuPlace[i]] = (itemPlace[i][menuPlace[i]] == totalItems[i][menuPlace[i]]-1 ) ? itemStart[i][menuPlace[i]]:itemPlace[i][menuPlace[i]]+1;
			itemStart[i][1] = carType[itemPlace[i][0]][typeStart];
			totalItems[i][1] = carType[itemPlace[i][0]][typeEnd];
			itemPlace[i][1] = itemStart[i][1];
			UpdateCar(i);
	        UpdatecartypeMenu(i);}
		if(Keys[0] == KEY_SPRINT){
		    carSelect[i] = 1;
		    ClearCarMenu(i);
			TextDrawHideForPlayer(i , menuDraws[i][31]);
			TextDrawLetterSize(menuDraws[i][30],1.000000,2.95);
			TextDrawShowForPlayer(i , menuDraws[i][30]);
   			UpdatespideyMenu(i);}}
	else if(carSelect[i]==3){
	    if(Keys[1] == KEY_UP ){
	        itemPlace[i][menuPlace[i]] = (itemPlace[i][menuPlace[i]] == itemStart[i][menuPlace[i]] ) ? totalItems[i][menuPlace[i]]-1:itemPlace[i][menuPlace[i]]-1;
	        UpdateCarmMenu(i);
		 }
		if(Keys[1] == KEY_DOWN ){
		    itemPlace[i][menuPlace[i]] = (itemPlace[i][menuPlace[i]] == totalItems[i][menuPlace[i]]-1 ) ? itemStart[i][menuPlace[i]]:itemPlace[i][menuPlace[i]]+1;
	        UpdateCarmMenu(i);
		}
		if(Keys[0] == KEY_SPRINT ){
		    carSelect[i] = 5;
			UpdateCar(i); }}
	else if(carSelect[i]==4){
	    if(Keys[1] == KEY_UP ){
			itemPlace[i][menuPlace[i]] = itemPlace[i][menuPlace[i]]-8;
			if(itemPlace[i][menuPlace[i]] < 0 && colorpage[i]==0){
            itemPlace[i][menuPlace[i]] = totalItems[i][menuPlace[i]]-9;
			HideMenuColor(i);
            ShowMenuColor2(i);
			colorpage[i]=1;}
           	else if (itemPlace[i][menuPlace[i]] < 64 && colorpage[i]==1){
			HideMenuColor2(i);
			ShowMenuColor(i);
			colorpage[i]=0;}
			ChangeVehicleColor(VehicleInfo[playerCar[i]][idnum], itemPlace[i][2],itemPlace[i][3]);
			UpdateColSel(i);}
		if(Keys[1] == KEY_DOWN ){
			itemPlace[i][menuPlace[i]] = itemPlace[i][menuPlace[i]]+8;
           	if (itemPlace[i][menuPlace[i]] > totalItems[i][menuPlace[i]]-1 && colorpage[i]==1){
            itemPlace[i][menuPlace[i]] = itemPlace[i][menuPlace[i]]-totalItems[i][menuPlace[i]]-1;
			HideMenuColor2(i);
			ShowMenuColor(i);
			colorpage[i]=0;}
			else if(itemPlace[i][menuPlace[i]] > 63 && colorpage[i]==0){
			HideMenuColor(i);
            ShowMenuColor2(i);
			colorpage[i]=1;}
			ChangeVehicleColor(VehicleInfo[playerCar[i]][idnum], itemPlace[i][2],itemPlace[i][3]);
			UpdateColSel(i);}
	    if(Keys[2] == KEY_LEFT ){
	        itemPlace[i][menuPlace[i]] = itemPlace[i][menuPlace[i]]-1;
			if(itemPlace[i][menuPlace[i]] < 0 && colorpage[i]==0){
            itemPlace[i][menuPlace[i]] = totalItems[i][menuPlace[i]]-1;
			HideMenuColor(i);
            ShowMenuColor2(i);
			colorpage[i]=1;
			}
           	else if (itemPlace[i][menuPlace[i]] < 64 && colorpage[i]==1){
			HideMenuColor2(i);
			ShowMenuColor(i);
			colorpage[i]=0;
			}
            ChangeVehicleColor(VehicleInfo[playerCar[i]][idnum], itemPlace[i][2],itemPlace[i][3]);
            UpdateColSel(i);
		 }
		if(Keys[2] == KEY_RIGHT ){
	        itemPlace[i][menuPlace[i]] = itemPlace[i][menuPlace[i]]+1;
           	if (itemPlace[i][menuPlace[i]] > totalItems[i][menuPlace[i]]-1 && colorpage[i]==1){
            itemPlace[i][menuPlace[i]] = 0;
			HideMenuColor2(i);
			ShowMenuColor(i);
			colorpage[i]=0;}
			else if(itemPlace[i][menuPlace[i]] > 63 && colorpage[i]==0){
			HideMenuColor(i);
            ShowMenuColor2(i);
			colorpage[i]=1;}
            ChangeVehicleColor(VehicleInfo[playerCar[i]][idnum], itemPlace[i][2],itemPlace[i][3]);
            UpdateColSel(i);
		 }
		if(Keys[0] == KEY_SPRINT){
		    carSelect[i] = 1;
			VehicleInfo[playerCar[i]][color_1] = itemPlace[i][2];
			VehicleInfo[playerCar[i]][color_2] = itemPlace[i][3];
		    if ( colorpage[i]==0 ){
			HideMenuColor(i);}
			else if (colorpage[i]==1){
			HideMenuColor2(i);}
			colorpage[i]=0;
   			UpdatespideyMenu(i);}
		if (Keys[0] == KEY_SECONDARY_ATTACK){
			itemPlace[i][2]=VehicleInfo[playerCar[i]][color_1];
			itemPlace[i][3]=VehicleInfo[playerCar[i]][color_2];
			ChangeVehicleColor(VehicleInfo[playerCar[i]][idnum], itemPlace[i][2],itemPlace[i][3]);
		}}
	else if(carSelect[i]==5){
		if(Keys[0] == KEY_SPRINT ){
			carSelect[i] = 1;
			ClearCarMenu(i);
//			itemPlace[i][menuPlace[i]]=0;
			if ( colorpage[i]==2 ){
				TextDrawHideForPlayer(i , menuDraws[i][30]);}
			if ( colorpage[i]==3 ){
				TextDrawHideForPlayer(i , menuDraws[i][31]);}
			colorpage[i]=0;
			TextDrawLetterSize(menuDraws[i][30],1.000000,2.95);
			TextDrawShowForPlayer(i , menuDraws[i][30]);
			UpdatespideyMenu(i);}}
	}
	if(gasselect[i]==1){
		new string2[255];
		new string[255];
		new tmp2[255];
		new vid = GetPlayerVehicleID(i);
		new wm = GetVehicleModel(vid);
		GetPlayerKeys(i, Keys[0], Keys[1], Keys[2]);
		format(string3, 256, "%d %d %d", Keys[0],Keys[1],Keys[2]);
		SendClientMessage(i, COLOR_RED, string3);
		for (new h=0;h<MAX_CARS;h++){
		if (carDefines[h][ID]==wm){
			if(Keys[1] == KEY_UP){
		        menuPlace2[i] = menuPlace2[i]-1;
				if(menuPlace2[i] < 0){ menuPlace2[i] = MAX_MENUG_ITEMS-1;}
                DestroyMenuGas(i);
				UpdategasMenu(i);}
			if(Keys[1] == KEY_DOWN ){
		        menuPlace2[i] = menuPlace2[i]+1;
				if(menuPlace2[i] > MAX_MENUG_ITEMS-1){ menuPlace2[i] = 0;}
                DestroyMenuGas(i);
				UpdategasMenu(i);
		 	}
			if(Keys[2] == KEY_RIGHT ){
			if(menuPlace2[i]==1){
				liters[i] = liters[i]+1;
				if(liters[i] + tank[vid]/1000000 > carDefines[h][Tank]/10){
				liters[i]=0;
				format(tmp2, sizeof(tmp2), "Your car can only take %d Liters.", carDefines[h][Tank]/10);
				SendClientMessage(i, COLOR_YELLOW, tmp2);}
                DestroyMenuGas(i);
				UpdategasMenu(i);
	 		}}
			if(Keys[2] == KEY_LEFT ){
			if(menuPlace2[i]==1){
				liters[i] = liters[i]-1;
				if(liters[i] < 0){
				liters[i] = ((carDefines[h][Tank]-tank[vid]/100000)/10 + 1);}
                DestroyMenuGas(i);
				UpdategasMenu(i);}}
            if(Keys[0] == KEY_SPRINT ){
				if (menuPlace2[i]==0){
    				if (tank[vid]/100000 ==  carDefines[h][Tank])					{
					SendClientMessage(i, COLOR_RED, "This car is already refuelled.");
					TogglePlayerControllable(i,true);
					DestroyMenuGas(i);
					menuPlace2[i]=0;
					justbought[i]=1;
					gasselect[i]=0;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					return 1;
					}
					new cant = (carDefines[h][Tank]-tank[vid]/100000)/10;
					if (PRECIOLITRO*cant>GetPlayerMoney(i))
					{
					SendClientMessage(i, COLOR_RED, "You don't have enough money..");
					return 1;}
      		 		tank[vid]=tank[vid]+cant*1000000;
    				GivePlayerMoney(i,PRECIOLITRO*cant*-1);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters. The tank is full.", cant);
					SendClientMessage(i, COLOR_YELLOW, string2);
					format(string, sizeof(string), "Fuel:%d L", tank[vid]/1000000);
					TextDrawSetString(SpeedoString[i][0],string);
					menuPlace2[i]=0;
					justbought[i]=1;
					TogglePlayerControllable(i,true);
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;}
				if (menuPlace2[i]==1){
					if (PRECIOLITRO*liters[i]>GetPlayerMoney(i))
	    			{
       					SendClientMessage(i, COLOR_RED, "You don't have enough money.");
        				//TogglePlayerControllable(i,true);
						return 1;
		    		}
			        tank[vid]=tank[vid]+(liters[i]*1000000);
			        GivePlayerMoney(i,PRECIOLITRO*liters[i]*-1);
					format(string, sizeof(string), "You bought %d liters of fuel, the tank is full", liters[i]);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters of fuel, the tank is full", liters[i]);
					SendClientMessage(i, COLOR_YELLOW, string2);
					liters[i] = 0;
					format(string, sizeof(string), "Fuel:%d L", tank[vid]/1000000);
//					TankString[i]=string;
//					format(tmp, sizeof(tmp),"%s %s %s %s",TankString[i],SpeedString[i],KMString[i], OilString[i]);
					TextDrawSetString(SpeedoString[i][0],string);
       		 		TogglePlayerControllable(i,true);
					menuPlace2[i]=0;
					justbought[i]=1;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;	}
				if (menuPlace2[i]==2){
					TogglePlayerControllable(i,true);
					menuPlace2[i]=0;
					justbought[i]=1;
					SetTimerEx("justbdown", 15000, 0, "y",i);
					DestroyMenuGas(i);
					gasselect[i]=0;}
			}
}}}
	}
	return 1;
}
