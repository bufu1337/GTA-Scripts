// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERSCRIPT

#include <a_samp>

#define COLOR1 0x00FFFFFF

#define FILTERSCRIPT

new Lights[MAX_PLAYERS];
new Trunk[MAX_PLAYERS];
new Hood[MAX_PLAYERS];
new Alarm[MAX_PLAYERS];
new Engine[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
	Lights[playerid]=0;
	Trunk[playerid]=0;
	Hood[playerid]=0;
	Alarm[playerid]=0;
	Engine[playerid]=0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	Lights[playerid]=0;
	Trunk[playerid]=0;
	Hood[playerid]=0;
	Alarm[playerid]=0;
	Engine[playerid]=0;
	return 1;
}

public OnFilterScriptInit()
{
	print("\n----------------------------------");
	print(" Car System by Axel/TLG - True Life Gaming");
	print(" www.truelifegaming.at.ua");
	print(" Official TLG Roleplay Website");
	print("----------------------------------\n");
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		if (strcmp("/car", cmdtext, true, 10) == 0)
		{
	    	ShowPlayerDialog(playerid, 1000, DIALOG_STYLE_LIST, "Vehicle Controls", "Engine\nLights\nTrunk\nHood\nAlarm", "Select", "Cancel");
		}
		return 1;
	}
	else
	{
	    SendClientMessage(playerid, COLOR1, "You are not in a vehicle!");
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(response)
	{
	    switch(dialogid)
		{
			case 1000:
			{
				switch(listitem)
				{
				    case 0:
				    {
				        ShowPlayerDialog(playerid, 999, DIALOG_STYLE_LIST, "Vehicle Controls", "On\nOff", "Select", "Cancel");
					}
		    		case 1:
		    		{
		        		ShowPlayerDialog(playerid, 1001, DIALOG_STYLE_LIST, "Vehicle Controls", "On\nOff", "Select", "Cancel");
					}
					case 2:
					{
		 				ShowPlayerDialog(playerid, 1002, DIALOG_STYLE_LIST, "Vehicle Controls", "Open\nClose", "Select", "Cancel");
					}
					case 3:
					{
			    		ShowPlayerDialog(playerid, 1003, DIALOG_STYLE_LIST, "Vehicle Controls", "Open\nClose", "Select", "Cancel");
					}
					case 4:
					{
			    		ShowPlayerDialog(playerid, 1004, DIALOG_STYLE_LIST, "Vehicle Controls", "On\nOff", "Select", "Cancel");
					}
				}
			}
			case 999:
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(Engine[playerid]==0)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned your engine on!");
							Engine[playerid]=1;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're engine is already on!");
						}
					}
					case 1:
					{
					    if(Engine[playerid]==1)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned your engine off!");
							Engine[playerid]=0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're engine already off!");
						}
					}
				}
			}
			case 1001:
			{
	   		 	switch(listitem)
	    		{
	        		case 0:
	        		{
						if(Lights[playerid]==0)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_ON,alarm,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned your lights on!");
							Lights[playerid]=1;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're lights are already on!");
						}
					}
					case 1:
					{
					    if(Lights[playerid]==1)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,VEHICLE_PARAMS_OFF,alarm,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned your lights off!");
							Lights[playerid]=0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're lights are already off!");
						}
					}
				}
			}
			case 1002:
			{
	   		 	switch(listitem)
	    		{
	        		case 0:
	        		{
						if(Trunk[playerid]==0)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_ON,objective);
							SendClientMessage(playerid, COLOR1, "You have opened your trunk!");
							Trunk[playerid]=1;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're trunk is already open!");
						}
					}
					case 1:
					{
					    if(Trunk[playerid]==1)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,VEHICLE_PARAMS_OFF,objective);
							SendClientMessage(playerid, COLOR1, "You have closed your trunk!!");
							Trunk[playerid]=0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're trunk is already closed!");
						}
					}
				}
			}
			case 1003:
			{
	   		 	switch(listitem)
	    		{
	        		case 0:
	        		{
						if(Hood[playerid]==0)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_ON,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have opened your hood!");
							Hood[playerid]=1;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're hood is already open!");
						}
					}
					case 1:
					{
					    if(Hood[playerid]==1)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,alarm,doors,VEHICLE_PARAMS_OFF,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have closed your hood!");
							Hood[playerid]=0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're hood is already closed!");
						}
					}
				}
			}
			case 1004:
			{
	   		 	switch(listitem)
	    		{
	        		case 0:
	        		{
						if(Alarm[playerid]==0)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,VEHICLE_PARAMS_ON,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned on your vehicles alarm!");
							Alarm[playerid]=1;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're alarm is already on!");
						}
					}
					case 1:
					{
					    if(Alarm[playerid]==1)
						{
							new veh = GetPlayerVehicleID(playerid);
							new engine,lights,alarm,doors,bonnet,boot,objective;
							GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(veh,engine,lights,VEHICLE_PARAMS_OFF,doors,bonnet,boot,objective);
							SendClientMessage(playerid, COLOR1, "You have turned off your vehicle alarm!");
							Alarm[playerid]=0;
							return 1;
						}
						else
						{
						    SendClientMessage(playerid, COLOR1, "You're alarm is already off!");
						}
					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPlayerState(playerid) == 2)
	{
	    new veh = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(veh,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
		Engine[playerid]=0;
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT)
	{
	    new veh = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(veh,engine,lights,VEHICLE_PARAMS_OFF,doors,bonnet,boot,objective);
		Alarm[playerid]=0;
	}
	if(GetPlayerState(playerid) == 2 && newstate == PLAYER_STATE_ONFOOT)
	{
	    new veh = GetPlayerVehicleID(playerid);
		new engine,lights,alarm,doors,bonnet,boot,objective;
		GetVehicleParamsEx(veh,engine,lights,alarm,doors,bonnet,boot,objective);
		SetVehicleParamsEx(veh,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
		Engine[playerid]=0;
	}
	return 1;
}
