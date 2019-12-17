/*
	Ingame Map Include V0.1
		for general purposes

	Provides an automated "map dialog"

	You are allowed to use this include for your server.
	You may modify it as much as you like for private use.
	You are not allowed to re-release or sell the original or an edited version without my permission.
	If you use this include, or parts of it for your own script, please dont forget to give me some credits in any way.

And of course do not remove this header.

	Created by Mauzen (msoll(at)web.de), 3.11.2011
*/

// Technical defines
#define MAX_MAPDIALOGS          			(32)
#define INVALID_MAPDIALOG       			(MapDialog:-1)
#define NAVIGATION_UPDATETIME               (50)               // movement updatetime in ms

#define MAPDIALOG_USE_MOUSE                 (true)	// use mouse movement or not

#define MAPDIALOG_RESPONSE_EXIT      		(0)
#define MAPDIALOG_RESPONSE_CLICK     		(1)

// Control defines
#define MAPDIALOG_ZOOMSPEED                 (1.08)
#define MAPDIALOG_SCROLLSPEED               (100.0 / 128.0)
#define MAPDIALOG_MOUSESPEEDMOD             (50.0)	// "Mouse-sensitivity"

// Key defines
#define MAPDIALOG_ZOOM_IN                  	(KEY_YES)
#define MAPDIALOG_ZOOM_OUT                 	(KEY_CTRL_BACK)
#define MAPDIALOG_JUMP_TO_PLAYER            (KEY_SPRINT)
#define MAPDIALOG_EXIT                      (KEY_SECONDARY_ATTACK)


// Control fake-functions
#define IsValidMapDialog(%1)    			(MD_dialogs[_:%1][DIALOG_VALID] & 0b0001)
#define IsMapDialogVisible(%1)    			(MD_dialogs[_:%1][DIALOG_VALID] & 0b0010)
#define IsMapDialogCallbackActive(%1)    	(MD_dialogs[_:%1][DIALOG_VALID] & 0b0100)
#define IsRelockBitSet(%1)    				(MD_dialogs[_:%1][DIALOG_VALID] & 0b1000)
// General fake-functions
#define GetMapDialogOwner(%1)               (MD_dialogs[_:%1][DIALOG_PLAYER])
#define MapDialogSetPlayerPos(%1,%2,%3,%4) \
	SetPlayerPosFindZ(MD_dialogs[_:%1][DIALOG_PLAYER],%2,%3,%4); \
    MD_dialogs[_:%1][DIALOG_VALID] = MD_dialogs[_:%1][DIALOG_VALID] | 0b1000

enum MAPDIALOG_ENUM
{
			DIALOG_VALID,       // (bit 1: valid, bit 2: visible)
			                    // (bit 3: use move callback, bit 4: relock player pos)
			                    // (bit 5: show position TD)
			                    // (bits 16-19: maptd textdraws created)
	Text:   DIALOG_BGTD,
   	Text:	DIALOG_MAPTD[4],
	//Text:	DIALOG_FRAMETD[4],  // unused
	Text:   DIALOG_PLAYERTD,
	Text:   DIALOG_POSTD,
	Text:   DIALOG_HELPTD,
	//Text:   DIALOG_HORLINETD, // unused
	//Text:   DIALOG_VERLINETD, //unused
	Text:   DIALOG_MARKERTD,
			DIALOG_PLAYER,
	Float:  DIALOG_X,
	Float:  DIALOG_Y,
	Float:  DIALOG_ZOOM,
	Float:  DIALOG_ENTERX,      // For locking the player position
	Float:  DIALOG_ENTERY,
	Float:  DIALOG_ENTERZ,
		 	DIALOG_TIMER,
		 	DIALOG_LASTKEYS,
		 	DIALOG_MSG
}


new MD_dialogs[MAX_MAPDIALOGS][MAPDIALOG_ENUM];

new MapDialog:playerdialog[MAX_PLAYERS];        // waste of RAM, but faster



// --------- FORWARDS AND FAKE NATIVES -----------------------------------------

forward MapDialog:CreateMapDialog(playerid, usecallback, showposition, showhelp, msg=0);
forward MapDialog:GetFreeMapDialogSlot();
forward MapDialogUpdate(dialog);

// Callbacks
/*
	Called, when the player performs an non-navigation action.
	params:
	    MapDialog:dialog:       Source MapDialog
	    msg:                    Custom ID for identifying the MapDialog
	    Float:x/y:              Currently focused position of the MapDialog
	    response:               Type of action (EXIT, CLICK)

	return:
		for MAPDIALOG_RESPONSE_EXIT:
		    1: Set the MapDialog to not visible (exit)
		    0: Do nothing (ignore exit attempt)
		for MAPDIALOG_RESPONSE_CLICK:
			ignored
*/
forward OnMapDialogResponse(MapDialog:dialog, msg, Float:x, Float:y, response);

/*
	Called, when the player navigates in the MapDialog (scrolling, zooming)
	params:
	    MapDialog:dialog:       Source MapDialog
	    msg:                    Custom ID for identifying the MapDialog
	    Float:oldx/oldy:        The currently focused position
	    Float:oldzoom:          The current zoomfactor
	    Float:newx/newy:        The position, the owner wants to scroll to
	    Float:newzoom:          The zoomfactor, the owner wants to set.

	return:
		1: Apply navigation-attempt. Focus will move the new position, and zoomfactor will be applied.
		0: Reject navigation-attempt. Focus will stay at the old position and zoomfactor wont change.
*/
forward OnMapDialogNavigation(MapDialog:dialog, msg, Float:oldx, Float:oldy, Float:oldzoom,
								Float:newx, Float:newy, Float:newzoom);

/*
	native MapDialog:CreateMapDialog(playerid, usecallback, showposition, showhelp, msg=0);
	native DestroyMapDialog(MapDialog:dialog);
	native MapDialogScrollTo2D(MapDialog:dialog, Float:x, Float:y, Float:zoom, bool:init=false);
	native SetMapDialogVisible(MapDialog:dialog, visible);

	// Returns the owner of the MapDialog
	native GetMapDialogOwner(MapDialog:dialog);

	// Use this to change the player's position in the callbacks!
	native MapDialogSetPlayerPos(MapDialog:dialog, Float:x, Float:y, Float:z);
*/



// ----------- GENERAL FUNCTIONS -----------------------------------------------


/*
	Creates a new MapDialog
	params:
	    playerid: 		owner
	    usecallback: 	Use the OnMapDialogNavigation callback?
	    showposition: 	Show the position textdraw?
	    showhelp: 		Show the controlhelp textdraw?
	    msg:            Optional ID for identification in callbacks

	return: ID of the MapDialog, INVALID_MAPDIALOG on failure
*/
stock MapDialog:CreateMapDialog(playerid, usecallback, showposition, showhelp, msg=0)
{
	new MapDialog:slot = GetFreeMapDialogSlot();


	if (slot == INVALID_MAPDIALOG) return INVALID_MAPDIALOG;


	// Create black background
	MD_dialogs[_:slot][DIALOG_BGTD] = TextDrawCreate(0, 0, "~n~~n~~n~~n~~n~~n~\
		~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~\
		~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~");
	TextDrawUseBox(MD_dialogs[_:slot][DIALOG_BGTD], true);
	TextDrawBoxColor(MD_dialogs[_:slot][DIALOG_BGTD], 0x000000FF);
	TextDrawTextSize(MD_dialogs[_:slot][DIALOG_BGTD], 640.0, 480.0);

    new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	MapDialogScrollTo2D(slot, x, y, 1.0, true);

    if (showposition)
	{
	    format(txt, 32, "~n~~n~Position: %.2f, %2f", x, y);
		MD_dialogs[_:slot][DIALOG_POSTD] = TextDrawCreate(485, 400, txt);
	    TextDrawLetterSize(MD_dialogs[_:slot][DIALOG_POSTD], 0.3, 0.7);
	    TextDrawUseBox(MD_dialogs[_:slot][DIALOG_POSTD], true);
	    TextDrawBoxColor(MD_dialogs[_:slot][DIALOG_POSTD], 0x44444488);
	    TextDrawSetShadow(MD_dialogs[_:slot][DIALOG_POSTD], 0);
	    TextDrawSetOutline(MD_dialogs[_:slot][DIALOG_POSTD], 1);
	}

	if (showhelp)
	{
		MD_dialogs[_:slot][DIALOG_HELPTD] = TextDrawCreate(460, -10,
			"~n~~n~RMB+mouse / move keys: move~n~LMB: Select position~n~KEY_YES(Z): Zoom in~n~KEY_CTRL_BACK(H): Zoom out~n~KEY_SPRINT: Jump to player pos~n~KEY_SEC_ATTACK(F): Exit");
	    TextDrawLetterSize(MD_dialogs[_:slot][DIALOG_HELPTD], 0.3, 0.7);
	    TextDrawUseBox(MD_dialogs[_:slot][DIALOG_HELPTD], true);
	    TextDrawBoxColor(MD_dialogs[_:slot][DIALOG_HELPTD], 0x44444488);
	    TextDrawSetShadow(MD_dialogs[_:slot][DIALOG_HELPTD], 0);
	    TextDrawSetOutline(MD_dialogs[_:slot][DIALOG_HELPTD], 1);
	}

	MD_dialogs[_:slot][DIALOG_PLAYER] = playerid;
	MD_dialogs[_:slot][DIALOG_MSG] = msg;
	playerdialog[playerid] = slot;
	MD_dialogs[_:slot][DIALOG_VALID] = MD_dialogs[_:slot][DIALOG_VALID] | 0b0001;
	MD_dialogs[_:slot][DIALOG_VALID] = MD_dialogs[_:slot][DIALOG_VALID] | (usecallback << 2);
	MD_dialogs[_:slot][DIALOG_VALID] = MD_dialogs[_:slot][DIALOG_VALID] | (showposition << 4);
	MD_dialogs[_:slot][DIALOG_VALID] = MD_dialogs[_:slot][DIALOG_VALID] | (showhelp << 5);

	return slot;
}


/*
	Destroys the specified MapDialog
	params:
	    MapDialog:dialog:   	The MapDialog to destroy

	return: null
*/
stock DestroyMapDialog(MapDialog:dialog)
{
	SetMapDialogVisible(dialog, false);
	MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] = 0;
}

/*
	Sets the currently focused position of the MapDialog
	params:
	    MapDialog:dialog:       MapDialog to affect
	    Float:x/y:              Position to focus.
	    Float:zoom:             Zoomfactor to set.
	    bool:init:              Internally used only

	return: null
*/
stock MapDialogScrollTo2D(MapDialog:dialog, Float:x, Float:y, Float:zoom, bool:init=false)
{
	new Float:tx, Float:ty, Float:zoff;

	MD_dialogs[_:dialog][DIALOG_ZOOM] = zoom;
	MD_dialogs[_:dialog][DIALOG_X] = x;
	MD_dialogs[_:dialog][DIALOG_Y] = y;

	tx = 320 - 640 * (MD_dialogs[_:dialog][DIALOG_ZOOM]) / 6000 * (x + 3000);
	ty = 240 + 640 * (MD_dialogs[_:dialog][DIALOG_ZOOM]) / 6000 * (y - 3000);
	zoff = 320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM];       // zoom offset


	for (new i = 0; i < 4; i ++)
	{
	    if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (16 + i))
			TextDrawDestroy(MD_dialogs[_:dialog][DIALOG_MAPTD][i]);
	}

	if (tx + zoff > 0 && ty + zoff > 0) // "TD streamer"
	{                                   // Only create TDs that actually are within the screen boundaries
	 	MD_dialogs[_:dialog][DIALOG_MAPTD][0] = TextDrawCreate(tx, ty, "samaps:gtasamapbit1");
		TextDrawFont(MD_dialogs[_:dialog][DIALOG_MAPTD][0], 4);
		TextDrawColor(MD_dialogs[_:dialog][DIALOG_MAPTD][0],0xFFFFFFFF);
		TextDrawTextSize(MD_dialogs[_:dialog][DIALOG_MAPTD][0],
			320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM], 320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM]);
        MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] | 1 << (16 + 0);
	} else {
	    MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] & ~(1 << (16 + 0));
	}

    if (tx + zoff < 640 && ty + zoff > 0)
	{
		MD_dialogs[_:dialog][DIALOG_MAPTD][1] = TextDrawCreate(tx + zoff, ty, "samaps:gtasamapbit2");
		TextDrawFont(MD_dialogs[_:dialog][DIALOG_MAPTD][1], 4);
		TextDrawColor(MD_dialogs[_:dialog][DIALOG_MAPTD][1],0xFFFFFFFF);
		TextDrawTextSize(MD_dialogs[_:dialog][DIALOG_MAPTD][1],
			320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM], 320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM]);
        MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] | 1 << (16 + 1);
	} else {
	    MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] & ~(1 << (16 + 1));
	}

    if (tx + zoff > 0 && ty + zoff < 480)
	{
		MD_dialogs[_:dialog][DIALOG_MAPTD][2] = TextDrawCreate(tx, ty + zoff, "samaps:gtasamapbit3");
		TextDrawFont(MD_dialogs[_:dialog][DIALOG_MAPTD][2], 4);
		TextDrawColor(MD_dialogs[_:dialog][DIALOG_MAPTD][2],0xFFFFFFFF);
		TextDrawTextSize(MD_dialogs[_:dialog][DIALOG_MAPTD][2],
			320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM], 320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM]);
        MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] | 1 << (16 + 2);
	} else {
	    MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] & ~(1 << (16 + 2));
	}

    if (tx + zoff < 640 && ty + zoff < 480)
	{
		MD_dialogs[_:dialog][DIALOG_MAPTD][3] = TextDrawCreate(tx + zoff, ty + zoff, "samaps:gtasamapbit4");
		TextDrawFont(MD_dialogs[_:dialog][DIALOG_MAPTD][3], 4);
		TextDrawColor(MD_dialogs[_:dialog][DIALOG_MAPTD][3],0xFFFFFFFF);
		TextDrawTextSize(MD_dialogs[_:dialog][DIALOG_MAPTD][3],
			320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM], 320.0 * MD_dialogs[_:dialog][DIALOG_ZOOM]);
		MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] | 1 << (16 + 3);
	} else {
	    MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] & ~(1 << (16 + 3));
	}

	if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (4))
	{
		format(txt, 64, "~n~~n~Position: %.2f, %.2f", x, y);
		TextDrawSetString(MD_dialogs[_:dialog][DIALOG_POSTD], txt);
	}


    if (!init) TextDrawDestroy(MD_dialogs[_:dialog][DIALOG_MARKERTD]);
	MD_dialogs[_:dialog][DIALOG_MARKERTD] = TextDrawCreate(316.0, 235.0, "O");
	TextDrawLetterSize(MD_dialogs[_:dialog][DIALOG_MARKERTD], 0.3, 1.0);
	TextDrawSetShadow(MD_dialogs[_:dialog][DIALOG_MARKERTD], 0);
	TextDrawColor(MD_dialogs[_:dialog][DIALOG_MARKERTD], 0xFF000099);

	SetMapDialogVisible(dialog, IsMapDialogVisible(dialog));
}

/*
	Toggles the visibility/activity of a MapDialog. A MapDialog can only be
	shown to its owner.
	params:
	    MapDialog:dialog:       MapDialog to affect
	    visible:                Should be visible?

	return: null
*/
stock SetMapDialogVisible(MapDialog:dialog, visible)
{
	if (!IsValidMapDialog(dialog)) return;
	if (visible)
	{
	    GetPlayerPos(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_ENTERX],
	                MD_dialogs[_:dialog][DIALOG_ENTERY], MD_dialogs[_:dialog][DIALOG_ENTERZ]);
	    TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_BGTD]);
	    for (new i = 0; i < 4; i++)
			if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (16 + i))
				TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_MAPTD][i]);
        if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (4))
	    	TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_POSTD]);
	    if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (5))
			TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_HELPTD]);
	    //TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][0]);
	    //TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][1]);
	    //TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][2]);
	    //TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][3]);
		//TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_PLAYERTD]);
		//TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_HORLINETD]);
	    //TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_VERLINETD]);
	    TextDrawShowForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_MARKERTD]);
	    if (!IsMapDialogVisible(dialog)) MD_dialogs[_:dialog][DIALOG_TIMER] = SetTimerEx("MapDialogUpdate", NAVIGATION_UPDATETIME, 1, "i", _:dialog);
	    MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] | 0b0010;
	} else {
	    TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_BGTD]);
	    for (new i = 0; i < 4; i++)
			if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (16 + i))
				TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_MAPTD][i]);
	    if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (4))
			TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_POSTD]);
        if (MD_dialogs[_:dialog][DIALOG_VALID] & 1 << (5))
			TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_HELPTD]);
	    //TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][0]);
	    //TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][1]);
	    //TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][2]);
	    //TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_FRAMETD][3]);
		//TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_PLAYERTD]);
		//TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_HORLINETD]);
	    //TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_VERLINETD]);
	    TextDrawHideForPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_MARKERTD]);
		if (IsMapDialogVisible(dialog)) KillTimer(MD_dialogs[_:dialog][DIALOG_TIMER]);
		MD_dialogs[_:dialog][DIALOG_VALID] = MD_dialogs[_:dialog][DIALOG_VALID] & ~0b0010;
	}
}



// ---------------- INTERNALS --------------------------------------------------

stock MapDialog:GetFreeMapDialogSlot()
{
	for (new i = 0; i < MAX_MAPDIALOGS; i++)
	{
	    if (!IsValidMapDialog(i)) return MapDialog:i;
	}
	return INVALID_MAPDIALOG;
}

public MapDialogUpdate(dialog)
{
	new ud, lr, keys, updated;
	GetPlayerKeys(MD_dialogs[dialog][DIALOG_PLAYER], keys, ud, lr);

	if (!IsRelockBitSet(dialog))
	{
		SetPlayerPos(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_ENTERX],
	                MD_dialogs[_:dialog][DIALOG_ENTERY], MD_dialogs[_:dialog][DIALOG_ENTERZ]);
	} else {
	    GetPlayerPos(MD_dialogs[_:dialog][DIALOG_PLAYER], MD_dialogs[_:dialog][DIALOG_ENTERX],
	                MD_dialogs[_:dialog][DIALOG_ENTERY], MD_dialogs[_:dialog][DIALOG_ENTERZ]);
	}

	#if (MAPDIALOG_USE_MOUSE == true)
	    if (keys & KEY_HANDBRAKE)
	    {
			new Float:vx, Float:vy, Float:vz;
			GetPlayerCameraFrontVector(MD_dialogs[_:dialog][DIALOG_PLAYER], vx, vy, vz);
			if (lr == 0 && ud == 0)
			{
				lr = floatround(atan2(vx, vy) * MAPDIALOG_MOUSESPEEDMOD);
				ud = floatround((asin(vz) + 2.864789) * -MAPDIALOG_MOUSESPEEDMOD);
				if (lr > 512) lr = 512;
				if (lr < -512) lr = -512;
				if (ud > 512) ud = 512;
				if (ud < -512) ud = -512;
			}
		}
		SetCameraBehindPlayer(MD_dialogs[_:dialog][DIALOG_PLAYER]);
		SetPlayerFacingAngle(MD_dialogs[_:dialog][DIALOG_PLAYER], 0.0);
	#endif


	new Float:x = MD_dialogs[dialog][DIALOG_X],
		Float:y = MD_dialogs[dialog][DIALOG_Y],
		Float:zoom = MD_dialogs[dialog][DIALOG_ZOOM];

	if (ud != 0)
	{
	    y -= MAPDIALOG_SCROLLSPEED / MD_dialogs[dialog][DIALOG_ZOOM]  * ud;
	    updated = true;
	}

	if (lr != 0)
	{
	    x += MAPDIALOG_SCROLLSPEED / MD_dialogs[dialog][DIALOG_ZOOM] * lr;
	    updated = true;
	}

	if (keys & MAPDIALOG_ZOOM_OUT)
	{
	    zoom *= (1 / MAPDIALOG_ZOOMSPEED);
	    updated = true;
	} else if (keys & MAPDIALOG_ZOOM_IN)
	{
	    zoom *= MAPDIALOG_ZOOMSPEED;
	    updated = true;
	}
	if (keys & MAPDIALOG_JUMP_TO_PLAYER)
	{
		new Float:z;
		GetPlayerPos(MD_dialogs[dialog][DIALOG_PLAYER], x, y, z);
        updated = true;
	}

	if ((keys & KEY_FIRE) && !(MD_dialogs[dialog][DIALOG_LASTKEYS] & KEY_FIRE))
	{
	    CallLocalFunction("OnMapDialogResponse", "iIffi", dialog,
		MD_dialogs[dialog][DIALOG_MSG], x, y, MAPDIALOG_RESPONSE_CLICK);
	}

	if (keys & MAPDIALOG_EXIT)
	{
	    if (CallLocalFunction("OnMapDialogResponse", "iiffi", dialog,
			MD_dialogs[dialog][DIALOG_MSG], x, y, MAPDIALOG_RESPONSE_EXIT))
		{
	    	SetMapDialogVisible(MapDialog:dialog, false);
		}
	}

	if (zoom < 0.6) zoom = 0.6;
	if (x > 3000.0) x = 3000.0;
	if (y > 3000.0) y = 3000.0;
	if (x < -3000.0) x = -3000.0;
	if (y < -3000.0) y = -3000.0;

	if (updated)
	{
		if (IsMapDialogCallbackActive(dialog))
		{
		    if (CallLocalFunction("OnMapDialogNavigation", "iiffffff",
		        _:dialog, MD_dialogs[dialog][DIALOG_MSG],
		        MD_dialogs[dialog][DIALOG_X], MD_dialogs[dialog][DIALOG_Y], MD_dialogs[dialog][DIALOG_ZOOM],
		        x, y, zoom))
			{
			    MapDialogScrollTo2D(MapDialog:dialog, x, y, zoom);
			}
		} else
		{
			MapDialogScrollTo2D(MapDialog:dialog, x, y, zoom);
		}
	}

	MD_dialogs[dialog][DIALOG_LASTKEYS] = keys;
}