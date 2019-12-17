#include <a_samp>
#include <zcmd>
#include <Dini>
#include <dudb>
#include <foreach>
#include <sscanf2>
#include <streamer>

//ATM Crap
#define MAX_ATM 100
#define MAX_BANK 100
#define MAX_DISTANCE_TO_PROP 1.5
new ATMObject[MAX_ATM];
new Text3D:ATMLabel[MAX_ATM];
new Object[MAX_PLAYERS];
new oModel[MAX_PLAYERS];
new ATMi;
new ATMm[MAX_PLAYERS];
new atms;
new Banks;
new BankObject[MAX_ATM];
new Text3D:BankLabel[MAX_ATM];

enum abInfo
{
    Float:ATMx,
    Float:ATMy,
    Float:ATMz,
    Float:ATMrx,
    Float:ATMry,
    Float:ATMrz,
    ATMint,
    ATMvw,
    ATMMoney
}
new ATMInfo[MAX_ATM][abInfo];

enum bInfo
{
    Float:Bankx,
    Float:Banky,
    Float:Bankz,
    Float:Bankrx,
    Float:Bankry,
    Float:Bankrz,
    Bankint,
    Bankvw,
    BankMoney
}
new BankInfo[MAX_BANK][bInfo];

enum pInfo
{
    pBank,
    playerenterbankid
}
new PlayerInfo[MAX_PLAYERS][pInfo];
#define ATM_USER_FILE "ATMs/ATMUsers/%s.ini"
//COLOR DEFINES
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
#define COL_EASY           "{FFF1AF}"
#define COL_WHITE          "{FFFFFF}"
#define COL_BLACK          "{0E0101}"
#define COL_GREY           "{C3C3C3}"
#define COL_GREEN          "{6EF83C}"
#define COL_RED            "{F81414}"
#define COL_YELLOW         "{F3FF02}"
#define COL_ORANGE         "{FFAF00}"
#define COL_LIME           "{B7FF00}"
#define COL_CYAN           "{00FFEE}"
#define COL_LIGHTBLUE      "{00C0FF}"
#define COL_BLUE           "{0049FF}"
#define COL_MAGENTA        "{F300FF}"
#define COL_VIOLET         "{B700FF}"
#define COL_PINK           "{FF00EA}"
#define COL_MARONE         "{A90202}"
#define COL_CMD            "{B8FF02}"
#define COL_PARAM          "{3FCD02}"
#define COL_SERVER         "{AFE7FF}"
#define COL_VALUE          "{A3E4FF}"
#define COL_RULE           "{F9E8B7}"
#define COL_RULE2          "{FBDF89}"
#define COL_RWHITE         "{FFFFFF}"
#define COL_LGREEN         "{C9FFAB}"
#define COL_LRED           "{FFA1A1}"
#define COL_LRED2          "{C77D87}"

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Jueixs bank system loaded");
    print("--------------------------------------\n");
    LoadATMs();
    LoadBanks();
    return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
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
            new ATMid = GetATMs();
            new ATM[256];
            format(ATM, sizeof(ATM), "ATMs/%i.ini",ATMid);
            OVW = GetPlayerVirtualWorld(playerid);
            OINT = GetPlayerInterior(playerid);
            GetObjectPos(objectid, OX, OY, OZ);
            GetObjectRot(objectid, ORX, ORY, ORZ);
            ATMInfo[ATMid][ATMMoney] = ATMm[playerid];
            dini_Create(ATM);
            dini_IntSet(ATM, "Money", ATMInfo[ATMid][ATMMoney]);
            dini_IntSet(ATM, "INT", OINT);
            dini_IntSet(ATM, "VW", OVW);
            dini_FloatSet(ATM, "ATMX", OX);
            dini_FloatSet(ATM, "ATMY", OY);
            dini_FloatSet(ATM, "ATMZ", OZ);
            dini_FloatSet(ATM, "ATMRX", ORX);
            dini_FloatSet(ATM, "ATMRY", ORY);
            dini_FloatSet(ATM, "ATMRZ", ORZ);
            DestroyObject(Object[playerid]);
            ATMObject[ATMid] = CreateObject(2942, OX, OY, OZ, ORX, ORY, ORZ);
            new string[256];
            format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d\nID[%d]",ATMInfo[ATMid][ATMMoney],ATMid);
            ATMLabel[ATMid] = Create3DTextLabel(string, 0x008080FF, OX, OY, OZ, 10.0, 0, 1);
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

public OnPlayerConnect(playerid)
{
    new name[MAX_PLAYER_NAME], userfile[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(userfile, sizeof(userfile), ATM_USER_FILE, name);
    if (!dini_Exists(userfile)) {
        dini_Create(userfile);
        PlayerInfo[playerid][pBank] = 5000;
        SaveStats(playerid);
    }
    if(fexist(userfile)) {
        LoadStats(playerid);
    }
    return 1;
}

public OnFilterScriptExit()
{
    return 1;
}

//ATM Loading
stock LoadATMs()
{
    new file[60];
    for(new i = 0; i < MAX_ATM;i++)
    {
        format(file,sizeof(file),"ATMs/%i.ini",i);
        if(!dini_Exists(file)) continue;
        ATMInfo[i][ATMx] = dini_Float(file, "ATMX");
        ATMInfo[i][ATMy] = dini_Float(file, "ATMY");
        ATMInfo[i][ATMz] = dini_Float(file, "ATMZ");
        ATMInfo[i][ATMrx] = dini_Float(file, "ATMRX");
        ATMInfo[i][ATMry] = dini_Float(file, "ATMRY");
        ATMInfo[i][ATMrz] = dini_Float(file, "ATMRZ");
        ATMInfo[i][ATMvw] = dini_Int(file, "VW");
        ATMInfo[i][ATMint] = dini_Int(file, "INT");
        ATMInfo[i][ATMMoney] = dini_Int(file, "Money");
        ATMObject[i] = CreateObject(2942, ATMInfo[i][ATMx], ATMInfo[i][ATMy], ATMInfo[i][ATMz], ATMInfo[i][ATMrx], ATMInfo[i][ATMry], ATMInfo[i][ATMrz]);
        new string[256];
        format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d",ATMInfo[i][ATMMoney]);
        ATMLabel[i] = Create3DTextLabel(string, 0x008080FF, ATMInfo[i][ATMx], ATMInfo[i][ATMy], ATMInfo[i][ATMz], 10.0, 0, 1);
        atms++;
    }
    
    printf("ATMs Created!");
    return 1;
}

stock LoadBanks()
{
    new file[60];
    for(new i = 0; i < MAX_BANK;i++)
    {
        format(file,sizeof(file),"Banks/%i.ini",i);
        if(!dini_Exists(file)) continue;
        BankInfo[i][Bankx] = dini_Float(file, "BankX");
        BankInfo[i][Banky] = dini_Float(file, "BankY");
        BankInfo[i][Bankz] = dini_Float(file, "BankZ");
        BankInfo[i][Bankrx] = dini_Float(file, "BankRX");
        BankInfo[i][Bankry] = dini_Float(file, "BankRY");
        BankInfo[i][Bankrz] = dini_Float(file, "BankRZ");
        BankInfo[i][Bankvw] = dini_Int(file, "VW");
        BankInfo[i][Bankint] = dini_Int(file, "INT");
        BankInfo[i][BankMoney] = dini_Int(file, "Money");
        BankObject[i] = CreatePickup(1318, 1, BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz], -1);
        new string[256];
        format(string, sizeof(string), "/enter to enter the bank.\nMoney left in this banks vault $%d.",BankInfo[i][BankMoney]);
        BankLabel[i] = Create3DTextLabel(string, 0x008080FF, BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz], 10.0, 0, 1);
        Banks++;
    }

    printf("Banks Created!");
    return 1;
}

stock GetATMs()
{
    new file[60];
    for(new i = 0; i < MAX_ATM;i++)
    {
        format(file,sizeof(file),"ATMs/%i.ini",i);
        if(!dini_Exists(file)) return i;
    }
    return -1;
}

stock GetBanks()
{
    new file[60];
    for(new i = 0; i < MAX_BANK;i++)
    {
        format(file,sizeof(file),"Banks/%i.ini",i);
        if(!dini_Exists(file)) return i;
    }
    return -1;
}

stock GetATMID(playerid)
{
    for(new i=0; i<MAX_ATM; i++)
    {
        if(PlayerToPoint(MAX_DISTANCE_TO_PROP, playerid, ATMInfo[i][ATMx],ATMInfo[i][ATMy],ATMInfo[i][ATMz]))
        {
            return i;
        }
    }
    return 1;
}

stock GetBankID(playerid)
{
    for(new i=0; i<MAX_BANK; i++)
    {
        if(PlayerToPoint(MAX_DISTANCE_TO_PROP, playerid, BankInfo[i][Bankx],BankInfo[i][Banky],BankInfo[i][Bankz]))
        {
            return i;
        }
    }
    return 1;
}

stock RandomEx(min, max) //Y_Less
{
    return random(max - min) + min;
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
            ATMm[playerid] = hCost;
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

COMMAND:addbank(playerid, params[])
{
    new hCost;
    if(IsPlayerAdmin(playerid))
    {
        if(!sscanf(params, "i", hCost))
        {
            new i = GetBanks();
            GetPlayerPos(playerid, BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz]);
            BankInfo[i][Bankrx] = 2305.8408;
            BankInfo[i][Bankry] = -16.4474;
            BankInfo[i][Bankrz] = 26.7496;
            BankInfo[i][Bankint] = 0;
            BankInfo[i][Bankvw] = i;
            BankInfo[i][BankMoney] = hCost;
            new Bank[256];
            format(Bank, sizeof(Bank), "Banks/%i.ini",i);
            dini_Create(Bank);
            dini_IntSet(Bank, "Money", BankInfo[i][BankMoney]);
            dini_IntSet(Bank, "INT", BankInfo[i][Bankint]);
            dini_IntSet(Bank, "VW", BankInfo[i][Bankvw]);
            dini_FloatSet(Bank, "BankX", BankInfo[i][Bankx]);
            dini_FloatSet(Bank, "BankY", BankInfo[i][Banky]);
            dini_FloatSet(Bank, "BankZ", BankInfo[i][Bankz]);
            dini_FloatSet(Bank, "BankRX", BankInfo[i][Bankrx]);
            dini_FloatSet(Bank, "BankRY", BankInfo[i][Bankry]);
            dini_FloatSet(Bank, "BankRZ", BankInfo[i][Bankrz]);
            BankObject[i] = CreatePickup(1318, 1, BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz], -1);
            new string[256];
            format(string, sizeof(string), "/enter to enter the bank.\nMoney left in this banks vault $%d.",BankInfo[i][BankMoney]);
            BankLabel[i] = Create3DTextLabel(string, 0x008080FF, BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz], 10.0, 0, 1);
            SendClientMessage(playerid, 0xD8D8D8FF, "Bank created");
            return 1;
        }
        else return SendClientMessage(playerid, COLOR_RED, "USAGE: /addbank [amount of money]");
    }
    else return SendClientMessage(playerid, COLOR_RED, "You do not have the rights to use this command.");
}

COMMAND:enter(playerid, params[])
{
    new i = GetBankID(playerid);
    if(IsPlayerInRangeOfPoint(playerid, 3,BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz]))
    {
        SetPlayerPos(playerid,BankInfo[i][Bankrx], BankInfo[i][Bankry], BankInfo[i][Bankrz]);
        SetPlayerVirtualWorld(playerid,BankInfo[i][Bankvw]);
        SetPlayerInterior(playerid,BankInfo[i][Bankint]);
        PlayerInfo[playerid][playerenterbankid] = i;
        return 1;
    }
    else return SendClientMessage(playerid, COLOR_RED, "You are not near anywhere you can enter.");
}

COMMAND:exit(playerid, params[])
{
    new i = PlayerInfo[playerid][playerenterbankid];
    if(IsPlayerInRangeOfPoint(playerid, 3,2305.8408,-16.4474,26.7496))
    {
        SetPlayerPos(playerid,BankInfo[i][Bankx], BankInfo[i][Banky], BankInfo[i][Bankz]);
        SetPlayerVirtualWorld(playerid,0);
        SetPlayerInterior(playerid,0);
        return 1;
    }
    else return SendClientMessage(playerid, COLOR_RED, "You are not near anywhere you can enter.");
}

COMMAND:removeatm(playerid, params[])
{
    if(IsPlayerAdmin(playerid))
    {
        new i;
        if(!sscanf(params, "i", i))
        {
            new file[256];
            format(file,sizeof(file),"ATMs/%i.ini",i);
            dini_Remove(file);
            DestroyObject(ATMObject[i]);
            Delete3DTextLabel(ATMLabel[i]);
            SendClientMessage(playerid, COLOR_ORANGE, "ATM removed.");
            return 1;
        }
        else return SendClientMessage(playerid, COLOR_RED, "You do not have the rights to use this command.");
    }
    else return SendClientMessage(playerid, COLOR_RED, "Usage: /removeatm [atmid].");
}

COMMAND:removebank(playerid, params[])
{
    if(IsPlayerAdmin(playerid))
    {
        new i;
        if(!sscanf(params, "i", i))
        {
            new file[256];
            format(file,sizeof(file),"Banks/%i.ini",i);
            dini_Remove(file);
            DestroyObject(BankObject[i]);
            Delete3DTextLabel(BankLabel[i]);
            SendClientMessage(playerid, COLOR_ORANGE, "Bank removed.");
            return 1;
        }
        else return SendClientMessage(playerid, COLOR_RED, "You do not have the rights to use this command.");
    }
    else return SendClientMessage(playerid, COLOR_RED, "Usage: /removeBank [Bankid].");
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
            format(Biz, sizeof(Biz), "ATMs/%i.ini",atid);
            ATMInfo[atid][ATMMoney] = amount;
            dini_IntSet(Biz, "Money", ATMInfo[atid][ATMMoney]);
            Delete3DTextLabel(ATMLabel[atid]);
            format(string, sizeof(string), "ATM type /atmwithdraw and /atmbalance.\nMoney left $%d",ATMInfo[atid][ATMMoney]);
            ATMLabel[atid] = Create3DTextLabel(string, 0x008080FF, ATMInfo[atid][ATMx],ATMInfo[atid][ATMy],ATMInfo[atid][ATMz], 10.0, 0, 1);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /setatmcash [atmid] [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
}

COMMAND:setbankcash(playerid, params[])
{
    new amount;
    new atid;
    new Biz[128];
    new string[256];
    if(IsPlayerAdmin(playerid))
    {
        if(!sscanf(params, "ii", atid, amount))
        {
            format(Biz, sizeof(Biz), "Banks/%i.ini",atid);
            BankInfo[atid][BankMoney] = amount;
            dini_IntSet(Biz, "Money", BankInfo[atid][BankMoney]);
            Delete3DTextLabel(BankLabel[atid]);
            format(string, sizeof(string), "Bank type /Bankwithdraw and /Bankbalance.\nMoney left $%d",BankInfo[atid][BankMoney]);
            BankLabel[atid] = Create3DTextLabel(string, 0x008080FF, BankInfo[atid][Bankx],BankInfo[atid][Banky],BankInfo[atid][Bankz], 10.0, 0, 1);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /setBankcash [Bankid] [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
}

COMMAND:juesbank(playerid, params[])
{
    if(IsPlayerAdmin(playerid))
    {
        SendClientMessage(playerid,COLOR_ORANGE,"/addatm /addbank /getatmid /getbankid /setatmcash /setbankcash /withdraw!");
        SendClientMessage(playerid,COLOR_ORANGE,"/removeatm /removebank /deposit /atmwithdraw!");
        return 1;
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
        if(IsPlayerInRangeOfPoint(playerid, 3.0,ATMInfo[i][ATMx],ATMInfo[i][ATMy],ATMInfo[i][ATMz]))
        {
            if(amount <= ATMInfo[i][ATMMoney] && amount > 0)
            {
                if(amount <= PlayerInfo[playerid][pBank] && amount > 0)
                {
                    format(Biz, sizeof(Biz), "ATMs/ATMid%d",i);
                    PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank]-amount;
                    GivePlayerMoney(playerid,amount);
                    ATMInfo[i][ATMMoney] = ATMInfo[i][ATMMoney]-amount;
                    dini_IntSet(Biz, "Money", ATMInfo[i][ATMMoney]);
                    Delete3DTextLabel(ATMLabel[i]);
                    format(string, sizeof(string), "ATM type /atmwithdraw and /balance.\nMoney left $%d",ATMInfo[i][ATMMoney]);
                    ATMLabel[i] = Create3DTextLabel(string, 0x008080FF, ATMInfo[i][ATMx],ATMInfo[i][ATMy],ATMInfo[i][ATMz], 10.0, 0, 1);
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

COMMAND:getatmid(playerid, params[])
{
    new string[256];
    new i;
    i = GetATMID(playerid);
    if(IsPlayerAdmin(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0,ATMInfo[i][ATMx],ATMInfo[i][ATMy],ATMInfo[i][ATMz]))
        {
            format(string, sizeof(string), "ATM ID %d",i);
            SendClientMessage(playerid,COLOR_ORANGE,string);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"You are not around any cash machines.");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
}

COMMAND:getbankid(playerid, params[])
{
    new string[256];
    new i;
    i = GetBankID(playerid);
    if(IsPlayerAdmin(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0,BankInfo[i][Bankx],BankInfo[i][Banky],BankInfo[i][Bankz]))
        {
            format(string, sizeof(string), "Bank ID %d",i);
            SendClientMessage(playerid,COLOR_ORANGE,string);
            return 1;
        }
        else return SendClientMessage(playerid,COLOR_RED,"You are not around any cash machines.");
    }
    else return SendClientMessage(playerid,COLOR_RED,"You can not use this command!");
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
                    SaveStats(playerid);
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

COMMAND:deposit(playerid, params[])
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
                    PlayerInfo[playerid][pBank] = PlayerInfo[playerid][pBank]+amount;
                    GivePlayerMoney(playerid,-amount);
                    SaveStats(playerid);
                    return 1;
                }
                else return SendClientMessage(playerid,COLOR_RED,"You don't have this much in your wallet.");
            }
            else return SendClientMessage(playerid,COLOR_RED,"Invalid amount.");
        }
        else return SendClientMessage(playerid,COLOR_RED,"USAGE: /deposit [amount]");
    }
    else return SendClientMessage(playerid,COLOR_RED,"Not around the bank.");
}

SaveStats(playerid)
{
    new name[MAX_PLAYER_NAME], file[256];
    GetPlayerName(playerid, name, sizeof(name));
    format(file, sizeof(file), ATM_USER_FILE, name);
    dini_IntSet(file, "Bank", PlayerInfo[playerid][pBank]);
}

LoadStats(playerid)
{
  new name[MAX_PLAYER_NAME], userfile[256];
  GetPlayerName(playerid, name, sizeof(name));
  format(userfile, sizeof(userfile), ATM_USER_FILE, name);
  PlayerInfo[playerid][pBank] = dini_Int(userfile, "Bank");
}