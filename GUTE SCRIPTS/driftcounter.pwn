#include <a_samp>

#define DRIFT_MINKAT 10.0
#define DRIFT_MAXKAT 90.0
#define DRIFT_SPEED 30.0

#define WHITErabbit 0xFFFFFFAA

new DriftPointsNow[200];
new PlayerDriftCancellation[200];
new Float:ppos[200][3];
enum Float:Pos{ Float:sX,Float:sY,Float:sZ };
new Float:SavedPos[MAX_PLAYERS][Pos];
new driftc[MAX_PLAYERS];

forward Drift(playerid);
forward AngleUpdate();
forward DriftCancellation(playerid);

public OnFilterScriptInit(){
        SetTimer("AngleUpdate", 200, true);
        SetTimer("Drift", 200, true);
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/drift", cmdtext, true, 10) == 0)
        {
                if(IsPlayerInAnyVehicle(playerid) == 1 && driftc[playerid] == 0)
                {
                        driftc[playerid] = 1;
                        SendClientMessage(playerid, WHITErabbit, "Drift Counter: ON");
                        return 1;
                }
                else if(IsPlayerInAnyVehicle(playerid) == 0)
                {
                        SendClientMessage(playerid, WHITErabbit, "Kinda waste of time to doing this without a car");
                }
                else if(IsPlayerInAnyVehicle(playerid) == 1 && driftc[playerid] == 1)
                {
                driftc[playerid] = 0;
                SendClientMessage(playerid, WHITErabbit, "Drift Counter: OFF");
                return 1;
                }
        }
        return 1;
}

Float:GetPlayerTheoreticAngle(i) // By Luby
{
        new Float:sin;
        new Float:dis;
        new Float:angle2;
        new Float:x,Float:y,Float:z;
        new Float:tmp3;
        new Float:tmp4;
        new Float:MindAngle;
        if(IsPlayerConnected(i)){
                GetPlayerPos(i,x,y,z);
                dis = floatsqroot(floatpower(floatabs(floatsub(x,ppos[i][0])),2)+floatpower(floatabs(floatsub(y,ppos[i][1])),2));
                if(IsPlayerInAnyVehicle(i))GetVehicleZAngle(GetPlayerVehicleID(i), angle2); else GetPlayerFacingAngle(i, angle2);
                if(x>ppos[i][0]){tmp3=x-ppos[i][0];}else{tmp3=ppos[i][0]-x;}
                if(y>ppos[i][1]){tmp4=y-ppos[i][1];}else{tmp4=ppos[i][1]-y;}
                if(ppos[i][1]>y && ppos[i][0]>x){
                        sin = asin(tmp3/dis);
                        MindAngle = floatsub(floatsub(floatadd(sin, 90), floatmul(sin, 2)), -90.0);
                }
                if(ppos[i][1]<y && ppos[i][0]>x){
                        sin = asin(tmp3/dis);
                        MindAngle = floatsub(floatadd(sin, 180), 180.0);
                }
                if(ppos[i][1]<y && ppos[i][0]<x){
                        sin = acos(tmp4/dis);
                        MindAngle = floatsub(floatadd(sin, 360), floatmul(sin, 2));
                }
                if(ppos[i][1]>y && ppos[i][0]<x){
                        sin = asin(tmp3/dis);
                        MindAngle = floatadd(sin, 180);
                }
        }
        if(MindAngle == 0.0){
                return angle2;
        } else
                return MindAngle;
}

public DriftCancellation(playerid){ // By Luby
        PlayerDriftCancellation[playerid] = 0;
        GameTextForPlayer(playerid, Split("~w~Drift ended!~n~~g~Earned ", tostr(DriftPointsNow[playerid]), "$"), 2000, 3);
        GivePlayerMoney(playerid, DriftPointsNow[playerid]);
        DriftPointsNow[playerid] = 0;
}

Float:ReturnPlayerAngle(playerid){ // By Luby
        new Float:Ang;
        if(IsPlayerInAnyVehicle(playerid))GetVehicleZAngle(GetPlayerVehicleID(playerid), Ang); else GetPlayerFacingAngle(playerid, Ang);
        return Ang;
}

public Drift(playerid){ // By Luby
                if(driftc[playerid] != 0)
                {
        new Float:Angle1, Float:Angle2, Float:BySpeed, s[256];
        new Float:Z;
        new Float:X;
        new Float:Y;
        new Float:SpeedX;
        for(new g=0;g<200;g++){
                GetPlayerPos(g, X, Y, Z);
                SpeedX = floatsqroot(floatadd(floatadd(floatpower(floatabs(floatsub(X,SavedPos[ g ][ sX ])),2),floatpower(floatabs(floatsub(Y,SavedPos[ g ][ sY ])),2)),floatpower(floatabs(floatsub(Z,SavedPos[ g ][ sZ ])),2)));
                Angle1 = ReturnPlayerAngle(g);
                Angle2 = GetPlayerTheoreticAngle(g);
                BySpeed = floatmul(SpeedX, 12);
                if(IsPlayerInAnyVehicle(g) && IsCar(GetPlayerVehicleID(g)) && floatabs(floatsub(Angle1, Angle2)) > DRIFT_MINKAT && floatabs(floatsub(Angle1, Angle2)) < DRIFT_MAXKAT && BySpeed > DRIFT_SPEED){
                        if(PlayerDriftCancellation[g] > 0)KillTimer(PlayerDriftCancellation[g]);
                        PlayerDriftCancellation[g] = 0;
                        DriftPointsNow[g] += floatval( floatabs(floatsub(Angle1, Angle2)) * 3 * (BySpeed*0.1) )/10;
                        PlayerDriftCancellation[g] = SetTimerEx("DriftCancellation", 3000, 0, "d", g);
                }
                if(DriftPointsNow[g] > 0){
                        format(s, sizeof(s), "~n~~n~~n~~n~~n~~n~~n~~n~~w~_________________You are drifting!~n~___________________~p~Points: %d$!", DriftPointsNow[g]);
                        GameTextForPlayer(g, s, 3000, 3);
                }
                SavedPos[ g ][ sX ] = X;
                SavedPos[ g ][ sY ] = Y;
                SavedPos[ g ][ sZ ] = Z;
                        }
                }
                else
                {
   //nothiiiiing
   }
}

Split(s1[], s2[], s3[]=""){ // By Luby
        new rxx[256];
        format(rxx, 256, "%s%s%s", s1, s2, s3);
        return rxx;
}

tostr(int){ // By Luby
        new st[256];
        format(st, 256, "%d", int);
        return st;
}

public AngleUpdate(){ // By Luby
        for(new g=0;g<200;g++){
                new Float:x, Float:y, Float:z;
                if(IsPlayerInAnyVehicle(g))GetVehiclePos(GetPlayerVehicleID(g), x, y, z); else GetPlayerPos(g, x, y, z);
                ppos[g][0] = x;
                ppos[g][1] = y;
                ppos[g][2] = z;
        }
}

floatval(Float:val){ // By Luby
        new str[256];
        format(str, 256, "%.0f", val);
        return todec(str);
}

IsCar(model) //By Luby
{
        switch(model)
        {
                case 443:return 0;
                case 448:return 0;
                case 461:return 0;
                case 462:return 0;
                case 463:return 0;
                case 468:return 0;
                case 521:return 0;
                case 522:return 0;
                case 523:return 0;
                case 581:return 0;
                case 586:return 0;
                case 481:return 0;
                case 509:return 0;
                case 510:return 0;
                case 430:return 0;
                case 446:return 0;
                case 452:return 0;
                case 453:return 0;
                case 454:return 0;
                case 472:return 0;
                case 473:return 0;
                case 484:return 0;
                case 493:return 0;
                case 595:return 0;
                case 417:return 0;
                case 425:return 0;
                case 447:return 0;
                case 465:return 0;
                case 469:return 0;
                case 487:return 0;
                case 488:return 0;
                case 497:return 0;
                case 501:return 0;
                case 548:return 0;
                case 563:return 0;
                case 406:return 0;
                case 444:return 0;
                case 556:return 0;
                case 557:return 0;
                case 573:return 0;
                case 460:return 0;
                case 464:return 0;
                case 476:return 0;
                case 511:return 0;
                case 512:return 0;
                case 513:return 0;
                case 519:return 0;
                case 520:return 0;
                case 539:return 0;
                case 553:return 0;
                case 577:return 0;
                case 592:return 0;
                case 593:return 0;
                case 471:return 0;
        }
        return 1;
}

todec(str[]){ // By Luby
        return strval(str);
}