/*
----------------------------------
----- Anti hack Filterscript -----
---- Script by Reallifescript ----
---- Tested by Reallifescript ----
----------------------------------
*/


#include <a_samp>


#define FILTERSCRIPT
#if defined FILTERSCRIPT

#define COLOR_RED 0xFF0000AA
#define COLOR_YELLOW 0xFFFF00AA
#define MAX_CASH 1000000

new banning[MAX_PLAYERS];
new healthhackingbans;
new hackingbans;
new weaponhackingbans;

forward healthanti();//checks for some health hacks
forward banningtimer();//Timer before you get banned
forward weaponanti();//checks the players weapons



public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print(" Anti weapon script by reallifescript ");
        print("--------------------------------------\n");

        SetTimer("weaponanti",2500,1);
        SetTimer("healthanti",2500,1);
        return 1;
}

public OnFilterScriptExit()
{
        return 1;
}

#endif


public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/cheatstats", cmdtext, true, 10) == 0)
        {
            	new string[200];
                SendClientMessage(playerid,COLOR_RED,"ANTI-CHEAT STATS");
                format(string, sizeof(string), "Weapon hacking bans: %d", weaponhackingbans);
            	SendClientMessageToAll(COLOR_RED,string);
                format(string, sizeof(string), "Health hacking bans: %d", healthhackingbans);
            	SendClientMessageToAll(COLOR_RED,string);
                format(string, sizeof(string), "Total hacking bans: %d", hackingbans);
            	SendClientMessageToAll(COLOR_YELLOW,string);
                return 1;
        }
        return 0;
}



public banningtimer()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
        {
       if(banning[i] == 1)
     {
        Ban(i);
     }
    }
}

public weaponanti()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
        {
     if (GetPlayerWeapon(i) == 35 || GetPlayerWeapon(i) == 36 || GetPlayerWeapon(i) == 37 || GetPlayerWeapon(i) == 38)  // here the id's of the weapon who are disabled ( autoban )
     {
           new pname[200];
           new string[200];
   		   weaponhackingbans +=1;
           hackingbans +=1;
   		   GetPlayerName(i, pname, sizeof(pname));
           format(string, sizeof(string), "(Anti-Weapon ban) %s(%d) has been banned by the anti-cheat system for cash hacking", pname,i);
           SendClientMessageToAll(COLOR_RED,string);
           format(string, sizeof(string), "Weapon hacking bans: %d  Total hacking bans: %d", weaponhackingbans,hackingbans);
           SendClientMessageToAll(COLOR_YELLOW,string);
   		   SetPlayerInterior(i,10);
   		   SetPlayerPos(i,219.6257,111.2549,999.0156);
           SetPlayerFacingAngle(i,2.2339);
           SetCameraBehindPlayer(i);
           SetTimer("banningtimer",2000,0);
           banning[i] =1;
       }
         }
}

public healthanti()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
        {
       	   new Float:health;
           GetPlayerHealth(i, health);
           if(health >=101)
       {
            new pname[200];
            new string[200];
            healthhackingbans +=1;
            hackingbans +=1;
            GetPlayerName(i, pname, sizeof(pname));
            format(string, sizeof(string), "(anti-Healthhack BAN) %s(%d) has been banned by the anti-cheat system for cash hacking", pname,i);
            SendClientMessageToAll(COLOR_RED,string);
            format(string, sizeof(string), "Health hacking bans: %d  Total hacking bans: %d", healthhackingbans,hackingbans);
            SendClientMessageToAll(COLOR_YELLOW,string);
            SetPlayerInterior(i,10);
            SetPlayerPos(i,219.6257,111.2549,999.0156);
            SetPlayerFacingAngle(i,2.2339);
            SetCameraBehindPlayer(i);
            SetTimer("banningtimer",2000,0);
            banning[i] =1;
       }
    }
}

/*
----------------------------------
----- Anti hack Filterscript -----
---- Script by Reallifescript ----
---- Tested by Reallifescript ----
----------------------------------
*/






