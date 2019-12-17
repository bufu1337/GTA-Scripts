#include <a_samp>
#include <dudb>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
//----------------------------
//----------------------------
//  Full house script by Antironix!
//  Just don't remove the credits!
//----------------------------
//----------------------------
#define MAX_HOUSES 2
#define MAX_RENTCOST 1000
#define MIN_RENTCOST 500
#define MAX_BUY_CARS 8
#define CAR_DELIVER_TIME 1 //The time that it takes that your car will be delivered. In hours.
new HOUSE_STATS = 0; //0 Means housestats on pickup pickup, 1 means only housestats on /housestats command.

//buyable cars
enum CarInfo {CarModel,CarName[24],CarCost};
new Buyable_Cars[MAX_BUY_CARS][CarInfo] =
{  //Modelid, Buy Name, Price
	{411,"Infernus",0},
	{522,"NRG-500",50000},
	{451,"Turismo",50000},
	{541,"Bullet",50000},
	{415,"Cheetah",50000},
	{429,"Banshee",50000},
	{494,"Hotring",50000},
	{556,"Monster",50000}
};
#define Cost_Admiral 50000
//----------------------------
//----------------------------
#define c_y 0xFFFF00AA
#define c_r 0xAA3333AA
new HousePickup[MAX_HOUSES];
new playerinterior[MAX_PLAYERS]=-1;
new inhousepickup[MAX_PLAYERS];
new playericonhouse[MAX_PLAYERS];
new Float:housex, Float:housey, Float:housez;
new housemapicon[MAX_PLAYERS];
new playerworld[MAX_PLAYERS];
new bool:KillVeh[MAX_VEHICLES] = false;
forward rentfee();
forward newcar();
forward KillVehicle(carid);

enum HouseInfo
{
	Name[24],
	Renter[24],
	Rentable,
	Rentcost,
	Cost,
	Sell,
	Interior,
	Virtualworld,
	Locked,
	Float:InteriorX,
	Float:InteriorY,
	Float:InteriorZ,
	Float:iconx,
	Float:icony,
	Float:iconz,
	Rentfee
}
new hInfo[MAX_HOUSES][HouseInfo];

enum HouseCarInfo
{
	HouseCar,
	GotCar,
	Houseid,
	CarModel,
	Float:CarX,
	Float:CarY,
	Float:CarZ,
	CarColor1,
	CarColor2,
	Respawn_Delay,
	NewCar
}
new cInfo[MAX_HOUSES][HouseCarInfo];

#define FILTERSCRIPT
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Simple House System by Antironix");
	print("--------------------------------------\n");
	AddHouse(0, 1442.9769,-629.5287,95.7186, 2317.8201,-1024.7500,1050.2109, 0, 0, 9, 0);
	AddHouse(1, 1980.9896,-1719.0171,17.0304, 328.1465, 1478.4457,1084.4375, 0, 0, 15, 0);
	AddHouseCar(0, 429, 1454.3051,-636.2531,95.4855, 0, 0, 5*60*1000);//5 min respawn delay
	SetTimer("rentfee", 1*60*60*1000, 1);//1 hour
	SetTimer("newcar", CAR_DELIVER_TIME*60*10*1000,1);//1 hour
	return 0;
}

public OnFilterScriptExit()
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
	    DestroyPickup(HousePickup[i]);
	    DestroyVehicle(cInfo[i][HouseCar]);
	}
	return 0;
}

#else
#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(buy,3,cmdtext);
	dcmd(sell,4,cmdtext);
	dcmd(enter,5,cmdtext);
	dcmd(exit,4,cmdtext);
	dcmd(lock,4,cmdtext);
	dcmd(unlock,6,cmdtext);
	dcmd(home,4,cmdtext);
	dcmd(setrent,7,cmdtext);
	dcmd(rent,4,cmdtext);
	dcmd(unrent,6,cmdtext);
	dcmd(house,5,cmdtext);
	dcmd(housestats,10,cmdtext);
	dcmd(getrent,7,cmdtext);
	dcmd(payrent,7,cmdtext);
	dcmd(ordercar,8,cmdtext);
	return 0;
}

AddHouse(houseid, Float:iconX, Float:iconY, Float:iconZ, Float:interiorX, Float:interiorY, Float:interiorZ, Costa, Sella, Interiora, virtualworld)
{
	new house[256];
	format(house, sizeof(house), "Houses/houseid%d",houseid);
	if(!dini_Exists(house))
	{
		dini_Create(house);
		format(hInfo[houseid][Name], 24, "ForSale");
		dini_Set(house, "Name", "ForSale");
		format(hInfo[houseid][Renter], 24, "ForRent");
		dini_Set(house, "Renter", "ForRent");
		hInfo[houseid][Rentable] = 0;
		dini_IntSet(house, "Rentable", 0);
		hInfo[houseid][Rentcost] = 0;
		dini_IntSet(house, "Rentcost", 0);
		hInfo[houseid][Cost] = Costa;
		dini_IntSet(house, "Cost", Costa);
		hInfo[houseid][Sell] = Sella;
		dini_IntSet(house, "Sell", Sella);
		hInfo[houseid][Interior] = Interiora;
		dini_IntSet(house, "Interior", Interiora);
		dini_IntSet(house, "Virtualworld", virtualworld);
		hInfo[houseid][Virtualworld] = virtualworld;
		hInfo[houseid][Locked] = 1;
		dini_IntSet(house, "Locked", 1);
		hInfo[houseid][InteriorX] = interiorX;
		hInfo[houseid][InteriorY] = interiorY;
		hInfo[houseid][InteriorZ] = interiorZ;
		dini_FloatSet(house, "X", interiorX);
		dini_FloatSet(house, "Y", interiorY);
		dini_FloatSet(house, "Z", interiorZ);
		dini_IntSet(house, "RentPay", 0);
		dini_IntSet(house, "RentGet", 0);
		cInfo[houseid][HouseCar] = 429;
		dini_IntSet(house, "HouseCar", 0);
		cInfo[houseid][CarModel] = 429;
		dini_IntSet(house, "CarModel", 0);
		cInfo[houseid][CarX] = 0;
		cInfo[houseid][CarY] = 0;
		cInfo[houseid][CarZ] = 0;
		dini_FloatSet(house, "CarX", 0);
		dini_FloatSet(house, "CarY", 0);
		dini_FloatSet(house, "CarZ", 0);
		cInfo[houseid][CarColor1] = 0;
		cInfo[houseid][CarColor2] = 0;
		dini_IntSet(house, "CarColor1", 0);
		dini_IntSet(house, "CarColor2", 0);
		cInfo[houseid][GotCar] = 0;
		print("-");
		print("--------------House Created--------------");
		printf("- Houseid: %d", houseid);
		printf("- Buy Cost: %d", Costa);
		printf("- Sell Cost: %d", Sella);
		printf("- Interior: %d", Interiora);
		printf("- VirtualWorld: %d", virtualworld);
		print("-----------------------------------------");
		print("-");
	}
	else
	{
	    format(hInfo[houseid][Name], 24, dini_Get(house, "Name"));
	    format(hInfo[houseid][Renter], 24, dini_Get(house, "Renter"));
		hInfo[houseid][Rentable] = dini_Int(house, "Rentable");
		hInfo[houseid][Rentcost] = dini_Int(house, "Rentcost");
	    hInfo[houseid][Cost] = dini_Int(house, "Cost");
	    hInfo[houseid][Sell] = dini_Int(house, "Sell");
	    hInfo[houseid][Interior] = dini_Int(house, "Interior");
	    hInfo[houseid][Locked] = dini_Int(house, "Locked");
	    hInfo[houseid][InteriorX] = dini_Float(house, "X");
	    hInfo[houseid][InteriorY] = dini_Float(house, "Y");
		hInfo[houseid][InteriorZ] = dini_Float(house, "Z");
		hInfo[houseid][Virtualworld] = dini_Int(house, "Virtualworld");
	}
    hInfo[houseid][iconx]=iconX;
	hInfo[houseid][icony]=iconY;
	hInfo[houseid][iconz]=iconZ;
	format(house, sizeof(house), "Houses/houseid%d",houseid);
	if(strcmp(hInfo[playericonhouse[houseid]][Name],"ForSale",true)==0)
	{
		HousePickup[houseid] = CreatePickup(1273, 23, iconX, iconY, iconZ);//not bought
	}
	else
	{
		HousePickup[houseid] = CreatePickup(1272,23, iconX, iconY, iconZ);//bought
	}
}

AddHouseCar(houseid, modelid, Float:Carx, Float:Cary, Float:Carz, color1, color2, respawn_delay)
{
	new house[256];
	format(house, sizeof(house), "Houses/houseid%d",houseid);
	if(dini_Exists(house))
	{
	    cInfo[houseid][GotCar] = 1;
		if(dini_Int(house, "CarModel")==0)
		{
		    dini_IntSet(house, "CarModel", modelid);
		    cInfo[houseid][CarModel] = modelid;
		    cInfo[houseid][CarX] = Carx;
			cInfo[houseid][CarY] = Cary;
			cInfo[houseid][CarZ] = Carz;
			dini_FloatSet(house, "CarX", Carx);
			dini_FloatSet(house, "CarY", Cary);
			dini_FloatSet(house, "CarZ", Carz);
			cInfo[houseid][CarColor1] = color1;
			cInfo[houseid][CarColor2] = color2;
			dini_IntSet(house, "CarColor1", color1);
			dini_IntSet(house, "CarColor2", color2);
			dini_IntSet(house, "Respawn_Delay", respawn_delay);
			cInfo[houseid][Respawn_Delay] = respawn_delay;
 			cInfo[houseid][HouseCar] = CreateVehicle(cInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
		    print("-");
			print("--------------Car Created--------------");
			printf("- Car Houseid: %d", houseid);
			printf("- Modelid: %d", modelid);
			printf("- Color 1: %d", color1);
			printf("- Color 2: %d", color2);
			printf("- Respawn Delay: %d", respawn_delay);
			print("---------------------------------------");
			print("-");
		}
		else
		{
		    cInfo[houseid][CarModel] = dini_Int(house, "CarModel");
		}
		cInfo[houseid][CarX] = dini_Int(house, "CarX");
		cInfo[houseid][CarY] = dini_Int(house, "CarY");
		cInfo[houseid][CarZ] = dini_Int(house, "CarZ");
		cInfo[houseid][CarColor1] = dini_Int(house, "CarColor1");
		cInfo[houseid][CarColor2] = dini_Int(house, "CarColor2");
		cInfo[houseid][Respawn_Delay] = dini_Int(house, "Respawn_Delay");
 		cInfo[houseid][HouseCar] = CreateVehicle(cInfo[houseid][CarModel], Carx, Cary, Carz, 0.0, color1, color2, respawn_delay);
	}
}

stock SpawnPlayerAtHouse(playerid)
{
	new str1[256],pname[24],str[256];
	GetPlayerName(playerid, pname, sizeof(pname));
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (dini_Exists(str1))
	{
		if(dini_Int(str1,"Houseid")!=-255)
		{
			new Float:x,Float:y,Float:z;
			str = dini_Get(str1,"SpawnInt");
			SetPlayerInterior(playerid, strval(str));
			playerinterior[playerid] = strval(str);
    		x = dini_Float(str1,"SpawnX");
	  		y = dini_Float(str1,"SpawnY");
	  		z = dini_Float(str1,"SpawnZ");
			SetPlayerPos(playerid, x, y, z);
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SpawnPlayerAtHouse(playerid);
}

GetHouseStats(playerid, pickupid)
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
		if(pickupid==HousePickup[i])
	   	{
	   	    if(HOUSE_STATS==0)
		 	{
				new str2[256];
	    		format(str2, sizeof(str2), "Owned by: %s", hInfo[i][Name]);
	    		SendClientMessage(playerid, c_y, str2);
	    		if(strcmp(hInfo[i][Renter],"ForRent",true))
	    		{
	    			format(str2, sizeof(str2), "Rented by: %s", hInfo[i][Renter]);
	    			SendClientMessage(playerid, c_y, str2);
				}
	    		format(str2,sizeof(str2),"Cost: %i",hInfo[i][Cost]);
	    		SendClientMessage(playerid, c_y, str2);
	    	}
	    	inhousepickup[playerid] = GetTickCount();
	    	playericonhouse[playerid] = i;
	    }
	}
}

dcmd_sell(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str[255],str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],pname,false)) return SendClientMessage(playerid, c_r, "This house isn't yours!");
 	SendClientMessage(playerid, c_y, "You have sold your house!");
  	format(str, sizeof(str), "%s has sold houseid 0",pname);
	print(str);
	GivePlayerMoney(playerid, hInfo[playericonhouse[playerid]][Sell]);
    dini_Set(str1, "Name", "ForSale");
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",1);
    format(hInfo[playericonhouse[playerid]][Name],255,"ForSale");
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	dini_IntSet(str1, "Houseid", -255);
	DestroyPickup(HousePickup[playericonhouse[playerid]]);
	HousePickup[playericonhouse[playerid]] = CreatePickup(1273, 23, hInfo[playericonhouse[playerid]][iconx], hInfo[playericonhouse[playerid]][icony], hInfo[playericonhouse[playerid]][iconz]);
	RemovePlayerMapIcon(playerid, housemapicon[playerid]);
 	return 1;
}

dcmd_buy(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str[255],str1[255],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if(dini_Exists(str1))
	{
	if (dini_Int(str1, "Houseid")!=-255) return SendClientMessage(playerid, c_r, "You can only buy one house!");
	}
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if (strcmp(hInfo[playericonhouse[playerid]][Name],"ForSale",true)) return SendClientMessage(playerid, c_r, "This house isn't for sale!");
	if(GetPlayerMoney(playerid)<hInfo[playericonhouse[playerid]][Cost]) return SendClientMessage(playerid, c_r, "Not enough money!");
	SendClientMessage(playerid, c_y, "You have bought the house!");
	format(str, sizeof(str), "%s has bought houseid 0",pname);
	print(str);
	GivePlayerMoney(playerid, -hInfo[playericonhouse[playerid]][Cost]);
    dini_Set(str1, "Name", pname);
    hInfo[playericonhouse[playerid]][Name]=pname;
    hInfo[playericonhouse[playerid]][Locked] = dini_IntSet(str1,"Locked",0);

	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if (!dini_Exists(str1)) dini_Create(str1);
	new Float:sy, Float:sx, Float:sz;
	dini_IntSet(str1, "Houseid", playericonhouse[playerid]);
	if(!dini_Isset(str1,"Rentid"))
	{
		dini_IntSet(str1, "Rentid", -255);
	}
	GetPlayerPos(playerid, sx,sy,sz);
	dini_FloatSet(str1, "SpawnX", sx);
	dini_FloatSet(str1, "SpawnY", sy);
	dini_FloatSet(str1, "SpawnZ", sz);
	dini_IntSet(str1, "SpawnInt", GetPlayerInterior(playerid));
	DestroyPickup(HousePickup[playericonhouse[playerid]]);
	HousePickup[playericonhouse[playerid]] = CreatePickup(1272, 23, hInfo[playericonhouse[playerid]][iconx], hInfo[playericonhouse[playerid]][icony], hInfo[playericonhouse[playerid]][iconz]);
	return 1;
}

dcmd_lock(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, c_y, "You have locked your house!");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Renter],pname,true)==0)
    {
        SendClientMessage(playerid, c_y, "You have locked your house!");
    	dini_IntSet(str1,"Locked",1);
    	hInfo[playericonhouse[playerid]][Locked] = 1;
    }
    else
    {
        SendClientMessage(playerid, c_r, "This house isn't yours!");
    }	
	return 1;
}

dcmd_unlock(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
 		SendClientMessage(playerid, c_y, "You have unlocked your house!");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else if(strcmp(hInfo[playericonhouse[playerid]][Renter],pname,true)==0)
    {
        SendClientMessage(playerid, c_y, "You have unlocked your house!");
    	dini_IntSet(str1,"Locked",0);
    	hInfo[playericonhouse[playerid]][Locked] = 0;
    }
    else
    {
        SendClientMessage(playerid, c_r, "This house isn't yours!");
    }
	return 1;
}

dcmd_enter(playerid,params[])
{
    #pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str1[255],pname[24];
	GetPlayerPos(playerid, housex, housey, housez);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	GetPlayerName(playerid, pname, 24);
	if(hInfo[playericonhouse[playerid]][Locked]==1) return SendClientMessage(playerid, c_r, "This house is locked!");
    playerworld[playerid] = GetPlayerVirtualWorld(playerid);
 	SendClientMessage(playerid, c_y, "You entered the house!");
    SetPlayerVirtualWorld(playerid, hInfo[playericonhouse[playerid]][Virtualworld]);
    SetPlayerInterior(playerid, hInfo[playericonhouse[playerid]][Interior]);
	SetPlayerPos(playerid, hInfo[playericonhouse[playerid]][InteriorX], hInfo[playericonhouse[playerid]][InteriorY], hInfo[playericonhouse[playerid]][InteriorZ]);
	playerinterior[playerid] = hInfo[playericonhouse[playerid]][Interior];
   	return 1;
}

dcmd_exit(playerid,params[])
{
    #pragma unused params

	if(GetPlayerInterior(playerid)==playerinterior[playerid])
	{
		SetPlayerPos(playerid, housex, housey, housez);
		SetPlayerInterior(playerid, playerworld[playerid]);
	}
	else
	{
		SendClientMessage(playerid, c_r, "You have not entered a house!");
	}
   	return 1;
}

dcmd_home(playerid,params[])
{
    #pragma unused params
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	if(!dini_Exists(str1)) return SendClientMessage(playerid, c_r, "You don't own a house!");
	if(dini_Int(str1, "Houseid")!=-255)
	{
	    housemapicon[playerid] = SetPlayerMapIcon(playerid,31,hInfo[dini_Int(str1, "Houseid")][iconx], hInfo[dini_Int(str1, "Houseid")][icony], hInfo[dini_Int(str1, "Houseid")][iconz],31,c_y);
	}
	else if (dini_Int(str1, "Rentid")!=-255)
	{
	    housemapicon[playerid] = SetPlayerMapIcon(playerid,31,hInfo[dini_Int(str1, "Rentid")][iconx], hInfo[dini_Int(str1, "Rentid")][icony], hInfo[dini_Int(str1, "Rentid")][iconz],31,c_y);
	}
	else
	{
	    SendClientMessage(playerid, c_r, "You don't own a house!");
	}
	return 1;
}

dcmd_setrent(playerid,params[])
{
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str[256],str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	str = dini_Get(str1,"Name");
	if (strcmp(str,pname,true)) return SendClientMessage(playerid, c_r, "This house isn't yours!");
	new rentcost, rentable;
	if (sscanf(params, "dd", rentable, rentcost)) return SendClientMessage(playerid, c_r, "USAGE: /setrent [0/1] [Rentcost]");
	else if (rentcost<MIN_RENTCOST)
	{
	    format(str, sizeof(str), "The minimum rentcost is $%i.", MIN_RENTCOST);
		SendClientMessage(playerid, c_r, str);
		return 1;
	}
	else if (rentcost>MAX_RENTCOST)
	{
	    format(str, sizeof(str), "The maximum rentcost is $%i.", MAX_RENTCOST);
		SendClientMessage(playerid, c_r, str);
		return 1;
	}
	else if(rentable==1)
	{
        SendClientMessage(playerid, c_y, "Your house is now rentable!");
        hInfo[playericonhouse[playerid]][Rentable] = 1;
		dini_IntSet(str1, "Rentable", 1);
        hInfo[playericonhouse[playerid]][Rentcost] = rentcost;
		dini_IntSet(str1, "Rentcost", rentcost);
        return 1;
	}
	else if(rentable==0)
	{
	    SendClientMessage(playerid, c_y, "Your house is now not rentable!");
	    hInfo[playericonhouse[playerid]][Rentable] = 0;
		dini_IntSet(str1, "Rentable", 0);
	    hInfo[playericonhouse[playerid]][Rentcost] = rentcost;
		dini_IntSet(str1, "Rentcost", rentcost);
	    return 1;
	}
	return 1;
}

dcmd_rent(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str[255],str1[256],str5[255],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	format(str5, sizeof(str5), "Houses/Users/%s", udb_encode(pname));
	if(dini_Isset(str5, "Rentid"))
	{
		if (dini_Int(str5, "Rentid")!=-255) return SendClientMessage(playerid, c_r, "You can only rent one house at a time!");
	}
	format(str, sizeof(str), dini_Get(str1,"Name"));
	if (strcmp(str,"ForSale",true)==0) return SendClientMessage(playerid, c_r, "This house has no owner!");
	if(hInfo[playericonhouse[playerid]][Rentable]==0 || strcmp(hInfo[playericonhouse[playerid]][Renter], "ForRent", true)==0) return SendClientMessage(playerid, c_r, "This house is not rentable!");
	if(GetPlayerMoney(playerid)<hInfo[playericonhouse[playerid]][Rentcost]) return SendClientMessage(playerid, c_r, "Not enough money!");
	dini_Set(str1, "Renter", udb_encode(pname));
	format(hInfo[playericonhouse[playerid]][Renter], 24, udb_encode(pname));
	dini_IntSet(str5, "Rentid", playericonhouse[playerid]);
	format(str1, sizeof(str1), "You have rented this house, it will cost you $%i an hour!", hInfo[playericonhouse[playerid]][Rentcost]);
	SendClientMessage(playerid, c_y, str1);
	return 1;
}

dcmd_unrent(playerid,params[])
{
    #pragma unused params
   	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str1[256],pname[24];
	GetPlayerName(playerid, pname, 24);
	format(str1, sizeof(str1), "Houses/houseid%d", playericonhouse[playerid]);
	if(strcmp(hInfo[playericonhouse[playerid]][Renter], pname, true)) return SendClientMessage(playerid, c_r, "You aren't renting this house!");
	
	dini_Set(str1, "Renter", "ForRent");
	format(hInfo[playericonhouse[playerid]][Renter], 24, "ForRent");
	format(str1, sizeof(str1), "Houses/Users/%s", udb_encode(pname));
	dini_IntSet(str1, "Rentid", -255);
	SendClientMessage(playerid, c_y, "You have unrented this house!");
	return 1;
}

dcmd_house(playerid,params[])
{
	#pragma unused params
	SendClientMessage(playerid, c_y, "-------------");
	SendClientMessage(playerid, c_y, "House options");
	SendClientMessage(playerid, c_y, "-------------");
	SendClientMessage(playerid, c_y, "/setrent [0/1] [Cost] - House owner");
	SendClientMessage(playerid, c_y, "/ordercar [CarName]   - House owner");
	SendClientMessage(playerid, c_y, "/getrent              - House owner");
	SendClientMessage(playerid, c_y, "/lock                 - Renter/Owner");
	SendClientMessage(playerid, c_y, "/unlock               - Renter/Owner");
	SendClientMessage(playerid, c_y, "/payrent              - Renter");
	SendClientMessage(playerid, c_y, "/unrent               - Renter");
	SendClientMessage(playerid, c_y, "/rent                 - Guest");
	SendClientMessage(playerid, c_y, "-------------");
	return 1;
}

dcmd_housestats(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new str[256];
	format(str, sizeof(str), "Owner: %s", hInfo[playericonhouse[playerid]][Name]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Cost: $%d", hInfo[playericonhouse[playerid]][Cost]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Renter: %s", hInfo[playericonhouse[playerid]][Renter]);
	SendClientMessage(playerid, c_y, str);
	format(str, sizeof(str), "Rentcost: $%d / hour", hInfo[playericonhouse[playerid]][Rentcost]);
	SendClientMessage(playerid, c_y, str);
	return 1;
}

dcmd_getrent(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new pname[24];
	GetPlayerName(playerid, pname, 24);
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
	    new str[255];
 		SendClientMessage(playerid, c_y, "You collected the money of the renter!");
 		format(str, sizeof(str), "Houses/houseid%d", playericonhouse[playerid]);
    	GivePlayerMoney(playerid, dini_Int(str, "RentGet"));
    	dini_IntSet(str, "RentGet", 0);
    }
    else
    {
        SendClientMessage(playerid, c_r, "This house isn't yours!");
    }
    return 1;
}

dcmd_payrent(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new pname[24];
	GetPlayerName(playerid, pname, 24);
	if(strcmp(hInfo[playericonhouse[playerid]][Renter],pname,true)==0)
	{
	    new str[255];
	    format(str, sizeof(str), "Houses/houseid%d", playericonhouse[playerid]);
	    if(GetPlayerMoney(playerid)<dini_Int(str, "RentPay")) return SendClientMessage(playerid, c_r, "You don't have enough money to pay the house owner!");
 		SendClientMessage(playerid, c_y, "You have payed the money to the owner!");
     	GivePlayerMoney(playerid, -dini_Int(str, "RentPay"));
    	dini_IntSet(str, "RentPay", 0);
    }
    else
    {
        SendClientMessage(playerid, c_r, "You aren't renting this house!");
    }
    return 1;
}

dcmd_ordercar(playerid,params[])
{
	#pragma unused params
	new timestamp = GetTickCount();
	if(timestamp - inhousepickup[playerid] > 5000)
	{
    		SendClientMessage(playerid, c_r, "You are not in a house icon!");
    		return 1;
	}
	new pname[24];
	GetPlayerName(playerid, pname, 24);
	if(cInfo[playericonhouse[playerid]][GotCar]==0) return SendClientMessage(playerid, c_r, "This house can't order a car!");
	if(strcmp(hInfo[playericonhouse[playerid]][Name],pname,true)==0)
	{
	    new carname[40];
	    if (sscanf(params, "s", carname))
		{
	 		SendClientMessage(playerid, c_r, "USAGE: /ordercar [CarName]");
	 	}
		else
		{
		    new str[256], abc;
		    for(new i=0;i<MAX_BUY_CARS;i++)
		    {
        		if(strcmp(carname,Buyable_Cars[i][CarName],true)==0)
	       		{
	       		    if(GetPlayerMoney(playerid)<Buyable_Cars[i][CarCost]) return SendClientMessage(playerid, c_r, "Not enough money!");
         			GivePlayerMoney(playerid, -Buyable_Cars[i][CarCost]);
					cInfo[playericonhouse[playerid]][CarModel] = Buyable_Cars[i][CarModel];
					format(str, sizeof(str), "Houses/houseid%d", playericonhouse[playerid]);
					dini_IntSet(str, "CarModel", Buyable_Cars[i][CarModel]);
					format(str, sizeof(str), "You have ordered the %s for $%d!", carname, Buyable_Cars[i][CarCost]);
  					SendClientMessage(playerid, c_y, str);
  					SendClientMessage(playerid, c_y, "It will take some time when your car will be delivered.");
  					cInfo[playericonhouse[playerid]][NewCar] = 1;
  					abc = 1;
  				}
  			}
  			if(abc==0)
  			{
  			    SendClientMessage(playerid, c_r, "Wrong vehicle name!");
  			    abc=0;
  			}
  			
		}
    }
    else
    {
        SendClientMessage(playerid, c_r, "This house isn't yours!");
    }
    return 1;
}

public newcar()
{
	for(new carid=0;carid<MAX_HOUSES;carid++)
	{
		if(cInfo[carid][NewCar]==1)
		{
		    cInfo[carid][NewCar]=0;
		    KillVehicle(cInfo[carid][HouseCar]);
	    	cInfo[carid][HouseCar] = CreateVehicle(cInfo[carid][CarModel], cInfo[carid][CarX], cInfo[carid][CarY], cInfo[carid][CarZ], 0.0, cInfo[carid][CarColor1], cInfo[carid][CarColor2], cInfo[carid][Respawn_Delay]);
		}
	}
}

public KillVehicle(carid)
{
	for (new i=0;i<MAX_PLAYERS;i++)
	{
	    if(IsPlayerInVehicle(i, carid))
	    {
			RemovePlayerFromVehicle(i);
    		KillVeh[carid] = true;
    		SetVehicleToRespawn(carid);
    		SendClientMessage(i, c_r, "System: Your car has been destroyed.");
    		SendClientMessage(i, c_r, "Reason: House system.");
		}
		else
		{
		    KillVeh[carid] = true;
		    SetVehicleToRespawn(carid);
		}
	}
}

public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_HOUSES;i++)
	{
    	if(KillVeh[cInfo[i][HouseCar]]==true)
    	{
     		KillVeh[cInfo[i][HouseCar]] = false;
        	DestroyVehicle(cInfo[i][HouseCar]);
		}
	}
}

public rentfee()
{
	new str[255],str2[255],pname[24];
	for(new houseid=0;houseid<MAX_HOUSES;houseid++)
	{
	    print("f");
		format(str, sizeof(str), "Houses/houseid%d", houseid);
		if(strcmp(hInfo[houseid][Renter], "ForRent", true))
		{
			for(new ii=0;ii<MAX_PLAYERS;ii++)
			{
		    	if(IsPlayerConnected(ii))
	  			{
	  		    	GetPlayerName(ii, pname, 24);
        			if(strcmp(hInfo[houseid][Renter], pname, true)==0)
        			{
        	 		   	format(str2, sizeof(str2), "You have to pay $%d for the hour you have rented the hous!", hInfo[houseid][Rentcost]);
        	 		   	SendClientMessage(ii, c_y, str2);
						dini_IntSet(str, "RentGet", dini_Int(str, "RentGet")+hInfo[houseid][Rentcost]);
						dini_IntSet(str, "RentPay", dini_Int(str, "RentPay")+hInfo[houseid][Rentcost]);
						hInfo[houseid][Rentfee]=1;
					}
				}
			}
			if(hInfo[houseid][Rentfee]==0)
			{
				    if(strcmp(hInfo[houseid][Renter],"ForRent"))
				    {
				        dini_IntSet(str, "RentGet", dini_Int(str, "RentGet")+hInfo[houseid][Rentcost]);
				        dini_IntSet(str, "RentPay", dini_Int(str, "RentPay")+hInfo[houseid][Rentcost]);
				    }
			}
			hInfo[houseid][Rentfee]=0;
		}
	}
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	GetHouseStats(playerid, pickupid);
	return 0;
}

stock sscanf(string[], format[], {Float,_}:...)
{
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs();
	while (paramPos < paramCount && string[stringPos])
	{
		switch (format[formatPos++])
		{
			case '\0':
			{
				return 0;
			}
			case 'i', 'd':
			{
				new
					neg = 1,
					num = 0,
					ch = string[stringPos];
				if (ch == '-')
				{
					neg = -1;
					ch = string[++stringPos];
				}
				do
				{
					stringPos++;
					if (ch >= '0' && ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return 1;
					}
				}
				while ((ch = string[stringPos]) && ch != ' ');
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					ch,
					num = 0;
				while ((ch = string[stringPos++]))
				{
					switch (ch)
					{
						case 'x', 'X':
						{
							num = 0;
							continue;
						}
						case '0' .. '9':
						{
							num = (num << 4) | (ch - '0');
						}
						case 'a' .. 'f':
						{
							num = (num << 4) | (ch - ('a' - 10));
						}
						case 'A' .. 'F':
						{
							num = (num << 4) | (ch - ('A' - 10));
						}
						case ' ':
						{
							break;
						}
						default:
						{
							return 1;
						}
					}
				}
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{
				new tmp[25];
				strmid(tmp, string, stringPos, stringPos+sizeof(tmp)-2);
				setarg(paramPos, 0, _:floatstr(tmp));
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != ' ')
					{
						setarg(paramPos, i++, ch);
					}
					if (!i) return 1;
				}
				else
				{
					while ((ch = string[stringPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				stringPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (string[stringPos] && string[stringPos] != ' ')
		{
			stringPos++;
		}
		while (string[stringPos] == ' ')
		{
			stringPos++;
		}
		paramPos++;
	}
	while (format[formatPos] == 'z') formatPos++;
	return format[formatPos];
}
