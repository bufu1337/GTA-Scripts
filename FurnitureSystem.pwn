// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp> // Credits to the SA:MP Developement Team
#include <sscanf2> // Credits to Y_Less
#include <YSI\y_ini> // Credits to Y_Less
#include <ZCMD> // Credits to Zeex
#include <streamer> // Credits to Incognito
#include <foreach> // Credits to Y_Less

//furniture shit
new Object;
new oModel;
#define OBJECT_FILE_NAME 		"DObjects.txt"
#define COLOR_YELLOW 	0xD8D8D8FF
#define COLOR_FADE1 	0xE6E6E6E6
#define COLOR_FADE2 	0xC8C8C8C8
#define COLOR_FADE3 	0xAAAAAAAA
#define COLOR_FADE4 	0x8C8C8C8C
#define COLOR_FADE5 	0x6E6E6E6E
#define COLOR_FADE 		0xC8C8C8C8
#define COLOR_WHITE 	0xFFFFFFAA
#define COLOR_GRAD2 	0xBFC0C2FF
#define COLOR_DARKRED 	0x8B0000AA
#define COLOR_RED 		0xFF0000AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GREY 		0xAFAFAFAA
#define COLOR_PINK 		0xDC00DDAA
#define COLOR_BLUE 		0x0259EAAA
#define COLOR_GREEN 	0x00A800AA
#define COLOR_ORANGE 	0xFF8000AA
#define COLOR_CYAN 		0xFF8080AA
#define COLOR_WHITE 	0xFFFFFFAA
#define COLOR_DARKBLUE 	0x0000A0AA
#define COLOR_BLACK 	0x000000AA
#define COLOR_DARKGOLD 	0x808000AA
#define COLOR_PURPLE    0xC2A2DAAA
#define COLOR_BROWN 	0x804000AA
#define COLOR_BLACK2 	0x000000ff
#define COLOR_GRAD2 0xBFC0C2FF

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	new Line[60], Veh;
	AddObjectFromFile(OBJECT_FILE_NAME);
	format(Line, sizeof(Line), "** %i\t<->\tObjects Loaded From\t<->\tDObjects.txt **", Veh);
	printf(Line);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case 509:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, 510, DIALOG_STYLE_LIST, "Furniture Chairs", "Chair1\nChair2\nChair3\nChair4", "Ok", "Cancel");
				}
				case 1:
				{
					ShowPlayerDialog(playerid, 511, DIALOG_STYLE_LIST, "Furniture Beds", "Bed1\nBed2\nBed3\nBed4", "Ok", "Cancel");
				}
				case 2:
				{
					ShowPlayerDialog(playerid, 512, DIALOG_STYLE_LIST, "Furniture Tables", "Table1\nTable2\nTable3", "Ok", "Cancel");
				}
				case 3:
				{
					ShowPlayerDialog(playerid, 513, DIALOG_STYLE_LIST, "Furniture T.V", "TV1\n TV2\n TV3", "Ok", "Cancel");
				}
				case 4:
				{
					ShowPlayerDialog(playerid, 514, DIALOG_STYLE_LIST, "Furniture Cabinet", "Cabinet 1", "Ok", "Cancel");
				}
				case 5:
				{
					ShowPlayerDialog(playerid, 515, DIALOG_STYLE_LIST, "Furniture Misc", "Basket Ball net\nClothes\nEaster Egg", "Ok", "Cancel");
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 510:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1723;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1723, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 1:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1704;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1704, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 2:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 11665;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(11665, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 3:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1705;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1705, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 511:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1745;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1745, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 1:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1794;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1794, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 2:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1797;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1797, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 3:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2566;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2566, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 512:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1281;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1281, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 1:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2311;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2311, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 2:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 1825;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(1825, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 513:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2297;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2297, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 1:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2296;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2296, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 2:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2595;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2595, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 514:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2078;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2078, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	switch(dialogid)
	{
		case 515:
		{
			if(!response)
			{
				SendClientMessage(playerid, 0x42F3F198, "You canceled the dialog.");
				return 1;
			}
			switch(listitem)
			{
				case 0:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 3496;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(3496, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 1:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 2844;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(2844, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
				case 2:
				{
					new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
             		GetPlayerPos(playerid, OX, OY, OZ);
             		oModel = 19343;
             		ORX = 0.0;
             		ORY = 0.0;
             		ORZ = 0.0;
              		Object = CreateObject(19343, OX+2, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
               		SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
               		EditObject(playerid, Object);
				}
//You can continue cases here but make sure you make a new line in the ShowPlayerDialog on /mp3 command \r\n4. 4th \r\n5. 5th channel etc..
			}
		}
	}
	return 1;
}

stock AddObjectFromFile(DFileName[])
{
	if(!fexist(DFileName)) return 0;

	new File:ObjectFile, Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OVW, OINT, oTotal, Line[128];

	ObjectFile = fopen(DFileName, io_read);
	while(fread(ObjectFile, Line))
	{
	    if(Line[0] == '/' || isnull(Line)) continue;
	    unformat(Line, "ffffffiii", OX, OY, OZ, ORX, ORY, ORZ, OVW, OINT, oModel);
	    CreateDynamicObject(oModel, Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OVW, OINT, -1, 200.0);
	    oTotal++;
	}
	fclose(ObjectFile);
	return oTotal;
}

stock AddObjectToFile(DFileName[], Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OVW, OINT)
{
	new File:ObjectFile, Line[128];

	format(Line, sizeof(Line), "%f %f %f %f %f %f %i %i %i\r\n", OX, OY, OZ, ORX, ORY, ORZ, OVW, OINT, oModel);
	ObjectFile = fopen(DFileName, io_append);
	fwrite(ObjectFile, Line);
	fclose(ObjectFile);
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	new Float:oldX, Float:oldY, Float:oldZ,
		Float:oldRotX, Float:oldRotY, Float:oldRotZ;
	GetObjectPos(objectid, oldX, oldY, oldZ);
	GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
	new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OVW, OINT;
	if(!playerobject) // If this is a global object, move it for other players
	{
	    if(!IsValidObject(objectid)) return;
	    MoveObject(objectid, fX, fY, fZ, 10.0, fRotX, fRotY, fRotZ);
	}

	if(response == EDIT_RESPONSE_FINAL)
	{
	    new string[254];
		OVW = GetPlayerVirtualWorld(playerid);
		OINT = GetPlayerInterior(playerid);
		GetObjectPos(objectid, OX, OY, OZ);
		GetObjectRot(objectid, ORX, ORY, ORZ);
		AddObjectToFile(OBJECT_FILE_NAME, OX, OY, OZ, ORX, ORY, ORZ, OVW, OINT);
		SendClientMessage(playerid, COLOR_BLUE, "Object Saved, Please add more if you wish");
		format(string, sizeof(string), "Object model %i spawned at %f, %f, %f, with rotation %f, %f, %f,", oModel, OX, OY, OZ, ORX, ORY, ORZ);
		SendClientMessage(playerid, 0xD8D8D8FF, string);
		format(string, sizeof(string), "Object world %i interior id %i", OVW, OINT);
		SendClientMessage(playerid, 0xD8D8D8FF, string);
		CreateDynamicObject(oModel, Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ, OVW, OINT, -1, 200.0);
		DestroyObject(Object);
	}

	if(response == EDIT_RESPONSE_CANCEL)
	{
		//The player cancelled, so put the object back to it's old position
		if(!playerobject) //Object is not a playerobject
		{
			SetObjectPos(objectid, oldX, oldY, oldZ);
			SetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
		}
		else
		{
			SetPlayerObjectPos(playerid, objectid, oldX, oldY, oldZ);
			SetPlayerObjectRot(playerid, objectid, oldRotX, oldRotY, oldRotZ);
		}
	}
}

CMD:furniture(playerid, params[])
{
    ShowPlayerDialog(playerid, 509, DIALOG_STYLE_LIST, "Furniture", "Chairs\nBeds\nTables\nTvs\nCabinets\nFuns tuff\n", "Ok", "Cancel");
	return 1;
}

CMD:fhelp(playerid, params[])
{
    SendClientMessage(playerid, COLOR_ORANGE, "This system was scripted by jueix, Type /furniture to plant furniture in your house");
    SendClientMessage(playerid, COLOR_ORANGE, "If the furniture is not in /furniture that you want please type /fplant then the object id.");
    SendClientMessage(playerid, COLOR_ORANGE, "Thank you for using Jueix's furniture system.");
	return 1;
}

COMMAND:fplant(playerid, params[])
{
	new objectid;
 	if(!sscanf(params, "i", objectid))
  	{
   		if(objectid >= 1 && objectid <= 11000)
     	{
     		new Float:OX, Float:OY, Float:OZ, Float:ORX, Float:ORY, Float:ORZ;
      		GetPlayerPos(playerid, OX, OY, OZ);
       		oModel = objectid;
       		ORX = 0.0;
        	ORY = 0.0;
        	ORZ = 0.0;
        	Object = CreateObject(oModel, OX, OY, OZ, ORX, ORY, ORZ); //Object will render at its default distance.
        	SendClientMessage(playerid, 0xD8D8D8FF, "Object spawned now move it");
        	EditObject(playerid, Object);
         	return 1;
		}
		else return SendClientMessage(playerid, 0xD8D8D8FF, "Only id's between 1 and 11000 are avaliable.");
  	}
    else return SendClientMessage(playerid, 0xD8D8D8FF, "USAGE: /fplant[objectid]");
}

public OnFilterScriptExit()
{
	return 1;
}