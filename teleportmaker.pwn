#include <a_samp>

#define weiss	0xFFFFFFAA
#define gelb 	0xFFFF00AA
#define rot 	0xAA3333AA

new str[256];

new Float:Pos[MAX_PLAYERS][4];
new Interior[MAX_PLAYERS];
new CMDName[MAX_PLAYERS][256];
new Money[MAX_PLAYERS][256];

new PosSelected[MAX_PLAYERS];
new CMDNameSelected[MAX_PLAYERS];
new MoneySelected[MAX_PLAYERS];


public OnFilterScriptInit()
{
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	print("~                                    ~");
	print("~ InGame Teleport-Maker by [RTS]Toad ~");
	print("~                                    ~");
	print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
	return 1;
}


public OnPlayerCommandText(playerid,cmdtext[])
{
	new cmd[256],idx;
	cmd = strtok(cmdtext,idx);
	if(!strcmp(cmdtext,"/infos",true))
	{
	    SendClientMessage(playerid,weiss,"Commands avaible to make a Teleport:");
		SendClientMessage(playerid,weiss,"Go to the Place where you want to be teleported in your Teleport and type '/pos'");
		SendClientMessage(playerid,weiss,"Now, to define the command name, type '/cmdname ([cmdname] without '/')'");
		SendClientMessage(playerid,weiss,"Define the money which the player who uses the Teleport pays with '/money [payamount]'");
		SendClientMessage(playerid,weiss,"When you have done all these Things, type '/makeit' to save your Teleport to a file named:");
		SendClientMessage(playerid,weiss,"TeleportMaker.txt");
	    return 1;
	}
	if(!strcmp(cmdtext,"/pos",true,4))
	{
		if(PosSelected[playerid] == 1) return SendClientMessage(playerid,rot,"You already defined the Position");
		GetPlayerPos(playerid,Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		GetPlayerFacingAngle(playerid,Pos[playerid][3]);
		Interior[playerid] = GetPlayerInterior(playerid);
		PosSelected[playerid] = 1;
		format(str,256,"Position succesfully defined .. X: %.4f .. Y: %.4f .. Z: %.4f .. Angle: %.4f .. Interior: %d",Pos[playerid][0],Pos[playerid][1],Pos[playerid][2],Pos[playerid][3],Interior[playerid]);
		SendClientMessage(playerid,gelb,str);
		return 1;
	}
	if(!strcmp(cmdtext,"/cmdname",true,8))
	{
	    if(CMDNameSelected[playerid] == 1) return SendClientMessage(playerid,rot,"You already defined the CommandName");
	    CMDName[playerid] = strtok(cmdtext,idx);
	    if(!strlen(CMDName[playerid])) return SendClientMessage(playerid,rot,"ERROR: /cmdname ([cmdname] without '/')");
	    CMDNameSelected[playerid] = 1;
	    format(str,256,"CommandName succesfully defined .. CommandName: /%s",CMDName[playerid]);
	    SendClientMessage(playerid,gelb,str);
		return 1;
	}
	if(!strcmp(cmdtext,"/money",true,6))
	{
	    if(MoneySelected[playerid] == 1) return SendClientMessage(playerid,rot,"You already defined the Money");
	    Money[playerid] = strtok(cmdtext,idx);
	    if(!strlen(Money[playerid])) return SendClientMessage(playerid,rot,"ERROR: /money [payamount]");
	    MoneySelected[playerid] = 1;
	    format(str,256,"Money succesfully defined .. Money: %s$",Money[playerid]);
	    SendClientMessage(playerid,gelb,str);
	    return 1;
	}
	if(!strcmp(cmdtext,"/makeit",true,5))
	{
	    if(PosSelected[playerid] == 0) return SendClientMessage(playerid,rot,"You haven't defined any Position");
	    if(CMDNameSelected[playerid] == 0) return SendClientMessage(playerid,rot,"You haven't defined any CommandName");
	    if(MoneySelected[playerid] == 0) return SendClientMessage(playerid,rot,"You haven't defined any Money");
	    new File:fhandle;
    	fhandle = fopen("TeleportMaker.txt",io_append);
	    fwrite(fhandle,	" \r\n");
	    format(str,256,	"if(!strcmp(cmdtext,\"/%s\",true))\r\n",CMDName[playerid]);
	    fwrite(fhandle,str);
		fwrite(fhandle,	"{\r\n");
		format(str,256,	"   if(GetPlayerMoney(playerid) < %s) return SendClientMessage(playerid,0xAA3333AA,\"You haven't enogh Money\");\r\n",Money[playerid]);
		fwrite(fhandle,str);
		fwrite(fhandle,	"   if(!IsPlayerInAnyVehicle(playerid))\r\n");
		fwrite(fhandle,	"   {\r\n");
		format(str,256,	"      SetPlayerPos(playerid,%.4f,%.4f,%.4f);\r\n",Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerFacingAngle(playerid,%.4f);\r\n",Pos[playerid][3]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerInterior(playerid,%d);\r\n",Interior[playerid]);
		fwrite(fhandle,str);
		fwrite(fhandle,	"   }else\r\n");
		fwrite(fhandle, "   {\r\n");
		format(str,256,	"      SetVehiclePos(GetPlayerVehicleID(playerid),%.4f,%.4f,%.4f);\r\n",Pos[playerid][0],Pos[playerid][1],Pos[playerid][2]);
		fwrite(fhandle,str);
		format(str,256,	"      SetVehicleZAngle(GetPlayerVehicleID(playerid),%.4f);\r\n",Pos[playerid][3]);
		fwrite(fhandle,str);
		format(str,256,	"      SetPlayerInterior(playerid,%d);\r\n",Interior[playerid]);
		fwrite(fhandle,str);
		format(str,256,	"      LinkVehicleToInterior(GetPlayerVehicleID(playerid),%d);\r\n",Interior[playerid]);
		fwrite(fhandle,str);
		fwrite(fhandle,	"   }\r\n");
		fwrite(fhandle, "   return 1;\r\n");
  		fwrite(fhandle, "}\r\n");
	    fwrite(fhandle,	" \r\n");
  		fclose(fhandle);
  		SendClientMessage(playerid,gelb,"Your Teleport has been created in the file 'TeleportMaker.txt' in your scriptfiles");
  		PosSelected[playerid] = 0;
		CMDNameSelected[playerid] = 0;
		MoneySelected[playerid] = 0;
	    return 1;
	}
	return 0;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid,weiss,"Welcome to [RTS]Toad's InGame TeleportMaker, type /infos for infos how to make a Teleport");
	PosSelected[playerid] = 0;
	CMDNameSelected[playerid] = 0;
	MoneySelected[playerid] = 0;
	return 1;
}


//strtok
strtok(const string[], &index)
{
 new length = strlen(string);
 while ((index < length) && (string[index] <= ' ') && (string[index] > '\r'))
 {
  index++;
 }

 new offset = index;
 new result[30];
 while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)) && (string[index] > '\r'))
 {
  result[index - offset] = string[index];
  index++;
 }
 result[index - offset] = EOS;
 return result;
}
