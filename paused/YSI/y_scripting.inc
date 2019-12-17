/*----------------------------------------------------------------------------*-
					===============================
					 y_scripting - Access amx data
					===============================
Description:
	Allows a script access to information about itself, such as function names.
	This can be used for a range of things, including automatic callback hooking
	and testing.
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
	06/08/10:
		First version
-*----------------------------------------------------------------------------*/

#include <a_samp>

#include <YSI\internal\y_funcinc>

#define Scripting_FastString(%1,%2,%3,%4) \
	(((%1) << 0) | ((%2) << 8) | ((%3) << 16) | ((%4) << 24))

static stock Scripting_GetBase()
{
	static
		s_addr;
	if (!s_addr)
	{
		// Get the data offset.
		#emit LCTRL                     1
		#emit STOR.pri                  s_addr
		// Invert to get the prefix offset relative to the data.
		s_addr = -s_addr;
	}
	return s_addr;
}

static stock Scripting_GetPublics()
{
	static
		s_addr;
	if (!s_addr)
	{
		new
			addr;// = Scripting_GetBase();
		// Get the data offset.
		#emit LCTRL                     1
		#emit STOR.S.pri                addr
		// Invert to get the prefix offset relative to the data.
		addr = -addr;
		// Get the pointer to the publics.
		addr += 32;
		#emit LREF.S.pri                addr
		#emit STOR.pri                  s_addr
		// Adjust to get the relative offset.
		s_addr = s_addr + addr - 32;
	}
	return s_addr;
}

static stock Scripting_GetNatives()
{
	static
		s_addr;
	if (!s_addr)
	{
		new
			addr;// = Scripting_GetBase();
		// Get the data offset.
		#emit LCTRL                     1
		#emit STOR.S.pri                addr
		// Invert to get the prefix offset relative to the data.
		addr = -addr;
		// Get the pointer to the publics.
		addr += 36;
		#emit LREF.S.pri                addr
		#emit STOR.pri                  s_addr
		// Adjust to get the relative offset.
		s_addr = s_addr + addr - 36;
	}
	return s_addr;
}

static stock Scripting_GetLibraries()
{
	static
		s_addr;
	if (!s_addr)
	{
		new
			addr;// = Scripting_GetBase();
		// Get the data offset.
		#emit LCTRL                     1
		#emit STOR.S.pri                addr
		// Invert to get the prefix offset relative to the data.
		addr = -addr;
		// Get the pointer to the publics.
		addr += 40;
		#emit LREF.S.pri                addr
		#emit STOR.pri                  s_addr
		// Adjust to get the relative offset.
		s_addr = s_addr + addr - 40;
	}
	return s_addr;
}

static stock Scripting_GetString(addr)
{
	new
		str[33],
		buffer,
		ch,
		idx;
	do
	{
		// Read 4 bytes.
		#emit LREF.S.pri                addr
		#emit STOR.S.pri                buffer
		// Write a character to the buffer.
		ch = buffer & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >> 8 & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >> 16 & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >> 24;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Get the next address.
		addr += 4;
	}
	while (idx < 32);
	return str;
}

static stock Scripting_GetStringFast(addr, buffer)
{
	new
		str[33],
		ch,
		idx;
	do
	{
		// Write a character to the buffer.
		ch = buffer & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >> 8 & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >> 16 & 0xFF;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Write a character to the buffer.
		ch = buffer >>> 24;
		str[idx++] = ch;
		// Check for the end of the string.
		if (!ch) break;
		// Get the next address.
		addr += 4;
		// Read 4 bytes.
		#emit LREF.S.pri                addr
		#emit STOR.S.pri                buffer
	}
	while (idx < 32);
	return str;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetPublicsCount
Params:
	-
Return:
	Number of public functions in a script.
Notes:
	-

native Scripting_GetPublicsCount();

-*----------------------------------------------------------------------------*/

stock Scripting_GetPublicsCount()
{
	static
		s_count;
	if (!s_count)
	{
		// Get the difference in pointers.
		s_count = (Scripting_GetNatives() - Scripting_GetPublics()) / 8;
	}
	return s_count;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetNativesCount
Params:
	-
Return:
	Number of native functions in a script.
Notes:
	-

native Scripting_GetNativesCount();

-*----------------------------------------------------------------------------*/

stock Scripting_GetNativesCount()
{
	static
		s_count;
	if (!s_count)
	{
		// Get the difference in pointers.
		s_count = (Scripting_GetLibraries() - Scripting_GetNatives()) / 8;
	}
	return s_count;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetPublicFast
Params:
	idx - Index of the public to get.
	buffer[33] - Buffer to store the name in.
	search - Pattern matching parameter.
Return:
	Index of next public.
Notes:
	Gets a string starting with a know 4 character sequence.

native Scripting_GetPublicFast(idx, buffer[33], search);

-*----------------------------------------------------------------------------*/

stock Scripting_GetPublicFast(idx, buffer[33], search)
{
	new
		count = Scripting_GetPublicsCount(),
		base = Scripting_GetBase(),
		publics = Scripting_GetPublics();
	while (idx < count)
	{
		// Get the offset in the public records.
		new
			pos = idx * 8 + 4;
		// Get the pointer to the string.
		pos += publics;
		// Get the address of the string.
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                pos
		//printf("%s", Scripting_GetString(Scripting_GetBase() + pos));
		//new
		//	str[33] = Scripting_GetString(base + pos));
		++idx;
		pos += base;
		new
			chars;
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                chars
		if (chars == search)
		{
			buffer = Scripting_GetStringFast(pos, chars);
			return idx;
		}
	}
	buffer[0] = '\0';
	return 0;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetNative
Params:
	idx - Index of the native to get.
	buffer[33] - Buffer to store the name in.
	search - Pattern matching parameter.
Return:
	Index of next native.
Notes:
	-

native Scripting_GetNativeFast(idx, buffer[33], search);

-*----------------------------------------------------------------------------*/

stock Scripting_GetNativeFast(idx, buffer[33], search)
{
	new
		count = Scripting_GetNativesCount(),
		base = Scripting_GetBase(),
		publics = Scripting_GetNatives();
	while (idx < count)
	{
		// Get the offset in the public records.
		new
			pos = idx * 8 + 4;
		// Get the pointer to the string.
		pos += publics;
		// Get the address of the string.
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                pos
		//printf("%s", Scripting_GetString(Scripting_GetBase() + pos));
		//new
		//	str[33] = Scripting_GetString(base + pos));
		++idx;
		pos += base;
		new
			chars;
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                chars
		if (chars == search)
		{
			buffer = Scripting_GetStringFast(pos, chars);
			return idx;
		}
	}
	buffer[0] = '\0';
	return 0;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetPublic
Params:
	idx - Index of the public to get.
	buffer[33] - Buffer to store the name in.
	search[] - Optional pattern matching parameter.
Return:
	Index of next public.
Notes:
	-

native Scripting_GetPublic(idx, buffer[33], search[] = "");

-*----------------------------------------------------------------------------*/

stock Scripting_GetPublic(idx, buffer[33], search[] = "")
{
	new
		count = Scripting_GetPublicsCount(),
		base = Scripting_GetBase(),
		publics = Scripting_GetPublics();
	while (idx < count)
	{
		// Get the offset in the public records.
		new
			pos = idx * 8 + 4;
		// Get the pointer to the string.
		pos += publics;
		// Get the address of the string.
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                pos
		//printf("%s", Scripting_GetString(Scripting_GetBase() + pos));
		//new
		//	str[33] = Scripting_GetString(base + pos));
		++idx;
		buffer = Scripting_GetString(base + pos);
		if (search[0] == '\0' || strfind(buffer, search) != -1)
		{
			return idx;
		}
	}
	buffer[0] = '\0';
	return 0;
}

/*----------------------------------------------------------------------------*-
Function:
	Scripting_GetNative
Params:
	idx - Index of the native to get.
	buffer[33] - Buffer to store the name in.
	search[] - Optional pattern matching parameter.
Return:
	Index of next native.
Notes:
	-

native Scripting_GetNative(idx, buffer[33], search[] = "");

-*----------------------------------------------------------------------------*/

stock Scripting_GetNative(idx, buffer[33], search[] = "")
{
	new
		count = Scripting_GetNativesCount(),
		base = Scripting_GetBase(),
		publics = Scripting_GetNatives();
	while (idx < count)
	{
		// Get the offset in the public records.
		new
			pos = idx * 8 + 4;
		// Get the pointer to the string.
		pos += publics;
		// Get the address of the string.
		#emit LREF.S.pri                pos
		#emit STOR.S.pri                pos
		//printf("%s", Scripting_GetString(Scripting_GetBase() + pos));
		//new
		//	str[33] = Scripting_GetString(base + pos));
		++idx;
		buffer = Scripting_GetString(base + pos);
		if (search[0] == '\0' || strfind(buffer, search) != -1)
		{
			return idx;
		}
	}
	buffer[0] = '\0';
	return 0;
}
