///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
///                                                                             ///
///                       !damo!spiderman's CAR SELECTOR 0.2                    ///
///                                                                             ///
///////////////////////////////////////////////////////////////////////////////////
///                                                                             ///
/// 1. This is a FilterScript. Make sure it is in your Filterscripts Folder.    ///
///                                                                             ///
/// 2. Add the name of this file to the line filterscripts in your server.cfg   ///
///                                                                             ///
/// 3. Add carDefines.def into your scriptfiles Folder                          ///
///                                                                             ///
/// 4. Edit carDefines.def with own vehicle defines.                            ///
///                                                                             ///
/// 5. * denotes a Car Type Heading                                             ///
///                                                                             ///
/// 6. Make sure there is no blank returns(blank newlines) in carDefines.def    ///
///                                                                             ///
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////


Fix for Player Spawn Issue

In your main gamemode script add the following

Somewhere at the top of your script before main() add
-----------------------------------------------------

forward CarSelectMenu( playerid, i );
new carSelectMenu[MAX_PLAYERS];


----------------------------------------------------

Somewhere near the bottom of your script add

---------------------------------------------------

public CarSelectMenu( playerid, i )
{
	carSelectMenu[playerid] = i;
}


----------------------------------------------------

And Under the OnPlayerSpawn(playerid){

add
-------------------------------------------------

	if( carSelectMenu[playerid] == 1 ){
	    return 0;
	}

----------------------------------------------