/*----------------------------------------------------------------------------*-
					=================================
					Y Sever Includes - Misc Functions
					=================================
Description:
	Misc functions used throughout.
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
	0.1.3
Changelog:
	08/09/10:
		Added strcpy and StripNL.
	08/08/10:
		Scrapped almost everything.  Only VERY usefult things go in now.
Functions:
	Stock:
		StripNL - Strips the newline characters from the end of a string.
	Inline:
		iseven - Checks if a number is even.
		isodd - Checks if a number is odd.
		isnull - Checks if a string is NULL ("\1\0").
		strcpy - Copy one string to another.
Variables:
	Global:
		TRUE - True hack for infinate loops.
		FALSE - False hack for one-time loops.
		NULL - 1 long string for passing via Call(Remote|Local)Function.
-*----------------------------------------------------------------------------*/

#tryinclude <sscanf>

new
	bool:TRUE = true,
	bool:FALSE = false,
	NULL[2] = {1, 0};

#pragma unused TRUE, FALSE, NULL

/*----------------------------------------------------------------------------*-
Function:
	isnull
Params:
	str - String to check if is null.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define isnull(%1) \
	((%1[0] == 0) || (%1[0] == 1 && %1[1] == 0))

/*----------------------------------------------------------------------------*-
Function:
	isodd
Params:
	value - Value to check if is odd.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define isodd(%1) \
	((%1) & 1)

/*----------------------------------------------------------------------------*-
Function:
	iseven
Params:
	value - Value to check if is even.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define iseven(%1) \
	(!isodd(%1))

/*----------------------------------------------------------------------------*-
Function:
	strcpy
Params:
	dest - Destination string.
	src - Source string.
	len - Maximum length of the destination.
Return:
	-
Notes:
	-
-*----------------------------------------------------------------------------*/

#define strcpy(%0,%1,%2) \
	strcat((%0[0] = '\0', %0), %1, %2)
//	memcpy(%0,%1,0,strlen(%1)*4+4,%2)

/*----------------------------------------------------------------------------*-
Function:
	StripNL
Params:
	str[] - The string to remove the newline characters from
Return:
	-
Notes:
	Updated from old versions, should be more efficient
-*----------------------------------------------------------------------------*/

stock StripNL(str[])
{
	new
		i = strlen(str);
	while (i-- && str[i] <= ' ') str[i] = '\0';
}

/*----------------------------------------------------------------------------*-
Function:
	endofline
Params:
	line[] - String to check.
	pos - Postion to start from.
Return:
	-
Notes:
	Checks if the current point in a line is the end of non-whitespace data.
-*----------------------------------------------------------------------------*/

stock endofline(line[], pos)
{
	while (line[pos]) if (line[pos++] > ' ') return 0;
	return 1;
}

/*----------------------------------------------------------------------------*-
Function:
	chrfind
Params:
	needle - The character to find.
	haystack[] - The string to find it in.
	start - The offset to start from.
Return:
	Fail - -1, Success - pos
Notes:
	-
-*----------------------------------------------------------------------------*/

stock chrfind(needle, haystack[], start = 0)
{
	if (start < 0)
	{
		start = 0;
	}
	while (haystack[start]) if (haystack[start++] == needle) return start - 1;
	return -1;
}

#if !defined _inc_sscanf
	/*------------------------------------------------------------------------*-
	Function:
		hexstr
	Params:
		string[] - String to convert to a number.
	Return:
		value of the passed hex string.
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	stock hexstr(string[])
	{
		new
			ret,
			val,
			i;
		if (string[0] == '0' && (string[1] == 'x' || string[1] == 'X')) i = 2;
		while (string[i])
		{
			ret <<= 4;
			val = string[i++] - '0';
			if (val > 0x09) val -= 0x07;
			if (val > 0x0F) val -= 0x20;
			if (val < 0x01) continue;
			if (val < 0x10) ret += val;
		}
		return ret;
	}
	
	/*------------------------------------------------------------------------*-
	Function:
		binstr
	Params:
		string[] - String to try convert to a boolean.
	Return:
		bool: passed boolean.
	Notes:
		This can take a number of ways of representing booleans - 0, false and
		nothing there.  Anything not one of those things (false is not case
		sensitive) is assumed true.
	-*------------------------------------------------------------------------*/
	
	stock bool:binstr(string[])
	{
		if (!string[0] || string[0] == '0' || !strcmp(string, "false", true)) return false;
		return true;
	}
#endif
