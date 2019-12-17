//-------------------------------------------------
//
//  Creating commands set set player's specials
//  actions.
//  kyeman 2007
//
//-------------------------------------------------

#pragma tabsize 0
#include <a_samp>
#include <core>
#include <float>

forward Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance);
forward showIcons();
forward HidePhone(playerid);

#define COLOR_SYSMSG 0xFF9000FF

new showIconsTimer;
new pizza_pickup[MAX_PLAYERS];
new bool:pizza_driver[MAX_PLAYERS];
new bool:need_pizza[MAX_PLAYERS];

//-------------------------------------------------


Float:GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
        new Float:a;
        GetPlayerPos(playerid, x, y, a);
        if (IsPlayerInAnyVehicle(playerid)) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
        else GetPlayerFacingAngle(playerid, a);
        x += (distance * floatsin(-a, degrees));
        y += (distance * floatcos(-a, degrees));
        return a;
}

public showIcons()
{
        new Float:posX;
        new Float:posY;
        new Float:posZ;

        for(new i=0; i<MAX_PLAYERS; i++)
        {
                for(new i2=0; i2<MAX_PLAYERS; i2++)
                {
                        if(IsPlayerConnected(i) && IsPlayerConnected(i2))
                        {
                                GetPlayerPos(i2, posX, posY, posZ);
                                if(pizza_driver[i] && need_pizza[i2])
                                {
                                        SetPlayerMapIcon( i, i2, posX, posY, posZ, 60, 0 );
                                } else if(pizza_driver[i2])
                                {
                                        SetPlayerMapIcon( i, i2, posX, posY, posZ, 29, 0 );
                                } else {
                                        RemovePlayerMapIcon(i, i2);
                                }
                } else {
                                RemovePlayerMapIcon(i, i2);
                                RemovePlayerMapIcon(i2, i);
                        }
                }

        }
}

public HidePhone(playerid)
{
        SetPlayerSpecialAction (playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
}

//-------------------------------------------------

public OnFilterScriptInit()
{
        showIconsTimer = SetTimer("showIcons",500,1);
        return 1;
}

public OnFilterScriptExit()
{
        KillTimer(showIconsTimer);
        for(new i=0; i<MAX_PLAYERS; i++)
        {
                for(new i2=0; i2<MAX_PLAYERS; i2++)
                {
                RemovePlayerMapIcon(i, i2);
                RemovePlayerMapIcon(i2, i);
                }
        }
        return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{

        if(strcmp(cmdtext,"/pizza",true)==0)
        {

        SendClientMessage(playerid, COLOR_SYSMSG, "  ===============- Pizza commands -===============");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /callpizza - Ask for a pizza");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /nopizza - Cancel your order");
                SendClientMessage(playerid, COLOR_SYSMSG, "  ------------------------------------------------");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /impizzaman - Become a pizza delivery guy");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /whowantspizza - A list of who wants pizza");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /droppizza - Drop a pizza");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /takepizza - Take back your pizza");
                SendClientMessage(playerid, COLOR_SYSMSG, "    /ihatepizza - Quit the pizza delivery job");
                SendClientMessage(playerid, COLOR_SYSMSG, "  ============- Made by Banana[NL] -==============");

                return 1;
        }


        if (strcmp(cmdtext, "/callpizza", true)==0)
        {
                new call_name[24], string[256];
                if(!need_pizza[playerid]) {
                    need_pizza[playerid] = true;
                    SetPlayerSpecialAction ( playerid , SPECIAL_ACTION_USECELLPHONE );
                    SetTimerEx("HidePhone",2000,0,"i",Float:playerid);
                for(new i=0; i<MAX_PLAYERS; i++)
                        {
                                if(IsPlayerConnected(i))
                                {
                                    if(pizza_driver[i]) {
                                        GetPlayerName(playerid, call_name, sizeof(call_name));
                                        format(string, sizeof(string), "%s wants pizza!", call_name);
                                        SendClientMessage(i, COLOR_SYSMSG, string);
                                }
                                }
                        }
                SendClientMessage(playerid,COLOR_SYSMSG,"You've called for a pizza!");
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"You've already called for a pizza!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/nopizza", true)==0)
        {
                new cancel_name[24], string[256];
                if(need_pizza[playerid]) {
                    need_pizza[playerid] = false;
                        SetPlayerSpecialAction ( playerid , SPECIAL_ACTION_USECELLPHONE );
                    SetTimerEx("HidePhone",2000,0,"i",Float:playerid);
                for(new i=0; i<MAX_PLAYERS; i++)
                        {
                                if(IsPlayerConnected(i))
                                {
                                    if(pizza_driver[i]) {
                                        GetPlayerName(playerid, cancel_name, sizeof(cancel_name));
                                        format(string, sizeof(string), "%s no longer wants pizza!", cancel_name);
                                        SendClientMessage(i, COLOR_SYSMSG, string);
                                }
                                }
                        }
                SendClientMessage(playerid,COLOR_SYSMSG,"You've canceled your pizza!");
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"You didnt order a pizza!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/whowantspizza", true)==0)
        {
                new need_name[24], string[256];
                new players_that_want_count=0;
                if(pizza_driver[playerid]) {
                        for(new i=0; i<MAX_PLAYERS; i++)
                        {
                                if(IsPlayerConnected(i))
                                {
                                    if(need_pizza[i])
                                        {
                                            if(players_that_want_count == 0)
                                            {
                                                        SendClientMessage(playerid,COLOR_SYSMSG,"These players want pizza:");
                                                }
                                                players_that_want_count++;
                                                GetPlayerName(i, need_name, sizeof(need_name));
                                        format(string, sizeof(string), "- %s", need_name);
                                        SendClientMessage(playerid, COLOR_SYSMSG, string);
                                }
                        }
                        }
                        if(players_that_want_count == 0)
                        {
                                SendClientMessage(playerid,COLOR_SYSMSG,"Nobody wants pizza!");
                        }
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your no pizza delivery guy!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/impizzaman", true)==0)
        {
                if(!pizza_driver[playerid]) {
                    pizza_driver[playerid] = true;
                SendClientMessage(playerid,COLOR_SYSMSG,"Your a pizza delivery guy!");
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your a pizza delivery guy already!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/ihatepizza", true)==0)
        {
                if(pizza_driver[playerid]) {
                    pizza_driver[playerid] = false;
                SendClientMessage(playerid,COLOR_SYSMSG,"Your no longer a pizza delivery guy!");
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your not a pizza delivery guy!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/takepizza", true)==0)
        {
                if(pizza_driver[playerid]) {
                    if(pizza_pickup[playerid])
                        {
                        SendClientMessage(playerid,COLOR_SYSMSG,"You took your pizza back!");
                        DestroyPickup(pizza_pickup[playerid]);
                                pizza_pickup[playerid] = false;
                        } else {
                        SendClientMessage(playerid,COLOR_SYSMSG,"You didnt drop a pizza!");
                        }
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your not a pizza delivery guy!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/droppizza", true)==0)
        {
                if(pizza_driver[playerid]) {
                    if(!pizza_pickup[playerid]) {
                                new Float:x, Float:y, Float:z;
                                GetPlayerPos(playerid, x, y, z);
                                GetXYInFrontOfPlayer(playerid, x, y, 2.5);
                                pizza_pickup[playerid] = CreatePickup(1582, 3, x, y, z+0.3);
                        SendClientMessage(playerid,COLOR_SYSMSG,"Dropped pizza!");
                } else {
                        SendClientMessage(playerid,COLOR_SYSMSG,"You already dropped a pizza!");
                }
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your no pizza delivery guy!");
                }
                return 1;
        }

        return 0;
}


public OnPlayerPickUpPickup(playerid, pickupid)
{
        new pickup_ply_name[24], string[256];
        for(new i=0; i<MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                        if (pickupid == pizza_pickup[i])
                        {
                            if (playerid != i)
                            {
                                        GivePlayerMoney(i,25);
                                        GivePlayerMoney(playerid,-25);
                                        SetPlayerHealth(playerid,100.0);
                                        SetPlayerArmour(playerid, 100.0);
                                SendClientMessage(playerid,COLOR_SYSMSG,"You've bought a pizza for $25!");
                                SendClientMessage(i,COLOR_SYSMSG,"You've sold a pizza for $25!");
                                DestroyPickup(pickupid);
                                        pizza_pickup[i] = false;
                                        need_pizza[playerid] = false;

                            if(pizza_driver[i]) {

                                        GetPlayerName(playerid, pickup_ply_name, sizeof(pickup_ply_name));
                                                format(string, sizeof(string), "%s got a pizza!", pickup_ply_name);
                                                SendClientMessage(i, COLOR_SYSMSG, string);
                                        DestroyPickup(pickupid);
                                                RemovePlayerMapIcon(i, playerid);
                                                RemovePlayerMapIcon(i, playerid);
                                                need_pizza[playerid] = false;
                                        }

                            } else {
                                SendClientMessage(playerid,COLOR_SYSMSG,"You took your pizza back!");
                                DestroyPickup(pickupid);
                                        pizza_pickup[i] = false;
                        }
                        }

                }
        }
        return 1;
}
public OnPlayerConnect(playerid)
{
        DestroyPickup(pizza_pickup[playerid]);

        pizza_pickup[playerid] = false;
        need_pizza[playerid] = false;
        pizza_driver[playerid] = false;

        for(new i=0; i<MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                        RemovePlayerMapIcon(playerid, i);
                }
        }
        return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
        DestroyPickup(pizza_pickup[playerid]);

        pizza_pickup[playerid] = false;
        need_pizza[playerid] = false;
        pizza_driver[playerid] = false;

        for(new i=0; i<MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                        RemovePlayerMapIcon(playerid, i);
                }
        }
        return 1;
}
//-------------------------------------------------
// EOF
