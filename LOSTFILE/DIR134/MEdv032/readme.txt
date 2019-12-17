MapEditor (MEd) (C) 2005-2006 Tony Wroblewski

N.B. This software is still in an early-beta testing phase. Please backup your installation before using this software.

Welcome to MEd (MapEditor)!. MEd is a map editing utility for GTA III, Vice City And San Andreas. MEd will allow you to add, move and delete objects on the map using a simple drag, new, copy and paste technique. Tutorials are available on www.gtaforums.com.

In order to use textures in this tool, your graphics card must support the s3tc OpenGL extension. You should ensure you update to the latest drivers as the default Windows XP drivers on some cards do not support the required opengl extensions. To find out whether your system is supported, launch MEd and select the About My Computer option from the menu. Verify the, S3TC extension is supported.

When reporting graphical glitches and texture problems, please launch MEd and Select Help > About My Computer. Copy and paste the information given into your bug report.



************************************************************
**		  Hardware Information  	          **
************************************************************

This utility has been tested and verified on the following cards
* NVIDIA Geforce 6600
* NVIDIA Geforce 3 TI
* ATI Radeon 9550
* ATI Radeon 8500

For NVIDIA you MUST install the latest forceware drivers from nvidia's website. Not doing so, will prevent MEd from running.
For ATI cards you MUST install the latest catalyst drivers from ATI's website. Again, not doing so will prevent MEd from running.

************************************************************
**	IMPORTANT INFORMATION - Read Before Using         **
************************************************************

* If you have Version 2.0 of San Andreas, do not attempt to modify the image archive in anyway, as it is protected. It it highly recommended you set the Read-Only attribute on your image archive or replace the gtasa.exe with a Version 1.0 executable.

* Please backup your installation before using this software, this includes the image file archive which contains the Binary IPL files.

* Uncheck the Read-Only attribute before saving, otherwise your changes will be lost (Unless you don't want them to be saved)

* Editing and Removing Binary IPL instances may cause unwanted effects and crashes. Only delete objects if you know what you are doing, ensuring they are not used or referenced by anything else in the game.

* This utility cannot be used to edit 2DFX, Paths, Colfiles, Enex and parked cars. These features may be added later on, but for now the major goal is to get the editor stable.

* GTA III and Vice City do not support more than one IMG Archive. San Andreas will allow you to create additional archives, which is recommended if you add your own objects into the game

* Please use the default filepaths provided when creating new objects, as I haven't added correct error checking in yet, and straying from the default paths may cause the game to crash.

* There is basic colfile support which will allow you to view collision files, at the moment only basic functionality is available. Colfile support will be expanded on in later releases.

* If you are using ZModeler, ensure you are using the latest dff filter (build 202), as the older versions have known problems in game as well as in the editor. Thanks to bokkers for pointing this out

***********************************************************
**			ChangeLog			 **
***********************************************************
	
29th November 2005 - Version 0.1a
* Initial Release


05th December 2005 - Version 0.11a
* Changed Name to MEd - Short for Mapeditor
* Updated controls, now uses W,S,A,D for movement, much smoother
* Added Edit Locking and Mouse Sensitivity Control
* Binary IPL Editing (Still no Deletion)
* Ability to select multiple games using a friendly treeview
* Renamed config file to med.ini
* Correct a couple of bugs with the IPL reader, specifically to do with Myriad Islands MOD
* Attempted to fix flicker on dragging for some graphics card
* Removed Palette extension and implemented ASM routine. Should work on all systems now
* Fixed a couple of DFF rendering errors
* Added Select All and Render options to MapFile List
* Added Graphics Card Checks to various areas of Texture Loader
* Added LOD Object viewer to IPL Editor window (Read-Only ATM)

08th December 2005 - Version 0.12a
* Updated IDEBrowser to allow the use of cursor (Faster Browsing)
* Forced stricter name checking on TXD Archives, to prevent duplicates
* Re-enabled Deletion (Still causes Random Crashes in game!)
* Navigation with the Arrow Keys as well as W,S,A,D
* Fine Tuning Moving for select objects using Arrow Keys
* Sorting and Search for IDE Treeview
* Sorting and Search for IPL Treeview
* Adding Sorting and Search to Item Chooser
* Game Chooser interface changes and ability to remember last install
* Bookmark Tools (Remembers commonly used positions on the map) - Separate Config file from med.ini to allow distributing co-ordinates easier.
* Changed a couple of icon graphics and Intro Wizard
* Bug Fixes for adding objects to map
* Fixed a couple of rendering problems in San Andreas
* Stricter checking for Treeviews
* Adding New Object automatically centres on it
* Fixed texture viewer not displaying the generic texture dictionary file

15th December 2005 - Version 0.20a
* Fixed major rendering bug with IPL reader (all objects in Vegasn.ipl, countrye.ipl now render correctly)
* Added information about graphics card extensions to help Window
* Fixed objects and textures disappearing when using the dffview, txdview and idebrowser.
* Speeded up DFF rendering slightly
* Added Image Archive Tool and ability to add custom objects into the game.
* Added IDE Parameter flags dialog and redesigned entire dialog.
* Tidied up Main Window, reducing clutter.
* Fixed multiple deletion for IPL and IDE Trees
* Ability to extract DFF and TXD straight from the map
* Ability to replace an item on the map using the context menu
* Added support for TXD.img for GTA III (Contains uncompressed Textures)
* Added Properties to Right-Click Object Menu
* IPL Dialog has been made smaller and less intrusive.
* Added Movement Speed Slider Option (Used to control how fast the shift key increases speed)
* Real Lighting for Objects without Textures
* Fullscreen Mode
* Updated all controls, multiple key presses now work. 
* Moved Keyboard Help screen to the help menu

16th December 2005 - Version 0.20b  
* Small Bug Fixes
* Added Reset Rotation Button to IPLEditor
* Tidied up loading Dialogs
* Added Preliminary COLL & COL3 support (To be used in next release).

22th December 2005 - Version 0.21b
* Fixed Centre on Object
* Fixed New Item Placement
* Added Centre on Object to Context Menu
* COLL/COL3 Rendering Mode
* Basic Undo for Mapview (paste, delete or new item)
* Collision File Properties Window
* Fixed Rotation for separate GL Windows (DFFView, COLView and TXDView)
* Fixed Bug when adding new IMG Archive
* Added Bounding Spheres and Boxes to Item Selection
* Made Progress Bars show overall progress
* Added Error warnings when OpenGL context fails to be created.
* Small Interface Bug Fixes
* Adding New Items using the IPLTree will automatically centre the view
* Fixed Keyboard Focus with GLView
* Changed OpenGL context creation order
* Stopped the IPLEditor window hogging the screen

12th January 2006 - Version 0.22b

* Options for hiding sidebar, statusbar and toolbar
* Extra key mappings for fullscreen mode
* Bug Fixes
* Moved IPLEditor into the sidebar, adding extra buttons for movement
* Add grid lines to selected item, to match new buttons in IPLEditor
* Better lighting on COL file renders
* Allowed File and ID to be changed in IPLEditor, added verification Icons
* Added LODBrowser for choosing LODS in San Andreas
* Changed Key mapping for "Space" to Centre on Object
* Support for changing the GTA installation whilst the program is running
* Added Duplicate Item button to context menu
* Added warning when system does not support hardware accelleration
* Added Wireframe mode for Collision File viewer

2nd February 2006 - Version 0.30b

* Added Multiple Item Selection Support (Hold down Shift whilst selecting, right-clicking)
* Double-clicking on an IPL in the Scene Tab will centre it on the map
* Better Memory Allocation/Deallocation
* Remove automatic centre on map when loading additional IPL files
* Fixed bug in Scene Tab
* Better Undo support (Upto 5 last actions)
* Added Redo Option
* Made Keyboard Controls Window Resizable
* Removed the now redundtant, Editing Enabled option
* Made Bookmarks Window resizable, and remove stripy effect
* Make "<<" and ">>" buttons in the IPL properties window auto-repeat
* Fixed problem in item properties where identifier effected wrong object
* Fixed right-click Paste altering the item properties window
* Fixed crash preventing some Vice City/Myriad Islands installs from loading
* Stopped Progress Bar Flicker

20th March 2006 - Version 0.31
* Allowed Window to Resize Vertically
* Save settings on exit, MouseSpeed, Sidebar, Statusbar, Toolbar, Window Size and Position
  Other settings such as object mode are not saved.
* Undo and Redo buttons are only active when there is something to undo/redo.
* Added optimizations to object loading
* Moved various scene options to main menu
* Added a selection mode option which changes the behaviour of the mouse left click. When selected, the Alt key moves the camera as opposed to the object, reversing the default effect.
* Fixed new IPL file bug, should be able to create new IPL files without program crashing

25th April 2006 - Version v0.32
* Fixed Deleting IPL File bug
* Added Support for rotating and moving multiple objects using IPL Selection control window
* Reduced step size on IPL Selection Window
* Fixed Maximize/Minimize bug in registry
* Fixed Hiding Of The Toolbar with toolbar context menu
* Fixed Hiding of the Sidebar with the viewing menu
* Changed Behaviour of Select All/Deselect All on visible files list to check which items are manually selected
* Prevented User from pasting/copying and adding items to IPL files not marked as visible, prevents confusing behaviour
* Reduced Sensitivity of Up/Down camera control
* Added topdown view button, allows you to easily find an object, select top down, right-click on area of map and select Centre on object











