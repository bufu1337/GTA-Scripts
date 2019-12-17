#include <a_samp>
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1


new Float:mapX[MAX_PLAYERS] = 1743.8674;
new Float:mapY[MAX_PLAYERS] = 1453.9987;
new mapstarted[MAX_PLAYERS] = 0;

public OnFilterScriptInit()
{
        print("\n-------------------------------------------");
        print(" BirdsEyeView Map ------ By Mach37 (C) 2009");
        print("---------------------------------------------\n");
        return 1;
}

public OnFilterScriptExit()
{

        // I KNOW THIS IS ABSOLUTE UN-USE //
        for(new p=0; p < MAX_PLAYERS; p++)
        {
            mapX[p] = 1729.4530;
                mapY[p] = 1461.4821;
            mapstarted[p] = 0;
        }
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
        mapX[playerid] = 1743.8674;
        mapY[playerid] = 1453.9987;
        mapstarted[playerid] = 0;
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        dcmd(mapon,5,cmdtext);
        dcmd(mapoff,6,cmdtext);
        return 0;
}
dcmd_mapon(playerid,params[])
{
    #pragma unused params
        mapstarted[playerid] = 1;
        TogglePlayerControllable(playerid, 0);
        SetPlayerCameraPos(playerid, mapX[playerid], mapY[playerid], 350.0000);
        SetPlayerCameraLookAt(playerid, mapX[playerid], mapY[playerid], 15.3746);
}

dcmd_mapoff(playerid,params[])
{
        #pragma unused params
        mapstarted[playerid] = 0;
        TogglePlayerControllable(playerid, 1);
    SetCameraBehindPlayer(playerid);
}

public OnPlayerUpdate(playerid)
{
        if(mapstarted[playerid] == 1)
        {
                new o,ud,lr;
                GetPlayerKeys(playerid,o,ud,lr);

                if(ud > 0)
                {
                        mapY[playerid] = mapY[playerid] - 10.0000;
                        SetPlayerCameraPos(playerid, mapX[playerid], mapY[playerid], 350.0000);
                        SetPlayerCameraLookAt(playerid, mapX[playerid], mapY[playerid], 15.3746);
                }
                else if(ud < 0)
                {
                    mapY[playerid] = mapY[playerid] + 10.0000;
                        SetPlayerCameraPos(playerid, mapX[playerid], mapY[playerid], 350.0000);
                        SetPlayerCameraLookAt(playerid, mapX[playerid], mapY[playerid], 15.3746);
                }

                if(lr > 0)
                {
                        mapX[playerid] = mapX[playerid] + 10.0000;
                        SetPlayerCameraPos(playerid, mapX[playerid], mapY[playerid], 350.0000);
                        SetPlayerCameraLookAt(playerid, mapX[playerid], mapY[playerid], 15.3746);
                }
                else if(lr < 0)
                {
                        mapX[playerid] = mapX[playerid] - 10.0000;
                    SetPlayerCameraPos(playerid, mapX[playerid], mapY[playerid], 350.0000);
                        SetPlayerCameraLookAt(playerid, mapX[playerid], mapY[playerid], 15.3746);
                }
        }
        return 1;
}