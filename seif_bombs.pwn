/*
							Bombing Script by Seif - Allowing you to
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
#define MAX_BOMBS   	500
//**VARIABLES**//
enum bombInfo
{
	bombPlanter[MAX_PLAYER_NAME],
	Float:bombX,
	Float:bombY,
	Float:bombZ,
};
new BombInfo[MAX_BOMBS][bombInfo];
new Bombs[MAX_PLAYERS];
new VehicleBombed[MAX_VEHICLES];
new Bomber[MAX_PLAYERS];
new ExplosiveObject[MAX_OBJECTS];
new explosive = 0;
// **FORWARDS** //

/*x---------------------------------CallBacks-------------------------------------x*/
public OnFilterScriptInit()
{
	for(new b = 0; b < MAX_BOMBS; b++)
	{
		strmid(BombInfo[b][bombPlanter], "[NONE]", 0, strlen("[NONE]"), 128);
		BombInfo[b][bombX] = 0.0;
		BombInfo[b][bombY] = 0.0;
		BombInfo[b][bombZ] = 0.0;
	}
	for(new v = 1; v < MAX_VEHICLES; v++) VehicleBombed[v] = 0;
	explosive = 0;

    print("<|-----------------------------------------|>");
 	print("  .:[ - Bombing Script by Seif - ]:.");
	print("<|-----------------------------------------|>");
	return 1;
}

public OnFilterScriptExit()
{
	for(new o = 0; o < MAX_OBJECTS; o++) DestroyObject(ExplosiveObject[o]);
	return 1;
}

public OnPlayerConnect(playerid)
{
	Bombs[playerid] = 0;
	Bomber[playerid] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new tmp[256],cmd[256],idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp("/setbomb", cmd, true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (!Bombs[playerid]) return SendClientMessage(playerid, ORANGE," You don't have a bomb with you.");
		if(!strlen(tmp)) return SendClientMessage(playerid, ORANGE,"USAGE: /setbomb [foot/car]");
		else if (strcmp("foot", tmp, true) == 0)
		{
		    if (GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SendClientMessage(playerid, ORANGE, " You're not on foot");
		    new Float:X,Float:Y,Float:Z,Float:A;
		    new playername[24];
		    GetPlayerPos(playerid, X, Y, Z);
		    GetPlayerFacingAngle(playerid,A);
      		GetPlayerName(playerid, playername, 24);
		    explosive++;
		    Y += (1 * floatcos(-A, degrees));
		    X += (1 * floatsin(-A, degrees));
		    ApplyAnimation(playerid, "BOMBER","BOM_Plant_In",4.0,0,0,0,0,0);
		    ExplosiveObject[explosive] = CreateObject(1654, X, Y, Z-0.9, 0, 90, 0);
		    Bomber[playerid] = 1;
		    BombInfo[explosive][bombX] = X;
		    BombInfo[explosive][bombY] = Y;
		    BombInfo[explosive][bombZ] = Z;
		    strmid(BombInfo[explosive][bombPlanter], playername, 0, strlen(playername), 50);
		    printf("%d",explosive);
		    SendClientMessage(playerid,ORANGE," You have planted a bomb on the ground. Type /usebomb to detonate it.");
		    Bombs[playerid]--;
		}
		else if (strcmp("car", tmp, true) == 0)
		{
		    if (IsPlayerInAnyVehicle(playerid))
		    {
		        new vehicleid = GetPlayerVehicleID(playerid);
		        new playername[24];
          		GetPlayerName(playerid, playername, 24);
		    	VehicleBombed[vehicleid] = 1;
		    	Bomber[playerid] = 2;
		    	explosive++;
		    	strmid(BombInfo[explosive][bombPlanter], playername, 0, strlen(playername), 50);
		    	SendClientMessage(playerid,ORANGE," You have planted a bomb inside the car. Type /usebomb to detonate it.");
		    	Bombs[playerid]--;
			}
			else SendClientMessage(playerid, ORANGE, " You're not inside a vehicle");
		}
		else SendClientMessage(playerid, ORANGE,"USAGE: /setbomb [foot/car]");
		return 1;
	}

	if(strcmp(cmdtext, "/bomber", true)==0)
	{
	    new string[128];
    	for(new i = 0; i < MAX_BOMBS; i++)
    	{
   			if (PlayerToPoint(playerid,3,BombInfo[i][bombX],BombInfo[i][bombY],BombInfo[i][bombZ]))
    		{
   			 	printf("%d - %d",explosive,i);
   			 	format(string,sizeof(string),"Bomber: %s - Bomb #%d",BombInfo[i][bombPlanter],i);
    		 	SendClientMessage(playerid,GREY,string);
    		}
    	}
    	return 1;
    }

    if (strcmp("/usebomb", cmd, true) == 0)
    {
       	if (Bomber[playerid] == 1) // On foot bomb
        {
        	new playa[128];
            GetPlayerName(playerid, playa, 24);
            new count = 0;
            for(new bomb = 1; bomb < MAX_BOMBS; bomb++)
            {
                if (!strcmp(BombInfo[bomb][bombPlanter], playa, false)) // if he's the planter of this bomb
                {
                    CreateExplosion(BombInfo[bomb][bombX],BombInfo[bomb][bombY],BombInfo[bomb][bombZ], 7, 7);
                    DestroyObject(ExplosiveObject[bomb]);
                    if (explosive <= 0) explosive = 1;
                    explosive--;
                    Bomber[playerid] = 0;
                    BombInfo[bomb][bombX] = 0.0;
		    		BombInfo[bomb][bombY] = 0.0;
		    		BombInfo[bomb][bombZ] = 0.0;
		    		strmid(BombInfo[bomb][bombPlanter], "[NONE]", 0, strlen("[NONE]"), 128);
                    printf("[ON FOOT] B: %d - E: %d - P: %s",bomb, explosive, BombInfo[bomb][bombPlanter]);
                    count++;
                }
            }
            format(playa, sizeof(playa), "You activated %d bombs", count);
            SendClientMessage(playerid, ORANGE, playa);
        }
        else if (Bomber[playerid] == 2) // car bomb
        {
        	new playa[128];
            GetPlayerName(playerid, playa, 24);
            new count = 0;
            for(new carbomb = 1; carbomb < MAX_VEHICLES; carbomb++)
            {
                if (VehicleBombed[carbomb] == 1)
                {
                    new bomb = 0;
                    while(bomb < MAX_BOMBS)
                    {
                    	bomb++;
                		if (strcmp(BombInfo[bomb][bombPlanter], playa, true) == 0) // if he's the planter of this bomb
                		{
                	 	   	new Float:X,Float:Y,Float:Z;
                	 	   	GetVehiclePos(carbomb,X,Y,Z);
                		   	SetVehicleHealth(carbomb,-999);
               		    	CreateExplosion(X,Y,Z, 7, 7);
               		    	Bomber[playerid] = 0;
               		    	VehicleBombed[carbomb] = 0;
               		    	strmid(BombInfo[bomb][bombPlanter], "[NONE]", 0, strlen("[NONE]"), 128);
               		    	if (explosive <= 0) explosive = 1;
                		    explosive--;
                		    printf("[IN VEH] B: %d - E: %d",bomb, explosive);
                		    count++;
                		}
					}
				}
            }
            format(playa, sizeof(playa), "You activated %d car bombs", count);
            SendClientMessage(playerid, ORANGE, playa);
        }
        return 1;
    }

    if(strcmp(cmd, "/givebomb", true) == 0)
	{
	    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, RED, " You're not an admin");
	    tmp = strtok(cmdtext, idx);
	    new targetid = ReturnUser(tmp, playerid);
	    new name[MAX_PLAYER_NAME];
	    GetPlayerName(targetid, name, sizeof(name));
	    new tname[MAX_PLAYER_NAME];
	    GetPlayerName(targetid, tname, sizeof(tname));

	    tmp = strtok(cmdtext, idx);
	    new amount = strval(tmp);
	    if (!strlen(tmp)) amount = 1;
	    Bombs[targetid] += amount;
	    format(tmp, 128, " You gave %d bombs to %s.",amount, tname);
	    SendClientMessage(playerid, LIGHTBLUE, tmp);
	    format(tmp, 128, " You have received %d bombs from %s.",amount, name);
	    SendClientMessage(targetid, LIGHTBLUE, tmp);
    	return 1;
    }

    if (!strcmp("/test", cmdtext, true))
    {
        new name[24];
        GetPlayerName(playerid, name, 24);
        if (!strcmp(BombInfo[1][bombPlanter], name, false))
		{
		    printf("%s : %s", BombInfo[1][bombPlanter], name);
		 	return 0;
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

PlayerToPoint(playerid,Float:radi, Float:px, Float:py, Float:pz)
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

stock IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	if (string[i] > '9' || string[i] < '0')
    return 0;
	return 1;
}

ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
	new pos = 0;
	while (text[pos] < 0x21)
	{
	if (text[pos] == 0) return INVALID_PLAYER_ID;
	pos++;
	}
	new userid = INVALID_PLAYER_ID;
	if (IsNumeric(text[pos]))
	{
	userid = strval(text[pos]);
	if (userid >=0 && userid < MAX_PLAYERS)
	{
	if(!IsPlayerConnected(userid))
	{
	userid = INVALID_PLAYER_ID;
	}
	else
	{
	return userid;
	}
	}
	}
	new len = strlen(text[pos]);
	new count = 0;
	new pname[MAX_PLAYER_NAME];
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
	if (IsPlayerConnected(i))
	{
	GetPlayerName(i, pname, sizeof (pname));
	if (strcmp(pname, text[pos], true, len) == 0)
	{
	if (len == strlen(pname))
	{
	return i;
	}
	else
	{
	count++;
	userid = i;
	}
	}
	}
	}
	if (count != 1)
	{
	if (playerid != INVALID_PLAYER_ID)
	{
	if (count)
	{
	SendClientMessage(playerid, COLOR_SYSTEM, "There are multiple users, enter full playername.");
	}
	else
	{
	SendClientMessage(playerid, COLOR_SYSTEM, "Playername not found.");
	}
	}
	userid = INVALID_PLAYER_ID;
	}
	return userid;
}