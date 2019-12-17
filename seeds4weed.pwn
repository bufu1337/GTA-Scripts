// Created by HadFuny
// Seeds4Weed
// www.hadfuny.tk
// www.passwords4porn.com
// www.warez4free.passwords4porn.com

#include <a_samp>
#include <dudb>
#include <dini>
#include <dutils>

new Seeds[MAX_PLAYERS];
new Weed[MAX_PLAYERS];
new Planted[MAX_PLAYERS];
new PlantedAmmount[MAX_PLAYERS];
forward Growing(playerid);

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#if defined FILTERSCRIPT


public OnFilterScriptInit() { print(""); return 1; }
public OnFilterScriptExit() { return 1; }
#else
main() { print(""); }
#endif


public OnGameModeInit()
{
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new formatZ[256];
	format(formatZ,sizeof(formatZ),"%s.hf",PlayerName(playerid));
	if(!udb_Exists(formatZ))
	{
		udb_Create(formatZ,"209010");
	}
    Seeds[playerid] = dUserINT(formatZ).("Seeds");
    Weed[playerid] = dUserINT(formatZ).("Weed");
    Planted[playerid] = dUserINT(formatZ).("Planted");
    PlantedAmmount[playerid] = dUserINT(formatZ).("PlantedAmmount");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new formatZ2[256];
	format(formatZ2,sizeof(formatZ2),"%s.hf",PlayerName(playerid));
	dUserSetINT(formatZ2).("Seeds",Seeds[playerid]);
    dUserSetINT(formatZ2).("Weed",Weed[playerid]);
    dUserSetINT(formatZ2).("Planted",Planted[playerid]);
    dUserSetINT(formatZ2).("PlantedAmmount",Weed[playerid]);
	return 1;
}

stock PlayerName(playerid) {
	new name[255];
	GetPlayerName(playerid, name, 255);
	return name;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

dcmd_buyseeds(playerid, params[])
{
    new ammount;
    if (sscanf(params, "u", ammount)) SendClientMessage(playerid, 0xFF0000AA, "Usage: \"/buyseeds <ammount>\"");
    else {
        if(GetPlayerMoney(playerid) <= 10*ammount) {
            Seeds[playerid] += ammount;
            GivePlayerMoney(playerid, -10*ammount);
        }
        else {
            SendClientMessage(playerid, 0xFF0000AA, "You do not have enough money!");
        }
    }
    return 1;
}


dcmd_plantseeds(playerid, params[])
{
    new ammount;
    if (sscanf(params, "u", ammount)) SendClientMessage(playerid, 0xFF0000AA, "Usage: \"/plantseeds <ammount>\"");
    else {
        if(ammount >= Seeds[playerid])
        {
            SendClientMessage(playerid, 0xFF0000AA, "You do not have so many seeds!");
        }
        else if(Seeds[playerid] == 0) {
            SendClientMessage(playerid, 0xFF0000AA, "You do not have any seeds, buy them! /buyseeds");
        }
        Seeds[playerid] -= ammount;
        PlantedAmmount[playerid] += ammount;
        Planted[playerid] = 1;
        SetTimer("Growing",600000,false);
    }
    return 1;
}


dcmd_pickup(playerid, params[])
{
#pragma unused params
    if(Planted[playerid] == 1) {
        SendClientMessage(playerid, 0xFF0000AA, "Your seeds/plants have not growed fully please be patient!");
    }
    else {
        Weed[playerid] += PlantedAmmount[playerid];
        PlantedAmmount[playerid] -= Weed[playerid];
    }
    return 1;
}


dcmd_sellweed(playerid, params[])
{
    new ammount;
    if (sscanf(params, "u", ammount)) SendClientMessage(playerid, 0xFF0000AA, "Usage: \"/sellweed <ammount>\"");
    else {
        if(ammount >= Weed[playerid])
        {
            SendClientMessage(playerid, 0xFF0000AA, "You do not have so many weed!");
        }
        else if(Weed[playerid] == 0) {
            SendClientMessage(playerid, 0xFF0000AA, "You do not have weed, buy seeds and let them grow! /buyseeds");
        }
        GivePlayerMoney(playerid, 15*ammount);
        Weed[playerid] -= ammount;
    }
    return 1;
}


public Growing(playerid)
{
	Planted[playerid] = 0;
	SendClientMessage(playerid, 0xFF0000AA, "Your seeds/plants have growed, they are ready to be picked up! (/pickup)");
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(buyseeds,8, cmdtext);
    dcmd(plantseeds,10, cmdtext);
    dcmd(pickup,6, cmdtext);
    dcmd(sellweed,8, cmdtext);
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

stock sscanf(string[], format[], {Float,_}:...)
{
	#if defined isnull
		if (isnull(string))
	#else
		if (string[0] == 0 || (string[0] == 1 && string[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		stringPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (string[stringPos] && string[stringPos] <= ' ')
	{
		stringPos++;
	}
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
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					num = 0,
					ch = string[stringPos];
				do
				{
					stringPos++;
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
						default:
						{
							return -1;
						}
					}
				}
				while ((ch = string[stringPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, string[stringPos++]);
			}
			case 'f':
			{

				new changestr[16], changepos = 0, strpos = stringPos;
				while(changepos < 16 && string[strpos] && string[strpos] != delim)
				{
					changestr[changepos++] = string[strpos++];
    				}
				changestr[changepos] = '\0';
				setarg(paramPos,0,_:floatstr(changestr));
			}
			case 'p':
			{
				delim = format[formatPos++];
				continue;
			}
			case '\'':
			{
				new
					end = formatPos - 1,
					ch;
				while ((ch = format[++end]) && ch != '\'') {}
				if (!ch)
				{
					return -1;
				}
				format[end] = '\0';
				if ((ch = strfind(string, format[formatPos], false, stringPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				stringPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = stringPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = string[++end]) && ch != delim)
				{
					if (num)
					{
						if ('0' <= ch <= '9')
						{
							id = (id * 10) + (ch - '0');
						}
						else
						{
							num = false;
						}
					}
				}
				if (num && IsPlayerConnected(id))
				{
					setarg(paramPos, 0, id);
				}
				else
				{
					#if !defined foreach
						#define foreach(%1,%2) for (new %2 = 0; %2 < MAX_PLAYERS; %2++) if (IsPlayerConnected(%2))
						#define __SSCANF_FOREACH__
					#endif
					string[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - stringPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, string[stringPos], true, id))
						{
							setarg(paramPos, 0, playerid);
							num = true;
							break;
						}
					}
					if (!num)
					{
						setarg(paramPos, 0, INVALID_PLAYER_ID);
					}
					string[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				stringPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = string[stringPos++]) && ch != delim)
					{
						setarg(paramPos, i++, ch);
					}
					if (!i)
					{
						return -1;
					}
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
		while (string[stringPos] && string[stringPos] != delim && string[stringPos] > ' ')
		{
			stringPos++;
		}
		while (string[stringPos] && (string[stringPos] == delim || string[stringPos] <= ' '))
		{
			stringPos++;
		}
		paramPos++;
	}
	do
	{
		if ((delim = format[formatPos++]) > ' ')
		{
			if (delim == '\'')
			{
				while ((delim = format[formatPos++]) && delim != '\'') {}
			}
			else if (delim != 'z')
			{
				return delim;
			}
		}
	}
	while (delim > ' ');
	return 0;
}