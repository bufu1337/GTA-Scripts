//==============================================================================
//                         Youtube Player v1.0 by usrb1n !
//                   http://forum.sa-mp.com/member.php?u=122322
//					 http://www.youtube-mp3.org/
//==============================================================================
//                              Includes & Defines
//==============================================================================
#include <a_samp>
#include <a_http>
#include <core>
#include <float>
#define U2BDIAG				6958 //DialogID used
new PlayerU2B[MAX_PLAYERS];
new PlayerU2BLink[MAX_PLAYERS][32];
new U2BRadius[MAX_PLAYERS][16];
forward U2BInfo(playerid, response_code, data[]);
#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define WHOMADETHIS "Youtube Player v1.0 by {FF0000}us{FFEF00}rb{1A00FF}1n"

public OnFilterScriptInit()
{
	print("Youtube player by usrb1n has been loaded");
}
public OnFilterScriptExit()
{
	print("Youtube player by usrb1n has been unloaded");
}

//==============================================================================
//                              Commands
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(youtube, 7, cmdtext);
    dcmd(stopu2b, 7, cmdtext);
	return 0;
}

dcmd_stopu2b(playerid, params[])
{
    if(strlen(params)) return 0;
	PlayAudioStreamForPlayer(playerid, "Music was stoped by player.");
 	return 1;
}

dcmd_youtube(playerid, params[])
{
    if(strlen(params)) return 0;
    if(!IsPlayerAdmin(playerid))
    {
		SendClientMessage(playerid, 0xD776FF, "Only RCON admins can use this command.");
		return 1;
	}
	ShowPlayerDialog(playerid, U2BDIAG, DIALOG_STYLE_LIST, WHOMADETHIS, "{46BEE6}Play for yourself (The song will be played only for you)\n{ED954E}Play for someone (The song will be played for the ID you input in the textbox)\n{46BEE6}Play for a location (The song will be played with the radius you choose)\n{ED954E}Play for all (The song will be played for all the players in the server)", "Select", "Cancel");
	return 1;
}
//==============================================================================
//                              Dialogs
//==============================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == U2BDIAG && response)
	{
		switch(listitem)
		{
  			case 0:
			{
			    PlayerU2B[playerid] = 1;
			    ShowPlayerDialog(playerid,U2BDIAG+1,DIALOG_STYLE_INPUT,WHOMADETHIS,"Paste the youtube link you want to play for yourself:","Play","Cancel");
   				return 1;
			}
			case 1:
			{
			    PlayerU2B[playerid] = 2;
			    ShowPlayerDialog(playerid,U2BDIAG+1,DIALOG_STYLE_INPUT,WHOMADETHIS,"Paste the youtube link you want to play for a player:","Play","Cancel");
   				return 1;
			}
			case 2:
			{
			    PlayerU2B[playerid] = 3;
			    ShowPlayerDialog(playerid,U2BDIAG+1,DIALOG_STYLE_INPUT,WHOMADETHIS,"Paste the youtube link you want to play for your location:","Play","Cancel");
   				return 1;
			}
			case 3:
			{
			    PlayerU2B[playerid] = 4;
			    ShowPlayerDialog(playerid,U2BDIAG+1,DIALOG_STYLE_INPUT,WHOMADETHIS,"Paste the youtube link you want to play for the whole server:","Play","Cancel");
   				return 1;
			}
		}
	}
	if(dialogid == U2BDIAG+1 && response)
	{
	    if(strlen(inputtext))
	    {
	        new result[128], videostr[128];
			strmid(result,inputtext,31,44,strlen(inputtext));
	        format(videostr,sizeof(videostr),"www.youtube-mp3.org/api/itemInfo/?video_id=%s",result);
	        strmid(PlayerU2BLink[playerid], result, 0, 32);
		    if (PlayerU2B[playerid] == 1)
		    {
		        PlayerU2B[playerid] = 11;
        		HTTP(playerid,HTTP_GET,videostr,"","U2BInfo");
			}
			else if (PlayerU2B[playerid] == 2)
		    {
                PlayerU2B[playerid] = 22;
				ShowPlayerDialog(playerid,U2BDIAG+2,DIALOG_STYLE_INPUT,WHOMADETHIS,"Enter the player id you want to play the song for:","Play","Cancel");
				new string[128];
				format(string, sizeof(string), "%s", PlayerU2BLink[playerid]);
			}
	        else if (PlayerU2B[playerid] == 3)
		    {
		        PlayerU2B[playerid] = 33;
    			ShowPlayerDialog(playerid,U2BDIAG+3,DIALOG_STYLE_INPUT,WHOMADETHIS,"Enter the radius in which you want the song to be heard:","Play","Cancel");
			}
	        else if (PlayerU2B[playerid] == 4)
		    {
		        PlayerU2B[playerid] = 44;
    			HTTP(playerid,HTTP_GET,videostr,"","U2BInfo");
			}
		}
		return 1;

	}
	if(dialogid == U2BDIAG+2 && response)
	{
 		new gpid = strval(inputtext);
		new videostr[128];
		format(videostr,sizeof(videostr),"www.youtube-mp3.org/api/itemInfo/?video_id=%s",PlayerU2BLink[playerid]);
		HTTP(gpid,HTTP_GET,videostr,"","U2BInfo");
		return 1;

	}
	if(dialogid == U2BDIAG+3 && response)
	{
	    strmid(U2BRadius[playerid], inputtext, 0, 32);
	    new videostr[128];
 		PlayerU2B[playerid] = 333;
		format(videostr,sizeof(videostr),"www.youtube-mp3.org/api/itemInfo/?video_id=%s",PlayerU2BLink[playerid]);
		HTTP(playerid,HTTP_GET,videostr,"","U2BInfo");
		return 1;

	}


	return 0;
}

//==============================================================================
//                              Functions
//==============================================================================

public U2BInfo(playerid, response_code, data[])
{
	if(response_code == 200)
	{
	    new result[33], u2bstr[33]; new streamedurl[128];
		new crypted = strfind(data, "\"h\"", true, -1);
		strmid(result,data,crypted+7,crypted+39,strlen(data));
		format(u2bstr,sizeof(u2bstr), "%s", result);
		format(streamedurl, sizeof(streamedurl), "http://www.youtube-mp3.org/get?video_id=%s&h=%s",PlayerU2BLink[playerid], u2bstr);
		if(PlayerU2B[playerid] == 11)
		{
			PlayAudioStreamForPlayer(playerid, streamedurl);
			return 1;
		}
		else if(PlayerU2B[playerid] == 22)
		{
			PlayAudioStreamForPlayer(playerid, streamedurl);
			return 1;
		}
		else if(PlayerU2B[playerid] == 33)
		{

			PlayAudioStreamForPlayer(playerid, streamedurl);
			return 1;
		}
		else if(PlayerU2B[playerid] == 44)
		{
		    for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
    				PlayAudioStreamForPlayer(i, streamedurl);
					return 1;
	        	}
	        	else return 1;
			}
		}
		else if(PlayerU2B[playerid] == 333)
		{
	  		new Float:X, Float:Y, Float:Z;
	   		GetPlayerPos(playerid, X, Y, Z);
			new radius = strval(U2BRadius[playerid]);
	   		for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
	      			if(IsPlayerInRangeOfPoint(i, radius , X, Y, Z))
		        	{
		        	    PlayAudioStreamForPlayer(i, streamedurl, X, Y, Z, radius, 1);
						return 1;
	     			}
	     			else return 1;
	        	}
			}
		}

  	}
  	else
    {

        new u2bstring[128];
		format(u2bstring,sizeof(u2bstring),"							{FF0000}Youtube link error\n\n{FFFFFF}This youtube link is broken or uses some copyright protection, we can't convert it to mp3 for streaming. Try another link please. ");
		ShowPlayerDialog(playerid,61,DIALOG_STYLE_MSGBOX ,WHOMADETHIS,u2bstring, "Exit", "");
    }
  	return 1;
}
