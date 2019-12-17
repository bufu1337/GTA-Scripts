/*********************************************************** pSpaceship v1.0 ***
*
* Scriptname:
* -» pSpaceship
*
* Author:
* -» Pablo_Borsellino

* Changelog:
* • v1.0 (18.10.2011)
* -» Initial Release
*
* Need to use:
* -» Sa:Mp 0.3d RC5-3 or higher
*
* Language:
* -» English
*
* Description:
* -» Watch the Video: http://www.youtube.com/watch?v=rwGb3W9rqoQ
*
* Functions:
* -» n/a
*
* Public's:
* -» n/a
*
* Credit's:
* -» n/a
*											Copyright © 2011 by Pablo_Borsellino
*******************************************************************************/

//_____________________________________________________________________Include's
#include <a_samp>

//__________________________________________________________________Definition's
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define forEx(%0,%1) for(new %1=0;%1<%0;%1++)

//_____________________________________________________________________Setting's
#define SPACESHIP_SPEED 4 //speed of the spaceship
#define SPACESHIP_CONSUMPTION 0.1 //fuel consumption of spaceship
#define BONUS_SPEED 6 //speed of the bonus
#define BONUS_DISTANCE 25 //distance between the bonus in seconds
#define ATTACKER_SPEED 10 //speed of the attacker
#define ATTACKER_DISTANCE 1 //distance between the attacker in seconds (1@Time)

//____________________________________________________________________Variable's
new Text:TD_Spaceship_Background,
	Text:TD_Spaceship_CornerTopLeft,
	Text:TD_Spaceship_CornerTopRight,
	Text:TD_Spaceship_CornerBottomLeft,
	Text:TD_Spaceship_CornerBottomRight,

	Text:TD_Spaceship[MAX_PLAYERS],
	Text:TD_Spaceship_Fuel[MAX_PLAYERS],
	Text:TD_Spaceship_Health[MAX_PLAYERS],
	Text:TD_Spaceship_Bonus[MAX_PLAYERS],
	Text:TD_Spaceship_Attacker[MAX_PLAYERS],
	Text:TD_Spaceship_Explosion[MAX_PLAYERS],

	_Spaceship_Position[MAX_PLAYERS]=300,
	_Spaceship_Health[MAX_PLAYERS]=100,
	_Spaceship_Explosion[MAX_PLAYERS]=3,
	_Spaceship_BonusX[MAX_PLAYERS],
	_Spaceship_BonusY[MAX_PLAYERS]=-10,
	_Spaceship_AttackerX[MAX_PLAYERS],
	_Spaceship_AttackerY[MAX_PLAYERS]=-10,

	Float:_Spaceship_Fuel[MAX_PLAYERS]=100.0,

	bool:_Spaceship_PlayerPlays[MAX_PLAYERS]=false,
	bool:_Spaceship_Bonus_ONW[MAX_PLAYERS]=false, //On the way
	bool:_Spaceship_Attacker_ONW[MAX_PLAYERS]=false, //On the way
	bool:_Spaceship_PlayerExplode[MAX_PLAYERS]=false,
	bool:_Spaceship_PlayerLoosed[MAX_PLAYERS]=false;

//______________________________________________________________________Public's
public OnFilterScriptInit()
{
   	TD_Spaceship_Background=TextDrawCreate(0,0,"LD_DUAL:backgnd");
	TextDrawFont(TD_Spaceship_Background,4);
	TextDrawColor(TD_Spaceship_Background,0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Background,640,480);

	TD_Spaceship_CornerTopLeft=TextDrawCreate(0,0,"LD_DUAL:tvcorn");
	TextDrawFont(TD_Spaceship_CornerTopLeft,4);
	TextDrawColor(TD_Spaceship_CornerTopLeft,0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_CornerTopLeft,320,240);

	TD_Spaceship_CornerTopRight=TextDrawCreate(640,0,"LD_DUAL:tvcorn");
	TextDrawFont(TD_Spaceship_CornerTopRight,4);
	TextDrawColor(TD_Spaceship_CornerTopRight,0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_CornerTopRight,-320,240);

	TD_Spaceship_CornerBottomLeft=TextDrawCreate(0,450,"LD_DUAL:tvcorn");
	TextDrawFont(TD_Spaceship_CornerBottomLeft,4);
	TextDrawColor(TD_Spaceship_CornerBottomLeft,0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_CornerBottomLeft,320,-240);

	TD_Spaceship_CornerBottomRight=TextDrawCreate(640,450,"LD_DUAL:tvcorn");
	TextDrawFont(TD_Spaceship_CornerBottomRight,4);
	TextDrawColor(TD_Spaceship_CornerBottomRight,0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_CornerBottomRight,-320,-250);
	return true;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(TD_Spaceship_Background);
	TextDrawDestroy(TD_Spaceship_CornerTopLeft);
	TextDrawDestroy(TD_Spaceship_CornerTopRight);
	TextDrawDestroy(TD_Spaceship_CornerBottomLeft);
	TextDrawDestroy(TD_Spaceship_CornerBottomRight);
	forEx(MAX_PLAYERS,playerid)
		HideSpaceshipGame(playerid);
	return true;
}

public OnPlayerUpdate(playerid)
{
	if(_Spaceship_PlayerPlays[playerid]==true&&_Spaceship_PlayerLoosed[playerid]==false)
	{
		if(_Spaceship_Fuel[playerid]<=0)return PlayerLooseSpaceship(playerid);
		new Keys,UNUSED_KEYS,LeftOrRight;
		GetPlayerKeys(playerid,Keys,UNUSED_KEYS,LeftOrRight);
		if(LeftOrRight>0)//Right
		{
		    if(_Spaceship_Position[playerid]>540-SPACESHIP_SPEED)return true;
			_Spaceship_Fuel[playerid]-=SPACESHIP_CONSUMPTION;
			_Spaceship_Position[playerid]=_Spaceship_Position[playerid]+SPACESHIP_SPEED;
		}
		else if(LeftOrRight<0)//Left
		{
		    if(_Spaceship_Position[playerid]<60+SPACESHIP_SPEED)return true;
			_Spaceship_Fuel[playerid]-=SPACESHIP_CONSUMPTION;
			_Spaceship_Position[playerid]=_Spaceship_Position[playerid]-SPACESHIP_SPEED;
		}
		TextDrawDestroy(TD_Spaceship[playerid]);
		TD_Spaceship[playerid]=TextDrawCreate(_Spaceship_Position[playerid],360,"LD_DUAL:rockshp");
		TextDrawFont(TD_Spaceship[playerid],4);
		TextDrawColor(TD_Spaceship[playerid],0xFFFFFFFF);
		TextDrawTextSize(TD_Spaceship[playerid],40,40);
		TextDrawShowForPlayer(playerid,TD_Spaceship[playerid]);

		TextDrawDestroy(TD_Spaceship_Fuel[playerid]);
		TD_Spaceship_Fuel[playerid]=TextDrawCreate(480,50,"LD_DUAL:health");
		TextDrawFont(TD_Spaceship_Fuel[playerid],4);
		TextDrawColor(TD_Spaceship_Fuel[playerid],0xFFFFFFFF);
		TextDrawTextSize(TD_Spaceship_Fuel[playerid],_Spaceship_Fuel[playerid],5);
		TextDrawShowForPlayer(playerid,TD_Spaceship_Fuel[playerid]);
	}
    return true;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(spaceship,9,cmdtext);
	dcmd(exitspaceship,13,cmdtext);
	return false;
}

//_____________________________________________________________________Command's
dcmd_exitspaceship(playerid,params[])
{
	#pragma unused params
    if(_Spaceship_PlayerPlays[playerid]==true)
		HideSpaceshipGame(playerid);
	return true;
}

dcmd_spaceship(playerid,params[])
{
	#pragma unused params
	if(_Spaceship_PlayerPlays[playerid]==true)return true;
	TogglePlayerControllable(playerid,false);
	forEx(20,i)
	    SendClientMessage(playerid,-1,"");
	TD_Spaceship[playerid]=TextDrawCreate(300,360,"LD_DUAL:rockshp");
	TextDrawFont(TD_Spaceship[playerid],4);
	TextDrawColor(TD_Spaceship[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship[playerid],40,40);

	TD_Spaceship_Fuel[playerid]=TextDrawCreate(480,50,"LD_DUAL:health");
	TextDrawFont(TD_Spaceship_Fuel[playerid],4);
	TextDrawColor(TD_Spaceship_Fuel[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Fuel[playerid],100,5);

	TD_Spaceship_Health[playerid]=TextDrawCreate(480,40,"LD_DUAL:power");
	TextDrawFont(TD_Spaceship_Health[playerid],4);
	TextDrawColor(TD_Spaceship_Health[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Health[playerid],100,5);

	TextDrawShowForPlayer(playerid,TD_Spaceship_Background);
	TextDrawShowForPlayer(playerid,TD_Spaceship_CornerTopLeft);
	TextDrawShowForPlayer(playerid,TD_Spaceship_CornerTopRight);
	TextDrawShowForPlayer(playerid,TD_Spaceship_CornerBottomLeft);
	TextDrawShowForPlayer(playerid,TD_Spaceship_CornerBottomRight);
	TextDrawShowForPlayer(playerid,TD_Spaceship[playerid]);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Fuel[playerid]);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Health[playerid]);
    _Spaceship_PlayerPlays[playerid]=true;
	SetTimerEx("SendBonusToSpaceship",BONUS_DISTANCE*1000,false,"d",playerid);
	SetTimerEx("SendAttackerToSpaceship",ATTACKER_DISTANCE*1000,false,"d",playerid);
	return true;
}

//__________________________________________________________________New Public's
forward SendBonusToSpaceship(playerid);
public SendBonusToSpaceship(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	if(_Spaceship_Bonus_ONW[playerid]==true)return true;
    _Spaceship_Bonus_ONW[playerid]=true;
    _Spaceship_BonusY[playerid]=-10;
	_Spaceship_BonusX[playerid]=Random(70,520);
	TD_Spaceship_Bonus[playerid]=TextDrawCreate(_Spaceship_BonusX[playerid],_Spaceship_BonusY[playerid],"LD_DUAL:shoot");
	TextDrawFont(TD_Spaceship_Bonus[playerid],4);
	TextDrawColor(TD_Spaceship_Bonus[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Bonus[playerid],10,10);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Bonus[playerid]);
	SetTimerEx("SendBonusToSpaceshipTimer",100,false,"d",playerid);
	return true;
}

forward SendBonusToSpaceshipTimer(playerid);
public SendBonusToSpaceshipTimer(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	if(_Spaceship_BonusY[playerid]>480)
	{
		TextDrawHideForPlayer(playerid,TD_Spaceship_Bonus[playerid]);
		_Spaceship_Bonus_ONW[playerid]=false;
		SetTimerEx("SendBonusToSpaceship",BONUS_DISTANCE*1000,false,"d",playerid);
		return true;
	}
	if(_Spaceship_BonusY[playerid]>360&&_Spaceship_BonusY[playerid]<400)
	{
		if(_Spaceship_BonusX[playerid]>_Spaceship_Position[playerid]&&_Spaceship_BonusX[playerid]<_Spaceship_Position[playerid]+30)
		{
			TextDrawHideForPlayer(playerid,TD_Spaceship_Bonus[playerid]);
			_Spaceship_Fuel[playerid]=100;
			if(_Spaceship_Health[playerid]<=75)_Spaceship_Health[playerid]+=25;
			TextDrawDestroy(TD_Spaceship_Health[playerid]);
			TD_Spaceship_Health[playerid]=TextDrawCreate(480,40,"LD_DUAL:power");
			TextDrawFont(TD_Spaceship_Health[playerid],4);
			TextDrawColor(TD_Spaceship_Health[playerid],0xFFFFFFFF);
			TextDrawTextSize(TD_Spaceship_Health[playerid],_Spaceship_Health[playerid],5);
			TextDrawShowForPlayer(playerid,TD_Spaceship_Health[playerid]);
			_Spaceship_Bonus_ONW[playerid]=false;
			SetTimerEx("SendBonusToSpaceship",BONUS_DISTANCE*1000,false,"d",playerid);
			return true;
		}
	}
	TextDrawDestroy(TD_Spaceship_Bonus[playerid]);
	TD_Spaceship_Bonus[playerid]=TextDrawCreate(_Spaceship_BonusX[playerid],_Spaceship_BonusY[playerid],"LD_DUAL:shoot");
	TextDrawFont(TD_Spaceship_Bonus[playerid],4);
	TextDrawColor(TD_Spaceship_Bonus[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Bonus[playerid],10,10);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Bonus[playerid]);
	_Spaceship_BonusY[playerid]+=BONUS_SPEED;
	SetTimerEx("SendBonusToSpaceshipTimer",100,false,"d",playerid);
	return true;
}

forward SendAttackerToSpaceship(playerid);
public SendAttackerToSpaceship(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	if(_Spaceship_Attacker_ONW[playerid]==true)return true;
    _Spaceship_Attacker_ONW[playerid]=true;
    _Spaceship_AttackerY[playerid]=-10;
	_Spaceship_AttackerX[playerid]=Random(70,520);
	TD_Spaceship_Attacker[playerid]=TextDrawCreate(_Spaceship_AttackerX[playerid],_Spaceship_AttackerY[playerid],"LD_NONE:ship2");
	TextDrawFont(TD_Spaceship_Attacker[playerid],4);
	TextDrawColor(TD_Spaceship_Attacker[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Attacker[playerid],50,50);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Attacker[playerid]);
	SetTimerEx("SpaceshipAttackerMoving",50,false,"d",playerid);
	return true;
}

forward SpaceshipAttackerMoving(playerid);
public SpaceshipAttackerMoving(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	if(_Spaceship_AttackerY[playerid]>480)
	{
		TextDrawHideForPlayer(playerid,TD_Spaceship_Attacker[playerid]);
		_Spaceship_Attacker_ONW[playerid]=false;
		SetTimerEx("SendAttackerToSpaceship",ATTACKER_DISTANCE*1000,false,"d",playerid);
		return true;
	}
	if(_Spaceship_AttackerY[playerid]+50>360&&_Spaceship_AttackerY[playerid]<400)
	{
		if(_Spaceship_AttackerX[playerid]>=_Spaceship_Position[playerid]&&_Spaceship_AttackerX[playerid]<=_Spaceship_Position[playerid]+40||_Spaceship_AttackerX[playerid]+50>=_Spaceship_Position[playerid]&&_Spaceship_AttackerX[playerid]+50<=_Spaceship_Position[playerid]+40)
		{
			TextDrawHideForPlayer(playerid,TD_Spaceship_Attacker[playerid]);
			_Spaceship_Attacker_ONW[playerid]=false;
			_Spaceship_Health[playerid]-=25;
			TextDrawDestroy(TD_Spaceship_Health[playerid]);
			TD_Spaceship_Health[playerid]=TextDrawCreate(480,40,"LD_DUAL:power");
			TextDrawFont(TD_Spaceship_Health[playerid],4);
			TextDrawColor(TD_Spaceship_Health[playerid],0xFFFFFFFF);
			TextDrawTextSize(TD_Spaceship_Health[playerid],_Spaceship_Health[playerid],5);
			TextDrawShowForPlayer(playerid,TD_Spaceship_Health[playerid]);
		    CreateSpaceshipExplosion(playerid);
			if(_Spaceship_Health[playerid]<=0)
			{
			    PlayerLooseSpaceship(playerid);
			    return true;
			}
			SetTimerEx("SendAttackerToSpaceship",ATTACKER_DISTANCE*1000,false,"d",playerid);
			return true;
		}
	}
	TextDrawDestroy(TD_Spaceship_Attacker[playerid]);
	TD_Spaceship_Attacker[playerid]=TextDrawCreate(_Spaceship_AttackerX[playerid],_Spaceship_AttackerY[playerid],"LD_NONE:ship2");
	TextDrawFont(TD_Spaceship_Attacker[playerid],4);
	TextDrawColor(TD_Spaceship_Attacker[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Attacker[playerid],50,50);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Attacker[playerid]);
	_Spaceship_AttackerY[playerid]+=ATTACKER_SPEED/2;
	SetTimerEx("SpaceshipAttackerMoving",50,false,"d",playerid);
	return true;
}

forward ExplodeSpaceshipAnimation(playerid);
public ExplodeSpaceshipAnimation(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	TextDrawDestroy(TD_Spaceship_Explosion[playerid]);
	if(_Spaceship_Explosion[playerid]==3)TD_Spaceship_Explosion[playerid]=TextDrawCreate(_Spaceship_Position[playerid],360,"LD_DUAL:ex2");
	else if(_Spaceship_Explosion[playerid]==2)TD_Spaceship_Explosion[playerid]=TextDrawCreate(_Spaceship_Position[playerid],360,"LD_DUAL:ex3");
	else if(_Spaceship_Explosion[playerid]==1)TD_Spaceship_Explosion[playerid]=TextDrawCreate(_Spaceship_Position[playerid],360,"LD_DUAL:ex4");
	else if(_Spaceship_Explosion[playerid]==0)
	{
		_Spaceship_PlayerExplode[playerid]=false;
		TextDrawDestroy(TD_Spaceship_Explosion[playerid]);
		return true;
	}
	SetTimerEx("ExplodeSpaceshipAnimation",75,false,"d",playerid);
	TextDrawFont(TD_Spaceship_Explosion[playerid],4);
	TextDrawColor(TD_Spaceship_Explosion[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Explosion[playerid],40,40);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Explosion[playerid]);
    _Spaceship_Explosion[playerid]--;
	return true;
}

forward HideSpaceshipGame(playerid);
public HideSpaceshipGame(playerid)
{
	TextDrawHideForPlayer(playerid,TD_Spaceship_Background);
	TextDrawHideForPlayer(playerid,TD_Spaceship_CornerTopLeft);
	TextDrawHideForPlayer(playerid,TD_Spaceship_CornerTopRight);
	TextDrawHideForPlayer(playerid,TD_Spaceship_CornerBottomLeft);
	TextDrawHideForPlayer(playerid,TD_Spaceship_CornerBottomRight);
	TextDrawDestroy(TD_Spaceship[playerid]);
	TextDrawDestroy(TD_Spaceship_Fuel[playerid]);
	TextDrawDestroy(TD_Spaceship_Health[playerid]);
	if(_Spaceship_Bonus_ONW[playerid]==true)TextDrawDestroy(TD_Spaceship_Bonus[playerid]);
	if(_Spaceship_Attacker_ONW[playerid]==true)TextDrawDestroy(TD_Spaceship_Attacker[playerid]);
	_Spaceship_Position[playerid]=300;
	_Spaceship_Health[playerid]=100;
	_Spaceship_Fuel[playerid]=100.0;
	_Spaceship_BonusY[playerid]=-10;
	_Spaceship_AttackerY[playerid]=-10;
	_Spaceship_PlayerLoosed[playerid]=false;
	_Spaceship_PlayerPlays[playerid]=false;
	_Spaceship_PlayerExplode[playerid]=false;
	_Spaceship_Bonus_ONW[playerid]=false;
	_Spaceship_Attacker_ONW[playerid]=false;
	TogglePlayerControllable(playerid,true);
	return true;
}

//____________________________________________________________________Function's
CreateSpaceshipExplosion(playerid)
{
    if(_Spaceship_PlayerPlays[playerid]==false)return true;
	if(_Spaceship_PlayerExplode[playerid]==true)return true;
	_Spaceship_PlayerExplode[playerid]=true;
	TD_Spaceship_Explosion[playerid]=TextDrawCreate(_Spaceship_Position[playerid],360,"LD_DUAL:ex1");
	TextDrawFont(TD_Spaceship_Explosion[playerid],4);
	TextDrawColor(TD_Spaceship_Explosion[playerid],0xFFFFFFFF);
	TextDrawTextSize(TD_Spaceship_Explosion[playerid],40,40);
	TextDrawShowForPlayer(playerid,TD_Spaceship_Explosion[playerid]);
	_Spaceship_Explosion[playerid]=3;
	SetTimerEx("ExplodeSpaceshipAnimation",100,false,"d",playerid);
	return true;
}

PlayerLooseSpaceship(playerid)
{
	GameTextForPlayer(playerid,"~r~Game Over",3000,3);
	_Spaceship_PlayerLoosed[playerid]=true;
	TextDrawHideForPlayer(playerid,TD_Spaceship[playerid]);
	TextDrawHideForPlayer(playerid,TD_Spaceship_Fuel[playerid]);
	TextDrawHideForPlayer(playerid,TD_Spaceship_Health[playerid]);
	TextDrawHideForPlayer(playerid,TD_Spaceship_Bonus[playerid]);
	TextDrawHideForPlayer(playerid,TD_Spaceship_Attacker[playerid]);
	SetTimerEx("HideSpaceshipGame",3000,false,"d",playerid);
	return true;
}

stock Random(min,max)
{
	new a=random(max-min)+min;
	return a;
}
