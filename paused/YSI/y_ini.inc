/*----------------------------------------------------------------------------*-
					===========================
					Y Sever Includes - INI Core
					===========================
Description:
	Reads the INI and also exports a number of functions to other "classes" for
	easy reading of data files there.
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
	08/09/10:
		Started adding sscanf and file plugin compatibility.
		Added tagless data at the start of a file (dini compatible).
		Added new INI:file[tag]() syntax.
		Added options to default file load.
		Fixed bugs in default file load configuration.
		Modified to be stand alone.
	20/02/08:
		Added INI_RemoveEntry.
	18/08/07:
		Fixed bug reading identifiers starting with a tag (i.e. names).
		Added local file reading for non-serverwide broadcasting.
		Added tag passing instead of tag based functions option.
		Increased default pool size.
	30/07/07:
		Added auto creation of non-existant files.
	13/07/07:
		Fixed INI writing to actually work.
		Added support for blank lines in INIs decently and quickly.
	25/06/07:
		Altered file write options to use lists.
		Added buffer overwriting for updating values.
	24/06/07:
		Added file write options.
	21/06/07:
		Added INI_NEW_LINE for future writing functions.
	20/06/07:
		Added support for an optional parameter in broadcast data.
	15/04/07:
		Updated for more whitespaces.
		Added INI comment code.
		Added support for value-less entries.
		Modified entry extraction to use end of name location parameter.
		Removed INI_GetTagName, now done via INI_GetEntryName.
	14/04/07:
		Updated header documentation with more than changelog.
	24/03/07:
		First version.
Functions:
	Public:
		-
	Core:
		-
	Stock:
		INI_Load - Loads an INI file using standard features.
		INI_ParseFile - Loads a file as an ini and distributes data.
		INI_GetEntryName - Gets the name of an INI item.
		INI_GetEntryText - Gets the value of an INI item.
		INI_Open - Opens an INI for writing.
		INI_Close - Closes an INI being written to.
		INI_SetTag - Sets a subheading in an INI fo subsequent writes.
		INI_WriteString - Writes a string to an INI.
		INI_WriteInt - Writes an int to an INI.
		INI_WriteFloat - Writes a float to an INI.
		INI_RemoveEntry - Remove an entry from a file.
	Static:
		INI_WriteBuffer - Writes an INI's buffer to the file.
		INI_AddToBuffer - Adds a string to an INI buffer.
	Inline:
		INI_Int - Parse an integer INI entry.
		INI_Float - Parse a float INI entry.
		INI_Hex - Parse a hex INI entry.
		INI_Bin - Parse a binary INI entry.
		INI_String - Parse a string INI entry.
	API:
		-
Callbacks:
	-
Definitions:
	MAX_INI_TAG - Maximum length of an INI tagname.
	MAX_INI_ENTRY_NAME - Maximum length of an INI entry name.
	MAX_INI_ENTRY_TEXT - Maximum length of an INI's entries' value.
	MAX_INI_LINE - Maximum length of a line in a file.
	INI_NEW_LINE - String for new lines.
	INI_MAX_WRITES - Maximum concurrent files open for writing.
	MAX_INI_TAGS - Number of tags the buffer can hold data for at once.
Enums:
	E_INI_WRITE - Storage for entries to be written.
	E_INI_TAGS - Data for tags with data.
Macros:
	INI_Parse - Header for ini parsing functions.
Tags:
	INI - Handle to an INI file being written to.
Variables:
	Global:
		-
	Static:
		YSI_g_sINIWriteBuffer - Basic data to be written.
		YSI_g_sINIWritePos - Next slot to write to.
		YSI_g_sINITagPos - Next slot to add a tag to.
		YSI_g_sINICurrentTag - Pointer to the tag been writen to.
		YSI_g_sINIWriteTag - Data for tags,
		YSI_g_sINIWriteFile - Current files been written to.
Commands:
	-
Compile options:
	-
Operators:
	-
-*----------------------------------------------------------------------------*/

// Ini file reading is not distributed.  User file reading may be, though I
// doubt it.

#include <a_samp>

#tryinclude <sscanf>

#include <YSI\y_utils>
#include <YSI\y_bit>

#if !defined MAX_INI_TAG
	#define MAX_INI_TAG                 (16)
#endif

#if !defined MAX_INI_ENTRY_NAME
	#define MAX_INI_ENTRY_NAME          (32)
#endif

#if !defined MAX_INI_ENTRY_TEXT
	#define MAX_INI_ENTRY_TEXT          128
#endif

#define MAX_INI_LINE                    (MAX_INI_ENTRY_NAME + MAX_INI_ENTRY_TEXT + 32)

#define INI_NO_FILE                     (INI:-1)

#if !defined INI_NEW_LINE
	#define INI_NEW_LINE                "\r\n"
#endif

#if !defined INI_MAX_WRITES
	// I doubt many people will use the multiple ini function.
	#define INI_MAX_WRITES              (2)
#endif

#if !defined INI_BUFFER_SIZE
	#define INI_BUFFER_SIZE             (64)
#endif

/*#if INI_BUFFER_SIZE <= 32
	#define INI_BUFFER_BITS 2
#else
	#define INI_BUFFER_BITS Bit_Bits(INI_BUFFER_SIZE)
#endif*/

#if !defined MAX_INI_TAGS
	#define MAX_INI_TAGS 3
/*#else
	#if MAX_INI_TAGS > 32
		#error Current code only supports up to 32 buffer tags
	#endif*/
#endif

#define MAX_INI_STRING                  (64)

enum E_INI_WRITE
{
	E_INI_WRITE_NAME[MAX_INI_ENTRY_NAME],
	E_INI_WRITE_TEXT[MAX_INI_ENTRY_TEXT],
	E_INI_WRITE_NEXT
}

enum E_INI_TAGS
{
	E_INI_TAGS_NAME[MAX_INI_TAG char],
	E_INI_TAGS_START,
	E_INI_TAGS_LAST
}

static stock
	YSI_g_sINIWriteBuffer[INI_MAX_WRITES][INI_BUFFER_SIZE][E_INI_WRITE],
	YSI_g_sINIWritePos[INI_MAX_WRITES],
	YSI_g_sINITagPos[INI_MAX_WRITES],
	YSI_g_sINICurrentTag[INI_MAX_WRITES],
	YSI_g_sINIWriteTag[INI_MAX_WRITES][MAX_INI_TAGS][E_INI_TAGS],
	YSI_g_sINIWriteFile[INI_MAX_WRITES][128];

#define INI_Parse(%1,%2) \
	forward @INI_%1_%2(name[], value[]); \
	@INI_%1_%2(name[], value[])

#define INI:%0[%1](%2) \
	forward @INI_%0_%1(%2); \
	@INI_%0_%1(%2)

#if defined _inc_sscanf
	/*------------------------------------------------------------------------*-
	Function:
		INI_Int
	Params:
		name[] - Name of the INI textual identifier.
		function - Function to call with integer value.
	Return:
		function().
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	#define INI_Int(%1,%2) \
		if(!strcmp((%1),name,true)&&!sscanf(value,"d",%2))return;
		//if(!strcmp(){%2=floatstr(value);return;}
		//if (!strcmp((%1), name, true)) return %2(strval(value))
	
	/*------------------------------------------------------------------------*-
	Function:
		INI_Float
	Params:
		name[] - Name of the INI textual identifier.
		function - Function to call with float value.
	Return:
		function().
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	#define INI_Float(%1,%2) \
		if(!strcmp((%1),name,true)&&!sscanf(value,"f",%2))return;
		//if (!strcmp((%1), name, true)) return %2(floatstr(value))
	
	/*------------------------------------------------------------------------*-
	Function:
		INI_Hex
	Params:
		name[] - Name of the INI textual identifier.
		function - Function to call with hex value.
	Return:
		function().
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	#define INI_Hex(%1,%2) \
		if(!strcmp((%1),name,true)&&!sscanf(value,"h",%2))return;
		//if (!strcmp((%1), name, true)) return %2(hexstr(value))
	
	/*------------------------------------------------------------------------*-
	Function:
		INI_Bin
	Params:
		name[] - Name of the INI textual identifier.
		function - Function to call with binary value.
	Return:
		function().
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	#define INI_Bin(%1,%2) \
		if(!strcmp((%1),name,true)&&!sscanf(value,"l",%2))return;
		//if (!strcmp((%1), name, true)) return %2(binstr(value))
	
	/*------------------------------------------------------------------------*-
	Function:
		INI_String
	Params:
		name[] - Name of the INI textual identifier.
		function - Function to call with string value.
	Return:
		function().
	Notes:
		-
	-*------------------------------------------------------------------------*/
	
	#define INI_String(%1,%2,%3) \
		if(!strcmp((%1),name,true)&&!sscanf(value,"s["#%3"]",%2))return;
		//if (!strcmp((%1), name, true)) return %2(value)
#else
	#define INI_Int(%1,%2) \
		if(!strcmp((%1),name,true)){%2=strval(value);return;}
	
	#define INI_Float(%1,%2) \
		if(!strcmp((%1),name,true)){%2=floatstr(value);return;}
	
	#define INI_Hex(%1,%2) \
		if(!strcmp((%1),name,true)){%2=hexstr(value);return;}
	
	#define INI_Bin(%1,%2) \
		if(!strcmp((%1),name,true)){%2=binstr(value);return;}
	
	#define INI_String(%1,%2,%3) \
		if(!strcmp((%1),name,true)){strcpy(%2,value,%3);return;}
#endif

/*----------------------------------------------------------------------------*-
Function:
	INI_GetEntryName
Params:
	source - The string you want to get an entry name from.
	dest - The place you want to store the entry name to
Return:
	bool: Found the name correctly.
Notes:
	-
-*----------------------------------------------------------------------------*/

stock bool:INI_GetEntryName(source[], dest[], &i)
{
	new
		j;
	while (source[j] && source[j] <= ' ') j++;
	i = j;
	while (source[i] > ' ' && source[i] != '=') i++;
	if (i == j) return false;
	i -= j;
	memcpy(dest, source, j, i * 4, MAX_INI_ENTRY_NAME);
	dest[i] = '\0';
	return true;
}

/*----------------------------------------------------------------------------*-
Function:
	INI_GetEntryText
Params:
	source - The string you want to get an entry from.
	dest - The place you want to store the entry to
Return:
	-
Notes:
-*----------------------------------------------------------------------------*/

stock INI_GetEntryText(source[], dest[], i)
{
	while (source[i] && (source[i] <= ' ' || source[i] == '=')) i++;
	dest[0] = 1;
	dest[1] = '\0';
	if (!source[i]) return;
	strcpy(dest, source[i], MAX_INI_ENTRY_TEXT);
}

/*----------------------------------------------------------------------------*-
Function:
	INI_ParseFile
Params:
	filename[] - The file to load.
	remoteFormat[] - The format string to generate the remote function to
		pass the data to once loaded.
	bool:bFileFirst - The order of the remoteFormat parameters.
	bool:bExtra - Send additional data.
	extra - Additional data to send.
	bLocal - Call local functions instead of gloabal ones.
	bPassTag - Pass the tag as an extra parameter not the function name.
Return:
	-
Notes:
	bFileFirst sets the order and inclusion of the possible remoteFormat
	parameters.  If true the format will add the filename first then the 
	current tag, if false the order will be reversed.  This can also be used
	to exclude one or the other from the function name by setting the required
	parameter to be entered first and then only haing one %s in the format
	sting.  The default order is tag first for languages compatability.
-*----------------------------------------------------------------------------*/

stock bool:INI_ParseFile(filename[], remoteFormat[], bool:bFileFirst = false, bool:bExtra = false, extra = 0, bool:bLocal = true, bool:bPassTag = false)
{
	new
		File:f;
	if (!(f = fopen(filename, io_read))) return false;
	new
		line[MAX_INI_LINE],
		tagName[MAX_INI_STRING],
		function[MAX_INI_STRING],
		comment,
		pos;
	// Strip the extension from the filename.
	comment = chrfind('.', filename);
	if (comment != -1) filename[comment] = '\0';
	// Now reduce it to only the filename, no path.
	while (comment != -1)
	{
		if (filename[comment] == '\\' || filename[comment] == '/')
		{
			//strcpy(filename, filename[comment + 1], MAX_INI_STRING);
			++comment;
			new
				i = 0;
			while ((filename[i] = filename[comment + i]))
			{
				++i;
			}
			break;
		}
		--comment;
	}
	// Set the default tag value.
	if (bFileFirst) format(function, sizeof (function), remoteFormat, filename, "");
	else format(function, sizeof (function), remoteFormat, "", filename);
	// Now read in the whole data.
	while (fread(f, line))
	{
		StripNL(line);
		if (!line[0]) continue;
		new
			stringIdent[MAX_INI_ENTRY_NAME];
		comment = chrfind(';', line);
		if (comment != -1) line[comment] = '\0';
		if (!INI_GetEntryName(line, stringIdent, pos)) continue;
		if (stringIdent[0] == '[' && (comment = chrfind(']', stringIdent)) != -1 && !stringIdent[comment + 1])
		{
			// Got a tag, update the function to call.
			stringIdent[comment] = '\0';
			if (bFileFirst) format(function, sizeof (function), remoteFormat, filename, stringIdent[1]);
			else format(function, sizeof (function), remoteFormat, stringIdent[1], filename);
			strcpy(tagName, stringIdent[1], MAX_INI_STRING);
		}
		else if (function[0])
		{
			new
				stringText[MAX_INI_ENTRY_TEXT];
			INI_GetEntryText(line, stringText, pos);
			// Read in a value - distribute it as required.
			if (bLocal)
			{
				if (bExtra)
				{
					if (bPassTag)
					{
						CallLocalFunction(function, "isss", extra, tagName, stringIdent, stringText);
					}
					else
					{
						CallLocalFunction(function, "iss", extra, stringIdent, stringText);
					}
				}
				else
				{
					if (bPassTag)
					{
						CallLocalFunction(function, "sss", tagName, stringIdent, stringText);
					}
					else
					{
						CallLocalFunction(function, "ss", stringIdent, stringText);
					}
				}
			}
			else
			{
				if (bExtra)
				{
					if (bPassTag)
					{
						CallRemoteFunction(function, "isss", extra, tagName, stringIdent, stringText);
					}
					else
					{
						CallRemoteFunction(function, "iss", extra, stringIdent, stringText);
					}
				}
				else
				{
					if (bPassTag)
					{
						CallRemoteFunction(function, "sss", tagName, stringIdent, stringText);
					}
					else
					{
						CallRemoteFunction(function, "ss", stringIdent, stringText);
					}
				}
			}
		}
	}
	fclose(f);
	return true;
}

/*----------------------------------------------------------------------------*-
Function:
	INI_Load
Params:
	filename[] - The file to load.
	bool:bExtra - Send additional data.
	extra - Additional data to send.
	bLocal - Call local functions instead of gloabal ones.
Return:
	INI_ParseFile
Notes:
	Wrapper for INI_ParseFile to use standard API features so people can
	worry even less.  Designed for use with INI_Parse.
-*----------------------------------------------------------------------------*/

stock bool:INI_Load(filename[], bool:bExtra = false, extra = 0, bool:bLocal = true)
{
	return INI_ParseFile(filename, "@INI_%s_%s", true, bExtra, extra, bLocal, false);
}

/*----------------------------------------------------------------------------*-
Function:
	INI_Open
Params:
	filename[] - INI file to open.
Return:
	INI - handle to the file or INI_NO_FILE.
Notes:
	Doesn't actually open the file, just starts a new buffer if possible.
-*----------------------------------------------------------------------------*/

stock INI:INI_Open(filename[])
{
	new
		i;
	for (i = 0; i < INI_MAX_WRITES; i++)
	{
		if (!YSI_g_sINIWriteFile[i][0]) break;
	}
	if (i == INI_MAX_WRITES)
	{
		return INI_NO_FILE;
	}
	strcpy(YSI_g_sINIWriteFile[i], filename, sizeof (YSI_g_sINIWriteFile[]));
	YSI_g_sINIWritePos[i] = 0;
	YSI_g_sINITagPos[i] = 0;
	// Reset tags.
	YSI_g_sINICurrentTag[i] = 0;
	YSI_g_sINIWriteTag[i][0][E_INI_TAGS_NAME][0] = '\0';
	YSI_g_sINIWriteTag[i][0][E_INI_TAGS_START] = -1;
	return INI:i;
}

/*----------------------------------------------------------------------------*-
Function:
	INI_Close
Params:
	INI:file - Handle to the ini to close.
Return:
	-
Notes:
	Writes any outstanding buffer data to the file and ends the stream.
-*----------------------------------------------------------------------------*/

stock INI_Close(INI:file)
{
	if (YSI_g_sINIWritePos[_:file]) INI_WriteBuffer(file);
	YSI_g_sINIWriteFile[_:file][0] = '\0';
}

/*----------------------------------------------------------------------------*-
Function:
	INI_SetTag
Params:
	INI:file - INI file handle to write to.
	tag[] - Name of the new file subsection for subsequent data to write to.
Return:
	-
Notes:
	Sets a new [tag] section header.  Subsequent data is written under this
	header.  Uses lists for constant tag switching and checks the tag doesn't
	already exist.
-*----------------------------------------------------------------------------*/

stock INI_SetTag(INI:file, tag[])
{
	if (file < INI:0 || file >= INI:INI_MAX_WRITES) return;
	new
		pos = YSI_g_sINITagPos[_:file];
	for (new i = 0; i < pos; i++)
	{
		if (YSI_g_sINIWriteTag[_:file][i][E_INI_TAGS_NAME][0] && !strcmp(tag, YSI_g_sINIWriteTag[_:file][i][E_INI_TAGS_NAME], true))
		{
			YSI_g_sINICurrentTag[_:file] = i;
			return;
		}
	}
	// Allow untagged data (not sure how it will go down...).
	if (pos == 0 && YSI_g_sINIWriteTag[_:file][0][E_INI_TAGS_START] != -1)
	{
		++pos;
		++YSI_g_sINITagPos[_:file];
	}
	if (pos >= MAX_INI_TAGS)
	{
		if (!INI_WriteBuffer(file)) return;
		// Loop.
		pos = 0;
	}
	//strcpy(YSI_g_sINIWriteTag[_:file][pos][E_INI_TAGS_NAME], tag, MAX_INI_TAG);
	strpack(YSI_g_sINIWriteTag[_:file][pos][E_INI_TAGS_NAME], tag, MAX_INI_TAG);
	YSI_g_sINIWriteTag[_:file][pos][E_INI_TAGS_START] = -1;
	YSI_g_sINICurrentTag[_:file] = pos;
	++YSI_g_sINITagPos[_:file];
}

/*----------------------------------------------------------------------------*-
Function:
	INI_AddToBuffer
Params:
	INI:file - INI file to write to.
	name[] - Data name to write.
	data[] - Data to write.
Return:
	-
Notes:
	First checks the name doesn't already exist under the current tag header
	and if it does overwrites the current value.  If not checks there's room
	in the buffer to write to and purges the buffer if not.  Finally saves the
	data in the buffer for writing when required and adds the data to the
	relevant list for tag inclusion.
-*----------------------------------------------------------------------------*/

static stock INI_AddToBuffer(INI:file, name[], data[])
{
	if (file < INI:0 || file >= INI:INI_MAX_WRITES)
	{
		return 0;
	}
	new
		pos = YSI_g_sINIWritePos[_:file],
		tmptag = YSI_g_sINICurrentTag[_:file],
		start = YSI_g_sINIWriteTag[_:file][tmptag][E_INI_TAGS_START];
	while (start != -1)
	{
		if (!strcmp(name, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NAME], true))
		{
			strcpy(YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT], data, MAX_INI_ENTRY_TEXT);
			//strpack(YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT], data, MAX_INI_ENTRY_TEXT);
			return 1;
		}
		start = YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NEXT];
	}
	if (pos >= INI_BUFFER_SIZE)
	{
		if (!INI_WriteBuffer(file))
		{
			return 0;
		}
		INI_SetTag(file, YSI_g_sINIWriteTag[_:file][tmptag][E_INI_TAGS_NAME]);
		pos = 0;
	}
	new
		curtag = YSI_g_sINICurrentTag[_:file];
	if (YSI_g_sINIWriteTag[_:file][curtag][E_INI_TAGS_START] == -1) YSI_g_sINIWriteTag[_:file][curtag][E_INI_TAGS_START] = pos;
	else YSI_g_sINIWriteBuffer[_:file][YSI_g_sINIWriteTag[_:file][curtag][E_INI_TAGS_LAST]][E_INI_WRITE_NEXT] = pos;
	strcpy(YSI_g_sINIWriteBuffer[_:file][pos][E_INI_WRITE_NAME], name, MAX_INI_ENTRY_NAME);
	//strpack(YSI_g_sINIWriteBuffer[_:file][pos][E_INI_WRITE_NAME], name, MAX_INI_ENTRY_NAME);
	strcpy(YSI_g_sINIWriteBuffer[_:file][pos][E_INI_WRITE_TEXT], data, MAX_INI_ENTRY_TEXT);
	YSI_g_sINIWriteBuffer[_:file][pos][E_INI_WRITE_NEXT] = -1;
	YSI_g_sINIWriteTag[_:file][curtag][E_INI_TAGS_LAST] = pos;
	YSI_g_sINIWritePos[_:file]++;
	return 1;
}

/*----------------------------------------------------------------------------*-
Function:
	INI_RemoveEntry
Params:
	INI:file - File to write to.
	name[] - Item to remove.
Return:
	-
Notes:
	Wrapper for INI_AddToBuffer for removing data.
-*----------------------------------------------------------------------------*/

stock INI_RemoveEntry(INI:file, name[])
{
	static
		sData[2] = {-1, 0};
	INI_AddToBuffer(file, name, sData);
}

/*----------------------------------------------------------------------------*-
Function:
	INI_WriteString
Params:
	INI:file - File to write to.
	name[] - Data name.
	data[] - Data.
Return:
	-
Notes:
	Wrapper for INI_AddToBuffer for strings.
-*----------------------------------------------------------------------------*/

stock INI_WriteString(INI:file, name[], data[])
{
	INI_AddToBuffer(file, name, data);
}

/*----------------------------------------------------------------------------*-
Function:
	INI_WriteInt
Params:
	INI:file - File to write to.
	name[] - Data name.
	data - Integer data.
Return:
	-
Notes:
	Wrapper for INI_AddToBuffer for integers.
-*----------------------------------------------------------------------------*/

stock INI_WriteInt(INI:file, name[], data)
{
	INI_AddToBuffer(file, name, numstr(data));
}

/*----------------------------------------------------------------------------*-
Function:
	INI_WriteFloat
Params:
	INI:file - File to write to.
	name[] - Data name.
	Float:data - Float data.
	accuracy - number of decimal places to write.
Return:
	-
Notes:
	Wrapper for INI_AddToBuffer for floats.  Uses custom code instead of
	format() as it's actually faster for something simple like this.
-*----------------------------------------------------------------------------*/

stock INI_WriteFloat(INI:file, name[], Float:data, accuracy = 6)
{
	new
		str[32];
	format(str, sizeof (str), "%.*f", accuracy, data);
	INI_AddToBuffer(file, name, str);
}

/*----------------------------------------------------------------------------*-
Function:
	INI_WriteBuffer
Params:
	INI:file - INI stream to write to file.
Return:
	Success/fail.
Notes:
	Opens the required file for reading and a temp file for read/writing.  Goes
	through the entire file reading all contained data.  If it reaches a tag
	line ([tag_name]) it dumps any unwritten data from the last tag (if there
	was one) and starts processing the new tag.  While a tag is being processed
	every line is compared against the UNWRITTEN new data for that tag in the
	buffer, if they're the same it writes the new data instead (it also writes
	any comments which were after the data in the original line back), else it
	writes the original line back.
	
	Once all the new data is written to the temp file any tags which haven't
	been processed at all (i.e. were not found in the original file) are
	written to the temp file along with all their data.  The original file is
	then destroyed and reopend and all the data copied out from the temp file
	to the newly opened original file, closed and saved.
-*----------------------------------------------------------------------------*/

static stock INI_WriteBuffer(INI:file)
{
	if (_:file < 0 || _:file >= INI_MAX_WRITES) return 0;
	new
		File:buffer = fopen("_temp_ysi_user_file_.ysi", io_write),
		File:source = fopen(YSI_g_sINIWriteFile[_:file], io_read);
	if (buffer)
	{
		new
			line[MAX_INI_LINE],
			BitArray:read<INI_BUFFER_SIZE>, //:read[INI_BUFFER_BITS],
			writing = 0,
			//Bit:tagswritten,
			BitArray:tagswritten<MAX_INI_TAGS>,
			tagpos = YSI_g_sINITagPos[_:file],
			start = -1,
			blank;
		// Write tagless data.
		if (!YSI_g_sINIWriteTag[_:file][0][E_INI_TAGS_NAME][0])
		{
			start = YSI_g_sINIWriteTag[_:file][0][E_INI_TAGS_START];
			// Will be -1 if there is no tagless data.
			if (start != -1)
			{
				writing = 1;
				Bit_Set(tagswritten, 0, true);
			}
		}
		if (source)
		{
			while (fread(source, line))
			{
				new
					pos = 1;
				for (new i = 0; line[i]; i++)
				{
					if (line[i] == ';')
					{
						goto INI_WriteBuffer_cont1;
					}
					else if (line[i] > ' ')
					{
						// Determine that the line is not blank.
						pos = 0;
						break;
					}
				}
				if (pos)
				{
					blank++;
					continue;
				}
				if (line[0] == '[' && (pos = chrfind(']', line)) != -1 && endofline(line, pos + 1))
				{
					pos--;
					writing = 0;
					new
						form[MAX_INI_LINE];
					// Reached a new tag - flush the rest of the last tag.
					while (start != -1)
					{
						if (!Bit_GetBit(read, start))
						{
							if (YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT][0] != -1)
							{
								format(form, sizeof (form), "%s = %s" INI_NEW_LINE, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NAME], YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT]);
								fwrite(buffer, form);
							}
							Bit_Set(read, start, true);
						}
						start = YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NEXT];
					}
					while (blank--) fwrite(buffer, INI_NEW_LINE);
					blank = 0;
					// Note the start of the new tag.
					for (new j = 0; j < tagpos; j++)
					{
						//if (!Bit_Get(tagswritten, j) && !YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_NAME][pos] && !strcmp(YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_NAME], line[1], true, pos))
						if (!Bit_Get(tagswritten, j) && !strcmp(YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_NAME], line[1], true, pos))
						{
							writing = 1;
							start = YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_START];
							//tagswritten |= Bit:(1 << j);
							Bit_Set(tagswritten, j, true);
							break;
						}
					}
				}
				else if (writing)
				{
					new
						name[MAX_INI_ENTRY_NAME],
						temp,
						liststart = start;
					INI_GetEntryName(line, name, temp);
					pos = chrfind(';', line, temp);
					while (blank--) fwrite(buffer, INI_NEW_LINE);
					blank = 0;
					while (start != -1)
					{
						if (!Bit_GetBit(read, start) && !strcmp(name, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NAME]))
						{
							Bit_Set(read, start, true, INI_BUFFER_SIZE);
							// Delete the current entry from the file, as per
							// our request.
							if (YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT][0] == -1)
							{
								// Can't use "continue" as we're in an inner
								// loop.
								goto INI_WriteBuffer_cont2;
							}
							if (pos != -1)
							{
								format(line, sizeof (line), "%s = %s %s", name, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT], line[pos]);
							}
							else
							{
								format(line, sizeof (line), "%s = %s" INI_NEW_LINE, name, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT]);
							}
							start = -1;
						}
						else
						{
							start = YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NEXT];
						}
					}
					start = liststart;
				}
				INI_WriteBuffer_cont1:
				fwrite(buffer, line);
				INI_WriteBuffer_cont2:
			}
			// Write any data from this tag group not in the original file.
			// I.e. flush the final read tag.
			while (start != -1)
			{
				if (!Bit_GetBit(read, start))
				{
					if (YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT][0] != -1)
					{
						format(line, sizeof (line), "%s = %s" INI_NEW_LINE, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NAME], YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT]);
						fwrite(buffer, line);
					}
				}
				start = YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NEXT];
			}
			fclose(source);
		}
		// Write any tag groups not found in the original file.
		for (new j = 0; j < tagpos; j++)
		{
			//if (!(tagswritten & Bit:(1 << j)))
			if (!Bit_Get(tagswritten, j))
			{
				start = YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_START];
				if (j || YSI_g_sINIWriteTag[_:file][0][E_INI_TAGS_NAME][0])
				{
					//printf("%s", YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_NAME]);
					strunpack(line, YSI_g_sINIWriteTag[_:file][j][E_INI_TAGS_NAME]);
					format(line, sizeof (line), "[%s]" INI_NEW_LINE, line);
					fwrite(buffer, line);
				}
				while (start != -1)
				{
					if (YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT][0] != -1)
					{
						format(line, sizeof (line), "%s = %s" INI_NEW_LINE, YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NAME], YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_TEXT]);
						fwrite(buffer, line);
					}
					start = YSI_g_sINIWriteBuffer[_:file][start][E_INI_WRITE_NEXT];
				}
			}
		}
		fclose(buffer);
		// This renames the file back (by copying all the data).
		fremove(YSI_g_sINIWriteFile[_:file]);
		#if defined _inc_TODO_COPY_INC
		#else
			#if defined _int_TODO_OTHER_COPY_INC
			#else
				source = fopen(YSI_g_sINIWriteFile[_:file], io_write);
				buffer = fopen("_temp_ysi_user_file_.ysi", io_read);
				if (source && buffer)
				{
					while (fread(buffer, line)) fwrite(source, line);
					fclose(source);
					fclose(buffer);
				}
				fremove("_temp_ysi_user_file_.ysi");
			#endif
		#endif
		// Reset the write buffer.
		YSI_g_sINITagPos[_:file] = 0;
		YSI_g_sINIWritePos[_:file] = 0;
		YSI_g_sINICurrentTag[_:file] = 0;
		return 1;
	}
	return 0;
}
