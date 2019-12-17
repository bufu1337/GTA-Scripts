SA-MP Plugin :: Map Andreas v1.0 beta
by Kye/SA-MP team 2010
----------------------------------

This plugin is designed to read San Andreas map related information from
provided data files and provide useful functions to the SA-MP pawn scripts.

This version contains a heightmap of the San Andreas geometry and provides
a function to obtain the highest ground position from a provided 2D point.

Important:

- This plugin uses approximately 70MB of RAM. If you are using shared hosting,
please confirm with your host that this is okay.

Installation:

- Extract the contents of the zip in to your SA-MP server folder/directory.
- Windows Server: edit server.cfg and add the line: plugins MapAndreas
- Linux Server: edit server.cfg and add the line: plugins MapAndreas.so

Revision history:

v1.0 beta
---------
Initial test version.

Pawn Natives:

native MapAndreas_Init(mode); // Used to initalise the data files in to
  memory - should be called at least once before any other function.

native MapAndreas_FindZ_For2DCoord(Float:X, Float:Y, &Float:Z); // return
  highest Z point (ground level) for the provided X,Y co-ordinate.

Included files:

plugins/MapAndreas.dll - The Windows dll plugin.
plugins/MapAndreas.so - The linux shared object plugin.
scriptfiles/SAfull.hmap - The San Andreas heightmap data.
scriptfiles/SAfull.jpg - A graphical representation of the heightmap data.
pawno/include/mapandreas.inc - The pawn include for the MapAndreas plugin natives.
filterscripts/mapandreas_test.amx - A filterscript with a test command /glvl
filterscripts/mapandreas_test.pwn - Pawn script source for the above filterscript.

License:

The binaries, data files, and source code provided in this package may
only be used in conjunction with the SA-MP modification. For other uses
please request permission from the author.

----------------------------------
