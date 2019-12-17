#include <a_samp>

#define BOT_DISTANCE 0.6
#define BOT_CALC 100

new Float:posar[3][MAX_PLAYERS];
new SpeedBotUse[MAX_PLAYERS];

forward BotPlayerToPoint(Float:radi, botid, Float:x, Float:y, Float:z);
forward SpeedBot(botid);

stock SetAngleBot(botid,Float:x,Float:y,&Float:z)
{
        new Float:xo,Float:yo,Float:zo;
        GetPlayerPos(botid,xo,yo,zo);
        x = x -xo;
        y = y -yo;
        new Float:Rot = atan2(y,x);
        SetPlayerFacingAngle(botid,Rot+270);
}

stock SetBotSpeed(botid,Float:x,Float:y,&Float:z)
{
        posar[0][botid]=x;
        posar[1][botid]=y;
        posar[2][botid]=z;
        new Float:xo,Float:yo,Float:zo;
        GetPlayerPos(botid,xo,yo,zo);
        SetAngleBot(botid,x,y,z);
        GetXYInFrontOfBot(botid,xo,yo,BOT_DISTANCE);
        if(SpeedBotUse[botid]==0)
        {
                SetTimerEx("SpeedBot",BOT_CALC,0,"d",botid);
        }
        SpeedBotUse[botid]=1;

        ApplyAnimation(botid,"PED","WALK_player",4.1,1,1,1,1,1);

}

stock StopBotSpeed(botid)
{
        SpeedBotUse[botid]=0;
        ApplyAnimation(botid,"PED","WALK_player",4.0,0,0,0,0,1);
}

stock GetXYInFrontOfBot(botid,&Float:x,&Float:y,Float:dis)
{
        new Float:pos[3];
        new Float:A;
        GetPlayerPos(botid,pos[0],pos[1],pos[2]);
        GetPlayerFacingAngle(botid,A);
        GetXYInFrontOfPointBot(botid,pos[0],pos[1],x,y,A,dis);
}

stock GetXYInFrontOfPointBot(botid,Float:x,Float:y,&Float:x2,&Float:y2,Float:A,Float:distance)
{
        new Float:pos[3];
        x2 = x + (distance * floatsin(-A,degrees));
        y2 = y + (distance * floatcos(-A,degrees));

        GetPlayerPos(botid,pos[0],pos[1],pos[2]);
        SetPlayerPos(botid,x2,y2,pos[2]);
}

public SpeedBot(botid)
{
    if(SpeedBotUse[botid]==1)
    {
                if(BotPlayerToPoint(BOT_DISTANCE,botid,posar[0][botid],posar[1][botid],posar[2][botid]))
                {
                        SpeedBotUse[botid]=0;
                ApplyAnimation(botid,"PED","WALK_player",4.0,0,0,0,0,1);
                }
        else
        {
                        new Float:pos[3];
                        GetPlayerPos(botid,pos[0],pos[1],pos[2]);
                        GetXYInFrontOfBot(botid,pos[0],pos[1],BOT_DISTANCE);
                SetTimerEx("SpeedBot",BOT_CALC,0,"d",botid);
        }



    }
}

public BotPlayerToPoint(Float:radi, botid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(botid))
        {
                new Float:oldposx, Float:oldposy, Float:oldposz;
                new Float:tempposx, Float:tempposy, Float:tempposz;
                GetPlayerPos(botid, oldposx, oldposy, oldposz);
                tempposx = (oldposx -x);
                tempposy = (oldposy -y);
                tempposz = (oldposz -z);
                if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
                {
                        return 1;
                }
        }
        return 0;
}