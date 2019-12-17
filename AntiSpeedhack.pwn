//Easy, look you use OnPlayerUpdate(playerid)
//So mine is like this, It's kinda simple and easy

new SpeedHacking[MAX_PLAYERS];
#define SpeedCheck(%0,%1,%2,%3,%4) floatround(floatsqroot(%4?(%0*%0+%1*%1+%2*%2):(%0*%0+%1*%1) ) *%3*1.6)
//=================================================================================================//
//Under OnPlayerUpdate
public OnPlayerUpdate(playerid)
{
        //Anti SpeedHack
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
          if(GetPlayerVehicleID(playerid) != 578 || GetPlayerVehicleID(playerid) != 520 || GetPlayerVehicleID(playerid) != 578 || 425)
      {
           if(PlayerInfo[playerid][pAdmin] < 10)
           {
         if(GetVehicleSpeed(GetPlayerVehicleID(playerid), 0) > 250)
                 {
        	    new Float:x, Float:y, Float:z;
        	    GetPlayerPos(playerid, x, y, z);
        	    SetPlayerPos(playerid, x, y, z+5);
                    SpeedHacking[playerid] =1;
                    CheatsDetected(playerid);
            return 1;
         }
        }
       }
        }
    //OTHER CODES
    return 1;
}
//=================================================================================================//
//Now lets go to the stock CheatsDetected
//Stock CheatsDeteceed
stock CheatsDetected(playerid)
{
   new string[128];
   if(SpeedHacking[playerid] == 1)
   {
      new pName[MAX_PLAYER_NAME];
      GetPlayerName(playerid,pName,MAX_PLAYER_NAME);
      format(string,sizeof(string),"[ANTI CHEAT] Anti-Cheat has banned %s(%d). [Reason: Cheats Detected]",pName,playerid);
      SendClientMessageToAll(COLOR_PINK,string);

      format(string,sizeof(string),"1[ANTI CHEAT] Anti-Cheat has banned %s(%d). [Reason: Cheats Detected]",pName,playerid);
      IRC_GroupSay(gGroupID,IRC_CHANNEL,string);
      IRC_GroupSay(gGroupID,IRC_ADMINCHANNEL,string);

      format(string, sizeof(string), "~r~BANNED!");
      GameTextForPlayer(playerid, string, 3000, 1);

      new INI:File = INI_Open(UserPath(playerid));
      INI_SetTag(File,"Player's Data");
      INI_WriteString(File,"BanReason","Cheats Detected");
      INI_WriteString(File,"Reason","Speed Hacks");
      INI_Close(File);
      PlayerInfo[playerid][pBanned] =1;

      SetTimerEx("KickPlayer",1000,false,"i",playerid);
      return 1;
  }
 return 1;
}
//=================================================================================================//
//In o.3x Kick(playerid); has proirity over all codes, so you have to make a timer for it
//like this so it posts all the codes needed before the kick

forward KickPlayer(ID);
public KickPlayer(ID)
{
     Kick(ID);
     return 1;
}
//=================================================================================================//
//Now lets come to OnPlayerConnect part
//So I'm using Y_INI as you see
if(fexist(UserPath(playerid)))
    {
        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
        if(PlayerInfo[playerid][pBanned] == 1)
        {
          format(string,sizeof(string),"[BANNED] You are currently banned from the server. [Reason: %s]",PlayerInfo[playerid][pBanReason]);
          SendClientMessage(playerid, COLOR_RED,string);
          SendClientMessage(playerid, COLOR_RED,"[BANNED] Please Ban Appeal on our forums at www.SERVER.net");
          SetTimerEx("KickPlayer",1000,false,"i",playerid);
          return 1;
        }
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT,"{FF0000}SERVER","{FFFFFF}Welcome back to the server! \n Type your password below to login.","Login","Quit");
    }
//=================================================================================================//
//Vehicle speed
stock GetVehicleSpeed(vehicleid, get3d)
{
        new Float:x, Float:y, Float:z;
        GetVehicleVelocity(vehicleid, x, y, z);
        return SpeedCheck(x, y, z, 100.0, get3d);
}