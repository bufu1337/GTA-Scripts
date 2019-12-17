#include <a_samp>
 
#define Orange  0xFF9900AA
#define Red     0xAA3333AA
 
static bool:AlreadyUse[MAX_PLAYERS];
 
public OnFilterScriptInit(){printf("\tSimple Control Vehicle System\n\t\t By UploaD");}
 
public OnPlayerConnect(playerid){   AlreadyUse[playerid] = false; return true;}
 
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
        if(IsPlayerInAnyVehicle(playerid))
        {
                new vehicleid = GetPlayerVehicleID(playerid);
            	new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                if (newkeys & KEY_ACTION) // Left CTRL
                {
                    if(AlreadyUse[playerid] == false )
                    {
                                SetVehicleParamsEx(vehicleid, true, lights, alarm, doors, bonnet, boot, objective);
                                AlreadyUse[playerid] = true;
                                SendClientMessage(playerid,Orange,"You've turned on the engine!.");
                        }
                        else
                        {
                                SetVehicleParamsEx(vehicleid, false, lights, alarm, doors, bonnet, boot, objective);
                                AlreadyUse[playerid] = false;
                                SendClientMessage(playerid,Red,"You've turned off the engine!.");
                        }
                }
                if (newkeys & KEY_FIRE) // Left ALT/Left Click
                {
                    if(AlreadyUse[playerid] == false )
                    {
                                SetVehicleParamsEx(vehicleid, engine, true, alarm, doors, bonnet, boot, objective);
                                AlreadyUse[playerid] = true;
                                SendClientMessage(playerid,Orange,"You've turned on your vehicle lights!.");
                        }
                        else
                        {
                                SetVehicleParamsEx(vehicleid, engine, false, alarm, doors, bonnet, boot, objective);
                                AlreadyUse[playerid] = false;
                                SendClientMessage(playerid,Red,"You've turned off your vehicle lights!.");
                        }
                }
                if (newkeys & KEY_YES) // Y
                {
                    if(AlreadyUse[playerid] == false )
                    {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, false, bonnet, boot, objective);
                                AlreadyUse[playerid] = true;
                                SendClientMessage(playerid,Orange,"You've opened your vehicle doors!.");
                        }
                        else
                        {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, true, bonnet, boot, objective);
                                AlreadyUse[playerid] = false;
                                SendClientMessage(playerid,Red,"You've closed your vehicle doors!.");
                        }
                }
                if (newkeys & KEY_NO) // N
                {
                    if(AlreadyUse[playerid] == false )
                    {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, true, boot, objective);
                                AlreadyUse[playerid] = true;
                                SendClientMessage(playerid,Orange,"You've opened your bonnet!.");
                        }
                        else
                        {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, false, boot, objective);
                                AlreadyUse[playerid] = false;
                                SendClientMessage(playerid,Red,"You've closed your bonnet!.");
                        }
                }
                if (newkeys & KEY_CTRL_BACK) // H
                {
                    if(AlreadyUse[playerid] == false )
                    {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, true, objective);
                                AlreadyUse[playerid] = true;
                                SendClientMessage(playerid,Orange,"You've opened your vehicle boot!.");
                        }
                        else
                        {
                                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, false, objective);
                                AlreadyUse[playerid] = false;
                                SendClientMessage(playerid,Red,"You've closed your vehicle boot!.");
                        }
                }
        }
        return true;
}