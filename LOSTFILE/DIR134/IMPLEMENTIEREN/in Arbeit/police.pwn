#include <a_samp>

// This is a comment
// uncomment the line below if you want to write a filterscript
//#define FILTERscript
new gates[10];
new wgates[20];
new lamp[10];
new GateRotTimer;
forward  OpenRotGate(objectid);
forward  CloseRotGate(objectid);
#define COLOR_YELLOW 0xFFFF00AA

#if defined FILTERscript


public OnFilterscriptInit()
{
        print("\n--------------------------------------");
        print(" Police station useful comands by Gecatahh");
        print("--------------------------------------\n");
        return 1;
}

public OnFilterscriptExit()
{
        return 1;
}

#else

main()
{
        print("\n----------------------------------");
        print(" Police station useful comands by Gecatahh");
        print("----------------------------------\n");
}

#endif

public OnGameModeInit()
{
        gates[1] = CreateObject(971,1589.053344,-1638.123168,14.122960,0.000000,0.000000,181.045272);//gateinside
        CreateObject(997,1544.590576,-1617.848388,12.438137,0.000000,0.000000,271.938476);
        CreateObject(997,1544.710205,-1620.973266,12.416269,0.000000,0.000000,270.590179);
        CreateObject(997,1544.037353,-1632.651123,12.576721,0.000000,0.000000,269.745178);
        CreateObject(997,1544.005737,-1635.747070,12.857315,0.000000,0.000000,270.540161);
        gates[3] = CreateObject(968,1544.700317,-1630.735717,13.096980,-1.000000,-91.000000,269.972869);//gateout
        CreateObject(1616,1583.743530,-1637.326538,17.417528,0.000000,-14.000000,251.336318);//camera1
        CreateObject(1616,1540.411865,-1641.461914,18.786596,0.000000,-10.000000,298.783935);//camera2
        CreateObject(1215,1544.439819,-1623.946655,12.815100,0.000000,0.000000,264.435058);
        CreateObject(1215,1544.219482,-1630.794067,12.832411,0.000000,0.000000,241.320739);
        CreateObject(1215,1584.373291,-1637.751464,12.904351,0.000000,0.000000,164.794158);
        CreateObject(1215,1592.681762,-1637.685302,12.979562,0.000000,0.000000,184.221054);
        CreateObject(1215,1546.053833,-1672.452758,12.984669,0.000000,0.000000,308.639587);
        CreateObject(1215,1546.100097,-1678.703247,13.097762,0.000000,0.000000,211.866531);
        CreateObject(2008,256.912719,86.266647,1001.380432,0.000000,0.000000,89.637771);
        CreateObject(2008,256.895721,84.360313,1001.387145,0.000000,0.000000,90.264396);
        CreateObject(1708,258.067474,87.681488,1001.343872,0.000000,0.000000,270.072540);
        CreateObject(1708,258.011108,85.874336,1001.301879,0.000000,0.000000,268.482452);
        CreateObject(1616,251.099990,91.619064,1004.695495,6.000000,-6.000000,189.532470);//camera3
        CreateObject(1616,242.434860,62.707202,1006.762084,0.000000,-1.000000,276.543151);//camera4
        gates[4] = CreateObject(1553,246.750320,72.625373,1003.791320,0.000000,0.000000,359.420227);//door1
        gates[5] = CreateObject(1553,252.132568,74.126708,1003.869262,0.000000,0.000000,270.505157);//door2
        gates[6] = CreateObject(1553,259.135986,90.645027,1002.695190,0.000000,0.000000,270.107757);//door3
        gates[7] = CreateObject(1553,266.258880,87.403976,1001.264709,0.000000,0.000000,90.746047);//door4
        gates[8] = CreateObject(1553,266.226318,82.993461,1001.272521,0.000000,0.000000,90.333274);//door5
        wgates[1] = CreateObject(969,266.254119,80.097030,1002.746459,0.000000,0.000000,89.614189);
        wgates[2] = CreateObject(969,258.981872,93.270011,998.136230,0.000000,0.000000,270.699279);
        wgates[3] = CreateObject(969,247.969924,89.569862,1005.312072,0.000000,0.000000,270.628265);
        wgates[4] = CreateObject(969,244.005432,72.650382,1005.176635,0.000000,0.000000,-1.310884);
        wgates[5] = CreateObject(969,241.849548,65.413963,999.263977,0.000000,0.000000,359.059967);
        wgates[6] = CreateObject(971,1546.122924,-1675.582031,7.959709,0.000000,0.000000,269.105682);//outgates
        wgates[7] = CreateObject(971,1550.607788,-1671.214233,7.326846,0.000000,0.000000,179.444091);
        wgates[8] = CreateObject(971,1550.480712,-1679.953857,7.754576,0.000000,0.000000,0.3578);
        wgates[9] = CreateObject(971,1559.672729,-1675.573364,19.358980,-90.000000,0.000000,269.081054);
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

public OnPlayerRequestSpawn(playerid)
{
        return 1;
}

public OnPlayerConnect(playerid)
{
        return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
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
public OpenRotGate(objectid){
        new Float:lspdx2,Float:lspdy2,Float:lspdz2,rotstr[256];
        GetObjectRot(objectid, lspdx2, lspdy2, lspdz2);
        format(rotstr,sizeof(rotstr), "x:%f y:%f z:%f", lspdx2, lspdy2, lspdz2);
        SendClientMessageToAll(COLOR_YELLOW,rotstr);
           if(lspdy2<0){
        SetObjectRot(objectid, lspdx2, lspdy2+2, lspdz2);
        SendClientMessageToAll(COLOR_YELLOW,"lol1");}
        else {
            KillTimer(GateRotTimer);
            SendClientMessageToAll(COLOR_YELLOW,"lol2");}
}
public CloseRotGate(objectid){
    new Float:lspdx2,Float:lspdy2,Float:lspdz2,rotstr[256];
    GetObjectRot(objectid, lspdx2, lspdy2, lspdz2);
    format(rotstr,sizeof(rotstr), "x:%f y:%f z:%f", lspdx2, lspdy2, lspdz2);
    SendClientMessageToAll(COLOR_YELLOW,rotstr);
    if(lspdy2>-91){
        SendClientMessageToAll(COLOR_YELLOW,"lol1");
        SetObjectRot(objectid, lspdx2, lspdy2-2, lspdz2);}
    else {
        KillTimer(GateRotTimer);
        SendClientMessageToAll(COLOR_YELLOW,"lol2");}
}
public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp(cmdtext, "/lspdinclose", true) == 0){
        MoveObject(gates[1], 1589.053344,-1638.123168,14.122960,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdinopen", true) == 0){
        MoveObject(gates[1], 1589.053344,-1638.123168,7.858397,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdoutopen", true) == 0){
        GateRotTimer = SetTimerEx("OpenRotGate",300,1, "i",gates[3]);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdoutclose", true) == 0){
        GateRotTimer = SetTimerEx("CloseRotGate",300,1, "i",gates[3]);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdcamera1", true) == 0){
        TogglePlayerControllable(playerid, 0);
        SetPlayerCameraPos(playerid, 1539.7491,-1636.6981,13.9816);
        SetPlayerCameraLookAt(playerid, 1543.4221,-1626.4825,13.3828);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdcamera2", true) == 0){
        TogglePlayerControllable(playerid, 0);
        SetPlayerCameraPos(playerid, 1582.6552,-1637.4558,13.3905);
        SetPlayerCameraLookAt(playerid, 1588.0464,-1628.6290,13.3828);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdcameraoff", true) == 0){
        SetCameraBehindPlayer(playerid);
        TogglePlayerControllable(playerid, 1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor1close", true) == 0){
        MoveObject(gates[4], 246.750320,72.625373,1003.791320,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor1open", true) == 0){
        MoveObject(gates[4], 248.560958,72.655189,1003.791320,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor2close", true) == 0){
        MoveObject(gates[5], 252.132568,74.126708,1003.869262,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor2open", true) == 0){
        MoveObject(gates[5], 252.132568,74.126708,1006.383789,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor3close", true) == 0){
        MoveObject(gates[6], 259.135986,90.645027,1002.695190,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor3open", true) == 0){
        MoveObject(gates[6], 259.135986,90.645027,1005.024963,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor4close", true) == 0){
        MoveObject(gates[7], 266.258880,87.403976,1001.264709,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor4open", true) == 0){
        MoveObject(gates[7], 266.259887,85.617530,1001.264709,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor5close", true) == 0){
        MoveObject(gates[8], 266.226318,82.993461,1001.272521,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspddoor5open", true) == 0){
        MoveObject(gates[8], 266.226318,81.172584,1001.272521,1);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdcamera3", true) == 0){
        TogglePlayerControllable(playerid, 0);
        SetPlayerCameraPos(playerid, 242.9750,62.7240,1003.6406);
        SetPlayerCameraLookAt(playerid, 246.4861,69.7667,1003.6406);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdcamera4", true) == 0){
        TogglePlayerControllable(playerid, 0);
        SetPlayerCameraPos(playerid, 251.4041,91.4763,1002.4453);
        SetPlayerCameraLookAt(playerid, 254.8335,89.5035,1002.4453);
        return 1;
        }
        if (strcmp(cmdtext, "/lspdwarnoff", true) == 0){
        MoveObject(wgates[1], 266.254119,80.097030,1002.746459,2);
        MoveObject(wgates[2], 258.981872,93.270011,998.136230,2);
        MoveObject(wgates[3], 247.969924,89.569862,1005.312072,2);
        MoveObject(wgates[4], 244.005432,72.650382,1005.176635,2);
        MoveObject(wgates[5], 241.849548,65.413963,999.263977,2);
        MoveObject(wgates[6], 1546.122924,-1675.582031,7.959709,2);
        MoveObject(wgates[7], 1550.607788,-1671.214233,7.326846,2);
        MoveObject(wgates[8], 1550.480712,-1679.953857,7.754576,2);
        MoveObject(wgates[9], 1559.672729,-1675.573364,19.358980,2);
        DestroyObject( lamp[1] );
        DestroyObject( lamp[2] );
        DestroyObject( lamp[3] );
        DestroyObject( lamp[4] );
        DestroyObject( lamp[5] );
        DestroyObject( lamp[6] );
        DestroyObject( lamp[7] );
        DestroyObject( lamp[8] );
        DestroyObject( lamp[9] );
        return 1;
        }
        if (strcmp(cmdtext, "/lspdwarnon", true) == 0){
        MoveObject(wgates[1], 266.254119,80.097030,999.760253,2);
        MoveObject(wgates[2], 258.981872,93.270011,1001.136230,2);
        MoveObject(wgates[3], 247.969924,89.569862,1002.348022,2);
        MoveObject(wgates[4], 244.005432,72.650382,1002.408935,2);
        MoveObject(wgates[5], 241.849548,65.413963,1002.319763,2);
        lamp[1] = CreateObject(3666,1546.472412,-1672.418457,13.930196,0.000000,0.000000,26.449516);
        lamp[2] = CreateObject(3666,1546.703491,-1678.717895,13.916833,0.000000,0.000000,173.934997);
        lamp[3] = CreateObject(3666,1554.529052,-1672.435791,16.195312,0.000000,0.000000,285.482727);
        lamp[4] = CreateObject(3666,1554.332763,-1678.736328,16.195312,0.000000,0.000000,233.468902);
        lamp[5] = CreateObject(3666,242.569076,72.190734,1003.134521,0.000000,0.000000,40.420383);
        lamp[6] = CreateObject(3666,250.217651,72.105926,1003.228698,0.000000,0.000000,308.612823);
        lamp[7] = CreateObject(3666,251.069580,81.934661,1001.882568,0.000000,0.000000,133.771133);
        lamp[8] = CreateObject(3666,270.200134,92.650123,1000.553222,0.000000,0.000000,334.065551);
        lamp[9] = CreateObject(3666,270.344757,75.482254,1000.476379,0.000000,0.000000,191.497604);
        MoveObject(wgates[6], 1546.122924,-1675.582031,15.798633,2);
        MoveObject(wgates[7], 1550.607788,-1671.214233,15.777406,2);
        MoveObject(wgates[8], 1550.480712,-1679.953857,15.820456,2);
        MoveObject(wgates[9], 1549.670043,-1675.573364,19.358980,2);
        return 1;
        }
        if (strcmp(cmdtext, "/lshelp", true) == 0){
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdinclose  /lspdinopen");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdoutclose  /lspdoutopen");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspddoor1close  /lspddoor1open");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspddoor2close  /lspddoor2open");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspddoor3close  /lspddoor3open");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspddoor4close  /lspddoor4open");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspddoor5close  /lspddoor5open");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdwarnoff  /lspdwarnon");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdcamera1  /lspdcamera2");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdcamera3  /lspdcamera4");
        SendClientMessage(playerid, 0xFFFF00AA,"/lspdcameraoff  /lspd");
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
        return 1;
}

public OnPlayerExitedMenu(playerid)
{
        return 1;
}

