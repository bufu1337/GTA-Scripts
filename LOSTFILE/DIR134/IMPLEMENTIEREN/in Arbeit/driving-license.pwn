//> Includes <//
#include <a_samp>
//> Pragmas <//
#pragma unused dmvcp
//> Defines <//
#define GREEN 0x21DD00FF
#define RED 0xE60000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define GRAY 0xCECECEFF
#define LIGHTBLUE 0x00C2ECFF
#define CHECKPOINT_DMV 0
#define DrivingTestCash 5000 // Edit this if needed. 5000 = the cash that you'll pay to take the driving test
#define TooSlow 110 // 110 = if the time is 110 or more, you are driving too slow. You may edit this if needed.
#define TooFast 105 // 105 = if the time is less than 105, you are driving too fast. You may edit this if needed.
//> Variables <//
static Checkpoint[MAX_PLAYERS];
new Menu:dmvoption[MAX_PLAYERS];
new Float:DrivingSchoolCP[31][3] =
{
    {-2047.318237, -78.493286, 35.043674}, // Starting of the first test's checkpoints
        {-2020.431396, -72.462600, 35.046836},
        {-2004.230468, -63.067325, 35.043403},
        {-2004.557861, 92.230476, 27.414079},
        {-2001.461181, 306.811828, 34.771896},
        {-2016.024169, 322.754547, 34.890529},
        {-2134.363769, 321.980102, 35.024250},
        {-2238.925292, 322.899688, 35.046855},
        {-2249.107177, 327.225555, 35.046890},
        {-2298.212402, 411.341003, 34.885196},
        {-2321.346435, 410.600982, 34.890609},
        {-2423.162597, 55.284839, 34.890628},
        {-2485.413818, 42.110366, 26.862459},
        {-2590.423339, 41.848583, 4.056760},
        {-2606.167480, 32.018920, 4.118466},
        {-2606.167480, -57.042472, 4.054659},
        {-2597.467041, -72.002243, 4.125582},
        {-2514.526123, -72.963630, 24.342817},
        {-2386.916503, -71.996078, 35.038841},
        {-2273.539550, -72.938049, 35.039089},
        {-2261.753173, -83.578163, 35.046840},
        {-2260.035400, -177.289489, 35.046775},
        {-2245.059814, -192.252777, 35.046882},
        {-2164.877441, -82.917831, 35.046836},
        {-2154.212402, -72.622978, 35.046878},
        {-2052.066894, -72.116477, 35.042152},
        {-2047.616333, -88.755950, 35.038990},
        {-2025.749145, -97.650115, 35.039009},
        {-2044.890747, -139.023742, 35.188522}, // Starting of the second test's checkpoints
        {-2056.534667, -222.281845, 35.198474},
        {-2062.643554, -118.802627, 35.325977}
};
new DMVCP[MAX_PLAYERS];
new dmvcp;
new dmvcar,dmvcar2;
new DrivingLicense[MAX_PLAYERS];
new DMVTest[MAX_PLAYERS];
new DMVCount[MAX_PLAYERS];
new DrivingTestTime[MAX_PLAYERS];
new DMVT,DMVT2;
new barrier;
//> Forwards <//
forward DrivingTestCount(playerid);
forward DrivingTestCount2(playerid);
forward DMVTest2Barrels(playerid);
//> Callbacks <//
public OnFilterScriptInit()
{
        dmvcar = CreateVehicle(445,-2027,-94,35,92,-1,-1,180000);
        dmvcar2 = CreateVehicle(445,-2047,-109,35,269,-1,-1,180000);
        return 1;
}

public OnPlayerRequestSpawn(playerid)
{
        return 1;
}

public OnPlayerConnect(playerid)
{
    dmvoption[playerid] = CreateMenu(" Driving School",0,200,100,300,500);
        SetMenuColumnHeader(dmvoption[playerid],0,"Would you like to take the test?");
        AddMenuItem(dmvoption[playerid],0,"Yes, I want to take the test");
        AddMenuItem(dmvoption[playerid],0,"No, I am not ready yet.");
        dmvcp = CHECKPOINT_DMV;
        dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
        Checkpoint[playerid] = CHECKPOINT_DMV;
        DMVCP[playerid] = -1;
        DrivingLicense[playerid] = 0;
        DMVTest[playerid] = 0;
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
        new dmvadmiral = dmvcar || dmvcar2;
        if (GetPlayerVehicleID(playerid) == dmvcar || GetPlayerVehicleID(playerid) == dmvcar2) SetVehicleToRespawn(dmvadmiral);
        return 1;
}

public OnPlayerSpawn(playerid)
{
        return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
        if (DMVTest[playerid] == 1)
        {
        SendClientMessage(playerid,RED,"You 'died' during a driving test. Therefore, it has been cancelled.");
                DisablePlayerCheckpoint(playerid);
                DMVCP[playerid] = -1;
                DMVTest[playerid] = 0;
                KillTimer(DMVT);
                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
        }
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
        if(strcmp(cmdtext, "/dmv", true) == 0)
        {
            SetPlayerPos(playerid,-2027.835693, -98.881484, 35.164062);
            SetPlayerFacingAngle(playerid,180);
            SetCameraBehindPlayer(playerid);
            return 1;
        }
        if(strcmp(cmdtext, "/stopdmvtest", true) == 0)
        {
            if (DMVTest[playerid] == 0)
            {
                SendClientMessage(playerid,RED,"You're not having a driving test.");
                return 1;
            }
            SendClientMessage(playerid,GREEN,"You abandoned the test.");
                DisablePlayerCheckpoint(playerid);
                DMVCP[playerid] = -1;
                DMVTest[playerid] = 0;
                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
            return 1;
        }
        if(strcmp(cmdtext, "/licenses", true) == 0)
        {
            SendClientMessage(playerid,LIGHTBLUE,"[-------------Licenses-------------]");
            if (DrivingLicense[playerid] == 0) SendClientMessage(playerid,GRAY,"Driving: Not Passed."); else SendClientMessage(playerid,GRAY,"Driving: Passed.");
            return 1;
        }
        return 0;
}

public OnPlayerInfoChange(playerid)
{
        return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
        new taxi1,taxi2,taxi3,taxi4,taxi5,taxi6,taxi7,taxi8,taxi9,taxi10;
    new taxicar = vehicleid >= taxi1 && vehicleid <= taxi10;
        new Float:X,Float:Y,Float:Z;
        GetPlayerPos(playerid,X,Y,Z);
        if (vehicleid == dmvcar && DMVTest[playerid] == 0) { SetPlayerPos(playerid,X,Y,Z+3); SendClientMessage(playerid,RED,"You didn't subscribe to take the driving test, therefore you are not allowed to drive this car."); }
        if (vehicleid == dmvcar2 && DMVTest[playerid] == 0) { SetPlayerPos(playerid,X,Y,Z+3); SendClientMessage(playerid,RED,"You didn't subscribe to take the driving test, therefore you are not allowed to drive this car."); }
        return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
        if (vehicleid == dmvcar) { SetVehicleToRespawn(dmvcar); SetVehicleParamsForPlayer(dmvcar,playerid,0,0); }
        if (vehicleid == dmvcar2) { SetVehicleToRespawn(dmvcar2); SetVehicleParamsForPlayer(dmvcar2,playerid,0,0); }
        return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
        new vehicleid = GetPlayerVehicleID(playerid);
        if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER && DMVTest[playerid] == 1 && vehicleid == dmvcar) SetVehicleParamsForPlayer(dmvcar,playerid,0,0);
        if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER && DMVTest[playerid] == 1 && vehicleid == dmvcar2) SetVehicleParamsForPlayer(dmvcar2,playerid,0,0);
        if (oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER && DrivingLicense[playerid] == 0 && DMVTest[playerid] == 0)
        {
            SendClientMessage(playerid,RED,"Warning: you might get caught for driving without a real driving license!");
            new star = GetPlayerWantedLevel(playerid);
            SetPlayerWantedLevel(playerid,star+1);
        }
        return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
        switch(DMVCP[playerid])
        {
            case -1:
                {
                    ShowMenuForPlayer(dmvoption[playerid],playerid);
                TogglePlayerControllable(playerid,0);
                }
            case 0:
                {
                        if(!IsPlayerInVehicle(playerid,dmvcar))
                        {
                            SendClientMessage(playerid,RED,"You're not in the Admiral car!");
                        }
                        else
                        {
                            DisablePlayerCheckpoint(playerid);
                            DMVCP[playerid] = 1;
                            SetPlayerCheckpoint(playerid,DrivingSchoolCP[1][0],DrivingSchoolCP[1][1],DrivingSchoolCP[1][2],5.0);
                            DMVCount[playerid] = 1;
                            DMVT = SetTimerEx("DrivingTestCount",1000,0,"d",playerid);
                            DMVT2 = SetTimerEx("DrivingTestCount2",1000,0,"d",playerid);
                        }
                }
                case 1..26:
                {
                    if(!IsPlayerInVehicle(playerid,dmvcar))
                        {
                            SendClientMessage(playerid,RED,"You're not in the Admiral car!");
                        }
                        else
                        {
                            DisablePlayerCheckpoint(playerid);
                            SetPlayerCheckpoint(playerid,DrivingSchoolCP[DMVCP[playerid]+1][0],DrivingSchoolCP[DMVCP[playerid]+1][1],DrivingSchoolCP[DMVCP[playerid]+1][2],5.0);
                            DMVCP[playerid]++;
                        }
                }
                case 27:
                {
                    new Float:VehHealth;
                    new string[128];
                    GetVehicleHealth(GetPlayerVehicleID(playerid),VehHealth);
                    if (VehHealth <= 899)
                        {
                                SendClientMessage(playerid,RED,"You failed the test: you weren't driving safely!");
                                DrivingLicense[playerid] = 0;
                                DisablePlayerCheckpoint(playerid);
                                DMVCP[playerid] = -1;
                                format(string, sizeof(string), "Time: %d",DrivingTestTime[playerid]);
                                SendClientMessage(playerid,YELLOW,string);
                        DMVTest[playerid] = 0;
                                KillTimer(DMVT);
                                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
                        }
                        else if (DrivingTestTime[playerid] > TooSlow)
                        {
                                SendClientMessage(playerid,RED,"You failed the test: you were driving too slow!");
                                DrivingLicense[playerid] = 0;
                                DisablePlayerCheckpoint(playerid);
                                DMVCP[playerid] = -1;
                                format(string, sizeof(string), "Time: %d",DrivingTestTime[playerid]);
                                SendClientMessage(playerid,YELLOW,string);
                        DMVTest[playerid] = 0;
                                KillTimer(DMVT);
                                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
                        }
                        else if (DrivingTestTime[playerid] < TooFast)
                        {
                                SendClientMessage(playerid,RED,"You failed the test: you were driving too fast!");
                                DrivingLicense[playerid] = 0;
                                DisablePlayerCheckpoint(playerid);
                                DMVCP[playerid] = -1;
                                format(string, sizeof(string), "Time: %d",DrivingTestTime[playerid]);
                                SendClientMessage(playerid,YELLOW,string);
                        DMVTest[playerid] = 0;
                                KillTimer(DMVT);
                                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
                        }
                        else if (DrivingTestTime[playerid] > TooFast && DrivingTestTime[playerid] < TooSlow)
                        {
                                SendClientMessage(playerid,GREEN,"You passed the first test!");
                                DMVCP[playerid] = 28;
                                DMVTest2Barrels(playerid);
                                DisablePlayerCheckpoint(playerid);
                                SetPlayerCheckpoint(playerid,DrivingSchoolCP[28][0],DrivingSchoolCP[28][1],DrivingSchoolCP[28][2],5.0);
                                SetPlayerPos(playerid,-2046.157592, -109.187286, 35.234008);
                        }

                }
                case 28,29:
                {
                        if(!IsPlayerInVehicle(playerid,dmvcar2))
                        {
                            SendClientMessage(playerid,RED,"You're not in the Admiral car!");
                        }
                        else
                        {
                            DisablePlayerCheckpoint(playerid);
                            SetPlayerCheckpoint(playerid,DrivingSchoolCP[DMVCP[playerid]+1][0],DrivingSchoolCP[DMVCP[playerid]+1][1],DrivingSchoolCP[DMVCP[playerid]+1][2],5.0);
                            DMVCP[playerid]++;
                            SetPlayerObjectRot(playerid,barrier, 0, 270.6185, 3.4377);
                        }
                }
                case 30:
                {
                    if(!IsPlayerInVehicle(playerid,dmvcar2))
                        {
                            SendClientMessage(playerid,RED,"You're not in the Admiral car!");
                        }
                        else
                        {
                                new string[256];
                            DisablePlayerCheckpoint(playerid);
                            DMVCP[playerid] = -1;
                            SendClientMessage(playerid,GREEN,"You passed the driving test! Here's your license. Drive safely!");
                            DrivingLicense[playerid] = 1;
                                SendClientMessage(playerid,LIGHTBLUE,"You earned a driving license. ( /licenses )");
                        dmvcp = CHECKPOINT_DMV;
                                dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
                                Checkpoint[playerid] = CHECKPOINT_DMV;
                                format(string, sizeof(string), "Total Time: %d",DrivingTestTime[playerid]);
                                SendClientMessage(playerid,YELLOW,string);
                                DMVTest[playerid] = 0;
                                KillTimer(DMVT);
                        }
                }
        }
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

public OnPlayerSelectedMenuRow(playerid, row)
{
        new Menu:Current = GetPlayerMenu(playerid);
        if (Current == dmvoption[playerid])
        {
                switch (row)
                {
                    case 0:
                        {
                                if (GetPlayerMoney(playerid) < DrivingTestCash)
                                {
                                        SendClientMessage(playerid,RED,"You don't have enough cash");
                                        ShowMenuForPlayer(dmvoption[playerid],playerid);
                                        return 1;
                                }
                                if (DrivingLicense[playerid] == 1)
                                {
                                    SendClientMessage(playerid,RED,"You already have a license!");
                                    return 1;
                                }
                                GivePlayerMoney(playerid,-DrivingTestCash);
                                SetPlayerPos(playerid,-2027.8353, -98.8884, 35.1642);
                                SetPlayerFacingAngle(playerid,355);
                                SetCameraBehindPlayer(playerid);
                                DisablePlayerCheckpoint(playerid);
                                SetPlayerCheckpoint(playerid,DrivingSchoolCP[0][0],DrivingSchoolCP[0][1],DrivingSchoolCP[0][2],5.0);
                                SendClientMessage(playerid,GREEN,"Get ready!");
                                DMVCP[playerid]=0;
                                SetPlayerInterior(playerid,0);
                                DMVTest[playerid] = 1;
                                SetVehicleParamsForPlayer(dmvcar,playerid,1,0);
                        }
                    case 1: {DisablePlayerCheckpoint(playerid);SendClientMessage(playerid,RED,"Alright, come back again!");dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);DMVCP[playerid]=-1;DMVTest[playerid] = 0;}
                }
                TogglePlayerControllable(playerid,1);
                HideMenuForPlayer(dmvoption[playerid],playerid);
        }
        return 1;
}

public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1);
    dmvcp = SetPlayerCheckpoint(playerid,-2033.396606, -117.458976, 1035.171875,2.0);
    SetPlayerPos(playerid,-2029.798217, -113.841880, 1035.171875);
        return 1;
}

public DrivingTestCount(playerid)
{
        if (DMVTest[playerid] == 0)
        {
            KillTimer(DMVT);
        }
        else
        {
                DrivingTestTime[playerid]++;
                DMVT = SetTimerEx("DrivingTestCount",1000,0,"d",playerid);
        }
        return 1;
}

public DrivingTestCount2(playerid)
{
        new string[128];
        if (DMVTest[playerid] == 0) { KillTimer(DMVT2); DrivingTestTime[playerid] = 0; }
        else
        {
        format(string, sizeof(string), "%d",DrivingTestTime[playerid]);
        GameTextForPlayer(playerid,string,1500,6);
        DMVT2 = SetTimerEx("DrivingTestCount2",1000,0,"d",playerid);
        }
        return 1;
}

public DMVTest2Barrels(playerid)
{
        CreatePlayerObject(playerid,1225, -2047.739380, -124.699600, 34.675339, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.828735, -127.508087, 34.685390, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.975708, -131.667175, 34.698689, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.973022, -136.163910, 34.721497, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.925659, -139.214722, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.908203, -141.976624, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.887329, -144.973816, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.729858, -148.626572, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.702393, -152.689362, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.698242, -157.703888, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2045.846924, -160.790421, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2043.227295, -162.861053, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2040.600098, -162.904633, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2037.797485, -163.111908, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2034.899170, -162.867844, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2031.852295, -163.106583, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2029.787598, -165.264786, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.985352, -166.907516, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.733643, -170.627853, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.643677, -174.075684, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.636963, -178.923584, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.671143, -183.302338, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.617920, -186.658890, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.563721, -191.181686, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2027.580078, -195.068634, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2029.627197, -196.768021, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2032.301880, -196.650391, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2035.021729, -196.580505, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2037.809937, -196.429749, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2039.987305, -195.957809, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2043.569214, -195.811615, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2045.273193, -198.124237, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.288330, -200.983261, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2049.360107, -203.673172, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2052.088623, -206.996796, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2053.906738, -209.363663, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2054.351563, -211.975128, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2054.267090, -214.795746, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2054.124268, -217.791809, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2055.906250, -219.694305, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2057.633545, -219.397446, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.626953, -217.816498, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.747559, -215.103271, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.573486, -211.342789, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.686035, -208.026291, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.655762, -204.211914, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.548828, -199.790741, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.497314, -194.988190, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.647949, -189.953400, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.572266, -184.511627, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.516357, -179.578522, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.537598, -174.580582, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.625977, -169.239868, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.639404, -163.440292, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.717041, -158.009964, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.677490, -153.811859, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.600098, -148.967178, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.447998, -144.551208, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.364014, -139.715439, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.335449, -136.523911, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2058.574219, -133.029388, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2060.240967, -130.847961, 34.730694, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2062.932861, -129.208313, 34.731895, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.347168, -128.650375, 34.732307, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2067.585205, -128.456207, 34.732227, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2067.923828, -125.978699, 34.734264, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2067.055176, -123.778641, 34.735874, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2064.495850, -123.390129, 34.733089, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2062.125977, -123.011520, 34.731354, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2060.723633, -120.962669, 34.730324, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2060.789063, -116.457222, 34.730373, 0, 0, 0);
        CreatePlayerObject(playerid,973, -2062.548096, -115.718750, 35.166935, 0, 0, 180);
        CreatePlayerObject(playerid,1225, -2042.614014, -124.766006, 34.651779, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2042.276733, -128.329132, 34.663055, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2042.025024, -132.687607, 34.681007, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2041.642700, -137.868835, 34.717808, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2041.426880, -141.111725, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2041.288574, -143.401657, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2041.016602, -147.020721, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2040.770386, -150.297256, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2040.692505, -153.235474, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2039.353027, -154.612793, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2036.316528, -154.779053, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2033.045776, -154.687347, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2029.543579, -156.997269, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2026.646118, -159.627060, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2023.610718, -163.053543, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2021.614014, -166.409607, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2021.167114, -169.434769, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.853638, -173.505859, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.595337, -178.758606, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.436035, -184.067459, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.353882, -187.446762, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.294189, -190.886353, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2020.032837, -195.188446, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2019.900024, -199.928207, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2023.939331, -201.555603, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2028.125977, -202.197342, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2032.997314, -202.245728, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2038.529907, -202.236694, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2041.955811, -204.437988, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2043.894287, -206.880768, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2046.462891, -209.915741, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2047.820313, -213.071594, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2048.056885, -216.837219, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2048.151855, -220.537430, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2050.383545, -222.960617, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2053.129395, -224.293259, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2056.260986, -225.874878, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2059.005371, -225.500443, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2061.224121, -224.122742, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2063.714111, -221.460449, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2064.190430, -217.112183, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2064.535400, -212.231552, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2064.851318, -206.732819, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.049316, -202.883667, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.298584, -197.836700, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.397949, -193.946503, 34.837078, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.649658, -188.854095, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.890137, -182.918167, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.158203, -176.039978, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.401367, -168.610062, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.095947, -162.975357, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.087158, -157.294281, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.281006, -151.829300, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.358887, -146.058899, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2066.005859, -139.813278, 34.733147, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2065.747559, -136.000671, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2067.414795, -133.682510, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2070.273438, -132.213989, 34.726067, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2072.827393, -129.196564, 34.730789, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2072.656494, -125.322281, 34.733643, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2070.666016, -121.036743, 34.736496, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2067.880371, -119.043213, 34.766632, 0, 0, 0);
        CreatePlayerObject(playerid,1225, -2064.679199, -116.779121, 34.733040, 0, 0, 0);
        CreatePlayerObject(playerid,966, -2041.694458, -123.222923, 34.234409, 0, 0, 358.3584);
        barrier = CreatePlayerObject(playerid,968, -2041.642212, -123.153976, 35.068645, 0, 356.5622, 0);
        return 1;
}

