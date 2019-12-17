#include <a_samp>
#include <a_sampmysql>

#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA

#define MYSQL_ADDRESS "localhost"   //Adjust these values to your server
#define MYSQL_NAME "name"
#define MYSQL_PW "abc123"
#define MYSQL_DBNAME "samp"
#define MAX_BOMBS 10
#define SHOW_HP 0       //Used for debugging and testing, if you want to, you can enable it
#define USE_TEXTDRAW 0  //See the forum thread for information

#define KEY_DROP_BOMB KEY_HANDBRAKE
#define KEY_NEXT_BOMBTYPE KEY_ANALOG_DOWN
#define KEY_PREV_BOMBTYPE KEY_ANALOG_UP

#define FILTERSCRIPT

// Free changeable stuff -------------

//Names of the bombtypes
new gBombTypes[7][32] = {
"Nothing",
"Normal bomb",
"Fire bomb",
"Big bomb",
"High-precision bomb",
"Posion gas bomb",
"Heavy bomb"
}

//{Explosion ID, Radius, Accuracy (Height / this value = max x,y tolerance), bomb model id, bomb model rotation, delay (ms) from touching ground to detonating, minimum time (ms) between drops}
new Float:gBombID[7][7] = {
{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
{11.0, 2.0, 7.0, 1636.0, 270.0, 0.0, 125.0},
{1.0, 4.0, 8.5, 1636.0, 270.0, 0.0, 180.0},
{7.0, 4.5, 10.0, 354.0, 270.0, 0.0, 750.0},
{6.0, 2.0, 25.0, 1636.0, 270.0, 0.0, 1000.0},
{-1.0, 4.5, 10.0, 2780.0, 0.0, 20000.0, 3000.0},    //Explosion ID -1 is used for special explosions
{-1.0, 5.0, 15.0, 345.0, 270.0, 0.0, 10000.0}       //for more info look at CreateSpecialExplosion
}

//[Vehicle model ID, bombtype 1 allowed, bombtype 2 allowed, ..., bombtype n allowed}
//needs to be expanded, when more bombtypes are available
new gVehicleBombs[16][8] = {
	{476, 1, 1, 1, 0, 0, 0, 0},      //Rustler
	{593, 1, 0, 1, 0, 0, 0, 0},      //Dodo
	{553, 1, 1, 1, 0, 1, 1, 1},      //Nevada
	{513, 1, 0, 1, 0, 0, 0, 0},      //Stuntplane
	{512, 1, 0, 1, 0, 0, 0, 0},      //Cropdust
	{577, 1, 1, 1, 1, 1, 1, 1},      //At-400
	{511, 1, 1, 1, 0, 0, 0, 0},      //Beagle
	{460, 1, 0, 1, 0, 0, 0, 0},      //Skimmer
	{519, 1, 1, 1, 1, 1, 1, 0},      //Shamal
	{548, 1, 1, 1, 0, 0, 1, 1},      //Cargobob
	{417, 1, 1, 1, 0, 1, 1, 0},      //Leviathan
	{487, 1, 1, 1, 0, 0, 0, 0},      //Maverick
	{497, 1, 1, 1, 0, 0, 1, 0},      //Police Maverick
	{563, 1, 1, 1, 0, 1, 0, 0},      //Raindance
	{447, 1, 0, 1, 0, 0, 0, 0},      //Seasparrow
	{469, 1, 0, 1, 0, 0, 0, 0}       //Sparrow
}

new Float:gBombSpeed = 20.0;
// ----------------------------------
// Global variables ---------------
new bombid[MAX_PLAYERS][MAX_BOMBS];     //Used for different stuff
new bombtime[MAX_PLAYERS][MAX_BOMBS];
new bombcount[MAX_PLAYERS];
new bombarmed[MAX_PLAYERS][MAX_BOMBS];
new Float:targetz[MAX_PLAYERS][MAX_BOMBS];
new boti[MAX_PLAYERS][MAX_BOMBS];
new bfree[MAX_PLAYERS][sizeof gBombTypes];
new btype[MAX_PLAYERS][MAX_BOMBS];
new bptype[MAX_PLAYERS] = 0;
new vmid[MAX_PLAYERS] = -1;

new Text:bombint[MAX_PLAYERS];  //For Textdraws
new Text:vint[MAX_PLAYERS];
new vintupdate[MAX_PLAYERS];

new poisoned[MAX_PLAYERS];      //For poison gas
new poisontimer[MAX_PLAYERS];
new poisonpl[MAX_PLAYERS];
// ----------------------------------

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
        print("\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print("X         Bombing filterscript  V0.9        X");
        print("X          created by Mauzen 7/2008         X");
        print("XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX");
        if(!(samp_mysql_connect(MYSQL_ADDRESS, MYSQL_NAME, MYSQL_PW) == 1) || !(samp_mysql_select_db(MYSQL_DBNAME) == 1)) {
		    print("Database Error!");
		}
		print("XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX\n");
        
        
        return 1;
}

public OnFilterScriptExit()
{
        print("\nxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
        print("X         Bombing filterscript  V0.9        X");
        print("X    Unloading and closing connection...    X");
        print("XxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxX\n");
        samp_mysql_close();
		return 1;
}
#endif


public OnPlayerConnect(playerid)
{
		if(USE_TEXTDRAW) {
			bombint[playerid] = TextDrawCreate(500, 110, "Nothing");
		}
        vint[playerid] = TextDrawCreate(500, 70, "HP: 0");
        return 1;
}

public OnPlayerDisconnect(playerid)
{
        if(USE_TEXTDRAW) {
			TextDrawDestroy(Text:bombint[playerid]);
		}
		TextDrawDestroy(Text:vint[playerid]);
		return 1;
}

public OnPlayerSpawn(playerid)
{
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
        if(USE_TEXTDRAW) {
			TextDrawHideForPlayer(playerid, Text:bombint[playerid]);
		}
		if(SHOW_HP) {
			TextDrawHideForPlayer(playerid, Text:vint[playerid]);
			KillTimer(vintupdate[playerid]);
		}
		return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
		vmid[playerid] = GetVehicleStatID(GetVehicleModel(vehicleid));
        if(vmid[playerid] > -1) {
			bptype[playerid] = 0;
            if(USE_TEXTDRAW) {
				TextDrawSetString(Text:bombint[playerid], gBombTypes[bptype[playerid]]);
				TextDrawShowForPlayer(playerid, Text:bombint[playerid]);
			}
		}
		if(SHOW_HP) {
			vintupdate[playerid] = SetTimerEx("UpdateCarHealth", 250, 1, "i", playerid);
			TextDrawShowForPlayer(playerid, Text:vint[playerid]);
		}
		return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
        if(USE_TEXTDRAW) {
			TextDrawHideForPlayer(playerid, Text:bombint[playerid]);
		}
        if(SHOW_HP) {
			TextDrawHideForPlayer(playerid, Text:vint[playerid]);
			KillTimer(vintupdate[playerid]);
		}
		return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
		if(IsPlayerInAnyVehicle(playerid) && (vmid[playerid] > -1)) {
			new old[MAX_PLAYERS];
			if(GetKeyPressed(newkeys, KEY_NEXT_BOMBTYPE)) {
				old[playerid] = bptype[playerid];
				bptype[playerid] ++;
                if(bptype[playerid] >= sizeof gBombTypes) {
					bptype[playerid] = old[playerid];
				}
				while(gVehicleBombs[vmid[playerid]][bptype[playerid] + 1] <= 0) {
					bptype[playerid] ++;
			        if(bptype[playerid] >= sizeof gBombTypes) {
						bptype[playerid] = old[playerid];
						return 1;
					}
				}
                if(USE_TEXTDRAW) {
					TextDrawSetString(Text:bombint[playerid], gBombTypes[bptype[playerid]]);
				} else {
				    new str[64];
				    format(str, 64, "You have selected %s", gBombTypes[bptype[playerid]]);
				    SendClientMessage(playerid, COLOR_YELLOW, str);
				}
		    }
		    if(GetKeyPressed(newkeys, KEY_PREV_BOMBTYPE)) {
                old[playerid] = bptype[playerid];
				bptype[playerid] --;
	        	if(bptype[playerid] < 0) {
					bptype[playerid] = old[playerid];
				}
				while(gVehicleBombs[vmid[playerid]][bptype[playerid] + 1] <= 0) {
					bptype[playerid] --;
		        	if(bptype[playerid] < 0) {
						bptype[playerid] = old[playerid];
						return 1;
					}
				}
				if(USE_TEXTDRAW) {
					TextDrawSetString(Text:bombint[playerid], gBombTypes[bptype[playerid]]);
				} else {
				    new str[64];
				    format(str, 64, "You have selected %s", gBombTypes[bptype[playerid]]);
				    SendClientMessage(playerid, COLOR_YELLOW, str);
				}
		    }
			if(GetKeyPressed(newkeys, KEY_DROP_BOMB)) {
				DropBomb(playerid);
			}
		}
		return 1;
}

// -----------------------------------------------------------------------------

//useful stuff

public GetKeyPressed(code, key) {
		for(new i = 65536; i > 0; i = i / 2) {
		    if(code >= i) {
		        code = code - i;
		        if(i == key) return 1;
			}
		}
		return 0;
}

public Float:floatrandom(Float:max) {
		new Float:rand;
		max = max * 100000;
		rand = floatdiv(float(random(floatround(max))), 100000.0);
		return rand;
}

public Float:GetPlayerDistanceToPoint(playerid, Float:x, Float:y, Float:z) {
		new Float:px;
		new Float:py;
		new Float:pz;
		GetPlayerPos(playerid, px, py, pz);
		return floatsqroot( floatadd( floatadd( floatpower(floatsub(x, px), 2), floatpower(floatsub(y, py), 2) ), floatpower(floatsub(z, pz), 2) ) );
}

public Float:GetGroundZ(Float:x, Float:y) {
		new rxy[96];
		x = 5.0 * floatround(x / 5.0);
		y = 5.0 * floatround(y / 5.0);
		format(rxy, 96, "SELECT z FROM hmap WHERE x = %d AND y = %d;", floatround(x), floatround(y));
		samp_mysql_query(rxy);
		samp_mysql_store_result();
		samp_mysql_fetch_row(rxy);
		samp_mysql_free_result();
		return floatstr(rxy);
}

public GetVehicleStatID(modelid) {
	for(new i = 0; i < sizeof gVehicleBombs; i ++) {
	    if(gVehicleBombs[i][0] == modelid) {
	        return i;
		}
	}
	return -1;
}

// -----------------------------------------------------------------------------

public DropBomb(playerid) {
		if(bptype[playerid] != 0) {
			if(bfree[playerid][bptype[playerid]] == 0) {
				if(bombcount[playerid] < MAX_BOMBS) {
					bfree[playerid][bptype[playerid]] = 1;
			        bombcount[playerid] ++;
					new Float:x;
					new Float:y;
					new Float:z;
					new sel;
					for(new i = 0; i < MAX_BOMBS; i++) {
					    if(bombid[playerid][i] <= 0) {
					        sel = i;
					        bombid[playerid][i] = 1;
					        break;
						}
					}
					btype[playerid][sel] = bptype[playerid];
					GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
					new Float:tolerancex = floatsub( floatrandom( floatdiv(z, gBombID[btype[playerid][sel]][2]) ), floatdiv(floatdiv(z, gBombID[btype[playerid][sel]][2]), 2.0));
					new Float:tolerancey = floatsub( floatrandom( floatdiv(z, gBombID[btype[playerid][sel]][2]) ), floatdiv(floatdiv(z, gBombID[btype[playerid][sel]][2]), 2.0));
					targetz[playerid][sel] = GetGroundZ(x + tolerancex, y + tolerancey);
					if(targetz[playerid][sel] == 0.0) {
							SendClientMessage(playerid, COLOR_RED, "Warning! The bomb detonator is damaged. Bomb will be activated on default water level.");
					}
					bombid[playerid][sel] = CreateObject(floatround(gBombID[btype[playerid][sel]][3]), x, y, z - 1, gBombID[btype[playerid][sel]][4], 0, 0);
					MoveObject(bombid[playerid][sel], x + tolerancex, y + tolerancey, targetz[playerid][sel] - 1, gBombSpeed);
			        boti[playerid][sel] = 0;
			        bombarmed[playerid][sel] = 0;
					bombtime[playerid][sel] = SetTimerEx("BombTimer", 100, 1, "ii", playerid, sel);
					SetTimerEx("ReactivateBomb", floatround(gBombID[bptype[playerid]][6]), 0, "ii", playerid, bptype[playerid]);
				} else {
				    SendClientMessage(playerid, COLOR_RED, "Too many active bombs, cannot control more at once!");
				}
            } else {
			    SendClientMessage(playerid, COLOR_RED, "The bomb need to be prepared! Wait a moment...");
			}
        } else {
		}
}

public BombTimer(playerid, num) {
	    new Float:x;
		new Float:y;
		new Float:z;
		GetObjectPos(bombid[playerid][num], x, y, z);
		boti[playerid][num] ++;
		if(bombarmed[playerid][num]) {
			// If you want to add a posion effect to your bomb you need to add a check like this
			if(btype[playerid][num] == 6) {     //Poison gas
				for(new i = 0; i < MAX_PLAYERS; i ++) {     //look for players near the bomb
			        if((GetPlayerDistanceToPoint(i, x, y, z) <= gBombID[btype[playerid][num]][1])) {
						if(poisoned[i] == 0) {
							poisonpl[i] = playerid;     //used for kill-detection, not important yet
							poisoned[i] = 50;           //set the "poison level" of the player
							ApplyAnimation(i, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1);     //if you want to, let him look poisoned ;)
				            KillTimer(poisontimer[i]);
				            poisontimer[i] = SetTimerEx("Poison", 200, 1, "if", i, 0.7);
				            //each time the timer gets called (here 200ms) player 'i' (player next to the bomb) gets '0.7' damage
				            //and his poison level is decreased by 1 until it reaches 0 again
						} else {
						    poisoned[i] = 50;   //if he stays within the poison radius, his poison level does not decrease
						}
			            break;
					}
				}
			}
		}
		if((floatsub(z, targetz[playerid][num] - 1) < 0.1) && !bombarmed[playerid][num]) {  //bomb reached ground
			if(gBombID[btype[playerid][num]][5] > 0.0) {
				SetTimerEx("DetonateBomb", floatround(gBombID[btype[playerid][num]][5]), 0, "ii", playerid, num);
				bombarmed[playerid][num] = 1;
			} else {
			    DetonateBomb(playerid, num);
			}
		}
}

public DetonateBomb(playerid, num) {
	    new Float:x;
		new Float:y;
		new Float:z;
		GetObjectPos(bombid[playerid][num], x, y, z);
		KillTimer(bombtime[playerid][num]);
		if(floatround(gBombID[btype[playerid][num]][0]) != -1.0) {
			CreateExplosion(x, y, z, floatround(gBombID[btype[playerid][num]][0]), gBombID[btype[playerid][num]][1]);
		} else {
			CreateSpecialExplosion(num, playerid);
		}
		DestroyObject(bombid[playerid][num]);
	    bombid[playerid][num] = -1;
		bombcount[playerid] --;
}

public CreateSpecialExplosion(num, playerid) {              //Every explosion wit explosion ID -1 is created here
	    new Float:x;                                        //You may add a check for your own bombs like the one already existing
		new Float:y;
		new Float:z;
		GetObjectPos(bombid[playerid][num], x, y, z);
		if(btype[playerid][num] == 6) {                     //btype[playerid][num] is the index of the bomb exploding
		    CreateExplosion(x, y, z, 7, 4.0);               //x, y and z are the coordinates of the bomb
		    CreateExplosion(x, y, z + 5.0, 1, 4.0);
		    CreateExplosion(x, y, z + 9.0, 1, 3.0);
		    CreateExplosion(x, y, z + 12.5, 1, 3.0);
		    CreateExplosion(x + 4.0, y, z, 0, 2.0);
		    CreateExplosion(x - 4.0, y, z, 0, 2.0);
		    CreateExplosion(x, y + 4.0, z, 0, 2.0);
		    CreateExplosion(x, y - 4.0, z, 0, 2.0);
		    CreateExplosion(x, y - 7.0, z, 1, 3.0);
		    CreateExplosion(x, y + 7.0, z, 1, 3.0);
		    CreateExplosion(x + 7.0, y, z, 1, 3.0);
		    CreateExplosion(x - 7.0, y, z, 1, 3.0);
		    CreateExplosion(x + 4.0, y + 4.0, z, 1, 4.0);
		    CreateExplosion(x - 4.0, y - 4.0, z, 1, 4.0);
		    CreateExplosion(x - 4.0, y + 4.0, z, 1, 4.0);
		    CreateExplosion(x + 4.0, y - 4.0, z, 1, 4.0);
		}
		if(btype[playerid][num] == 7) {
		}
		//To add an own explosion create a new check like this:
		/*if(btype[playerid][num] == YOUR_BOMB_INDEX) {
		    ...your explosion...
		}*/
}

public ReactivateBomb(playerid, bombnum) {
		bfree[playerid][bombnum] = 0;
}

public UpdateCarHealth(playerid) {
		new str[8];
		new Float:hp;
		GetVehicleHealth(GetPlayerVehicleID(playerid), hp);
		format(str, 8, "HP: %d", floatround(hp));
		TextDrawSetString(vint[playerid], str);
}

public Poison(playerid, Float:dmg) {
		new Float:hp;
		GetPlayerHealth(playerid, hp);
		if(hp <= 0.0) poisoned[playerid] = -1;
		SetPlayerHealth(playerid, hp - dmg);
		poisoned[playerid] --;
		ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1);
		if(poisoned[playerid] <= 0) {
			KillTimer(poisontimer[playerid]);
			ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0);
		}
}
