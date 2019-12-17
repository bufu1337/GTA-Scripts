//------------------------------------------------------------------------------
//
//   TowTruck miniMission Filter Script v1.0
//   Designed for SA-MP v0.2.1
//
//   Created by zeruel_angel
//
//------------------------------------------------------------------------------

#include <a_samp>
enum posicion{
        Float:X,
        Float:Y,
        Float:Z,
        Float:angle
        }
#define BONUS 500
#define MAX_CASH 2000
#define MIN_CASH 1000

new Rotos[100][posicion];
new archRotos[]="TowTruck.txt";
new playerInMiniMissionGrua[MAX_PLAYERS];
new contador[MAX_PLAYERS];
new avisado1[MAX_PLAYERS];
new cantidadRotos;
new enganchado[MAX_PLAYERS];
forward terminarMission(playerid);
forward cerrarRoto();
forward enganchador();
public OnFilterScriptInit()
        {
        print("\nTowTruck Filter Script v1.0 Loading...\n*******************************\n      (Zeruel_Angel)\n");
        new File:fileGrua;
        new lineaGrua[255];
        fileGrua = fopen(archRotos,io_readwrite);
        new j=0;
        new idx;
        while   ((fread(fileGrua,lineaGrua,sizeof(lineaGrua),false))&&(j<25))
                        {
                        idx = 0;
                        Rotos[j][X] = floatstr(strtok(lineaGrua,idx));
                        Rotos[j][Y] = floatstr(strtok(lineaGrua,idx));
                        Rotos[j][Z] = floatstr(strtok(lineaGrua,idx));
                        Rotos[j][angle] = floatstr(strtok(lineaGrua,idx));
                        j++;
                        }
        cantidadRotos=j;
        fclose(fileGrua);
        format(lineaGrua,sizeof(lineaGrua),"Total TowTruck destinations loaded: %d", cantidadRotos);
        print(lineaGrua);
        for (new i=0;i<MAX_PLAYERS;i++)
            {
        playerInMiniMissionGrua[i]=-1;
        avisado1[i]=-1;
        enganchado[i]=0;
            }
        SetTimer("cerrarRoto",5000,1);
        SetTimer("enganchador",3000,1);
        print("TowTruck Filter Script fully Loaded\n**********************************\n\n");
        }
//------------------------------------------------------------------------------------------------------
public OnFilterScriptExit()
        {
    print("\nTowTruck Script UnLoaded\n********************************************\n\n");
        return 1;
        }
//------------------------------------------------------------------------------------------------------
public cerrarRoto()
        {
        for     (new i=0;i<MAX_PLAYERS;i++)
            {
            if (playerInMiniMissionGrua[i]!=-1)
                {
                for (new j=0;j<MAX_PLAYERS;j++)
                    {
                    if  (IsPlayerConnected(j))
                        {
                        SetVehicleParamsForPlayer(playerInMiniMissionGrua[i],j,0,1);
                        }
                    }
                }
            }
        return 1;
        }
//------------------------------------------------------------------------------------------------------
public enganchador()
        {
        new Float:pX,Float:pY,Float:pZ;
        for     (new i=0;i<MAX_PLAYERS;i++)
            {
            if ((playerInMiniMissionGrua[i]!=-1)&&(enganchado[i]==1))
                {
                if      ((IsPlayerInAnyVehicle(i))&&(GetVehicleModel(GetPlayerVehicleID(i)) == 525))
                        {
                        if      (IsTrailerAttachedToVehicle(GetPlayerVehicleID(i)))
                            {
                            if  (GetVehicleTrailer(GetPlayerVehicleID(i))!=playerInMiniMissionGrua[i])
                                            {
                                                enganchado[i]=0;
                                                GetVehiclePos(playerInMiniMissionGrua[i],pX,pY,pZ);
                                                pX=pX+3.0*floatsin(-Rotos[i][angle],degrees);
                                                pY=pY+3.0*floatcos(-Rotos[i][angle],degrees);
                                                SetPlayerRaceCheckpoint(i,0,pX,pY,pZ,1960.0590,2162.1296,10.8203,5.0);
                                                }
                                }
                                else
                                    {
                                        enganchado[i]=0;
                                        GetVehiclePos(playerInMiniMissionGrua[i],pX,pY,pZ);
                                        pX=pX+3.0*floatsin(-Rotos[i][angle],degrees);
                                        pY=pY+3.0*floatcos(-Rotos[i][angle],degrees);
                                        SetPlayerRaceCheckpoint(i,0,pX,pY,pZ,1960.0590,2162.1296,10.8203,5.0);
                                        }
                    }
                        else
                            {
                                enganchado[i]=0;
                                GetVehiclePos(playerInMiniMissionGrua[i],pX,pY,pZ);
                                pX=pX+3.0*floatsin(-Rotos[i][angle],degrees);
                                pY=pY+3.0*floatcos(-Rotos[i][angle],degrees);
                                SetPlayerRaceCheckpoint(i,0,pX,pY,pZ,1960.0590,2162.1296,10.8203,5.0);
                                }
                }
            }
        return 1;
        }
//------------------------------------------------------------------------------------------------------
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
//------------------------------------------------------------------------------------------------------
public terminarMission(playerid)
        {
        GameTextForPlayer(playerid,"~r~TowTruck ~n~ ~w~MiniMision ~n~~w~cancelled",3000,4);
        DestroyVehicle(playerInMiniMissionGrua[playerid]);
    playerInMiniMissionGrua[playerid]=-1;
    avisado1[playerid]=-1;
    DisablePlayerRaceCheckpoint(playerid);
    contador[playerid]=0;
        enganchado[playerid]=0;
    return 1;
        }
//------------------------------------------------------------------------------------------------------
public OnPlayerStateChange(playerid, newstate, oldstate)
        {
        if (newstate==PLAYER_STATE_DRIVER)
            {
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
                {
                if      (avisado1[playerid]==-1)
                    {
                                GameTextForPlayer(playerid,"~w~Press ~b~Buttom 2~n~~w~to start ~r~TowTruck~n~~w~Minimission",3000,5);//SetTimerEx("MandarMensaje",5500,0,"%d",playerid);
                                }
                        else
                            {
                            KillTimer(avisado1[playerid]);
                            avisado1[playerid]=-1;
                            }
                    }
            }
        if      (newstate==PLAYER_STATE_ONFOOT)
            {
            if  ((playerInMiniMissionGrua[playerid]>0)&&(avisado1[playerid]==-1))
                    {
                    GameTextForPlayer(playerid,"~w~You have ~r~10 sec ~n~~w~ to get a TowTruck",3000,4);
                    avisado1[playerid]=SetTimerEx("terminarMission",10000,0,"%d",playerid);
                    }
            }
        return 1;
        }
//------------------------------------------------------------------------------------------------------
  crearAutoRoto(playerid)
        {
        new index = random(cantidadRotos);
        DisablePlayerRaceCheckpoint(playerid);
        new ran=random(2);
        new mid=605;
        if      (ran!=1)
            {
            mid=604;
            }
        new ran2=random(126);
        ran = random(126);
        playerInMiniMissionGrua[playerid]=CreateVehicle(mid,Rotos[index][X],Rotos[index][Y],Rotos[index][Z],Rotos[index][angle],ran,ran2,-1);
        SetPlayerRaceCheckpoint(playerid,0,Rotos[index][X]+3.0*floatsin(-Rotos[index][angle],degrees),Rotos[index][Y]+3.0*floatcos(-Rotos[index][angle],degrees),Rotos[index][Z],1960.0590,2162.1296,10.8203,5.0);
        SetVehicleParamsForPlayer(playerInMiniMissionGrua[playerid],playerid,1,1);
        return 1;
        }
//------------------------------------------------------------------------------------------------------
  MissionIni(playerid)
    {
    GameTextForPlayer(playerid,"~r~TowTruck ~w~MiniMision ~w~starts!~n~ tow away the ~r~ wrecked vehicle ~w~ to the ~n~~r~Paint & Spray",3000,4);
    crearAutoRoto(playerid);
    return 1;
    }
//------------------------------------------------------------------------------------------------------
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
        {
        if ((newkeys==KEY_SUBMISSION)&&(IsPlayerInAnyVehicle(playerid))&&(GetPlayerState(playerid)==PLAYER_STATE_DRIVER))
            {
            if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 525)
                {
            if  (playerInMiniMissionGrua[playerid]<0)
                        {
                        MissionIni(playerid);
                        }
                        else
                            {
                                terminarMission(playerid);
                            }
                    }
            }
        }
//------------------------------------------------------------------------------------------------------
public OnPlayerEnterRaceCheckpoint(playerid)
        {
        if      (playerInMiniMissionGrua[playerid]!=-1)
            {
            if  (enganchado[playerid]==0)
                {
                if      (IsPlayerInAnyVehicle(playerid))
                {
                new vehicleid = GetPlayerVehicleID(playerid);
                                new mid = GetVehicleModel(vehicleid);
                        if (mid == 525)
                                {
                                if      (IsTrailerAttachedToVehicle(vehicleid))
                                    {
                                    DetachTrailerFromVehicle(vehicleid);
                                    }
                            AttachTrailerToVehicle(playerInMiniMissionGrua[playerid],vehicleid);
                            GameTextForPlayer(playerid,"~w~tow away the  ~r~wrecked vehicle ~n~ ~w~with the ~r~TowTruck ~n~ ~w~ to the ~r~Paint & Spray",3000,4);
                            SetPlayerRaceCheckpoint(playerid,0,1960.0590,2162.1296,10.8203,1960.0590,2162.1296,10.8203,5.0);
                                        enganchado[playerid]=1;
                                }
                        else
                                    {
                                    GameTextForPlayer(playerid,"~w~You need a~r~TowTruck",3000,4);
                                    }
                    }
                        else
                            {
                            GameTextForPlayer(playerid,"~w~You need a ~r~TowTruck",3000,4);
                            }
                return 1;
                }
            if (IsPlayerInAnyVehicle(playerid))
                {
                new vehicleid = GetPlayerVehicleID(playerid);
                new mid = GetVehicleModel(vehicleid);
                if      ((mid == 525)&&(IsTrailerAttachedToVehicle(vehicleid))&&(GetVehicleTrailer(vehicleid)==playerInMiniMissionGrua[playerid]))
                        {
                        enganchado[playerid]=0;
                    contador[playerid]++;
                                new cash=(random(MAX_CASH-MIN_CASH)+MIN_CASH);
                                GivePlayerMoney(playerid,cash);
                                DestroyVehicle(playerInMiniMissionGrua[playerid]);
                                playerInMiniMissionGrua[playerid]=-1;
                                crearAutoRoto(playerid);
                                if      ((((contador[playerid]/5)*5)==contador[playerid])&&(contador[playerid]!=0))
                                    {
                                    new string[255];
                                    format(string,sizeof(string),"You get a ~r~BONUS ~w~ every 5 cars!.~n~You towed away %d cars your bonus is ~n~~b~$%d",contador[playerid],contador[playerid]*BONUS);
                                        GivePlayerMoney(playerid,contador[playerid]*BONUS);
                                    GameTextForPlayer(playerid,string,3000,3);
                                    }
                                else
                                    {
                                        GameTextForPlayer(playerid,"~w~Mission complete! Here is your cash!. ~n~go get the other ~r~wrecked vehicle ~w~to the ~r~Paint & Spray",5000,3);
                                        }
                }
                }
                }
        return 1;
        }
//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
        {
        terminarMission(playerid);
        return 1;
        }

