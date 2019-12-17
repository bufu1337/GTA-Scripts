/*----------------------------------------------------------------------------
					==================================
					Usefull GM Incs fusioned by cmg4life
					==================================
------------------------------------------------------------------------------*/





#include <a_samp>


//////////////////////////////////////////////////
//////////////////////////////////////////////////
///       EasyGates by cmg4life               ///
///                                           ///
//////////////////////////////////////////////////
//////////////////////////////////////////////////


/*Natives
native AddGate(Float:Xopen, Float:Yopen, Float:Zopen,rXclose,rYclose,rZclose, Float:Xclose, Float:Yclose, Float:Zclose)
native OpenGate(gateid, Float:speed);
native CloseGate(gateid, Float:speed);
native DestroyGate(gateid);
native GateExists(gateid);
*/
#define MAX_STRING 256
#define MAX_GATES 50
enum ginf
{
	gID,
	Float:Xo,
	Float:Yo,
	Float:Zo,
	Float:Xc,
	Float:Yc,
	Float:Zc,
	Float:rXc,
	Float:rYc,
	Float:rZc
}

new Gate[MAX_GATES][ginf];

stock AddGate(Float:Xopen, Float:Yopen, Float:Zopen,rXclose,rYclose,rZclose, Float:Xclose, Float:Yclose, Float:Zclose)
{

	new gateid;
	gateid++;
	if( Gate[gateid][gID] > 50 ) return print("Gate not created, Too many gates !");
	Gate[gateid][gID] = CreateObject(969, Xclose, Yclose,Zclose, rXclose, rYclose, rZclose);
	Gate[gateid][Xc] = Xclose;
	Gate[gateid][Yc] = Yclose;
	Gate[gateid][Zc] = Zclose;
	Gate[gateid][Xo] = Xopen;
	Gate[gateid][Yo] = Yopen;
	Gate[gateid][Zo] = Zopen;
	Gate[gateid][rXc] = rXclose;
	Gate[gateid][rYc] = rYclose;
	Gate[gateid][rZc] = rZclose;
	return gateid;
}

stock OpenGate(gateid, Float:speed)
{

	MoveObject(Gate[gateid][gID], Gate[gateid][Xo], Gate[gateid][Yo], Gate[gateid][Zo], speed);
	return 1;
}

stock CloseGate(gateid, Float:speed)
{

	MoveObject(Gate[gateid][gID], Gate[gateid][Xc], Gate[gateid][Yc], Gate[gateid][Zc], speed);
	return 1;
}

stock DestroyGate(gateid)
{
	DestroyObject(Gate[gateid][gID]);
	return 1;
}

stock GateExists(gateid)
{

	if(IsValidObject(Gate[gateid][gID])) return 1; else return 0;
}



//////////////////////////////////////////////////
//////////////////////////////////////////////////
///        Matraka's Checkpoint Streamer       ///
///                                            ///
/// Author: [MPA]matraka_IDG                   ///
/// Contact: msn_matraka@gtabrasil.net         ///
///                                            ///
///   ---===Infernus Development Group===---   ///
//////////////////////////////////////////////////
//////////////////////////////////////////////////

/*Natives
native CAddCheckpoint(Float:X,Float:Y,Float:Z,Float:size,Float:spawn_dist);
native CIsPlayerInCheckpoint(playerid,cpid);
native CIsPlayerInAnyCheckpoint(playerid,cpid);
native CRemoveCheckpoint(cpid);
native CGetPlayerCheckpoint(playerid);
*/

#define MAX_CHECKPOINTS 500

forward CPSERVICE_Handler();
enum cpinfo
{
	Float:cpX,
	Float:cpY,
	Float:cpZ,
	Float:cpsz,
	cpsd,
};
new CPSERVICE_active;
new Checkpoints[MAX_CHECKPOINTS][cpinfo];
new UsedCPSlot[MAX_CHECKPOINTS];
new CPSERVICE_actualcp[MAX_PLAYERS];

stock CAddCheckpoint(Float:X,Float:Y,Float:Z,Float:size,spawn_dist)
{
	new cpid=1;
	while(UsedCPSlot[cpid] == 1) cpid++;
	if(CPSERVICE_active == 0){
	    SetTimer("CPSERVICE_Handler",500,true);
	    CPSERVICE_active=1;
	}
	UsedCPSlot[cpid]=1;
	Checkpoints[cpid][cpX]=X;
	Checkpoints[cpid][cpY]=Y;
	Checkpoints[cpid][cpZ]=Z;
	Checkpoints[cpid][cpsz]=size;
	Checkpoints[cpid][cpsd]=spawn_dist;
	return cpid;
}

stock CIsPlayerInCheckpoint(playerid,cpid)
{
	if(!IsPlayerInCheckpoint(playerid)) return 0;
	if(CPSERVICE_actualcp[playerid] == cpid) return 1;
	else return 0;
}

stock CIsPlayerInAnyCheckpoint(playerid)
{
	if(!IsPlayerInCheckpoint(playerid)) return 0;
	if(CPSERVICE_actualcp[playerid] == 0) return 0;
	else return 1;
}

stock CGetPlayerCheckpoint(playerid) if(!IsPlayerInCheckpoint(playerid)) return 0; else return CPSERVICE_actualcp[playerid];

stock CRemoveCheckpoint(cpid)
{
	if(cpid == 0 || UsedCPSlot[cpid] == 0) return 0;
	UsedCPSlot[cpid]=0;
	return 1;
}

public CPSERVICE_Handler()
{
	for(new i; i<MAX_PLAYERS; i++){
		new Float:prevdist = 100000.000;
		new prevcp;
		for(new cpid=1; cpid < MAX_CHECKPOINTS; cpid++){
			if(UsedCPSlot[cpid]) {
			    new Float:dist;
			    dist = CPSERVICE_getdist(i,Checkpoints[cpid][cpX],Checkpoints[cpid][cpY],Checkpoints[cpid][cpZ]);
				if(dist < prevdist){
		    		prevdist = dist;
			 		prevcp = cpid;
				}
			}
		}
		new cpid=prevcp;
		if(CPSERVICE_getdist(i,Checkpoints[cpid][cpX],Checkpoints[cpid][cpY],Checkpoints[cpid][cpZ]) < Checkpoints[cpid][cpsd]) {
		    if(CPSERVICE_actualcp[i] != cpid){
			    SetPlayerCheckpoint(i,Checkpoints[cpid][cpX],Checkpoints[cpid][cpY],Checkpoints[cpid][cpZ],Checkpoints[cpid][cpsz]);
			    CPSERVICE_actualcp[i] = cpid;
			}
		} else {
		    if(CPSERVICE_actualcp[i] != 0){
			    CPSERVICE_actualcp[i] = 0;
			    DisablePlayerCheckpoint(i);
			}
		}
	}
	return 1;
}

stock CPSERVICE_getdist(playerid,Float:x2,Float:y2,Float:z2)
{
	new Float:x1,Float:y1,Float:z1;
	new Float:tmpdis;
	GetPlayerPos(playerid,x1,y1,z1);
	tmpdis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(tmpdis);
}









//////////////////////////////////////
/// Icon Control                   ///
///                                ///
///                                ///
///                                ///
///          Copyright by Rafelder ///
//////////////////////////////////////

#define MAX_ICONS 1000
#define MAX_SHOWED_MAPICONS 32 //Don't write more than 32!

new Float:XM[MAX_ICONS];
new Float:YM[MAX_ICONS];
new Float:ZM[MAX_ICONS];

new MarkerM[MAX_ICONS];
new ColorM[MAX_ICONS];

new IsValid[MAX_ICONS];
new Show[MAX_PLAYERS][MAX_ICONS];

new IconidM=-1;
new Set_Timer=0;
new Count=0;
new ShowedForPlayer[MAX_PLAYERS];
forward StreamTimer();


/*
native CreateMapIcon(markerid, color, Float:X, Float:Y, Float:Z);
native DestroyMapIcon(iconid);
native ResetMapIconVariables(playerid);

native IsValidMapIcon(iconid);
native IsIconActivatedForPlayer(playerid, iconid);
native IsIconActivatedForAll(iconid);

native SetMapIconPos(iconid, Float:X, Float:Y, Float:Z);
native SetMapIconIcon(iconid, markerid, color);
native SetMapIconColor(iconid, color);

native GetMapIconPos(iconid, &Float:X, &Float:Y, &Float:Z);
native GetMapIconIcon(iconid);
native GetMapIconColor(iconid);

native ShowMapIconForPlayer(playerid, iconid);
native ShowMapIconForAll(iconid);
native ShowAllMapIconForPlayer(playerid);
native ShowAllMapIconForAll();
native DisableMapIconForPlayer(playerid, iconid);
native DisableMapIconForAll(iconid);
native DisableAllMapIconForPlayer(playerid);
native DisableAllMapIconForAll();
*/

/***************************CREATE***************************/
stock CreateMapIcon(markerid, color, Float:X, Float:Y, Float:Z)
{
        if (Set_Timer == 0) {
        SetTimer("StreamTimer", 200, 1);
        Set_Timer=1;
        }

        if (IconidM >= MAX_ICONS) return 0;
        IconidM++;
        IsValid[IconidM]=1;
        XM[IconidM]=X;
        YM[IconidM]=Y;
        ZM[IconidM]=Z;
        MarkerM[IconidM]=markerid;
        ColorM[IconidM]=color;
        for(new i=0; i<MAX_PLAYERS; i++) {
        Show[i][IconidM]=1;
        }
        return IconidM;
}

stock DestroyMapIcon(iconid)
{
        IsValid[iconid]=0;
        XM[iconid]=0.0;
        YM[iconid]=0.0;
        ZM[iconid]=0.0;
        MarkerM[iconid]=0;
        ColorM[iconid]=0;
        for(new i=0; i<MAX_PLAYERS; i++)
        Show[i][iconid]=0;
        return 1;
}

stock ResetMapIconVariables(playerid)
{
        for(new i=0; i<MAX_ICONS; i++) {
        Show[playerid][i]=1;
        }
        return 1;
}
/*****************************IS*****************************/
stock IsValidMapIcon(iconid)
{
        if (IsValid[iconid] == 1) return 1;
        return 0;
}


stock IsIconActivatedForPlayer(playerid, iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        if (Show[playerid][iconid] == 1) return 1;
        return 0;
}

stock IsIconActivatedForAll(iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        for(new i=0; i<MAX_PLAYERS; i++) {
        if (Show[i][iconid] == 1) return 1;
        return 0;
        }
}

/*****************************DO*****************************/
stock SetMapIconPos(iconid, Float:X, Float:Y, Float:Z)
{
        if (!IsValidMapIcon(icondid)) return 0;
        XM[iconid]=X;
        YM[iconid]=Y;
        ZM[iconid]=Z;
        return 1;
}

stock SetMapIconIcon(iconid, markerid, color)
{
        if (!IsValidMapIcon(icondid)) return 0;
        MarkerM[iconid]=markerid;
        ColorM[iconid]=color;
        return 1;
}

stock SetMapIconColor(iconid, color)
{
        if (!IsValidMapIcon(icondid)) return 0;
        ColorM[iconid]=color;
        return 1;
}

stock ShowMapIconForPlayer(playerid, iconid)
{
        if (!IsValidMapIcon(iconid)) return 0;
        Show[playerid][iconid]=1;
        return 1;
}

stock ShowMapIconForAll(iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        for(new i=0; i<MAX_PLAYERS; i++)
        if (IsPlayerConnected(i))
        Show[i][iconid]=1;
        return 1;
}

stock ShowAllMapIconForPlayer(playerid)
{
        for(new m=0; m<MAX_ICONS; m++) {
        if (IsValidMapIcon(m))
        Show[playerid][m]=1;
        }
        return 1;
}

stock ShowAllMapIconForAll()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
        for(new m=0; m<MAX_ICONS; m++) {
        if (IsValidMapIcon(m))
        Show[i][m]=1;
        }
        }
        }
        return 1;
}

stock DisableMapIconForPlayer(playerid, iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        Show[playerid][iconid]=0;
        return 1;
}

stock DisableMapIconForAll(iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        for(new i=0; i<MAX_PLAYERS; i++)
        Show[i][iconid]=0;
        return 1;
}

stock DisableAllMapIconForPlayer(playerid)
{
        for(new m=0; m<MAX_ICONS; m++) {
        if (IsValidMapIcon(m))
        Show[playerid][m]=0;
        }
        return 1;
}

stock DisableAllMapIconForAll()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
        if (IsPlayerConnected(i)) {
        for(new m=0; m<MAX_ICONS; m++) {
        if (IsValidMapIcon(m))
        Show[i][m]=0;
        }
        }
        }
        return 1;
}
/****************************GET*****************************/
stock GetMapIconPos(iconid, &Float:X, &Float:Y, &Float:Z)
{
        if (!IsValidMapIcon(iconid)) return 0;
        X=XM[iconid];
        Y=YM[iconid];
        Z=ZM[iconid];
        return 1;
}

stock GetMapIconIcon(iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        return MarkerM[iconid];
}

stock GetMapIconColor(iconid)
{
        if (!IsValidMapIcon(icondid)) return 0;
        return ColorM[inconid];
}
/***************************TIMER*****************************/
public StreamTimer()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if (IsPlayerConnected(i)) {
                        ShowedForPlayer[i]=0;
                        for(new oldm=0; oldm<32; oldm++) {RemovePlayerMapIcon(i, oldm);}
                        Count=0;
                        for(new m=0; m<MAX_ICONS; m++) {
                                if (IsValidMapIcon(m)) {
                                        if (ShowedForPlayer[i] < MAX_SHOWED_MAPICONS) {
                                                if (Show[i][m] == 1) {
                                                        if (GetDistanceToMapIcon(i, m) <= 400) {
                                                                SetPlayerMapIcon(i, Count, XM[m], YM[m], ZM[m], MarkerM[m], ColorM[m]);
                                                                ShowedForPlayer[i]++;
                                                                Count++;
                                                        }

                                                }
                                        }
                                }
                        }
                }
        }
        return 1;
}
/**************************DISTANCE***************************/
stock GetDistanceToMapIcon(playerid, iconid)
{
        new Float:x1,Float:y1,Float:z1;
        new Float:x2,Float:y2,Float:z2;
        new Float:output;
        GetPlayerPos(playerid, x1, y1, z1);
        GetMapIconPos(iconid, x2, y2, z2);
        output = floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2)+floatpower(floatabs(floatsub(y2, y1)), 2));
        return floatround(output);
}










/*===========================================================*\
||                                     PropertyInclude Version 1.6.8                                               ||
||                                                                                                                                       ||
||============================================================||
||                          Created on the 31th of March 2008 by =>Sandra<=                     ||
||                                   PlayerToPoint-function by Sneaky!                                         ||
||                                    Do NOT remove any credits!!                                                 ||
\*===========================================================*/

#define MAX_PROPERTIES 250
#define MAX_DISTANCE_TO_PROPERTY 1.5

new UseTextDraw = 1;  //If '0', only gametext will appear when picking up a property-pickup, else if '1' a textdraw will appear.

#define COLOR_MENU 0xADFF2FAA //Green/Yellow
#define COLOR_MENUHEADER 0x7CFC00AA

enum propinfo
{
	PropIsEnabled,
	PropExists,
	PropName[60],
	PropPrice,
	PropSell,
	PropEarning,
	Float:PropX,
	Float:PropY,
	Float:PropZ,
	PropOwner,
	PropIsBought
}
new PropInfo[MAX_PROPERTIES][propinfo];
new PayoutTimer = -1;
new PropertyPayoutFrequency = 180;  //Propertyowners will get every 60 seconds money from their properties
new MAX_PROPERTIES_PER_PLAYER = 8;
new PropertyCount;
new PropertyIcon[MAX_PROPERTIES];
new PropertyPickup[MAX_PROPERTIES];
new PlayerPropertyCount[MAX_PLAYERS];
new PlayerEarnings[MAX_PLAYERS];
new Text:PropertyText1[MAX_PLAYERS];
new Text:PropertyText2[MAX_PLAYERS];
new IsTextdrawActive[MAX_PLAYERS];
new TextdrawTimer[MAX_PLAYERS];

/*
native AddProperty(const name[], Float:X, Float:Y, Float:Z, price, sell, earning);
native SellPropertyForPlayer(playerid);
native BuyPropertyForPlayer(playerid);
native GetPropertyInfo(propertyID, &Float:X, &Float:Y, &Float:Z, &Price, &SellValue, &Earning);
native GetPropertyName(propertyID);
native GetPropertyOwner(propertyID);
native GetPropertyStatus(propertyID);
native GetPlayerProperties(playerid);
native SetPayoutFrequency(seconds);
native SetMaxPropertiesPerPlayer(amount);
native ToggleProperty(propertyID, toggle);
native ResetPlayerPropertyInfo(playerid);
native LocatePropertyForPlayer(property, playerid);
native OnPropertyPickupPickup(playerid, pickupid);
native DestroyAllPropertyPickups();
native UsePropertyTextdraw(toggle);
native SetPropertyPrice(propertyID, price);
native SetPropertySellValue(propertyID, value);
native SetPropertyEarning(propertyID, earning);
native DoesPropertyExists(propertyID);
native IsPlayerNearProperty(playerid);
native SaveProperty(propertyID, const comment[]);
*/

stock AddProperty(const name[], Float:X, Float:Y, Float:Z, price, sell, earning)
{
    PropertyCount++;
	new ID = PropertyCount;
	if(!strlen(name))
	{
	    print("====================================================");
	    printf("Property Error: You forgot to give property #%d a name!", ID);
	    print("        This property will not be created           ");
	    print("====================================================");
	    return 1;
	}
	if(price < 0)
	{
	    print("=============================================================");
	    print("Property Error: You cant give a property a price lower than 0");
	    printf("           Property #%d will not be created                 ", ID);
	    print("=============================================================");
	    return 1;
	}
	if(sell < 0)
	{
	    print("===============================================================");
	    print("Property Error: You cant give players less than $0 when selling");
	    printf("           Property #%d will not be created                   ", ID);
	    print("===============================================================");
	    return 1;
	}
	if(!strlen(name))
	{
	    print("==================================================================");
	    print("Property Error: You can't give a property an earning lower than 0");
	    printf("               Property #%d will not be created                  ", ID);
	    print("==================================================================");
	    return 1;
	}

	if(PayoutTimer == -1)
	{
	    PayoutTimer = SetTimer("PropertyPayout", (PropertyPayoutFrequency*1000), 1);
	    for(new i=1; i<MAX_PROPERTIES; i++)
	    {
	        PropInfo[i][PropOwner] = -1;
		}
	}
	PropInfo[ID][PropExists] = 1;
	PropInfo[ID][PropIsEnabled] = 1;
	format(PropInfo[ID][PropName], 60, "%s", name);
	PropInfo[ID][PropX] = X;
	PropInfo[ID][PropY] = Y;
	PropInfo[ID][PropZ] = Z;
	PropInfo[ID][PropPrice] = price;
	PropInfo[ID][PropSell] = sell;
	PropInfo[ID][PropEarning] = earning;
	PropInfo[ID][PropOwner] = -1;
	PropertyPickup[ID] = CreatePickup(1274, 1, X, Y, Z);
	PropertyIcon[ID] = CreateMapIcon(52, 0, X, Y, Z);
	return ID;
}




stock SetPayoutFrequency(seconds)
{
	KillTimer(PayoutTimer);
	PropertyPayoutFrequency = seconds;
	PayoutTimer = SetTimer("PropertyPayout", (PropertyPayoutFrequency*1000), 1);
}
stock SetMaxPropertiesPerPlayer(amount)
{
	MAX_PROPERTIES_PER_PLAYER = amount;
}

stock GetPlayerProperties(playerid)
{
	new propid;
	SendClientMessage(playerid, COLOR_MENUHEADER, "=====================================");
	if(PlayerPropertyCount[playerid] > 0)
	{
		new str[128];
		SendClientMessage(playerid, COLOR_MENUHEADER, "Your Properties:");
		for(new ID = 1; ID<MAX_PROPERTIES; ID++)
		{
			if(PropInfo[ID][PropIsBought] == 1)
			{
				if(PropInfo[ID][PropOwner] == playerid)
				{
					format(str,128, "** \"%s\" (ID: %d) **  Price: $%d  **  SellValue: $%d  **  Earnings: $%d", PropInfo[ID][PropName], ID, PropInfo[ID][PropPrice], PropInfo[ID][PropSell], PropInfo[ID][PropEarning]);
					SendClientMessage(playerid, COLOR_MENU, str);
				}
			}
		}
		SendClientMessage(playerid, COLOR_MENU, "------------------------------");
		format(str, 128, "Total Earnings: $%d", PlayerEarnings[playerid]);
		SendClientMessage(playerid, COLOR_MENU, str);
	}
	else
	{
		SendClientMessage(playerid, COLOR_MENU, "You don't own properties");
	}
	SendClientMessage(playerid, COLOR_MENUHEADER, "=====================================");

	for(new ID = 1; ID<MAX_PROPERTIES; ID++)
	{
		if(PropInfo[ID][PropIsBought] == 1)
		{
			if(PropInfo[ID][PropOwner] == playerid)
			{
				ID = propid;
			}
		}
	}

	return propid;
}

stock IsPropertyBought(propertyID)
{
	if(PropInfo[propertyID][PropIsBought] == 1) return 1; else return 0;

}


stock BuyPropertyForPlayer(playerid)
{
	new str[128];
	new maxP = MAX_PROPERTIES_PER_PLAYER;
	if(PlayerPropertyCount[playerid] == maxP)
	{
	    if(maxP == 1)
	    {
	    	format(str, 128, "You already have 1 property, you have to sell your other property before you can buy this one");
	    	SendClientMessage(playerid, 0xFF0000AA, str);
		}
		else
		{
		    format(str, 128, "You already have %d properties, you have to sell one of your other properties before you can buy this one", PlayerPropertyCount[playerid]);
	        SendClientMessage(playerid, 0xFF0000AA, str);
		}
		return 1;
	}
	new ID = IsPlayerNearProperty(playerid);
	if(ID == -1)
	{
	    SendClientMessage(playerid, 0xFF0000AA, "You are not close enough to a property!");
	    return 1;
	}
	if(PropInfo[ID][PropIsEnabled] == 0) return SendClientMessage(playerid, 0xFF0000AA, "Sorry, this property is currently disabled!");
	if(PropInfo[ID][PropIsBought] == 1)
	{
	    new oName[MAX_PLAYER_NAME];
	    GetPlayerName(PropInfo[ID][PropOwner], oName, MAX_PLAYER_NAME);
	    format(str, 128, "This property is currently owned by %s (ID: %d)", oName, PropInfo[ID][PropOwner]);
		SendClientMessage(playerid, 0xFF0000AA, str);
	    return 1;
	}
	if(PropInfo[ID][PropOwner] == playerid)
	{
		SendClientMessage(playerid, 0xFF0000AA, "You already own this property!");
	    return 1;
	}
	if(PropInfo[ID][PropPrice] > GetPlayerMoney(playerid))
	{
		format(str, 128, "You don't have enough money to buy this property, you need $%d", PropInfo[ID][PropPrice]);
	    SendClientMessage(playerid, 0xFF0000AA, str);
	    return 1;
	}
	GivePlayerMoney(playerid, -PropInfo[ID][PropPrice]);
	PlayerEarnings[playerid] += PropInfo[ID][PropEarning];
	PlayerPropertyCount[playerid]++;
	PropInfo[ID][PropOwner] = playerid;
	PropInfo[ID][PropIsBought] = 1;
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	format(str, 128, "%s has bought property \"%s\" (ID: %d) for $%d", pName, PropInfo[ID][PropName], ID, PropInfo[ID][PropPrice]);
	SendClientMessageToAll(0x00FFFFAA, str);
	format(str, 128, "You will earn now $%d every %d seconds!", PlayerEarnings[playerid], PropertyPayoutFrequency);
	SendClientMessageToAll(0x00FFFFAA, str);
	return 1;
}

stock SellPropertyForPlayer(playerid)
{
	new str[128];
	new ID = IsPlayerNearProperty(playerid);
	if(ID == -1)
	{
	    SendClientMessage(playerid, 0xFF0000AA, "You are not close enough to a property!");
	    return 1;
	}
	if(PropInfo[ID][PropOwner] != playerid)
	{
		SendClientMessage(playerid, 0xFF0000AA, "You don't own this property!");
	    return 1;
	}

    GivePlayerMoney(playerid, PropInfo[ID][PropSell]);
    PlayerPropertyCount[playerid]--;
    PlayerEarnings[playerid] -= PropInfo[ID][PropEarning];
	PropInfo[ID][PropOwner] = -1;
	PropInfo[ID][PropIsBought] = 0;
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	format(str, 128, "%s has sold property \"%s\"  (ID: %d) for $%d", pName, PropInfo[ID][PropName], ID, PropInfo[ID][PropSell]);
	SendClientMessageToAll(0x00FFFFAA, str);
	return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	tempposx = (oldposx -x);
	tempposy = (oldposy -y);
	tempposz = (oldposz -z);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

stock SetPropertieOwner(propertyID, playerid)
{
	PropInfo[propertyID][PropOwner] = playerid;
}


stock ResetPlayerPropertyInfo(playerid)
{
    for(new ID; ID<MAX_PROPERTIES; ID++)
	{
		if(PropInfo[ID][PropIsBought] == 1 && PropInfo[ID][PropOwner] == playerid)
		{
		    PropInfo[ID][PropIsBought] = 0;
		    PropInfo[ID][PropOwner] = -1;
		}
	}
	PlayerPropertyCount[playerid] = 0;
	PlayerEarnings[playerid] = 0;
	if(IsTextdrawActive[playerid] == 1)
	{
	    TextDrawDestroy(PropertyText1[playerid]);
	    TextDrawDestroy(PropertyText2[playerid]);
	    KillTimer(TextdrawTimer[playerid]);
	}
	IsTextdrawActive[playerid] = 0;
	return 1;
}

stock IsPlayerNearProperty(playerid)
{
	for(new i=1; i<MAX_PROPERTIES; i++)
	{
	    if(PlayerToPoint(MAX_DISTANCE_TO_PROPERTY, playerid, PropInfo[i][PropX], PropInfo[i][PropY], PropInfo[i][PropZ]))
	    {
	        return i;
		}
	}
	return -1;
}

forward PropertyPayout();
public PropertyPayout()
{
	for(new i; i<MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
		    if(PlayerEarnings[i] > 0)
		    {
		        GivePlayerMoney(i, PlayerEarnings[i]);
				new str[128];
				format(str, 128, "You received $%d from your properties", PlayerEarnings[i]);
				SendClientMessage(i, 0xFFFF00AA, str);
			}
		}
	}
}

stock LocatePropertyForPlayer(propertyID, playerid)
{
	 PropInfo[ID][ = propertyID;
	if(PropInfo[ID][PropExists] == 0) return SendClientMessage(playerid, 0xFF0000AA, "This property does not exists!");
	SetPlayerCheckpoint(playerid, PropInfo[ID][PropX], PropInfo[ID][PropY], PropInfo[ID][PropZ], 3);
	SendClientMessage(playerid, 0xFFFF00, "The property is now indicated on the radar!");
	return 1;
}

stock GetPropertyInfo(propertyID, &Float:X, &Float:Y, &Float:Z, &Price, &SellValue, &Earning)
{
	X = PropInfo[propertyID][PropX];
	Y = PropInfo[propertyID][PropY];
	Z = PropInfo[propertyID][PropZ];
	Price = PropInfo[propertyID][PropPrice];
	SellValue = PropInfo[propertyID][PropSell];
	Earning = PropInfo[propertyID][PropEarning];
}

stock GetPropertyName(propertyID)
{
	new PropertyName[64];
	format(PropertyName, 64, "%s", PropInfo[propertyID][PropName]);
	return PropertyName;
}
stock GetPropertyOwner(propertyID)
{
	new PropertyOwner[MAX_PLAYER_NAME];
	if(PropInfo[propertyID][PropIsBought] == 1)
	{
		new oName[MAX_PLAYER_NAME];
		GetPlayerName(PropInfo[propertyID][PropOwner], oName, sizeof(oName));
		format(PropertyOwner, MAX_PLAYER_NAME, "%s", oName);
	}
	else
	{
	    format(PropertyOwner, MAX_PLAYER_NAME, "Nobody");
	}
	return PropertyOwner;
}

stock GetPropertyStatus(propertyID)
{
	new PropertyStatus[10];
	if(PropInfo[propertyID][PropIsEnabled] == 1)
	{
		format(PropertyStatus, 10,"Enabled");
	}
	else
	{
	    format(PropertyStatus, 10, "Disabled");
	}
	return PropertyStatus;
}

stock ToggleProperty(propertyID, toggle)
{
	if(toggle == 1)
	{
	    if(PropInfo[propertyID][PropIsEnabled] == 0)
	    {
			PropInfo[propertyID][PropIsEnabled] = 1;
		}
	}
	else if(toggle == 0)
	{
	    if(PropInfo[propertyID][PropIsEnabled] == 1)
	    {
			PropInfo[propertyID][PropIsEnabled] = 0;
		}
	}
}

stock DestroyAllPropertyPickups()
{
	for(new ID=1; ID<MAX_PROPERTIES; ID++)
	{
		DestroyPickup(PropertyPickup[ID]);
	}
}

stock UsePropertyTextDraw(toggle)
{
	if(toggle < 0 || toggle > 1) return 0;
	UseTextDraw = toggle;
	return 1;
}
stock SetPropertyPrice(propertyID, price)
{
	if(PropInfo[propertyID][PropExists] == 0) return 0;
	PropInfo[propertyID][PropPrice] = price;
	return 1;
}

stock SetPropertySellValue(propertyID, value)
{
    if(PropInfo[propertyID][PropExists] == 0) return 0;
	PropInfo[propertyID][PropSell] = value;
	return 1;
}

stock SetPropertyEarning(propertyID, earning)
{
    if(PropInfo[propertyID][PropExists] == 0) return 0;
	if(PropInfo[propertyID][PropIsBought] == 1)
	{
        PlayerEarnings[PropInfo[propertyID][PropOwner]] -= PropInfo[propertyID][PropEarning];
        PlayerEarnings[PropInfo[propertyID][PropOwner]] += earning;
	}
	PropInfo[propertyID][PropEarning] = earning;

	return 1;
}

stock DoesPropertyExists(propertyID)
{
	if(PropInfo[propertyID][PropExists] == 1)
	{
		return 1;
	}
	return 0;
}

stock SaveProperty(propertyID, const comment[])
{
    if(PropInfo[propertyID][PropExists] == 0) return 0;
	new ID = propertyID;
    new File:hFile;
	if(!fexist("SavedProperties.txt"))
	{
		hFile=fopen("SavedProperties.txt",io_write);
		fclose(hFile);
		print("File 'SavedProperties.txt' created succesfully!");
	}
	new Float:X = PropInfo[ID][PropX];
	new Float:Y = PropInfo[ID][PropY];
	new Float:Z = PropInfo[ID][PropZ];
	new Price = PropInfo[ID][PropPrice];
	new Value = PropInfo[ID][PropSell];
	new Earning = PropInfo[ID][PropEarning];
    new entry[128], entry2[128];
	format(entry, 128, "AddProperty(\"%s\", %.2f, %.2f, %.2f, %d, %d, %d); // %s", PropInfo[ID][PropName], X, Y, Z, Price, Value, Earning, comment);
	format(entry2, 128, "\r\n%s",entry);
	hFile = fopen("SavedProperties.txt", io_append);
	fwrite(hFile, entry2);
	fclose(hFile);
	return 1;
}

stock OnPropertyPickupPickup(playerid, pickupid)
{
 	new ID = -1;
	for(new i=1; i<MAX_PROPERTIES; i++)
	{
	    if(pickupid == PropertyPickup[i])
	    {
	        ID = i;
			break;
		}
	}
	if(ID != -1)
	{
	    if(UseTextDraw == 1)
	    {
		    if(IsTextdrawActive[playerid] == 1)
			{
			    TextDrawDestroy(PropertyText1[playerid]);
			    TextDrawDestroy(PropertyText2[playerid]);
			    KillTimer(TextdrawTimer[playerid]);
			}
		}
	    new str[128], str2[128], str3[256];
	    if(PropInfo[ID][PropIsBought] == 0)
	    {
	        if(UseTextDraw == 1)
			{
	       		format(str2, sizeof(str2), "~r~Earning every %d seconds: ~w~$%d ~n~~r~Owner: ~w~Nobody~n~~r~Status: ~w~%s", PropertyPayoutFrequency, PropInfo[ID][PropEarning], GetPropertyStatus(ID));
			}
			else
			{
			    format(str2, sizeof(str2), "~r~Earning: ~w~$%d ~n~~r~Owner: ~w~Nobody", PropInfo[ID][PropEarning]);
			}
		}
		else
		{
		    if(UseTextDraw == 1)
			{
	          	new oName[MAX_PLAYER_NAME];
			    GetPlayerName(PropInfo[ID][PropOwner], oName, MAX_PLAYER_NAME);
			    format(str2, 128, "~r~Earning every %d seconds: ~w~$%d ~n~~r~Owner: ~w~%s~n~~r~Status: ~w~%s", PropertyPayoutFrequency, PropInfo[ID][PropEarning], oName, GetPropertyStatus(ID));
			}
			else
			{
	          	new oName[MAX_PLAYER_NAME];
			    GetPlayerName(PropInfo[ID][PropOwner], oName, MAX_PLAYER_NAME);
			    format(str2, 128, "~r~Earning: ~w~$%d ~n~~r~Owner: ~w~%s", PropInfo[ID][PropEarning], oName);
			}

		}
	    format(str, 128, "~w~\"%s\"~n~~r~Price: ~w~$%d ~n~~r~SellValue: ~w~$%d", PropInfo[ID][PropName],PropInfo[ID][PropPrice], PropInfo[ID][PropSell]);
		if(UseTextDraw == 1)
		{
			PropertyText1[playerid] = TextDrawCreate(10,150,str);
			PropertyText2[playerid] = TextDrawCreate(10,185,str2);
	 		TextDrawLetterSize(PropertyText1[playerid] , 0.4, 1.30);
	 		TextDrawLetterSize(PropertyText2[playerid] , 0.4, 1.30);
	 		TextDrawShowForPlayer(playerid,PropertyText1[playerid]);
		 	TextDrawShowForPlayer(playerid,PropertyText2[playerid]);
	 		IsTextdrawActive[playerid] = 1;
	 		TextdrawTimer[playerid] = SetTimerEx("DestroyTextdraw",10000,false,"i",playerid);
		}
		else
		{
		    format(str3, 256, "%s~n~%s", str, str2);
		    GameTextForPlayer(playerid, str3, 10000, 3);
		}
	}
}

forward DestroyTextdraw(playerid);
public DestroyTextdraw(playerid)
{
    if(UseTextDraw == 1)
	{
		TextDrawDestroy(PropertyText1[playerid]);
		TextDrawDestroy(PropertyText2[playerid]);
		IsTextdrawActive[playerid] = 0;
	}
}

stock GPO(propertyID)
{
	return PropInfo[propertyID][PropOwner];
}



/*--------------------------------------\
|					|
|	     SimpleFiles.inc    	|
|     					|
|  -Creator: Rafelder			|
|  -Credits to me and the creators of	|
|	 	encode, decode and hash	|
|  -Version: 1.0			|
|  -Date: 1st March 2008		|
|  -Require: dini, dutils		|
|					|
|					|
|             (c) Copyright by Rafelder |
\--------------------------------------*/

#if defined _SimpleFiles_included
  #endinput
#endif

#define _SimpleFiles_included

#include <dini>
#include <dutils>

/*
native FileCreate(filename[]);
native FileDelete(filename[]);
native FileExists(filename[])
native FilePasswordCreate(filename[], password[]);

native IsRightPassword(filename[], password[])
native ChangePassword(filename[], newpassword[]);

native SaveFileString(filename[], key[], stringx[]);
native SaveFileInteger(filename[], key[], integer);
native SaveFileFloat(filename[], key[], Float:float);

native GetFileString(filename[], key[]);
native GetFileInteger(filename[], key[]);
native Float:GetFileFloat(filename[], key[]);

native IsRightPassword(filename[], password[])
native ChangePassword(filename[], newpassword[]);
native EditFileName(filename[], newname[]);
*/

stock IsRightPassword(filename[], password[])
{
	if(!FileExists(filename)) return false;
	new pstring[MAX_STRING];
	format(pstring, sizeof(pstring),"%s.txt", NameEncode(filename));
  	if (GetFileInteger(filename, "password_hash") == f_hash(password)) return true;
  	return false;
}

stock ChangePassword(filename[], newpassword[])
{
	if(!FileExists(filename)) return false;
	SaveFileInteger(filename, "password_hash", f_hash(newpassword));
	return 1;
}

stock FilePasswordCreate(filename[], password[])
{
	if(FileExists(filename)) return false;
	new File:afile, filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	if (fexist(filen)) return false;
	afile=fopen(filen, io_write);
	fclose(afile);
	SaveFileInteger(filename, "password_hash", f_hash(password));
	return true;
}

stock FileCreate(filename[])
{
	if(FileExists(filename)) return false;
	new File:afile, filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	if (fexist(filen)) return false;
	afile=fopen(filen, io_write);
	fclose(afile);
	return true;
}

stock FileDelete(filename[])
{
	if(!FileExists(filename)) return false;
	new filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	if (!fexist(filen)) return false;
	fremove(filen);
	return true;
}

stock FileExists(filename[])
{
	new filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	if (fexist(filen)) return true;
	return false;
}

stock SaveFileString(filename[], key[], stringx[])
{
	if(!FileExists(filename)) return false;
	new filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	return dini_Set(filen, key, stringx);
}

stock SaveFileInteger(filename[], key[], integer)
{
	if(!FileExists(filename)) return false;
	new filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	return dini_IntSet(filen, key, integer);
}

stock SaveFileFloat(filename[], key[], Float:float)
{
	if(!FileExists(filename)) return false;
	new filen[MAX_STRING];
	format(filen, sizeof(filen), "%s.txt", NameEncode(filename));
	return dini_FloatSet(filen, key, float);
}

stock GetFileString(filename[], key[])
{
	new fstring[MAX_STRING];
	fstring[0]=0;
	if(!FileExists(filename)) return fstring;
  	format(fstring, sizeof(fstring), "%s.txt", NameEncode(filename));
  	format(fstring, sizeof(fstring), dini_Get(fstring, key));
  	return fstring;
}

stock GetFileInteger(filename[], key[])
{
	if(!FileExists(filename)) return false;
	new fstring[MAX_STRING];
  	format(fstring, sizeof(fstring), "%s.txt", NameEncode(filename));
  	return dini_Int(fstring, key);
}

stock Float:GetFileFloat(filename[], key[])
{
	new Float:wfloat;
	wfloat=0.0;
	if(!FileExists(filename)) return wfloat;
	new fstring[MAX_STRING];
  	format(fstring, sizeof(fstring), "%s.txt", NameEncode(filename));
  	return dini_Float(fstring, key);

}


stock EditFileName(filename[], newname[])
{
	if(!FileExists(filename)) return false;
  	new oldfname[MAX_STRING], newfname[MAX_STRING];
  	format(oldfname, sizeof(oldfname), "%s.txt", NameEncode(filename));
  	format(newfname, sizeof(newfname), "%s.txt", NameEncode(newname));
  	return frenametextfile(oldfname, newfname);
}

stock f_hash(buf[])//Wikipage
{
	new length=strlen(buf);
	new s1 = 1;
	new s2 = 0;
	new n;
	for (n=0; n<length; n++)
	{
		s1 = (s1 + buf[n]) % 65521;
		s2 = (s2 + s1)     % 65521;
	}
	return (s2 << 16) + s1;
}

stock NameEncode(filename[])//From dudb file
{
  	new tmp[MAX_STRING];
  	set(tmp, filename);
  	tmp=strreplace("_","_00",tmp);
  	tmp=strreplace(";","_01",tmp);
  	tmp=strreplace("!","_02",tmp);
  	tmp=strreplace("/","_03",tmp);
  	tmp=strreplace("\\","_04",tmp);
  	tmp=strreplace("[","_05",tmp);
  	tmp=strreplace("]","_06",tmp);
  	tmp=strreplace("?","_07",tmp);
  	tmp=strreplace(".","_08",tmp);
  	tmp=strreplace("*","_09",tmp);
  	tmp=strreplace("<","_10",tmp);
  	tmp=strreplace(">","_11",tmp);
  	tmp=strreplace("{","_12",tmp);
  	tmp=strreplace("}","_13",tmp);
  	tmp=strreplace(" ","_14",tmp);
  	tmp=strreplace("\"","_15",tmp);
  	tmp=strreplace(":","_16",tmp);
  	tmp=strreplace("|","_17",tmp);
  	tmp=strreplace("=","_18",tmp);
  	return tmp;
}

stock NameDecode(filename[])//From dudb file
{
  	new tmp[MAX_STRING];
  	set(tmp, filename);
  	tmp=strreplace("_01",";",tmp);
  	tmp=strreplace("_02","!",tmp);
  	tmp=strreplace("_03","/",tmp);
  	tmp=strreplace("_04","\\",tmp);
  	tmp=strreplace("_05","[",tmp);
  	tmp=strreplace("_06","]",tmp);
  	tmp=strreplace("_07","?",tmp);
  	tmp=strreplace("_08",".",tmp);
  	tmp=strreplace("_09","*",tmp);
  	tmp=strreplace("_10","<",tmp);
  	tmp=strreplace("_11",">",tmp);
  	tmp=strreplace("_12","{",tmp);
  	tmp=strreplace("_13","}",tmp);
  	tmp=strreplace("_14"," ",tmp);
  	tmp=strreplace("_15","\"",tmp);
  	tmp=strreplace("_16",":",tmp);
  	tmp=strreplace("_17","|",tmp);
  	tmp=strreplace("_18","=",tmp);
  	tmp=strreplace("_00","_",tmp);
  	return tmp;
}

