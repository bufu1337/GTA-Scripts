DeAMX, trc_'s .amx -> .pwn decompiler
  v0.3

Licence

	You may:
	- Use this program free of charge
	- Modify it
	- Redistribute it with your changes, provided you keep
	  the name of the original author (i.e. don't pretend you
	  made it all by yourself) and this licence, and mention
	  that you changed it (plus eventually what changes you made).
	- Use parts of this program in your own scripts, again
	  provided you mention that you used code from DeAMX and
	  name its author.
	  
	You are not allowed to:
	- Distribute this program, with or without changes, with the
	  name of the author and/or this licence removed, and/or with
	  the claim that you or someone else than the original author
	  made it, because you didn't.
	- Sell this program or a derivation of it.

Disclaimer:

	The author is in no way responsible for what you do with this
	decompiler. You are not allowed to decompile someone else's
	script and re-release it as your own script, unless explicitely
	approved by the script's author.

Usage

	DeAMX is a collection of Lua scripts, which means you need
	Lua to run it. If you don't have Lua yet, you can get it for
	free from the official download page:
	  http://luabinaries.luaforge.net/download.html

	Once you have Lua, there are two ways to decompile a script:
	- Place the .lua files and the .bat file in some folder,
	  edit the bat file in a text editor like Notepad, and make
	  sure the path to lua5.1.exe is correct. Save the file and
	  close it.
	  
	  To run, open a command prompt in the folder where you placed
	  deamx, and type:
	  
		deamx path\to\amxfile.amx
	  
	- Or, place the .lua files in the folder where you installed
	  Lua, open a command prompt in the Lua folder, and type:
	  
		lua5.1 deamx.lua path\to\amxfile.amx
		
	In both cases, the .amx file will be decompiled and the
	resulting code will be placed in a .pwn file in the same
	directory as the .amx file.

Changelog

	2008/02/08: v0.3
		- Feature: Recognized types of function arguments are now propagated
		- Feature: Return types of functions are now recognized
		- Some minor fixes

	2008/02/03: v0.2.1
		- Fix: dimensions of global arrays with dimensions of the form [1][X]
		  were not recognized correctly

	2008/02/01: v0.2
		- Fix: signed number -64 was loaded as +64 during decompression
		- Feature: ternary operators (condition ? truepart : falsepart) are now recognized
		- Feature: pre-/post increment/decrement are now recognized
		- Several other minor fixes
	
	2008/01/30: v0.1
		initial public release
