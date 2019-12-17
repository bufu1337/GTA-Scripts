/*
* Name: Carmod
* Version: v2.2.0
* Author: Xalphox
* Type: Gamemode
* 
* Description: Car ownership and event stuff.
*/

#include <a_samp>
#include <dutils>

#define MAX_TRUNK_SLOTS		(5) // Is actually 4.
#define MAX_VEHICLE_MODELS	(70)
#define MAX_PLYVEH_RATIO	(20) // per player.
#define MAX_VEHICLE_PLATE	(7)

#define CARMOD_FILE_LOC "carmod/carmod.ini"
#define CARMOD_STARTDELAY	(2000)

forward BuildVehicles()

new bool:localVehicle[MAX_VEHICLES]

new IsVehicleOwned[MAX_VEHICLES]
new vehOwnerName[MAX_VEHICLES][MAX_PLAYER_NAME]
new bool:vehLocked[MAX_VEHICLES] = false

new vehTrunkCounter[MAX_VEHICLES] = 1
new vehTrunk[MAX_VEHICLES][MAX_TRUNK_SLOTS]
new vehTrunkAmmo[MAX_VEHICLES][MAX_TRUNK_SLOTS]
new Float:vehTrunkArmour[MAX_VEHICLES] = 0

stock CheckPlayerDistanceToVehicle(Float:radi, playerid, vehicleid)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:PX,Float:PY,Float:PZ,Float:X,Float:Y,Float:Z;
		GetPlayerPos(playerid,PX,PY,PZ);
		GetVehiclePos(vehicleid, X,Y,Z);
		new Float:Distance = (X-PX)*(X-PX)+(Y-PY)*(Y-PY)+(Z-PZ)*(Z-PZ);
		if(Distance <= radi*radi)
		{
			return 1;
		}
	}
	return 0;
}

stock ToggleVehicleLocked(vehicleid, bool:locked)
{
	vehLocked[vehicleid] = locked
	for(new i; i != MAX_PLAYERS; i++)
	{
		SetVehicleParamsForPlayer(vehicleid, i, false, locked)
	}
}

public OnFilterScriptInit()
{
	// The loading of carmod has to be delayed a few seconds, as to ensure that it's loaded after GF.
	SetTimer("BuildVehicles", CARMOD_STARTDELAY, false)
}

public OnFilterScriptExit()
{
	for(new i; i != MAX_VEHICLES; i++)
	{
		if(localVehicle[i])
		{
			printf("[CARMOD] Destroyed vehicle [%i]", i)
			DestroyVehicle(i)
		}
	}
}

public OnPlayerConnect(playerid)
{
	for(new i; i != MAX_VEHICLES; i++)
	{
		if(vehLocked[i])
		{
			SetVehicleParamsForPlayer(i, playerid, false, true)
		}
	}
}

public BuildVehicles()
{
	new File:carfile = fopen(CARMOD_FILE_LOC, io_read)
	new linebuffer[200] // Stores the value of each line.
	
	// This checks it exists.
	if(carfile)
	{
		// This reads by line, starts off with "{owner, plate, modelid, col1, col2, x, y, z, ang}"
		while(fread(carfile, linebuffer))
		{
			// Check for INI stuff
			if(strfind(linebuffer, ";", true, 0) != -1 || strlen(linebuffer) != 0)
			{
				new tmp[10][MAX_PLAYER_NAME]
				new vehOwner[MAX_PLAYER_NAME], vehPlate[MAX_PLAYER_NAME]
				new vehModel, vehCol1, vehCol2
				new Float:vehX, Float:vehY, Float:vehZ, Float:vehAng
				
				new len = strlen(linebuffer)
				
				strdel(linebuffer, 0, 1) // "owner, plate, modelid, carcol1, col2, x, y, z, ang}" 
				strdel(linebuffer, (len-1), len) // "owner, plate, modelid, col1, col2, x, y, z, ang"
				
				split(linebuffer, tmp, ':')
				
				vehOwner = tmp[0]
				vehPlate = tmp[1]
				
				vehModel = strval(tmp[2])
				vehCol1 = strval(tmp[3])
				vehCol2 = strval(tmp[4])
				
				vehX = floatstr(tmp[5])
				vehY = floatstr(tmp[6])
				vehZ = floatstr(tmp[7])
				vehAng = floatstr(tmp[8])
				
				new veh = CreateVehicle(vehModel, vehX, vehY, vehZ, vehAng, vehCol1, vehCol2, 999999)
				printf("[CARMOD] Vehicle added [%i]: %s (%s) <X: %f, Y: %f, Z: %f, ROT:%f>", veh, vehOwner, vehPlate, vehX, vehY, vehZ, vehAng)
				localVehicle[veh] = true
				
				if(strlen(vehOwner)) // False returns "0", so this is basically if vehOwner has any value.
				{
					ToggleVehicleLocked(veh, true)
					IsVehicleOwned[veh] = true
					copy(vehOwnerName[veh], vehOwner, MAX_PLAYER_NAME)
				}
			}
		}
		fclose(carfile)
	}
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{	
	if(!ispassenger)
	{
		if(IsVehicleOwned[vehicleid])
		{
			new plyName[MAX_PLAYER_NAME]
			GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
			
			new buffer[512]
			format(buffer, sizeof(buffer), "[CARMOD] This car is owned by: %s.", vehOwnerName[vehicleid])
			SendClientMessage(playerid, 0xFF0000FF, buffer)
		}
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if(!strcmp("/carmod", cmdtext, true))
	{
		SendClientMessage(playerid, 0xFF0000FF, "- CARMOD -")
		SendClientMessage(playerid, 0xFF0000FF, "Author: Xalphox (Jonathon_Cruscoe)")
		SendClientMessage(playerid, 0xFF0000FF, "Version: V2.3.0")
		SendClientMessage(playerid, 0xFF0000FF, "")
		SendClientMessage(playerid, 0xFF0000FF, "Commands:")
		SendClientMessage(playerid, 0xFF0000FF, "RCON ADMIN: /addveh, /avehlock, /avehlockall, /avehunlock")
		SendClientMessage(playerid, 0xFF0000FF, "ALL: /vehlock, /storeweapon, /takeweapon, /storearmour, /takearmour, /vehcount")
	}
	
	// /addveh Jonathon_Cruscoe 490 0 0 -1
	if(!strcmp("/addveh", cmdtext, true, 8))
	{
		if(IsPlayerAdmin(playerid))
		{
			if(cmdtext[8] == ' ')
			{
				if(strlen(cmdtext) > 9) // Makes sure there's actually something there.
				{
					new tmp[5][MAX_PLAYER_NAME]
					new vehOwner[MAX_PLAYER_NAME], vehPlate[MAX_PLAYER_NAME]
					new vehModel, vehCol1, vehCol2
					new Float:vehX, Float:vehY, Float:vehZ, Float:vehAng
					
					strdel(cmdtext, 0, 8) // Trims off the "/addveh "
					split(cmdtext, tmp, ' ')
					
					vehOwner = tmp[0]
					vehPlate = ""
					vehModel = strval(tmp[1])
					vehCol1 = strval(tmp[2])
					vehCol2 = strval(tmp[3])
					vehAng = strval(tmp[4])
					GetPlayerPos(playerid, vehX, vehY, vehZ)
					
					if(vehAng == -1)
					{
						GetPlayerFacingAngle(playerid, vehAng)
					}
					
					if(vehModel >= 400 && vehModel <= 611)
					{
						new File:carfile = fopen(CARMOD_FILE_LOC, io_append)
						new buffer[1024]
						new veh = CreateVehicle(vehModel, vehX, vehY, vehZ, vehAng, vehCol1, vehCol2, 999999)
						
						format(buffer, sizeof(buffer), "[CARMOD] Vehicle added [%i]: %s (%s) <X: %f, Y: %f, Z: %f, ROT:%f>", veh, vehOwner, vehPlate, vehX, vehY, vehZ, vehAng)
						print(buffer)
						SendClientMessageToAll(0xFF0000FF, buffer)
						
						localVehicle[veh] = true
						
						if(strlen(vehOwner)) // False returns "0", so this is basically if vehOwner has any value.
						{
							ToggleVehicleLocked(veh, true)
							IsVehicleOwned[veh] = true
							copy(vehOwnerName[veh], vehOwner, MAX_PLAYER_NAME)
						}
						
						// File function:
						if(carfile)
						{
							// {owner:plate:model:col:col2:x:y:z:ang}
							new cmd[1024]
							format(cmd, sizeof(cmd), "{%s:%s:%i:%i:%i:%f:%f:%f:%f}\r\n", vehOwner, vehPlate, vehModel, vehCol1, vehCol2, vehX, vehY, vehZ, vehAng)
							fwrite(carfile, cmd)
							fclose(carfile)
						}
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Invalid Model ID")
					}
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Syntax: /addveh <name> <modelid> <col1> <col2> <ang (-1 = where you're pointing)>")
				}
			}else{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Syntax: /addveh <name> <modelid> <col1> <col2> <ang (-1 = where you're pointing)>")
			}
		}else{
			SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You need to be an RCON admin to use this.")
		}
		return 1
	}
	
	if(!strcmp("/vehlock", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			if(IsVehicleOwned[i])
			{	
				if(strcmp(vehOwnerName[i], plyName, true) == 0)
				{
					new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
					if(dist)
					{
						result = i
						counter++
					}
				}
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car owned by you located near you.")
			}
			
			case 1:
			{
				if(!vehLocked[result])
				{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Car locked.")
					vehLocked[result] = true
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Car unlocked.")
					vehLocked[result] = false
				}
				
				ToggleVehicleLocked(result, vehLocked[result])
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one of your cars detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	if(!strcmp("/avehlock", cmdtext, true))
	{
		if(IsPlayerAdmin(playerid))
		{
			new counter = 0
			new result
			new plyName[MAX_PLAYER_NAME]
			
			GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
			for(new i; i != MAX_VEHICLES; i++)
			{
				new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
				if(dist)
				{
					result = i
					counter++
				}
			}
			
			switch(counter)
			{
				case 0:
				{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car owned by you located near you.")
				}
				
				case 1:
				{
					if(!vehLocked[result])
					{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Car locked.")
						vehLocked[result] = true
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] Car unlocked.")
						vehLocked[result] = false
					}
					
					ToggleVehicleLocked(result, vehLocked[result])
				}
				
				default:
				{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one of your cars detected detected in the vercinity.")
				}
			}
		}else{
			SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You need to be RCON admin to use this command.")
		}
		return 1
	}
	
	if(!strcmp("/avehlockall", cmdtext, true))
	{
		if(IsPlayerAdmin(playerid))
		{
			new plyName[MAX_PLAYER_NAME]
			new buffer[512]
			
			GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
			format(buffer, sizeof(buffer), "[CARMOD] All vehicles locked by admin: %s.", plyName)
			
			SendClientMessageToAll(0xFF0000FF, buffer)
			
			for(new i; i != MAX_VEHICLES; i++)
			{
				if(localVehicle[i])
				{
					ToggleVehicleLocked(i, true)
				}
			}
		}else{
			SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You need to be RCON admin to use this command.")
		}
		return 1
	}
	
	if(!strcmp("/avehunlockall", cmdtext, true))
	{
		if(IsPlayerAdmin(playerid))
		{
			new plyName[MAX_PLAYER_NAME]
			new buffer[512]
			
			GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
			format(buffer, sizeof(buffer), "[CARMOD] All vehicles unlocked by admin: %s.", plyName)
			
			SendClientMessageToAll(0xFF0000FF, buffer)
			
			for(new i; i != MAX_VEHICLES; i++)
			{
				ToggleVehicleLocked(i, false)
			}
		}else{
			SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You need to be RCON admin to use this command.")
		}
		return 1
	}
	
	if(!strcmp("/vehcount", cmdtext, true))
	{
		new buffer[512]
		
		new bot = CreateVehicle(400, 0, 0, 0, 0, 0, 0, 1000)
		new vehiclecount = (bot-1)
		DestroyVehicle(bot)
		
		new modelcount = 0
		new vehModelUsed[MAX_VEHICLES]
		
		for(new i; i != MAX_VEHICLES; i++)
		{
			new vehModel = GetVehicleModel(i)
			if(!vehModelUsed[vehModel])
			{
				modelcount++
				vehModelUsed[vehModel] = true
			}
		}
		
		format(buffer, sizeof(buffer), "[CARMOD] Vehicle slots taken: %i/%i, model slots taken: %i/%i", vehiclecount, MAX_VEHICLES, modelcount, MAX_VEHICLE_MODELS)
		SendClientMessage(playerid, 0xFF0000FF, buffer)
		return 1
	}
	
	if(!strcmp("/storeweapon", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
			if(dist)
			{
				result = i
				counter++
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car located near you.")
			}
			
			case 1:
			{
				if(vehTrunkCounter[result] != (MAX_TRUNK_SLOTS-1))
				{
					if(!vehLocked[result] && !IsPlayerInAnyVehicle(playerid))
					{
						new buffer[512]
						new gunname[100]
						new gunID = GetPlayerWeapon(playerid)
						new gunAmmo = GetPlayerAmmo(playerid)
						
						new plyWeapons[12]
						new plyAmmo[12]
						
						if(gunID != 0)
						{
							GetWeaponName(gunID, gunname, sizeof(gunname))
							
							// Step 1: Store all the players guns (except for the one being put in the car.)
							for(new slot = 0; slot != 12; slot++)
							{
								new wep, ammo
								GetPlayerWeaponData(playerid, slot, wep, ammo)
								if(wep != gunID)
								{
									GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot])
								}
							}
							
							// Step 2: Store the gun being put in the car and display the message.
							vehTrunkCounter[result]++
							vehTrunk[result][vehTrunkCounter[result]] = gunID
							vehTrunkAmmo[result][vehTrunkCounter[result]] = gunAmmo
							
							format(buffer, sizeof(buffer), "[CARMOD] You put your %s (AMMO: %i) in the car's trunk.", gunname, gunAmmo)
							SendClientMessage(playerid, 0xFF0000FF, buffer)
							
							// This adds back your guns EXCEPT for the one stored.
							ResetPlayerWeapons(playerid)
							for(new slot = 0; slot != 12; slot++)
							{
								GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot])
							}
						}else{
							SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You can't store your hands in the car!")
						}
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You couldn't open the trunk.")
					}
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This car's trunk is full.")
				}
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one car detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	
	if(!strcmp("/takeweapon", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
			if(dist)
			{
				result = i
				counter++
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car located near you.")
			}
			
			case 1:
			{
				if(!vehLocked[result])
				{
					if(vehTrunkCounter[result] != 0)
					{
						new buffer[512]
						new gunName[100]
						
						GivePlayerWeapon(playerid, vehTrunk[result][vehTrunkCounter[result]], vehTrunkAmmo[result][vehTrunkCounter[result]])
						GetWeaponName(vehTrunk[result][vehTrunkCounter[result]], gunName, sizeof(gunName))
						
						format(buffer, sizeof(buffer), "[CARMOD] You've taken a %s (AMMO: %i) from the vehicle.", gunName, vehTrunkAmmo[result][vehTrunkCounter[result]])
						SendClientMessage(playerid, 0xFF0000FF, buffer)
						
						vehTrunk[result][vehTrunkCounter[result]] = '\0'
						vehTrunkAmmo[result][vehTrunkCounter[result]] = '\0'
						vehTrunkCounter[result]--
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] The trunk is empty.")
					}
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This car is locked, so you couldn't open the trunk.")
				}
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one car detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	if(!strcmp("/storearmour", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
			if(dist)
			{
				result = i
				counter++
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car located near you.")
			}
			
			case 1:
			{
				if(!vehLocked[result])
				{
					new Float:plyArmour
					GetPlayerArmour(playerid, plyArmour)
					
					if(plyArmour != 0)
					{
						SetPlayerArmour(playerid, 0)
						vehTrunkArmour[result] = plyArmour
						
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You took off the body armour and put it in the car's trunk.")
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You haven't got any armour.")
					}
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This car is locked, so you couldn't open the trunk.")
				}
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one car detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	if(!strcmp("/takearmour", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
			if(dist)
			{
				result = i
				counter++
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car located near you.")
			}
			
			case 1:
			{
				if(!vehLocked[result])
				{
					if(vehTrunkArmour[result] != 0)
					{
						SetPlayerArmour(playerid, vehTrunkArmour[result])
						vehTrunkArmour[result] = 0
						
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] You took the body armour from the car and put it on.")
					}else{
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] There's no armour in the trunk.")
					}
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This car is locked, so you couldn't open the trunk.")
				}
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one car detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	if(!strcmp("/trunk", cmdtext, true))
	{
		new counter = 0
		new result
		new plyName[MAX_PLAYER_NAME]
		
		GetPlayerName(playerid, plyName, MAX_PLAYER_NAME)
		for(new i; i != MAX_VEHICLES; i++)
		{
			new dist = CheckPlayerDistanceToVehicle(5, playerid, i)
			if(dist)
			{
				result = i
				counter++
			}
		}
		
		switch(counter)
		{
			case 0:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] No car located near you.")
			}
			
			case 1:
			{
				if(!vehLocked[result])
				{
					new buffer[512]
					SendClientMessage(playerid, 0xFF0000FF, "- Carmod Trunk: -")
					for(new slot = 1; slot != MAX_TRUNK_SLOTS; slot++)
					{
						new gunname[100]
						if(vehTrunk[result][slot] != 0)
						{
							GetWeaponName(vehTrunk[result][slot], gunname, sizeof(gunname))
							format(buffer, sizeof(buffer), "[CARMOD] Slot %i: %s (AMMO: %i)", slot, gunname, vehTrunkAmmo[result][slot])
							SendClientMessage(playerid, 0xFF0000FF, buffer)
						}else{
							format(buffer, sizeof(buffer), "[CARMOD] Slot %i: Empty (AMMO: N/A)", slot)
							SendClientMessage(playerid, 0xFF0000FF, buffer)
						}
					}
					format(buffer, sizeof(buffer), "[CARMOD] BODY ARMOUR: %f%", vehTrunkArmour[result])
					SendClientMessage(playerid, 0xFF0000FF, buffer)
					if(GetVehicleModel(result) == 490)
					{
						SendClientMessage(playerid, 0xFF0000FF, "")
						SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This vehicle has different sets of clothes. Use /vehskin to use them.")
					}
					
				}else{
					SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This car is locked, so you couldn't open the trunk.")
				}
			}
			
			default:
			{
				SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] More than one car detected detected in the vercinity.")
			}
		}
		return 1
	}
	
	// And backwards compatiblility.
	if(!strcmp("/storetrunk", cmdtext, true))
	{
		SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This command has been replaced by: /storeweapon. For details, say /carmod.")
		return 1
	}
	
	if(!strcmp("/taketrunk", cmdtext, true))
	{
		SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This command has been replaced by: /takeweapon. For details, say /carmod.")
		return 1
	}
	
	if(!strcmp("/modelcount", cmdtext, true))
	{
		SendClientMessage(playerid, 0xFF0000FF, "[CARMOD] This command has been replaced by: /vehcount. For details, say /carmod.")
		return 1
	}
	return 0
}
