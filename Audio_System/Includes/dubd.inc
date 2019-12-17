/*
 *            DUDB 1.2
 *       (c) Copyright 2006 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 8th May 2006
 * @update    : 31st July 2006
 * @require   : DUtils 1.3
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in 
 * about box is honouring thing, isn't it?
 *
 * Versão especial para uso do Texugo
 *
 * SA:MP 0.2.2 Ready Version
 */

#if defined _dudb_included
  #endinput
#endif

#define _dudb_included
#pragma library dutils

#include <a_samp>
#include <dutils>
//---Forwards---//
forward udb_hash(buf[]);
forward udb_Exists(nickname[]);
forward udb_Remove(nickname[]);
forward udp_PRIVATE_clearbroken(nicknameenc[]);
forward udb_Save(nickname[], pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[], Float:X, Float:Y, Float:Z, Float:ang, Float:health);
forward udb_Load(nickname[], &pwd_hash, &acc_state, &skin, &bank_money, &gasoline, &habaerea, &habterre, &habnauti, &prisao, &prof, clantag[], &Float:X, &Float:Y, &Float:Z, &Float:ang, &Float:health);
forward udb_getPwdHash(nickname[]);
forward udb_getAccState(nickname[]);
forward udb_getPosition(nickname[], &Float:X, &Float:Y, &Float:Z);
forward udb_getAng(nickname[], &Float:ang);
forward udb_getSkin(nickname[]);
forward udb_getBankMoney(nickname[]);
forward udb_getHealth(nickname[], &Float:health);
forward udb_getGasoline(nickname[]);
forward udb_getHabaerea(nickname[]);
forward udb_gethabterre(nickname[]);
forward udb_getHabnauti(nickname[]);
forward udb_getPrisao(nickname[]);
forward udb_getProf(nickname[]);
forward udb_setClantag(nickname[], new_clantag[]);
forward udb_setPwdHash(nickname[], new_pwdhash);
forward udb_setAccState(nickname[], new_accstate);
forward udb_setPosition(nickname[], Float:new_x, Float:new_y, Float:new_z);
forward udb_setAng(nickname[], Float:new_ang);
forward udb_setSkin(nickname[], new_skin);
forward udb_setBankMoney(nickname[], new_bankmoney);
forward udb_setHealth(nickname[], Float:new_health);
forward udb_setGasoline(nickname[], new_gasoline);
forward udb_setHabaerea(nickname[], new_habaerea);
forward udb_setHablv(nickname[], new_hablv);
forward udb_setHabls(nickname[], new_habls);
forward udb_setHabterre(nickname[], new_habterre);
forward udb_setHabnauti(nickname[], new_habnauti);
forward udb_setPrisao(nickname[], new_prisao);
forward udb_setProf(nickname[], new_prof);
forward udb_CheckLogin(nickname[], pwd[]);
forward udb_setPassword(nickname[], pwd[]);
forward udb_Create(nickname[], pwd[], acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[], Float:X, Float:Y, Float:Z, Float:ang, Float:health);
//--------------//
public udb_hash(buf[]) {
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

stock udb_encode(nickname[]) {
  new tmp[MAX_STRING];
  set(tmp,nickname);
  tmp=strreplace("/"," 03",tmp);
  tmp=strreplace("\\"," 04",tmp);
  tmp=strreplace("?"," 07",tmp);
  tmp=strreplace("*"," 09",tmp);
  tmp=strreplace("<"," 10",tmp);
  tmp=strreplace(">"," 11",tmp);
  tmp=strreplace(":"," 14",tmp);
  tmp=strreplace("|"," 15",tmp);
  return tmp;
}

stock udb_decode(nickname[]) {
  new tmp[MAX_STRING];
  set(tmp,nickname);
  tmp=strreplace(" 03","/",tmp);
  tmp=strreplace(" 04","\\",tmp);
  tmp=strreplace(" 07","?",tmp);
  tmp=strreplace(" 09","*",tmp);
  tmp=strreplace(" 10","<",tmp);
  tmp=strreplace(" 11",">",tmp);
  tmp=strreplace(" 14",":",tmp);
  tmp=strreplace(" 15","|",tmp);
  return tmp;
}


public udb_Exists(nickname[]) {
  new tmp[MAX_STRING];
  new tmp2[MAX_STRING];
  set(tmp2,udb_encode(nickname));
  set(tmp,tmp2);
  strcat(tmp,".1.player");
  if (fexist(tmp)) return true;
  set(tmp,tmp2);
  strcat(tmp,".2.player");
  if (fexist(tmp)) return true;
  set(tmp,tmp2);
  strcat(tmp,".3.player");
  if (fexist(tmp)) return true;
  return false;
}


public udb_Remove(nickname[]) {
  new tmp[MAX_STRING];
  new tmp2[MAX_STRING];
  if (!udb_Exists(nickname)) return false;
  set(tmp2,udb_encode(nickname));
  set(tmp,tmp2);
  strcat(tmp,".1.player");
  fremove(tmp);
  set(tmp,tmp2);
  strcat(tmp,".2.player");
  fremove(tmp);
  set(tmp,tmp2);
  strcat(tmp,".3.player");
  fremove(tmp);
  return true;
}

public udp_PRIVATE_clearbroken(nicknameenc[]) {
  new tmp2[MAX_STRING];
  new tmp_a[MAX_STRING];
  new tmp_b[MAX_STRING];

  set(tmp2,nicknameenc);
  set(tmp_a,tmp2);strcat(tmp_a,".1.player");
  set(tmp_b,tmp2);strcat(tmp_b,".2.player");
  if ((fexist(tmp_a))&&(fexist(tmp_b))) {
	 fremove(tmp_b);
  } else {
    set(tmp_a,tmp2);strcat(tmp_a,".2.player");
    set(tmp_b,tmp2);strcat(tmp_b,".3.player");
    if ((fexist(tmp_a))&&(fexist(tmp_b))) {
  	   fremove(tmp_b);
    } else {
       set(tmp_a,tmp2);strcat(tmp_a,".3.player");
       set(tmp_b,tmp2);strcat(tmp_b,".1.player");
       if ((fexist(tmp_a))&&(fexist(tmp_b))) {
         fremove(tmp_b);
       } else {

       }
    }

  }

}

public udb_Save(nickname[], pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[], Float:X, Float:Y, Float:Z, Float:ang, Float:health) {
  new tmpres[MAX_STRING];
  tmpres[0]=0;
  new tmp[MAX_STRING];
  new File:fhnd;
  
  valstr(tmp,pwd_hash);  strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,acc_state); strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,skin);      strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,bank_money);strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,gasoline);  strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,habaerea);  strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,habterre);  strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,habnauti);  strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,prisao);    strcat(tmpres,tmp); strcat(tmpres,";");
  valstr(tmp,prof);    strcat(tmpres,tmp); strcat(tmpres,";");
  strcat(tmpres,clantag);
  format(tmpres,sizeof(tmpres),"%s;%f;%f;%f;%f;%f", tmpres, X, Y, Z, ang, health);
  
  
  new tmp2[MAX_STRING];

  new tmp_a[MAX_STRING];
  new tmp_b[MAX_STRING];

  set(tmp2,udb_encode(nickname));
  udp_PRIVATE_clearbroken(tmp2);

  set(tmp_a,tmp2);strcat(tmp_a,".1.player");
  set(tmp_b,tmp2);strcat(tmp_b,".2.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }

  set(tmp_a,tmp2);strcat(tmp_a,".2.player");
  set(tmp_b,tmp2);strcat(tmp_b,".3.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }
  set(tmp_a,tmp2);strcat(tmp_a,".3.player");
  set(tmp_b,tmp2);strcat(tmp_b,".1.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_b,io_write);
	 fwrite(fhnd,tmpres);
	 fclose(fhnd);
	 fremove(tmp_a);
     return true;
  }
  fhnd=fopen(tmp_b,io_write);
  fwrite(fhnd,tmpres);
  fclose(fhnd);


  return false;
}

public udb_Load(nickname[], &pwd_hash, &acc_state, &skin, &bank_money, &gasoline, &habaerea, &habterre, &habnauti, &prisao, &prof, clantag[], &Float:X, &Float:Y, &Float:Z, &Float:ang, &Float:health) {
  new tmpres[MAX_STRING];
  tmpres[0]=0;
  pwd_hash=0; acc_state=0; skin=0; bank_money=0; gasoline=0; habaerea=0; habterre=0; habnauti=0; prisao=0; prof=0; clantag[0]=0; X=0; Y=0; Z=0; ang=0; health=0;

  new File:fhnd;

  new tmp2[MAX_STRING];
  new tmp_a[MAX_STRING];

  set(tmp2,udb_encode(nickname));
  udp_PRIVATE_clearbroken(tmp2);

  set(tmp_a,tmp2);strcat(tmp_a,".1.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }

  set(tmp_a,tmp2);strcat(tmp_a,".2.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }

  set(tmp_a,tmp2);strcat(tmp_a,".3.player");
  if ((fexist(tmp_a))) {
	 fhnd=fopen(tmp_a,io_read);
	 fread(fhnd,tmpres);
	 fclose(fhnd);
  }
  StripNewLine(tmpres);
  if (tmpres[0]!=0) {
  new i;
  pwd_hash    = strval(strtok(tmpres,i,';'));
  acc_state   = strval(strtok(tmpres,i,';'));
  skin        = strval(strtok(tmpres,i,';'));
  bank_money  = strval(strtok(tmpres,i,';'));
  gasoline    = strval(strtok(tmpres,i,';'));
  habaerea    = strval(strtok(tmpres,i,';'));
  habterre    = strval(strtok(tmpres,i,';'));
  habnauti    = strval(strtok(tmpres,i,';'));
  prisao      = strval(strtok(tmpres,i,';'));
  prof        = strval(strtok(tmpres,i,';'));
  set(clantag,strtok(tmpres,i,';'));
  X           = Float:floatstr(strtok(tmpres,i,';'));
  Y           = Float:floatstr(strtok(tmpres,i,';'));
  Z           = Float:floatstr(strtok(tmpres,i,';'));
  ang       = Float:floatstr(strtok(tmpres,i,';'));
  health      = Float:floatstr(strtok(tmpres,i,';'));
  return true;
  }
  return false;
}

stock udb_getClantag(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return clantag;
  clantag[0]=0;
  return clantag;
}

public udb_getPwdHash(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return pwd_hash;
  return 0;
}

public udb_getAccState(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return acc_state;
  return -1;
}

public udb_getPosition(nickname[], &Float:X, &Float:Y, &Float:Z) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return true;
  return false;
}

public udb_getAng(nickname[], &Float:ang) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return true;
  return false;
}

public udb_getSkin(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return skin;
  return 0;
}

public udb_getBankMoney(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return bank_money;
  return 0;
}

public udb_getHealth(nickname[], &Float:health) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return true;
  return false;
}

public udb_getGasoline(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return gasoline;
  return 0;
}

public udb_getHabaerea(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return habaerea;
  return 0;
}

public udb_gethabterre(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return habterre;
  return 0;
}

public udb_getHabnauti(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return habnauti;
  return 0;
}

public udb_getPrisao(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return prisao;
  return 0;
}

public udb_getProf(nickname[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) return prof;
  return 0;
}


public udb_setClantag(nickname[], new_clantag[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, new_clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setPwdHash(nickname[], new_pwdhash) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, new_pwdhash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setPassword(nickname[], pwd[]) {
  return udb_setPwdHash(nickname, udb_hash(pwd));
}

public udb_setAccState(nickname[], new_accstate) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, new_accstate, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_CheckLogin(nickname[], pwd[]) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if((udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health))&&(udb_hash(pwd)==pwd_hash)) return true;
  return false;
}

public udb_Create(nickname[], pwd[], acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[], Float:X, Float:Y, Float:Z, Float:ang, Float:health) {
  if (udb_Exists(nickname)) return false;
  udb_Save(nickname, udb_hash(pwd), acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
  return true;
}

public udb_setPosition(nickname[], Float:new_x, Float:new_y, Float:new_z) {
	new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
	if(udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
		udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, new_x, new_y, new_z, ang, health);
		return true;
	}
  	return false;
}

public udb_setAng(nickname[], Float:new_ang) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, new_ang, health);
	  return true;
    }
  return false;
}



public udb_setSkin(nickname[], new_skin) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, new_skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setBankMoney(nickname[], new_bankmoney) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, new_bankmoney, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setHealth(nickname[], Float:new_health) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, new_health);
	  return true;
    }
  return false;
}

public udb_setGasoline(nickname[], new_gasoline) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, new_gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setHabaerea(nickname[], new_habaerea) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, new_habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setHabterre(nickname[], new_habterre) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, new_habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setHabnauti(nickname[], new_habnauti) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, new_habnauti, prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setPrisao(nickname[], new_prisao) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, new_prisao, prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}

public udb_setProf(nickname[], new_prof) {
  new pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag[MAX_STRING], Float:X, Float:Y, Float:Z, Float:ang, Float:health;
  if (udb_Load(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, prof, clantag, X, Y, Z, ang, health)) {
      udb_Save(nickname, pwd_hash, acc_state, skin, bank_money, gasoline, habaerea, habterre, habnauti, prisao, new_prof, clantag, X, Y, Z, ang, health);
	  return true;
    }
  return false;
}
