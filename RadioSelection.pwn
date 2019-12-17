//============================================================================//
//=========================|Radio Selection FS|===============================//
//============================|by [DR]Sc0pe|==================================//
//============================================================================//

//============================================================================//
//                                  Requirements                              //
//============================================================================//
//  In order to run this [FS] you are going to need the following:            //
//               							      //
//  =================================                                         //
//  1.  Incognito's Audio Plugin v0.4                                         //
//  =================================                                         //
//  *	Download: http://www.mediafire.com/?oziymwywxjn                       //
//  *	SA-MP Forums Post: http://forum.sa-mp.com/showthread.php?t=82162      //
//                                                                            //
//  ===========================                                               //
//  2.  Y_Less' Foreach Include                                               //
//  ===========================                                               //
//  *   Download: http://pastebin.com/2wduLfcq                                //
//  *   SA-MP Forums Post: http://forum.sa-mp.com/showthread.php?t=92679      //
//                                                                            //
//============================================================================//
//                              End of Requirements                           //
//============================================================================//

//===[Includes]===//
#include <a_samp>
#include <audio>
#include <foreach>

//===[Defines (Colors)]===//
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_FLBLUE 0x6495EDAA

//===[Defines (Dialog IDs)]===//
#define VolumeInput 11337

//===[Radio Script Variables]===//
new Radio[MAX_PLAYERS];
new Listening[MAX_PLAYERS];

//===[Menus]===//
new Menu:RadioMenu;

public OnFilterScriptInit()
{
    print("|====================================|");
    print("|---|Radio Station Selection Menu|---|");
    print("|-----------|by [DR]Sc0pe|-----------|");
    print("|--------------|Loaded|--------------|");
    print("|====================================|");

    Audio_SetPack("default_pack", true);

    //===[Menu Designs]===//
    RadioMenu = CreateMenu("~b~R~p~a~y~d~g~i~r~o ~w~Menu",1,15,150,225);
    SetMenuColumnHeader(RadioMenu , 0, "~w~Please select your station.");
    AddMenuItem(RadioMenu,0,"Hardstyle");
    AddMenuItem(RadioMenu,0,"Dubstep");
    AddMenuItem(RadioMenu,0,"Electro House");
    AddMenuItem(RadioMenu,0,"Trance");
    AddMenuItem(RadioMenu,0,"Club Sounds");
    AddMenuItem(RadioMenu,0,"Drum and Bass");
    AddMenuItem(RadioMenu,0,"Stop Radio");
    AddMenuItem(RadioMenu,0,"Volume");
    AddMenuItem(RadioMenu,0,"Exit Menu");

    return 1;
}
public OnFilterScriptExit()
{
    print("|======================================|");
    print("|----|Radio Station Selection Menu|----|");
    print("|------------|by [DR]Sc0pe|------------|");
    print("|--------------|UnLoaded|--------------|");
    print("|======================================|");

    foreach (Player, i)
    {
    	Audio_Stop(i, Radio[i]);
    }
    return 1;
}
public Audio_OnClientConnect(playerid)
{
    new string[128];
    format(string, sizeof(string), "Audio client ID %d connected", playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    Audio_TransferPack(playerid);
    return 1;
}
public Audio_OnClientDisconnect(playerid)
{
    new string[128];
    format(string, sizeof(string), "Audio client ID %d disconnected", playerid);
    SendClientMessageToAll(COLOR_YELLOW, string);
    Audio_Stop(playerid,Radio[playerid]);
    return 1;
}
public Audio_OnTrackChange(playerid, handleid, track[])
{
    new string[128];
    format(string, sizeof(string), "Now Playing: %s.", track, handleid);
    SendClientMessage(playerid, COLOR_ORANGE, string);
}
public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if(Current == RadioMenu)
    {
	TogglePlayerControllable(playerid, 1);
	switch(row)
	{
            case 0:
	    {
                if(Listening[playerid] == 1)
  		{
  		     Audio_Stop(playerid, Radio[playerid]);
  		     Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/hardstyle.asx", false, false, false);
		     SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Hardstyle.");
	    	     return 1;
		}
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/hardstyle.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Hardstyle.");
		    Listening[playerid] = 1;
		    return 1;
	        }
	    }
	    case 1:
	    {
                if(Listening[playerid] == 1)
  		{
  		    Audio_Stop(playerid, Radio[playerid]);
  		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/dubstep.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Dubstep.");
	    	    return 1;
		}
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/dubstep.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Dubstep.");
		    Listening[playerid] = 1;
	            return 1;
	        }
	    }
	    case 2:
	    {
                if(Listening[playerid] == 1)
  		{
  		    Audio_Stop(playerid, Radio[playerid]);
  		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/electro.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Electro House.");
		    return 1;
	        }
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/electro.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Electro House.");
		    Listening[playerid] = 1;
	            return 1;
	        }
            }
            case 3:
	    {
                if(Listening[playerid] == 1)
  		{
  		    Audio_Stop(playerid, Radio[playerid]);
  		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/trance.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Trance.");
	    	    return 1;
		}
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/trance.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Trance.");
		    Listening[playerid] = 1;
	            return 1;
	        }
       	    }
	    case 4:
	    {
                if(Listening[playerid] == 1)
  		{
  		    Audio_Stop(playerid, Radio[playerid]);
  		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/club.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Club Sounds.");
	    	    return 1;
		}
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/club.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Club Sounds.");
		    Listening[playerid] = 1;
	            return 1;
	        }
       	    }
	    case 5:
	    {
                if(Listening[playerid] == 1)
  		{
  		    Audio_Stop(playerid, Radio[playerid]);
  		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/drumandbass.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Drum 'n' Bass.");
		}
		else
		{
		    Radio[playerid] = Audio_PlayStreamed(playerid, "http://listen.di.fm/public5/drumandbass.asx", false, false, false);
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Audio Bot: Now playing: Digitally Imported - Drum 'n' Bass.");
		    Listening[playerid] = 1;
	            return 1;
	        }
            }
	    case 6:
	    {
		if(Listening[playerid] == 1)
		{
                    Audio_Stop(playerid, Radio[playerid]);
                    Listening[playerid] = 0;
		    SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You have shut off the Radio.");
	            return 1;
		}
		else
	        {
                    SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You aren't listening to any Radio Stations.");
                    return 1;
	        }
            }
	    case 7:
	    {
            ShowPlayerDialog(playerid, VolumeInput, DIALOG_STYLE_INPUT, "Volume","Type a number between 1 and 10.", "Set", "Cancel");
            return 1;
		}
		case 8:
            {
                HideMenuForPlayer(RadioMenu,playerid);
                return 1;
            }
        }
    }
    return 1;
}
public OnPlayerExitedMenu(playerid)
{
    TogglePlayerControllable(playerid,1);
    return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == VolumeInput)
 	{
	    if(response)
       	    {
           	switch(strval(inputtext)) //Not tested, but I guess it'll work
           	{
           	case 0:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 0);
		    }
            case 1:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 10);
		    }
		    case 2:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 20);
		    }
		    case 3:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 30);
		    }
		    case 4:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 40);
		    }
		    case 5:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 50);
		    }
		    case 6:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 60);
		    }
		    case 7:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 70);
		    }
		    case 8:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 80);
		    }
		    case 9:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 90);
		    }
		    case 10:
           	    {
           	        Audio_SetVolume(playerid, Radio[playerid], 100);
		    }
		    default:
               	    {
               	        SendClientMessage(playerid, 0xFF0000AA, "ERROR: You have entered an invalid volume number.");
               	    }
       	    	}
	    }
	    else return SendClientMessage(playerid, 0xFF0000AA, "ERROR: You have cancelled.");
	}
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
    //===[Radio Script]===//
    if(strcmp(cmdtext,"/radiomenu",true)==0)
    {
		if(Audio_IsClientConnected(playerid))
	        {
	            ShowMenuForPlayer(RadioMenu,playerid);
	            TogglePlayerControllable(playerid,0);
	            return 1;
		}
		else
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You are not connected to the audio server.");
		    SendClientMessage(playerid, COLOR_YELLOW, "You may need to install the audio client, please visit the forums.");
		    return 1;
		}
    }
    if(strcmp(cmdtext,"/stopradio",true)==0)
    {
		if(Audio_IsClientConnected(playerid))
		{
		    if(Listening[playerid] == 1)
		    {
		        Audio_Stop(playerid, Radio[playerid]);
	       	 	SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: Stopped Radio.");
		        return 1;
		    }
		    else
		    {
		        SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You aren't listening to any radio stations.");
		        return 1;
		    }
		}
		else
		{
		    SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You are not connected to the audio server.");
		    SendClientMessage(playerid, COLOR_YELLOW, "You may need to install the audio client, please visit the forums.");
	            return 1;
		}
    }
    //===[Credits]=(Please do not remove this)===//
    if(strcmp(cmdtext, "/radiocredits",true)==0)
    {
        if(Audio_IsClientConnected(playerid))
   		{
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------");
	    SendClientMessage(playerid, COLOR_WHITE, "[DR]Sc0pe: Radio Selection FS");
	    SendClientMessage(playerid, COLOR_WHITE, "Incognito: Audio Plugin v0.4");
            SendClientMessage(playerid, COLOR_LIGHTBLUE, "---------------------------------------");
	    return 1;
		}
		else
		{
	    SendClientMessage(playerid, COLOR_YELLOW, "Audio Bot: You are not connected to the audio server.");
	    SendClientMessage(playerid, COLOR_YELLOW, "You may need to install the audio client, please visit the forums.");
	    return 1;
		}
    }
    return 0;
}