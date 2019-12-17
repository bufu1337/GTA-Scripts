/*

For Sid and Mione's Pirate RPG. Basic inventory framework using clickable textdraws.

By Mione Auchindoun
2013 - 2015 ®

For feedback, add my Skype:
paintthetown_red

Xoxoxo

*/

#include <a_samp>
#include <fixes>

#include <zcmd>
#include <sscanf2>

#define INV_TXD_BACKGROUND_COL      (0xBCD69477)
#define INV_TXD_TILE_COL      		(0xD6D6D6AA)
#define INV_TXD_TILE_INFO_COL      	(0x91A17AFF)

#define MAX_INV_ITEMS               (24)
#define INVALID_ITEM_ID             (999)

#define MAX_VIS_TILES               (12)

new PlayerText: InventoryTD 	 [ 6 ] 				[ MAX_PLAYERS ],
	PlayerText: InventoryTD_Tile [ MAX_VIS_TILES  ] [ MAX_PLAYERS ],
	PlayerText: InventoryTD_Name [ MAX_VIS_TILES  ] [ MAX_PLAYERS ],
	PlayerText: InventoryTD_Qty  [ MAX_VIS_TILES  ] [ MAX_PLAYERS ],
	PlayerText: InventoryTD_Prev [ MAX_VIS_TILES  ] [ MAX_PLAYERS ],
	PlayerText: InventoryTD_Use	 [ 9 ]				[ MAX_PLAYERS ];


new pInventoryPage 			[ MAX_PLAYERS char ];
new pExaminingItem          [ MAX_PLAYERS char ];
new pLoadedInventory        [ MAX_PLAYERS char ];

new bool: pHasInventoryOpen [ MAX_PLAYERS char ];

new pInventoryItem 		[ MAX_PLAYERS ] [ MAX_INV_ITEMS ];
new pInventoryItemQty 	[ MAX_PLAYERS ] [ MAX_INV_ITEMS ];

enum invItems {
	itemID,
	itemName [ 32 ],
	itemModel,
	itemType
};

enum {
	ITEM_TYPE_EQUIPABLE,
	ITEM_TYPE_USABLE,
	ITEM_TYPE_CONSUMABLE,
	ITEM_TYPE_MISCALLENEOUS
}

new const itemArray [ ] [ invItems ] = {
//    id        name                model       type
	{ 0, 		"One", 				1337, 		ITEM_TYPE_MISCALLENEOUS },
	{ 1, 		"Two", 				1338, 		ITEM_TYPE_EQUIPABLE },
	{ 2, 		"Three",			1336, 		ITEM_TYPE_USABLE },
	{ 3, 		"Four", 			1339, 		ITEM_TYPE_CONSUMABLE },
	{ 4,		"Five", 			1340, 		ITEM_TYPE_EQUIPABLE },
	{ 5, 		"Six", 				1341, 		ITEM_TYPE_EQUIPABLE },
	{ 6,		"Seven", 			1342, 		ITEM_TYPE_EQUIPABLE },
	{ 7,	 	"Eight", 			1343, 		ITEM_TYPE_EQUIPABLE },
	{ 8,		"Nine", 			1344, 		ITEM_TYPE_EQUIPABLE },
	{ 9,		"Ten", 				1345, 		ITEM_TYPE_EQUIPABLE },
	{ 10,		"Eleven", 			1346, 		ITEM_TYPE_EQUIPABLE },
	{ 11,		"Twelve", 			1347, 		ITEM_TYPE_EQUIPABLE },
	{ 12,		"Thirteen", 		1348,		ITEM_TYPE_EQUIPABLE },
	{ 13,		"Fourteen", 		1349,		ITEM_TYPE_EQUIPABLE },
	{ 14,		"Fifteen", 			1350,		ITEM_TYPE_EQUIPABLE },
	{ 15,		"Sixteen", 			1351, 		ITEM_TYPE_EQUIPABLE },
	{ 16, 		"Seventeen", 		1352, 		ITEM_TYPE_EQUIPABLE },
	{ 17,		"Eighteen", 		1353, 		ITEM_TYPE_EQUIPABLE },
	{ 18,		"Nineteen", 		1354, 		ITEM_TYPE_EQUIPABLE },
	{ 19, 		"Twenty", 			1355,		ITEM_TYPE_EQUIPABLE },
	{ 20, 		"Twenty one", 		1356, 		ITEM_TYPE_EQUIPABLE },
	{ 21, 		"Twenty two", 		1357, 		ITEM_TYPE_EQUIPABLE },
	{ 22, 		"Twenty three", 	1358, 		ITEM_TYPE_EQUIPABLE },
	{ 23, 		"Twenty four", 		1359, 		ITEM_TYPE_EQUIPABLE }
};

public OnPlayerDisconnect( playerid ) {
	UnloadInventory ( playerid ) ;
	UnloadExaminePage ( playerid );

	return true;
}

// When players press ESC...
public OnPlayerClickTextDraw(playerid, Text: clickedid) {
    if(clickedid == Text:INVALID_TEXT_DRAW ) {
		UnloadInventory ( playerid );
		UnloadExaminePage ( playerid );
    }

	#if defined invsys_OnPlayerClickTextDraw
	    return invsys_OnPlayerClickTextDraw(playerid, Text: clickedid);
	#else
   	 	return false;
	#endif
}

#if defined _ALS_OnPlayerClickTextDraw
    #undef OnPlayerClickTextDraw
#else
    #define _ALS_OnPlayerClickTextDraw
#endif
#define OnPlayerClickTextDraw invsys_OnPlayerClickTextDraw
#if defined invsys_OnPlayerClickTextDraw
	forward invsys_OnPlayerClickTextDraw(playerid, Text: clickedid);
#endif

public OnPlayerConnect ( playerid ) {
	for(new i; i < MAX_INV_ITEMS; i ++) {
		pInventoryItem [ playerid ] [ i ] = INVALID_ITEM_ID;
	}

	#if defined invsys_OnPlayerConnect
	    return invsys_OnPlayerConnect(playerid);
	#else
   	 	return false;
	#endif
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect
#else
    #define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect invsys_OnPlayerConnect
#if defined invsys_OnPlayerConnect
	forward invsys_OnPlayerConnect(playerid);
#endif

public OnPlayerDisconnect ( playerid, reason ) {
	UnloadInventory   ( playerid );
	UnloadExaminePage ( playerid );

	#if defined invsys_OnPlayerDisconnect
	    return invsys_OnPlayerDisconnect(playerid, reason);
	#else
    	return false;
	 #endif
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect
#else
    #define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect invsys_OnPlayerDisconnect
#if defined invsys_OnPlayerDisconnect
	forward invsys_OnPlayerDisconnect(playerid, reason);
#endif

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {
	// Next Page
	if( playertextid == InventoryTD [ 2 ] [ playerid ] ) {
		UnloadInventory ( playerid );
		pInventoryPage { playerid } = 2;

		LoadInventory ( playerid );
	}

	// Close Inventory, along with previous page for page 2
	if( playertextid == InventoryTD [ 4 ] [ playerid ] ) {

		if ( pInventoryPage { playerid } == 1 )  {
		    CancelSelectTextDraw ( playerid );
			UnloadInventory ( playerid );
		}

	 	else if ( pInventoryPage { playerid } == 2 )  {
			UnloadInventory ( playerid );
			LoadInventory ( playerid );
		}
	}

	// Show examine page when clicking on a item tile
	new multiply = (pInventoryPage { playerid} == 2 ) ? 12 : 0;

	for(new i; i < sizeof ( InventoryTD_Prev); i ++ ) {
		if ( playertextid == InventoryTD_Prev [ i ] [ playerid ] ) {

			if ( pInventoryPage { playerid } == 1 ) {
           	 	ExamineInventoryItem ( playerid, i );
			}

			else if ( pInventoryPage { playerid } == 2 ) {
           	 	ExamineInventoryItem ( playerid, i + multiply );
			}
		}
	}

	// Examine page return to inventory
	if ( playertextid == InventoryTD_Use[5][playerid] ) {

		UnloadExaminePage ( playerid );
		LoadInventory ( playerid );
	}

	// Use examined item
	if ( playertextid == InventoryTD_Use[7][playerid] ) {

		UseInventoryItem ( playerid, pExaminingItem { playerid } );
	}

	#if defined invsys_OnPlayerClickPlayerTD
	    return invsys_OnPlayerClickPlayerTextDraw ( playerid, PlayerText: playertextid );
	#else
   	 	return false;
	#endif
}

#if defined _ALS_OnPlayerClickPlayerTD
    #undef OnPlayerClickPlayerTextDraw
#else
    #define _ALS_OnPlayerClickPlayerTD
#endif
#define OnPlayerClickPlayerTextDraw invsys_OnPlayerClickPlayerD
#if defined invsys_OnPlayerClickPlayerTD
	forward invsys_OnPlayerClickPlayerTextDraw ( playerid, PlayerText: playertextid );
#endif

public OnPlayerKeyStateChange ( playerid, newkeys, oldkeys ) {

	if(newkeys & KEY_YES) {
	    switch (pHasInventoryOpen { playerid }) {
			case false: {
				LoadInventory ( playerid );
			}
	    }
	}

	#if defined invsys_OnPlayerKeyStateChange
	    return invsys_OnPlayerKeyStateChange ( playerid, newkeys, oldkeys );
	#else
   	 	return false;
	#endif
}

#if defined _ALS_OnPlayerKeyStateChange
    #undef OnPlayerKeyStateChange
#else
    #define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange invsys_OnPlayerKeyStateChange
#if defined invsys_OnPlayerKeyStateChange
	forward invsys_OnPlayerKeyStateChange ( playerid, newkeys, oldkeys );
#endif

UseInventoryItem ( playerid, itemid ) {
	new itemtype = itemArray [ pExaminingItem { playerid } ] [ itemType ];

	// Make inventory usable here...

	switch ( itemtype ) {
	    case ITEM_TYPE_EQUIPABLE: {
			SendClientMessage  ( playerid, -1, "* Equipable item ");
	    }

	    case ITEM_TYPE_USABLE: {
			SendClientMessage  ( playerid, -1, "* Usable item ");
	    }

		// Consumable example
	    case ITEM_TYPE_CONSUMABLE: {

			// Check for item quanity
	    	if ( pInventoryItemQty [ playerid ] [ itemid ] < 1 ) {
			    return SendClientMessage ( playerid, -1, "You don't have enough of this item to use!");
			}

	        // Decrease item quanity and send a message
            pInventoryItemQty [ playerid ] [ itemid ] --;
			SendClientMessage  ( playerid, -1, " * Consumed item ");
	    }

	    case ITEM_TYPE_MISCALLENEOUS: {
			SendClientMessage  ( playerid, -1, " * Miscalleneous item ");
	    }
	}

	// Refreshing page...
	UnloadExaminePage ( playerid );

	// Restore our values...
	pExaminingItem { playerid} = itemid;
	ExamineInventoryItem ( playerid, itemid );

	return true;
}

// itemid should be pInventoryItem [ playerid ] [ array ] ;
ExamineInventoryItem ( playerid, itemid ) {
	UnloadInventory ( playerid ) ;
	LoadExamineTextDraws ( playerid ) ;

	new itemInfo [ 64 ];

	format(itemInfo, sizeof(itemInfo), "Item Name:~n~~y~%s", itemArray [ itemid ] [ itemName ] );
	PlayerTextDrawSetString(playerid, InventoryTD_Use [ 2 ] [ playerid ], itemInfo );

	format(itemInfo, sizeof(itemInfo), "Item Quanity:~n~~y~%d", pInventoryItemQty [ playerid ] [ itemid ] );
	PlayerTextDrawSetString(playerid, InventoryTD_Use [ 3 ] [ playerid ], itemInfo );

	switch ( itemArray [ itemid ] [ itemType ] ) {

	    case ITEM_TYPE_EQUIPABLE:     PlayerTextDrawSetString ( playerid, InventoryTD_Use [ 7 ] [ playerid ], "Equip Item");
		case ITEM_TYPE_USABLE:   	  PlayerTextDrawSetString ( playerid, InventoryTD_Use [ 7 ] [ playerid ], "Use Item");
		case ITEM_TYPE_CONSUMABLE: 	  PlayerTextDrawSetString ( playerid, InventoryTD_Use [ 7 ] [ playerid ], "Consume Item");
		case ITEM_TYPE_MISCALLENEOUS: PlayerTextDrawSetString ( playerid, InventoryTD_Use [ 7 ] [ playerid ], "Examine Item");

	}

	PlayerTextDrawSetPreviewModel ( playerid, InventoryTD_Use [ 8 ] [ playerid], itemArray [ itemid ] [ itemModel] );
	PlayerTextDrawHide ( playerid, InventoryTD_Use [ 8 ] [ playerid]);
	PlayerTextDrawShow ( playerid, InventoryTD_Use [ 8 ] [ playerid]);

    SelectTextDraw(playerid, INV_TXD_TILE_INFO_COL);
    pExaminingItem { playerid } = itemid;

	return true;
}

LoadExamineTextDraws ( playerid ) {

	for(new i; i < sizeof(InventoryTD_Use); i ++) {
	    PlayerTextDrawDestroy ( playerid, InventoryTD_Use [ i ] [ playerid ] );
	}

	InventoryTD_Use[0][playerid] = CreatePlayerTextDraw(playerid, 443.666595, 171.574081, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[0][playerid], 0.000000, 14.783331);
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[0][playerid], 207.000000, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Use[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Use[0][playerid], INV_TXD_BACKGROUND_COL);

	InventoryTD_Use[1][playerid] = CreatePlayerTextDraw(playerid, 312.666687, 182.359252, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[1][playerid], 0.000000, 9.546710);
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[1][playerid], 215.666656, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Use[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Use[1][playerid], INV_TXD_TILE_COL);

	InventoryTD_Use[2][playerid] = CreatePlayerTextDraw(playerid, 320.666748, 187.081634, "Item Name:~n~~y~Name Here");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[2][playerid], 0.332333, 1.176000);
	PlayerTextDrawAlignment(playerid, InventoryTD_Use[2][playerid], 1);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Use[2][playerid], 1);
	PlayerTextDrawSetShadow(playerid, InventoryTD_Use[2][playerid], true);

	InventoryTD_Use[3][playerid] = CreatePlayerTextDraw(playerid, 320.666687, 221.925903, "Item Quanity:~n~~y~9999");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[3][playerid], 0.332333, 1.176000); // 0.210000, 0.899998
	PlayerTextDrawAlignment(playerid, InventoryTD_Use[3][playerid], 1);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Use[3][playerid], 1);
	PlayerTextDrawSetShadow(playerid, InventoryTD_Use[3][playerid], true);

	InventoryTD_Use[4][playerid] = CreatePlayerTextDraw(playerid, 312.0, 280, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[4][playerid], 0.000000, 1.7);
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[4][playerid], 215.34, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Use[4][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Use[4][playerid], INV_TXD_TILE_COL);

	InventoryTD_Use[5][playerid] = CreatePlayerTextDraw(playerid, 220, 280, "Back to inventory");
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[5][playerid], 310, 15);
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[5][playerid], 0.3, 1.5);
	PlayerTextDrawAlignment(playerid, InventoryTD_Use[5][playerid], 1);
	PlayerTextDrawColor(playerid, InventoryTD_Use[5][playerid], -1);
	PlayerTextDrawSetShadow(playerid, InventoryTD_Use[5][playerid], 0);
	PlayerTextDrawSetOutline(playerid, InventoryTD_Use[5][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Use[5][playerid], true);

	InventoryTD_Use[6][playerid] = CreatePlayerTextDraw(playerid, 435.0, 280, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[6][playerid], 0.000000, 1.7);
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[6][playerid], 334.34, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Use[6][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Use[6][playerid], INV_TXD_TILE_COL);

	InventoryTD_Use[7][playerid] = CreatePlayerTextDraw(playerid, 340, 280, "Use Item");
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[7][playerid], 433, 15);
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[7][playerid], 0.3, 1.5);
	PlayerTextDrawAlignment(playerid, InventoryTD_Use[7][playerid], 1);
	PlayerTextDrawColor(playerid, InventoryTD_Use[7][playerid], -1);
	PlayerTextDrawSetShadow(playerid, InventoryTD_Use[7][playerid], 0);
	PlayerTextDrawSetOutline(playerid, InventoryTD_Use[7][playerid], 0);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Use[7][playerid], true);

	InventoryTD_Use[8][playerid] = CreatePlayerTextDraw(playerid, 217, 180.359252, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Use[8][playerid], 0.000000, 9.546710);
	PlayerTextDrawTextSize(playerid, InventoryTD_Use[8][playerid], 95, 90.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Use[8][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Use[8][playerid], 0);
	PlayerTextDrawFont ( playerid, InventoryTD_Use [ 8 ] [ playerid ], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Use [ 8 ] [ playerid ] , 1337);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Use [ 8 ] [ playerid ], 0);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Use [ 8 ][playerid], 0, 0, 60, 1);

	for(new i; i < sizeof(InventoryTD_Use); i ++) {
	    PlayerTextDrawShow ( playerid, InventoryTD_Use [ i ] [ playerid ] );
	}

	return true;
}

ReturnPlayerItemCount ( playerid ) {
	new count;

	for(new i; i < MAX_INV_ITEMS; i ++) {
	    if(pInventoryItem [ playerid ] [ i ] != INVALID_ITEM_ID) {
			count ++;
	    }
	}

	return count;
}

UnloadExaminePage ( playerid ) {
	pExaminingItem { playerid } = INVALID_ITEM_ID;

	for(new i; i < sizeof(InventoryTD_Use); i ++) {
	    PlayerTextDrawDestroy ( playerid, InventoryTD_Use [ i ] [ playerid ] );
	}
}

UnloadInventory ( playerid ) {
	for(new i; i < sizeof(InventoryTD); i ++) {
		PlayerTextDrawDestroy(playerid, InventoryTD[i][playerid] ); // Background and menu buttons + page info
	}

	for(new i; i < MAX_VIS_TILES; i ++) {
		PlayerTextDrawDestroy(playerid, InventoryTD_Tile[i][playerid] ); // Tiles
		PlayerTextDrawDestroy(playerid, InventoryTD_Name[i][playerid] ); // Item Names
		PlayerTextDrawDestroy(playerid, InventoryTD_Qty[i][playerid] ); // Item Quanity
		PlayerTextDrawDestroy(playerid, InventoryTD_Prev[i][playerid] ); // Item preview
	}

	pHasInventoryOpen { playerid } = false;
	pInventoryPage { 0 } = 1;
}

InitialisePlayerItems ( playerid ) {
	// Load items here

	if ( ! pLoadedInventory { playerid } ) {
		pInventoryItem [ playerid ] [ 0 ] = itemArray [ 0 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 0 ] = 1337;

		pInventoryItem [ playerid ] [ 1 ] = itemArray [ 1 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 1 ] = 1;

		pInventoryItem [ playerid ] [ 2 ] = itemArray [ 2 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 2 ] = 2;

		pInventoryItem [ playerid ] [ 3 ] = itemArray [ 3 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 3 ] = 3;

		pInventoryItem [ playerid ] [ 4 ] = itemArray [ 4 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 4 ] = 4;

		pInventoryItem [ playerid ] [ 5 ] = itemArray [ 5 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 5 ] = 5;

		pInventoryItem [ playerid ] [ 6 ] = itemArray [ 6 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 6 ] = 6;

		pInventoryItem [ playerid ] [ 7 ] = itemArray [ 7 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 7 ] = 7;

		pInventoryItem [ playerid ] [ 8 ] = itemArray [ 8 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 8 ] = 8;

		pInventoryItem [ playerid ] [ 9 ] = itemArray [ 9 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 9 ] = 9;

		pInventoryItem [ playerid ] [ 10 ] = itemArray [ 10 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 10 ] = 10;

		pInventoryItem [ playerid ] [ 11 ] = itemArray [ 11 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 11 ] = 11;

		pInventoryItem [ playerid ] [ 12 ] = itemArray [ 12 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 12 ] = 12;

		pInventoryItem [ playerid ] [ 13 ] = itemArray [ 13 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 13 ] = 13;

		pInventoryItem [ playerid ] [ 14 ] = itemArray [ 14 ] [ itemID ];
		pInventoryItemQty [ playerid ] [ 14 ] = 14;

		pLoadedInventory { playerid } = true;
	}

	return true;
}

LoadInventory ( playerid ) {

	InitialisePlayerItems ( playerid );

    pHasInventoryOpen { playerid } = true;
    SelectTextDraw(playerid, INV_TXD_TILE_INFO_COL);

	new pageStr [ 32 ];

	format(pageStr, sizeof(pageStr), "Page %d of 2 (%d items)", pInventoryPage { playerid }, ReturnPlayerItemCount ( playerid ) );

	new previewModel [ MAX_INV_ITEMS ], multiply = (pInventoryPage { playerid} == 2) ? 12 : 0;

	for(new i; i < MAX_INV_ITEMS; i ++) {
		if(pInventoryItem [ playerid ] [ i ] != INVALID_ITEM_ID) {
			new itemidx = pInventoryItem [ playerid ] [ i ];

			previewModel [ i] = itemArray [ itemidx ] [itemModel] ;
		}
	}

	InventoryTD[0][playerid] = CreatePlayerTextDraw(playerid, 492, 155, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD[0][playerid], 0, 24);
	PlayerTextDrawTextSize(playerid, InventoryTD[0][playerid], 195, 0);
	PlayerTextDrawUseBox(playerid, InventoryTD[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD[0][playerid], INV_TXD_BACKGROUND_COL);

	// Letters each have 71 X width and (8 Y width for item/qty).
	// Boxes each have 71 X width and 64 Y width and 73 letter width, -1 every time

	// Tile number 0
	InventoryTD_Tile[0][playerid] = CreatePlayerTextDraw(playerid, 273, 160, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[0][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[0][playerid], 200, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[0][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[0][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[0][playerid] = CreatePlayerTextDraw(playerid, 205, 200, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[0][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[0][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[0][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[0][playerid], true);

	InventoryTD_Qty[0][playerid] = CreatePlayerTextDraw(playerid, 205, 208, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[0][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[0][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[0][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[0][playerid], true);

	InventoryTD_Prev[0][playerid] = CreatePlayerTextDraw(playerid, 203, 155, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[0][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[0][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[0][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[0][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[0][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[0][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[0][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[0][playerid], previewModel[0]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[0][playerid], previewModel[0 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[0][playerid], true);

	// Tile number 1
	InventoryTD_Tile[1][playerid] = CreatePlayerTextDraw(playerid, 345, 160, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[1][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[1][playerid], 272, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[1][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[1][playerid] = CreatePlayerTextDraw(playerid, 276, 200, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[1][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[1][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[1][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[1][playerid], true);

	InventoryTD_Qty[1][playerid] = CreatePlayerTextDraw(playerid, 276, 208, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[1][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[1][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[1][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[1][playerid], true);

	InventoryTD_Prev[1][playerid] = CreatePlayerTextDraw(playerid, 275, 155, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[1][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[1][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[1][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[1][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[1][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[1][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[1][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[1][playerid], previewModel[1]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[1][playerid], previewModel[1 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[1][playerid], true);

	// Tile number 2
	InventoryTD_Tile[2][playerid] = CreatePlayerTextDraw(playerid, 416, 160, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[2][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[2][playerid], 344, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[2][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[2][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[2][playerid] = CreatePlayerTextDraw(playerid, 348, 200, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[2][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[2][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[2][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[2][playerid], true);

	InventoryTD_Qty[2][playerid] = CreatePlayerTextDraw(playerid, 348, 208, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[2][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[2][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[2][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[2][playerid], true);

	InventoryTD_Prev[2][playerid] = CreatePlayerTextDraw(playerid, 346, 155, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[2][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[2][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[2][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[2][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[2][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[2][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[2][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[2][playerid], previewModel[2]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[2][playerid], previewModel[2 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[2][playerid], true);

	// Tile number 3
	InventoryTD_Tile[3][playerid] = CreatePlayerTextDraw(playerid, 487, 160, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[3][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[3][playerid], 415, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[3][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[3][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[3][playerid] = CreatePlayerTextDraw(playerid, 419, 200, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[3][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[3][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[3][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[3][playerid], true);

	InventoryTD_Qty[3][playerid] = CreatePlayerTextDraw(playerid, 419, 208, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[3][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[3][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[3][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[3][playerid], true);

	InventoryTD_Prev[3][playerid] = CreatePlayerTextDraw(playerid, 417, 155, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[3][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[3][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[3][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[3][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[3][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[3][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[3][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[3][playerid], previewModel[3]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[3][playerid], previewModel[3 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[3][playerid], true);

	////////////////////////////////////////////////////////////////////////////
	/////////////////////////////// MIDDLE ROW /////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	// Tile number 4
	InventoryTD_Tile[4][playerid] = CreatePlayerTextDraw(playerid, 273, 224, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[4][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[4][playerid], 200, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[4][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[4][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[4][playerid] = CreatePlayerTextDraw(playerid, 205, 264, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[4][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[4][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[4][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[4][playerid], true);

	InventoryTD_Qty[4][playerid] = CreatePlayerTextDraw(playerid, 205, 272, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[4][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[4][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[4][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[4][playerid], true);

	InventoryTD_Prev[4][playerid] = CreatePlayerTextDraw(playerid, 203, 220, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[4][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[4][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[4][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[4][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[4][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[4][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[4][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[4][playerid], previewModel[4]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[4][playerid], previewModel[4 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[4][playerid], true);

	// Tile number 5
	InventoryTD_Tile[5][playerid] = CreatePlayerTextDraw(playerid, 345, 224, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[5][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[5][playerid], 272, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[5][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[5][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[5][playerid] = CreatePlayerTextDraw(playerid, 276, 264, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[5][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[5][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[5][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[5][playerid], true);

	InventoryTD_Qty[5][playerid] = CreatePlayerTextDraw(playerid, 276, 272, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[5][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[5][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[5][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[5][playerid], true);

	InventoryTD_Prev[5][playerid] = CreatePlayerTextDraw(playerid, 275, 220, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[5][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[5][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[5][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[5][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[5][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[5][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[5][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[5][playerid], previewModel[5]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[5][playerid], previewModel[5 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[5][playerid], true);

	// Tile number 6
	InventoryTD_Tile[6][playerid] = CreatePlayerTextDraw(playerid, 416, 224, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[6][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[6][playerid], 344, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[6][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[6][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[6][playerid] = CreatePlayerTextDraw(playerid, 348, 264, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[6][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[6][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[6][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[6][playerid], true);

	InventoryTD_Qty[6][playerid] = CreatePlayerTextDraw(playerid, 348, 272, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[6][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[6][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[6][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[6][playerid], true);

	InventoryTD_Prev[6][playerid] = CreatePlayerTextDraw(playerid, 346, 220, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[6][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[6][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[6][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[6][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[6][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[6][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[6][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[6][playerid], previewModel[6]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[6][playerid], previewModel[6 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[6][playerid], true);

	// Tile number 7
	InventoryTD_Tile[7][playerid] = CreatePlayerTextDraw(playerid, 487, 224, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[7][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[7][playerid], 415, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[7][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[7][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[7][playerid] = CreatePlayerTextDraw(playerid, 419, 264, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[7][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[7][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[7][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[7][playerid], true);

	InventoryTD_Qty[7][playerid] = CreatePlayerTextDraw(playerid, 419, 272, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[7][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[7][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[7][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[7][playerid], true);

	InventoryTD_Prev[7][playerid] = CreatePlayerTextDraw(playerid, 417, 220, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[7][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[7][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[7][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[7][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[7][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[7][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[7][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[7][playerid], previewModel[7]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[7][playerid], previewModel[7 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[7][playerid], true);

	////////////////////////////////////////////////////////////////////////////
	/////////////////////////////// BOTTOM ROW /////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	// Tile number 8
	InventoryTD_Tile[8][playerid] = CreatePlayerTextDraw(playerid, 273, 288, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[8][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[8][playerid], 200, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[8][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[8][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[8][playerid] = CreatePlayerTextDraw(playerid, 205, 328, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[8][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[8][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[8][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[8][playerid], true);

	InventoryTD_Qty[8][playerid] = CreatePlayerTextDraw(playerid, 205, 336, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[8][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[8][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[8][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[8][playerid], true);

	InventoryTD_Prev[8][playerid] = CreatePlayerTextDraw(playerid, 203, 284, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[8][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[8][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[8][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[8][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[8][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[8][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[8][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[8][playerid], previewModel[8]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[8][playerid], previewModel[8 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[8][playerid], true);

	// Tile number 9
	InventoryTD_Tile[9][playerid] = CreatePlayerTextDraw(playerid, 345, 288, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[9][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[9][playerid], 272, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[9][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[9][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[9][playerid] = CreatePlayerTextDraw(playerid, 276, 328, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[9][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[9][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[9][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[9][playerid], true);

	InventoryTD_Qty[9][playerid] = CreatePlayerTextDraw(playerid, 276, 336, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[9][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[9][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[9][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[9][playerid], true);

	InventoryTD_Prev[9][playerid] = CreatePlayerTextDraw(playerid, 275, 284, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[9][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[9][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[9][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[9][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[9][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[9][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[9][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[9][playerid], previewModel[9]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[9][playerid], previewModel[9 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[9][playerid], true);

	// Tile number 10
	InventoryTD_Tile[10][playerid] = CreatePlayerTextDraw(playerid, 416, 288, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[10][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[10][playerid], 344, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[10][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[10][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[10][playerid] = CreatePlayerTextDraw(playerid, 348, 328, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[10][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[10][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[10][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[10][playerid], true);

	InventoryTD_Qty[10][playerid] = CreatePlayerTextDraw(playerid, 348, 336, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[10][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[10][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[10][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[10][playerid], true);

	InventoryTD_Prev[10][playerid] = CreatePlayerTextDraw(playerid, 346, 284, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[10][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[10][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[10][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[10][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[10][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[10][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[10][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[10][playerid], previewModel[10]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[10][playerid], previewModel[10 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[10][playerid], true);

	// Tile number 11
	InventoryTD_Tile[11][playerid] = CreatePlayerTextDraw(playerid, 487, 288, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Tile[11][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Tile[11][playerid], 415, 0.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD_Tile[11][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Tile[11][playerid], INV_TXD_TILE_COL);

	InventoryTD_Name[11][playerid] = CreatePlayerTextDraw(playerid, 419, 328, "Item Name");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Name[11][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Name[11][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Name[11][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Name[11][playerid], true);

	InventoryTD_Qty[11][playerid] = CreatePlayerTextDraw(playerid, 419, 336, "Qty. ~l~0");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Qty[11][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD_Qty[11][playerid], INV_TXD_TILE_INFO_COL );
	PlayerTextDrawSetShadow(playerid, InventoryTD_Qty[11][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD_Qty[11][playerid], true);

	InventoryTD_Prev[11][playerid] = CreatePlayerTextDraw(playerid, 417, 284, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD_Prev[11][playerid], 0.000000, 6.5);
	PlayerTextDrawTextSize(playerid, InventoryTD_Prev[11][playerid], 70, 60);
	PlayerTextDrawUseBox(playerid, InventoryTD_Prev[11][playerid], true);
    PlayerTextDrawFont(playerid, InventoryTD_Prev[11][playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawSetPreviewRot(playerid, InventoryTD_Prev[11][playerid], 0, 0, 60, 1.4);
	PlayerTextDrawBackgroundColor(playerid, InventoryTD_Prev[11][playerid], 0);
	PlayerTextDrawBoxColor(playerid, InventoryTD_Prev[11][playerid], 0);
	if(pInventoryPage { playerid } == 1) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[11][playerid], previewModel[11]);
	else if(pInventoryPage { playerid } == 2 ) PlayerTextDrawSetPreviewModel(playerid, InventoryTD_Prev[11][playerid], previewModel[11 + multiply]);
	PlayerTextDrawSetSelectable(playerid, InventoryTD_Prev[11][playerid], true);

	////////////////////////////////////////////////////////////////////////////
	/////////////////////////////// MENU ROW ///////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	InventoryTD[1][playerid] = CreatePlayerTextDraw(playerid, 487, 352, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD[1][playerid], 0.000000, 1.5);
	PlayerTextDrawTextSize(playerid, InventoryTD[1][playerid], 415, 50.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD[1][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD[1][playerid], INV_TXD_TILE_COL);

	InventoryTD[2][playerid] = CreatePlayerTextDraw(playerid, 425, 353, "Next Page");
	PlayerTextDrawTextSize(playerid, InventoryTD[2][playerid], 483, 10);
	PlayerTextDrawLetterSize(playerid, InventoryTD[2][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD[2][playerid], -1);
	PlayerTextDrawSetShadow(playerid, InventoryTD[2][playerid], false);
	PlayerTextDrawSetProportional(playerid, InventoryTD[2][playerid], true);
	PlayerTextDrawSetSelectable(playerid, InventoryTD[2][playerid], true);

	InventoryTD[3][playerid] = CreatePlayerTextDraw(playerid, 273, 352, "usebox");
	PlayerTextDrawLetterSize(playerid, InventoryTD[3][playerid], 0.000000, 1.5);
	PlayerTextDrawTextSize(playerid, InventoryTD[3][playerid], 200, 50.000000);
	PlayerTextDrawUseBox(playerid, InventoryTD[3][playerid], true);
	PlayerTextDrawBoxColor(playerid, InventoryTD[3][playerid], INV_TXD_TILE_COL);

	InventoryTD[4][playerid] = CreatePlayerTextDraw(playerid, 208, 353, "Prev. Page");
	PlayerTextDrawTextSize(playerid, InventoryTD[4][playerid], 265, 10);
	PlayerTextDrawLetterSize(playerid, InventoryTD[4][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD[4][playerid], -1 );
	PlayerTextDrawSetShadow(playerid, InventoryTD[4][playerid], false);
	PlayerTextDrawSetProportional(playerid, InventoryTD[4][playerid], true);
	PlayerTextDrawSetSelectable(playerid, InventoryTD[4][playerid], true);

	InventoryTD[5][playerid] = CreatePlayerTextDraw(playerid, 288, 353, pageStr);
	PlayerTextDrawLetterSize(playerid, InventoryTD[5][playerid], 0.3, 1.1);
	PlayerTextDrawColor(playerid, InventoryTD[5][playerid], -1 );
	PlayerTextDrawSetShadow(playerid, InventoryTD[5][playerid], true);
	PlayerTextDrawSetProportional(playerid, InventoryTD[5][playerid], true);

	for(new i; i < sizeof(InventoryTD); i ++) {
		PlayerTextDrawShow(playerid, InventoryTD[i][playerid] );
	}

	// Show all textdraws before configuring them as shown below
	for(new i; i < MAX_VIS_TILES; i ++) {
		PlayerTextDrawShow(playerid, InventoryTD_Tile[i][playerid] );
		PlayerTextDrawShow(playerid, InventoryTD_Name[i][playerid] );
		PlayerTextDrawShow(playerid, InventoryTD_Qty[i][playerid] );
		PlayerTextDrawShow(playerid, InventoryTD_Prev[i][playerid] );
	}

	AdjustInventoryTiles(playerid, pInventoryPage { playerid} );

	switch ( pInventoryPage { playerid } ) {
	    case 1: {
			PlayerTextDrawSetString(playerid, InventoryTD[4][playerid], "Close");

			if ( pInventoryItem [ playerid ] [ 12 ] == INVALID_ITEM_ID) {
				// Page 2 is empty, so hide the "next page" button.
				PlayerTextDrawHide(playerid, InventoryTD[1][playerid]);
				PlayerTextDrawHide(playerid, InventoryTD[2][playerid]);
			}

			for(new i; i < MAX_INV_ITEMS; i ++) {
			    if(pInventoryItem [ playerid ] [ i ] == INVALID_ITEM_ID) {
					HideInventoryTile(playerid, i);
			    }
			}
	    }

	    case 2: {
			// There is no next page, so remove the "next page" buttons.
			PlayerTextDrawHide(playerid, InventoryTD[1][playerid]);
			PlayerTextDrawHide(playerid, InventoryTD[2][playerid]);

        	for(new i; i < MAX_INV_ITEMS; i ++) {
			    if(pInventoryItem [ playerid ] [ i + 12 ] == INVALID_ITEM_ID) {
					HideInventoryTile(playerid, i);
			    }
			}
		}
	}

	return true;
}

AdjustInventoryTiles(playerid, page) {
	new multiply;

	switch ( page ) {
	    case 1: multiply = 0;
	    case 2: multiply = 12;
	}

	for(new i; i < MAX_VIS_TILES; i ++) {
		if(pInventoryItem [ playerid ] [ i + multiply ] != INVALID_ITEM_ID) {
	        new item_ID =  pInventoryItem [ playerid ][ i + multiply ], string [ 32 ];

	    	PlayerTextDrawSetString(playerid, InventoryTD_Name[i][playerid], itemArray [ item_ID] [ itemName ]);

	    	format(string, sizeof(string), "Qty. ~w~%d", pInventoryItemQty [ playerid ] [ i + multiply ]);
	    	PlayerTextDrawSetString(playerid, InventoryTD_Qty[i][playerid], string);
		}
	}

	return true;
}

HideInventoryTile(playerid, tile_id) {

    PlayerTextDrawHide( playerid, InventoryTD_Tile [ tile_id ] [ playerid ] );
    PlayerTextDrawHide( playerid, InventoryTD_Name [ tile_id ] [ playerid ] );
    PlayerTextDrawHide( playerid, InventoryTD_Qty  [ tile_id ] [ playerid ] );
	PlayerTextDrawHide( playerid, InventoryTD_Prev [ tile_id ] [ playerid ] );

	return true;
}