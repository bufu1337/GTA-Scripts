/*
 *            Generic Funtions 1.0
*
 * author    	: Red-Zero
 * date      	: 6th Feb 2008
 * required   : sampmysql 0.12
 *
 *
 */

#if defined _functions_included
  #endinput
#endif
#define _functions_included
#pragma library functions

#define MAX_STRING 255
#define MSG_ERROR 0xCC3300FF
#define MSG_INFO 0xADFF2FFF
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_LIGHTGREY 0xCCCCCCFF

stock strcpy(to[], const from[])
{
	new length = strlen(from);
	for (new i = 0; i <= length; i++)
	{
		to[i] = from[i];
	}
}

stock strtok(const string[], &index)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }

    new offset = index;
    new result[32];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}

stock Cstrtok(const string[], &index, sep)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= sep))
    {
        index++;
    }

    new offset = index;
    new result[32];
    while ((index < length) && (string[index] > sep) && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}

stock strrest(const string[], index)
{
	new length = strlen(string);

	new offset = index;
	new result[256];
	while ((index < length) && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

stock IsNumeric(const string[]) //By Mike
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
	    if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

stock PlayerID(partofname[]) //By Jan "DracoBlue" Schütze
{
	new i;
	new playername[MAX_STRING];
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i,playername,MAX_STRING);
			if (strcmp(playername,partofname,true)==0) 	return i;
		}
	}
	new correctsigns_userid=-1;
	new tmpuname[MAX_STRING];
	new hasmultiple=-1;
	for (i=0;i<MAX_PLAYERS;i++)
	{
		if (IsPlayerConnected(i))
		{
			GetPlayerName(i,tmpuname,MAX_STRING);
			if (strfind(tmpuname,partofname,true)==0)
			{
				hasmultiple++;
				correctsigns_userid=i;
			}
			if (hasmultiple>0) 	return -2;
		}
	}
	return correctsigns_userid;
}

stock ReturnID(part[])
{
	new tmpid;
	if(!IsNumeric(part)) tmpid = PlayerID(part);
	else tmpid = strval(part);
	if(tmpid < 0) return tmpid;
	if(!IsPlayerConnected(tmpid)) return -1;
	else return tmpid;
}

SendError(playerid, errormessage[])
{
	new _error[MAX_STRING];
	format(_error, MAX_STRING, ".: Error: %s :.", errormessage);
	if(IsPlayerConnected(playerid)) SendClientMessage(playerid, MSG_ERROR,  _error);
	return 1;
}

SendInfo(playerid, infostr[])
{
	new _info[MAX_STRING];
	format(_info, MAX_STRING, ".: Info: %s :.", infostr);
	if(IsPlayerConnected(playerid)) SendClientMessage(playerid, MSG_INFO, _info);
	return 1;
}

SendWarning(playerid, warnstr[])
{
	new _warn[MAX_STRING];
	format(_warn, MAX_STRING, ".: Warning: %s :.", warnstr);
	if(IsPlayerConnected(playerid)) SendClientMessage(playerid, COLOR_ORANGE, _warn);
	return 1;
}

SendUsage(playerid, commandn[], helpmsg[])
{
	new _usage[MAX_STRING];
	format(_usage, MAX_STRING, ".: Usage: /%s %s :.", commandn, helpmsg);
	if(IsPlayerConnected(playerid)) SendClientMessage(playerid, COLOR_LIGHTGREY, _usage);
	return 1;
}

stock PlayerName(playerid)
{
  new name[MAX_PLAYER_NAME];
  GetPlayerName(playerid, name, MAX_PLAYER_NAME);
  return name;
}

stock GetDistanceBetweenPlayers(playerid,playerid2) //By Slick (Edited by Sacky)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	GetPlayerPos(playerid2,x2,y2,z2);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}

stock IsPlayerInSphere(playerid,Float:sx,Float:sy,Float:sz,sradius) //By Sacky
{
	if(GetPlayerDistanceToPointEx(playerid,sx,sy,sz) < sradius){
	return 1;
}
	return 0;
}

stock GetPlayerDistanceToPointEx(playerid,Float:sx,Float:sy,Float:sz) //By Sacky
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(sx,x1)),2)+floatpower(floatabs(floatsub(sy,y1)),2)+floatpower(floatabs(floatsub(sz,z1)),2));
	return floatround(tmpdis);
}

/**
 *  Return the value of an hex-string
 *  @param string
 */
stock HexToInt(string[]) {
  if (string[0]==0) return 0;
  new i;
  new cur=1;
  new res=0;
  for (i=strlen(string);i>0;i--) {
    if (string[i-1]<58) res=res+cur*(string[i-1]-48); else res=res+cur*(string[i-1]-65+10);
    cur=cur*16;
  }
  return res;
}

/**
 *  Return the int as string
 *  @param   number
 */
stock IntToHex(number)
{
	new m=1;
	new depth=0;
	while (number>=m) {
		m = m*16;
		depth++;
	}
	depth--;
	new str[MAX_STRING];
	for (new i = depth; i >= 0; i--)
	{
		str[i] = ( number & 0x0F) + 0x30; // + (tmp > 9 ? 0x07 : 0x00)
		str[i] += (str[i] > '9') ? 0x07 : 0x00;
		number >>= 4;
	}
	str[8] = '\0';
	return str;
}

