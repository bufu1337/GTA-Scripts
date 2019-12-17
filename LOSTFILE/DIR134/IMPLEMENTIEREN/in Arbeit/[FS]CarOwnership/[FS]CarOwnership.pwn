//===========================Section: Includes==================================
#include <a_samp>
//===========================Section: Definations===============================
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_YELLOW2 0xF5DEB3AA
//===========================Section: Forwards==================================
forward split(const strsrc[], strdest[][], delimiter);
forward LoadCar();
forward CheckOwner(playerid);
forward SaveCars();
//===========================Section: Variables=================================
enum pInfo
{
	pCarKey,
}
new PlayerInfo[256][pInfo];
enum cInfo
{
	cModel,
	Float:cLocationx,
	Float:cLocationy,
	Float:cLocationz,
	Float:cAngle,
	cColorOne,
	cColorTwo,
	cOwner[MAX_PLAYER_NAME],
	cDescription[MAX_PLAYER_NAME],
	cValue,
	cLicense,
	cRegistration,
	cOwned,
	cLock,
	ownedvehicle,
};
new CarInfo[12][cInfo];

new CarAutolock[999]; // Variable for Autolocking Car Doors
new cartrack[256];
new CarOffered[256];
//===========================Section: strtok & split============================
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

public split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
//===========================Section: Callbacks & Functions=====================
public OnFilterScriptInit()
{
	printf("Filterscript [FS]CarOwnership.amx Initiated\n");
	LoadCar();
	for(new i = 1; i < sizeof(CarInfo); i++)
	{
		CarInfo[i][ownedvehicle] = CreateVehicle(CarInfo[i][cModel],CarInfo[i][cLocationx],CarInfo[i][cLocationy],CarInfo[i][cLocationz],CarInfo[i][cAngle],CarInfo[i][cColorOne],CarInfo[i][cColorTwo],300000);
	}
	SetTimer("SaveCars",60000,1);
	SetTimer("CheckOwner",5000,1);
	return 1;
}
public OnVehicleSpawn(vehicleid)
{
	for(new i = 1; i < sizeof(CarInfo); i++)
	{
		ChangeVehicleColor(CarInfo[i][ownedvehicle],CarInfo[vehicleid][cColorOne],CarInfo[vehicleid][cColorTwo]);
	}
	return 1;
}
public CheckOwner(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    for(new i = 1; i < sizeof(CarInfo); i++)
	    {
	        new playername[MAX_PLAYER_NAME];
	        GetPlayerName(playerid,playername,sizeof(playername));
	        if(strcmp(playername,CarInfo[i][cOwner],true)==0)
	        {
	            PlayerInfo[i][pCarKey] = i;
				return i;
	        }
 		}
	}
	return 1;
}
public OnPlayerConnect(playerid)
{
	PlayerInfo[playerid][pCarKey] = 0;
	CheckOwner(playerid);
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new string[256];
	new cmd[256];
	new tmp[256];
	new sendername[MAX_PLAYER_NAME];
	cmd = strtok(cmdtext, idx);
	new vehid = GetPlayerVehicleID(playerid);
	if(strcmp(cmd, "/carbuy", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        for(new i = 0; i < sizeof(CarInfo); i++)
	        {
				if(CarInfo[i][ownedvehicle] == vehid)
				{
					if(PlayerInfo[playerid][pCarKey]!=0)
					{
						SendClientMessage(playerid, COLOR_GREY, "You already own a car, type /car sell if you want to buy this one!");
						return 1;
					}
					if(CarInfo[i][cOwned]==1)
					{
					    SendClientMessage(playerid, COLOR_GREY, "Someone already owns this car");
					    return 1;
					}
					if(GetPlayerMoney(playerid) >= CarInfo[i][cValue])
					{
						PlayerInfo[playerid][pCarKey] = i;
						CarInfo[i][cOwned] = 1;
						CarOffered[playerid]=0;
						GetPlayerName(playerid, sendername, sizeof(sendername));
						strmid(CarInfo[i][cOwner], sendername, 0, strlen(sendername), 999);
						GivePlayerMoney(playerid,-CarInfo[i][cValue]);
						GameTextForPlayer(playerid, "~w~Congratulations~n~This is your car until you sell it!", 5000, 3);
						SendClientMessage(playerid, COLOR_GRAD2, "Congratulations on your new purchase!");
						SendClientMessage(playerid, COLOR_GRAD2, "Type /car manual to view the car manual!");
						TogglePlayerControllable(playerid, 1);
						SaveCars();
						return 1;
					}
					else
					{
						SendClientMessage(playerid, COLOR_GREY, "   You don't have the cash for that!");
						return 1;
					}
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd,"/car",true)==0)
	{
		new playername[MAX_PLAYER_NAME];
		GetPlayerName(playerid,playername,sizeof(playername));
	    tmp = strtok(cmdtext, idx);
	    if(!strlen(tmp))
	    {
	        SendClientMessage(playerid,COLOR_WHITE,"(( Use /car manual for detailed instructions for: ))");
	        SendClientMessage(playerid,COLOR_WHITE,"(( [FS]CarOwnership by Ipuvaepe ))");
	        return 1;
	    }
	    if(strcmp(tmp,"exit",true)==0)
	    {
	        CarOffered[playerid]=0;
	        RemovePlayerFromVehicle(playerid);
	        TogglePlayerControllable(playerid, 1);
	        return 1;
	    }
		if(strcmp(tmp, "manual", true) == 0)
		{
	    	if(IsPlayerConnected(playerid))
	    	{
	        	if(PlayerInfo[playerid][pCarKey]!=0)
	        	{
					format(string,sizeof(string),"________________%s________________",CarInfo[CheckOwner(playerid)][cDescription]);
					SendClientMessage(playerid, COLOR_GREEN,string);
					SendClientMessage(playerid, COLOR_GRAD2,"** /carbuy - Buys the car (if for sale)");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car sell - Sells the car");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car manual - Shows this list");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car exit - Exits the car");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car locate - Uses the car's On-Star to locate");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car lock - Locks the car");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car unlock - Unlocks the car");
					SendClientMessage(playerid, COLOR_GRAD2,"** /car autolock - Automatically locks the car upon exiting");
					return 1;
				}
				else
				{
				    SendClientMessage(playerid,COLOR_GRAD2,"** You do not currently own a car! **");
				    return 1;
				}
			}
			return 1;
		}
		if(strcmp(tmp, "buy", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
		    {
		        for(new i = 0; i < sizeof(CarInfo); i++)
		        {
					if(CarInfo[i][ownedvehicle] == vehid)
					{
						if(PlayerInfo[playerid][pCarKey]!=0)
						{
							SendClientMessage(playerid, COLOR_GREY, "You already own a car, type /carsell if you want to buy this one!");
							return 1;
						}
						if(CarInfo[i][cOwned]==1)
						{
						    SendClientMessage(playerid, COLOR_GREY, "Someone already owns this car");
						    return 1;
						}
						if(GetPlayerMoney(playerid) >= CarInfo[i][cValue])
						{
							PlayerInfo[playerid][pCarKey] = i;
							CarInfo[i][cOwned] = 1;
							CarOffered[playerid]=0;
							GetPlayerName(playerid, sendername, sizeof(sendername));
							strmid(CarInfo[i][cOwner], sendername, 0, strlen(sendername), 999);
							GivePlayerMoney(playerid,-CarInfo[i][cValue]);
							GameTextForPlayer(playerid, "~w~Congratulations~n~This is your car until you sell it!", 5000, 3);
							SendClientMessage(playerid, COLOR_GRAD2, "Congratulations on your new purchase!");
							SendClientMessage(playerid, COLOR_GRAD2, "Type /manual to view the car manual!");
							TogglePlayerControllable(playerid, 1);
							SaveCars();
							return 1;
						}
						else
						{
							SendClientMessage(playerid, COLOR_GREY, "   You don't have the cash for that!");
							return 1;
						}
					}
				}
			}
			return 1;
		}
		if(strcmp(tmp, "sell", true) == 0)
		{
		    if(IsPlayerConnected(playerid))
			{
				GetPlayerName(playerid, playername, sizeof(playername));
				if(PlayerInfo[playerid][pCarKey] == 0)
				{
					SendClientMessage(playerid, COLOR_GREY, "You don't own a car.");
					return 1;
				}
				if(PlayerInfo[playerid][pCarKey] != 0 && strcmp(playername, CarInfo[PlayerInfo[playerid][pCarKey]][cOwner], true) == 0)
				{
					new car = PlayerInfo[playerid][pCarKey];
					CarInfo[car][cOwned] = 0;
					GetPlayerName(playerid, sendername, sizeof(sendername));
					strmid(CarInfo[car][cOwner], "Dealership", 0, strlen("Dealership"), 999);
					GivePlayerMoney(playerid,CarInfo[car][cValue]);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "~w~You have sold your car for: ~n~~g~$%d", CarInfo[car][cValue]);
					GameTextForPlayer(playerid, string, 10000, 3);
					RemovePlayerFromVehicle(playerid);
					TogglePlayerControllable(playerid, 1);
					PlayerInfo[playerid][pCarKey] = 999;
					return 1;
				}
			}
			return 1;
		}
		if(strcmp(tmp, "locate", true) == 0)
		{
		    if(!IsPlayerConnected(playerid)) { return 1; }
		    if(PlayerInfo[playerid][pCarKey] == 0) { GameTextForPlayer(playerid, "~w~You do not have a car to locate", 2500, 3); return 1; }
		    if(cartrack[playerid]==0)
		    {
		        SendClientMessage(playerid,COLOR_WHITE,"On-Star: This is On-Star's automated vehicle tracking system");
		        SendClientMessage(playerid,COLOR_WHITE,"On-Star: Please enter your PIN # and password now");
		        SendClientMessage(playerid,COLOR_WHITE,"On-Star: Your vehicle's location is now uploaded to your phone");
		        SetPlayerCheckpoint(playerid,CarInfo[PlayerInfo[playerid][pCarKey]][cLocationx], CarInfo[PlayerInfo[playerid][pCarKey]][cLocationy], CarInfo[PlayerInfo[playerid][pCarKey]][cLocationz], 5.0);
		        cartrack[playerid] = 1;
		        return 1;
			}
			else
			{
		        SendClientMessage(playerid,COLOR_WHITE,"On-Star: This is On-Star's automated vehicle tracking system");
		        SendClientMessage(playerid,COLOR_WHITE,"On-Star: The tracking on your vehicle has been canceled");
		        DisablePlayerCheckpoint(playerid);
		        cartrack[playerid] = 0;
		        return 1;
			}
		}
		if(strcmp(tmp, "lock", true) == 0)
	    {
			new keycar = PlayerInfo[playerid][pCarKey];
	    	if(IsPlayerConnected(playerid))
	        {
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					SetVehicleParamsForPlayer(CarInfo[keycar][ownedvehicle],i,0,1);
				}
				format(string, sizeof(string), "~w~Car~n~~r~Locked");
				GameTextForPlayer(playerid, string, 10000, 3);
				CarInfo[keycar][cLock] = 1;
				return 1;
			}
		}
		if(strcmp(tmp, "unlock", true) == 0)
	    {
			new keycar = PlayerInfo[playerid][pCarKey];
	    	if(IsPlayerConnected(playerid))
	        {
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					SetVehicleParamsForPlayer(CarInfo[keycar][ownedvehicle],i,0,0);
				}
				format(string, sizeof(string), "~w~Car~n~~g~Unlocked");
				GameTextForPlayer(playerid, string, 10000, 3);
				CarInfo[keycar][cLock] = 0;
				return 1;
			}
		}
		if(strcmp(tmp, "autolock", true) == 0)
	    {
			new keycar = PlayerInfo[playerid][pCarKey];
	    	if(CarAutolock[CarInfo[keycar][ownedvehicle]] == 0) { CarAutolock[CarInfo[keycar][ownedvehicle]] = 1; format(string, sizeof(string), "~w~Car Autolock~n~~r~Engaged"); return 1; }
	    	if(CarAutolock[CarInfo[keycar][ownedvehicle]] == 1) { CarAutolock[CarInfo[keycar][ownedvehicle]] = 0; format(string, sizeof(string), "~w~Car Autolock~n~~g~Disengaged"); return 1; }
	    	GameTextForPlayer(playerid, string, 10000, 3);
	    	return 1;
		}
	}
	return 0;
}
/*----------Car Save Functions----------*/
public LoadCar()
{
	new arrCoords[13][64];
	new strFromFile2[256];
	new File: file = fopen("[FS]CarOwnership.cfg", io_read);
	if (file)
	{
		new idx = 0;
		while (idx < sizeof(CarInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			CarInfo[idx][cModel] = strval(arrCoords[0]);
			CarInfo[idx][cLocationx] = floatstr(arrCoords[1]);
			CarInfo[idx][cLocationy] = floatstr(arrCoords[2]);
			CarInfo[idx][cLocationz] = floatstr(arrCoords[3]);
			CarInfo[idx][cAngle] = floatstr(arrCoords[4]);
			CarInfo[idx][cColorOne] = strval(arrCoords[5]);
			CarInfo[idx][cColorTwo] = strval(arrCoords[6]);
			strmid(CarInfo[idx][cOwner], arrCoords[7], 0, strlen(arrCoords[7]), 255);
			strmid(CarInfo[idx][cDescription], arrCoords[8], 0, strlen(arrCoords[8]), 255);
			CarInfo[idx][cValue] = strval(arrCoords[9]);
			CarInfo[idx][cLicense] = strval(arrCoords[10]);
			CarInfo[idx][cOwned] = strval(arrCoords[11]);
			CarInfo[idx][cLock] = strval(arrCoords[12]);
			printf("CarInfo: %d Owner:%s LicensePlate %s",idx,CarInfo[idx][cOwner],CarInfo[idx][cLicense]);
			idx++;
		}
	}
	return 1;
}
public SaveCars()
{
	new idx;
	new File: file2;
	while (idx < sizeof(CarInfo))
	{
	    new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%d,%f,%f,%f,%f,%d,%d,%s,%s,%d,%s,%d,%d\n",
		CarInfo[idx][cModel],
		CarInfo[idx][cLocationx],
		CarInfo[idx][cLocationy],
		CarInfo[idx][cLocationz],
		CarInfo[idx][cAngle],
		CarInfo[idx][cColorOne],
		CarInfo[idx][cColorTwo],
		CarInfo[idx][cOwner],
		CarInfo[idx][cDescription],
		CarInfo[idx][cValue],
		CarInfo[idx][cLicense],
		CarInfo[idx][cOwned],
		CarInfo[idx][cLock]);
		if(idx == 0)
		{
			file2 = fopen("[FS]CarOwnership.cfg", io_write);
		}
		else
		{
			file2 = fopen("[FS]CarOwnership.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}
public OnVehicleRespray(vehicleid, color1, color2)
{
	for(new i = 0; i < sizeof(CarInfo); i++)
	{
	    if(vehicleid == CarInfo[i][ownedvehicle])
	    {
			CarInfo[i][cColorOne] = color1;
			CarInfo[i][cColorTwo] = color2;
			printf("[FS]CarOwnership report");
			printf("** Car %s[%d] painted %d and %d",CarInfo[i][cDescription],i,color1,color2);
		}
	}
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
	    for(new i = 0; i < sizeof(CarInfo); i++)
	    {
		    if(vehicleid == CarInfo[i][ownedvehicle])
		    {
		    	new Float:x,Float:y,Float:z;
				new Float:a;
				GetVehiclePos(vehicleid, x, y, z);
				GetVehicleZAngle(vehicleid, a);
				CarInfo[i][cLocationx] = x;
				CarInfo[i][cLocationy] = y;
				CarInfo[i][cLocationz] = z;
				CarInfo[i][cAngle] = a;
			}
			if(CarAutolock[vehicleid] == 1)
			{
			    for(new j = 0; j < MAX_PLAYERS; i++)
				{
					if (IsPlayerConnected(j))
					{
						SetVehicleParamsForPlayer(vehicleid,j,0,1);
						GameTextForPlayer(playerid,"~w~Car~n~~r~Autolocked",2500,3);
						return 1;
					}
				}
			}
		}
	}
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate==2)
	{
	    for(new i = 0; i < sizeof(CarInfo); i++)
	    {
	    	new newcar = GetPlayerVehicleID(playerid);
	    	new string[256];
        	if(newcar == CarInfo[i][ownedvehicle])
			{
			    if(CarInfo[i][cOwned]==0)
			    {
			        TogglePlayerControllable(playerid, 0);
			        CarOffered[playerid]=1;
			        format(string,sizeof(string),"~w~Car: %s~n~Price: ~g~%d~n~~w~/carbuy to buy this car",CarInfo[i][cDescription],CarInfo[i][cValue]);
					GameTextForPlayer(playerid,string,5000,5);
			    }
			}
		}
	}
	return 1;
}
public OnPlayerEnterCheckpoint(playerid)
{
	if(cartrack[playerid]!=0)
	{
		SendClientMessage(playerid,COLOR_YELLOW,"SMS: On-Star: Our sensors show that you have come within 5.0 metres of your vehicle");
		DisablePlayerCheckpoint(playerid);
		cartrack[playerid] = 0;
	}
	return 1;
}
