#include <a_samp>

#define MAX_ITEMS 10
#define MAX_ITEM_NAME 19 //10x19 = 190+57=247 -- Just Short Of MAX_TEXTDRAW_TEXT, Leaves Room For Colors
#define MAX_TEXTDRAW_TEXT 256 //It's true, this even counts '~n~' as 3 characters

//Using Variables With Acronomous Names To Prevent Cross Contamination
new Text:PIPTD[MAX_PLAYERS][2];//PlayerInventory Player TextDraws -- Will Make Up The Window
new PIPUI[MAX_PLAYERS];//PlayerInventory Player Using Inventory -- Boolean For The Window
new PIPIN[MAX_PLAYERS][MAX_ITEMS][MAX_ITEM_NAME];//PlayerInventory Player's Item's Name
new PIPIA[MAX_PLAYERS][MAX_ITEMS];//PlayerInventory Player Item's Amount
new PIPWS[MAX_PLAYERS];//PlayerInventory Player Window Slot -- The Slot That The Player Has Selected
new PIPLC[MAX_PLAYERS][13];//PlayerInventory Player Letter Color -- Goes By Decimal Code, EX: 0=White
new PIPWC[MAX_PLAYERS];//PlayerInventory Player Window Color
new PIPLF[MAX_PLAYERS];//PlayerInventory Player Letter Font
new PIPOK[MAX_PLAYERS];//PlayerInventory Player Old Keys
//Clear Player TextDraws// -- Not Going To Make A Function Used Only In The Include
//for(new tmp; tmp<5; tmp++)if(_:PTD[playerid][tmp])TextDrawDestroy(PTD[playerid][tmp]);

forward PlayerInventoryUseItem(playerid,ItemName[]);//Similar To OnPlayerCommandText, Except It's Called When A Player Choose An Item In The Window

PlayerInventoryToggleWindow(playerid,toggle) //0 = off, 1 = on
{
	if(toggle)
	{
		if(PIPUI[playerid])return;
		PIPUI[playerid]=1;
		PIPWS[playerid]=0;
		new tmpstring[256];
		for(new tmploop; tmploop<MAX_ITEMS; tmploop++)
		{
			if(!strlen(PIPIN[playerid][tmploop]) || PIPIA[playerid][tmploop]==0)
			{
				format(PIPIN[playerid][tmploop],MAX_ITEM_NAME,"Empty");
				PIPIA[playerid][tmploop]=0;
			}
		}
		format(tmpstring,sizeof(tmpstring),"~r~%s~n~%s%s~n~%s~n~%s~n~%s~n~%s~n~%s~n~%s~n~%s~n~%s",PIPIN[playerid][0],PIPLC[playerid],PIPIN[playerid][1],PIPIN[playerid][2],PIPIN[playerid][3],PIPIN[playerid][4],PIPIN[playerid][5],PIPIN[playerid][6],PIPIN[playerid][7],PIPIN[playerid][8],PIPIN[playerid][9]);
		PIPTD[playerid][0]=TextDrawCreate(150.0,140.0,tmpstring);
		TextDrawTextSize(PIPTD[playerid][0],490.0,0.0);
		TextDrawFont(PIPTD[playerid][0],PIPLF[playerid]);
		TextDrawUseBox(PIPTD[playerid][0],1);
		TextDrawBoxColor(PIPTD[playerid][0],PIPWC[playerid]);
		TextDrawShowForPlayer(playerid,PIPTD[playerid][0]);
		
		format(tmpstring,sizeof(tmpstring),"~r~%d~n~%s%d~n~%d~n~%d~n~%d~n~%d~n~%d~n~%d~n~%d~n~%d~n~",PIPIA[playerid][0],PIPLC[playerid],PIPIA[playerid][1],PIPIA[playerid][2],PIPIA[playerid][3],PIPIA[playerid][4],PIPIA[playerid][5],PIPIA[playerid][6],PIPIA[playerid][7],PIPIA[playerid][8],PIPIA[playerid][9]);
		PIPTD[playerid][1]=TextDrawCreate(480.0,140.0,tmpstring);
		TextDrawFont(PIPTD[playerid][1],PIPLF[playerid]);
		TextDrawAlignment(PIPTD[playerid][1],3);
		TextDrawShowForPlayer(playerid,PIPTD[playerid][1]);
	}
	else
	{
	    if(!PIPUI[playerid])return;
	    PIPUI[playerid]=0;
	    for(new tmp; tmp<2; tmp++)if(_:PIPTD[playerid][tmp])TextDrawDestroy(PIPTD[playerid][tmp]);
	}
}
PlayerInventoryAddItem(playerid,ItemName[],amount=1)//Returns 0 If Player's Inventory Is Full, -1 If Invalid Item Name Or Invalid Amount
{
	if(!strlen(ItemName))return -1;
	if(!strcmp(ItemName,"Empty",false))return -1;
	if(amount<=0)return -1;
	new firstempty=-1;
	new textstring[256];
	new colors[10][13];
	for(new tmploop; tmploop<MAX_ITEMS; tmploop++)
	{
		if(!strlen(PIPIN[playerid][tmploop]) || PIPIA[playerid][tmploop]==0)
		{
			format(PIPIN[playerid][tmploop],MAX_ITEM_NAME,"Empty");
			PIPIA[playerid][tmploop]=0;
			if(firstempty==-1)firstempty=tmploop;
			format(colors[0],13,"%s",PIPLC[playerid]);
			format(colors[PIPWS[playerid]],13,"~r~");
			if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
			format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
			if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
			format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
			if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		}
		if(!strcmp(PIPIN[playerid][tmploop],ItemName,false))//If Player Owns Item Of Same EXACT Name
		{
		    PIPIA[playerid][tmploop]+=amount;
			format(colors[0],13,"%s",PIPLC[playerid]);
			format(colors[PIPWS[playerid]],13,"~r~");
			if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
			format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
			if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
			format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
			if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		    return 1; //Found Item Of Matching Name
		}
		if(firstempty==-1)if(!strcmp(PIPIN[playerid][tmploop],"Empty",false))
		{
			firstempty=tmploop;
		}
	}
	if(firstempty>=0)
	{
	    format(PIPIN[playerid][firstempty],sizeof(PIPIN[][]),"%s",ItemName);
	    PIPIA[playerid][firstempty]=amount;
		format(colors[0],13,"%s",PIPLC[playerid]);
		format(colors[PIPWS[playerid]],13,"~r~");
		if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
		format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
		if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
		format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
		if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
	    return 1; //Found No Matching Items, But Found Empty Slot
	}
	return 0; //Inventory Full
}
PlayerInventoryRemoveItem(playerid,ItemName[],amount=1)//Returns 0 If Player Doesn't Own Item, -1 If Invalid Item Name Or Invalid Amount
{
	if(!strlen(ItemName))return -1;
	if(!strcmp(ItemName,"Empty",false))return -1;
	if(amount<=0)return -1;
	new itemfound;
	for(new tmploop; tmploop<MAX_ITEMS; tmploop++)
	{
		if(!strcmp(PIPIN[playerid][tmploop],ItemName,false))
		{
		    PIPIA[playerid][tmploop]-=amount;
		    itemfound=1;
		}
		if(!strlen(PIPIN[playerid][tmploop]) || PIPIA[playerid][tmploop]==0)
		{
			format(PIPIN[playerid][tmploop],MAX_ITEM_NAME,"Empty");
			PIPIA[playerid][tmploop]=0;
			new textstring[256];
			new colors[10][13];
			format(colors[0],13,"%s",PIPLC[playerid]);
			format(colors[PIPWS[playerid]],13,"~r~");
			if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
			format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
			if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
			format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
			if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		}
	}
	if(itemfound)return 1;
	return 0;
}
PlayerInventorySetLetterColor(playerid,code)//Returns 0 If Incorrect Code
{
	switch(code)
	{
	    case 0: PIPLC[playerid]="~w~";
	    case 1: PIPLC[playerid]="~g~";
	    case 2: PIPLC[playerid]="~b~";
	    case 3: PIPLC[playerid]="~y~";
	    case 4: PIPLC[playerid]="~p~";
	    case 5: PIPLC[playerid]="~l~";
	    case 6: PIPLC[playerid]="~h~~g~";
	    case 7: PIPLC[playerid]="~h~~b~";
	    case 8: PIPLC[playerid]="~h~~y~";
	    case 9: PIPLC[playerid]="~h~~p~";
	    case 10: PIPLC[playerid]="~h~~h~~g~";
	    case 11: PIPLC[playerid]="~h~~h~~b~";
	    case 12: PIPLC[playerid]="~h~~h~~p~";
	    default: return 0;
	}
	new textstring[300];
	new colors[10][20];
	format(colors[0],13,"%s",PIPLC[playerid]);
	format(colors[PIPWS[playerid]],13,"~r~");
	if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
	format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
	if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
	format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
	if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
	return 1;
}
PlayerInventorySetWindowColor(playerid,colorhex)//EX: 0xAAAAAAFF Is Gray
{
	PIPWC[playerid]=colorhex;
	TextDrawBoxColor(PIPTD[playerid][0],colorhex);
	TextDrawShowForPlayer(playerid,PIPTD[playerid][0]);
}
PlayerInventorySetFont(playerid,font)//EX: 0 Is All Cursivey
{
	PIPLF[playerid]=font;
	TextDrawFont(PIPTD[playerid][0],font);
	TextDrawShowForPlayer(playerid,PIPTD[playerid][0]);
	TextDrawFont(PIPTD[playerid][1],font);
	TextDrawShowForPlayer(playerid,PIPTD[playerid][1]);	
}
PlayerInventoryPlayerHasItem(playerid,ItemName[])//Returns Amount Of The Item That The Player Has, -1 If Invalid Item Name EX:if(PlayerInventoryPlayerHasItem(playerid,"Map Pieces")==5)return SendClientMessage(playerid,0xFF0000FF,"You've found all the map pieces!");
{
	if(!strlen(ItemName))return -1;
	if(!strcmp(ItemName,"Empty",false))return -1;
	new itemfound;
    for(new tmploop; tmploop<MAX_ITEMS; tmploop++)
	{
		if(!strcmp(PIPIN[playerid][tmploop],ItemName,false))
		{
		    itemfound=tmploop;
		}
		if(!strlen(PIPIN[playerid][tmploop]) || PIPIA[playerid][tmploop]==0)
		{
			format(PIPIN[playerid][tmploop],MAX_ITEM_NAME,"Empty");
			PIPIA[playerid][tmploop]=0;
			new textstring[256];
			new colors[10][13];
			format(colors[0],13,"%s",PIPLC[playerid]);
			format(colors[PIPWS[playerid]],13,"~r~");
			if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
			format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
			if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
			format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
			if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		}
	}
	return PIPIA[playerid][itemfound];
}
PlayerInventoryPlayerItemData(playerid,slot,ItemName[],&Amount,len=sizeof(ItemName))//Similar To GetPlayerWeaponData
{
	if(slot>MAX_ITEMS)return 0;
	format(ItemName,len,"%s",PIPIN[playerid][slot]);
	Amount=PIPIA[playerid][slot];
	return 1;
}


PlayerInventoryOnPlayerUpdate(playerid)
{
	if(PIPUI[playerid])
	{
	    new keys,null;
	    GetPlayerKeys(playerid,null,keys,null);
	    if(PIPOK[playerid]!=keys)
	    {
	        new textstring[256];
	        new colors[MAX_ITEMS][13];
		    if(keys==KEY_UP)
		    {
		        PIPWS[playerid]--;
		        if(PIPWS[playerid]<0)PIPWS[playerid]=MAX_ITEMS-1;
		        PlayerPlaySound(playerid,1138,0,0,0);
				format(colors[0],13,"%s",PIPLC[playerid]);
				format(colors[PIPWS[playerid]],13,"~r~");
				if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
				format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
				if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
				format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
				if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		    }else if(keys==KEY_DOWN)
		    {
		        PIPWS[playerid]++;
		        if(PIPWS[playerid]>=MAX_ITEMS)PIPWS[playerid]=0;
		        PlayerPlaySound(playerid,1138,0,0,0);
				format(colors[0],13,"%s",PIPLC[playerid]);
				format(colors[PIPWS[playerid]],13,"~r~");
				if(PIPWS[playerid]<MAX_ITEMS-1)if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
				format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
				if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
				format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
				if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
		    }
	    }
	    PIPOK[playerid]=keys;
	    ApplyAnimation(playerid,"WUZI","Wuzi_stand_loop",4.1,1,1,1,1,1);
	}
}
PlayerInventoryOnPlayerKeyState(playerid,newkeys)
{
	if(PIPUI[playerid])
	{
	    if(newkeys==KEY_SECONDARY_ATTACK)
	    {
			PlayerInventoryToggleWindow(playerid,0);
			PlayerPlaySound(playerid,1138,0,0,0);
			ClearAnimations(playerid);
	    }
	    if(newkeys==KEY_SPRINT)
	    {
	        if(!strcmp(PIPIN[playerid][PIPWS[playerid]],"Empty",false))return;
	        PlayerInventoryUseItem(playerid,PIPIN[playerid][PIPWS[playerid]]);
	        PlayerPlaySound(playerid,1138,0,0,0);
			new textstring[256];
			new colors[10][13];
			format(colors[0],13,"%s",PIPLC[playerid]);
			format(colors[PIPWS[playerid]],13,"~r~");
			if(PIPWS[playerid]<MAX_ITEMS-1)if(PIPWS[playerid]<MAX_ITEMS-1)format(colors[PIPWS[playerid]+1],13,"%s",PIPLC[playerid]);
			format(textstring,sizeof(textstring),"%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s~n~%s%s",colors[0],PIPIN[playerid][0],colors[1],PIPIN[playerid][1],colors[2],PIPIN[playerid][2],colors[3],PIPIN[playerid][3],colors[4],PIPIN[playerid][4],colors[5],PIPIN[playerid][5],colors[6],PIPIN[playerid][6],colors[7],PIPIN[playerid][7],colors[8],PIPIN[playerid][8],colors[9],PIPIN[playerid][9]);
			if(_:PIPTD[playerid][0])TextDrawSetString(PIPTD[playerid][0],textstring);
			format(textstring,sizeof(textstring),"%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~%s%d~n~",colors[0],PIPIA[playerid][0],colors[1],PIPIA[playerid][1],colors[2],PIPIA[playerid][2],colors[3],PIPIA[playerid][3],colors[4],PIPIA[playerid][4],colors[5],PIPIA[playerid][5],colors[6],PIPIA[playerid][6],colors[7],PIPIA[playerid][7],colors[8],PIPIA[playerid][8],colors[9],PIPIA[playerid][9]);
			if(_:PIPTD[playerid][1])TextDrawSetString(PIPTD[playerid][1],textstring);
	    }
	}
}

PlayerInventoryOnGameModeInit()
{
	new Text:null = TextDrawCreate(0,0,"  ");
	TextDrawSetString(null,"  ");//Removes A Bug
	for(new tmp; tmp<MAX_PLAYERS;tmp++)
	{
		PlayerInventorySetLetterColor(tmp,0);
		PlayerInventorySetFont(tmp,1);
		PlayerInventorySetWindowColor(tmp,400000);
	}
}
#pragma unused PlayerInventoryPlayerHasItem
#pragma unused PlayerInventoryPlayerItemData
#pragma unused PlayerInventoryAddItem
#pragma unused PlayerInventoryRemoveItem