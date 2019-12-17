//------------------------------------------------------------------------------
//
//   TowCars Filter Script v1.0
//   Designed for SA-MP v0.2.2
//
//   Created by zeruel_angel
//
//------------------------------------------------------------------------------
#include <a_samp>

new TowTruckers=0;
new IsTowTrucker[MAX_PLAYERS];

public OnFilterScriptInit()
	{
	print("\n TowCars Filter Script v1.0 Loading...\n**********************\n      (Zeruel_Angel)\n");

	print("TowCars Filter Script fully Loaded\n**********************************\n\n");
	}
//------------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
	{
    print("\n TowCars Script UnLoaded\n********************************************\n\n");
	return 1;
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
	{
	if	(newstate==PLAYER_STATE_DRIVER)
	    {
		if	(GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
	        {
	        IsTowTrucker[playerid]=1;
	        TowTruckers++;
			SendClientMessage(playerid,0xFFFF00AA,"You can use the ACTION KEY to Tow cars");
		    }
		else
		    {
		    if	(TowTruckers>0)
		        {
		    	SendClientMessage(playerid,0xFFFF00AA,"If you have a problem with your car, use /TowMe to call a TowTruker");
		    	}
		    }
	    }
	if 	((newstate==PLAYER_STATE_ONFOOT)&&(IsTowTrucker[playerid]==1))
	    {
	    IsTowTrucker[playerid]=0;
	    TowTruckers--;
	    }
	if 	((newstate==PLAYER_STATE_PASSENGER)&&(TowTruckers>0))
        {
    	SendClientMessage(playerid,0xFFFF00AA,"If you have a problem with your car, use /TowMe to call a TowTruker");
    	}
	return 1;
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
	if ((newkeys==KEY_ACTION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
	    {
	    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
	        {
	        SendClientMessage(playerid,0xFFFF00AA,"trying to tow a car");
			new Float:pX,Float:pY,Float:pZ;
			GetPlayerPos(playerid,pX,pY,pZ);
			new Float:vX,Float:vY,Float:vZ;
			new Found=0;
			new vid=0;
			while((vid<MAX_VEHICLES)&&(!Found))
   				{
   				vid++;
   				GetVehiclePos(vid,vX,vY,vZ);
   				if  ((floatabs(pX-vX)<7.0)&&(floatabs(pY-vY)<7.0)&&(floatabs(pZ-vZ)<7.0)&&(vid!=GetPlayerVehicleID(playerid)))
   				    {
   				    Found=1;
   				    if	(IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid)))
   				        {
   				        DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
   				        }
   				    AttachTrailerToVehicle(vid,GetPlayerVehicleID(playerid));
   				    SendClientMessage(playerid,0xFFFF00AA,"Car towed!");
   				    }
       			}
			if  (!Found)
			    {
			    SendClientMessage(playerid,0xFFFF00AA,"There is no car in range.");
			    }
		    }
	    }
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
	{
	if 	(IsTowTrucker[playerid]==1)
	    {
	    IsTowTrucker[playerid]=0;
	    TowTruckers--;
	    }
	return 1;
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid,cmdtext[])
	{
	if	(strcmp(cmdtext, "/TowMe", true)==0)
		{
		if  (TowTruckers==0)
		    {
		    SendClientMessage(playerid,0xFFFF00AA,"Sorry there isn't any TowTrucker Available at the moment");
		    return 1;
		    }
        SendClientMessage(playerid,0xFFFF00AA,"TowTruckers has been told of your situation, just wait.");
        SendClientMessage(playerid,0xFFFF00AA,"REMEMBER: Your car can't be towed if you are sitting as the driver");
		new pName[MAX_PLAYER_NAME];
		new msg[256];
		format(msg,sizeof(msg),"*** %s (id:%d) Need to be Towed ***",pName,playerid);
		GetPlayerName(playerid,pName,sizeof(pName));
		for (new i=0;i<MAX_PLAYERS;i++)
		    {
		    if 	(IsTowTrucker[i]==1)
		        {
		        SendClientMessage(i,0xFFFF00AA,msg);
		        }
		    }
		return 1;
		}
	return 0;
	}
