/*
 *
 *  DAntiCheat Interface
 *  (c) Copyright 2006, DracoBlue (DracoBlue.com)
 *
 *  Version: 0.12
 */

#if defined _danticheat_included
	#endinput
#endif
#define _danticheat_included
#pragma library danticheat

public dac_PRIVATE_hash(buf[]) {
	new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

public DAntiCheat_SetPlayerMoney(playerid,amount) {
  new string[255];
  format(string,sizeof(string),"danticheat_money_%d",playerid);
  new string2[255];
  format(string2,sizeof(string2),"%d",amount);
  setproperty(0, "", dac_PRIVATE_hash(string), string2);
  GivePlayerMoney(playerid,amount-GetPlayerMoney(playerid));
}

public DAntiCheat_SetPlayerScore(playerid,amount) {
  new string[255];
  format(string,sizeof(string),"danticheat_score_%d",playerid);
  new string2[255];
  format(string2,sizeof(string2),"%d",amount);
  setproperty(0, "", dac_PRIVATE_hash(string), string2);
  SetPlayerScore(playerid,amount);
}

public DAntiCheat_Gamemode(name[]) {
  setproperty(0, "", dac_PRIVATE_hash("danticheat_gamemode"), name);
}

public DAntiCheat_GivePlayerMoney(playerid,amount) {
  new string[255];
  format(string,sizeof(string),"danticheat_money_%d",playerid);
  new string2[255];
  format(string2,sizeof(string2),"%d",amount+GetPlayerMoney(playerid));
  setproperty(0, "", dac_PRIVATE_hash(string), string2);
  GivePlayerMoney(playerid,amount);
}

public DAntiCheat_ResetPlayerMoney(playerid) {
  new string[255];
  format(string,sizeof(string),"danticheat_money_%d",playerid);
  new string2[255];
  format(string2,sizeof(string2),"%d",0);
  setproperty(0, "", dac_PRIVATE_hash(string2), string2);
  GivePlayerMoney(playerid,0-GetPlayerMoney(playerid));
}
