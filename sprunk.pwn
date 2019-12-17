#include <a_samp>

#define SprunkFile "sprunkin machines.txt"
#define MAX_VENDING_MACHINES 50
#define COLOR_RED 0xE81C1CFF
#define COLOR_GREEN 0x6CEB12FF

#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

enum sprunkEnum
{
	SprunkObjectID,
	SprunkModelID,
	Float:SprunkObjectX1,
	Float:SprunkObjectY1,
	Float:SprunkObjectX2,
	Float:SprunkObjectY2,
	Float:SprunkObjectZ,
	Float:SprunkObjectA,
	Float:SprunkHeal,
	SprunkPrice,
	bool:SprunkCreated,
};

new SprunkMachines[MAX_VENDING_MACHINES][sprunkEnum];

enum vendingEnum
{
	vmName[64],
	vmModel,
};

new VendingMachines[3][vendingEnum] = {
	{"Sprunk", 1775},
	{"Cola", 1302},
	{"Food", 1776}
};

forward Float:zOffsetCheck(modelid);

Float:zOffsetCheck(modelid)
{
	if(modelid == 1302)
		return 1.132;
	return 0.0;
}

stock GetXYInFrontOfSprunk(&Float:X, &Float:Y, Float:A)
{
	X += (0.75*floatsin(-A,degrees));
	Y += (0.75*floatcos(-A,degrees));
	return 1;
}

public OnFilterScriptInit()
{
	print("\n ____________________ ");
	print("|                    |");
	print("|   -- SPRUNKIN --   |");
	print("|    ____________    |");
	print("|   |############| O |");
	print("|   |##$######$##| O |");
	print("|   |############| O |");
	print("|   |____________| O |");
	print("|                  O |");
	print("|     o o o o o    O |");
	print("|        o o         |");
	print("|____________________|");
	print("STARTED - BY: TR1VIUM\n");


	new File:file = fopen(SprunkFile, io_readwrite), Float:X, Float:Y;
	if(file)
	{
		new string[128], i = 0;
		while(fread(file, string, 128))
		{
  			sscanf(string, "ifffffi", SprunkMachines[i][SprunkModelID], SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ], SprunkMachines[i][SprunkObjectA], SprunkMachines[i][SprunkHeal], SprunkMachines[i][SprunkPrice]);
			SprunkMachines[i][SprunkObjectID] = CreateObject(SprunkMachines[i][SprunkModelID], SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ]-zOffsetCheck(SprunkMachines[i][SprunkModelID]), 0.0, 0.0, SprunkMachines[i][SprunkObjectA]-180);
            X = SprunkMachines[i][SprunkObjectX1], Y = SprunkMachines[i][SprunkObjectY1];
     		GetXYInFrontOfSprunk(X, Y, SprunkMachines[i][SprunkObjectA]);
  			SprunkMachines[i][SprunkObjectX2] = X, SprunkMachines[i][SprunkObjectY2] = Y;
			SprunkMachines[i][SprunkCreated] = true;
			i++;
		}
		fclose(file);
	}
	SendClientMessageToAll(COLOR_RED, "SPRUNKING COMMANDS!!");
	SendClientMessageToAll(COLOR_RED, "/createsprunk, /removesprunk, /vendingmachines");
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < MAX_VENDING_MACHINES; i++)
	    if(SprunkMachines[i][SprunkCreated])
	    {
	    	DestroyObject(SprunkMachines[i][SprunkObjectID]);
	   }
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(sprunkhelp, 10, cmdtext);
	dcmd(createsprunk, 12, cmdtext);
	dcmd(removesprunk, 12, cmdtext);
	dcmd(vendingmachines, 15, cmdtext);
	return 0;
}


public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
	    for(new i = 0; i < MAX_VENDING_MACHINES; i++)
	    {
	        if(!SprunkMachines[i][SprunkCreated])
	            continue;
	            
	        if(PlayerToPoint(0.5, playerid, SprunkMachines[i][SprunkObjectX2], SprunkMachines[i][SprunkObjectY2], SprunkMachines[i][SprunkObjectZ]))
	        {
	            if(GetPlayerMoney(playerid) < SprunkMachines[i][SprunkPrice])
	            {
					PlayerPlaySound(playerid, 1055, SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ]);
					// SendClientMessage(playerid, COLOR_RED, "SERVER: YOU DONT HAVE ENOUGH MONEY");
					break;
	            }
				new Float:health;
				GetPlayerHealth(playerid, health);
				if(health + SprunkMachines[i][SprunkHeal] >= 100)
				    SetPlayerHealth(playerid, 100.0);
				else
				    SetPlayerHealth(playerid, health + SprunkMachines[i][SprunkHeal]);
				GivePlayerMoney(playerid, -SprunkMachines[i][SprunkPrice]);
				SetPlayerFacingAngle(playerid, SprunkMachines[i][SprunkObjectA]-180.0);
				ApplyAnimation(playerid, "VENDING", "VEND_Use",1.5,1,0,0,0,2500);
				PlayerPlaySound(playerid, 1084, SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ]);
				return 1;
	        }
	    }
	}
	return 1;
}

dcmd_sprunkhelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_RED, "SPRUNKING COMMANDS!!");
	SendClientMessage(playerid, COLOR_RED, "/createsprunk, /removesprunk, /vendingmachines");
	#pragma unused params
	return 1;
}

dcmd_createsprunk(playerid, params[])
{
	if(!IsPlayerAdmin(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "§ Admin only.");

	if(GetPlayerState(playerid) == 1)
	{
	    new string[128], Float:heal, price;
	    if(sscanf(params, "sfi", string, heal, price))
		{
			SendClientMessage(playerid, COLOR_RED, "§ /createsprunk [vendingmachine] [heal bonus] [price]");
			return SendClientMessage(playerid, COLOR_RED, "  Type /vendingmachines");
		}
		else
		{
			for(new int = 0; int < sizeof(VendingMachines); int++)
			{
			    if(strcmp(string, VendingMachines[int][vmName], true))
			        continue;

			    for(new i = 0; i < MAX_VENDING_MACHINES; i++)
			    {
					if(SprunkMachines[i][SprunkCreated])
						continue;
						
				    GetPlayerPos(playerid, SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ]);
				    GetPlayerFacingAngle(playerid, SprunkMachines[i][SprunkObjectA]);
	   			    SprunkMachines[i][SprunkHeal] = heal;
	   			    SprunkMachines[i][SprunkPrice] = price;
	   			    SprunkMachines[i][SprunkModelID] = VendingMachines[int][vmModel];
	   			    SprunkMachines[i][SprunkCreated] = true;
		   			new File:file = fopen(SprunkFile, io_append);
					if (file)
					{
					    format(string, 128, "%i %f %f %f %f %f %i \r\n", SprunkMachines[i][SprunkModelID], SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ], SprunkMachines[i][SprunkObjectA], SprunkMachines[i][SprunkHeal], SprunkMachines[i][SprunkPrice]);
		   				fwrite(file, string);
                        fclose(file);
                    }
                
                    new Float:X, Float:Y;
					SprunkMachines[i][SprunkObjectID] = CreateObject(SprunkMachines[i][SprunkModelID], SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ]-zOffsetCheck(SprunkMachines[i][SprunkModelID]), 0.0, 0.0, SprunkMachines[i][SprunkObjectA]-180);
		            X = SprunkMachines[i][SprunkObjectX1], Y = SprunkMachines[i][SprunkObjectY1];
		     		GetXYInFrontOfSprunk(X, Y, SprunkMachines[i][SprunkObjectA]);
		  			SprunkMachines[i][SprunkObjectX2] = X, SprunkMachines[i][SprunkObjectY2] = Y;
					SprunkMachines[i][SprunkCreated] = true;
					SetPlayerPos(playerid, SprunkMachines[i][SprunkObjectX2], SprunkMachines[i][SprunkObjectY2], SprunkMachines[i][SprunkObjectZ]);
					SaveVendingMachines();
					return 1;
				}
				return SendClientMessage(playerid, COLOR_RED, "§ No vending machine spots left..Type /removesprunk.");
			}
			return SendClientMessage(playerid, COLOR_RED, "§ Invalid vending machine name. Type /vendingmachines.");
		}
	}
	else
	    return SendClientMessage(playerid, COLOR_RED, "§ You must be on foot.");
	#pragma unused params
}

dcmd_removesprunk(playerid, params[])
{
	if(!IsPlayerAdmin(playerid))
	    return SendClientMessage(playerid, COLOR_RED, "§ Admin only.");

	if(GetPlayerState(playerid) == 1)
	{
	    for(new i = 0; i < MAX_VENDING_MACHINES; i++)
	    {
	        if(!SprunkMachines[i][SprunkCreated])
	            continue;

	        if(PlayerToPoint(0.5, playerid, SprunkMachines[i][SprunkObjectX2], SprunkMachines[i][SprunkObjectY2], SprunkMachines[i][SprunkObjectZ]))
	        {
                SprunkMachines[i][SprunkCreated] = false;
                SendClientMessage(playerid, COLOR_GREEN, "§ You succesfully removed the vending machine.");
                DestroyObject(SprunkMachines[i][SprunkObjectID]);
	    		SaveVendingMachines();
				return 1;
	        }
	    }
	    return SendClientMessage(playerid, COLOR_RED, "§ You're not at a vending machine.");
	}
	else
	    return SendClientMessage(playerid, COLOR_RED, "§ You must be on foot.");
	#pragma unused params
}

dcmd_vendingmachines(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Vending Machines:");
	for(new i = 0; i < sizeof(VendingMachines); i++)
	    SendClientMessage(playerid, COLOR_GREEN, VendingMachines[i][vmName]);
	#pragma unused params
	return 1;
}

SaveVendingMachines()
{
    new File:file = fopen(SprunkFile, io_write), string[128];
	if (file)
	{
		for(new i = 0; i < MAX_VENDING_MACHINES; i++)
		{
		    if(!SprunkMachines[i][SprunkCreated])
		        continue;

		    format(string, 128, "%i %f %f %f %f %f %i \r\n", SprunkMachines[i][SprunkModelID], SprunkMachines[i][SprunkObjectX1], SprunkMachines[i][SprunkObjectY1], SprunkMachines[i][SprunkObjectZ], SprunkMachines[i][SprunkObjectA], SprunkMachines[i][SprunkHeal], SprunkMachines[i][SprunkPrice]);
			fwrite(file, string);
		}
		fclose(file);
	}
	return 1;
}

PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z) // Not by me.
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

stock sscanf(text[], format[], {Float,_}:...) // Not by me.
{
	#if defined isnull
		if (isnull(text))
	#else
		if (text[0] == 0 || (text[0] == 1 && text[1] == 0))
	#endif
		{
			return format[0];
		}
	#pragma tabsize 4
	new
		formatPos = 0,
		textPos = 0,
		paramPos = 2,
		paramCount = numargs(),
		delim = ' ';
	while (text[textPos] && text[textPos] <= ' ')
	{
		textPos++;
	}
	while (paramPos < paramCount && text[textPos])
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
					ch = text[textPos];
				if (ch == '-')
				{
					neg = -1;
					ch = text[++textPos];
				}
				do
				{
					textPos++;
					if ('0' <= ch <= '9')
					{
						num = (num * 10) + (ch - '0');
					}
					else
					{
						return -1;
					}
				}
				while ((ch = text[textPos]) > ' ' && ch != delim);
				setarg(paramPos, 0, num * neg);
			}
			case 'h', 'x':
			{
				new
					ch,
					num = 0;
				while ((ch = text[textPos]) > ' ' && ch != delim)
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
						default:
						{
							return -1;
						}
					}
				}
				setarg(paramPos, 0, num);
			}
			case 'c':
			{
				setarg(paramPos, 0, text[textPos++]);
			}
			case 'f':
			{
				setarg(paramPos, 0, _:floatstr(text[textPos]));
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
				if ((ch = strfind(text, format[formatPos], false, textPos)) == -1)
				{
					if (format[end + 1])
					{
						return -1;
					}
					return 0;
				}
				format[end] = '\'';
				textPos = ch + (end - formatPos);
				formatPos = end + 1;
			}
			case 'u':
			{
				new
					end = textPos - 1,
					id = 0,
					bool:num = true,
					ch;
				while ((ch = text[++end]) && ch != delim)
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
					text[end] = '\0';
					num = false;
					new
						name[MAX_PLAYER_NAME];
					id = end - textPos;
					foreach (Player, playerid)
					{
						GetPlayerName(playerid, name, sizeof (name));
						if (!strcmp(name, text[textPos], true, id))
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
					text[end] = ch;
					#if defined __SSCANF_FOREACH__
						#undef foreach
						#undef __SSCANF_FOREACH__
					#endif
				}
				textPos = end;
			}
			case 's', 'z':
			{
				new
					i = 0,
					ch;
				if (format[formatPos])
				{
					while ((ch = text[textPos++]) && ch != delim)
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
					while ((ch = text[textPos++]))
					{
						setarg(paramPos, i++, ch);
					}
				}
				textPos--;
				setarg(paramPos, i, '\0');
			}
			default:
			{
				continue;
			}
		}
		while (text[textPos] && text[textPos] != delim && text[textPos] > ' ')
		{
			textPos++;
		}
		while (text[textPos] && (text[textPos] == delim || text[textPos] <= ' '))
		{
			textPos++;
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
