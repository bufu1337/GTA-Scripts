/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
/*x---------------------------------Defining-------------------------------------x*/
//**COLORS*//
#define GREEN 0x21DD00FF
#define RED 0xE60000FF
#define ADMIN_RED 0xFB0000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define LIGHTRED 0xFF8080FF
#define LIGHTBLUE 0x00C2ECFF
#define PURPLE 0xB360FDFF
#define PLAYER_COLOR 0xFFFFFFFF
#define BLUE 0x1229FAFF
#define LIGHTGREEN 0x38FF06FF
#define DARKPINK 0xE100E1FF
#define DARKGREEN 0x008040FF
#define ANNOUNCEMENT 0x6AF7E1FF
#define COLOR_SYSTEM 0xEFEFF7AA
#define GRAY 0xCECECEFF
//**VARIABLES**//
new dbtime;
new antidb;
new DB[200];
new weap,bull,gun,ammo;
//**FORWARDS**//
forward AntiDriveBy(playerid);
/*x---------------------------------CallBacks-------------------------------------x*/
public OnFilterScriptInit()
{
        print("<|-----------------------------------------|>");
        print(" |   .:[ - Anti Drive-By FS by Seif - ]:.  |");
        print("<|-----------------------------------------|>");
        antidb = 1;
        return 1;
}

public OnFilterScriptExit() return antidb = 0;

public OnPlayerDeath(playerid, killerid, reason)
{
        if (DB[playerid] == 1)
        {
            KillTimer(dbtime);
            DB[playerid] = 0;
        }
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/db", cmdtext, true, 10) == 0)
        {
                if (!IsPlayerAdmin(playerid)) return 0;
                if (antidb == 1)
                {
                    antidb = 0;
                    SendClientMessage(playerid,LIGHTRED,"Anti Drive-By DISABLED");
                }
                else if (antidb == 0)
                {
                    antidb = 1;
                    SendClientMessage(playerid,LIGHTRED,"Anti Drive-By ENABLED");
                }
                return 1;
        }
        return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
        GetPlayerWeaponData(playerid,4,gun,ammo);
        if (antidb == 1 && ammo >= 1 && !ispassenger)
        {
                GetPlayerWeaponData(playerid,4,weap,bull);
                GivePlayerWeapon(playerid,weap,-bull);
                dbtime = SetTimerEx("AntiDriveBy",7000,0,"d",playerid);
                DB[playerid] = 1;
        }
        return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
        if (newstate == 2 && DB[playerid] == 1) KillTimer(dbtime);
        if (newstate == PLAYER_STATE_ONFOOT && DB[playerid] == 1) AntiDriveBy(playerid);
        return 1;
}

public AntiDriveBy(playerid)
{
        GivePlayerWeapon(playerid,weap,bull);
        DB[playerid] = 0;
        return 1;
}

