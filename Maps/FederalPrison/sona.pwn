#include <a_samp>
#pragma tabsize 0
#define COLOR_RED 0xAA3333AA
#define COLOR_DGREEN 0x7CFC00AA
#define Sonajail 1

new prime1;
new prime2;
new prime3;
new prime4;

enum playerinfo {
	sonajail,
};

new PlayerInfo[MAX_PLAYERS][playerinfo];

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid,COLOR_DGREEN,"Sona Federal Prison loaded... Type /sona for more information (by [TDM]prime)");
	return 1;
}

public OnFilterScriptInit()
{
	print("[FS]|-----------------------------------------------|[FS]");
	print("[FS]| .:[ - Sona Federal Prison by [TDM]pRime - ]:.|[FS]");
	print("[FS]| .:[----------------------------------------]:.|[FS]");
	print("[FS]|-----------------------------------------------|[FS]");
	
CreateObject(8071,557.2859,-2227.0541,1.6191,0.0000,0.0000,0.0000);//
CreateObject(8149,568.5895,-2287.0214,3.5019,0.0000,0.0000,270.0000);//
CreateObject(8150,467.3805,-2229.9277,3.5019,0.0000,0.0000,90.0000);//
CreateObject(8152,567.6333,-2196.9455,3.5019,0.0000,0.0000,0.0000);//
CreateObject(8150,647.0311,-2223.9140,3.5019,0.0000,0.0000,270.0000);//
CreateObject(8150,530.3076,-2287.2382,3.5019,0.0000,0.0000,180.0000);//
CreateObject(8150,529.8067,-2167.6125,3.5094,0.0000,0.0000,0.0000);//
CreateObject(3279,472.8072,-2171.9052,0.5019,0.0000,0.0000,0.0000);//
CreateObject(3279,472.3353,-2282.0290,0.5019,0.0000,0.0000,0.0000);//
CreateObject(3279,642.1152,-2282.4980,0.5019,0.0000,0.0000,180.0000);//
CreateObject(3279,641.9938,-2172.8723,0.5019,0.0000,0.0000,180.0000);//
CreateObject(7929,628.9194,-2229.2946,7.2019,0.0000,0.0000,270.0000);//
CreateObject(9241,631.1401,-2252.1816,2.2619,0.0000,0.0000,360.0000);//
CreateObject(16614,628.0523,-2198.7971,-2.4980,0.0000,0.0000,450.0000);//
CreateObject(8154,559.2572,-2209.3525,3.5019,0.0000,0.0000,0.0000);//
CreateObject(8947,593.7191,-2180.0678,3.5019,0.0000,0.0000,0.0000);//
prime1 = CreateObject(980,593.9420,-2191.8830,2.8019,0.0000,0.0000,180.0000);//
CreateObject(987,532.1749,-2251.3122,0.5019,0.0000,0.0000,270.0000);//
prime2 = CreateObject(980,532.0258,-2268.9880,-3.7019,0.0000,0.0000,90.0000);//
CreateObject(987,532.1719,-2274.7971,0.5019,0.0000,0.0000,270.0000);//
CreateObject(3279,526.9992,-2277.6489,0.5019,0.0000,0.0000,90.0000);//
CreateObject(3279,527.5968,-2259.7878,0.5019,0.0000,0.0000,270.0000);//
CreateObject(987,531.9880,-2251.1481,0.5019,0.0000,0.0000,180.0000);//
CreateObject(987,520.0624,-2251.0192,0.5019,0.0000,0.0000,270.0000);//
prime3 = CreateObject(980,519.8372,-2268.6899,2.6019,0.0000,0.0000,270.0000);//
CreateObject(987,519.9644,-2274.7062,0.5019,0.0000,0.0000,270.0000);//
CreateObject(8153,540.2034,-2216.3527,2.7019,0.0000,0.0000,180.0000);//
CreateObject(987,573.5264,-2181.7336,0.5019,0.0000,0.0000,180.0000);//
CreateObject(987,585.6413,-2181.7526,0.5019,0.0000,0.0000,180.0000);//
CreateObject(3279,581.3670,-2173.2758,0.5019,0.0000,0.0000,270.0000);//
CreateObject(987,518.9876,-2191.3457,0.5019,0.0000,0.0000,270.0000);//
CreateObject(987,518.8596,-2212.2187,0.5019,0.0000,0.0000,270.0000);//
CreateObject(3279,513.8299,-2200.2595,0.5019,0.0000,0.0000,180.0000);//
CreateObject(3279,514.4453,-2217.6860,0.5019,0.0000,0.0000,180.0000);//
prime4 = CreateObject(980,518.8210,-2207.7797,2.7019,0.0000,0.0000,90.0000);//
CreateObject(18259,566.3624,-2195.7343,1.8019,0.0000,0.0000,90.0000);//
CreateObject(18259,542.7445,-2196.3378,1.9019,0.0000,0.0000,90.0000);//
CreateObject(1278,519.8694,-2201.1413,6.5019,0.0000,0.0000,0.0000);//
CreateObject(1278,519.8099,-2214.1967,6.5019,0.0000,0.0000,180.0000);//
CreateObject(1278,521.2808,-2250.3208,6.5019,0.0000,0.0000,135.0000);//
CreateObject(1278,585.0485,-2250.3728,6.5019,0.0000,0.0000,225.0000);//
CreateObject(1278,585.5114,-2183.7436,6.5019,0.0000,0.0000,-45.0000);//
CreateObject(1278,519.6935,-2182.4526,6.5019,0.0000,0.0000,45.0000);//
CreateObject(620,515.1904,-2227.3078,-3.4980,0.0000,0.0000,0.0000);//
CreateObject(620,514.9641,-2239.0351,-3.4980,0.0000,0.0000,0.0000);//
CreateObject(620,515.6795,-2251.0458,-1.4980,0.0000,0.0000,0.0000);//
CreateObject(620,515.7991,-2261.1948,-0.4980,0.0000,0.0000,0.0000);//
CreateObject(621,512.9487,-2233.7165,-13.4980,0.0000,0.0000,0.0000);//
CreateObject(621,515.2221,-2245.8955,-13.4980,0.0000,0.0000,0.0000);//
CreateObject(621,518.7780,-2255.6926,-12.4980,0.0000,0.0000,0.0000);//
CreateObject(622,517.7428,-2179.4975,-3.4980,0.0000,0.0000,270.0000);//
CreateObject(619,566.4644,-2179.0754,-1.4980,0.0000,0.0000,0.0000);//
CreateObject(1498,566.1174,-2200.8750,1.9019,0.0000,0.0000,0.0000);//
CreateObject(1567,542.3375,-2201.3383,2.0019,0.0000,0.0000,0.0000);//
CreateObject(3864,532.6392,-2204.3676,6.3019,0.0000,0.0000,90.0000);//
CreateObject(3872,532.3713,-2211.7656,6.5019,0.0000,0.0000,450.0000);//


CreateVehicle(427,590.3558,-2177.2063,1.5019,179.3985,0,0,30); //
CreateVehicle(427,596.3771,-2177.2063,1.5019,179.3985,0,0,30); //
CreateVehicle(425,631.0502,-2252.1272,4.0901,86.9643,0,0,30); //
CreateVehicle(470,609.8177,-2283.1318,1.5019,359.5435,0,0,30); //
CreateVehicle(470,599.4088,-2283.1318,1.5019,359.5435,0,0,30); //


return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
//-----------------------commands----------------------
if(strcmp("/garageopen", cmdtext, true, 10) == 0)
    {
    if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime1,593.9420,-2191.8830,-3.8019,2.0);
	}
	return 1;
	}
	if(strcmp("/garageclose", cmdtext, true, 10) == 0)
    {
    if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime1,593.9420,-2191.8830,2.8019,2.0);
	}
	return 1;
	}
	if(strcmp("/g1open", cmdtext, true, 10) == 0)
	{
	if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime2,532.0258,-2268.9880,2.7019,2.0);
	MoveObject(prime3,519.8372,-2268.6899,-3.6019,2.0);
	}
	return 1;
	}
    if(strcmp("/g1close", cmdtext, true, 10) == 0)
	{
	if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime2,532.0258,-2268.9880,-3.7019,2.0);
	MoveObject(prime3,519.8372,-2268.6899,2.6019,2.0);
	}
	return 1;
	}
	if(strcmp("/mainopen", cmdtext, true, 10) == 0)
	{
	if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime4,518.8210,-2207.7797,-3.7019,2.0);
	}
	return 1;
	}
    if(strcmp("/mainclose", cmdtext, true, 10) == 0)
	{
	if (IsPlayerAdmin(playerid))
	{
	MoveObject(prime4,518.8210,-2207.7797,2.7019,2.0);
	}
	return 1;
	}
	if(strcmp("/gotosona", cmdtext, true, 10) == 0)
	{
		if (IsPlayerAdmin(playerid))
		{
				SetPlayerPos(playerid, 605.3300,-2232.6687,1.5019);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "You is not an admin");
		}
	return 1;
	}
 	if(strcmp("/sona", cmdtext, true, 10) == 0)
	{
	SendClientMessage(playerid, COLOR_DGREEN,"This script was made by [TDM]pRime");
 	SendClientMessage(playerid, COLOR_DGREEN," /garageopen /garageclose - open and close the police garage");
	SendClientMessage(playerid, COLOR_DGREEN," /g1open /g1close - open the gates to federal area");
	SendClientMessage(playerid, COLOR_DGREEN," /mainopen /mainclose - open the maingate to prison [BE CAREFUL :D]");
	SendClientMessage(playerid, COLOR_DGREEN," /gotosona - teleport to sona federal prison");
	SendClientMessage(playerid, COLOR_DGREEN," /sonajail /unjailsona - jail or unjail the player");
	return 1;
	}
	new cmd[256], idx;
   		new tmp[256];
		cmd = strtok(cmdtext, idx);
		if(strcmp(cmd, "/sonajail", true) == 0)
			{
	    	if(IsPlayerConnected(playerid))
	    		{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
					{
					SendClientMessage(playerid, COLOR_DGREEN, "USAGE: /sonajail [playerid]");
					return 1;
					}
				new playa;
				playa = strval(tmp);
				if(playa == playerid)
					{
					SendClientMessage(playerid, COLOR_DGREEN, "*You can not put yoursel in sona federal prison");
					return 1;
					}
				if (IsPlayerAdmin(playerid))
					{
			    	if(IsPlayerConnected(playa))
			    		{
			        	if(playa != INVALID_PLAYER_ID)
			        		{
			        		if(PlayerInfo[playerid][sonajail] != Sonajail)
			        		    {
								SetPlayerPos(playerid, 543.8196,-2226.0264,1.5019);
								GameTextForPlayer(playerid,"~r~Welcome to SONA federal prison",4000,3);
								SetPlayerSkin(playerid, 62);
                				PlayerInfo[playerid][sonajail] = Sonajail;
                				SetPlayerColor(playerid,0xF7DFB5AA);
                				ResetPlayerWeapons(playerid);
                				}
							else
							    {
							    SendClientMessage(playerid, COLOR_RED, "This player is also in SONA FEDERAL PRISON");
							    }
							}
						}
					}
				else
					{
					SendClientMessage(playerid, COLOR_RED, "You are not an admin");
					}
				}
            else
				{
				SendClientMessage(playerid, COLOR_RED, "This player is offline");
				}
			return 1;
			}
			if(strcmp(cmd, "/unjailsona", true) == 0)
			{
	    	if(IsPlayerConnected(playerid))
	    		{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
					{
					SendClientMessage(playerid, COLOR_RED, "USAGE: /unjailsona [playerid]");
					return 1;
					}
				new playa;
				playa = strval(tmp);
/*				if(playa == playerid)
					{
					SendClientMessage(playerid, CoLOR_RED, "* Вы пытаетесь вытащить из тюрьмы сами себя! ЭТО НЕВОЗМОЖНО!");
					return 1;
					}*/
				if (IsPlayerAdmin(playerid))
					{
			    	if(IsPlayerConnected(playa))
			    		{
			        	if(playa != INVALID_PLAYER_ID)
			        		{
			        		if(PlayerInfo[playerid][sonajail] != Sonajail)
			        		    {
			        		    SendClientMessage(playerid, COLOR_DGREEN, "This player is not in SONA FEDERAL PRISON");
								}
							else
							    {
							    GameTextForPlayer(playerid,"~g~You are realised from SONA FEDERAL PRISON",4000,3);
								SetPlayerSkin(playerid, 239);
                				PlayerInfo[playerid][sonajail] = 0;
                				SetPlayerColor(playerid,0xFFFFFFAA);
                				SetPlayerHealth(playerid,100);
                				SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
							    }
							}
						}
					}
				else
					{
					SendClientMessage(playerid, COLOR_DGREEN, "You are not an admin");
					}
				}
            else
				{
				SendClientMessage(playerid, COLOR_DGREEN, "This player is offline");
				}
			return 1;
			}
	
 	return 0;
}

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
