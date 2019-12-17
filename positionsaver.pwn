//________________________________________________________________________________
/*|                     This Filterscript Was Made By                            |
  |________________________[HiC]TheKiller and AFX!_______________________________|*/
//====================================================================================
#include <a_samp>
//===========**Defines**===========
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define FILTERSCRIPT
#if defined FILTERSCRIPT
public OnFilterScriptInit()
{
        print("\n=========================================|\r");
        print("  Car Saver By [HiC]TheKiller AND AFX!     |\r");
        print("=========================================|\n");
        return 1;
}

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
        dcmd(AddStaticVehicle, 16, cmdtext);
        dcmd(AddStaticVehicleEX, 18, cmdtext);
        dcmd(Coordonates, 11, cmdtext);
        dcmd(SaveCarPos, 10, cmdtext);
        dcmd(AddPlayerClass, 14, cmdtext);
        dcmd(AddStaticPickup, 15, cmdtext);
        dcmd(CreatePickup, 12, cmdtext);

        return 0;
}

dcmd_AddStaticVehicleEX(playerid, params[])
{
                new carid,Respawn;
        if (sscanf(params, "ss", carid,Respawn))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: \"/AddStaticVehicleEX <Carid> <Respawn Delay>\"");
                else if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else if (carid < 400)
                return SendClientMessage(playerid, 0xFF5A0FF, "Car model ids are between 400-611!!");
                else if (carid > 611)
                return SendClientMessage(playerid, 0xFF5A0FF, "Car model ids are between 400-611!!");
        else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24];
        new string[256], File:ftw = fopen("AddStaticVehicleEX.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"AddStaticVehicleEX(%s,%f,%f,%f,%f,-1,-1,%s); [By:%s]  \r\n", carid,X,Y,Z,Angle,pname,Respawn);
                SendClientMessage(playerid,0x094FFFF,"Car has been Made.");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}
dcmd_AddStaticVehicle(playerid, params[])
{
                new carid;
        if (sscanf(params, "s", carid))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: \"/AddStaticVehicle <Carid>\"");
                else if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else if (carid < 400)
                return SendClientMessage(playerid, 0xFF5A0FF, "Car model ids are between 400-611!!");
                else if (carid > 611)
                return SendClientMessage(playerid, 0xFF5A0FF, "Car model ids are between 400-611!!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24];
        new string[256], File:ftw = fopen("AddStaticVehicle.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"AddStaticVehicle(%s,%f,%f,%f,%f,-1,-1); [By:%s]  \r\n", carid,X,Y,Z,Angle,pname);
                SendClientMessage(playerid,0x094FFFF,"Car has been Made.");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

dcmd_Coordonates(playerid, params[])
{
        #pragma unused params
            if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24],interior;
        new string[256],string1[256], File:ftw = fopen("BlankCoords.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        interior=GetPlayerInterior(playerid);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string1, sizeof(string1),"Coordonates:[%f,%f,%f] Angle:[%f] Interior:[%s] has been saved ",X,Y,Z,Angle,interior);
        format(string, sizeof(string),"Coordonates:[%f,%f,%f] Angle:[%f] Interior:[%s] [By:%s]  \r\n",X,Y,Z,Angle,interior,pname);
                SendClientMessage(playerid,0x094FFFF,string1);
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

dcmd_AddPlayerClass(playerid, params[])
{
                new Skinid;
        if (sscanf(params, "s", Skinid))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: \"/AddPlayerClass <Skinid>\"");
        else if (Skinid < 0)
                return SendClientMessage(playerid, 0xFF5A0FF, "Skin ids are between 0-299!!");
                else if (Skinid > 299)
                return SendClientMessage(playerid, 0xFF5A0FF, "Skin ids are between 0-299!!");
                else if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24];
        new string[256], File:ftw = fopen("AddPlayerClass.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"AddPlayerClass(%s,%f,%f,%f,%f,0,0,0,0,0,0); [By:%s]  \r\n", Skinid,X,Y,Z,Angle,pname);
                SendClientMessage(playerid,0x094FFFF,"PlayerClass has been Made.");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

dcmd_AddStaticPickup(playerid, params[])
{
                new Pickupid,Type;
        if (sscanf(params, "ss", Pickupid,Type))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: \"/AddStaticPickup <Pickupid> <Type>\"");
                else if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24];
        new string[256], File:ftw = fopen("AddStaticPickup.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"AddStaticPickup(%s,%s,%f,%f,%f); [By:%s]  \r\n", Pickupid,Type,X,Y,Z,pname);
                SendClientMessage(playerid,0x094FFFF,"Pickup has been Made.");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

dcmd_CreatePickup(playerid, params[])
{
                new Pickupid,Type;
        if (sscanf(params, "ss", Pickupid,Type))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Usage: \"/CreatePickup <Pickupid> <Type>\"");
                else if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24];
        new string[256], File:ftw = fopen("CreatePickup.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"CreatePickup(%s,%s,%f,%f,%f); [By:%s]  \r\n", Pickupid,Type,X,Y,Z,pname);
                SendClientMessage(playerid,0x094FFFF,"Pickup has been Made.");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

dcmd_SaveCarPos(playerid, params[])
{
                #pragma unused params
                if (!IsPlayerAdmin(playerid))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not RCON admin!");
                else if (!IsPlayerInVehicle(playerid,GetPlayerVehicleID(playerid)))
                return SendClientMessage(playerid, 0xFF5A0FF, "You are not In a car!");
                else
        {
        new Float:X,Float:Y,Float:Z,Float:Angle,pname[24],carid;
        new string[256], File:ftw = fopen("SavedCarPositions.txt", io_append);
        GetPlayerPos(playerid,X,Y,Z);
                carid=GetVehicleModel(GetPlayerVehicleID(playerid));
        GetPlayerFacingAngle(playerid,Angle);
        GetPlayerName(playerid, pname, 24);
        format(string, sizeof(string),"AddStaticVehicle(%s,%f,%f,%f,%f,-1,-1); [By:%s]  \r\n", carid,X,Y,Z,Angle,pname);
                SendClientMessage(playerid,0x094FFFF,"Car has been Saved!");
                fwrite(ftw, string);
        fclose(ftw);
        return 1;
    }
}

//===================================================SSCANAF==============================================
stock sscanf(string[], format[], {Float,_}:...)
{
        new
                formatPos = 0,
                stringPos = 0,
                paramPos = 2,
                paramCount = numargs();
        while (paramPos < paramCount && string[stringPos])
        {
                switch (format[formatPos++])
                {
                        case '\0':
                        {
                                return 0;
                        }
                        case 'i', 'd':
                        {
                                new
                                        neg = 1,
                                        num = 0,
                                        ch = string[stringPos];
                                if (ch == '-')
                                {
                                        neg = -1;
                                        ch = string[++stringPos];
                                }
                                do
                                {
                                        stringPos++;
                                        if (ch >= '0' && ch <= '9')
                                        {
                                                num = (num * 10) + (ch - '0');
                                        }
                                        else
                                        {
                                                return 1;
                                        }
                                }
                                while ((ch = string[stringPos]) && ch != ' ');
                                setarg(paramPos, 0, num * neg);
                        }
                        case 'h', 'x':
                        {
                                new
                                        ch,
                                        num = 0;
                                while ((ch = string[stringPos++]))
                                {
                                        switch (ch)
                                        {
                                                case 'x', 'X':
                                                {
                                                        num = 0;
                                                        continue;
                                                }
                                                case '0' .. '9':
                                                {
                                                        num = (num << 4) | (ch - '0');
                                                }
                                                case 'a' .. 'f':
                                                {
                                                        num = (num << 4) | (ch - ('a' - 10));
                                                }
                                                case 'A' .. 'F':
                                                {
                                                        num = (num << 4) | (ch - ('A' - 10));
                                                }
                                                case ' ':
                                                {
                                                        break;
                                                }
                                                default:
                                                {
                                                        return 1;
                                                }
                                        }
                                }
                                setarg(paramPos, 0, num);
                        }
                        case 'c':
                        {
                                setarg(paramPos, 0, string[stringPos++]);
                        }
                        case 'f':
                        {
                                new tmp[25];
                                strmid(tmp, string, stringPos, stringPos+sizeof(tmp)-2);
                                setarg(paramPos, 0, _:floatstr(tmp));
                        }
                        case 's', 'z':
                        {
                                new
                                        i = 0,
                                        ch;
                                if (format[formatPos])
                                {
                                        while ((ch = string[stringPos++]) && ch != ' ')
                                        {
                                                setarg(paramPos, i++, ch);
                                        }
                                        if (!i) return 1;
                                }
                                else
                                {
                                        while ((ch = string[stringPos++]))
                                        {
                                                setarg(paramPos, i++, ch);
                                        }
                                }
                                stringPos--;
                                setarg(paramPos, i, '\0');
                        }
                        default:
                        {
                                continue;
                        }
                }
                while (string[stringPos] && string[stringPos] != ' ')
                {
                        stringPos++;
                }
                while (string[stringPos] == ' ')
                {
                        stringPos++;
                }
                paramPos++;
        }
        while (format[formatPos] == 'z') formatPos++;
        return format[formatPos];
}
//====================================================END=============================================
