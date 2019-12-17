/********************************************
*	  DUtils functions 1.6, Dini 1.4        *
*     (c) Copyright 2006 by DracoBlue       *
*     Xtreme Administration Filterscript  	*
*     Programmers: Xtreme                   *
*     Include Programmer: DracoBlue		    *
********************************************/

#if defined _dutils_included
  #endinput
#endif

#define _dutils_included
#pragma library dutils

#define MAX_STRING 255

#if !defined floatstr
native Float:floatstr(const string[]);
#endif


new PRIVATE_Last_Money[MAX_PLAYERS];

/**
 *  Return the truncated value
 *  @param   Float:value
 */
trunc(Float:value) {
  return floatround(value,floatround_floor);
}
#pragma unused trunc

/**
 *  Sets money for player
 *  @param   playerid
 *           howmuch
 */
SetPlayerMoney(playerid,howmuch) {
  PRIVATE_Last_Money[playerid]=howmuch;
  GivePlayerMoney(playerid,howmuch-GetPlayerMoney(playerid));
}
#pragma unused SetPlayerMoney

/**
 *  Copies a file (Source file won't be deleted!)
 *  @param   oldname
 *           newname
 *  @requires WINDOWS
 */
fcopy(oldname[],newname[]) {
  new File:ohnd,File:nhnd;
  if (!fexist(oldname)) return false;
  ohnd=fopen(oldname,io_read);
  nhnd=fopen(newname,io_write);
  new buf2[1];
  new i;
  for (i=flength(ohnd);i>0;i--) {
    fputchar(nhnd, fgetchar(ohnd, buf2[0],false),false);
  }
  fclose(ohnd);
  fclose(nhnd);
  return true;
}
#pragma unused fcopy


/**
 *  Copies a textfile (Source file won't be deleted!)
 *  @param   oldname
 *           newname
 */
fcopytextfile(oldname[],newname[]) {
  new File:ohnd,File:nhnd;
  if (!fexist(oldname)) return false;
  ohnd=fopen(oldname,io_read);
  nhnd=fopen(newname,io_write);
  new tmpres[MAX_STRING];
  while (fread(ohnd,tmpres)) {
    StripNewLine(tmpres);
    format(tmpres,sizeof(tmpres),"%s\r\n",tmpres);
    fwrite(nhnd,tmpres);
  }
  fclose(ohnd);
  fclose(nhnd);
  return true;
}
#pragma unused fcopytextfile


/**
 *  Renames a file (Source file will be deleted!)
 *  @param   oldname
 *           newname
 *  @requires WINDOWS (because fcopy does)
 */
frename(oldname[],newname[]) {
    if (!fexist(oldname)) return false;
    fremove(newname);
    if (!fcopy(oldname,newname)) return false;
    fremove(oldname);
    return true;
}
#pragma unused frename

/**
 *  Strips Newline from the end of a string.
 *  Idea: Y_Less, Bugfixing (when length=1) by DracoBlue
 *  @param   string
 */
stock StripNewLine(string[])
{
  new len = strlen(string);
  if (string[0]==0) return ;
  if ((string[len - 1] == '\n') || (string[len - 1] == '\r'))
    {
      string[len - 1] = 0;
      if (string[0]==0) return ;
      if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
    }
}
#pragma unused StripNewLine

/**
 *  Copies items from one array/string into return.
 *  @param   source
 *           index (where to start, 0 is first)
 *           numbytes (how much)
 */
ret_memcpy(source[],index=0,numbytes) {
  new tmp[MAX_STRING];
  new i=0;
  tmp[0]=0;
  if (index>=strlen(source)) return tmp;
  if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
  if (numbytes<=0) return tmp;
  for (i=index;i<numbytes+index;i++) {
	tmp[i-index]=source[i];
	if (source[i]==0) return tmp;
  }
  tmp[numbytes]=0;
  return tmp;
}
#pragma unused ret_memcpy

/**
 *  Copies items from one array/string into another.
 *  @param   dest
 *           source
 *           count
 */
stock copy(dest[],source[],count) {
  dest[0]=0;
  if (count<0) return false;
  if (count>strlen(source)) count=strlen(source);
  new i=0;
  for (i=0;i<count;i++) {
	dest[i]=source[i];
	if (source[i]==0) return true;
  }
  dest[count]=0;
  return true;
}
#pragma unused copy


/**
 *  Deletes the first 'count' items of a array/string
 *  @param   string[]
 *           count
 */
stock delete(string[],count) {
  new tmp[MAX_STRING];
  tmp[0]=0;
  if (count<=0) {
    format(tmp,sizeof(tmp),"%s",string);
    return tmp;
  }
  tmp=ret_memcpy(string,count,strlen(string));
  return tmp;
}
#pragma unused delete

/**
 *  Sets a string's value to source.
 *  @param   dest
 *           source
 *           count
 */
stock set(dest[],source[]) {
  new count = strlen(source);
  new i=0;
  for (i=0;i<count;i++) {
	dest[i]=source[i];
  }
  dest[count]=0;
}
#pragma unused set

/**
 *  Checks wether two strings are equal (case insensetive)
 *  @param   str1
 *           str2
 */
stock equal(str1[],str2[],bool:ignorecase) {
    if (strlen(str1)!=strlen(str2)) return false;
    if (strcmp(str1,str2,ignorecase)==0) return true;
    return false;
  }
#pragma unused equal

/**
 *  Returns an element of a string splitted by ' ', default index is 0.
 *  @param   string
 *           index
 */

stock mod(up,down) {
  return up-(floatround((up/down),floatround_floor))*down;
}
#pragma unused mod

stock div(up,down) {
  return (floatround((up/down),floatround_floor));
}
#pragma unused div

/**
 *  Returns a hashed value in adler32 as int
 *  @param   buf
 */
stock num_hash(buf[])
 {
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
#pragma unused num_hash

/**
 *  Returns a hashed value in adler32 as string
 *  @param   buf
 */
stock hash(str2[])
   {
   new tmpdasdsa[MAX_STRING];
   tmpdasdsa[0]=0;
   valstr(tmpdasdsa,num_hash(str2));
   return tmpdasdsa;
}
#pragma unused hash

/**
 *  Returns a string which has 'newstr' where 'trg' was before
 *  @param   trg
 *           newstr
 *           src
 */
strreplace(trg[],newstr[],src[]) {
    new f=0;
    new s1[MAX_STRING];
    new tmp[MAX_STRING];
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0)
      {
        strcat(tmp,ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
      }
    strcat(tmp,s1);
    return tmp;
}
#pragma unused strreplace
strlower(txt[]) {
  new tmp[MAX_STRING];
  tmp[0]=0;
  if (txt[0]==0) return tmp;
  new i=0;
  for (i=0;i<strlen(txt);i++) {
	tmp[i]=tolower(txt[i]);
  }
  tmp[strlen(txt)]=0;
  return tmp;
}
#pragma unused strlower
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
stock dini_Exists(filename[]) {
  if (fexist(filename)) return true;
  return false;
}
stock dini_Remove(filename[]) {
  if (!fexist(filename)) return false;
  fremove(filename);
  return true;
}
stock dini_Create(filename[]) {
  new File:fhnd;
  if (fexist(filename)) return false;
  fhnd=fopen(filename,io_write);
  fclose(fhnd);
  return true;
}
stock dini_PRIVATE_ExtractKey(line[]) {
    new tmp[MAX_STRING];
    tmp[0]=0;
    if (strfind(line,"=",true)==-1) return tmp;
    set(tmp,strlower(ret_memcpy(line,0,strfind(line,"=",true))));
    return tmp;
}
stock dini_PRIVATE_ExtractValue(line[]) {
    new tmp[MAX_STRING];
    tmp[0]=0;
    if (strfind(line,"=",true)==-1) {
        return tmp;
    }
    set(tmp,ret_memcpy(line,strfind(line,"=",true)+1,strlen(line)));
    return tmp;
}
stock dini_Set(filename[],key[],value[]) {
  new File:fohnd, File:fwhnd;
  new bool:wasset=false;
  new tmpres[MAX_STRING];
  if (key[0]==0) return false; /* If we have no sign in key, it can't be set*/
  format(tmpres,sizeof(tmpres),"%s.part",filename);
  fohnd=fopen(filename,io_read);
  if (!fohnd) return false;
  fremove(tmpres);
  fwhnd=fopen(tmpres,io_write);
//  if (!fwhnd) return false;
  while (fread(fohnd,tmpres)) {
    StripNewLine(tmpres);
    if ((!wasset)&&(equal(dini_PRIVATE_ExtractKey(tmpres),key,true))) {
      /* We've got what needs to be replaced! */
      format(tmpres,sizeof(tmpres),"%s=%s",key,value);
      wasset=true;
    }
    fwrite(fwhnd,tmpres);
    fwrite(fwhnd,"\r\n");
  }
  if (!wasset) {
    format(tmpres,sizeof(tmpres),"%s=%s",key,value);
    fwrite(fwhnd,tmpres);
    fwrite(fwhnd,"\r\n");
  }
  fclose(fohnd);
  fclose(fwhnd);
  format(tmpres,sizeof(tmpres),"%s.part",filename);
  if (fcopytextfile(tmpres,filename)) {
    return fremove(tmpres);
  } else return false;
}
stock dini_IntSet(filename[],key[],value) {
   new valuestring[MAX_STRING];
   format(valuestring,sizeof(valuestring),"%d",value);
   return dini_Set(filename,key,valuestring);
}
stock dini_Int(filename[],key[]) {
   return strval(dini_Get(filename,key));
}
stock dini_FloatSet(filename[],key[],Float:value) {
   new valuestring[MAX_STRING];
   format(valuestring,sizeof(valuestring),"%f",value);
   return dini_Set(filename,key,valuestring);
}
stock Float:dini_Float(filename[],key[]) {
   return floatstr(dini_Get(filename,key));
}
stock dini_Bool(filename[],key[]) {
   return strval(dini_Get(filename,key));
}
stock dini_BoolSet(filename[],key[],value) {
   new valuestring[MAX_STRING];
   format(valuestring,sizeof(valuestring),"%d",value);
   return dini_Set(filename,key,valuestring);
}
stock dini_Unset(filename[],key[]) {
  new File:fohnd, File:fwhnd;
  new tmpres[MAX_STRING];
  format(tmpres,sizeof(tmpres),"%s.part",filename);
  fohnd=fopen(filename,io_read);
  if (!fohnd) return false;
  fremove(tmpres);
  fwhnd=fopen(tmpres,io_write);
//  if (!fwhnd) return false;
  while (fread(fohnd,tmpres)) {
    StripNewLine(tmpres);
    if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true)) {
      /* We've got what needs to be removed! */
    } else {
    format(tmpres,sizeof(tmpres),"%s",tmpres);
    fwrite(fwhnd,tmpres);
    fwrite(fwhnd,"\r\n");
    }
  }

  fclose(fohnd);
  fclose(fwhnd);

  format(tmpres,sizeof(tmpres),"%s.part",filename);
  if (fcopytextfile(tmpres,filename)) {
    return fremove(tmpres);
  }
  return false;
}
stock dini_Get(filename[],key[]) {
  new File:fohnd;
  new tmpres[MAX_STRING];
  new tmpres2[MAX_STRING];
  tmpres[0]=0;
  fohnd=fopen(filename,io_read);
  if (!fohnd) return tmpres;
  while (fread(fohnd,tmpres)) {
    StripNewLine(tmpres);
    if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true)) {
      /* We've got what we need */
      tmpres2[0]=0;
      strcat(tmpres2,dini_PRIVATE_ExtractValue(tmpres));
      fclose(fohnd);
      return tmpres2;
    }
  }
  fclose(fohnd);
  return tmpres;
}
stock dini_Isset(filename[],key[]) {
  new File:fohnd;
  new tmpres[MAX_STRING];
  fohnd=fopen(filename,io_read);
  if (!fohnd) return false;
  while (fread(fohnd,tmpres)) {
    StripNewLine(tmpres);
    if (equal(dini_PRIVATE_ExtractKey(tmpres),key,true)) {
      /* We've got what we need */
      fclose(fohnd);
      return true;
    }
  }
  fclose(fohnd);
  return false;
}
stock udb_hash(buf[]) {
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
  tmp=strreplace("_","_00",tmp);
  tmp=strreplace(";","_01",tmp);
  tmp=strreplace("!","_02",tmp);
  tmp=strreplace("/","_03",tmp);
  tmp=strreplace("\\","_04",tmp);
  tmp=strreplace("[","_05",tmp);
  tmp=strreplace("]","_06",tmp);
  tmp=strreplace("?","_07",tmp);
  tmp=strreplace(".","_08",tmp);
  tmp=strreplace("*","_09",tmp);
  tmp=strreplace("<","_10",tmp);
  tmp=strreplace(">","_11",tmp);
  tmp=strreplace("{","_12",tmp);
  tmp=strreplace("}","_13",tmp);
  tmp=strreplace(" ","_14",tmp);
  tmp=strreplace("\"","_15",tmp);
  tmp=strreplace(":","_16",tmp);
  tmp=strreplace("|","_17",tmp);
  tmp=strreplace("=","_18",tmp);
  return tmp;
}
