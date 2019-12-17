/*----------------------------------------------------------------------------*-
					===============================
					Y Sever Includes - Master Auto
					===============================
Description:
	Attempts to figure out from what library the current instance of the master
	system was included from.
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
	0.1
Changelog:
	06/08/10:
		First version.
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
		-
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
		-.
	Static:
		-
Commands:
	-
Compile options:
	-
Operators:
	-
Natives:
	-
-*----------------------------------------------------------------------------*/

#undef _inc_y_automasters

#define _YSIM_USED_AUTO

// Commands are set as master number 25
#if defined _inc_y_commands
	#if !defined _YCM_z@ // z is letter 25
		#define MASTER                  25
		#endinput
	#endif
#endif

// Groups are set as master number 24
#if defined _inc_y_grouponce
	#if !defined _YCM_y@ // y is letter 24
		#define MASTER                  24
		#endinput
	#endif
#endif

// Dialogs are set as master number 23
#if defined _inc_y_dialog
	#if !defined _YCM_x@ // x is letter 23
		#define MASTER                  23
		#endinput
	#endif
#endif

// Languages are set as master number 27
/*#if defined _inc_y_languages
	#if !defined _YCM_B@ // B is letter 27
		#define MASTER                  27
		#endinput
	#endif
#endif

// Players are set as master number 28
#if defined _inc_y_player
	#if !defined _YCM_C@ // C is letter 28
		#define MASTER                  28
		#endinput
	#endif
#endif

// The help system is set as master number 29
#if defined _inc_y_help
	#if !defined _YCM_D@ // D is letter 29
		#define MASTER                  29
		#endinput
	#endif
#endif*/

#undef _YSIM_USED_AUTO

// We can't have an auto-incrementing master number as there's no way to
// guarantee that two scripts using the same library will have the same master
// number for that library!
/*#if defined _YCM_z@
	#error "Max masters exceeded."
#endif
#if defined _YCM_y@
	#define MASTER                      25
#endif
#if defined _YCM_x@
	#define MASTER                      24
#endif
#if defined _YCM_w@
	#define MASTER                      23
#endif
#if defined _YCM_v@
	#define MASTER                      22
#endif
#if defined _YCM_u@
	#define MASTER                      21
#endif
#if defined _YCM_t@
	#define MASTER                      20
#endif
#if defined _YCM_s@
	#define MASTER                      19
#endif
#if defined _YCM_r@
	#define MASTER                      18
#endif
#if defined _YCM_q@
	#define MASTER                      17
#endif
#if defined _YCM_p@
	#define MASTER                      16
#endif
#if defined _YCM_o@
	#define MASTER                      15
#endif
#if defined _YCM_n@
	#define MASTER                      14
#endif
#if defined _YCM_m@
	#define MASTER                      13
#endif
#if defined _YCM_l@
	#define MASTER                      12
#endif
#if defined _YCM_k@
	#define MASTER                      11
#endif
#if defined _YCM_j@
	#define MASTER                      10
#endif
#if defined _YCM_i@
	#define MASTER                      9
#endif
#if defined _YCM_h@
	#define MASTER                      8
#endif
#if defined _YCM_g@
	#define MASTER                      7
#endif
#if defined _YCM_f@
	#define MASTER                      6
#endif
#if defined _YCM_e@
	#define MASTER                      5
#endif
#if defined _YCM_d@
	#define MASTER                      4
#endif
#if defined _YCM_c@
	#define MASTER                      3
#endif
#if defined _YCM_b@
	#define MASTER                      2
#endif
#if defined _YCM_a@
	#define MASTER                      1
#endif
#define MASTER                          0*/
