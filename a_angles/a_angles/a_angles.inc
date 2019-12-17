// a_angles.inc
// Angle functions
// Created by:
// Tannz0rz

#if defined _a_angles_included
  #endinput
#endif
#define _a_angles_included

#include <a_samp>
stock SetPlayerToFacePlayer(playerid, targetid){
	new	Float:pX;
	new	Float:pY;
	new	Float:pZ;
	new	Float:X;
	new	Float:Y;
	new	Float:Z;
	new	Float:ang;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)){
		return 0;
	}
	GetPlayerPos(targetid, X, Y, Z);
	GetPlayerPos(playerid, pX, pY, pZ);
	if( Y > pY ){
		ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	}
	else if( Y < pY && X < pX ){
		ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	}
	else if( Y < pY ){
		ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	}
	if(X > pX){
		ang = (floatabs(floatabs(ang) + 180.0));
	}
	else{
		ang = (floatabs(ang) - 180.0);
	}
	SetPlayerFacingAngle(playerid, ang);
 	return 0;
}
stock IsPlayerBehindPlayer(playerid, targetid, Float:dOffset){
	new Float:pa;
	new Float:ta;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)){
 		return 0;
	}
	GetPlayerFacingAngle(playerid, pa);
	GetPlayerFacingAngle(targetid, ta);
	if(AngleInRangeOfAngle(pa, ta, dOffset) && IsPlayerFacingPlayer(playerid, targetid, dOffset)){
		return true;
	}
	return false;
}
stock IsPlayerFacingPlayer(playerid, targetid, Float:dOffset){
	new	Float:pX;
	new	Float:pY;
	new	Float:pZ;
	new	Float:pA;
	new	Float:X;
	new	Float:Y;
	new	Float:Z;
	new	Float:ang;
	if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)){
		return 0;
	}
	GetPlayerPos(targetid, pX, pY, pZ);
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, pA);
	if( Y > pY ){
		ang = (-acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	}
	else if( Y < pY && X < pX ){
		ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 450.0);
	}
	else if( Y < pY ){
		ang = (acos((X - pX) / floatsqroot((X - pX)*(X - pX) + (Y - pY)*(Y - pY))) - 90.0);
	}
	if(AngleInRangeOfAngle(-ang, pA, dOffset)){
		return true;
	}
	return false;
}
stock AngleInRangeOfAngle(Float:a1, Float:a2, Float:range){
	a1 -= a2;
	if((a1 < range) && (a1 > -range)){ return true;}
	return false;
}
