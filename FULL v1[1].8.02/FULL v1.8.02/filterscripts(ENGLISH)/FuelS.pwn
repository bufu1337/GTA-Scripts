//------------------------------------------------------------------------------
//
//   Fuel system + speedoMeter Filter Script v1.8
//   Designed for SA-MP v0.2.2
//
//   Created by zeruel_angel translated by GTAIV
//   http://forum.sa-mp.com/index.php?topic=27691.0
//------------------------------------------------------------------------------

#include <a_samp>

#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_BLUE 0xAA33AA33
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA

#define FULLTANK 120
#define PRECIOLITRO 20
#define MAX_GAS 50
#define MIN_GAS 10
#define RAND_GAS 20

new CheckpointsComb[]="FuelSystem.txt";
new CantidadCombCheckp;
new Float:checkGas[MAX_GAS][4];
new Text:medidorTanque[MAX_PLAYERS];
new combustible[MAX_VEHICLES];
new SinGas[MAX_PLAYERS];
new Menu:MenuGas;
enum SavePlayerPosEnum
{
    Float:LastX,
    Float:LastY,
    Float:LastZ
}

new SavePlayerPos[MAX_PLAYERS][SavePlayerPosEnum];
new TankString[MAX_PLAYERS][255];
new SpeedString[MAX_PLAYERS][255];
new Float:Kilometers[MAX_PLAYERS];

new Configuration[]="FuelConf.txt";
new CheckpointsSTATUS;
new CommandsSTATUS;

forward Speedometer();
forward Float:GetDistanceToPoint(playerid,Float:x2,Float:y2,Float:z2);
forward ConsumirCombustible();
forward Float:checkpointGAScheck(player,Float:distOld2);

//-----------------------------------------------------------------------------------------------------

public OnFilterScriptInit()
	{
	print("\n FuelSystem Filter Script v1.8 Loading...\n**********************\n      (Zeruel_Angel)\n");
	new i;
	for (i=0;i<MAX_VEHICLES;i++)
	    {
	    combustible[i]=random(RAND_GAS)+MIN_GAS;
	    }
	//cargo los checkpoints desde el archivo
	new linea[255];
	new File:file1;
 	new j=0;
 	new idx;
   	file1 = fopen(CheckpointsComb,io_readwrite);
 	while	((fread(file1,linea,sizeof(linea),false))&&(j<MAX_GAS))
			{
	  		idx = 0;
            checkGas[j][0] = floatstr(strtok(linea,idx));
			checkGas[j][1] = floatstr(strtok(linea,idx));
			checkGas[j][2] = floatstr(strtok(linea,idx));
			checkGas[j][3] = floatstr(strtok(linea,idx));
			j++;
			}
	fclose(file1);
	CantidadCombCheckp=j;
	//Cargo las configuraciones del archivo
 	j=0;
   	file1 = fopen(Configuration,io_readwrite);
 	while	(fread(file1,linea,sizeof(linea),false))
			{
	  		idx = 0;
			strtok(linea,idx);//salteo el tag
			CheckpointsSTATUS = strval(strtok(linea,idx));
			strtok(linea,idx);//salteo el tag
			CommandsSTATUS = strval(strtok(linea,idx));
			}
	fclose(file1);
	
	//inicializo el sistema de combustible.
	SetTimer("ConsumirCombustible",60000,1);
	//inicio el speedometer
	SetTimer("Speedometer",500,1);
	//Creo el menu para la estacion de servicio
	MenuGas = CreateMenu("GasStation",2,25.0,200.0,105.0,0.0);
	AddMenuItem(MenuGas,0,"FULL Tank");
	AddMenuItem(MenuGas,0,"HALF Tank");
	AddMenuItem(MenuGas,0,"Salir");
	for (i=0;i<MAX_PLAYERS;i++)
	    {
   		medidorTanque[i] = TextDrawCreate(508.0,127.0,"Fuel:000 Km_h:000");
		TextDrawUseBox(medidorTanque[i],1);
		TextDrawBoxColor(medidorTanque[i],0x000000cc);
		TextDrawTextSize(medidorTanque[i],602.0,0.0);
		TextDrawAlignment(medidorTanque[i],0);
		TextDrawBackgroundColor(medidorTanque[i],0x000000ff);
		TextDrawFont(medidorTanque[i],3);
		TextDrawLetterSize(medidorTanque[i],0.6,1.0);
		TextDrawColor(medidorTanque[i],0x00ff0066);
		TextDrawSetProportional(medidorTanque[i],0);
		TextDrawSetShadow(medidorTanque[i],1);
		}
    print("\n FuelSystem Filter Script v1.8 Fully loaded Loading...\n**********************\n      (Zeruel_Angel)\n");
	}
//-----------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
	{
    print("\n**********************\n*Fuel System Filter Script UnLoaded*\n**********************\n");
	return 1;
	}
//-----------------------------------------------------------------------------------------------------
  actualizarMedidor(playerid,string[255])
	{
	new tmp[255];
	TankString[playerid]=string;
	format(tmp, sizeof(tmp),"%s %s",TankString[playerid],SpeedString[playerid]);
	TextDrawSetString(medidorTanque[playerid],tmp);
	}
//-----------------------------------------------------------------------------------------------------
public Speedometer()
    {
    new type;
    for (new player=0;player<MAX_PLAYERS;player++)
        {
        if 	((IsPlayerConnected(player))&&(IsPlayerInAnyVehicle(player)))
            {
            new wid = GetPlayerVehicleID(player);
            type=GetVehicleTypeFromId(GetVehicleModel(wid));
            if	((type==1)|(type==2)|(type==3))
                {
                actualizarVelocimetro(player);
                }
			else
			    {
			    actualizarVelocimetro2(player);
			    }
			}
		}
    }
//-----------------------------------------------------------------------------------------------------
  actualizarVelocimetro(playerid)
    {
    new tmp[255];
	new Float:x,Float:y,Float:z;
	new Float:distance,value;
	GetPlayerPos(playerid, x, y, z);
	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[playerid][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[playerid][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[playerid][LastZ])),2));
	SavePlayerPos[playerid][LastX] = x;
    SavePlayerPos[playerid][LastY] = y;
 	SavePlayerPos[playerid][LastZ] = z;
	value = floatround(distance * 11000);
	format(tmp, sizeof(tmp), "Km_h:%d",floatround(value/1400));
	SpeedString[playerid]=tmp;
	format(tmp, sizeof(tmp), "Fuel:%d", combustible[GetPlayerVehicleID(playerid)]);
	actualizarMedidor(playerid,tmp);
	Kilometers[playerid]=Kilometers[playerid]+floatround(value/1400);
	if  (Kilometers[playerid]>3000.0)
	    {
	    Kilometers[playerid]=0.0;
	    if 	(GetPlayerState(playerid)==PLAYER_STATE_DRIVER)
            {
        	combustible[GetPlayerVehicleID(playerid)]--;
        	format(tmp, sizeof(tmp), "Fuel:%d", combustible[GetPlayerVehicleID(playerid)]);
         	if	(combustible[GetPlayerVehicleID(playerid)]<1)
                {
                format(tmp, sizeof(tmp), "EMPTY", combustible[GetPlayerVehicleID(playerid)]);
				SinGas[playerid]=GetPlayerVehicleID(playerid);
				TogglePlayerControllable(playerid,false);
                combustible[GetPlayerVehicleID(playerid)]=0;
                }
        	actualizarMedidor(playerid,tmp);
        	}
	    }
    }
//-----------------------------------------------------------------------------------------------------
  actualizarVelocimetro2(playerid)
    {
    new tmp[255];
	new Float:x,Float:y,Float:z;
	new Float:distance,value;
	GetPlayerPos(playerid, x, y, z);
	distance = floatsqroot(floatpower(floatabs(floatsub(x,SavePlayerPos[playerid][LastX])),2)+floatpower(floatabs(floatsub(y,SavePlayerPos[playerid][LastY])),2)+floatpower(floatabs(floatsub(z,SavePlayerPos[playerid][LastZ])),2));
	SavePlayerPos[playerid][LastX] = x;
    SavePlayerPos[playerid][LastY] = y;
 	SavePlayerPos[playerid][LastZ] = z;
	value = floatround(distance * 11000);
	format(tmp, sizeof(tmp), "Km_h:%d",floatround(value/1400));
	SpeedString[playerid]=tmp;
	format(tmp, sizeof(tmp), "%s %s","_",SpeedString[playerid]);
	TextDrawSetString(medidorTanque[playerid],tmp);
    }
//-----------------------------------------------------------------------------------------------------
public ConsumirCombustible()
    {
    new player;
    new type;
    new string[255];
    for (player=0;player<MAX_PLAYERS;player++)
        {
        if ((IsPlayerConnected(player))&&(IsPlayerInAnyVehicle(player)))
            {
            new wid = GetPlayerVehicleID(player);
            type=GetVehicleTypeFromId(GetVehicleModel(wid));
            if ((type==1)|(type==2)|(type==3))
                {
                if 	(GetPlayerState(player)==PLAYER_STATE_DRIVER)
                    {
                	combustible[wid]--;
                	}
                format(string, sizeof(string), "Fuel:%d", combustible[wid]);
                if (combustible[wid]<1)
                    {
                    format(string, sizeof(string), "EMPTY");
                    if 	(GetPlayerState(player)==PLAYER_STATE_DRIVER)
                    	{
						SinGas[player]=wid;
						TogglePlayerControllable(player,false);
						}
                    combustible[wid]=0;
                    }
                actualizarMedidor(player,string);
				}
            }
        }
    }
//-----------------------------------------------------------------------------------------------------
public OnPlayerSelectedMenuRow(playerid, row)
	{
	if 	(GetPlayerMenu(playerid)==MenuGas)
	    {
	    new vid =GetPlayerVehicleID(playerid);
	    switch (row)
	        {
	        case 0:	{
					if (combustible[vid] == FULLTANK)
						{
						SendClientMessage(playerid, COLOR_RED, "This car is already refuelled.");
						TogglePlayerControllable(playerid,true);
						return 1;
						}
			        new cant=FULLTANK-combustible[vid];
					if (PRECIOLITRO*cant>GetPlayerMoney(playerid))
					    {
			            SendClientMessage(playerid, COLOR_RED, "You don't have enough money..");
			            TogglePlayerControllable(playerid,true);
			            return 1;
					    }
			        combustible[vid]=combustible[vid]+cant;
			        GivePlayerMoney(playerid,PRECIOLITRO*cant*-1);
					new string[255];
					new string2[255];
					format(string, sizeof(string), "You bought %d liters of fuel.", cant);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters. The tank is full.", cant);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "Fuel:%d", combustible[vid]);
					actualizarMedidor(playerid,string);
					for (new j=0;j<MAX_PLAYERS;j++)
					    {
					    if ((IsPlayerConnected(j))&&(IsPlayerInVehicle(j,vid))&&(j!=playerid))
					        {
					        SendClientMessage(j, COLOR_YELLOW, string2);
					        }
					    }
	                }
			case 1: {
					if (combustible[vid] >= FULLTANK/2)
						{
						SendClientMessage(playerid, COLOR_RED, "The tank is half-filled.");
                        TogglePlayerControllable(playerid,true);
						return 1;
						}
			        new cant=(FULLTANK/2)-combustible[vid];
					if (PRECIOLITRO*cant>GetPlayerMoney(playerid))
					    {
			            SendClientMessage(playerid, COLOR_RED, "You don't have enough money.");
                        TogglePlayerControllable(playerid,true);
						return 1;
					    }
			        combustible[vid]=combustible[vid]+cant;
			        GivePlayerMoney(playerid,PRECIOLITRO*cant*-1);
					new string[255];
					new string2[255];
					format(string, sizeof(string), "You bought %d liters of fuel, the tank is full", cant);
					format(string2, sizeof(string2), "Your car has been refuelled with %d liters of fuel, the tank is full", cant);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					format(string, sizeof(string), "Fuel:%d", combustible[vid]);
					actualizarMedidor(playerid,string);
					for (new j=0;j<MAX_PLAYERS;j++)
					    {
					    if ((IsPlayerConnected(j))&&(IsPlayerInVehicle(j,vid))&&(j!=playerid))
					        {
					        SendClientMessage(j, COLOR_YELLOW, string2);
					        }
					    }
		   			}
	        }
        TogglePlayerControllable(playerid,true);
	    }
	return 1;
	}
//-----------------------------------------------------------------------------------------------------
public OnVehicleSpawn(vehicleid)
	{
	combustible[vehicleid]=random(RAND_GAS)+MIN_GAS;
	}
//------------------------------------------------------------------------------------------------------
  MessageForDriver(playerid, vehicleid)
	{
	SendClientMessage(playerid, COLOR_RED, " ");
	new string[255];
	format(string, sizeof(string), " ");
 	new type=GetVehicleTypeFromId(GetVehicleModel(vehicleid));
  	if 	((type==1)|(type==2)|(type==3))
	    {
		SendClientMessage(playerid, COLOR_WHITE, "Drive to a gas-station to refuel.");
		format(string, sizeof(string), "Fuel:%d", combustible[vehicleid]);
    	}
	if (combustible[vehicleid]<1)
	    {
	    format(string, sizeof(string), "EMPTY");
		SinGas[playerid]=vehicleid;
		TogglePlayerControllable(playerid,false);
	    }
	actualizarMedidor(playerid,string);
    return 1;
	}
//------------------------------------------------------------------------------------------------------
  MessageForPassenger(playerid,vehicleid)
	{
	new string[255];
 	new type=GetVehicleTypeFromId(GetVehicleModel(vehicleid));
 	if 	((type==1)|(type==2)|(type==3))
 	    {
		format(string, sizeof(string), "Fuel:%d", combustible[vehicleid]);
    	}
	if	(combustible[vehicleid]<1)
	    {
	    format(string, sizeof(string), "EMPTY");
	    }
	actualizarMedidor(playerid,string);
	}
//------------------------------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
	{
 	#pragma unused oldstate
	if	(newstate==PLAYER_STATE_DRIVER)
	    {
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
    	new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
		SavePlayerPos[playerid][LastX] = x;
	    SavePlayerPos[playerid][LastY] = y;
	 	SavePlayerPos[playerid][LastZ] = z;
	    new vehicleid = GetPlayerVehicleID(playerid);
	    if  ((IsPlayerInCheckpoint(playerid))&&(IsCloserThanThis(playerid,20.0)))
     		{
        	ShowMenuForPlayer(MenuGas,playerid);
        	TogglePlayerControllable(playerid,false);
        	}
		else
		    {
		    MessageForDriver(playerid, vehicleid);
		    }
	    }
	if	(newstate==PLAYER_STATE_PASSENGER)
	    {
	    TextDrawShowForPlayer(playerid,medidorTanque[playerid]);
    	new Float:x,Float:y,Float:z;
    	GetPlayerPos(playerid,x,y,z);
		SavePlayerPos[playerid][LastX] = x;
	    SavePlayerPos[playerid][LastY] = y;
	 	SavePlayerPos[playerid][LastZ] = z;
	    new vehicleid = GetPlayerVehicleID(playerid);
        MessageForPassenger(playerid,vehicleid);
	    return 1;
	    }
	if	(newstate==PLAYER_STATE_ONFOOT)
	    {
	    TextDrawHideForPlayer(playerid,medidorTanque[playerid]);
	    if  (SinGas[playerid]!=0)
	        {
	        TogglePlayerControllable(playerid,true);
	        }
	    SinGas[playerid]=0;
	    }
	return 1;
	}
//-----------------------------------------------------------------------------------------------------
public OnPlayerCommandText(playerid,cmdtext[])
	{
	new tmp[256];
	new cmd[256];
	new idx;
    cmd = strtok(cmdtext, idx);
    if 	(CommandsSTATUS)
	    {
		if	(strcmp(cmd, "/buygas", true) == 0)
			{
			SendClientMessage(playerid, COLOR_RED, " ");
			if	(!IsCloserThanThis(playerid,20.0))
			    {
			    SendClientMessage(playerid, COLOR_RED, "You Must be in a GAS-STATION.");
			    return 1;
			    }
			if (!IsPlayerInAnyVehicle(playerid))
			    {
			    SendClientMessage(playerid, COLOR_RED, "You can either be a driver or a passenger, but YOU MUST be in a car to buy gas.");
			    return 1;
			    }
		  	new vid =GetPlayerVehicleID(playerid);
			if (combustible[vid] == FULLTANK)
				{
				SendClientMessage(playerid, COLOR_RED, "This car is already refuelled.");
				return 1;
				}
	        tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /buygas [litres]");
				return 1;
				}
	        new cant = strval(tmp);
	        if ( (cant<1) || (cant>1024))
	            {
	            SendClientMessage(playerid, COLOR_RED, "enter a valid amount");
	            return 1;
	            }
			if (PRECIOLITRO*cant>GetPlayerMoney(playerid))
			    {
	            SendClientMessage(playerid, COLOR_RED, "You don't have enough money..");
	            TogglePlayerControllable(playerid,true);
	            return 1;
			    }
	        GivePlayerMoney(playerid,PRECIOLITRO*cant*-1);
			if ((combustible[vid] + cant) > FULLTANK)
		        {
		        cant=FULLTANK-combustible[vid];
		        }
	        combustible[vid]=combustible[vid]+cant;
	        GivePlayerMoney(playerid,PRECIOLITRO*cant*-1);
			new string[255];
			new string2[255];
			format(string, sizeof(string), "You bought %d liters of fuel.", cant);
			format(string2, sizeof(string2), "Your car has been refuelled with %d liters. The tank is full.", cant);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			format(string, sizeof(string), "Fuel:%d", combustible[vid]);
			actualizarMedidor(playerid,string);
			for (new j=0;j<MAX_PLAYERS;j++)
			    {
			    if ((IsPlayerConnected(j))&&(IsPlayerInVehicle(j,vid))&&(j!=playerid))
			        {
			        SendClientMessage(j, COLOR_YELLOW, string2);
			        }
			    }
			return 1;
			}
		}
	//ADMIN SUPER POWERS!
    if	(IsPlayerAdmin(playerid))
        {
       	if	((strcmp(cmd,"/SetPlayerGas", true)==0)||(strcmp(cmd, "/SPG", true)==0))
	  		{
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new pid=strval(tmp);
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetPlayerGas [playerid] [cant]");
				return 1;
				}
            new cant=strval(tmp);
			if  (!IsPlayerInAnyVehicle(pid))
			    {
			    SendClientMessage(playerid, COLOR_WHITE, "That player is on FOOT...");
			    return 1;
			    }
			new vid = GetPlayerVehicleID(playerid);
			if	((combustible[vid] + cant) > FULLTANK)
		        {
		        cant=FULLTANK-combustible[vid];
		        }
	        combustible[vid]=combustible[vid]+cant;
			new string[255];
			new string2[255];
			format(string, sizeof(string), "An Admin have put %d litres in your vehicle", cant);
			format(string2, sizeof(string2), "You have added %d litres to a vehicle.", cant);
			SendClientMessage(pid, COLOR_YELLOW, string);
			SendClientMessage(playerid, COLOR_YELLOW, string2);
			format(string, sizeof(string), "Fuel:%d", combustible[vid]);
			actualizarMedidor(pid,string);
			return 1;
			}
       	if	((strcmp(cmd, "/SetCarGas", true)==0)||(strcmp(cmd, "/SCG", true)==0))
	  		{
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetCarGas [vehicleid] [cant]");
				return 1;
				}
            new vid=strval(tmp);
	  		tmp = strtok(cmdtext, idx);
			if	(!strlen(tmp))
				{
				SendClientMessage(playerid, COLOR_WHITE, "USO: /SetCarGas [vehicleid] [cant]");
				return 1;
				}
            new cant=strval(tmp);
			if	((combustible[vid] + cant) > FULLTANK)
		        {
		        cant=FULLTANK-combustible[vid];
		        }
	        combustible[vid]=combustible[vid]+cant;
			new string2[255];
			format(string2, sizeof(string2), "You have added %d litres to a vehicle.", cant);
			SendClientMessage(playerid, COLOR_YELLOW, string2);
			return 1;
			}
        }
	return 0;
	}
//-----------------------------------------------------------------------------------------------------
IsCloserThanThis(playerid, Float:distancia)
	{
	new Float:distNew = 0;
	new Float:distOld = 999999;
 	new index=0;
	for (index=0;index<(CantidadCombCheckp);index++)
		{
		distNew = GetDistanceToPoint(playerid,checkGas[index][1],checkGas[index][2],checkGas[index][3]);
		if 	(distNew<distOld)
			{
			distOld=distNew;
			}
		}
	if	(distOld < distancia)
	    {
	    return 1;
	    }
	return 0;
	}
//-----------------------------------------------------------------------------------------------------
public OnPlayerEnterCheckpoint(playerid)
	{
	if  (CheckpointsSTATUS)
	    {
	    if	(IsCloserThanThis(playerid,20.0))
	        {
	        if 	(IsPlayerInAnyVehicle(playerid))
	     		{
	        	ShowMenuForPlayer(MenuGas,playerid);
	        	TogglePlayerControllable(playerid,false);
	        	}
	        return 1;
	        }
        }
	return 0;
 	}
//-----------------------------------------------------------------------------------------------------
public OnPlayerLeaveCheckpoint(playerid)
{
    if 	(CheckpointsSTATUS && GetPlayerMenu(playerid)==MenuGas)
	    {
	    HideMenuForPlayer(MenuGas,playerid);
	    }
	return 1;
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	{
	#pragma unused oldkeys
	if 	((SinGas[playerid]!=0)&&(newkeys==KEY_SECONDARY_ATTACK)&&(IsPlayerInAnyVehicle(playerid))&&(IsPlayerInVehicle(playerid,SinGas[playerid])))
		{
		RemovePlayerFromVehicle(playerid);
		return 1;
		}
	return 1;
	}
//------------------------------------------------------------------------------------------------------
 strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
//-----------------------------------------------------------------------------------------------------
public OnPlayerExitedMenu(playerid)
{
	//seguro que hace falta
    TogglePlayerControllable(playerid,true);
	return 1;
}
//-----------------------------------------------------------------------------------------------------
public Float:GetDistanceToPoint(playerid,Float:x2,Float:y2,Float:z2)
		{
		if (IsPlayerConnected(playerid))
			{
			new Float:x1,Float:y1,Float:z1;
			GetPlayerPos(playerid,x1,y1,z1);
			return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
			}
		return -1.0;
		}
//-----------------------------------------------------------------------------------------------------
#define VTYPE_CAR 1
#define VTYPE_HEAVY 2
#define VTYPE_BIKE 3
#define VTYPE_AIR 4
#define VTYPE_SEA 5
#define VTYPE_BMX 6
#define VTYPE_TRAILER 7
#define VTYPE_TRAIN 8
GetVehicleTypeFromId(mid)
{
	new type;
// ================== CARS =======
	switch(mid) {
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
	554,   //yosemite,   //car
	477,   //zr3	50  -  car
	470   //patriot  -  car
	: type = VTYPE_CAR;

// ================== BIKES =======
	case
	581,   //bf400  -  bike
	523,   //copbike  -  bike
	462,   //faggio  -  bike
	521,   //fcr900  -  bike
	463,   //freeway  -  bike
	522,   //nrg500  -  bike
	461,   //pcj600  -  bike
	448,   //pizzaboy,   //bike
	468,   //sanchez  -  bike
	586,   //wayfarer,   //bike
	471   //quad  -  quad
	: type = VTYPE_BIKE;
// ================== BMX =======
	case
	509,   //bike  -  bmx
	481,   //bmx  -  bmx
	510   //mtbike  -  bmx
	: type = VTYPE_BMX;
// ================== SEA =======
	case
	472,   //coastg  -  boat
	473,   //dinghy  -  boat
	493,   //jetmax  -  boat
	595,   //launch  -  boat
	484,   //marquis  -  boat
	430,   //predator,   //boat
	453,   //reefer  -  boat
	452,   //speeder  -  boat
	446,   //squalo  -  boat
	454   //tropic  -  boat
	: type = VTYPE_SEA;

// ================== AIR =======
	case
	548,   //cargobob,   //heli
	425,   //hunter  -  heli
	417,   //leviathn,   //heli
	487,   //maverick,   //heli
	497,   //polmav  -  heli
	563,   //raindanc,   //heli
	501,   //rcgoblin,   //heli
	465,   //rcraider,   //heli
	447,   //seaspar  -  heli
	469,   //sparrow  -  heli
	488,   //vcnmav  -  heli
	592,   //androm  -  plane
	577,   //at	400  -  plane
	511,   //beagle  -  plane
	512,   //cropdust,   //plane
	593,   //dodo  -  plane
	520,   //hydra  -  plane
	553,   //nevada  -  plane
	464,   //rcbaron  -  plane
	476,   //rustler  -  plane
	519,   //shamal  -  plane
	460,   //skimmer  -  plane
	513,   //stunt  -  plane
	539   //vortex  -  plane
	: type = VTYPE_AIR;

// ================== HEAVY =======
	case
	588,   //hotdog  -  car
	437,   //coach  -  car
	532,   //combine  -  car
	433,   //barracks,   //car
	414,   //mule  -  car
	443,   //packer  -  car
	432,   //rhino  -  car
	525,   //towtruck,   //car
	531,   //tractor  -  car
	408,   //trash  -  car
	406,   //dumper  -  mtruck
	573,   //duneride,   //mtruck
	444,   //monster  -  mtruck
	556,   //monstera,   //mtruck
	557   //monsterb,   //mtruck
	: type = VTYPE_HEAVY;
// ================== TRAILERS =======
	case
	435,   //artict1  -  trailer
	450,   //artict2  -  trailer
	591,   //artict3  -  trailer
	606,   //bagboxa  -  trailer
	607,   //bagboxb  -  trailer
	610,   //farmtr1  -  trailer
	584,   //petrotr  -  trailer
	608,   //tugstair -  trailer
	611   //utiltr1  -  trailer
	: type = VTYPE_TRAILER;
// ================== TRAINS =======
	case
	590,   //freibox  -  train
	569,   //freiflat,   //train
	537,   //freight  -  train
	538,   //streak  -  train
	570,   //streakc  -  train
	449   //tram  -  train
	: type = VTYPE_TRAIN;
	}
	return type;
}
