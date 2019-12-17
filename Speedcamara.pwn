/*
	gCamera - Speedcamera in SA-MP WITH FLASH EFFECT!
	V1.0 - Released on 09-04-2011
	©Gamer931215

	Use at own risk, do NOT re-release,mirror,sell it or even worse: clame this as your own!
*/
#include <a_samp>
#if !defined CAMERA_LIMIT
	#define CAMERA_LIMIT 100
#endif
#if !defined CAMERA_UPDATE_INTERVAL
	#define CAMERA_UPDATE_INTERVAL 750
#endif
#if !defined CAMERA_FLASH_TIME
	#define CAMERA_FLASH_TIME 1200
#endif
/*
		native CreateSpeedCam(Float:x,Float:y,Float:z,Float:rot,range,limit,fine,use_mph = 0)
		native SetSpeedCamRange(cameraid,limit)
		native SetSpeedCamFine(cameraid,fine)
		native DestroySpeedCam(cameraid)
*/
//===================================================================================================
//                                         	  Variables
//===================================================================================================
enum _camera
{
	Float:_x,
	Float:_y,
	Float:_z,
	Float:_rot,
	_range,
	_limit,
	_fine,
	_usemph,
	_objectid,
	bool:_active
}
new SpeedCameras[CAMERA_LIMIT][_camera],currentid = -1,Text:flash;
//===================================================================================================
//                      					  Functions
//===================================================================================================
stock CreateSpeedCam(Float:x,Float:y,Float:z,Float:rot,range,limit,fine,use_mph = 0)
{
	if(currentid +1 > CAMERA_LIMIT)
	{
	    print("gSpeedcam: ERROR! Cannot create speedcam, max ammount of speedcameras has been reached!");
	    return -1;
	}
	currentid++;
	SpeedCameras[currentid][_x] = x;
	SpeedCameras[currentid][_y] = y;
	SpeedCameras[currentid][_z] = z;
	SpeedCameras[currentid][_rot] = rot;
	SpeedCameras[currentid][_range] = range;
	SpeedCameras[currentid][_limit] = limit;
	SpeedCameras[currentid][_fine] = fine;
	SpeedCameras[currentid][_usemph] = use_mph;
	SpeedCameras[currentid][_objectid] = CreateObject(18880,x,y,z,0,0,rot);
	SpeedCameras[currentid][_active] = true;
	return currentid;
}
stock DestroySpeedCam(cameraid)
{
    SpeedCameras[cameraid][_active] = false;
    DestroyObject(SpeedCameras[cameraid][_objectid]);
	return 1;
}
stock SetSpeedCamRange(cameraid,limit)
{
	SpeedCameras[cameraid][_limit] = limit;
	return 1;
}
stock SetSpeedCamFine(cameraid,fine)
{
    SpeedCameras[cameraid][_fine] = fine;
	return 1;
}
//===================================================================================================
//                                            Initialize
//===================================================================================================
#if defined FILTERSCRIPT
	public OnFilterScriptInit()
	{
		SetTimer("UpdateCameras",CAMERA_UPDATE_INTERVAL,true);
		flash = TextDrawCreate(-20.000000,2.000000,"|");
		TextDrawUseBox(flash,1);
		TextDrawBoxColor(flash,0xffffff66);
		TextDrawTextSize(flash,660.000000,22.000000);
		TextDrawAlignment(flash,0);
		TextDrawBackgroundColor(flash,0x000000ff);
		TextDrawFont(flash,3);
		TextDrawLetterSize(flash,1.000000,52.200000);
		TextDrawColor(flash,0xffffffff);
		TextDrawSetOutline(flash,1);
		TextDrawSetProportional(flash,1);
		TextDrawSetShadow(flash,1);
		return CallLocalFunction("speedcam_init","");
	}
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit speedcam_init
	forward speedcam_init();
#else
	public OnGameModeInit()
	{
		SetTimer("UpdateCameras",CAMERA_UPDATE_INTERVAL,true);
		flash = TextDrawCreate(-20.000000,2.000000,"|");
		TextDrawUseBox(flash,1);
		TextDrawBoxColor(flash,0xffffff66);
		TextDrawTextSize(flash,660.000000,22.000000);
		TextDrawAlignment(flash,0);
		TextDrawBackgroundColor(flash,0x000000ff);
		TextDrawFont(flash,3);
		TextDrawLetterSize(flash,1.000000,52.200000);
		TextDrawColor(flash,0xffffffff);
		TextDrawSetOutline(flash,1);
		TextDrawSetProportional(flash,1);
		TextDrawSetShadow(flash,1);
		return CallLocalFunction("speedcam_init","");
	}
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit speedcam_init
	forward speedcam_init();
#endif
//===================================================================================================
//                                          Internal Functions
//===================================================================================================
stock Float:GetVehicleSpeed(vehicleid,UseMPH = 0)
{
	new Float:speed_x,Float:speed_y,Float:speed_z,Float:temp_speed;
	GetVehicleVelocity(vehicleid,speed_x,speed_y,speed_z);
	if(UseMPH == 0)
	{
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*136.666667;
	} else {
	    temp_speed = floatsqroot(((speed_x*speed_x)+(speed_y*speed_y))+(speed_z*speed_z))*85.4166672;
	}
	floatround(temp_speed,floatround_round);return temp_speed;
}
stock SendClientMessageEx(playerid,color,type[],{Float,_}:...)
{
	new string[128];
	for(new i = 0;i<numargs() -2;i++)
	{
	    switch(type[i])
	    {
	        case 's':
	        {
				new result[128];
				for(new a= 0;getarg(i +3,a) != 0;a++)
				{
				    result[a] = getarg(i +3,a);
				}
				if(!strlen(string))
				{
				    format(string,sizeof string,"%s",result);
				} else format(string,sizeof string,"%s%s",string,result);
	        }

	        case 'i':
	        {
	            new result = getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%i",result);
				} else format(string,sizeof string,"%s%i",string,result);
	        }

	        case 'f':
	        {
				new Float:result = Float:getarg(i +3);
				if(!strlen(string))
				{
				    format(string,sizeof string,"%f",result);
				} else format(string,sizeof string,"%s%f",string,result);
	        }
	    }
	}
    SendClientMessage(playerid,color,string);
    return 1;
}
//===================================================================================================
//                                              Timers
//===================================================================================================
forward UpdateCameras();
public UpdateCameras()
{
	for(new a = 0;a<MAX_PLAYERS;a++)
	{
	    if(!IsPlayerConnected(a)) continue;
	    if(!IsPlayerInAnyVehicle(a)) continue;
	    if(GetPVarInt(a,"PlayerHasBeenFlashed") == 1)
		{
			continue;
		} else if (GetPVarInt(a,"PlayerHasBeenFlashed") == 2)
		{
			DeletePVar(a,"PlayerHasBeenFlashed");
			continue;
		}
	    for(new b = 0;b<currentid +1;b++)
	    {
	        if(SpeedCameras[b][_active] == false) continue;
	        if(IsPlayerInRangeOfPoint(a,SpeedCameras[b][_range],SpeedCameras[b][_x],SpeedCameras[b][_y],SpeedCameras[b][_z]))
	        {
	            new speed = floatround(GetVehicleSpeed(GetPlayerVehicleID(a),SpeedCameras[b][_usemph]));
	            new limit = SpeedCameras[b][_limit];
	            if(speed > limit)
	            {
	                TextDrawShowForPlayer(a,flash);
	                SetPVarInt(a,"PlayerHasBeenFlashed",1);
	                SetTimerEx("RemoveFlash",CAMERA_FLASH_TIME,false,"i",a);
					if(SpeedCameras[b][_usemph] == 0)
					{
						SendClientMessageEx(a,0xFF1E00FF,"sisis","You are driving too fast! you got busted driving ",speed,"kmh where you were allowed to drive ",limit, "kmh.");
						SendClientMessageEx(a,0xFF1E00FF,"sis","You got yourself a fine of $",SpeedCameras[b][_fine],".");
					} else {
						SendClientMessageEx(a,0xFF1E00FF,"sisis","You are driving too fast! you got busted driving ",speed,"mph where you were allowed to drive ",limit, "mph.");
						SendClientMessageEx(a,0xFF1E00FF,"sis","You got yourself a fine of $",SpeedCameras[b][_fine],".");
					}
					GivePlayerMoney(a, - SpeedCameras[b][_fine]);
	            }
	        }
	    }
	}
}
forward RemoveFlash(playerid);
public RemoveFlash(playerid)
{
	TextDrawHideForPlayer(playerid,flash);
	SetPVarInt(playerid,"PlayerHasBeenFlashed",2);
}