/*
      __________             .___.__
  ____\______   \_____     __| _/|__| ____
 /    \|       _/\__  \   / __ | |  |/  _ \
|   |  \    |   \ / __ \_/ /_/ | |  (  <_> )
|___|  /____|_  /(____  /\____ | |__|\____/ v0.1
     \/       \/      \/      \/

    Credits:
    Incognito (http://forum.sa-mp.com/member.php?u=925) (Audio Plugin)
    Norn (Scott Davey) (http://forum.sa-mp.com/member.php?u=33812)

Useful Links:
http://www.internet-radio.org.uk    (Internet Radio List)
http://forum.sa-mp.com/showthread.php?t=82162 (Audio Plugin)
*/

#include <a_samp>
#include <audio>

#define NRMAX_RADIOS  500
#define NRMAX_CATEGORIES  15
#define NRINVALID_RADIO_ID    -1
#define NRMAX_CATEGORY_LENGTH 50
#define NRMAX_RADIO_LENGTH    50
#define NRMAX_STREAM_URL_LENGTH   128
#define NRCATEGORIES_DIALOG_ID    1553
#define NRRADIO_DIALOG_ID 1552

enum nRadioItem
{
    nrCategoryID,
    nrTitle[NRMAX_RADIO_LENGTH],
    nrStreamURL[NRMAX_STREAM_URL_LENGTH]
}
new RadioItem[NRMAX_RADIOS][nRadioItem], nCategories[NRMAX_RADIOS][NRMAX_CATEGORY_LENGTH], nrCATEGORY_COUNT = 0, nrRADIO_COUNT = 0, nrDIALOG_STRING[1028], nrTextString[128];

forward RadioAdd(categoryid, name[NRMAX_RADIO_LENGTH], streamurl[NRMAX_STREAM_URL_LENGTH]);
forward RadioAddCategory(name[NRMAX_CATEGORY_LENGTH]);
forward RadioInitDialog(playerid);
forward RadioStop(playerid);
forward RadioPlay(playerid, radioid);
forward DeleteCategory(categoryid);
forward ModifyCategory(categoryid, name[NRMAX_CATEGORY_LENGTH]);
forward ModifyRadio(radioid, name[NRMAX_RADIO_LENGTH], streamurl[NRMAX_STREAM_URL_LENGTH]);
forward DeleteRadio(radioid);
forward RadioCountFromCategory(categoryid);
forward CategoryIDFromDialogOrder(listitem);
forward RadioCategoryBrowse(playerid, listitem);
forward RadioIDFromDialogOrder(playerid, listitem);
forward nRadio_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
forward RadioSetVolume(playerid, volume);

public RadioAddCategory(name[NRMAX_CATEGORY_LENGTH])
{
    new CATEGORY_ID = NRINVALID_RADIO_ID, bool:breakloop = false;
    if(strlen(name) >= 1 && strlen(name) <= NRMAX_CATEGORY_LENGTH) {
        if(nrCATEGORY_COUNT < NRMAX_CATEGORIES) {
            for(new i=0;i<NRMAX_CATEGORIES;i++) {
                if(!breakloop) {
                    if(!strlen(nCategories[i])) {
                        format(nCategories[i], NRMAX_CATEGORY_LENGTH, name);
                        CATEGORY_ID = i;
                        printf("[nRadio:] Category ID %d (%s) created.", CATEGORY_ID, nCategories[i]);
                        nrCATEGORY_COUNT++;
                        breakloop = true;
                    }
                }
            }
        }
    }
    return CATEGORY_ID;
}


public RadioAdd(categoryid, name[NRMAX_RADIO_LENGTH], streamurl[NRMAX_STREAM_URL_LENGTH])
{
    new bool:breakloop = false, RADIO_ID = -1;
    if(strlen(name) >= 1 && strlen(name) <= NRMAX_RADIO_LENGTH) {
        if(nrRADIO_COUNT < NRMAX_RADIOS) {
            for(new i=0;i<NRMAX_RADIOS;i++) {
                if(!breakloop) {
                    if(!strlen(RadioItem[i][nrTitle])) {
                        RadioItem[i][nrCategoryID] = categoryid;
                        format(RadioItem[i][nrTitle], NRMAX_RADIO_LENGTH, name);
                        format(RadioItem[i][nrStreamURL], NRMAX_STREAM_URL_LENGTH, streamurl);
                        printf("[nRadio:] Radio ID %d (%s) created and attached to %s.", i, RadioItem[i][nrTitle], nCategories[categoryid]);
                        breakloop = true;
                        nrRADIO_COUNT++;
                    }
                }
            }
        }
    }
    return RADIO_ID;
}


public RadioInitDialog(playerid)
{
	format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), "");
    for(new i=0;i<nrCATEGORY_COUNT;i++) {
        if(!i) {
            if(strlen(nCategories[i]) >= 1)
                format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), nCategories[i]);
        }
        else {
            if(strlen(nCategories[i]) >= 1)
                format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), "%s\n%s", nrDIALOG_STRING, nCategories[i]);
        }
    }
    if(strlen(nrDIALOG_STRING) >= 1) { ShowPlayerDialog(playerid, NRCATEGORIES_DIALOG_ID, DIALOG_STYLE_LIST, "Radio - Browse Categories", nrDIALOG_STRING, "Browse", "Cancel"); }
    return true;
}


stock RadioCategoryNameFromID(categoryid)
{
    new category_name[NRMAX_CATEGORY_LENGTH];
    format(category_name, sizeof(category_name), nCategories[categoryid]);
    return category_name;
}


stock RadioNameFromID(radioid)
{
    new radio_name[NRMAX_RADIO_LENGTH];
    format(radio_name, sizeof(radio_name), RadioItem[radioid][nrTitle]);
    return radio_name;
}


public RadioStop(playerid)
{
    if(GetPVarInt(playerid, "radioStream") != 0){Audio_Stop(playerid, GetPVarInt(playerid, "radioStream"));DeletePVar(playerid, "radioStream");}
    return true;
}


public RadioSetVolume(playerid, volume)
{
    SetPVarInt(playerid, "radioVolume", volume);
    Audio_SetVolume(playerid, GetPVarInt(playerid, "radioStream"), GetPVarInt(playerid, "radioVolume"));
    return true;
}


public RadioPlay(playerid, radioid)
{
    RadioStop(playerid);
    if(!GetPVarInt(playerid, "radioVolume")) { SetPVarInt(playerid, "radioVolume", 100); }
    SetPVarInt(playerid, "radioStream", Audio_PlayStreamed(playerid, RadioItem[radioid][nrStreamURL],false,false,false));
    Audio_SetVolume(playerid, GetPVarInt(playerid, "radioStream"), GetPVarInt(playerid, "radioVolume"));
    return true;
}


public DeleteCategory(categoryid)
{
    format(nCategories[categoryid], NRMAX_CATEGORY_LENGTH, "");
    for(new i=0;i<nrRADIO_COUNT;i++) {
        if(RadioItem[i][nrCategoryID] == categoryid && strlen(RadioItem[i][nrTitle]) >= 1) {
                                                  // Deleting all the radios attached to the category so the slot can be used.
            format(RadioItem[i][nrTitle], NRMAX_RADIO_LENGTH, "");
            nrRADIO_COUNT--;
        }
    }
    nrCATEGORY_COUNT--;
    return true;
}


public ModifyCategory(categoryid, name[NRMAX_CATEGORY_LENGTH])
{
    format(nCategories[categoryid], NRMAX_RADIO_LENGTH, name);
    return true;
}


public ModifyRadio(radioid, name[NRMAX_RADIO_LENGTH], streamurl[NRMAX_STREAM_URL_LENGTH])
{
    format(RadioItem[radioid][nrTitle], NRMAX_RADIO_LENGTH, name);
    format(RadioItem[radioid][nrStreamURL], NRMAX_RADIO_LENGTH, streamurl);
    return true;
}


public DeleteRadio(radioid)
{
    format(RadioItem[radioid][nrTitle], NRMAX_RADIO_LENGTH, "");
    nrRADIO_COUNT--;
    return true;
}


public RadioCountFromCategory(categoryid)
{
    new count = 0;
    for(new i=0;i<nrRADIO_COUNT;i++) {
        if(RadioItem[i][nrCategoryID] == categoryid && strlen(RadioItem[i][nrTitle]) >= 1) {
            count++;
        }
    }
    return count;
}


public CategoryIDFromDialogOrder(listitem)
{
    new current_array_id, bool:breakloop = false, id = -1;
    for(new i=0;i<nrCATEGORY_COUNT;i++) {
        if(strlen(nCategories[i]) >= 1) {
            if(!breakloop) {
                if(current_array_id == listitem) {
                    id = i;
                    breakloop = true;
                }
                current_array_id++;
            }
        }
    }
    return id;
}


public RadioIDFromDialogOrder(playerid, listitem)
{
    new categoryid = GetPVarInt(playerid, "radioCategory"), current_array_id, bool:breakloop = false, id = -1;
    for(new i=0;i<nrRADIO_COUNT;i++) {
        if(RadioItem[i][nrCategoryID] == categoryid && strlen(RadioItem[i][nrTitle]) >= 1) {
            if(!breakloop) {
                if(current_array_id == listitem) {
                    id = i;
                    breakloop = true;
                }
                current_array_id++;
            }
        }
    }
    return id;
}


public RadioCategoryBrowse(playerid, listitem)
{
    format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), "");
    new categoryid = CategoryIDFromDialogOrder(listitem);
    SetPVarInt(playerid, "radioCategory", categoryid);
    if(RadioCountFromCategory(categoryid) >= 1) {
        for(new i=0;i<nrRADIO_COUNT;i++) {
            if(RadioItem[i][nrCategoryID] == categoryid) {
                if(!i) {
                    if(strlen(RadioItem[i][nrTitle]) >= 1)
                        format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), RadioItem[i][nrTitle]);
                }
                else {
                    if(strlen(RadioItem[i][nrTitle]) >= 1)
                        format(nrDIALOG_STRING, sizeof(nrDIALOG_STRING), "%s\n%s", nrDIALOG_STRING, RadioItem[i][nrTitle]);
                }
            }
        }
        new dialog_title[100];
        format(dialog_title, sizeof(dialog_title), "Radio - %s", nCategories[categoryid]);
        if(strlen(nrDIALOG_STRING) >= 1) { ShowPlayerDialog(playerid, NRRADIO_DIALOG_ID, DIALOG_STYLE_LIST, dialog_title, nrDIALOG_STRING, "Stream", "Go Back"); }
    }
    else {
        format(nrTextString, sizeof(nrTextString), "[nRadio:] No stations exist in category ' %s '.", RadioCategoryNameFromID(categoryid));
        SendClientMessage(playerid, 0xFF0000FF, nrTextString);
        RadioInitDialog(playerid);
    }
    return true;
}


public nRadio_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid) {
        case NRRADIO_DIALOG_ID:
        {
            if(response) {
                new radioid = RadioIDFromDialogOrder(playerid, listitem);
                RadioPlay(playerid, radioid);
                format(nrTextString,sizeof(nrTextString),"[nRadio:] Stream for %s started.", RadioNameFromID(radioid));
                SendClientMessage(playerid, 0xADD8E6FF, nrTextString);
            }
            else {
                RadioInitDialog(playerid);
            }
        }
        case NRCATEGORIES_DIALOG_ID:
        {
            if(response) {
                RadioCategoryBrowse(playerid, listitem);
            }
        }
    }
    return 1;
}

