//!:.:!:.:!:.:!:.:!:.:!:.:!:.:!:.:![Made by Notime]!:.:!:.:!:.:!:.:!:.:!:.:!:.:!:.:!
#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define COLOR_TAN 0xBDB76BAA
#define RED 		0xE60000FF
#define WHITE 		0xFFFFFFFF
new Float:FRX[MAX_PLAYERS], Float:FRY[MAX_PLAYERS], Float:FRZ[MAX_PLAYERS];
new firecrackertime[MAX_PLAYERS];
new firerockettime[MAX_PLAYERS];
new explosionrocket[MAX_PLAYERS];
new Firecracker[MAX_PLAYERS];
new Firerocket[MAX_PLAYERS];
new rocketsmoke[MAX_PLAYERS];
new light1[MAX_PLAYERS];
new light2[MAX_PLAYERS];
new light3[MAX_PLAYERS];
new light4[MAX_PLAYERS];
new light5[MAX_PLAYERS];
new light6[MAX_PLAYERS];
new light7[MAX_PLAYERS];
new light8[MAX_PLAYERS];

new rlight11[MAX_PLAYERS];
new rlight12[MAX_PLAYERS];
new rlight13[MAX_PLAYERS];
new rlight14[MAX_PLAYERS];
new rlight15[MAX_PLAYERS];
new rlight16[MAX_PLAYERS];
new rlight17[MAX_PLAYERS];
new rlight18[MAX_PLAYERS];
new rlight19[MAX_PLAYERS];
new rlight20[MAX_PLAYERS];
new rlight21[MAX_PLAYERS];
new rlight22[MAX_PLAYERS];
new rlight23[MAX_PLAYERS];
new rlight24[MAX_PLAYERS];
new rlight25[MAX_PLAYERS];
new rlight26[MAX_PLAYERS];
new rlight27[MAX_PLAYERS];
new rlight28[MAX_PLAYERS];
new rlight29[MAX_PLAYERS];
new rlight30[MAX_PLAYERS];
new rlight31[MAX_PLAYERS];
new rlight32[MAX_PLAYERS];
new rlight33[MAX_PLAYERS];
new rlight34[MAX_PLAYERS];
new rlight35[MAX_PLAYERS];
new rlight36[MAX_PLAYERS];
new rlight37[MAX_PLAYERS];
new rlight38[MAX_PLAYERS];
new rlight39[MAX_PLAYERS];
new rlight40[MAX_PLAYERS];
new rlight41[MAX_PLAYERS];
new rlight42[MAX_PLAYERS];
new rlight43[MAX_PLAYERS];

forward FirecrackerTime(playerid);
forward FirerocketTime(playerid);
forward splittime(playerid);
forward splittime2(playerid);
forward splittime3(playerid);
forward lighttimer(playerid);
forward lighttimer2(playerid);

stock ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(IsPlayerConnected(i))
				{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}

stock Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, x, y, a);
    if (IsPlayerInAnyVehicle(playerid))
        GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else
        GetPlayerFacingAngle(playerid, a);
    x += (distance * floatsin(-a, degrees));
    y += (distance * floatcos(-a, degrees));
    return a;
}

public FirecrackerTime(playerid)
{
	if(firecrackertime[playerid] == 1)
	{
	    new Float:X, Float:Y,Float:Z;
		GetObjectPos(Firecracker[playerid], X, Y, Z);
		CreateExplosion(X,Y,Z, 12, 0);
		DestroyObject(Firecracker[playerid]);
		firecrackertime[playerid] = 0;
		return 1;
	}
	return 1;
}

public FirerocketTime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime", 500, 0, "i", playerid);
		return 1;
	}
	if(firerockettime[playerid] == 2)
	{
		GetObjectPos(Firerocket[playerid], FRX[playerid], FRY[playerid], FRZ[playerid]);
		explosionrocket[playerid] = CreateExplosion(FRX[playerid], FRY[playerid], FRZ[playerid], 6, 0);
		SetTimerEx("splittime2", 100, 0, "i", playerid);
		return 1;
	}
	return 1;
}

public splittime(playerid)
{
	if(firerockettime[playerid] == 1)
	{
		CreateExplosion(FRX[playerid]-3,FRY[playerid]-3,FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid]-3,FRY[playerid]+3,FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid]-3,FRY[playerid],FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid]+3,FRY[playerid]-3,FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid]+3,FRY[playerid]+3,FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid]+3,FRY[playerid],FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-3,FRZ[playerid]-3, 4, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+3,FRZ[playerid]-3, 4, 0);
		light1[playerid] = CreateObject(354,FRX[playerid]-3,FRY[playerid]-3,FRZ[playerid]+4, 0, 0,0);
		light2[playerid] = CreateObject(354,FRX[playerid]-3,FRY[playerid],FRZ[playerid]+3, 0, 0,0);
		light3[playerid] = CreateObject(354,FRX[playerid]-3,FRY[playerid],FRZ[playerid]-4, 0, 0,0);
		light4[playerid] = CreateObject(354,FRX[playerid]-1,FRY[playerid]-3,FRZ[playerid]+3, 0, 0,0);
		light5[playerid] = CreateObject(354,FRX[playerid]-3,FRY[playerid]+3,FRZ[playerid]+1, 0, 0,0);
		light6[playerid] = CreateObject(354,FRX[playerid]-3,FRY[playerid],FRZ[playerid]-3, 0, 0,0);
		light7[playerid] = CreateObject(354,FRX[playerid]-1,FRY[playerid]-1,FRZ[playerid]-3, 0, 0,0);
		light8[playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-1,FRZ[playerid]+2, 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(light1[playerid], X, Y, Z);
		MoveObject(light1[playerid], X-6, Y-6, Z-20, 6);
		GetObjectPos(light2[playerid], X, Y, Z);
		MoveObject(light2[playerid], X-6, Y+6, Z-20, 5);
		GetObjectPos(light3[playerid], X, Y, Z);
		MoveObject(light3[playerid], X-6, Y, Z-20, 4);
		GetObjectPos(light4[playerid], X, Y, Z);
		MoveObject(light4[playerid], X+6, Y-6, Z-20, 5);
		GetObjectPos(light5[playerid], X, Y, Z);
		MoveObject(light5[playerid], X+6, Y+6, Z-20, 5);
		GetObjectPos(light6[playerid], X, Y, Z);
		MoveObject(light6[playerid], X+6, Y, Z-20, 4);
		GetObjectPos(light7[playerid], X, Y, Z);
		MoveObject(light7[playerid], X, Y-6, Z-20, 6);
		GetObjectPos(light8[playerid], X, Y, Z);
		MoveObject(light8[playerid], X, Y+6, Z-20, 5);
		SetTimerEx("lighttimer", 3900, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public splittime2(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		CreateExplosion(FRX[playerid]-7,FRY[playerid]-7,FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-7,FRY[playerid]+7,FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]-7,FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+7,FRY[playerid]-7,FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+7,FRY[playerid]+7,FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid]+7,FRY[playerid],FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]-7,FRZ[playerid]-5, 6, 0);
		CreateExplosion(FRX[playerid],FRY[playerid]+7,FRZ[playerid]-5, 6, 0);
		light1[playerid] = CreateObject(354,FRX[playerid]-7,FRY[playerid]-7,FRZ[playerid]-5, 0, 0,0);
		light2[playerid] = CreateObject(354,FRX[playerid]-7,FRY[playerid]+7,FRZ[playerid]-5, 0, 0,0);
		light3[playerid] = CreateObject(354,FRX[playerid]-7,FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		light4[playerid] = CreateObject(354,FRX[playerid]+7,FRY[playerid]-7,FRZ[playerid]-5, 0, 0,0);
		light5[playerid] = CreateObject(354,FRX[playerid]+7,FRY[playerid]+7,FRZ[playerid]-5, 0, 0,0);
		light6[playerid] = CreateObject(354,FRX[playerid]+7,FRY[playerid],FRZ[playerid]-5, 0, 0,0);
		light7[playerid] = CreateObject(354,FRX[playerid],FRY[playerid]-7,FRZ[playerid]-5, 0, 0,0);
		light8[playerid] = CreateObject(354,FRX[playerid],FRY[playerid]+7,FRZ[playerid]-5, 0, 0,0);
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(light1[playerid], X, Y, Z);
		MoveObject(light1[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(light2[playerid], X, Y, Z);
		MoveObject(light2[playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(light3[playerid], X, Y, Z);
		MoveObject(light3[playerid], X-6, Y, Z-20, 4);
		GetObjectPos(light4[playerid], X, Y, Z);
		MoveObject(light4[playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(light5[playerid], X, Y, Z);
		MoveObject(light5[playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(light6[playerid], X, Y, Z);
		MoveObject(light6[playerid], X+6, Y, Z-20, 4);
		GetObjectPos(light7[playerid], X, Y, Z);
		MoveObject(light7[playerid], X, Y-6, Z-20, 4);
		GetObjectPos(light8[playerid], X, Y, Z);
		MoveObject(light8[playerid], X, Y+6, Z-20, 4);
		SetTimerEx("splittime3", 3000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public splittime3(playerid)
{
	if(firerockettime[playerid] == 2)
	{
		new Float:X,Float:Y,Float:Z;
		GetObjectPos(light1[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light2[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light3[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light4[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light5[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light6[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light7[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light8[playerid], X, Y, Z);
		CreateExplosion(X, Y, Z, 6, 0);
		GetObjectPos(light1[playerid], X, Y, Z);
		rlight11[playerid] = CreateObject(1213,X-7,Y+7,Z+8, 0, 0,0);
		rlight12[playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		rlight13[playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		rlight14[playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(light2[playerid], X, Y, Z);
		rlight15[playerid] = CreateObject(1213,X,Y-7,Z+5, 0, 0,0);
		rlight16[playerid] = CreateObject(1213,X-7,Y,Z-5, 0, 0,0);
		rlight17[playerid] = CreateObject(1213,X,Y+7,Z-8, 0, 0,0);
		rlight18[playerid] = CreateObject(1213,X,Y+7,Z-5, 0, 0,0);
		GetObjectPos(light3[playerid], X, Y, Z);
		rlight19[playerid] = CreateObject(1213,X+7,Y,Z-1, 0, 0,0);
		rlight20[playerid] = CreateObject(1213,X-7,Y,Z-8, 0, 0,0);
		rlight21[playerid] = CreateObject(1213,X+7,Y+7,Z-5, 0, 0,0);
		rlight22[playerid] = CreateObject(1213,X,Y,Z+5, 0, 0,0);
		GetObjectPos(light4[playerid], X, Y, Z);
		rlight23[playerid] = CreateObject(1213,X+7,Y-7,Z-5, 0, 0,0);
		rlight24[playerid] = CreateObject(1213,X-7,Y,Z-7, 0, 0,0);
		rlight25[playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		rlight26[playerid] = CreateObject(1213,X,Y-7,Z, 0, 0,0);
		GetObjectPos(light5[playerid], X, Y, Z);
		rlight27[playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		rlight28[playerid] = CreateObject(1213,X-7,Y,Z+8, 0, 0,0);
		rlight29[playerid] = CreateObject(1213,X+7,Y,Z-8, 0, 0,0);
		rlight30[playerid] = CreateObject(1213,X,Y+7,Z+5, 0, 0,0);
		GetObjectPos(light6[playerid], X, Y, Z);
		rlight31[playerid] = CreateObject(1213,X-7,Y-7,Z-7, 0, 0,0);
		rlight32[playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		rlight33[playerid] = CreateObject(1213,X+7,Y+7,Z+5, 0, 0,0);
		rlight34[playerid] = CreateObject(1213,X+4,Y-7,Z-5, 0, 0,0);
		GetObjectPos(light7[playerid], X, Y, Z);
		rlight35[playerid] = CreateObject(1213,X-7,Y-7,Z-8, 0, 0,0);
		rlight36[playerid] = CreateObject(1213,X-7,Y,Z+5, 0, 0,0);
		rlight37[playerid] = CreateObject(1213,X,Y,Z-5, 0, 0,0);
		rlight38[playerid] = CreateObject(1213,X,Y-7,Z+8, 0, 0,0);
		GetObjectPos(light8[playerid], X, Y, Z);
		rlight39[playerid] = CreateObject(1213,X-4,Y-7,Z-8, 0, 0,0);
		rlight41[playerid] = CreateObject(1213,X+7,Y,Z+8, 0, 0,0);
		rlight42[playerid] = CreateObject(1213,X+4,Y,Z+5, 0, 0,0);
		rlight43[playerid] = CreateObject(1213,X,Y-7,Z-5, 0, 0,0);
		GetObjectPos(light1[playerid], X, Y, Z);
		MoveObject(light1[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(light2[playerid], X, Y, Z);
		MoveObject(light2[playerid], X-6, Y+6, Z-20, 4);
		GetObjectPos(light3[playerid], X, Y, Z);
		MoveObject(light3[playerid], X-6, Y, Z-20, 4);
		GetObjectPos(light4[playerid], X, Y, Z);
		MoveObject(light4[playerid], X+6, Y-6, Z-20, 4);
		GetObjectPos(light5[playerid], X, Y, Z);
		MoveObject(light5[playerid], X+6, Y+6, Z-20, 4);
		GetObjectPos(light6[playerid], X, Y, Z);
		MoveObject(light6[playerid], X+6, Y, Z-20, 4);
		GetObjectPos(light7[playerid], X, Y, Z);
		MoveObject(light7[playerid], X, Y-6, Z-20, 4);
		GetObjectPos(light8[playerid], X, Y, Z);
		MoveObject(light8[playerid], X, Y+6, Z-20, 4);
		GetObjectPos(rlight11[playerid], X, Y, Z);
		MoveObject(rlight11[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight12[playerid], X, Y, Z);
		MoveObject(rlight12[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight13[playerid], X, Y, Z);
		MoveObject(rlight13[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight14[playerid], X, Y, Z);
		MoveObject(rlight14[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight15[playerid], X, Y, Z);
		MoveObject(rlight15[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight16[playerid], X, Y, Z);
		MoveObject(rlight16[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight17[playerid], X, Y, Z);
		MoveObject(rlight17[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight18[playerid], X, Y, Z);
		MoveObject(rlight18[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight19[playerid], X, Y, Z);
		MoveObject(rlight19[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight20[playerid], X, Y, Z);
		MoveObject(rlight20[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight21[playerid], X, Y, Z);
		MoveObject(rlight21[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight22[playerid], X, Y, Z);
		MoveObject(rlight22[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight23[playerid], X, Y, Z);
		MoveObject(rlight23[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight24[playerid], X, Y, Z);
		MoveObject(rlight24[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight25[playerid], X, Y, Z);
		MoveObject(rlight25[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight26[playerid], X, Y, Z);
		MoveObject(rlight26[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight27[playerid], X, Y, Z);
		MoveObject(rlight27[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight28[playerid], X, Y, Z);
		MoveObject(rlight28[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight29[playerid], X, Y, Z);
		MoveObject(rlight29[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight30[playerid], X, Y, Z);
		MoveObject(rlight30[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight31[playerid], X, Y, Z);
		MoveObject(rlight31[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight32[playerid], X, Y, Z);
		MoveObject(rlight32[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight33[playerid], X, Y, Z);
		MoveObject(rlight33[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight34[playerid], X, Y, Z);
		MoveObject(rlight34[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight35[playerid], X, Y, Z);
		MoveObject(rlight35[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight36[playerid], X, Y, Z);
		MoveObject(rlight36[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight37[playerid], X, Y, Z);
		MoveObject(rlight37[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight38[playerid], X, Y, Z);
		MoveObject(rlight38[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight39[playerid], X, Y, Z);
		MoveObject(rlight39[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight40[playerid], X, Y, Z);
		MoveObject(rlight40[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight41[playerid], X, Y, Z);
		MoveObject(rlight41[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight42[playerid], X, Y, Z);
		MoveObject(rlight42[playerid], X-6, Y-6, Z-20, 4);
		GetObjectPos(rlight43[playerid], X, Y, Z);
		MoveObject(rlight43[playerid], X-6, Y-6, Z-20, 4);
		SetTimerEx("lighttimer2", 4000, 0, "i", playerid);
		DestroyObject(Firerocket[playerid]);
		DestroyObject(rocketsmoke[playerid]);
		return 1;
	}
	return 1;
}

public lighttimer(playerid)
{
	DestroyObject(light1[playerid]);
	DestroyObject(light2[playerid]);
	DestroyObject(light3[playerid]);
	DestroyObject(light4[playerid]);
	DestroyObject(light5[playerid]);
    DestroyObject(light6[playerid]);
    DestroyObject(light7[playerid]);
    DestroyObject(light8[playerid]);
    firerockettime[playerid] = 0;
	return 1;
}

public lighttimer2(playerid)
{
	DestroyObject(light1[playerid]);
	DestroyObject(light2[playerid]);
	DestroyObject(light3[playerid]);
	DestroyObject(light4[playerid]);
	DestroyObject(light5[playerid]);
    DestroyObject(light6[playerid]);
    DestroyObject(light7[playerid]);
    DestroyObject(light8[playerid]);
    DestroyObject(rlight11[playerid]);
	DestroyObject(rlight12[playerid]);
	DestroyObject(rlight13[playerid]);
	DestroyObject(rlight14[playerid]);
	DestroyObject(rlight15[playerid]);
    DestroyObject(rlight16[playerid]);
    DestroyObject(rlight17[playerid]);
    DestroyObject(rlight18[playerid]);
    DestroyObject(rlight19[playerid]);
	DestroyObject(rlight20[playerid]);
	DestroyObject(rlight21[playerid]);
	DestroyObject(rlight22[playerid]);
	DestroyObject(rlight23[playerid]);
    DestroyObject(rlight24[playerid]);
    DestroyObject(rlight25[playerid]);
    DestroyObject(rlight26[playerid]);
    DestroyObject(rlight27[playerid]);
	DestroyObject(rlight28[playerid]);
	DestroyObject(rlight29[playerid]);
	DestroyObject(rlight30[playerid]);
	DestroyObject(rlight31[playerid]);
    DestroyObject(rlight32[playerid]);
    DestroyObject(rlight33[playerid]);
    DestroyObject(rlight34[playerid]);
    DestroyObject(rlight35[playerid]);
	DestroyObject(rlight36[playerid]);
	DestroyObject(rlight37[playerid]);
	DestroyObject(rlight38[playerid]);
	DestroyObject(rlight39[playerid]);
    DestroyObject(rlight40[playerid]);
    DestroyObject(rlight41[playerid]);
    DestroyObject(rlight42[playerid]);
    DestroyObject(rlight43[playerid]);
    firerockettime[playerid] = 0;
	return 1;
}
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Notime's Firework");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n--------------------------------------");
	print("Notime's Firework");
	print("--------------------------------------\n");
}

#endif

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, WHITE, "FilterScript loaded: Notime's Firework");
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(lightfw,7,cmdtext);
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

dcmd_lightfw(playerid, params[])
{
    if(!strlen(params))
	{
		SendClientMessage(playerid, COLOR_TAN, "Right Usage: /lightfw [type]");
		SendClientMessage(playerid, COLOR_TAN, "Types: Firecracker, firerocket1, firerocket2");
		return 1;
	}
	if(strcmp("firecracker", params, true, 8) == 0)
	{
	    if(firecrackertime[playerid] == 0)
	    {
	        new Float:X, Float:Y,Float:Z;
	        firecrackertime[playerid] = 1;
		    new string[128];
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "<> %s throws away a firecracker.", sendername);
			ProxDetector(15.0, playerid, string, WHITE,WHITE,WHITE,WHITE,WHITE);
			GetPlayerPos(playerid,X,Y,Z);
			GetXYInFrontOfPlayer(playerid, X,Y, 8);
			Firecracker[playerid] = CreateObject(1672, X,Y,(Z-0.9), 0, 0, 0);
			SetTimerEx("FirecrackerTime", 5000, 0, "i", playerid);
			return 1;
		}
		else return SendClientMessage(playerid, RED, "ERROR: You already threw a firecracker.");
	}
	if(strcmp("firerocket1", params, true, 11) == 0)
	{
	    if(firerockettime[playerid] == 0)
	    {
	        new Float:X, Float:Y,Float:Z;
	        firerockettime[playerid] = 1;
		    new string[128];
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "<> %s lights up a fire rocket.", sendername);
			ProxDetector(15.0, playerid, string, WHITE,WHITE,WHITE,WHITE,WHITE);
			GetPlayerPos(playerid,X,Y,Z);
			GetXYInFrontOfPlayer(playerid, X,Y, 40);
			Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
			rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
			MoveObject(Firerocket[playerid], X, Y, Z+30, 10);
			MoveObject(rocketsmoke[playerid], X, Y, Z+30, 10);
			SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
			return 1;
		}
		else return SendClientMessage(playerid, RED, "ERROR: You already threw a firerocket.");
	}
	if(strcmp("firerocket2", params, true, 11) == 0)
	{
		if(firerockettime[playerid] == 0)
		{
		    new Float:X, Float:Y,Float:Z;
		    firerockettime[playerid] = 2;
		    new string[128];
			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "<> %s lights up a fire rocket.", sendername);
			ProxDetector(15.0, playerid, string, WHITE,WHITE,WHITE,WHITE,WHITE);
			GetPlayerPos(playerid,X,Y,Z);
			GetXYInFrontOfPlayer(playerid, X,Y, 40);
			Firerocket[playerid] = CreateObject(354, X,Y,(Z), 0, 0, 0);
			rocketsmoke[playerid] = CreateObject(2780, X,Y,(Z), 0, 0, 0);
			MoveObject(Firerocket[playerid], X, Y, Z+50, 15);
			MoveObject(rocketsmoke[playerid], X, Y, Z+50, 15);
			SetTimerEx("FirerocketTime", 3000, 0, "i", playerid);
			return 1;
		}
		else return SendClientMessage(playerid, RED, "ERROR: You already threw a firerocket.");
	}
	else return SendClientMessage(playerid, COLOR_TAN, "Right Usage: /lightfirework [type]");
}

//!:.:!:.:!:.:!:.:!:.:!:.:!:.:!:.:![Made by Notime]!:.:!:.:!:.:!:.:!:.:!:.:!:.:!:.:!
