/*===========================================================*\
||                                     PropertyInclude Version 1.6.8                                               ||
||                                                                                                                                       ||
||============================================================||
||                          Created on the 31th of March 2008 by =>Sandra<=                     ||
||                                   PlayerToPoint-function by Sneaky!                                         ||
||                                    Do NOT remove any credits!!                                                 ||
\*===========================================================*/

#include <a_samp>

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
new PropertyPayoutFrequency = 60;  //Propertyowners will get every 60 seconds money from their properties
new MAX_PROPERTIES_PER_PLAYER = 3;
new PropertyCount;
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
	PropertyPickup[ID] = CreatePickup(1273, 1, X, Y, Z);
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
	new ID = propertyID;
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
