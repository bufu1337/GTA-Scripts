//Note
/*This is a [NPC]Filterscript  made by Adil.
  This Filter script allows you to travel through LS with two [NPC]'s who drive the Bus.
  I basically made this for RP servers.
  If you are facing some problems then read the tutorial or post your problem on the release page.
  Please you are requested to not to remove the credits, thankyou.
  For further support, this is my forums profile http://forum.sa-mp.com/member.php?u=35249
  Enjoy.*/
//Includes
#include <a_samp>
//Defines
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_RED 0xFF0000FF
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_TEAL 0x00AAAAAA
#define COLOR_OFFWHITE 0xF5DEB3AA
#define COLOR_DARKAQUA 0x83BFBFAA
//News
new Text3D:NPCTextBlue;
new Text3D:NPCTextBlack;
new NPCBlueBus;
new NPCBlackBus;
new BusID[MAX_PLAYERS];
new BusCost[MAX_PLAYERS];
new PlayerSitting[MAX_PLAYERS];
new Float:Playerx[MAX_PLAYERS], Float:Playery[MAX_PLAYERS], Float:Playerz[MAX_PLAYERS], Float:Playera[MAX_PLAYERS], PlayerSkin[MAX_PLAYERS];
new costtimer;
//Forwards
forward IsAtBlueBusStop(playerid);
forward IsAtBlackBusStop(playerid);
forward ResetView(playerid);
forward CPOff(playerid);
forward CostTimer(playerid);
forward ProxDetector(Float:radi, playerid, string[], color1, color2, color3, color4, color5);
//Publics
public OnFilterScriptInit(){
    print("                                ");
    print("\n--------------------------------");
    print("  Adil's [NPC]LS Bus System.");
    print("--------------------------------\n");
    print("                                ");
    //NPCs
    ConnectNPC("BlueBusDriver","Bus");
    ConnectNPC("BlackBusDriver","Bus2");
    //3DTextLabels
    NPCTextBlue = Create3DTextLabel("Blue Bus", 0x6495EDFF, 0.0, 0.0, 0.0, 30.0,0, 0);
    NPCTextBlack = Create3DTextLabel("Black Bus", 0x6495EDFF, 0.0, 0.0, 0.0, 30.0,0, 0);
    Create3DTextLabel("Press F to Exit", 0x6495EDFF, 2021.9740,2235.6626,2103.9536, 15.0,2);
    Create3DTextLabel("Press F to Exit", 0x6495EDFF, 2021.9740,2235.6626,2103.9536, 15.0,3);
    //Vehicles
    NPCBlueBus = CreateVehicle(431, 0.0, 0.0, 0.0, 0.0, 125, 125, 1);
    NPCBlackBus = CreateVehicle(431, 0.0, 0.0, 0.0, 0.0, 0, 0, 1);
    //Objects
    CreateObject(1257, 2868.9033203125, -1416.40625, 11.013171195984, 0, 0, 179.99450683594);//Bus Stops
    CreateObject(1257, 2636.32421875, -1693.125, 10.954420089722, 0, 0, 179.99450683594);
    CreateObject(1257, 2649.0073242188, -1710.6044921875, 11.185441970825, 0, 0, 0);
    CreateObject(1257, 2243.845703125, -1725.912109375, 13.596067428589, 0, 0, 90);
    CreateObject(1257, 2252.8876953125, -1738.87109375, 13.62606716156, 0, 0, 270);
    CreateObject(1257, 1948.3310546875, -1454.3525390625, 13.596067428589, 0, 0, 90);
    CreateObject(1257, 1926.419921875, -1472.359375, 13.62606716156, 0, 0, 270);
    CreateObject(1257, 1571.064453125, -2188.0107421875, 13.62606716156, 0, 0, 90);
    CreateObject(1257, 1712.9423828125, -1818.71484375, 13.62606716156, 0, 0, 270);
    CreateObject(1257, 1567.0966796875, -1725.4755859375, 13.62606716156, 0, 0, 90);
    CreateObject(1257, 1544.9990234375, -1739.0458984375, 13.62606716156, 0, 0, 270);
    CreateObject(1257, 1503.9716796875, -1027.76171875, 23.770128250122, 0, 0, 83.995971679688);
    CreateObject(1257, 1440.32421875, -1040.7060546875, 23.907316207886, 0, 0, 270);
    CreateObject(1257, 1188.8359375, -1354.6279296875, 13.648303985596, 0, 0, 179.99450683594);
    CreateObject(1257, 1212.8427734375, -1327.83984375, 13.647026062012, 0, 0, 0);
    CreateObject(1257, 861.71252441406, -1313.3009033203, 13.626066970825, 0, 0, 90);
    CreateObject(1257, 850.67578125, -1333.970703125, 13.615329742432, 0, 0, 270);
    CreateObject(1257, 393.69442749023, -1766.2702636719, 5.6197347640991, 0, 0, 90);
    CreateObject(1257, 1705.58984375, -1805.84765625, 13.530066490173, 0, 0, 90);//
    CreateObject(2631, 2022.0, 2236.7, 2102.9, 0.0, 0.0, 90.0);//Bus Interior
    CreateObject(2631, 2022.0, 2240.6, 2102.9, 0.0, 0.0, 90.0);
    CreateObject(2631, 2022.0, 2244.5, 2102.9, 0.0, 0.0, 90.0);
    CreateObject(2631, 2022.0, 2248.4, 2102.9, 0.0, 0.0, 90.0);
    CreateObject(16501, 2022.1, 2238.3, 2102.8, 0.0, 90.0, 0.0);
    CreateObject(16501, 2022.1, 2245.3, 2102.8, 0.0, 90.0, 0.0);
    CreateObject(16000, 2024.2, 2240.1, 2101.2, 0.0, 0.0, 90.0);
    CreateObject(16000, 2019.8, 2240.6, 2101.2, 0.0, 0.0, -90.0);
    CreateObject(16000, 2022.2, 2248.7, 2101.2, 0.0, 0.0, 180.0);
    CreateObject(16501, 2021.8, 2246.5, 2107.3, 0.0, 270.0, 90.0);
    CreateObject(16501, 2022.0, 2240.8, 2107.3, 0.0, 270.0, 0.0);
    CreateObject(16501, 2022.0, 2233.7, 2107.3, 0.0, 270.0, 0.0);
    CreateObject(18098, 2024.3, 2239.6, 2104.8, 0.0, 0.0, 90.0);
    CreateObject(18098, 2024.3, 2239.7, 2104.7, 0.0, 0.0, 450.0);
    CreateObject(18098, 2020.1, 2239.6, 2104.8, 0.0, 0.0, 90.0);
    CreateObject(18098, 2020.0, 2239.6, 2104.7, 0.0, 0.0, 90.0);
    CreateObject(2180, 2023.6, 2236.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2238.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2240.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2242.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2244.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2246.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2023.6, 2248.1, 2106.7, 0.0, 180.0, 90.0);
    CreateObject(2180, 2020.3, 2235.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2180, 2020.3, 2237.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2180, 2020.3, 2239.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2180, 2020.3, 2241.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2180, 2020.3, 2243.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2180, 2020.3, 2245.1, 2106.7, 0.0, 180.0, 270.0);
    CreateObject(2674, 2023.4, 2238.3, 2102.9, 0.0, 0.0, 600.0);
    CreateObject(2674, 2020.4, 2242.3, 2102.9, 0.0, 0.0, 600.0);
    CreateObject(2674, 2023.4, 2246.3, 2102.9, 0.0, 0.0, 600.0);
    CreateObject(14405, 2022.0, 2242.1, 2103.5, 0.0, 0.0, 540.0);
    CreateObject(14405, 2022.0, 2243.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2245.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2246.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2248.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2249.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2251.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2242.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2243.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2245.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2246.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2248.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2249.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2251.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2242.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2243.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2245.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2246.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2248.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2249.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2019.4, 2251.1, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(14405, 2022.0, 2253.6, 2104.0, -6.0, 0.0, 180.0);
    CreateObject(14405, 2021.1, 2253.6, 2104.0, -6.0, 0.0, 180.0);
    CreateObject(14405, 2024.6, 2253.6, 2103.5, 0.0, 0.0, 180.0);
    CreateObject(2674, 2020.4, 2235.7, 2102.9, 0.0, 0.0, 52.0);
    CreateObject(2673, 2020.4, 2246.7, 2102.9, 0.0, 0.0, 270.0);
    CreateObject(2700, 2023.5, 2235.1, 2105.5, 180.0, -4.0, 90.0);
    CreateObject(2700, 2020.4, 2235.1, 2105.5, 180.0, 0.0, 90.0);
    CreateObject(2700, 2023.5, 2242.1, 2105.5, 180.0, -4.0, 90.0);
    CreateObject(2700, 2020.4, 2242.1, 2105.5, 180.0, 0.0, 90.0);
    CreateObject(1799, 2023.1, 2234.2, 2105.7, 270.0, 0.0, 360.0);
    CreateObject(1799, 2019.8, 2234.2, 2105.7, 270.0, 0.0, 0.0);
    CreateObject(1538, 2022.7, 2234.7, 2102.8, 0.0, 0.0, 180.0);
    CreateObject(1799, 2022.1, 2234.2, 2106.1, 720.0, 90.0, 450.0);
    CreateObject(1799, 2021.8, 2234.2, 2105.1, 0.0, 270.0, 270.0);
    CreateObject(1799, 2022.1, 2234.2, 2107.3, 0.0, 90.0, 90.0);
    CreateObject(1799, 2021.6, 2234.2, 2106.3, 0.0, 270.0, 270.0);
    CreateObject(1799, 2022.3, 2234.2, 2104.3, 90.0, 0.0, 180.0);//
    return 1;
}
public OnPlayerConnect(playerid){
    BusID[playerid] = 0;
    BusCost[playerid] = 0;
    PlayerSitting[playerid] = 0;
    return 1;
}
public OnPlayerSpawn(playerid){
    if(IsPlayerNPC(playerid))    {
        new npcname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, npcname, sizeof(npcname));
        if(!strcmp(npcname, "BlueBusDriver", true)){
            SetPlayerColor(playerid, 0xFFFFFF00);
	    	PutPlayerInVehicle(playerid, NPCBlueBus, 0);
            SetPlayerSkin(playerid, 255);
            ResetPlayerWeapons(playerid);
            Attach3DTextLabelToVehicle(NPCTextBlue, NPCBlueBus, 0.0, 0.0, 0.0);
        }
        if(!strcmp(npcname, "BlackBusDriver", true)){
            SetPlayerColor(playerid, 0xFFFFFF00);
	    	PutPlayerInVehicle(playerid, NPCBlackBus, 0);
            SetPlayerSkin(playerid, 255);
            ResetPlayerWeapons(playerid);
            Attach3DTextLabelToVehicle(NPCTextBlack, NPCBlackBus, 0.0, 0.0, 0.0);
        }
        return 1;
    }
    return 1;
}
public OnPlayerDeath(playerid, killerid, reason){
    if(BusID[playerid]){
		BusID[playerid] = 0;
		BusCost[playerid] = 0;
		PlayerSitting[playerid] = 0;
		KillTimer(costtimer);
		SetPlayerVirtualWorld(playerid, 0);
    }
    return 1;
}
public OnPlayerText(playerid, text[]){
    new string[128];
    if(Playerx[playerid] != 0){
		return 0;
    }
    if(BusID[playerid] > 0){
        for(new i=0; i<MAX_PLAYERS; i++){
	    	if(Playerx[i] != 0){
                if(BusID[playerid] == BusID[i]){
		    		GetPlayerName(playerid, string, sizeof(string));
	            	format(string, sizeof(string), "%s says: %s", string, text);
                    if(IsPlayerInRangeOfPoint(playerid, 10/16, Playerx[i], Playery[i], Playerz[i])){
                        SendClientMessage(i, 0xE6E6E6E6, string);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 10/8, Playerx[i], Playery[i], Playerz[i])){
                        SendClientMessage(i, 0xC8C8C8C8, string);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 10/4, Playerx[i], Playery[i], Playerz[i])){
                        SendClientMessage(i, 0xAAAAAAAA, string);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 10/2, Playerx[i], Playery[i], Playerz[i])){
                        SendClientMessage(i, 0x8C8C8C8C, string);
                    }
                    else if(IsPlayerInRangeOfPoint(playerid, 10, Playerx[i], Playery[i], Playerz[i])){
                        SendClientMessage(i, 0x6E6E6E6E, string);
                    }
	            	return 1;
                }
            }
        }
        GetPlayerName(playerid, string, sizeof(string));
		format(string, sizeof(string), "%s says %s", string, text);
		ProxDetector(10, playerid, string, 0xE6E6E6E6, 0xC8C8C8C8, 0xAAAAAAAA, 0x8C8C8C8C, 0x6E6E6E6E);
		return 0;
    }
    return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
    if(strcmp("/gotobluebus", cmdtext, true) == 0){
		if(!IsPlayerAdmin(playerid)){
	    	SendClientMessage(playerid, COLOR_RED, "You are not authorised to use this command.");
	    	return 1;
        }
		if(BusID[playerid] > 0){
	    	SetPlayerVirtualWorld(playerid, 0);
		}
		PutPlayerInVehicle(playerid, NPCBlueBus, 2);
		SendClientMessage(playerid, COLOR_DARKAQUA, "You were teleported into the bus");
        return 1;
    }
    if(strcmp("/gotoblackbus", cmdtext, true) == 0)    {
        if(!IsPlayerAdmin(playerid)){
		    SendClientMessage(playerid, COLOR_RED, "You are not authorised to use this command.");
		    return 1;
		}
		if(BusID[playerid] > 0){
		    SetPlayerVirtualWorld(playerid, 0);
		}
		PutPlayerInVehicle(playerid, NPCBlackBus, 2);
		SendClientMessage(playerid, COLOR_DARKAQUA, "You were teleported into the bus");
		return 1;
    }
    if(strcmp("/lookout", cmdtext, true) == 0)    {
		if(!IsPlayerInRangeOfPoint(playerid, 10, 2021.9390,2241.9487,2103.9536)){
	    	SendClientMessage(playerid, COLOR_RED, "You are not inside a bus");
	    	return 1;
		}
        GetPlayerPos(playerid, Playerx[playerid], Playery[playerid], Playerz[playerid]);
		GetPlayerFacingAngle(playerid, Playera[playerid]);
		PlayerSkin[playerid] = GetPlayerSkin(playerid);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        TogglePlayerSpectating(playerid, 1);
		if(BusID[playerid] == 1){
            PlayerSpectateVehicle(playerid, NPCBlueBus);
        }
        else{
            PlayerSpectateVehicle(playerid, NPCBlackBus);
        }
        SetTimerEx("ResetView", 2000, 0, "d", playerid);
		return 1;
    }
    if(strcmp("/sit", cmdtext, true) == 0)    {
        ApplyAnimation(playerid,"PED","SEAT_idle",1.0,1,0,0,0,0);
        PlayerSitting[playerid] = 1;
		return 1;
    }
    if(strcmp("/busroute", cmdtext, true) == 0)    {
		if(IsAtBlueBusStop(playerid))	{
		    SendClientMessage(playerid, COLOR_TEAL, "Blue Bus Route: East Beach - The Stadium - The Gym - The County General Hospital - Los Santos International Airport - Taxi Stand");
		    return 1;
		}
		else if(IsAtBlackBusStop(playerid))	{
		    SendClientMessage(playerid, COLOR_TEAL, "Black Bus Route: Taxi Stand - Police Department - The Bank - All Saints Hospital - Market Station - Santa Maria Beach");
		    return 1;
		}
		else	{
		    SendClientMessage(playerid, COLOR_RED, "You are not at any bus stop");
		}
		return 1;
    }
    if(strcmp("/buslocation", cmdtext, true) == 0){
        new Float:busx, Float:busy, Float:busz;
		if(IsAtBlueBusStop(playerid))	{
		    GetVehiclePos(NPCBlueBus, busx, busy, busz);
		    SetPlayerCheckpoint(playerid, busx, busy, busz, 0);
		    GameTextForPlayer(playerid, "~w~Locating ~r~Bus~w~. . . .", 2000, 3);
		    SetTimerEx("CPOff", 3000, 0, "d", playerid);
		    return 1;
		}
		else if(IsAtBlackBusStop(playerid))	{
		    GetVehiclePos(NPCBlackBus, busx, busy, busz);
			SetPlayerCheckpoint(playerid, busx, busy, busz, 0);
		    GameTextForPlayer(playerid, "~w~Locating ~r~Bus~w~. . . .", 2000, 3);
		    SetTimerEx("CPOff", 3000, 0, "d", playerid);
		    return 1;
		}
		else	{
		    SendClientMessage(playerid, COLOR_RED, "You are not at any bus stop");
		}
		return 1;
    }
    return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate){
    if(newstate == PLAYER_STATE_PASSENGER){
		if(GetPlayerVehicleID(playerid) == NPCBlueBus){
			SetPlayerVirtualWorld(playerid, 2);
			SetPlayerPos(playerid, 2021.9740,2235.6626,2103.9536);
			SetPlayerFacingAngle(playerid, 355.3504);
			SetCameraBehindPlayer(playerid);
		    SetPlayerInterior(playerid, 1);
		    BusID[playerid] = 1;
			GameTextForPlayer(playerid, "~w~Blue Bus", 3000, 1);
		    costtimer = SetTimerEx("CostTimer", 30000, 1, "d", playerid);
			BusCost[playerid] += 20;
		}
		else if(GetPlayerVehicleID(playerid) == NPCBlackBus){
			SetPlayerVirtualWorld(playerid, 3);
			SetPlayerPos(playerid, 2021.9740,2235.6626,2103.9536);
			SetPlayerFacingAngle(playerid, 355.3504);
			SetCameraBehindPlayer(playerid);
			SetPlayerInterior(playerid, 1);
		    BusID[playerid] = 2;
		    GameTextForPlayer(playerid, "~w~Black Bus", 3000, 1);
			costtimer = SetTimerEx("CostTimer", 30000, 1, "d", playerid);
		    BusCost[playerid] += 20;
		}
    }
    return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    new string[128];
    if(newkeys == KEY_SECONDARY_ATTACK){
        if(IsPlayerConnected(playerid)){
            if(IsPlayerInRangeOfPoint(playerid, 1, 2021.9740,2235.6626,2103.9536)){
				new Float:busx, Float:busy, Float:busz, Float:angle;
				if(BusID[playerid] == 1){
		            GetVehiclePos(NPCBlueBus, busx, busy, busz);
				    GetVehicleZAngle(NPCBlueBus, angle);
				}
				else{
					GetVehiclePos(NPCBlackBus, busx, busy, busz);
				    GetVehicleZAngle(NPCBlackBus, angle);
				}
				GetPlayerName(playerid, string, sizeof(string));
				format(string, sizeof(string), "%s opens the door and exits the bus.", string);
				for(new i=0; i<MAX_PLAYERS; i++){
				    if(BusID[i] == BusID[playerid]){
						SendClientMessage(i, COLOR_PURPLE, string);
				    }
				}
				angle = 360 - angle;
				busx = floatsin(angle,degrees) * 1.5 + floatcos(angle,degrees) * 1.5 + busx;
				busy = floatcos(angle,degrees) * 1 - floatsin(angle,degrees) * 1 + busy;
				busz = 1 + busz;
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				SetPlayerPos(playerid, busx, busy, busz);
				BusID[playerid] = 0;
				KillTimer(costtimer);
				format(string, sizeof(string), "~r~-$%d", BusCost[playerid]);
				GameTextForPlayer(playerid, string, 3000, 1);
				GivePlayerMoney(playerid, -BusCost[playerid]);
				BusCost[playerid] = 0;
            }
		}
    }
    if(newkeys == KEY_CROUCH){
        if(IsPlayerNPC(playerid)){
	    new npcvehicle = GetPlayerVehicleID(playerid);
	    	if(npcvehicle == NPCBlueBus){
				if(IsPlayerInRangeOfPoint(playerid, 100, 2868.9033,-1416.4062,11.0131)){
	            	format(string, sizeof(string), "[Bus Driver] The Bus has reached East Beach.");
	        	}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 2636.3242,-1693.125,10.9544)){
	            	format(string, sizeof(string), "[Bus Driver] The Bus has reached The Stadium.");
	        	}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 2243.8457,-1725.9121,13.5960)){
		    		format(string, sizeof(string), "[Bus Driver] The Bus has reached The Gym.");
				}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 1948.3310,-1454.3525,13.5960)){
                    format(string, sizeof(string), "[Bus Driver] The Bus has reached The County General Hospital.");
	        	}
	        	else if(IsPlayerInRangeOfPoint(playerid, 100, 1571.0644,-2188.0107,13.6260)){
                    format(string, sizeof(string), "[Bus Driver] The Bus has reached Los Santos International Airport.");
	        	}
	        	else if(IsPlayerInRangeOfPoint(playerid, 100, 1712.9423,-1818.7148,13.6260)){
                    format(string, sizeof(string), "[Bus Driver] The Bus has reached The Taxi Stand.");
	        	}
		        for(new i = 0; i < MAX_PLAYERS; i++){
				    if(IsPlayerInRangeOfPoint(i, 10, 2021.9390,2241.9487,2103.9536) && BusID[i] == 1){
						SendClientMessage(i, COLOR_OFFWHITE, string);
						PlayerPlaySound(i, 1147, 0.0, 0.0, 0.0);
				    }
		        }
	    	}
            else if(npcvehicle == NPCBlackBus){
                if(IsPlayerInRangeOfPoint(playerid, 100, 1567.0966,-1725.4755,13.6260)){
	            format(string, sizeof(string), "[Bus Driver] The Bus has reached The Police Department.");
	        	}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 1503.9716,-1027.7617,23.7701)){
	            format(string, sizeof(string), "[Bus Driver] The Bus has reached The Bank.");
	        	}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 1188.8359,-1354.6279,13.6483)){
		    		format(string, sizeof(string), "[Bus Driver] The Bus has reached All Saints Hospital.");
				}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 861.7125,-1313.3009,13.6260)){
                    format(string, sizeof(string), "[Bus Driver] The Bus has reached Market Station.");
	        	}
                else if(IsPlayerInRangeOfPoint(playerid, 100, 393.6944,-1766.2702,5.6197)){
                    format(string, sizeof(string), "[Bus Driver] The Bus has reached Santa Maria Beach.");
	        	}
		        else if(IsPlayerInRangeOfPoint(playerid, 100, 1705.5898,-1805.8476,13.5300)){
	                    format(string, sizeof(string), "[Bus Driver] The Bus has reached The Taxi Stand.");
		        }
		        for(new i = 0; i < MAX_PLAYERS; i++){
				    if(IsPlayerInRangeOfPoint(i, 10, 2021.9390,2241.9487,2103.9536) && BusID[i] == 2){
		                        SendClientMessage(i, COLOR_OFFWHITE, string);
						PlayerPlaySound(i, 1147, 0.0, 0.0, 0.0);
				    }
		        }
			}
        }
    }
    if(newkeys == KEY_FIRE){
        if(PlayerSitting[playerid] == 1){
           ClearAnimations(playerid, 1);
           PlayerSitting[playerid] = 0;
        }
    }
    return 1;
}
public IsAtBlueBusStop(playerid){
    if(IsPlayerConnected(playerid)){
        if(IsPlayerInRangeOfPoint(playerid,2.0,2868.9033,-1416.4062,11.0131) || IsPlayerInRangeOfPoint(playerid,2.0,2636.3242,-1693.125,10.9544) || IsPlayerInRangeOfPoint(playerid,2.0,2649.0073,-1710.6044,11.1854)
           || IsPlayerInRangeOfPoint(playerid,2.0,2243.8457,-1725.9121,13.5960) || IsPlayerInRangeOfPoint(playerid,2.0,2252.8876,-1738.8710,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1948.3310,-1454.3525,13.5960)
           || IsPlayerInRangeOfPoint(playerid,2.0,1926.4199,-1472.3593,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1571.0644,-2188.0107,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1712.9423,-1818.7148,13.6260))
	        {
	            return 1;
	        }
    }
    return 0;
}
public IsAtBlackBusStop(playerid){
    if(IsPlayerConnected(playerid)){
        if(IsPlayerInRangeOfPoint(playerid,2.0,1567.0966,-1725.4755,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1544.9990,-1739.0458,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,1503.9716,-1027.7617,23.7701)
    	   || IsPlayerInRangeOfPoint(playerid,2.0,1440.3242,-1040.7060,23.9073) || IsPlayerInRangeOfPoint(playerid,2.0,1188.8359,-1354.6279,13.6483) || IsPlayerInRangeOfPoint(playerid,2.0,1212.8427,-1327.8398,13.6470)
    	   || IsPlayerInRangeOfPoint(playerid,2.0,861.7125,-1313.3009,13.6260) || IsPlayerInRangeOfPoint(playerid,2.0,850.6757,-1333.9707,13.6153) || IsPlayerInRangeOfPoint(playerid,2.0,393.6944,-1766.2702,5.6197)
    	   || IsPlayerInRangeOfPoint(playerid,2.0,1705.5898,-1805.8476,13.5300))
			{
			    return 1;
			}
    }
    return 0;
}
public ResetView(playerid){
    TogglePlayerSpectating(playerid, 0);
    SetPlayerInterior(playerid, 1);
    SetPlayerPos(playerid, Playerx[playerid], Playery[playerid], Playerz[playerid]);
    SetPlayerFacingAngle(playerid, Playera[playerid]);
    SetPlayerSkin(playerid, PlayerSkin[playerid]);
    SetCameraBehindPlayer(playerid);
    if(PlayerSitting[playerid] == 1){
        ApplyAnimation(playerid,"PED","SEAT_idle",30.0,1,0,0,0,0);
    }
    if(BusID[playerid] == 1){
        SetPlayerVirtualWorld(playerid, 2);
    }
    else{
        SetPlayerVirtualWorld(playerid, 3);
    }
    Playerx[playerid] = 0;
}
public CPOff(playerid){
    DisablePlayerCheckpoint(playerid);
}
public CostTimer(playerid){
    BusCost[playerid] += 20;
}
public ProxDetector(Float:radi, playerid, string[], color1, color2, color3, color4, color5){
    if(IsPlayerConnected(playerid)){
        new Float:playerposx, Float:playerposy, Float:playerposz;
		GetPlayerPos(playerid, playerposx, playerposy, playerposz);
		for(new i = 0; i < MAX_PLAYERS; i++){
            if(IsPlayerConnected(i)){
                if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)){
		    		if(IsPlayerInRangeOfPoint(i, radi/16, playerposx, playerposy, playerposz)){
                        SendClientMessage(i, color1, string);
                    }
                    else if(IsPlayerInRangeOfPoint(i, radi/8, playerposx, playerposy, playerposz)){
                        SendClientMessage(i, color2, string);
                    }
                    else if(IsPlayerInRangeOfPoint(i, radi/4, playerposx, playerposy, playerposz)){
                        SendClientMessage(i, color3, string);
                    }
                    else if(IsPlayerInRangeOfPoint(i, radi/2, playerposx, playerposy, playerposz)){
                        SendClientMessage(i, color4, string);
                    }
                    else if(IsPlayerInRangeOfPoint(i, radi, playerposx, playerposy, playerposz)){
                        SendClientMessage(i, color5, string);
                    }
                }
            }
            else{
	        SendClientMessage(i, color1, string);
	    	}
        }
    }
    return 1;
}