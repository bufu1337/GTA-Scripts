#include <a_samp>
#include <zcmd>
#include <YSI\y_ini>

#define PRESSED(%0) \
    ((newkeys & (%0)) == (%0))
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_CYAN 0x00FFFFFF
#define metals 1
#define inventory 2
#define pInvPath "Inventory/%s.ini"
//Metals u can dig for:
enum inv {
	Gold, 
	Diamond, 
	Silver, 
	Tin,
	Lead,
	Iron,
	Cobalt,
	Titanium,
	Platinum,
	Copper,
	Manganese,
	Mercury
}
//An array with the metals for each player
new Inventory[MAX_PLAYERS][inv];
//To execute the player's name with the INI files.
stock pPath(playerid){
		new Lname[MAX_PLAYER_NAME], string[128];
	GetPlayerName(playerid, Lname, sizeof(Lname));
	format(string, sizeof(string), pInvPath, Lname);
	return string;
}
forward LoadPlayer_Inventory(playerid, name[], value[]); //A forward function which loads player's inventory.
public LoadPlayer_Inventory(playerid, name[], value[]){
	//Function: INI_Int - Which loads the 'int' value (integer). In case of string, it's INI_String, in case of float it's INI_Float.
	INI_Int("Gold", Inventory[playerid][Gold]);
	INI_Int("Diamond", Inventory[playerid][Diamond]);
	INI_Int("Silver", Inventory[playerid][Silver]);
	INI_Int("Tin", Inventory[playerid][Tin]);
	INI_Int("Lead", Inventory[playerid][Lead]);
	INI_Int("Iron", Inventory[playerid][Iron]);
	INI_Int("Cobalt", Inventory[playerid][Cobalt]);
	INI_Int("Titanium", Inventory[playerid][Titanium]);
	INI_Int("Platinum", Inventory[playerid][Platinum]);
	INI_Int("Copper", Inventory[playerid][Copper]);
	INI_Int("Manganese", Inventory[playerid][Manganese]);
	INI_Int("Mercury", Inventory[playerid][Mercury]);
	//Gets the value of the saved file and puts it into the array
	return 1;
}
public OnFilterScriptInit(){
	//Some Objects (Rocks) where u can dig the raw materials
	CreateObject(897, 499.57, 779.96, -25.49,   0.00, 0.00, 0.00);
    CreateObject(897, 494.21, 777.72, -25.49,   0.00, 0.00, 0.00);
    CreateObject(897, 486.58, 782.16, -25.49,   0.00, 0.00, 0.00);
    CreateObject(897, 484.11, 790.04, -25.49,   0.00, 0.00, 0.00);
    CreateObject(897, 501.51, 779.70, -25.49,   0.00, 0.00, -98.00);
    CreateObject(897, 504.28, 778.75, -25.49,   0.00, 0.00, -98.00);
    CreateObject(897, 491.51, 782.23, -25.49,   0.00, 0.00, -98.00);
    CreateObject(897, 489.68, 787.14, -25.49,   0.00, 0.00, -98.00);
    return 1;
}

CMD:shovel(playerid, params[]){
	//U need a shovel to dig
	GivePlayerWeapon(playerid, 6, 1);
	SendClientMessage(playerid,COLOR_CYAN,"*You Have Spawned Shovel.");
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 493.9033,781.3535,-20.0965)){
    	if(GetPlayerWeapon(playerid) != 6){
	  		return SendClientMessage(playerid, COLOR_YELLOW,"You need shovel to Dig Metals.");
	  	}
 		else if (PRESSED(KEY_FIRE)){
			//random gain of metal while pressing the Fire-Button in the corresponding area and equiped with shovel
			new Reactions;
            Reactions = random(14);
            switch(Reactions){
				case 0:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Mercury From the Mine.");
					Inventory[playerid][Mercury]++;
				}
				case 1:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Gold From the Mine.");
					Inventory[playerid][Gold]++;
				}
				case 2:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Diamond From the Mine.");
					Inventory[playerid][Diamond]++;
				}
				case 3:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Silver From the Mine.");
					Inventory[playerid][Silver]++;
				}
				case 4:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Tin From the Mine.");
					Inventory[playerid][Tin]++;
				}
				case 5:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Lead From the Mine.");
					Inventory[playerid][Lead]++;
				}
				case 6:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Iron From the Mine.");
					Inventory[playerid][Iron]++;
				}
				case 7:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Cobalt From the Mine.");
					Inventory[playerid][Cobalt]++;
				}
				case 8:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Titanium From the Mine.");
					Inventory[playerid][Titanium]++;
				}
				case 9:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Platinum From the Mine.");
					Inventory[playerid][Platinum]++;
				}
				case 10:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Copper From the Mine.");
					Inventory[playerid][Copper]++;
				}
				case 11:{
					SendClientMessageToAll(COLOR_YELLOW,"You have Got Manganese From the Mine.");
					Inventory[playerid][Manganese]++;
				}
				case 12:{
					new Float:PlayerHealth;
					GetPlayerHealth(playerid, PlayerHealth);
					SetPlayerHealth(playerid, PlayerHealth - 20);
					SendClientMessage(playerid, COLOR_YELLOW,"You have Been Hurted while Mining Metals.");
				}
            }
		}
    }
    return 1;
}
CMD:dig(playerid, parmas[]){
	SendClientMessage(playerid, COLOR_CYAN,"*Press Fire Key(LMB) to Dig Metals.");
	return 1;
}
CMD:miningplace(playerid, params[]){
   SetPlayerPos(playerid,493.9033,781.3535,-20.0965);
   SendClientMessage(playerid, COLOR_CYAN,"You have Been spawned to Mining Place.");
   return 1;
}
public OnPlayerConnect(playerid){
	if(fexist(pPath(playerid))) //If there's a file for this player: then it loads
	{
		//We must use 'INI_ParseFile' function and execute the 'LoadPlayer_Inventory' with it. It loads the saved stats, via the user path defined in the function.
		INI_ParseFile(pPath(playerid), "LoadPlayer_Inventory", .bExtra = true, .extra = playerid);
		//Loads the data from the path defined and detects the player's file using getting player's name which is done in 'pPath' function.
		//Now the data is loaded.
	}
	return 1;
}
public OnPlayerDisconnect(playerid, reason){
	//Now the saving part, we must open, create a tag for the file and then write the values. And then, close the file. (INI_Open, INI_SetTag, INI_WriteInt, INI_Close )
	new INI:iFile = INI_Open(pPath(playerid)); //Opens the player's path.
	INI_SetTag(iFile, "Inventory"); //Sets a tag called "Inventory"
	INI_WriteInt(iFile, "Gold", Inventory[playerid][Gold]);
	INI_WriteInt(iFile, "Diamond", Inventory[playerid][Diamond]);
	INI_WriteInt(iFile, "Silver", Inventory[playerid][Silver]);
	INI_WriteInt(iFile, "Tin", Inventory[playerid][Tin]);
	INI_WriteInt(iFile, "Lead", Inventory[playerid][Lead]);
	INI_WriteInt(iFile, "Iron", Inventory[playerid][Iron]);
	INI_WriteInt(iFile, "Cobalt", Inventory[playerid][Cobalt]);
	INI_WriteInt(iFile, "Titanium", Inventory[playerid][Titanium]);
	INI_WriteInt(iFile, "Platinum", Inventory[playerid][Platinum]);
	INI_WriteInt(iFile, "Copper", Inventory[playerid][Copper]);
	INI_WriteInt(iFile, "Manganese", Inventory[playerid][Manganese]);
	INI_WriteInt(iFile, "Mercury", Inventory[playerid][Mercury]);
	INI_Close(iFile);
	Inventory[playerid][Gold] = 0;
	Inventory[playerid][Diamond] = 0;
	Inventory[playerid][Silver] = 0;
	Inventory[playerid][Tin] = 0;
	Inventory[playerid][Lead] = 0;
	Inventory[playerid][Iron] = 0;
	Inventory[playerid][Cobalt] = 0;
	Inventory[playerid][Titanium] = 0;
	Inventory[playerid][Platinum] = 0;
	Inventory[playerid][Copper] = 0;
	Inventory[playerid][Manganese] = 0;
	Inventory[playerid][Mercury] = 0;
	return 1;
}
CMD:metals(playerid, params[]){
	new string[256];
	format(string, sizeof(string), "Gold : %d\nDiamond : %d\nSilver : %d\nTin : %d\nLead : %d\nIron : %d\nCobalt : %d\nTitanium : %d\nPlatinum : %d\nCopper : %d\nManganese : %d\nMercury : %d", Inventory[playerid][Gold], Inventory[playerid][Diamond], Inventory[playerid][Silver], Inventory[playerid][Tin], Inventory[playerid][Lead], Inventory[playerid][Iron], Inventory[playerid][Cobalt], Inventory[playerid][Titanium], Inventory[playerid][Platinum], Inventory[playerid][Copper], Inventory[playerid][Manganese], Inventory[playerid][Mercury]); //Formatting the string to show the var's value in dialog. Normally the dialog function won't support "{Float_...}"
	ShowPlayerDialog(playerid, 2, DIALOG_STYLE_MSGBOX, "Metals", string, "Close", "");
	return 1;
}

//Next version with explosive mining before digging and creating cars with these raw materials
//selling it to other players or on the market with defined prices