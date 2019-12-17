/*----------------------------------------------------------------------------*-
                              ===================
                               YSI - Master Core
                              ===================
Description:
	There seems to be a bug with a compiler when using #emit in files included
	more than once, so this code has been moved to a file only included once.
Legal:
	Version: MPL 1.1
	
	The contents of this file are subject to the Mozilla Public License Version 
	1.1 (the "License"); you may not use this file except in compliance with 
	the License. You may obtain a copy of the License at 
	http://www.mozilla.org/MPL/
	
	Software distributed under the License is distributed on an "AS IS" basis,
	WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
	for the specific language governing rights and limitations under the
	License.
	
	The Original Code is the SA:MP script information include.
	
	The Initial Developer of the Original Code is Alex "Y_Less" Cole.
	Portions created by the Initial Developer are Copyright (C) 2008
	the Initial Developer. All Rights Reserved.
	
	Contributors:
		ZeeX, koolk
	
	Thanks:
		Peter, Cam - Support.
		ZeeX - Very productive conversations.
		koolk - IsPlayerinAreaEx code.
		TheAlpha - Danish translation.
		breadfish - German translation.
		Fireburn - Dutch translation.
		yom - French translation.
		50p - Polish translation.
		Zamaroht - Spanish translation.
		Dracoblue, sintax, mabako, Xtreme, other coders - Producing other modes
			for me to strive to better.
		Pixels^ - Running XScripters where the idea was born.
		Matite - Pestering me to release it and using it.
	
	Very special thanks to:
		Thiadmer - PAWN.
		Kye/Kalcor - SA:MP.
		SA:MP Team past, present and future - SA:MP.
Version:
	0.2
Changelog:
	07/08/10:
		Split in to y_masteronce.
		Added assembly for publics scanning.
	06/08/10:
		Managed the ultimate - got completely transparent inclusion!
	05/08/10:
		Completed new master system, now does all syncing and clients.
	06/10/09:
		Rewrote using states.
		Added remote function macros.
		Reduced the number of masters to a single one.  It must have them all.
		Vastly simplified the master model - ending the master ends everything.
	06/01/08:
		Added code to not pass data if no other script exists.
	17/11/07:
		Added code for a script to remove itself from the global list.
	11/10/07:
		Not first version but added documentation months late.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		-
	Static:
		-
	Inline:
		-
	API:
		-
	Hooks:
		OnGameModeInit
		OnGameModeExit
Callbacks:
	-
Definitions:
	-
Enums:
	-
Macros:
	-
Tags:
	-
Variables:
	Global:
		_@ - ID of this script.
	Static:
		-
Commands:
	-
Compile options:
	-
Operators:
	-
Natives:
	W@ - Renaming of CallRemoteFunction for size reasons.
	V@ - Renaming of getproperty for size reasons.
	S@ - Renaming of setproperty for size reasons.
-*----------------------------------------------------------------------------*/

// These parts should only be defined once ever.  This code is not dependent on
// the current MASTER value, it's all generic.

#include <YSI\y_debug>

#define YSIM_MASTER #M

#define YSIM_RETURN #R

#define YSIM_CALLER #C

#define YSIM_STRING (42)

// Public variable.
public
	_@ = -1;

#define YSIM_NOT_CLIENT (!YSIM_HAS_MASTER || !YSIM_IS_CLIENT)

//#if !defined MAX_MASTERS
#define MAX_MASTERS 43
//#else
//	#if MAX_MASTERS > 32
//		#undef MAX_MASTERS
//		#define MAX_MASTERS 32
//	#endif
//#endif

forward Master_Reassert();

static
	YSI_g_sMasterCount,
	YSI_g_sMasterData[MAX_MASTERS];

native U@(id=0, const name[]="", value=cellmin, const string[]="") = setproperty;
native V@(id=0, const name[]="", value=cellmin, string[]="") = getproperty;
// Define this command with basically every strong tag in existance to avoid
// tag mismatch warnings with remote functions with strong tag parameters.
native W@(const function[], const format[], {Float, File, Bit, PlayerText3D, Text, Text3D, Menu, DB, DBResult, Style, XML, Bintree, _}:...) = CallRemoteFunction;

stock X@(n)
{
	setproperty(8, YSIM_RETURN, n);
}

stock Y@()
{
	return setproperty(8, YSIM_CALLER, _@);
}

stock Z@()
{
	setproperty(8, YSIM_CALLER, -1);
	return getproperty(8, YSIM_RETURN);
}

stock T@()
{
	setproperty(8, YSIM_CALLER, -1);
}

new Q@[64];

stock S@()
{
	getproperty(9, "", YSIM_STRING, Q@);
	strunpack(Q@, Q@);
	setproperty(8, YSIM_CALLER, -1);
	return 0;
}

stock R@(buffer[])
{
	setproperty(9, "", YSIM_STRING, buffer);
}

/*----------------------------------------------------------------------------*-
Hook:
	OnGameModeInit
Notes:
	Constructor.  Gets the script a master ID.  Now ALWAYS gets an ID, even if
	the master system is disabled - doing otherwise is just too complicated.
-*----------------------------------------------------------------------------*/

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
#else
	public OnGameModeInit()
#endif
{
	P:1("Master_OGM");
	if (!existproperty(8, YSIM_MASTER))
	{
		setproperty(8, YSIM_MASTER, 0);
	}
	// Properties get lost between script changes so we need to force a rebuild.
	CallRemoteFunction("Master_Reassert", "");
	new
		masters = getproperty(8, YSIM_MASTER),
		i = 0;
	while (i != 32)
	{
		if (!(masters & (1 << i)))
		{
			_@ = i;
			masters |= 1 << i;
			break;
		}
		++i;
	}
	if (i != 32)
	{
		setproperty(8, YSIM_MASTER, masters);
	}
	C:1(if (_@ == -1) printf("*** Internal Error! MasterID not assigned"););
	// Just use one name...
	CallLocalFunction("YSIM_OnScriptInit", "");
	return 1;
}

#if defined FILTERSCRIPT
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit YSIM_OnScriptInit
#else
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit YSIM_OnScriptInit
#endif
forward YSIM_OnScriptInit();

/*----------------------------------------------------------------------------*-
Hook:
	OnGameModeExit
Notes:
	Destructor.
-*----------------------------------------------------------------------------*/

#if defined FILTERSCRIPT
	public OnFilterScriptExit()
#else
	public OnGameModeExit()
#endif
{
	// Loop through everything this script is master for and call the remote
	// function for it.  EXCEPT for this script itself!
	new
		func[4];
	for (new i = 0; i != YSI_g_sMasterCount; ++i)
	{
		// This is slightly slower for ending and starting scripts, but uses far
		// less heap space, and these values are rarely used, so may as well
		// pack them (which is what has happened here).
		func[0] = YSI_g_sMasterData[i] & 0xFF;
		func[1] = (YSI_g_sMasterData[i] >> 8) & 0xFF;
		func[2] = YSI_g_sMasterData[i] >> 16;
		CallLocalFunction(func, "");
		// The properties currently clear instantly, but that may not always be
		// the case.
		setproperty(8, YSIM_MASTER, getproperty(8, YSIM_MASTER) & ~(1 << _@));
	}
	CallLocalFunction("YSIM_OnScriptExit", "");
	return 1;
}

#if defined FILTERSCRIPT
	#if defined _ALS_OnFilterScriptExit
		#undef OnFilterScriptExit
	#else
		#define _ALS_OnFilterScriptExit
	#endif
	#define OnFilterScriptExit YSIM_OnScriptExit
#else
	#if defined _ALS_OnGameModeExit
		#undef OnGameModeExit
	#else
		#define _ALS_OnGameModeExit
	#endif
	#define OnGameModeExit YSIM_OnScriptExit
#endif
forward YSIM_OnScriptExit();

/*----------------------------------------------------------------------------*-
Function:
	Master_Reassert
Params:
	-
Return:
	-
Notes:
	Rebuilds the collection of master data whenever a script is restarted.
-*----------------------------------------------------------------------------*/

public Master_Reassert()
{
	// Make sure that the caller parameter is always -1 by default.
	U@(8, YSIM_CALLER, -1);
	if (_@ != -1)
	{
		// Readd this script's master value.
		setproperty(8, YSIM_MASTER, getproperty(8, YSIM_MASTER) | (1 << _@));
		// Readd this script's owned scripts.
		new
			func[4];
		for (new i = 0; i != YSI_g_sMasterCount; ++i)
		{
			// This is slightly slower for ending and starting scripts, but uses far
			// less heap space, and these values are rarely used, so may as well
			// pack them (which is what has happened here).
			func[0] = YSI_g_sMasterData[i] & 0xFF;
			func[1] = (YSI_g_sMasterData[i] >> 8) & 0xFF;
			func[2] = YSI_g_sMasterData[i] >> 16;
			setproperty(8, func, _@);
		}
	}
}

/*----------------------------------------------------------------------------*-
Function:
	_Master_Get
Params:
	library[] - The name of the library to try become master for.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

stock bool:_Master_Get(library[], bool:force = false)
{
	P:2("_Master_Get called");
	if (!force && existproperty(8, library))
	{
		P:4("_Master_Get: Prop exists: %d %d", getproperty(8, library), _@);
		if (getproperty(8, library) != -1)
		{
			P:4("_Master_Get: Prop set");
			return false;
		}
	}
	P:4("_Master_Get: Get master.");
	setproperty(8, library, _@);
	P:4("_Master_Get: Set master.");
	// Add this library to the list.  The list is designed to only deal with
	// two or three character master names now!
	if (YSI_g_sMasterCount < MAX_MASTERS)
	{
		P:4("_Master_Get: Set master string.");
		YSI_g_sMasterData[YSI_g_sMasterCount++] = library[0] | (library[1] << 8) | (library[2] << 16);
		P:4("_Master_Get: Set master string.");
	}
	C:1(else printf("*** Internal Error! Too many master scripts"););
	return true;
}

// Define all the alternate spellings once.
#define RF@cp  RF@pc
#define RF@pvc RF@pcv
#define RF@cpv RF@pcv
#define RF@cvp RF@pcv
#define RF@vpc RF@pcv
#define RF@vcp RF@pcv
#define RF@vp  RF@pv
#define RF@cv  RF@vc
//#define RF@nv  RF@vn

#define RF@cpt  RF@pct
#define RF@tcp  RF@pct
#define RF@tpc  RF@pct
#define RF@ctp  RF@pct
#define RF@ptc  RF@pct
#define RF@tp  RF@pt
#define RF@tc  RF@ct
//#define RF@tn  RF@nt

// Consume trailing spaces.
#define x,), x),

/*
#define RF:%1[%2](%3)
#define RF@p:%1[%2](%3)<%4>
#define RF@c:%1[%2](%3)
#define RF@v:%1[%2](%3)
#define RF@n:%1[]()
#define RF@pc:%1[%2](%3)<%4>
#define RF@pv:%1[%2](%3)<%4>
#define RF@pcv:%1[%2](%3)<%4>
#define RF@vc:%1[%2](%3)
#define RF@vn:%1[]()
*/

// Define all the alternate spellings once.
//#define RC@nv  RC@vn

/*
#define RC:%1[%2](%3)
#define RC@v:%1[%2](%3)
#define RC@n:%1[]()
#define RC@vn:%1[]()
*/
