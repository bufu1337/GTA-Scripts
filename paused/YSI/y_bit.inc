/*----------------------------------------------------------------------------*-
					===========================
					Y Sever Includes - Bit Core
					===========================
Description:
	Provides functions for bit manipulation and bit arrays greater than 32bits.
	The arrays are usually bigger than required due to cell boundaries but this
	shouldn't cause a major problem (bit tests on the 101st bit of a 100 bit
	array won't return 0 for out of bounds, but the 129th will).
	
	Note that y_commands has a few optimisations which bypass the code in here
	so any modifications to bit array layouts will need to be reflected there.
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
	01/12/08:
		Rewrote most of the code to use shifts and ands not divs and mods.
	24/06/07:
		Added Bit_GetBit
	18/06/07:
		Added Bit_GetCount
	30/04/07:
		Added Bit_SetAll
	15/04/07:
		First version.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		Bit_Set - Sets a slot to the given value.
		Bit_Get - Gets a slot state.
		Bit_SetAll - Sets all the slots in an array to the same thing.
		Bit_GetAll - Gets the number of 1s in a bit array.
	Static:
		-
	Inline:
		Bit_Bits - Gets the number of cells required for a bit array.
		Bit_Let - Sets a slot to 1.
		Bit_Vet - Sets a slot to 0.
		Bit_GetBits - Gets the bit at a slot unsafely.
	API:
		-
Callbacks:
	-
Definitions:
	CELLSHIFT - Number of bits that can hold "cellbits"
Enums:
	-
Macros:
	-
Tags:
	Bit - Bit array type.
Variables:
	Global:
		-
	Static:
		-
Commands:
	-
Compile options:
	-
-*----------------------------------------------------------------------------*/

#define BitArray:%1<%2> Bit:%1[%2]

#if cellbits == 32
	#define CELLSHIFT (5)
#else
	#if cellbits == 64
		#define CELLSHIFT (6)
	#else
		#if cellbits == 16
			#define CELLSHIFT (4)
		#else
			#error Unkown cell size
		#endif
	#endif
#endif

/*----------------------------------------------------------------------------*-
Function:
	Bit_Bits
Params:
	size - Number of bits required.
Return:
	Number of cells required for the bit array.
Notes:
	-
-*----------------------------------------------------------------------------*/

#define Bit_Bits(%1) \
	(((%1) + (cellbits) - 1) / (cellbits))

/*----------------------------------------------------------------------------*-
Function:
	Bit_GetBit
Params:
	Bit:array[] - Array of bits.
	slot - Bit slot.
Return:
	State of the provided slot, 0 on fail.
Notes:
	Unsafe but faster for when you're sure you're within range.
-*----------------------------------------------------------------------------*/

#define Bit_GetBit(%1,%2) \
	((%1[(%2) >>> CELLSHIFT]) & Bit:(1 << ((%2) & (cellbits - 1))))

/*----------------------------------------------------------------------------*-
Function:
	Bit_Get
Params:
	Bit:array[] - Array of bits.
	slot - Bit slot.
	size - Size of array.
Return:
	State of the provided slot, 0 on fail.
Notes:
	-

native Bit_Get(BitArray:array<>, slot);

-*----------------------------------------------------------------------------*/

#define Bit_Get(%1,%2) \
	bool:Bit_GetBit(Bit:%1, _:%2)

/*----------------------------------------------------------------------------*-
Function:
	Bit_Let
Params:
	Bit:array[] - Array of bits.
	slot - Bit slot.
Return:
	-
Notes:
	Sets the slot to 1.
-*----------------------------------------------------------------------------*/

#define Bit_Let(%1,%2) \
	%1[(%2) >>> CELLSHIFT] |= Bit:(1 << ((%2) & (cellbits - 1)))

/*----------------------------------------------------------------------------*-
Function:
	Bit_Vet
Params:
	Bit:array[] - Array of bits.
	slot - Bit slot.
Return:
	-
Notes:
	Sets the slot to 0.
-*----------------------------------------------------------------------------*/

#define Bit_Vet(%1,%2) \
	%1[(%2) >>> CELLSHIFT] &= Bit:~(1 << ((%2) & (cellbits - 1)))

/*----------------------------------------------------------------------------*-
Function:
	Bit_Set
Params:
	Bit:array[] - Array of bits.
	slot - Bit slot.
	bool:set - State to set the slot to.
	size - Size of array.
Return:
	-
Notes:
	-

native Bit_Set(BitArray:array<>, slot, bool:set, size = sizeof (array));

-*----------------------------------------------------------------------------*/

stock Bit_Set(BitArray:array<>, slot, bool:set, size = sizeof (array))
{
	if (slot >>> CELLSHIFT >= size) return;
	if (set) Bit_Let(array, slot);
	else Bit_Vet(array, slot);
}

/*----------------------------------------------------------------------------*-
Function:
	Bit_SetAll
Params:
	Bit:array[] - Array to set all values of.
	bool:set - Wether to set them all 0 or 1.
	size - Size of array.
Return:
	-
Notes:
	-

native Bit_SetAll(BitArray:array<>, bool:set, size = sizeof (array));

-*----------------------------------------------------------------------------*/

stock Bit_SetAll(BitArray:array<>, bool:set, size = sizeof (array))
{
	new
		Bit:val = (set) ? (Bit:0xFFFFFFFF) : (Bit:0);
	for (new i = 0; i != size; ++i) array[i] = val;
}

/*----------------------------------------------------------------------------*-
Function:
	Bit_GetCount
Params:
	Bit:array[] - Array to count.
	size - Size of array.
Return:
	Number of 1s in the array.
Notes:
	Code from:
	http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetParallel

native Bit_Count(BitArray:array<>, size = sizeof (array));

-*----------------------------------------------------------------------------*/

stock Bit_GetCount(BitArray:array<>, size = sizeof (array))
{
	new
		count,
		v;
	for (new i = 0; i != size; ++i)
	{
		v = _:array[i];
		v = v - ((v >>> 1) & 0x55555555);
		v = (v & 0x33333333) + ((v >>> 2) & 0x33333333);
		count += ((v + (v >>> 4) & 0xF0F0F0F) * 0x1010101) >>> 24;
	}
	return count;
}

#define bits<%1> \
	Bit_Bits(%1)

#undef BitArray
#define BitArray:%1<%2> Bit:%1[bits<%2>]
