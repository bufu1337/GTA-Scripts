//----------------------------------//
//--- Navigation System Beta 0.1 ---//
//--- Beta 0.1 ---- June 1, 2008 ---//
//------- ©2008 Michelle1991 -------//
//----------------------------------//


#include <a_samp>

#define COLOR_ORANGE 0xFF9900FF

new Menu:Navigation;
new Menu:LosSantos;
new Menu:SanFiero;
new Menu:LasVenturas;

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" -- Navigation System by Michelle1991 --");
	print("--------------------------------------\n");
	return 1;
}
//==============================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
if(strcmp(cmdtext, "/navigation", true) == 0)
	{
	ShowMenuForPlayer(Navigation, playerid);
	return 1;
	}
return 0;
}
//==============================================================================
public OnGameModeInit()
{
    Navigation = CreateMenu("Navigation", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(Navigation, 0, "Navigation");
	AddMenuItem(Navigation, 0, "Los Santos");
	AddMenuItem(Navigation, 0, "San Fiero");
	AddMenuItem(Navigation, 0, "Las Venturas");
//==============================================================================
    LosSantos = CreateMenu("Los Santos", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(LosSantos, 0, "Los Santos");
    AddMenuItem(LosSantos, 0, "Tobi Tower");
    AddMenuItem(LosSantos, 0, "Grove Street");
    AddMenuItem(LosSantos, 0, "Police");
    AddMenuItem(LosSantos, 0, "Vinewood");
    AddMenuItem(LosSantos, 0, "Skatepark");
	AddMenuItem(LosSantos, 0, "Loco Low");
    AddMenuItem(LosSantos, 0, "Airport");
    AddMenuItem(LosSantos, 0, "Exit Menu");
//==============================================================================
    SanFiero = CreateMenu("San Fiero", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(SanFiero, 0, "San Fiero");
    AddMenuItem(SanFiero, 0, "Wheel Arch Angels");
    AddMenuItem(SanFiero, 0, "Wang Cars");
    AddMenuItem(SanFiero, 0, "Mount Chiliad");
    AddMenuItem(SanFiero, 0, "Airport");
    AddMenuItem(SanFiero, 0, "Exit Menu");
//==============================================================================
    LasVenturas = CreateMenu("Las Venturas", 1, 50.0, 180.0, 200.0, 200.0);
    SetMenuColumnHeader(LasVenturas, 0, "Las Venturas");
    AddMenuItem(LasVenturas, 0, "Caligulas");
    AddMenuItem(LasVenturas, 0, "4 Dragons");
    AddMenuItem(LasVenturas, 0, "Come-A-Lot");
    AddMenuItem(LasVenturas, 0, "Emerald Isle");
    AddMenuItem(LasVenturas, 0, "Police");
    AddMenuItem(LasVenturas, 0, "Transfender");
    AddMenuItem(LasVenturas, 0, "Airport");
    AddMenuItem(LasVenturas, 0, "Exit Menu");
}
//==============================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:current;
    current = GetPlayerMenu(playerid);
    if(current == Navigation)
    {
        switch(row)
        {
            case 0:
			{
                HideMenuForPlayer(Navigation, playerid);
                ShowMenuForPlayer(LosSantos, playerid);
            }
            case 1:
			{
                HideMenuForPlayer(Navigation, playerid);
                ShowMenuForPlayer(SanFiero, playerid);
            }
            case 2:
			{
                HideMenuForPlayer(Navigation, playerid);
                ShowMenuForPlayer(LasVenturas, playerid);
            }
        }
    }
//==============================================================================
	if(current == LosSantos)
    {
        switch(row)
        {
            case 0://Tobi Tower
			{
	    	SetPlayerCheckpoint(playerid,1593.7095,-1314.1335,17.4642,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Tobi Tower.");
			}
            case 1://Grove Street
			{
	    	SetPlayerCheckpoint(playerid,2489.3713,-1667.2455,13.3438,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Grove Street.");
			}
            case 2://Police
			{
	    	SetPlayerCheckpoint(playerid,1533.7186,-1675.6587,13.3828,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Police Station.");
			}
            case 3://Vinewood
			{
	    	SetPlayerCheckpoint(playerid,1241.5826,-734.7064,95.3242,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Vinewood Hills.");
			}
            case 4://skatepark
			{
	    	SetPlayerCheckpoint(playerid,1872.9727,-1383.0305,13.5389,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the SkatePark.");
			}
            case 5://Loco Low
			{
	    	SetPlayerCheckpoint(playerid,2650.6650,-2004.5100,13.3828,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Loco Low Tuning Shop.");
			}
            case 6://Airport
			{
	    	SetPlayerCheckpoint(playerid,1861.3965,-2542.6294,13.5469,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Airport.");
			}
			case 7://Exit Menu
			{
	    	HideMenuForPlayer(LosSantos, playerid);
			}
        }
    }
//==============================================================================
    if(current == SanFiero)
    {
        switch(row)
        {
            case 0://Wheel Arch Angels
			{
	    	SetPlayerCheckpoint(playerid,-2700.2375,217.3544,4.1797,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Wheel Arch Angels Tuning Shop.");
			}
            case 1://Wang Cars
			{
	    	SetPlayerCheckpoint(playerid,-1987.9504,286.5176,34.3342,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Wang Cars Car Shop.");
			}
            case 2://Mount Chiliad
			{
	    	SetPlayerCheckpoint(playerid,-2388.4858,-2203.0935,33.2891,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Mount Chiliad.");
			}
            case 3://Airport
			{
	    	SetPlayerCheckpoint(playerid,-1653.3717,-160.6955,14.1484,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Airport.");
			}
			case 4://Exit Menu
			{
	    	HideMenuForPlayer(SanFiero, playerid);
		    }
        }
    }
//==============================================================================
    if(current == LasVenturas)
    {
        switch(row)
        {
            case 0://Caligulas
			{
	    	SetPlayerCheckpoint(playerid,2157.4944,1681.5742,10.6953,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Caligulas Casino.");
			}
            case 1://4 Dragons
			{
	    	SetPlayerCheckpoint(playerid,2036.6437,1008.2858,10.8203,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the 4 Dragons Casino.");
			}
            case 2://Come-A-Lot
			{
	    	SetPlayerCheckpoint(playerid,2168.0264,1123.3247,12.5949,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Come-A-Lot Hotel.");
			}
            case 3://Emerald Isle
			{
	    	SetPlayerCheckpoint(playerid,2124.5376,2351.5847,10.6719,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Emerald Isle Hotel.");
			}
            case 4://Police
			{
	    	SetPlayerCheckpoint(playerid,2286.4819,2417.3604,10.7066,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Police Station.");
			}
            case 5://Transfender
			{
	    	SetPlayerCheckpoint(playerid,2386.8870,1026.9823,10.8203,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Transfender Tuning Shop.");
			}
            case 6://Airport
			{
	    	SetPlayerCheckpoint(playerid,1430.0493,1463.0599,10.8203,5.0);
			SendClientMessage(playerid, COLOR_ORANGE, "The Red Marker is at the Airport.");
			}
			case 7://Exit Menu
			{
	    	HideMenuForPlayer(LasVenturas, playerid);
			}
        }
    }
    return 1;
}
