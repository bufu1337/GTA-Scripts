#include <a_samp>
new COLOR_TOWER = 0xD7FF00FF;
new COLOR_RADIO = 0xBEBEBEFF;
new lsa;
new lva;
new sfa;
new a69;
forward timer_reset(airfield);
forward timer_transmitted(land,playerid);

public OnFilterScriptInit()
{
        print("\n--------------------------------------");
        print("         ATC [FS] by Gamer931215         ");
        print("--------------------------------------\n");
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        new str_transmitting[256];
        format(str_transmitting,256,"~g~Transmitting...");
        if (strcmp("/takeoff", cmdtext, true, 10) == 0)
        {
            if (IsPlayerInAnyVehicle(playerid)) {
                GameTextForPlayer(playerid,str_transmitting,3000,4);
                SetTimerEx("timer_transmitted",3000,false,"ii",0,playerid);
                } else return SendClientMessage(playerid,COLOR_TOWER,"Youre not in a plane!");
                return 1;
}

        if (strcmp("/land", cmdtext, true, 10) == 0)
        {
            if (IsPlayerInAnyVehicle(playerid)) {
                GameTextForPlayer(playerid,str_transmitting,3000,4);
                SetTimerEx("timer_transmitted",3000,false,"ii",1,playerid);
                } else return SendClientMessage(playerid,COLOR_TOWER,"Youre not in a plane!");
                return 1;
}
        return 0;
}

public timer_reset(airfield)
{
        switch(airfield)
        {
                case 0: lsa = 0;
                case 1: lva = 0;
                case 2: sfa = 0;
                case 3: a69 = 0;
        }
}

public timer_transmitted(land,playerid)
{
        if (land == 1)
        {
                        switch(GetVehicleModel(GetPlayerVehicleID(playerid))){
                case 520 , 577 , 511 , 592 , 512 , 513 , 519 , 593 , 553 , 476:
                {
                        new string[64];
                                if (IsPlayerInRangeOfPoint(playerid,700,2061.8948,-2379.8354,16.1250) == 1)//lsa
                                {
                            if (lsa == 0) {
                                lsa = 1;
                                SetTimerEx("timer_reset",20000,false,"i",0);
                                format(string,sizeof string,"~w~Los Santos Airport: ~g~You are allowed to land.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is landing at Lsa",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Los Santos Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,700,1306.2268,1262.2083,14.2656 ) == 1)//lva
                                {
                            if (lva == 0) {
                                lva = 1;
                                SetTimerEx("timer_reset",20000,false,"i",1);
                                format(string,sizeof string,"~w~Las Venturas Airport: ~g~You are allowed to land.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is landing at Lva",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Las Venturas Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,700,-1294.7537,62.1835,14.1484) == 1) //sfa
                                {
                            if (sfa == 0) {
                                sfa = 1;
                                SetTimerEx("timer_reset",20000,false,"i",2);
                                format(string,sizeof string,"~w~San Fierro Airport: ~g~You are allowed to land.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is landing at Sfa",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~San Fierro Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,500,312.1916,2011.1819,17.6406) == 1) //a69
                                {
                            if (a69 == 0) {
                                a69 = 1;
                                SetTimerEx("timer_reset",20000,false,"i",4);
                                format(string,sizeof string,"~w~Area 69: ~g~You are allowed to land.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is landing at A69",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Area 69: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else {
                                    format(string,sizeof string,"~r~Could not transmit to any nearby airport!");
                                        GameTextForPlayer(playerid, string,6500,6);
                                }
                        }
                }
        } else {
                switch(GetVehicleModel(GetPlayerVehicleID(playerid))){
                case 520 , 577 , 511 , 592 , 512 , 513 , 519 , 593 , 553 , 476:
                {
                        new string[64];
                                if (IsPlayerInRangeOfPoint(playerid,700,2061.8948,-2379.8354,16.1250) == 1)//lsa
                                {
                            if (lsa == 0) {
                                lsa = 1;
                                SetTimerEx("timer_reset",20000,false,"i",0);
                                format(string,sizeof string,"~w~Los Santos Airport: ~g~You are allowed to takeoff.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is taking off from lsa",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Los Santos Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,700,1306.2268,1262.2083,14.2656 ) == 1)//lva
                                {
                            if (lva == 0) {
                                lva = 1;
                                SetTimerEx("timer_reset",20000,false,"i",1);
                                format(string,sizeof string,"~w~Las Venturas Airport: ~g~You are allowed to takeoff.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is taking off from Lva",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Las Venturas Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,700,-1294.7537,62.1835,14.1484) == 1) //sfa
                                {
                            if (sfa == 0) {
                                sfa = 1;
                                SetTimerEx("timer_reset",20000,false,"i",2);
                                format(string,sizeof string,"~w~San Fierro Airport: ~g~You are allowed to takeoff.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is taking off from Sfa",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~San Fierro Airport: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                } else if (IsPlayerInRangeOfPoint(playerid,500,312.1916,2011.1819,17.6406) == 1) //a69
                                {
                            if (a69 == 0) {
                                a69 = 1;
                                SetTimerEx("timer_reset",20000,false,"i",4);
                                format(string,sizeof string,"~w~Area 69: ~g~You are allowed to takeoff.");
                                                GameTextForPlayer(playerid,string,6500,6);
                                                new pName[64];
                                                GetPlayerName(playerid,pName,64);
                                                format(string,sizeof string,"Radio: %s is taking off from A69",pName);
                                                SendClientMessageToAll(COLOR_RADIO,string);
                                        } else {
                                            format(string,sizeof string,"~w~Area 69: ~r~Negative, runway in-use");
                                                GameTextForPlayer(playerid,string,6500,6);
                                        }
                                }
                        }
                }
        }
}