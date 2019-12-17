/*x---------------------------------Important-------------------------------------x*/
//**INCLUDES**//
#include <a_samp>
/*x---------------------------------Defining-------------------------------------x*/
//**COLORS**//
#define GREEN 0x21DD00FF
#define RED 0xE60000FF
#define ADMIN_RED 0xFB0000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define LIGHTRED 0xFF8080FF
#define LIGHTBLUE 0x00C2ECFF
#define PURPLE 0xB360FDFF
#define PLAYER_COLOR 0xFFFFFFFF
#define BLUE 0x1229FAFF
#define LIGHTGREEN 0x38FF06FF
#define DARKPINK 0xE100E1FF
#define DARKGREEN 0x008040FF
#define ANNOUNCEMENT 0x6AF7E1FF
#define COLOR_SYSTEM 0xEFEFF7AA
#define GRAY 0xCECECEFF
//**MISC**//
#define WEAPAMMO 500 // Weapon Ammo when the weapon is selected.
#undef KEY_LEFT
#define KEY_LEFT 65408
//**VARIABLES**//
new Weap;
new Weapons[200];
new WeaponSelecting[45][0] = {
{321},
{322},
{323},
{324},
{325},
{326},
{330},
{331},
{333},
{334},
{335},
{336},
{337},
{338},
{339},
{341},
{342},
{343},
{344},
{346},
{347},
{348},
{349},
{350},
{351},
{352},
{353},
{354},
{355},
{356},
{357},
{358},
{359},
{360},
{361},
{362},
{363},
{364},
{365},
{366},
{367},
{368},
{369},
{371},
{372}
};
new AllWeapons[45][0] = {
{10},
{11},
{12},
{13},
{14},
{15},
{0},
{1},
{2},
{3},
{4},
{5},
{6},
{7},
{8},
{9},
{16},
{17},
{18},
{22},
{23},
{24},
{25},
{26},
{27},
{28},
{29},
{0},
{30},
{31},
{33},
{34},
{35},
{36},
{37},
{38},
{39},
{40},
{41},
{42},
{43},
{44},
{45},
{46},
{32}
};
//**FORWARDS**//
forward WeaponSelection(playerid);
/*x---------------------------------CallBacks-------------------------------------x*/
public OnFilterScriptInit()
{
        print("[FS]|-----------------------------------------|[FS]");
        print("[FS]|  .:[ - Weapon Menu Script by Seif - ]:. |[FS]");
        print("[FS]|-----------------------------------------|[FS]");
        return 1;
}

public OnFilterScriptExit()
{
        print("[FS]|---------------[UNLOADED]----------------|[FS]");
        print("[FS]|  .:[ - Weapon Menu Script by Seif - ]:. |[FS]");
        print("[FS]|---------------[UNLOADED]----------------|[FS]");
        DestroyPickup(Weap);
        return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
        if (strcmp("/weapons", cmdtext, true, 10) == 0)
        {
            new string[256],weapname[50];
        SetPlayerCameraPos(playerid,2238,1090,40);
        SetPlayerCameraLookAt(playerid,2233,1090,40);
        TogglePlayerControllable(playerid,0);
        Weapons[playerid] = 1;
        Weap = CreatePickup(WeaponSelecting[0][0],23,2233,1090,40);
        GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                GameTextForPlayer(playerid,string,3000,3);
        SetTimerEx("WeaponSelection",100,1,"i",playerid);
            return 1;
        }
        return 0;
}

public WeaponSelection()
{
        for (new playerid=0;playerid<200;playerid++)
        {
        new keys, updown, leftright,weapname[50],string[128];
        GetPlayerKeys(playerid,keys,updown,leftright);
        switch (Weapons[playerid])
        {
                case 1:
                {
                        if (leftright & 128)
                        {
                            DestroyPickup(Weap);
                                Weap = CreatePickup(WeaponSelecting[1][0],23,2233,1090,40);
                                Weapons[playerid] = 2;
                                GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(leftright & 65408)
                        {
                            DestroyPickup(Weap);
                            Weap = CreatePickup(WeaponSelecting[44][0],23,2233,1090,40);
                            Weapons[playerid] = 44;
                            GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(keys & 16)
                        {
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                        else if(keys & 32)
                        {
                            GivePlayerWeapon(playerid,AllWeapons[Weapons[playerid]][0],WEAPAMMO);
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                }
                case 2..43:
                {
                        if (leftright & 128)
                        {
                            DestroyPickup(Weap);
                                Weap = CreatePickup(WeaponSelecting[Weapons[playerid]+1][0],23,2233,1090,40);
                                Weapons[playerid]++;
                                GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(leftright & 65408)
                        {
                            DestroyPickup(Weap);
                            Weap = CreatePickup(WeaponSelecting[Weapons[playerid]-1][0],23,2233,1090,40);
                            Weapons[playerid]--;
                            GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(keys & 16)
                        {
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                        else if(keys & 32)
                        {
                            GivePlayerWeapon(playerid,AllWeapons[Weapons[playerid]][0],WEAPAMMO);
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                }
                case 44:
                {
                        if (leftright & 128)
                        {
                            DestroyPickup(Weap);
                                Weap = CreatePickup(WeaponSelecting[0][0],23,2233,1090,40);
                                Weapons[playerid] = 1;
                                GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(leftright & 65408)
                        {
                            DestroyPickup(0);
                            Weap = CreatePickup(WeaponSelecting[43][0],23,2233,1090,40);
                            Weapons[playerid] = 43;
                            GetWeaponName(AllWeapons[Weapons[playerid]][0],weapname,50);
                                format(string,128,"~n~~n~~n~~n~~n~~n~~n~~n~~g~~h~%s",weapname);
                                GameTextForPlayer(playerid,string,3000,3);
                        }
                        else if(keys & 16)
                        {
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                        else if(keys & 32)
                        {
                            GivePlayerWeapon(playerid,AllWeapons[Weapons[playerid]][0],WEAPAMMO);
                            Weapons[playerid] = 0;
                            DestroyPickup(Weap);
                            SetCameraBehindPlayer(playerid);
                            TogglePlayerControllable(playerid,1);
                        }
                }
        }
        }
        return 1;
}
