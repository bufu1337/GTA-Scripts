#define FILTERSCRIPT

#include <a_samp>
#include <dini>
#include <dudb>
#include <zcmd>
#include <sscanf2>
#include <foreach>

#define MAX_ATM 100
#define ATM_FILE_NAME       "DATM.txt"
#define MAX_DISTANCE_TO_PROP 1.5
//colours
#define COLOR_YELLOW    0xD8D8D8FF
#define COLOR_FADE1     0xE6E6E6E6
#define COLOR_FADE2     0xC8C8C8C8
#define COLOR_FADE3     0xAAAAAAAA
#define COLOR_FADE4     0x8C8C8C8C
#define COLOR_FADE5     0x6E6E6E6E
#define COLOR_FADE      0xC8C8C8C8
#define COLOR_WHITE     0xFFFFFFAA
#define COLOR_GRAD2     0xBFC0C2FF
#define COLOR_DARKRED   0x8B0000AA
#define COLOR_RED       0xFF0000AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GREY      0xAFAFAFAA
#define COLOR_PINK      0xDC00DDAA
#define COLOR_BLUE      0x0259EAAA
#define COLOR_GREEN     0x00A800AA
#define COLOR_ORANGE    0xFF8000AA
#define COLOR_CYAN      0xFF8080AA
#define COLOR_WHITE     0xFFFFFFAA
#define COLOR_DARKBLUE  0x0000A0AA
#define COLOR_BLACK     0x000000AA
#define COLOR_DARKGOLD  0x808000AA
#define COLOR_PURPLE    0xC2A2DAAA
#define COLOR_BROWN     0x804000AA
#define COLOR_BLACK2    0x000000ff
#define ATM_USER_FILE "ATMs/ATMUsers/%s.ini"
//atm system crap
new ATMObject[MAX_ATM];
new Text3D:ATMLabel[MAX_ATM];
new Object[MAX_PLAYERS];
new oModel[MAX_PLAYERS];
new ATMi,ATMm;

enum ATMInfo
{
    Float:ATMx,
    Float:ATMy,
    Float:ATMz,
    ATMInt,
    ATMvw,
    ATMMoney
}
new abInfo[MAX_ATM][ATMInfo];

enum pInfo
{
    pBank
}
new PlayerInfo[MAX_PLAYERS][pInfo];

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Blank Filterscript by your name here");
    print("--------------------------------------\n");
    //bank enter
    ServerInfo();
    CreatePickup(1318, 1, 1465.2404,-1010.2532,26.8438, -1);
    Create3DTextLabel("/enter to enter the bank.", 0x008080FF, 1465.2404,-1010.2532,26.8438, 40.0, 0, 1);
    return 1;
}

public OnPlayerConnect(playerid)
{
    new name[MAX_PLAYER_NAME], sfile[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(sfile, sizeof(sfile), ATM_USER_FILE, name);
    dini_IntSet(sfile,"Bank",PlayerInfo[playerid][pBank]);
    if (!dini_Exists(sfile)) {
        dini_Create(sfile);
        dini_IntSet(sfile, "Bank",PlayerInfo[playerid][pBank] = 5000);
        PlayerInfo[playerid][pBank] = 5000;
    }
    if(fexist(sfile)) {
        PlayerInfo[playerid][pBank] = dini_Int(sfile, "Bank");
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new name[MAX_PLAYER_NAME], sfile[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(sfile, sizeof(sfile), ATM_USER_FILE, name);
    dini_IntSet(sfile,"Bank",PlayerInfo[playerid][pBank]);
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}

AddATM(ATMid, Float:ATMxx, Float:ATMyy, Float:ATMzz, Float:ATMrxx, Float:ATMryy, Float:ATMrzz, ATMMoneyy, ATMIntt, ATMvww)
{
    new ATM[256];
    format(ATM, sizeof(ATM), "ATMs/ATMid%d",ATMid);
    if(!dini_Exists(ATM))
    {
        dini_Create(ATM);
        abInfo[ATMid][ATMMoney] = ATMMoneyy;
        dini_IntSet(ATM, "Money", ATMMoneyy);
        abInfo[ATMid][ATMInt] = ATMIntt;
        dini_IntSet(ATM, "Interior", ATMIntt);
        dini_IntSet(ATM, "Virtualworld", ATMvww);
        abInfo[ATMid][ATMvw] = ATMvww;
        abInfo[ATMid][ATMx] = ATMxx;
        abInfo[ATMid][ATMy] = ATMyy;
        abInfo[ATMid][ATMz] = ATMzz;
        dini_FloatSet(ATM, "aX", ATMxx);
        dini_FloatSet(ATM, "aY", ATMyy);
        dini_FloatSet(ATM, "aZ", ATMzz);
        dini_FloatSet(ATM, "rX", ATMrxx);
        dini_FloatSet(ATM, "rY", ATMryy);
        dini_FloatSet(ATM, "rZ", ATMrzz);
        print("-");
        print("--------------ATM Created--------------");
    }
    else
    {
        abInfo[ATMid][ATMMoney] = dini_Int(ATM, "Money");
        abInfo[ATMid][ATMInt] = dini_Int(ATM, "Interior");
        abInfo[ATMid][ATMx] = dini_Float(ATM, "aX");
        abInfo[ATMid][ATMy] = dini_Float(ATM, "aY");
        abInfo[ATMid][ATMz] = dini_Float(ATM, "aZ");
        abInfo[ATMid][ATMvw] = dini_Int(ATM, "Virtualworld");
    }
    ATMObject[ATMid] = CreateObject(2942,ATMxx, ATMyy, ATMzz,ATMrxx,ATMryy,ATMrzz,0);//bought
    new string[256];
    format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d",abInfo[ATMid][ATMMoney]);
    ATMLabel[ATMid] = Create3DTextLabel(string, 0x008080FF, ATMxx,ATMyy,ATMzz, 10.0, 0, 1);
}

//commands
COMMAND:enter(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0,1465.2404,-1010.2532,26.8438))
    {
        SetPlayerPos(playerid, 2315.952880,-1.618174,26.742187);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 1);
        SendClientMessage(playerid, COLOR_ORANGE, "Welcome to the bank, Go up to the desk and use /deposit, /withdraw and /balance.");
    }
    return 1;
}

COMMAND:exit(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 3.0,2315.952880,-1.618174,26.742187))
    {
        SetPlayerPos(playerid, 1464.6573,-1012.9962,26.8438);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
    }
    return 1;
}

COMMAND:balance(playerid, params[])
{
    new i;
    i = GetATMID(playerid);
    if(IsPlayerInRangeOfPoint(playerid, 3.0,2316.5034,-10.0475,26.7422))
    {
        new string[256];
        format(string, sizeof(string), "There is %d in your bank account.", PlayerInfo[playerid][pBank]);
        SendClientMessage(playerid, COLOR_ORANGE, string);
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 3.0,abInfo[i][ATMx],abInfo[i][ATMy],abInfo[i][ATMz]))
    {
        new string[256];
        format(string, sizeof(string), "There is %d in your bank account.", PlayerInfo[playerid][pBank]);
        SendClientMessage(playerid, COLOR_ORANGE, string);
        return 1;
    }
    else return SendClientMessage(playerid,COLOR_RED,"Not around the bank.");
}

COMMAND:deposit(playerid, params[])
{
    new amount;
    if(IsPlayerInRangeOfPoint(playerid, 3.0,2316.5034,-10.0475,26.7422))
    {
        if(!sscanf(params, "i", amount))
        {
            if(amount > 0 && amount < 100000000)
            {
                if(GetPlayerMoney(playerid) >= amount)
                {
                    PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank]+amount;
                    GivePlayerMoney(playerid,-amount);
                    return 1;
                }
                else return SendClientMessage(playerid,COLOR_RED,"You are not carrying this much money.");
            }
            else return SendClientMessage(playerid,COLOR_RED,"Invalid amount.");
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /deposit [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"Not around the bank.");
}

COMMAND:withdraw(playerid, params[])
{
    new amount;
    if(IsPlayerInRangeOfPoint(playerid, 3.0,2316.5034,-10.0475,26.7422))
    {
        if(!sscanf(params, "i", amount))
        {
            if(amount > 0 && amount < 100000000)
            {
                if(PlayerInfo[playerid][pBank] >= amount)
                {
                    PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank]-amount;
                    GivePlayerMoney(playerid,amount);
                    return 1;
                }
                else return SendClientMessage(playerid,COLOR_RED,"You don't have this much in your account.");
            }
            else return SendClientMessage(playerid,COLOR_RED,"Invalid amount.");
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /withdraw [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"Not around the bank.");
}

COMMAND:addatm(playerid, params[])
{
    new hCost;
    if(IsPlayerAdmin(playerid))
    {
        if(!sscanf(params, "i", hCost))
        {
            new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
            GetPlayerPos(playerid, OX, OY, OZ);
            oModel[playerid] = 2942;
            ATMm = hCost;
            ORX = 0.0;
            ORY = 0.0;
            ORZ = 0.0;
            Object[playerid] = CreateObject(2942, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
            SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
            EditObject(playerid, Object[playerid]);
            return 1;
        }
        else return SendClientMessage(playerid, COLOR_RED, "USAGE: /addatm [amount of money]");
    }
    else return SendClientMessage(playerid, COLOR_RED, "You do not have the rights to use this command.");
}

COMMAND:setatmcash(playerid, params[])
{
    new amount;
    new atid;
    new Biz[128];
    new string[256];
    if(IsPlayerAdmin(playerid))
    {
        if(!sscanf(params, "ii", atid, amount))
        {
            format(Biz, sizeof(Biz), "ATMs/ATMid%d",atid);
            abInfo[atid][ATMMoney] = amount;
            dini_IntSet(Biz, "Money", abInfo[atid][ATMMoney]);
            Delete3DTextLabel(ATMLabel[atid]);
            format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d",abInfo[atid][ATMMoney]);
            ATMLabel[atid] = Create3DTextLabel(string, 0x008080FF, abInfo[atid][ATMx],abInfo[atid][ATMy],abInfo[atid][ATMz], 10.0, 0, 1);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /setatmcash [atmid] [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
}

COMMAND:getatmid(playerid, params[])
{
    new string[256];
    new i;
    i = GetATMID(playerid);
    if(IsPlayerAdmin(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0,abInfo[i][ATMx],abInfo[i][ATMy],abInfo[i][ATMz]))
        {
            format(string, sizeof(string), "ATM ID %d",i);
            SendClientMessage(playerid,COLOR_ORANGE,string);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"You are not around any cash machines.");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
}

COMMAND:atmwithdraw(playerid, params[])
{
    new amount;
    new Biz[128];
    new string[256];
    new i;
    i = GetATMID(playerid);
    if(!sscanf(params, "i", amount))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0,abInfo[i][ATMx],abInfo[i][ATMy],abInfo[i][ATMz]))
        {
            if(amount <= abInfo[i][ATMMoney] && amount > 0)
            {
                if(amount <= PlayerInfo[playerid][pBank] && amount > 0)
                {
                    format(Biz, sizeof(Biz), "ATMs/ATMid%d",i);
                    PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank]-amount;
                    GivePlayerMoney(playerid,amount);
                    abInfo[i][ATMMoney] = abInfo[i][ATMMoney]-amount;
                    dini_IntSet(Biz, "Money", abInfo[i][ATMMoney]);
                    Delete3DTextLabel(ATMLabel[i]);
                    format(string, sizeof(string), "ATM type /atmwithdraw and /balance.\nMoney left $%d",abInfo[i][ATMMoney]);
                    ATMLabel[i] = Create3DTextLabel(string, 0x008080FF, abInfo[i][ATMx],abInfo[i][ATMy],abInfo[i][ATMz], 10.0, 0, 1);
                    return 1;
                }
                else return SendClientMessage(playerid,COLOR_RED,"You don't have that much money in your bank account.");
            }
            else return SendClientMessage(playerid,COLOR_RED,"This cash machine doesn't have that much cash in.");
        }
        else return SendClientMessage(playerid,COLOR_RED,"You are not around any cash machines.");
    }
    else return SendClientMessage(playerid,COLOR_RED,"USAGE: /atmwithdraw [amount]");
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:oldX, Float:oldY, Float:oldZ,
        Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetObjectPos(objectid, oldX, oldY, oldZ);
    GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ,OVW,OINT;
    if(!playerobject) // If this is a global object, move it for other players
    {
        if(!IsValidObject(objectid)) return;
        MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
    }

    if(response == EDIT_RESPONSE_FINAL)
    {
        if(oModel[playerid] == 2942)
        {
            OVW = GetPlayerVirtualWorld(playerid);
            OINT = GetPlayerInterior(playerid);
            GetObjectPos(objectid, OX, OY, OZ);
            GetObjectRot(objectid, ORX, ORY, ORZ);
            ATMObject[ATMi] = CreateObject(2942,OX, OY, OZ,ORX,ORY,ORZ,0);
            AddATMToFile(ATM_FILE_NAME, Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OINT, ATMm, OVW);
            AddATM(ATMi, OX, OY, OZ, ORX, ORY, ORZ, ATMm, OINT, OVW);
            new string[256];
            format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d",abInfo[ATMi][ATMMoney]);
            ATMLabel[ATMi] = Create3DTextLabel(string, 0x008080FF, OX,OY,OZ, 10.0, 0, 1);
            ATMi = ATMi+1;
            new ATM[256];
            format(ATM, sizeof(ATM), "Server/atm/atminfo");
            dini_IntSet(ATM, "ATMs", ATMi);
            DestroyObject(Object[playerid]);
        }
    }

    if(response == EDIT_RESPONSE_CANCEL)
    {
        //The player cancelled, so put the object back to it's old position
        if(!playerobject) //Object is not a playerobject
        {
            SetObjectPos(objectid, oldX, oldY, oldZ);
            SetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
            DestroyObject(Object[playerid]);
        }
        else
        {
            SetPlayerObjectPos(playerid, objectid, oldX, oldY, oldZ);
            SetPlayerObjectRot(playerid, objectid, oldRotX, oldRotY, oldRotZ);
            DestroyObject(Object[playerid]);
        }
    }
}

stock GetATMID(playerid)
{
    for(new i=0; i<MAX_ATM; i++)
    {
        if(PlayerToPoint(MAX_DISTANCE_TO_PROP, playerid, abInfo[i][ATMx],abInfo[i][ATMy],abInfo[i][ATMz]))
        {
            return i;
        }
    }
    return 1;
}

stock AddATMToFile(DFileName[], Float:AX, Float:AY, Float:AZ, Float:ARX, Float:ARY, Float:ARZ, AINT, AMoney, AVW)
{
    new File:HouseFile, Line[128];
    format(Line, sizeof(Line), "AddATM(%i, %f, %f, %f, %f, %f, %f, %i, %i, %i);\r\n", ATMi, AX, AY, AZ, ARX, ARY, ARZ, AMoney, AINT, AVW);
    HouseFile = fopen(DFileName, io_append);
    fwrite(HouseFile, Line);
    fclose(HouseFile);
    return 1;
}

ServerInfo()
{
    new atm[256];
    format(atm, sizeof(atm), "Server/atm/atminfo");
    if(!dini_Exists(atm))
    {
        dini_Create(atm);
        ATMi = 0;
        dini_IntSet(atm, "ATMs", 0);
    }
    else
    {
        ATMi = dini_Int(atm, "ATMs");
    }
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        tempposx = (oldposx -x);
        tempposy = (oldposy -y);
        tempposz = (oldposz -z);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
        {
            return 1;
        }
    }
    return 0;
}

#endif