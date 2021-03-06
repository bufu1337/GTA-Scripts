IDS_ABORTING            			= Aborting...
IDS_NO_UPDATE_FOUND     			= No update found.
IDS_ERROR_MESSAGE       			= An error occured. The update service could not continue. If you wish to get further information contact ubisoft technical support and add the text from the technical Log below to your email.\nYou can click on the Copy to Clipboard button below to automatically copy all the text and paste it in your email.
IDS_DOWNLOAD_INCOMPLETE 			= The update download could not be completed.
IDS_QUIT_BUTTON_CAPTION 			= Quit
IDS_DOWNLOAD_PROGRESS   			= %.0f/%.0f bytes received (%.0f%%)
IDS_CURRENT_DOWNLOAD_FILE 			= Downloading %s...
IDS_CAN_RUN_UPDATE_FILE 			= One or more update was found and downloaded!\nDo you wish to run it now?
IDS_CAN_RUN_UPDATE_FILE_DLG_TITLE 	= Update found!
IDS_INIT_FAILED_RES     			= Initialization failed: Missing graphical resources
IDS_THIS_FILE						= This File
IDS_TOTAL							= Total
IDS_CANNOT_FIND_EXECUTABLE			= Cannot find main executable.\n
IDS_START_GAME_BUTTON_CAPTION   	= Start Game

IDS_NETWORK_UNAVAILABLE				= The network is unavailable.\n
IDS_ADMINISTRATOR					= You must be an administrator to run this application.\n
IDS_YES 							= Yes
IDS_NO 								= No
IDS_BTN_ADVANCED					= Advanced
IDS_BTN_INSTA						= Install
IDS_BTN_CLIPBORAD					= Copy To Clipboard
IDS_TECHNICAL_LOG					= Technical log

IDS_LIB_ERR_USER_ABORT				= Download aborted by user.
IDS_LIB_ERR_PARTIALLY				= Download partially failed.
IDS_LIB_ERR_CANNOT_DELETE_FILE		= Unable to delete file 
IDS_LIB_MSG_PATCH_INFO				= Downloading update information
IDS_LIB_MSG_GET_UPDATE_DOWNLOAD		= Trying to get update information to 
IDS_LIB_ERR_DWNLD_UPDATE_INFO		= Failed to download the update information
IDS_LIB_ERR_CANNOT_CONTINUE			= Update service cannot continue.
IDS_LIB_ERR_FILE_PARSING			= File parsing unsuccessful.
IDS_LIB_ERR_FILE_EMPTY				= File empty.
IDS_LIB_ERR_FILE_TYPE				= File of the wrong type.
IDS_LIB_ERR_FILE_FORMAT				= Bad file format.
IDS_LIB_MSG_NEW_UPDATE				= Downloading new update
IDS_LIB_MSG_VERSION_FILE			= Downloading version file
IDS_LIB_MSG_TRYING_VERSION_DOWNLOAD	= Trying to download version file from
IDS_LIB_MSG_DESTINATION				= Destination
IDS_LIB_MSG_SUCCES_VERSION			= Successfully downloaded version file.
IDS_LIB_ERR_CAB_NOT_TRUSTED			= Downloaded version file was not issued by a trusted authority and won't be executed.
IDS_LIB_ERR_DWNLD_VERSION_FILE		= Failed to download this version file
IDS_LIB_ERR_NO_INI					= Error reading version file. No INI file found in package.
IDS_LIB_ERR_NO_UPDATE_FOUND			= No update was found for current targets:
IDS_LIB_MSG_FOUND_UPDATE			= Found update
IDS_LIB_ERR_NO_HISTORY_1			= An update for target was found but the version was not part of the product history. Update cannot be selected.
IDS_LIB_ERR_NO_HISTORY_2			= No history found for target:
IDS_LIB_MSG_ATTEMPTING_RESUME		= Found existing file for target, attempting resume
IDS_LIB_MSG_FLAGGED_EXECUTION		= Found existing file for target, already flagged for execution. Skipping download 
IDS_LIB_MSG_FLAGGED_DELETE			= Found existing file for target, already flagged for deletion. Download fails
IDS_LIB_ERR_NO_MIRRORS				= No mirrors found for update.
IDS_LIB_MSG_TRYING_UPDATE_DOWNLOAD	= Trying to download update file from
IDS_LIB_MSG_SUCCESS_UPDATE			= Successfully downloaded update file.
IDS_LIB_ERR_OPEN_FILE				= Could not open downloaded file. Impossible to verify file's integrity.
IDS_LIB_MSG_CRC_VERIFY				= Verifying downloaded file's CRC:
IDS_LIB_MSG_CRC_EXPECTED			= Expected:
IDS_LIB_ERR_CRC_NOT_MATCH			= The downloaded file CRC does not match the CRC specified in the version file.\nThe downloaded file had an error.
IDS_LIB_MSG_PARTIAL_DOWNLOAD		= Succesfully downloaded update file. Saving file for resume 
IDS_LIB_ERR_FATAL_DOWNLOAD			= Fatal download error
IDS_LIB_ERR_DELETING				= Deleting downloaded data.
IDS_LIB_ERR_LOCAL_TARGET			= The local file information could not be retreived for update
IDS_LIB_ERR_UPDATE_NOT_TRUSTED		= Downloaded update file was not issued by a trusted authority and won't be executed.
IDS_LIB_MSG_START_UPDATE			= Starting update file
IDS_LIB_ERR_FAILED_START_UPDATE		= Failed to start downloaded update file.
IDS_LIB_ERR_EXE_NOT_FOUND			= Patch file executable not found
IDS_LIB_ERR_NOT_ENOUGH_DISK_SPACE	= Not enough disk space
IDS_LIB_MSG_AVAILABLE				= Available� 
IDS_LIB_MSG_REQUIRED				= Required� 
IDS_LIB_MSG_MB						= MB (Megabytes)
IDS_ERR_FAILED_START_GAME			= Failed to start the game.
IDS_ERR_MISSING_REGISTRY_KEY        = Cannot find essential information in the registry.
IDS_ERR_CONFIGURATION               = Configuration error:
IDS_ERR_MISSING_GAMEID  			= 0x0002
IDS_ERR_MISSING_EXECUTABLE_PATH		= 0x0003
IDS_MSG_REINSTALL					= Re-installing the game may fix this problem.
IDS_ERR_USER_CANCEL					= The operation was canceled by the user.
IDS_LIB_ERR_CORRUPTED	            = File corrupted?
                                                                                                        age(playerid,COLOR_SYSMSG,"You've already called for a pizza!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/nopizza", true)==0)
        {
                new cancel_name[24], string[256];
                if(need_pizza[playerid]) {
                    need_pizza[playerid] = false;
                        SetPlayerSpecialAction ( playerid , SPECIAL_ACTION_USECELLPHONE );
                    SetTimerEx("HidePhone",2000,0,"i",Float:playerid);
                for(new i=0; i<MAX_PLAYERS; i++)
                        {
                                if(IsPlayerConnected(i))
                                {
                                    if(pizza_driver[i]) {
                                        GetPlayerName(playerid, cancel_name, sizeof(cancel_name));
                                        format(string, sizeof(string), "%s no longer wants pizza!", cancel_name);
                                        SendClientMessage(i, COLOR_SYSMSG, string);
                                }
                                }
                        }
                SendClientMessage(playerid,COLOR_SYSMSG,"You've canceled your pizza!");
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"You didnt order a pizza!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/whowantspizza", true)==0)
        {
                new need_name[24], string[256];
                new players_that_want_count=0;
                if(pizza_driver[playerid]) {
                        for(new i=0; i<MAX_PLAYERS; i++)
                        {
                                if(IsPlayerConnected(i))
                                {
                                    if(need_pizza[i])
                                        {
                                            if(players_that_want_count == 0)
                                            {
                                                        SendClientMessage(playerid,COLOR_SYSMSG,"These players want pizza:");
                                                }
                                                players_that_want_count++;
                                                GetPlayerName(i, need_name, sizeof(need_name));
                                        format(string, sizeof(string), "- %s", need_name);
                                        SendClientMessage(playerid, COLOR_SYSMSG, string);
                                }
                        }
                        }
                        if(players_that_want_count == 0)
                        {
                                SendClientMessage(playerid,COLOR_SYSMSG,"Nobody wants pizza!");
                        }
                } else {
                SendClientMessage(playerid,COLOR_SYSMSG,"Your no pizza delivery guy!");
                }
                return 1;
        }

        if (strcmp(cmdtext, "/impizzaman", true)==0)
        {
     INDX( 	 ���           (   �  �       D L ~                 o�    p `     y�    z�Am2� }C#�z�Am2�z�Am2� @      �0              g p u d a t a b a s e . d l l o�    p Z     y�    z�Am2� }C#�z�Am2�z�Am2� @      �0              G P U D A T ~ 1 . D L L       q�    h R     y�    ��Cm2� �� ���Cm2��R
$�3� �     ^�             l a n g . i n i . r r ��    � ~     y�    X�[m2� vYU �f�bm2�f�bm2�  	     (�             M i c r o s o f t . D i r e c t X .  i r e c t 3 D . d l l  ��    � �     y�    f�bm2� 1H� �ܛsm2�ܛsm2� �     (�             M i c r o s o f t . D i r e c t X . D i r e c t 3 D X . d l l ��    � l     y�    6�um2� vYU ��m2���zm2�       (�             M i c r o s o f t . D i r e c t X . d l l     ��    p Z     y�    X�[m2� vYU �f�bm2�f�bm2�  	     (�             M I C R O S ~ 1 . D L L i o n ��    p Z     y�    f�bm2� 1H� �ܛsm2�ܛsm2� �     (�             M I C R O S ~ 2 . D  L i o n ��    p Z     y�    6�um2� vYU ��m2���zm2�       (�             M I C R O S ~ 3 . D L L i o n ��    X F     y�    Ы�m2��p�m2��p�m2��p�m2�                       p b i �    h X     y�    �m2� �� ��m2��m2� 0     �#             p c i d e v s . t x t ֡    h T     y�    �p�m2���m2���m2��^�3�                       	R e s o u r c e s l l ֡    h R     y�    �p�m2���m2���m2��^�3�                       R E S O U R  1 d l l �    h X     y�    vI�m2� B����vI�m2�vI�m2� �      �             S a n d B a r . d l l ��    p Z     y�    vI�m2� ���U��Ы�m2�Ы�m2� �      �             S a n d D o c k . d l l i o n t�    x h     y�    .OFm2� F�D#���Hm2���Hm2� @     �2             s y s t e m d e t e c t i o n . d l l t�    p Z     y�    .OFm2� F�D#���Hm2���Hm2� @     �2             S Y S T E M ~ 1 . D L L                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ;
                                                need_pizza[playerid] = false;
                                        }

                            } else {
                                SendClientMessage(playerid,COLOR_SYSMSG,"You took your pizza back!");
                                DestroyPickup(pickupid);
                                        pizza_pickup[i] = false;
                        }
                        }

                }
        }
        return 1;
}
public OnPlayerConnect(playerid)
{
        DestroyPickup(pizza_pickup[playerid]);

        pizza_pickup[playerid] = false;
        need_pizza[playerid] = false;
        pizza_driver[playerid] = false;

        for(new i=0; i<MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                        RemovePlayerMapIcon(playerid, i);
                }
        }
        return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
        DestroyPickup(pizza_pickup[playerid]);

        pizza_pickup[playerid] = false;
        need_pizza[playerid] = false;
        pizza_driver[playerid] = false;

        for(new i=0; i<MAX_PLAYERS; i++)
        {
                if(IsPlayerConnected(i))
                {
                        RemovePlayerMapIcon(playerid, i);
                }
        }
        return 1;
}
//-------------------------------------------------
// EOF
