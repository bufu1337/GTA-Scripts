/*
								Gang Zone Maker - By Seif
*/
/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
//**PRAGMAS**//

//**MISC**//

/*x---------------------------------Defining-------------------------------------x*/
//**COLORS*//
#define GREEN 			0x21DD00FF
#define RED 			0xE60000FF
#define ADMIN_RED 		0xFB0000FF
#define YELLOW 			0xFFFF00FF
#define ORANGE 			0xF97804FF
#define LIGHTRED 		0xFF8080FF
#define LIGHTBLUE 		0x00C2ECFF
#define PURPLE 			0xB360FDFF
#define PLAYER_COLOR 	0xFFFFFFFF
#define BLUE 			0x1229FAFF
#define LIGHTGREEN 		0x38FF06FF
#define DARKPINK 		0xE100E1FF
#define DARKGREEN 		0x008040FF
#define ANNOUNCEMENT 	0x6AF7E1FF
#define COLOR_SYSTEM 	0xEFEFF7AA
#define GREY 			0xCECECEFF
#define PINK 			0xD52DFFFF
#define DARKGREY    	0x626262FF
#define AQUAGREEN   	0x03D687FF
#define NICESKY 		0x99FFFFAA
#define WHITE 			0xFFFFFFFF
//**MISC**//
#define MAX_PICKUPS     400         // SA-MP's pickup limit
#define MAX_TURFS       100         // Maximum turfs creatable by default. Best to only decrease it when editing. Each turf has 4 pickups each. 4*100 = 400 = pickup limit.
#define DEFAULTCOLOR    WHITE       // Default color for gang zone creation(In full alpha 255(FF) recommended)
#define ALPHA           128         // The number of alpha you want to reduce from the color. Basically, the transparency. 128 = half
//**VARIABLES**//
enum tInfo
{
	Float:tMin_X,
	Float:tMin_Y,
	Float:tMin_Z,
	Float:tMax_X,
	Float:tMax_Y,
	Float:tMax_Z,
	tID,
	tColor,
}
new TurfInfo[MAX_TURFS][tInfo];
enum pInfo
{
	Float:pX,
	Float:pY,
	Float:pZ,
	pID,
	pTurfID,
}
new PickupInfo[MAX_PICKUPS][pInfo];
new Menu:zone;
new AreaAvailability[MAX_TURFS];
new LastTurf[MAX_PLAYERS];
// **FORWARDS** //

/*x---------------------------------CallBacks-------------------------------------x*/
public OnFilterScriptInit()
{
    zone = CreateMenu("Turf Maker", 0, 20, 120, 150, 400);
	AddMenuItem(zone, 0, "Minimum");
    AddMenuItem(zone, 0, "Maximum");

    for(new t; t < MAX_TURFS; t++)
    {
        DestroyArea(t);
    }

    for(new p; p < MAX_PICKUPS; p++)
    {
        PickupInfo[p][pX] = 0.0;
		PickupInfo[p][pY] = 0.0;
        PickupInfo[p][pZ] = 0.0;
        PickupInfo[p][pID] = -1;
        PickupInfo[p][pTurfID] = -1;
    }

    for(new i; i < MAX_PLAYERS; i++)
    {
        LastTurf[i] = -1;
    }

//    LoadTurfFile(); // Loads the saved turfs

    print("<|-----------------------------------------|>");
 	print("    .:[ - Gang Zone Maker by Seif - ]:.");
	print("<|-----------------------------------------|>");
	return 1;
}

public OnFilterScriptExit()
{
	DestroyMenu(zone);
	for(new p; p < MAX_PICKUPS; p++)
    {
        DestroyPickup(p);
    }
    for(new t; t < MAX_TURFS; t++)
    {
        GangZoneDestroy(t);
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	LastTurf[playerid] = -1;
	return 1;
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

public OnPlayerPrivmsg(playerid, recieverid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[128], idx, tmp[128];
	cmd = strtok(cmdtext, idx);

	if (!strcmp("/turf", cmd, true))
	{
		tmp = strtok(cmdtext, idx);
		if (!strlen(tmp)) return SendClientMessage(playerid, ORANGE, "USAGE: /turf [create/destroy/color/save/load/goto]");

		if (!strcmp("create", tmp, true))
		{
		    SetPlayerFacingAngle(playerid, 0);
		    SetCameraBehindPlayer(playerid);
		    TogglePlayerControllable(playerid, false);
		    ShowMenuForPlayer(zone, playerid);
		}
		else if (!strcmp("destroy", tmp, true))
		{
		    if (IsPlayerInATurf(playerid))
		    {
		        for(new i; i < MAX_TURFS; i++)
				{
				    if (!AreaAvailability[i])
				    {
				        if (IsPlayerInArea(playerid, TurfInfo[i][tMax_X], TurfInfo[i][tMin_X], TurfInfo[i][tMax_Y], TurfInfo[i][tMin_Y]))
				        {
				            GangZoneDestroy(TurfInfo[i][tID]);
				            for(new p; p < MAX_PICKUPS; p++)
				            {
				                if (PickupInfo[p][pTurfID] == TurfInfo[i][tID])
								{
									DestroyPickup(p);
								}
				            }
				            DestroyArea(i);
				            SendClientMessage(playerid, GREEN, "Turf erased!");
				            return 1;
				        }
				    }
				}
		    }
		    else SendClientMessage(playerid, RED, "You must be at the zone you want to destroy!");
		}
		else if (!strcmp("color", tmp, true))
		{
		    if (IsPlayerInATurf(playerid))
		    {
		        tmp = strtok(cmdtext, idx);

				SendClientMessage(playerid, LIGHTGREEN, "|- Color List -|");

				new areaid = -1;
				if (!fexist("TurfColors.txt"))
				{
				    print("color file doesn't exist");
					SendClientMessage(playerid, RED, "None. Please ask the server owner to add colors in the file 'TurfColors.txt' in the following format: ColorName,HexColor");
					return 1;
				}

				new str[128], LineColor[100]; // 100 = max colors your file can contain. I don't think you'll ever exceed that?
				new File:areafile = fopen("TurfColors.txt", io_read);
				if (areafile)
				{
				    print("opening color file");
				    new colorstr[256], lines;
				    while (fread(areafile, colorstr, 256))
				    {
				        lines++;
				        format(str, sizeof str, "%d- %s", lines, colorstr);
				        new colorvar;
				        if (strfind(colorstr, ",", false) != -1)
				        {
				            strdel(colorstr, 0, strfind(colorstr, ",", false)+1);
				            if (strlen(colorstr) > 10) strdel(colorstr, strlen(colorstr)-2, strlen(colorstr));
				            colorvar = HexToInt(colorstr)-ALPHA; // 80 = alpha
				            LineColor[lines] = colorvar;
				        }
				        SendClientMessage(playerid, colorvar, str);
				    }
				    for(new i; i < MAX_TURFS; i++)
					{
					    if (!AreaAvailability[i])
					    {
					        if (IsPlayerInArea(playerid, TurfInfo[i][tMax_X], TurfInfo[i][tMin_X], TurfInfo[i][tMax_Y], TurfInfo[i][tMin_Y]))
					        {
					            areaid = i;
					            fclose(areafile);
					            break;
					        }
					    }
					}
					if (areaid == -1)
					{
					    SendClientMessage(playerid, RED, "You're not in a created area!");
					    fclose(areafile);
					    return 1;
					}
			        fclose(areafile);
				}
				if (!strlen(tmp)) return SendClientMessage(playerid, ORANGE, "USAGE: /turf [create/destroy/COLOR/save/load/goto] [color id](listed above)");
				new colorid = strval(tmp);

				TurfInfo[areaid][tColor] = LineColor[colorid];
				GangZoneShowForAll(TurfInfo[areaid][tID], LineColor[colorid]);
				format(str, sizeof str, "Color changed to ID %d", colorid);
				SendClientMessage(playerid, LineColor[colorid], str);
		    }
		    else SendClientMessage(playerid, RED, "You must be at the zone you want to save(make sure you created it first!)");
		}
		else if (!strcmp("save", tmp, true))
		{
		    if (IsPlayerInATurf(playerid))
		    {
		        tmp = msgstrtok(cmdtext, idx);
				if (!strlen(tmp)) return SendClientMessage(playerid, RED, "You must enter a comment!");

				new areaid = -1;
				if (!fexist("TurfCoords.pwn"))
				{
				    print("file doesn't exist");
					new File:newfile = fopen("TurfCoords.pwn", io_write);
					if (newfile)
					{
					    print("made new file");
						fwrite(newfile, " ");
						fclose(newfile);
					}
				}
				print("file now exists");
				new File:areafile = fopen("TurfCoords.pwn", io_append);
				if (areafile)
				{
				    print("opening file");
				    for(new i; i < MAX_TURFS; i++)
					{
					    if (!AreaAvailability[i])
					    {
					        if (IsPlayerInArea(playerid, TurfInfo[i][tMax_X], TurfInfo[i][tMin_X], TurfInfo[i][tMax_Y], TurfInfo[i][tMin_Y]))
					        {
					            areaid = i;
					            break;
					        }
					    }
					}
					if (areaid == -1)
					{
					    SendClientMessage(playerid, RED, "You're not in a created area!");
					    fclose(areafile);
					}
					print("saving...");
				    new string[256];
				    format(string, sizeof string, "// Gang Zone Maker(SeifTurf) by Seif -- '%s' //\n%f, %f, %f, %f\nnew zoneid = GangZoneCreate(playerid, %f, %f, %f, %f);\nGangZoneShowForAll(zoneid, %d);\n", tmp, TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tColor]);
					fwrite(areafile, string);
					fclose(areafile);
					AddToLoadFile(areaid, tmp);
					SendClientMessage(playerid, LIGHTGREEN, "Turf coordinates saved in /scriptfiles/TurfCoords.pwn !");
				}
		    }
		    else SendClientMessage(playerid, RED, "You must be at the zone you want to save(make sure you created it first!)");
		}
		else if (!strcmp("load", tmp, true))
		{
		    LoadTurfFile();
		    SendClientMessage(playerid, LIGHTGREEN, " All saved turfs have loaded!");
		}
		else if (!strcmp("goto", tmp, true))
		{
		    tmp = strtok(cmdtext, idx);
		    if (!strlen(tmp)) return SendClientMessage(playerid, RED, "You must pick a pickup to teleport to(1-4)");
		    new pickup = strval(tmp);
		    if (pickup < 1 || pickup > 4) return SendClientMessage(playerid, RED, "There are only 4 pickups per turf!");

		    if (IsPlayerInATurf(playerid))
		    {
		        for(new i; i < MAX_TURFS; i++)
				{
				    if (!AreaAvailability[i])
				    {
				        if (IsPlayerInArea(playerid, TurfInfo[i][tMax_X], TurfInfo[i][tMin_X], TurfInfo[i][tMax_Y], TurfInfo[i][tMin_Y]))
				        {
				            new Pickup[4];
				            new pickupid;
				            for(new p; p < MAX_PICKUPS; p++)
				            {
				                if (PickupInfo[p][pTurfID] == TurfInfo[i][tID])
								{
									Pickup[pickupid] = p;
									pickupid++;
								}
				            }
				            pickupid = Pickup[pickup-1];
				            SetPlayerPos(playerid, PickupInfo[pickupid][pX], PickupInfo[pickupid][pY], PickupInfo[pickupid][pZ]);
				            SetPlayerFacingAngle(playerid, 0.0);
				            return 1;
				        }
				    }
				}
		    }
		    else SendClientMessage(playerid, RED, "You must be at the turf where you want to teleport to one of its pickups!");
		}
		else return SendClientMessage(playerid, ORANGE, "USAGE: /turf [create/destroy/color/save/load/goto]");
		return 1;
	}
	return 0;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	new Menu:menu = GetPlayerMenu(playerid);
	if (menu == zone)
	{
	    HideMenuForPlayer(menu, playerid);
	    switch (row)
	    {
	        case 0: // Minimum
	        {
	            new areaid;
				if (LastTurf[playerid] != -1) areaid = LastTurf[playerid];
				else areaid = FindAreaID();
				printf("last: %d - found: %d", LastTurf[playerid], FindAreaID());
	            new Float:X,Float:Y,Float:Z;
	            GetPlayerPos(playerid, X, Y, Z);
	            TurfInfo[areaid][tMin_X] = X;
	            TurfInfo[areaid][tMin_Y] = Y;
	            TurfInfo[areaid][tMin_Z] = Z;
	            if (LastTurf[playerid] == -1) LastTurf[playerid] = areaid;
	            else LastTurf[playerid] = -1;
	            OnPlayerExitedMenu(playerid);
	            printf("availability: %d - TURF: %d", AreaAvailability[areaid], areaid);
	            if (AreaAvailability[areaid] == 0)
	            {
	                new pickupid;
	                new gangid = GangZoneCreate(TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y]);
     				GangZoneShowForAll(gangid, DEFAULTCOLOR-ALPHA);
     				TurfInfo[areaid][tID] = gangid;
     				TurfInfo[areaid][tColor] = DEFAULTCOLOR-ALPHA;
     				printf("zone id: %d, areaid: %d", TurfInfo[areaid][tID], areaid);

	                pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMin_Z]);
     				PickupInfo[pickupid][pX] = TurfInfo[areaid][tMin_X];
     				PickupInfo[pickupid][pY] = TurfInfo[areaid][tMin_Y];
     				PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMin_Z];
     				PickupInfo[pickupid][pTurfID] = gangid;

			 		pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMax_Z]);
     				PickupInfo[pickupid][pX] = TurfInfo[areaid][tMax_X];
     				PickupInfo[pickupid][pY] = TurfInfo[areaid][tMax_Y];
     				PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMax_Z];
     				PickupInfo[pickupid][pTurfID] = gangid;

     				X = TurfInfo[areaid][tMin_X];   // North west
     				Y = TurfInfo[areaid][tMax_Y];
     				Z = TurfInfo[areaid][tMax_Z];
     				pickupid = CreatePickup(1239, 23, X, Y, Z);
     				PickupInfo[pickupid][pX] = X;
     				PickupInfo[pickupid][pY] = Y;
     				PickupInfo[pickupid][pZ] = Z;
     				PickupInfo[pickupid][pTurfID] = gangid;

     				X = TurfInfo[areaid][tMax_X];   // South east
     				Y = TurfInfo[areaid][tMin_Y];
     				Z = TurfInfo[areaid][tMin_Z];
     				pickupid = CreatePickup(1239, 23, X, Y, Z);
     				PickupInfo[pickupid][pX] = X;
     				PickupInfo[pickupid][pY] = Y;
     				PickupInfo[pickupid][pZ] = Z;
     				PickupInfo[pickupid][pTurfID] = gangid;
	            }
	            AreaAvailability[areaid] = 0;
	            printf("availabilityTWO: %d - TURF: %d", AreaAvailability[areaid], areaid);
	            SendClientMessage(playerid, GREEN, "Minimum X and Y created");
	        }
	        case 1: // Maximum
	        {
	            new areaid;
				if (LastTurf[playerid] != -1) areaid = LastTurf[playerid];
				else areaid = FindAreaID();
				printf("last: %d - found: %d", LastTurf[playerid], FindAreaID());
	            new Float:X,Float:Y,Float:Z;
	            GetPlayerPos(playerid, X, Y, Z);
	            TurfInfo[areaid][tMax_X] = X;
	            TurfInfo[areaid][tMax_Y] = Y;
	            TurfInfo[areaid][tMax_Z] = Z;
	            if (LastTurf[playerid] == -1) LastTurf[playerid] = areaid;
	            else LastTurf[playerid] = -1;
	            OnPlayerExitedMenu(playerid);
	            printf("availability: %d - TURF: %d", AreaAvailability[areaid], areaid);
	            if (AreaAvailability[areaid] == 0)
	            {
	                new pickupid;
	                new gangid = GangZoneCreate(TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y]);
     				GangZoneShowForAll(gangid, DEFAULTCOLOR-ALPHA);
     				TurfInfo[areaid][tID] = gangid;
     				TurfInfo[areaid][tColor] = DEFAULTCOLOR-ALPHA;
     				printf("zone id: %d, areaid: %d", TurfInfo[areaid][tID], areaid);

	                pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMin_Z]);
     				PickupInfo[pickupid][pX] = TurfInfo[areaid][tMin_X];
     				PickupInfo[pickupid][pY] = TurfInfo[areaid][tMin_Y];
     				PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMin_Z];
     				PickupInfo[pickupid][pTurfID] = gangid;

			 		pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMax_Z]);
     				PickupInfo[pickupid][pX] = TurfInfo[areaid][tMax_X];
     				PickupInfo[pickupid][pY] = TurfInfo[areaid][tMax_Y];
     				PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMax_Z];
     				PickupInfo[pickupid][pTurfID] = gangid;

     				X = TurfInfo[areaid][tMin_X];   // North west
     				Y = TurfInfo[areaid][tMax_Y];
     				Z = TurfInfo[areaid][tMax_Z];
     				pickupid = CreatePickup(1239, 23, X, Y, Z);
     				PickupInfo[pickupid][pX] = X;
     				PickupInfo[pickupid][pY] = Y;
     				PickupInfo[pickupid][pZ] = Z;
     				PickupInfo[pickupid][pTurfID] = gangid;

     				X = TurfInfo[areaid][tMax_X];   // South east
     				Y = TurfInfo[areaid][tMin_Y];
     				Z = TurfInfo[areaid][tMin_Z];
     				pickupid = CreatePickup(1239, 23, X, Y, Z);
     				PickupInfo[pickupid][pX] = X;
     				PickupInfo[pickupid][pY] = Y;
     				PickupInfo[pickupid][pZ] = Z;
     				PickupInfo[pickupid][pTurfID] = gangid;
	            }
	            AreaAvailability[areaid] = 0;
	            printf("availabilityTWO: %d - TURF: %d", AreaAvailability[areaid], areaid);
	            SendClientMessage(playerid, GREEN, "Maximum X and Y created");
	        }
	    }
	}
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid, true);
	return 1;
}

stock strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[128];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock msgstrtok(const string[], &idx)
{
    new length = strlen(string);
	while ((idx < length) && (string[idx] <= ' '))
	{
		idx++;
	}
	new offset = idx;
	new result[128];
	while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
	{
		result[idx - offset] = string[idx];
		idx++;
	}
	result[idx - offset] = EOS;
	return result;
}

stock FindAreaID()
{
	for(new i; i < MAX_TURFS; i++)
	{
	    if (AreaAvailability[i] == 1) return i;
	}
	return -1;
}

stock IsPlayerInATurf(playerid)
{
	for(new i; i < MAX_TURFS; i++)
	{
	    if (!AreaAvailability[i])
	    {
	        if (IsPlayerInArea(playerid, TurfInfo[i][tMax_X], TurfInfo[i][tMin_X], TurfInfo[i][tMax_Y], TurfInfo[i][tMin_Y]))
	        {
	            return 1;
	        }
	    }
	}
	return 0;
}

stock IsPlayerInArea(playerid, Float:max_x, Float:min_x, Float:max_y, Float:min_y)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y) return 1;
	return 0;
}

stock DestroyArea(areaid)
{
    TurfInfo[areaid][tMax_X] = 0.0;
    TurfInfo[areaid][tMax_Y] = 0.0;
    TurfInfo[areaid][tMax_Z] = 0.0;
    TurfInfo[areaid][tMin_X] = 0.0;
    TurfInfo[areaid][tMin_Y] = 0.0;
    TurfInfo[areaid][tMin_Z] = 0.0;
    TurfInfo[areaid][tID] = -1;
    AreaAvailability[areaid] = 1;
}

forward PlayerToPoint(playerid,Float:radi, Float:px, Float:py, Float:pz); public PlayerToPoint(playerid,Float:radi, Float:px, Float:py, Float:pz)
{
    if(IsPlayerConnected(playerid))
    {
	    new Float:x, Float:y, Float:z;
	    new Float:ox, Float:oy, Float:oz;
	    GetPlayerPos(playerid, ox, oy, oz);
	    x = (ox -px);
	    y = (oy -py);
	    z = (oz -pz);
	    if (((x < radi) && (x > -radi)) && ((y < radi) && (y > -radi)) && ((z < radi) && (z > -radi))) return 1;
	}
    return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if (newkeys & KEY_SECONDARY_ATTACK)
	{
	    for(new p; p < MAX_PICKUPS; p++)
	    {
	        if (PlayerToPoint(playerid, 3.0, PickupInfo[p][pX], PickupInfo[p][pY], PickupInfo[p][pZ]))
	        {
	            SetPlayerPos(playerid, PickupInfo[p][pX], PickupInfo[p][pY], PickupInfo[p][pZ]);
	            break;
	        }
	    }
	}
}

stock HexToInt(string[])    // I did not create this
{
	if (string[0]==0) return 0;
	new i;
	new cur=1;
	new res=0;
	for (i=strlen(string);i>0;i--)
	{
    	if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    	cur=cur*16;
	}
	return res;
}

stock IntToHex(number)
{
	new m=1;
	new depth=0;
	while (number>=m) {
		m = m*16;
		depth++;
	}
	depth--;
	new str[128];
	for (new i = depth; i >= 0; i--)
	{
		str[i] = ( number & 0x0F) + 0x30; // + (tmp > 9 ? 0x07 : 0x00)
		str[i] += (str[i] > '9') ? 0x07 : 0x00;
		number >>= 4;
	}
	str[8] = '\0';
	return str;
}

stock split(const strsrc[], strdest[][], delimiter)     // I did not create this
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

stock AddToLoadFile(areaid, comment[])
{
	if (!fexist("turfinfo.load"))
	{
	    new File:newfile = fopen("turfinfo.load", io_write);
	    if (newfile)
	    {
	        fwrite(newfile, " ");
			fclose(newfile);
	    }
	}

	new File:turffile = fopen("turfinfo.load", io_append);
	if (turffile)
	{
	    new string[256];
	    format(string, sizeof string, "%f|%f|%f|%f|%f|%f|%d|%s\n", TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMin_Z], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMax_Z], TurfInfo[areaid][tColor], comment);
		printf("[SAVE]%s", string);
		fwrite(turffile, string);
		fclose(turffile);
	}
	return 1;
}

stock LoadTurfFile()
{
    if (!fexist("turfinfo.load"))
	{
	    new File:newfile = fopen("turfinfo.load", io_write);
	    if (newfile)
	    {
	        fwrite(newfile, " ");
			fclose(newfile);
			return 1;
	    }
	}

	new File:turffile = fopen("turfinfo.load", io_read);
	if (turffile)
	{
	    new str[256], turf[10][32];
	    while (fread(turffile, str, 256))
	    {
	        split(str, turf, '|');
	        printf("%s", str);
	        new areaid = FindAreaID();
	        TurfInfo[areaid][tMin_X] = floatstr(turf[0]);
	        TurfInfo[areaid][tMin_Y] = floatstr(turf[1]);
	        TurfInfo[areaid][tMin_Z] = floatstr(turf[2]);
	        TurfInfo[areaid][tMax_X] = floatstr(turf[3]);
	        TurfInfo[areaid][tMax_Y] = floatstr(turf[4]);
	        TurfInfo[areaid][tMax_Z] = floatstr(turf[5]);
	        TurfInfo[areaid][tColor] = strval(turf[6])+ALPHA;

	        new string[128];
		    format(string, sizeof string, "%f,%f,%f,%f,%f,%f,%s", TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMin_Z], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMax_Z], TurfInfo[areaid][tColor]);
			printf("[LOAD]%s", string);

	        AreaAvailability[areaid] = 0;
	        new pickupid;
            new gangid = GangZoneCreate(TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y]);
			GangZoneShowForAll(gangid, TurfInfo[areaid][tColor]-ALPHA);
			TurfInfo[areaid][tID] = gangid;

            pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMin_X], TurfInfo[areaid][tMin_Y], TurfInfo[areaid][tMin_Z]);
			PickupInfo[pickupid][pX] = TurfInfo[areaid][tMin_X];
			PickupInfo[pickupid][pY] = TurfInfo[areaid][tMin_Y];
			PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMin_Z];
			PickupInfo[pickupid][pTurfID] = gangid;

	 		pickupid = CreatePickup(1239, 23, TurfInfo[areaid][tMax_X], TurfInfo[areaid][tMax_Y], TurfInfo[areaid][tMax_Z]);
			PickupInfo[pickupid][pX] = TurfInfo[areaid][tMax_X];
			PickupInfo[pickupid][pY] = TurfInfo[areaid][tMax_Y];
			PickupInfo[pickupid][pZ] = TurfInfo[areaid][tMax_Z];
			PickupInfo[pickupid][pTurfID] = gangid;

			new Float:X, Float:Y, Float:Z;

			X = TurfInfo[areaid][tMin_X];   // North west
			Y = TurfInfo[areaid][tMax_Y];
			Z = TurfInfo[areaid][tMax_Z];
			pickupid = CreatePickup(1239, 23, X, Y, Z);
			PickupInfo[pickupid][pX] = X;
			PickupInfo[pickupid][pY] = Y;
			PickupInfo[pickupid][pZ] = Z;
			PickupInfo[pickupid][pTurfID] = gangid;

			X = TurfInfo[areaid][tMax_X];   // South east
			Y = TurfInfo[areaid][tMin_Y];
			Z = TurfInfo[areaid][tMin_Z];
			pickupid = CreatePickup(1239, 23, X, Y, Z);
			PickupInfo[pickupid][pX] = X;
			PickupInfo[pickupid][pY] = Y;
			PickupInfo[pickupid][pZ] = Z;
			PickupInfo[pickupid][pTurfID] = gangid;
	    }
	    fclose(turffile);
	}
	return 1;
}