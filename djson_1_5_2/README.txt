/*
 *            DJson 1.5.2
 *       (c) Copyright 2008 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 20th Aug 2008
 * @update    : 21st Sep 2008
 *
 * This file is provided as is (no warranties).
 *
 * DJson is released under the terms of MIT License
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */
 
What is djson?

DracoBlue's djson is a dynamic json reader/writer for the pawn language. JSON
(JavaScriptObjectNotation) is a light weight encoding for data structures and
used to describe javascript objects.



Official Website

http://dracoblue.net/djson


Why use djson?

If you are fimilar with ini-files and used for example dini in the past, you
remember the file-content, like:
var1=value
var2=value2
spawn.x=val4
... and so on.

Actually creating lists of elements (arrays) is difficult and ini files are not
made for that.

In djson files you can write the following:
{
	"name":"DracoBlue",
	"vehicles":["PCJ","Cheetah","Banshee"],
	"position":{"x":1.2,"y":1.3,"z":10}
}
As you can see, we have an object, with the name DracoBlue, a position with x,y
and z coordinates and a list of favourite vehicles.


Reading Elements

With djson you can access each of the elements by its relative location.

E.g.:
dj("test.json","position/x") -- 1.2
dj("test.json","name") -- DracoBlue

You can even access a specific item of them vehicles list:
dj("test.json","vehicles/1") -- Cheetah

If you want to know how much elements a specific list has, you can use:
djCount("test.json","vehicles") -- 3


Writing Elements

Writing Elements to a djson-file is as simple as with dini for ini files.

E.g.:
djSet("test.json","name","Draco") -- set's the name to Draco
djSet("test.json","age","23") -- Create a new value called age and set
									the value to 23

But since djson also supports lists you may set a specific element of the list,
with the following syntax:
djSet("test.json","vehicles/1","NRG") -- replace vehicle 1 with NRG

If you want to append an element to the list, you can use:
djAppend("test.json","vehicles","NRG") -- append NRG to the list



Spotlight on technical implementation

The reader for json-files is a token-based reader, which expects a scope with the
following notation:
	scope = [] | [ array_values ] | { } | { object_values } | string | number
	string = ".*" (",\,\r,\n,\t are escaped with a trailing \)
	number = [1-9][0-9]* | 0.[0-9]* | 0 | -[1-9][0-9]* | -0.[0-9]*
	array_values = scope | scope more_array_value
	more_array_values = , scope | , scope more_array_values
	object_values = string : scope | string : scope more_object_values
	more_object_values = , string : scope | string : scope more_object_values
	