/**************************************************************** pBoom v1.0 ***
*
* Scriptname:
* -» pBoom
*
* Author:
* -» Pablo_Borsellino
*
* Creation Date:
* -» 17th October 2011
*
* Release Date:
* -» 18th October 2011
*
* Version:
* -» 1.0
*
* Need to use:
* -» Sa:Mp 0.3d RC5-3 or higher
*
* Language:
* -» English
*
* Description:
* -» Some new Function's, for a exploding Text.
*
* Functions:
* -» SetPlayerBoom(playerid,Text[]);
* -» StopPlayerBoom(playerid);
* -» IfPlayerBoom(playerid)
*
* Public's:
* -» n/a
*
* Credit's:
* -» n/a
*											Copyright © 2011 by Pablo_Borsellino
*******************************************************************************/
//____________________________________________________________________Variable's
new Text:_pBoom_TD_Sprite[MAX_PLAYERS],
	Text:_pBoom_TD_Text[MAX_PLAYERS],
	_pBoom_Player_Ticks[MAX_PLAYERS],
	bool:_pBoom_Player_Booms[MAX_PLAYERS];

//____________________________________________________________________Function's
stock SetPlayerBoom(playerid,Text[])
{
	if(_pBoom_Player_Booms[playerid]==false){
	   	_pBoom_TD_Sprite[playerid]=TextDrawCreate(260,40,"LD_NONE:explm01");
	    TextDrawFont(_pBoom_TD_Sprite[playerid],4);
	    TextDrawColor(_pBoom_TD_Sprite[playerid],0xFFFFFFFF);
	    TextDrawTextSize(_pBoom_TD_Sprite[playerid],140,140);
	    TextDrawShowForPlayer(playerid,_pBoom_TD_Sprite[playerid]);
		_pBoom_TD_Text[playerid]=TextDrawCreate(321,95,Text);
		TextDrawAlignment(_pBoom_TD_Text[playerid],2);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE01FF);
		TextDrawFont(_pBoom_TD_Text[playerid],0);
		TextDrawLetterSize(_pBoom_TD_Text[playerid],1.11,3.3);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000000);
		TextDrawSetOutline(_pBoom_TD_Text[playerid],0);
		TextDrawSetProportional(_pBoom_TD_Text[playerid],1);
		TextDrawSetShadow(_pBoom_TD_Text[playerid],1);
		_pBoom_Player_Ticks[playerid]=10;
		SetTimerEx("_pBoom_Player_Timer",75,false,"d",playerid);
	    _pBoom_Player_Booms[playerid]=true;
	}
	return true;
}

stock IfPlayerBoom(playerid)
{
	if(_pBoom_Player_Booms[playerid]==false)return false;
	return true;
}

stock StopPlayerBoom(playerid)
{
	if(_pBoom_Player_Booms[playerid]==true){
		TextDrawDestroy(_pBoom_TD_Text[playerid]);
		TextDrawDestroy(_pBoom_TD_Sprite[playerid]);
	    _pBoom_Player_Booms[playerid]=false;
		_pBoom_Player_Ticks[playerid]=-7;
	}
	return true;
}


//______________________________________________________________________Public's
forward _pBoom_Player_Timer(playerid);
public _pBoom_Player_Timer(playerid){
	if(_pBoom_Player_Ticks[playerid]==10){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000011);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm02");
	}else if(_pBoom_Player_Ticks[playerid]==9){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000033);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm03");
	}else if(_pBoom_Player_Ticks[playerid]==8){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000044);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm04");
	}else if(_pBoom_Player_Ticks[playerid]==7){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000066);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm05");
	}else if(_pBoom_Player_Ticks[playerid]==6){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000077);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm06");
	}else if(_pBoom_Player_Ticks[playerid]==5){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000099);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm07");
	}else if(_pBoom_Player_Ticks[playerid]==4){
		TextDrawColor(_pBoom_TD_Text[playerid],0x000000FF);
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm08");
	}else if(_pBoom_Player_Ticks[playerid]==3){
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm09");
	}else if(_pBoom_Player_Ticks[playerid]==2){
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm10");
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000099);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0199);
	}else if(_pBoom_Player_Ticks[playerid]==1){
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm11");
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000088);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0188);
	}else if(_pBoom_Player_Ticks[playerid]==0){
		TextDrawSetString(_pBoom_TD_Sprite[playerid],"LD_NONE:explm12");
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000077);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0177);
	}else if(_pBoom_Player_Ticks[playerid]==-1){
		TextDrawColor(_pBoom_TD_Sprite[playerid],0x00000088);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000066);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0166);
	}else if(_pBoom_Player_Ticks[playerid]==-2){
		TextDrawColor(_pBoom_TD_Sprite[playerid],0x00000066);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000055);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0155);
	}else if(_pBoom_Player_Ticks[playerid]==-3){
		TextDrawColor(_pBoom_TD_Sprite[playerid],0x00000044);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000044);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0144);
	}else if(_pBoom_Player_Ticks[playerid]==-4){
		TextDrawColor(_pBoom_TD_Sprite[playerid],0x00000022);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000033);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0133);
	}else if(_pBoom_Player_Ticks[playerid]==-5){
		TextDrawDestroy(_pBoom_TD_Sprite[playerid]);
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000022);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0122);
	}else if(_pBoom_Player_Ticks[playerid]==-6){
		TextDrawColor(_pBoom_TD_Text[playerid],0x00000011);
		TextDrawBackgroundColor(_pBoom_TD_Text[playerid],0xF1FE0111);
	}else if(_pBoom_Player_Ticks[playerid]==-7){
		TextDrawDestroy(_pBoom_TD_Text[playerid]);
	    _pBoom_Player_Booms[playerid]=false;
		return true;
	}
    TextDrawShowForPlayer(playerid,_pBoom_TD_Sprite[playerid]);
    TextDrawShowForPlayer(playerid,_pBoom_TD_Text[playerid]);
	_pBoom_Player_Ticks[playerid]--;
	SetTimerEx("_pBoom_Player_Timer",75,false,"d",playerid);
	return true;
}

