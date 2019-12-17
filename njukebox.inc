#include <a_samp>
#define MAX_JUKEBOXES   100
#define MAX_JUKEBOX_ITEMS   50
#define MAX_JB_STREAM_URL   100
#define MAX_JB_STREAM_T 60
#define JUKEBOX_MAX_ITEMS_A MAX_JUKEBOXES * MAX_JUKEBOX_ITEMS
#define JUKEBOX_DIALOG  5483
forward JukeBoxDialog(playerid, jukeboxid);
forward CreateJukebox(Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, pps, Float:stream_distance);
forward AttachStreamToJukebox(jukeboxid, streamtitle[MAX_JB_STREAM_T], streamurl[MAX_JB_STREAM_URL]);
forward JukeBoxItemExists(id);
forward JukeBoxExists(id);
forward DestroyJukebox(id);
forward DestroyJukeboxItem(id);
forward SetJukeboxPos(id, Float:x, Float:y, Float:z);
forward SetJukeboxRot(id, Float:x, Float:y, Float:z);
forward SetJukeboxItemStream(id, newstream[MAX_JB_STREAM_T]);
forward SetJukeboxItemTitle(id, newtitle[MAX_JB_STREAM_T]);
forward SetJukeboxItemOwner(id, jukeboxid);
forward SetJukeboxPricePerSong(id, price);
forward SetJukeboxStreamDistance(id, Float:stream_distance);
enum _JukeBoxItem
{
    jbiOwnerID,
    jbiStreamURL[MAX_JB_STREAM_URL],
    jbiStreamTitle[MAX_JB_STREAM_T],
    jbiOrder
}
enum _JukeBox
{
    Float:jbX,
    Float:jbY,
    Float:jbZ,
    Float:jbRotX,
    Float:jbRotY,
    Float:jbRotZ,
    jbPPS,
    jbObjID,
    jbItemsLoaded,
    Float:jbStreamDistance
}
new JukeBox[MAX_JUKEBOXES][_JukeBox],   JukeBoxItem[JUKEBOX_MAX_ITEMS_A][_JukeBoxItem];
public SetJukeboxItemStream(id, newstream[MAX_JB_STREAM_T])
{
    if(JukeBoxItemExists(id)) {
        format(JukeBoxItem[id][jbiStreamURL], MAX_JB_STREAM_URL, newstream);
        return true;
    }
    return false;
}
public SetJukeboxStreamDistance(id, Float:stream_distance)
{
    if(JukeBoxExists(id)) {
        JukeBox[id][jbStreamDistance] = stream_distance;
        return true;
    }
    return false;
}
public SetJukeboxItemTitle(id, newtitle[MAX_JB_STREAM_T])
{
    if(JukeBoxItemExists(id)) {
        format(JukeBoxItem[id][jbiStreamTitle], MAX_JB_STREAM_T, newtitle);
        return true;
    }
    return false;
}
public SetJukeboxItemOwner(id, jukeboxid)
{
    if(JukeBoxItemExists(id) && JukeBoxExists(jukeboxid)) {
        JukeBoxItem[id][jbiOwnerID] = jukeboxid;
        return true;
    }
    return false;
}
public SetJukeboxRot(id, Float:x, Float:y, Float:z)
{
    if(JukeBoxExists(id)) {
        JukeBox[id][jbRotX] = x, JukeBox[id][jbRotY] = y, JukeBox[id][jbRotZ] = z;
        SetObjectRot(JukeBox[id][jbObjID], JukeBox[id][jbRotX], JukeBox[id][jbRotY], JukeBox[id][jbRotZ]);
        return true;
    }
    return false;
}
public SetJukeboxPricePerSong(id, price)
{
    if(JukeBoxExists(id)) {
        JukeBox[id][jbPPS] = price;
        return true;
    }
    return false;
}
public SetJukeboxPos(id, Float:x, Float:y, Float:z)
{
    if(JukeBoxExists(id)) {
        DestroyObject(JukeBox[id][jbObjID]);
        JukeBox[id][jbX] = x, JukeBox[id][jbY] = y, JukeBox[id][jbZ] = z;
        JukeBox[id][jbObjID] = CreateObject(2618, JukeBox[id][jbX], JukeBox[id][jbY], JukeBox[id][jbZ], JukeBox[id][jbRotX], JukeBox[id][jbRotY], JukeBox[id][jbRotZ]);
        return true;
    }
    return false;
}
public DestroyJukebox(id)
{
    if(JukeBoxExists(id)) {
        for(new i = 0; i < JUKEBOX_MAX_ITEMS_A; i++) {
            if(JukeBoxItemExists(i)) {
                if(JukeBoxItem[i][jbiOwnerID] == id) {
                    DestroyJukeboxItem(id);
                }
            }
        }
        JukeBox[id][jbX] = 0, JukeBox[id][jbY] = 0, JukeBox[id][jbZ] = 0, JukeBox[id][jbRotX] = 0, JukeBox[id][jbRotY] = 0, JukeBox[id][jbRotZ] = 0, JukeBox[id][jbPPS] = 0, JukeBox[id][jbStreamDistance] = 0, JukeBox[id][jbItemsLoaded] = 0;
        DestroyObject(JukeBox[id][jbObjID]);
        return true;
    }
    return false;
}
public DestroyJukeboxItem(id)
{
    if(JukeBoxItemExists(id)) {
        JukeBox[JukeBoxItem[id][jbiOwnerID]][jbItemsLoaded]--;
        format(JukeBoxItem[id][jbiStreamTitle], MAX_JB_STREAM_T, "");
        format(JukeBoxItem[id][jbiStreamURL], MAX_JB_STREAM_URL, "");
        JukeBoxItem[id][jbiOwnerID] = 0;
        JukeBoxItem[id][jbiOrder] = 0;
        return true;
    }
    return false;
}
public CreateJukebox(Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz, pps, Float:stream_distance)
{
    new id = JB_Array_Space();
    if(id != -1) {
        JukeBox[id][jbX] = x, JukeBox[id][jbY] = y, JukeBox[id][jbZ] = z, JukeBox[id][jbRotX] = rotx, JukeBox[id][jbRotY] = roty, JukeBox[id][jbRotZ] = rotz, JukeBox[id][jbPPS] = pps, JukeBox[id][jbStreamDistance] = stream_distance;
        JukeBox[id][jbObjID] = CreateObject(2618, JukeBox[id][jbX], JukeBox[id][jbY], JukeBox[id][jbZ], JukeBox[id][jbRotX], JukeBox[id][jbRotY], JukeBox[id][jbRotZ]);
    }
    return id;
}
public AttachStreamToJukebox(jukeboxid, streamtitle[MAX_JB_STREAM_T], streamurl[MAX_JB_STREAM_URL])
{
    if(JukeBoxExists(jukeboxid)) {
        if(JukeBox[jukeboxid][jbItemsLoaded] < MAX_JUKEBOX_ITEMS) {
            new id = JBI_Array_Space();
            if(id != -1) {
                format(JukeBoxItem[id][jbiStreamTitle], MAX_JB_STREAM_T, streamtitle);
                format(JukeBoxItem[id][jbiStreamURL], MAX_JB_STREAM_URL, streamurl);
                JukeBoxItem[id][jbiOwnerID] = jukeboxid;
                printf("[nJukebox:] Attached %s to jukebox id %d.", JukeBoxItem[id][jbiStreamTitle], jukeboxid);
                JukeBoxItem[id][jbiOrder] = JukeBox[jukeboxid][jbItemsLoaded];
                JukeBox[jukeboxid][jbItemsLoaded]++;
                return id;
            }
        }
    }
    return -1;
}
stock JBI_Array_Space()
{
    for(new s = 0; s < JUKEBOX_MAX_ITEMS_A; s++) {
        if(!JukeBoxItemExists(s)) {
            return s;
        }
    }
    return -1;
}
stock JB_Array_Space()
{
    for(new s = 0; s < MAX_JUKEBOXES; s++) {
        if(!JukeBoxExists(s)) {
            return s;
        }
    }
    return -1;
}
public JukeBoxItemExists(id)
{
    if(!strlen(JukeBoxItem[id][jbiStreamURL])) {    return false;   }
    return true;
}
public JukeBoxExists(id)
{
    if(!JukeBox[id][jbX] && !JukeBox[id][jbY] && !JukeBox[id][jbZ]) {   return false;   }
    return true;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid) {
        case JUKEBOX_DIALOG:
        {
            PlayerPlaySound(playerid, 5205, 0.0, 0.0, 0.0);
            if(response) {
                for(new i = 0; i < JUKEBOX_MAX_ITEMS_A; i++) {
                    new jukeboxid = GetPVarInt(playerid, "jukeboxID");
                    if(JukeBoxItemExists(i)) {
                        if(JukeBoxItem[i][jbiOwnerID] == jukeboxid) {
                            if(JukeBoxItem[i][jbiOrder] == listitem) {
                                if(GetPlayerMoney(playerid) >= JukeBox[jukeboxid][jbPPS]) {
                                    GivePlayerMoney(playerid, -JukeBox[jukeboxid][jbPPS]);
                                    new now_playing[128], np_name[MAX_PLAYER_NAME];
                                    GetPlayerName(playerid, np_name, MAX_PLAYER_NAME);
                                    format(now_playing, sizeof(now_playing), "JUKEBOX: {FFFFFF}%s {ADD8E6}[Selected by {FFFFFF}%s(%d){ADD8E6}]", JukeBoxItem[i][jbiStreamTitle], np_name, playerid);
                                    for(new pid = 0; pid < MAX_PLAYERS; pid++) {
                                        if(IsPlayerConnected(pid) && IsPlayerInRangeOfPoint(pid, JukeBox[jukeboxid][jbStreamDistance], JukeBox[jukeboxid][jbX], JukeBox[jukeboxid][jbY], JukeBox[jukeboxid][jbZ])) {
                                            PlayAudioStreamForPlayer(pid, JukeBoxItem[i][jbiStreamURL], JukeBox[jukeboxid][jbX], JukeBox[jukeboxid][jbY], JukeBox[jukeboxid][jbZ], JukeBox[jukeboxid][jbStreamDistance], 1);
                                            SendClientMessage(pid, 0xADD8E6FF, now_playing);

                                        }
                                    }
                                    DeletePVar(playerid,"jukeboxID");
                                    return true;
                                }
                                else {
                                    new jbrs[128];
                                    format(jbrs, sizeof(jbrs), "[ERROR:] You don't have enough money to play this song! [$%d]", JukeBox[i][jbPPS]);
                                    return SendClientMessage(playerid, 0xADD8E6FF, jbrs);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (inputtext[0]) return CallLocalFunction("NJB_OnDialogResponse","iiiis",playerid,dialogid,response,listitem,inputtext);
    else return CallLocalFunction("NJB_OnDialogResponse","iiiis",playerid,dialogid,response,listitem,"\1\0");
}
#if defined _ALS_OnDialogResponse
#undef OnDialogResponse
#else
#define _ALS_OnDialogResponse
#endif
#define OnDialogResponse NJB_OnDialogResponse
forward NJB_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]);
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if (newkeys & KEY_SECONDARY_ATTACK) {
        for(new s = 0; s < MAX_JUKEBOXES; s++) {
            if(JukeBoxExists(s)) {
                if(IsPlayerInRangeOfPoint(playerid, 1.5, JukeBox[s][jbX], JukeBox[s][jbY], JukeBox[s][jbZ])) {
                    new Float:Px, Float:Py, Float: Pa;
                    GetPlayerPos(playerid, Px, Py, Pa);
                    Pa = floatabs(atan((JukeBox[s][jbY]-Py)/(JukeBox[s][jbX]-Px)));
                    if (JukeBox[s][jbX] <= Px && JukeBox[s][jbY] >= Py) Pa = floatsub(180, Pa);
                    else if (JukeBox[s][jbX] < Px && JukeBox[s][jbY] < Py) Pa = floatadd(Pa, 180);
                    else if (JukeBox[s][jbX] >= Px && JukeBox[s][jbY] <= Py) Pa = floatsub(360.0, Pa);
                    Pa = floatsub(Pa, 90.0);
                    if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
                    SetPlayerFacingAngle(playerid, Pa);
                    ApplyAnimation(playerid,"GANGS","DRUGS_BUY",3.00,0,0,0,0,0,0);
                    SetTimerEx("JukeBoxDialog", 1500, false, "ii", playerid, s);
                    PlayerPlaySound(playerid, 5205, 0.0, 0.0, 0.0);
                }
            }
        }
    }
    return CallLocalFunction("NJB_OnPlayerKeyStateChange", "iii", playerid, newkeys, oldkeys);
}
#if defined _ALS_OnPlayerKeyStateChange
#undef OnPlayerKeyStateChange
#else
#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange NJB_OnPlayerKeyStateChange
forward NJB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
public JukeBoxDialog(playerid, jukeboxid)
{
    if(JukeBoxExists(jukeboxid) && IsPlayerConnected(playerid)) {
        new ddata[1028], ptext[70], loaded;
        for(new i = 0; i < JUKEBOX_MAX_ITEMS_A; i++) {
            if(JukeBoxItemExists(i)) {
                if(JukeBoxItem[i][jbiOwnerID] == jukeboxid) {
                    if(loaded == JukeBox[jukeboxid][jbItemsLoaded]) { return true; }
                    format( ddata, sizeof(ddata), "%s\n{37DB45}%d.	{FFFFFF}%s", ddata, loaded+1, JukeBoxItem[i][jbiStreamTitle]);
                    loaded++;
                }
            }
        }
        if(strlen(ddata) >= 1) {    format(ptext, sizeof(ptext), "{FFFFFF}Jukebox %d - {37DB45}$ %d {FFFFFF}Per Song", jukeboxid, JukeBox[jukeboxid][jbPPS]), ShowPlayerDialog(playerid, JUKEBOX_DIALOG, DIALOG_STYLE_LIST, ptext, ddata, "Play Song", "Cancel"), SetPVarInt(playerid, "jukeboxID", jukeboxid); }
    }
    return true;
}
