/*==============================================================================
----------------------------Leviathan Magnet by De4dpOol------------------------
==============================================================================*/
//============= PS Leviathan or Laviathan? I am confused :/ ==================//

//Include(s)//
#include <a_samp>
#include <mapandreas>

//Define(s)//
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

//New(s)//
new MagnetObject[MAX_VEHICLES];
new RopeObject[MAX_VEHICLES];
new LeviathanCarryingVehicle[MAX_VEHICLES] = 0;
new AttachVehicleTimer[MAX_VEHICLES];
new Float:RopeZPos[MAX_VEHICLES];
new MoveUpTimer[MAX_PLAYERS];
new MoveDownTimer[MAX_PLAYERS];
new MovingUp[MAX_PLAYERS];
new MovingDown[MAX_PLAYERS];

//Forward(s)//
forward StartUpdatingVehicle(vehicleid, leviathanid);
forward MoveRopeUp(playerid, vehicleid);
forward MoveRopeDown(playerid, vehicleid);

//Public(s)//
public OnFilterScriptInit()
{
    //Create Leviathan here
	CreateVehicle(417, 0.0000, 0.0000, 3.0000, 0.0000, 1, 1, 0);

	//Attach megnet to every leviathan
	for(new i = 0; i < MAX_VEHICLES; i ++)
    {
        if (GetVehicleModel(i) == 417)
        {
			RopeZPos[i] = 1.000;
			RopeObject[i] = CreateObject(19087, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
			MagnetObject[i] = CreateObject(3053, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);

			AttachObjectToVehicle(RopeObject[i], i, 0.0000, 0.0000, RopeZPos[i], 0.0000, 0.0000, 0.0000);
			AttachObjectToObject(MagnetObject[i], RopeObject[i], 0.0000, 0.0000, -2.3000, 0.0000, 0.0000, 0.0000);
        }
    }

    MapAndreas_Init(MAP_ANDREAS_MODE_FULL);

	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_VEHICLES; i ++)
    {
        if (GetVehicleModel(i) == 417)//if player is in a Leviathan
        {
            if(LeviathanCarryingVehicle[i] == 1)//if the leviathan is carrying a vehicle
            {
                KillTimer(AttachVehicleTimer[i]);
                LeviathanCarryingVehicle[i] = 0;
                DestroyObject(RopeObject[i]);
                DestroyObject(MagnetObject[i]);
                return 1;
            }
        }
    }
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))//if he is a driver
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)//if player is in a Leviathan
        {
            if(LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] == 1)//if the leviathan is carrying a vehicle
            {
			    KillTimer(AttachVehicleTimer[GetPlayerVehicleID(playerid)]);
                LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] = 0;
                return 1;
            }
        }
    }
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
    if (GetVehicleModel(vehicleid) == 417)//if player is in a Leviathan
    {
        if((!IsValidObject(RopeObject[vehicleid])) && (!IsValidObject(MagnetObject[vehicleid])))
        {
			RopeObject[vehicleid] = CreateObject(19087, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
			MagnetObject[vehicleid] = CreateObject(3053, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000);
			AttachObjectToVehicle(RopeObject[vehicleid], vehicleid, 0.0000, 0.0000, -0.5000, 0.0000, 0.0000, 0.0000);
			AttachObjectToObject(MagnetObject[vehicleid], RopeObject[vehicleid], 0.0000, 0.0000, -2.3000, 0.0000, 0.0000, 0.0000);
            return 1;
        }
    }
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    if (GetVehicleModel(vehicleid) == 417)//if player is in a Leviathan
    {
        if(LeviathanCarryingVehicle[vehicleid] == 1)//if the leviathan is carrying a vehicle
        {
            KillTimer(AttachVehicleTimer[vehicleid]);
            LeviathanCarryingVehicle[vehicleid] = 0;
            DestroyObject(RopeObject[vehicleid]);
            DestroyObject(MagnetObject[vehicleid]);
            return 1;
        }
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)//if player is in a Leviathan
        {
            if(LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] == 1)//if the leviathan is carrying a vehicle
            {
			    KillTimer(AttachVehicleTimer[GetPlayerVehicleID(playerid)]);
                LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] = 0;
                return 1;
            }
        }
    }
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if((newkeys == KEY_CROUCH) && (IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER))
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)//if player is in a Leviathan
        {
            new Float:pX,Float:pY,Float:pZ;
            GetVehiclePos(GetPlayerVehicleID(playerid),pX,pY,pZ);
            new Float:vX,Float:vY,Float:vZ;
		    new Found=0;
			new vid=0;
            while((vid<MAX_VEHICLES)&&(!Found))
            {
                vid++;
                GetVehiclePos(vid,vX,vY,vZ);
                if((floatabs(pX-vX)<2.0)&&(floatabs(pY-vY)<2.0)&&(floatabs((pZ+RopeZPos[GetPlayerVehicleID(playerid)]-3.4)-vZ)<2.0)&&(vid!=GetPlayerVehicleID(playerid)))
                {
                    Found=1;
                    if(LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] == 1)
                    {
						KillTimer(AttachVehicleTimer[GetPlayerVehicleID(playerid)]);
                        LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] = 0;
                        GameTextForPlayer(playerid, "~w~Vehicle ~r~Dropped", 1000, 3);
                        return 1;
					}
                    if(!IsACar(vid)) return GameTextForPlayer(playerid, "~w~Can Carry ~g~Cars Only", 1000, 3);
				    AttachVehicleTimer[GetPlayerVehicleID(playerid)] = SetTimerEx("StartUpdatingVehicle", 50, 1, "ii", vid, GetPlayerVehicleID(playerid));
                    LeviathanCarryingVehicle[GetPlayerVehicleID(playerid)] = 1;
                    GameTextForPlayer(playerid, "~w~Vehicle ~g~Attached", 1000, 3);
			    }
                if(!Found)
                {
					//Uncommenting the line below sends the message a lot of times so don't send message here, do it outside loop//
                    //SendClientMessage(playerid, -1,"There is no vehicle in range.");
                }
            }
        }
    }
	else if(HOLDING(KEY_YES))
	{
        if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (MovingUp[playerid] == 0))
        {
            if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)
            {
                MovingUp[playerid] = 1;
	        	MoveUpTimer[playerid] = SetTimerEx("MoveRopeUp", 200, 1, "ii", playerid, GetPlayerVehicleID(playerid));
	        }
	    }
	}
	else if(RELEASED(KEY_YES))
	{
        if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (MovingUp[playerid] == 1))
        {
            if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)
            {
				MovingUp[playerid] = 0;
	        	KillTimer(MoveUpTimer[playerid]);
	        }
	    }
	}
	else if(HOLDING(KEY_NO))
	{
        if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (MovingDown[playerid] == 0))
        {
            if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)
            {
                MovingDown[playerid] = 1;
	        	MoveDownTimer[playerid] = SetTimerEx("MoveRopeDown", 200, 1, "ii", playerid, GetPlayerVehicleID(playerid));
	        }
	    }
	}
	else if(RELEASED(KEY_NO))
	{
        if((IsPlayerInAnyVehicle(playerid)) && (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (MovingDown[playerid] == 1))
        {
            if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 417)
            {
                MovingDown[playerid] = 0;
	        	KillTimer(MoveDownTimer[playerid]);
	        }
	    }
	}
    return 1;
}

public StartUpdatingVehicle(vehicleid, leviathanid)
{
	new Float:MagX, Float:MagY, Float:MagZ;
	new Float:MagRZ; new Float:MaxZ;
	GetVehiclePos(leviathanid, MagX, MagY, MagZ);
	GetVehicleZAngle(leviathanid, MagRZ);
	SetVehiclePos(vehicleid, MagX, MagY, MagZ + RopeZPos[leviathanid] - 3.4);
	SetVehicleZAngle(vehicleid, MagRZ);
    MapAndreas_SetZ_For2DCoord(MagX, MagY, MaxZ);
	if(MaxZ > MagZ + RopeZPos[leviathanid] - 3.6) SetVehicleVelocity(leviathanid, 0.0, 0.0, 0.5), GameTextForPlayer(VehicleDriver(leviathanid), "~w~Vehicle ~r~Touching Ground", 1000, 3);
}

public MoveRopeDown(playerid, vehicleid)
{
	if(RopeZPos[vehicleid] <= -0.5000) return KillTimer(MoveDownTimer[playerid]), MovingDown[playerid] = 0;
	RopeZPos[vehicleid] = RopeZPos[vehicleid] - 0.1;
	AttachObjectToVehicle(RopeObject[vehicleid], vehicleid, 0.0000, 0.0000, RopeZPos[vehicleid], 0.0000, 0.0000, 0.0000);
	return 1;
}

public MoveRopeUp(playerid, vehicleid)
{
	if(RopeZPos[vehicleid] >= 1.0000) return KillTimer(MoveUpTimer[playerid]), MovingUp[playerid] = 0;
	RopeZPos[vehicleid] = RopeZPos[vehicleid] + 0.1;
	AttachObjectToVehicle(RopeObject[vehicleid], vehicleid, 0.0000, 0.0000, RopeZPos[vehicleid], 0.0000, 0.0000, 0.0000);
	return 1;
}

VehicleDriver(vehicleid)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(GetPlayerVehicleID(i) == vehicleid && GetPlayerState(i) == PLAYER_STATE_DRIVER) return i;
	}
	return -1;
}

IsACar(vehicleid) //By YellowBlood
{
   	switch(GetVehicleModel(vehicleid))
	{
    	case
    	416,   //ambulan  -  car
    	445,   //admiral  -  car
    	602,   //alpha  -  car
    	485,   //baggage  -  car
    	568,   //bandito  -  car
    	429,   //banshee  -  car
    	499,   //benson  -  car
    	424,   //bfinject,   //car
    	536,   //blade  -  car
    	496,   //blistac  -  car
    	504,   //bloodra  -  car
    	422,   //bobcat  -  car
    	609,   //boxburg  -  car
    	498,   //boxville,   //car
        401,   //bravura  -  car
    	575,   //broadway,   //car
    	518,   //buccanee,   //car
    	402,   //buffalo  -  car
    	541,   //bullet  -  car
    	482,   //burrito  -  car
    	431,   //bus  -  car
    	438,   //cabbie  -  car
    	457,   //caddy  -  car
    	527,   //cadrona  -  car
    	483,   //camper  -  car
    	524,   //cement  -  car
    	415,   //cheetah  -  car
    	542,   //clover  -  car
    	589,   //club  -  car
    	480,   //comet  -  car
    	596,   //copcarla,   //car
    	599,   //copcarru,   //car
    	597,   //copcarsf,   //car
    	598,   //copcarvg,   //car
    	578,   //dft30  -  car
    	486,   //dozer  -  car
    	507,   //elegant  -  car
    	562,   //elegy  -  car
    	585,   //emperor  -  car
    	427,   //enforcer,   //car
    	419,   //esperant,   //car
    	587,   //euros  -  car
    	490,   //fbiranch,   //car
     	528,   //fbitruck,   //car
    	533,   //feltzer  -  car
    	544,   //firela  -  car
    	407,   //firetruk,   //car
    	565,   //flash  -  car
    	455,   //flatbed  -  car
    	530,   //forklift,   //car
    	526,   //fortune  -  car
    	466,   //glendale,   //car
    	604,   //glenshit,   //car
    	492,   //greenwoo,   //car
    	474,   //hermes  -  car
    	434,   //hotknife,   //car
    	502,   //hotrina  -  car
    	503,   //hotrinb  -  car
    	494,   //hotring  -  car
    	579,   //huntley  -  car
    	545,   //hustler  -  car
    	411,   //infernus,   //car
    	546,   //intruder,   //car
    	559,   //jester  -  car
    	508,   //journey  -  car
    	571,   //kart  -  car
    	400,   //landstal,   //car
    	403,   //linerun  -  car
    	517,   //majestic,   //car
    	410,   //manana  -  car
    	551,   //merit  -  car
    	500,   //mesa  -  car
    	418,   //moonbeam,   //car
    	572,   //mower  -  car
    	423,   //mrwhoop  -  car
    	516,   //nebula  -  car
    	582,   //newsvan  -  car
    	467,   //oceanic  -  car
    	404,   //peren  -  car
    	514,   //petro  -  car
    	603,   //phoenix  -  car
    	600,   //picador  -  car
    	413,   //pony  -  car
    	426,   //premier  -  car
    	436,   //previon  -  car
    	547,   //primo  -  car
    	489,   //rancher  -  car
    	441,   //rcbandit,   //car
    	594,   //rccam  -  car
    	564,   //rctiger  -  car
    	515,   //rdtrain  -  car
    	479,   //regina  -  car
	    534,   //remingtn,   //car
    	505,   //rnchlure,   //car
	    442,   //romero  -  car
    	440,   //rumpo  -  car
    	475,   //sabre  -  car
    	543,   //sadler  -  car
    	605,   //sadlshit,   //car
    	495,   //sandking,   //car
    	567,   //savanna  -  car
    	428,   //securica,   //car
    	405,   //sentinel,   //car
    	535,   //slamvan  -  car
    	458,   //solair  -  car
    	580,   //stafford,   //car
    	439,   //stallion,   //car
    	561,   //stratum  -  car
    	409,   //stretch  -  car
    	560,   //sultan  -  car
    	550,   //sunrise  -  car
    	506,   //supergt  -  car
    	601,   //swatvan  -  car
    	574,   //sweeper  -  car
    	566,   //tahoma  -  car
    	549,   //tampa  -  car
    	420,   //taxi  -  car
    	459,   //topfun  -  car
    	576,   //tornado  -  car
    	583,   //tug  -  car
    	451,   //turismo  -  car
    	558,   //uranus  -  car
    	552,   //utility  -  car
    	540,   //vincent  -  car
    	491,   //virgo  -  car
    	412,   //voodoo  -  car
    	478,   //walton  -  car
    	421,   //washing  -  car
    	529,   //willard  -  car
    	555,   //windsor  -  car
    	456,   //yankee  -  car
    	554,   //yosemite -  car
    	477   //zr350  -  car
    	: return 1;
    }
    return 0;
}
/*==============================================================================
----------------------------------End of Script---------------------------------
==============================================================================*/