/*----------------------------------------------------------------------------*-
					  ====================================
					   y_timers - Run timers efficiently. 
					  ====================================
Description:
	Sets up repeating timers without requiring any SetTimers and arranges them
	so that they will be very unlikely to meet (at least for a long time) using
	scheduling algorithms to get timers with the same period to be offset.
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
	1.0
Changelog:
	12/10/10:
		Rewrote for YSI 1.0 using y_scripting.
	11/08/07:
		Removed millions of defines to reduce pre-processing.
		Added pickups.
	03/08/07:
		First version.
-*----------------------------------------------------------------------------*/

#include <YSI\y_debug>
#include <YSI\y_scripting>

#define Timer:%0[%1](%2) forward @yT_%1_%0();@yT_%1_%0()

// This defines the number of different periods that timers can have.  This
// number is a HUGE over-estimate, you would need to have over 256 timers, none
// of them with the same period, for this number to be too small!
#define MAX_TIMER_VARIATIONS            (256)

forward Timer_Start(timer, delay);

/*----------------------------------------------------------------------------*-
Function:
	OnScriptInit
Params:
	-
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#if defined FILTERSCRIPT
	public OnFilterScriptInit()
#else
	public OnGameModeInit()
#endif
{
	new
		buffer[33],
		idx = 0,
		timers[MAX_TIMER_VARIATIONS][2],//[3],
		periods = 0;
	// 0 = time, 1 = count, 2 = offset.
	// First loop - get all the different periods.
	// Get the list of timers from the list of publics.
	while ((idx = Scripting_GetPublicFast(idx, buffer, (Scripting_FastString('@', 'y', 'T', '_')))))
	{
		// Get the time associated with the timer.  We know this starts at index
		// position 4, because we always set it to be there.
		new
			time = strval(buffer[4]);
		if (time)
		{
			// Valid time, find this in the array.
			for (new i = 0; ; ++i)
			{
				if (i == periods)
				{
					timers[i][0] = time;
					timers[i][1] = 1;
					++periods;
					break;
				}
				else if (timers[i][0] == time)
				{
					++timers[i][1];
					break;
				}
			}
			if (periods == MAX_TIMER_VARIATIONS)
			{
				P:1("*** Internal Error: Timer array full");
				break;
			}
		}
	}
	// Group timers with common periods together, for example timers with 1000
	// and 500ms periods need to be interleaved so they don't run at the same
	// time very often.  Obviously ANY combination of timers will eventually run
	// at the same time at some point, but we can reduce this chance.
	/*for (new i = 0; i != periods; ++i)
	{
		new
			time = timers[i][0];
		if (timers[i][2])
		{
			for (new j = 0; j != i; ++j)
			{
				new
					ct = timers[j][0];
				if ((time / ct) * ct == time || (ct / time) * time == ct)
				{
					// Set the count to the same as the master.
					timers[i][1] = timers[j][1];
					break;
				}
			}
		}
		else
		{
			new
				offset = timers[i][1];
			for (new j = i + 1; j != periods; ++j)
			{
				// Find similar periods.
				new
					ct = timers[j][0];
				if ((time / ct) * ct == time)
				{
					// This time is larger.
				}
				else if ((ct / time) * time == ct)
				{
				}
				if ((time / ct) * ct == time || (ct / time) * time == ct)
				{
					// That's integer division, so valid code.  Mark this
					// element as controlled by another element.
					timers[j][2] = offset;
					offset += timers[j][1];
				}
			}
			timers[i][1] = offset;
		}
	}*/
	C:1(for(new i;i!=periods;++i)printf("%d %d %d",timers[i][0],timers[i][1],0););//,timers[i][2]););
	// Now we know how many of each period there are we can try arrange them so
	// that they execute at very different times.
	// [1] contains the total number of timers on similar periods.
	for (new i = 0; i != periods; ++i)
	{
		// First calculate the gap between the timers.
		new
			time = timers[i][0],
			offset = time / timers[i][1];
		// Now start all the timers with this time at that offset.
		idx = 0;
		new
			last = 0,
			curo = offset;
		while ((idx = Scripting_GetPublicFast(idx, buffer, (Scripting_FastString('@', 'y', 'T', '_')))))
		{
			if (strval(buffer[4]) == time)
			{
				// That's the old start code, which uses 7ms offsets to try get
				// as close as possible to different server frames (5ms).
				SetTimerEx("Timer_Start", curo + (random(14) - 7), 0, "ii", last, time);
				//SetTimerEx("Timer_Start", curo, 0, "ii", last, time);
				curo += offset;
			}
			// So that the first found timer in the next function is correct.
			last = idx;
		}
	}
	CallLocalFunction("Timers_OnScriptInit", "");
}

#if defined FILTERSCRIPT
	#if defined _ALS_OnFilterScriptInit
		#undef OnFilterScriptInit
	#else
		#define _ALS_OnFilterScriptInit
	#endif
	#define OnFilterScriptInit Timers_OnScriptInit
#else
	#if defined _ALS_OnGameModeInit
		#undef OnGameModeInit
	#else
		#define _ALS_OnGameModeInit
	#endif
	#define OnGameModeInit Timers_OnScriptInit
#endif

forward Timers_OnScriptInit();

/*----------------------------------------------------------------------------*-
Function:
	Timer_Start
Params:
	timer - Approximate public function index.
	delay - How often it's called.
Return:
	-
Notes:
	Only needed for more than one timer.  Offsets calls from each other for
	better server load distribution.
-*----------------------------------------------------------------------------*/

public Timer_Start(timer, delay)
{
	new
		buffer[33];
	Scripting_GetPublicFast(timer, buffer, (Scripting_FastString('@', 'y', 'T', '_')));
	SetTimer(buffer, delay, 1);
}
