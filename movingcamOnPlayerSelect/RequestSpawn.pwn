#include <a_samp>
enum pInfo{bool:SpawnDance,Float:SpawnAngle,SpawnTimer};
new SkinClass[MAX_PLAYERS][pInfo];
new ClosedSelection[MAX_PLAYERS];
new Float:cordinatex,Float:cordinatey,Float:cordinatez,Float:cordinateangle;
new Float:RequestCamera[9][4] =
{
    {1296.4391,1583.2622,50.2969,317.8491},
    {1054.8481,1019.7778,57.3438,95.0108},
    {1452.0229,750.9430,32.6900,88.4309},
    {2213.8701,1679.2406,57.3038,91.4144 },
    {746.1910,740.3755,29.1076,24.4488},
    {199.7275,1393.2085,47.8297,179.5663},
    {596.4931,1502.9486,9.0578,29.4318},
    {-207.8227,1901.1121,128.4624,68.0533},
    {-2387.3440,2401.0579,20.7627,240.9129}
};
public OnPlayerRequestClass(playerid, classid)
{
    if(ClosedSelection[playerid] == 0) {

        new rand = random(sizeof(RequestCamera));
        cordinatex = RequestCamera[rand][0];
        cordinatey = RequestCamera[rand][1];
        cordinatez = RequestCamera[rand][2];
        cordinateangle = RequestCamera[rand][3];
        SetPlayerPos(playerid,cordinatex,cordinatey,cordinatez);
        SetPlayerFacingAngle(playerid, cordinateangle);
        SetPlayerCameraPos(playerid,cordinatex+(3.8*floatsin(-cordinateangle,degrees)),cordinatey+(3.8*floatcos(-cordinateangle,degrees)),cordinatez);
        SetPlayerCameraLookAt(playerid, cordinatex,cordinatey,cordinatez);
        ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1);
        PlayerPlaySound(playerid, 1097,-119.9460,23.1096,12.2238);
        if (SkinClass[playerid][SpawnDance]) SkinClass[playerid][SpawnTimer] = SetTimerEx("MoveCamera", 50, true, "i", playerid);
        SkinClass[playerid][SpawnDance] = false;
    }
    return 1;
}


public OnPlayerConnect(playerid)
{
    ClosedSelection[playerid]=0;
    ApplyAnimation(playerid,"BOMBER","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"SHOP","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"RAPPING","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"BEACH","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"SMOKING","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"FOOD","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"ON_LOOKERS","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"DEALER","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"CARRY","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"COP_AMBIENT","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"PARK","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"INT_HOUSE","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"FOOD","null",0.0,0,0,0,0,0);
    ApplyAnimation(playerid,"PED","null",0.0,0,0,0,0,0);
    SkinClass[playerid][SpawnDance] = true;
    ApplyAnimation(playerid,"DANCING","DNCE_M_B",4.0,1,0,0,0,-1);
    return 1;
}


public OnPlayerSpawn(playerid)
{
    ClosedSelection[playerid]=0;
    SkinClass[playerid][SpawnAngle] = 0.0;
    SkinClass[playerid][SpawnDance] = true;
    KillTimer( SkinClass[playerid][SpawnTimer] );
    PlayerPlaySound(playerid, 1186, 0.0, 0.0, 0.0);
    SetCameraBehindPlayer(playerid);
    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(SkinClass[playerid][SpawnTimer] );
    return 1;
}


forward MoveCamera(playerid,rand);
public MoveCamera(playerid,rand)
{
    SetPlayerCameraPos(playerid, cordinatex - 2 * floatsin(-SkinClass[playerid][SpawnAngle], degrees), cordinatey - 10 * floatcos(-SkinClass[playerid][SpawnAngle], degrees), cordinatez + 3);
    SetPlayerCameraLookAt(playerid, cordinatex, cordinatey, cordinatez + 0.5);
    SkinClass[playerid][SpawnAngle] += 0.5;
    if (SkinClass[playerid][SpawnAngle] >= 360.0)
        SkinClass[playerid][SpawnAngle] = 0.0;

}

