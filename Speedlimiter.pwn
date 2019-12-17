new pSpeedLimit[MAX_PLAYERS]={-1,...};
new Float:gTempFloat[4];
public OnPlayerConnect(playerid)
{
    pSpeedLimit[playerid]=-1;
    return 1;
}
public OnPlayerCommandText(playerid,cmdtext[])
{
    if(!strcmp(cmdtext[1],"setlimit",true,8))
    {
        pSpeedLimit[playerid]=strval(cmdtext[10]);
        return SendClientMessage(playerid,0x99CC9900,"    Speed Limit Set");
    }
}
public OnPlayerUpdate(playerid)
{
    if(pSpeedLimit[playerid]>-1)
    {
        GetVehicleVelocity(GetPlayerVehicleID(playerid),gFloatTemp[0],gFloatTemp[1],gFloatTemp[2]);
        gFloatTemp[3]=(floatsqroot(gFloatTemp[0]*gFloatTemp[0]+gFloatTemp[1]*gFloatTemp[1]+gFloatTemp[2]*gFloatTemp[2])*100)/pSpeedLimit[playerid];
        if(gFloatTemp[3]>1)SetVehicleVelocity(GetPlayerVehicleID(playerid),gFloatTemp[0]/gFloatTemp[3],gFloatTemp[1]/gFloatTemp[3],gFloatTemp[2]/gFloatTemp[3]);
    }
    return 1;
}


// ODER

#define MAX_SPEED 0.7
#define SLOW_FACTOR 0.7

forward Timer();

public OnFilterScriptInit()
{
SetTimer("Timer",1000,1);
return 1;
}

public Timer()
{
    new Float:x,Float:y,Float:z,veh;
	for(new i; i<MAX_PLAYERS; i++){
        veh=GetPlayerVehicleID(i);
		GetVehicleVelocity(veh,x,y,z);
		if((x > MAX_SPEED || x < -MAX_SPEED) || (y > MAX_SPEED || y < -MAX_SPEED)){
			SetVehicleVelocity(veh,x*SLOW_FACTOR,y*SLOW_FACTOR,z);
		}
	}
}