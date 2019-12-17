#include <a_samp>
#include <zcmd>

#define		COLOR_WHITE		0xFFFFFFFF
#define     PLAYERS         50 // Change.

new Text:Nanosuit[PLAYERS][4];
new Text:NanosuitTD[32][2];

new msg[128];

new RecoverEnergyTimer[MAX_PLAYERS];
new WasteEnergyTimer[MAX_PLAYERS];

#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
	
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
	
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))


forward ResetNanoStr(playerid);
public ResetNanoStr(playerid)
{
	SetPVarInt(playerid, "NanoStr",1);
	SetPlayerHealth(playerid, GetPVarFloat(playerid,"PreHealth"));

	if(GetPVarInt(playerid, "NanoSpeed") == 0)
	{
		TextDrawBoxColor(Nanosuit[playerid][1], 0x008080AA);
		HideNanoSuitText(playerid);
		ShowNanoSuitText(playerid);
	}
	else if(GetPVarInt(playerid, "NanoSpeed") == 1)
    {
        ApplyAnimation(playerid, "PED","sprint_civi",4.5,1,1,1,1,1,1);
        SetPVarInt(playerid, "NanoSpeed",1);
        KillTimer(RecoverEnergyTimer[playerid]);
	    KillTimer(WasteEnergyTimer[playerid]);
	    TextDrawBoxColor(Nanosuit[playerid][1], 0x00DDDDAA);
        HideNanoSuitText(playerid);
	    ShowNanoSuitText(playerid);

        if(GetPVarInt(playerid,"StealthMode") == 0 && GetPVarInt(playerid,"NanoShield") == 0)
        {
	        WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
		}
		else if(GetPVarInt(playerid, "StealthMode") == 1)
		{
		    WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",166,true,"i",playerid);
		}
		else if(GetPVarInt(playerid, "NanoShield") == 1)
		{
		    WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
		    RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",500,true,"i",playerid);
		}
	}
	return 1;
}

public OnFilterScriptInit()
{
	print("--------------------------------------");
	print("Nanosuit 2.0 by CuervO / Louis Keyl");
	print("--------------------------------------");
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < PLAYERS; i ++)
	    if(IsPlayerConnected(i))
	        OnPlayerDisconnect(i, 1);

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(GetPVarInt(playerid,"Nanosuit") == 1)
	{
	    KillTimer(RecoverEnergyTimer[playerid]);
		KillTimer(WasteEnergyTimer[playerid]);
	    DisableNanoSuit(playerid);
    	DestroyNanoSuitTexts(playerid);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    if(GetPVarInt(playerid, "Nanosuit") == 1)
	{
	    SetPlayerSkin(playerid,285);
	    SetPlayerArmour(playerid, 100);
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
    if(GetPVarInt(playerid, "Nanosuit") == 1)
	{
     	if(PRESSED(KEY_WALK))
		{

		    if(GetPVarInt(playerid,"PressedAlt") == 0)
		    {
		        SetPVarInt(playerid, "PressedAlt",1);
		        SetTimerEx("ResetKey",300,false,"ii",playerid,2);
		        return 1;
			}

			if(GetPVarInt(playerid,"PressedAlt") == 1)
			{
			    if(GetPVarInt(playerid, "SelectedRow") == 3 || GetPVarInt(playerid, "SelectedRow") == 0) // Up - Shield
			    {
			        SetPVarInt(playerid, "SelectedRow", 1);
			        SetPVarInt(playerid, "Switched",1);
			        TextDrawBoxColor(Nanosuit[playerid][0], 0x00DDDDAA);
			        TextDrawBoxColor(Nanosuit[playerid][2], 0x008080AA);
			        TextDrawBoxColor(Nanosuit[playerid][3], 0x008080AA);
			        HideNanoSuitText(playerid);
			        ShowNanoSuitText(playerid);
			    }
			    else if(GetPVarInt(playerid, "SelectedRow") == 1) // Down - Stealth
			    {
			        SetPVarInt(playerid, "SelectedRow", 2);
			        SetPVarInt(playerid, "Switched",1);
			        TextDrawBoxColor(Nanosuit[playerid][0], 0x008080AA);
			        TextDrawBoxColor(Nanosuit[playerid][2], 0x00DDDDAA);
			        TextDrawBoxColor(Nanosuit[playerid][3], 0x008080AA);
			        HideNanoSuitText(playerid);
				    ShowNanoSuitText(playerid);
			    }
			    else if(GetPVarInt(playerid, "SelectedRow") == 2) // None
			    {
			        SetPVarInt(playerid, "SelectedRow", 3);
			        SetPVarInt(playerid, "Switched",1);
			        TextDrawBoxColor(Nanosuit[playerid][0], 0x008080AA);
			        TextDrawBoxColor(Nanosuit[playerid][2], 0x008080AA);
			        TextDrawBoxColor(Nanosuit[playerid][3], 0x00DDDDAA);
			        HideNanoSuitText(playerid);
				    ShowNanoSuitText(playerid);
		    	}
			}
		}



	    if(RELEASED(KEY_WALK) && GetPVarInt(playerid, "Switched") == 1)
		{
		    SetPVarInt(playerid,"Switched", 0);

			if(GetPVarInt(playerid, "SelectedRow") == 1) // (Shield)
		    {
				if(GetPVarInt(playerid,"Energy") > 10)
				{
				    if(GetPVarInt(playerid,"NanoSpeed") == 1)
			        	DisableNanoSuit(playerid,1);
					else
					    DisableNanoSuit(playerid);

					KillTimer(RecoverEnergyTimer[playerid]);
			        KillTimer(WasteEnergyTimer[playerid]);
	    			if(GetPVarInt(playerid, "NanoSpeed") == 1)
					{
					    WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
					}
			        Shield(playerid);
				}
				else
    			{
					SendClientMessage(playerid, COLOR_WHITE,"{FF66FF}NANO SUIT MESSAGE: {FFFFFF}You can't use any nano module while your energy is in critical levels!");
                    InactiveNanoSuit(playerid);
					return 1;
				}
			}
			else if(GetPVarInt(playerid, "SelectedRow") == 2) // (Stealth)
		    {
		        if(GetPVarInt(playerid,"NanoSpeed") == 1)
		        	DisableNanoSuit(playerid,1);
				else
				    DisableNanoSuit(playerid);


		        for(new i = 0; i < PLAYERS; i++)
				{
					if(IsPlayerConnected(i))
					{
      					ShowPlayerNameTagForPlayer(i, playerid, false);
					}
				}

				SetPVarInt(playerid, "StealthMode", 1);

				KillTimer(RecoverEnergyTimer[playerid]);
		        KillTimer(WasteEnergyTimer[playerid]);
				if(GetPVarInt(playerid,"NanoSpeed") == 1)
		        {
			        WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",166,true,"i",playerid);
				}
				else
				{
		        	WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",300,true,"i",playerid);
				}
				GameTextForPlayer(playerid, "~w~Nanosuit Camouflage activated..",3000,3);
				SetPlayerColor(playerid, 0xFFFFFF00);
			}
			else if(GetPVarInt(playerid, "SelectedRow") == 3) // None
		    {
		        GameTextForPlayer(playerid, "~w~Nanosuit is now inactive...",3000,3);
		        if(GetPVarInt(playerid,"NanoSpeed") == 1)
		        	DisableNanoSuit(playerid,1);
				else
				    DisableNanoSuit(playerid);

				KillTimer(RecoverEnergyTimer[playerid]);
		        KillTimer(WasteEnergyTimer[playerid]);
				if(GetPVarInt(playerid,"NanoSpeed") == 1)
		        {
			        WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
				}
				else
				{
		        	RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",200,true,"i",playerid);
				}
			}
		}


		if(PRESSED(KEY_JUMP) && !IsPlayerInAnyVehicle(playerid))
		{
		    if(GetPVarInt(playerid,"PressedJump") == 0)
		    {
		        SetPVarInt(playerid, "PressedJump",1);
		        SetTimerEx("ResetKey",300,false,"ii",playerid,0);
		        return 1;
			}


		    if(GetPVarInt(playerid, "Nanosuit") == 1 && GetPVarInt(playerid, "Energy") > 20 && GetPVarInt(playerid,"PressedJump") == 1)
		    {
				if(GetPVarInt(playerid,"NanoStr") == 2)
				    return 1;

				new Float:Health;
				GetPlayerHealth(playerid,Health);

		        new Float:VelX, Float:VelY, Float:VelZ;
		        GetPlayerVelocity(playerid, VelX,VelY,VelZ);
		        SetPlayerVelocity(playerid, VelX,VelY,VelZ+0.5);
		        SetPVarFloat(playerid, "PreHealth",Health);
		        SetPVarInt(playerid, "NanoStr",2);
		        SetTimerEx("ResetNanoStr",2000,false,"i",playerid);
		        SetPVarInt(playerid,"Energy",GetPVarInt(playerid,"Energy") - 15);
		        TextDrawBoxColor(Nanosuit[playerid][1], 0x00DDDDAA);
		        HideNanoSuitText(playerid);
			    ShowNanoSuitText(playerid);

          		if(GetPVarInt(playerid,"StealthMode") == 0 && GetPVarInt(playerid,"NanoSpeed") == 0)
		        {
			        KillTimer(RecoverEnergyTimer[playerid]);
			        KillTimer(WasteEnergyTimer[playerid]);
			        RecoverEnergy(playerid);
			        if(GetPVarInt(playerid,"NanoShield") == 1)
			        	RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",500,true,"i",playerid);
					else
						RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",200,true,"i",playerid);
				}
			}
		}

	    if(PRESSED(KEY_SPRINT) && !IsPlayerInAnyVehicle(playerid))
	    {
	        if(GetPVarInt(playerid,"PressedSprint") == 0)
		    {
		        SetPVarInt(playerid, "PressedSprint",1);
		        SetTimerEx("ResetKey",300,false,"ii",playerid,1);
		        return 1;
			}
		}

		if(HOLDING(KEY_SPRINT) && GetPVarInt(playerid,"PressedSprint") == 1)
		{
			if(GetPVarInt(playerid, "Nanosuit") == 1 && GetPVarInt(playerid, "Energy") > 10)
		    {
		        ApplyAnimation(playerid, "PED","sprint_civi",4.5,1,1,1,1,1,1);
		        SetPVarInt(playerid, "NanoSpeed",1);
		        KillTimer(RecoverEnergyTimer[playerid]);
			    KillTimer(WasteEnergyTimer[playerid]);
			    TextDrawBoxColor(Nanosuit[playerid][1], 0x00DDDDAA);
		        HideNanoSuitText(playerid);
			    ShowNanoSuitText(playerid);

                if(GetPVarInt(playerid,"StealthMode") == 0 && GetPVarInt(playerid,"NanoShield") == 0)
		        {
			        WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
				}
				else if(GetPVarInt(playerid, "StealthMode") == 1)
				{
				    WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",166,true,"i",playerid);
				}
				else if(GetPVarInt(playerid, "NanoShield") == 1)
				{
				    WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",333,true,"i",playerid);
				    RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",500,true,"i",playerid);
				}
			}
		}
		if(RELEASED(KEY_SPRINT) && !IsPlayerInAnyVehicle(playerid))
		{
		    if(GetPVarInt(playerid, "Nanosuit") == 1 && GetPVarInt(playerid,"NanoSpeed") == 1)
		    {
		        if(GetPVarInt(playerid,"NanoStr") != 2)
		        {
		            new animlib[12],animname[24];
		            GetAnimationName(GetPlayerAnimationIndex(playerid),animlib,12,animname,24);

		            if(strfind(animname,"CLIMB_",true) == -1)
		            {
	                    new Float:x,Float:y,Float:z,Float:vx,Float:vy,Float:vz;
	                    GetPlayerVelocity(playerid,vx,vy,vz);
	                    GetPlayerPos(playerid, x,y,z);
	                    SetPlayerPos(playerid, x,y,z+1);
	                    SetPlayerVelocity(playerid,vx,vy,vz);
	 				}

		    		TextDrawBoxColor(Nanosuit[playerid][1], 0x008080AA);
			        HideNanoSuitText(playerid);
				    ShowNanoSuitText(playerid);
				}
	     		SetPVarInt(playerid, "NanoSpeed",0);
	     		KillTimer(RecoverEnergyTimer[playerid]);
			    KillTimer(WasteEnergyTimer[playerid]);

                if(GetPVarInt(playerid,"StealthMode") == 1)
		        {
		            WasteEnergyTimer[playerid] = SetTimerEx("WasteEnergy",300,true,"i",playerid);
				}
				else if(GetPVarInt(playerid, "NanoShield") == 1)
				{
				    RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",500,true,"i",playerid);
				}
				else
				{
                    RecoverEnergy(playerid);
			        RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",200,true,"i",playerid);
				}
			}
		}
	}
	
	if ( PRESSED(KEY_FIRE) )
	{

		if(GetPVarInt(playerid, "StealthMode") == 1) // Disabling Stealth
		{
			DisableNanoSuit(playerid);
			InactiveNanoSuit(playerid);
	     	SetPVarInt(playerid,"Energy", 0);
		}
	}
	return 0;
}

stock FormatNanoEnergy(playerid)
{
	new ene = GetPVarInt(playerid,"Energy");

	if(ene >= 100)
    	format(msg,sizeof(msg),"Energy: IIIIIIIIII");
    else if(ene >= 90 && ene < 100)
    	format(msg,sizeof(msg),"Energy: IIIIIIIII");
    else if(ene >= 80 && ene < 90)
    	format(msg,sizeof(msg),"Energy: IIIIIIII");
    else if(ene >= 70 && ene < 80)
    	format(msg,sizeof(msg),"Energy: IIIIIII");
    else if(ene >= 60 && ene < 70)
    	format(msg,sizeof(msg),"Energy: IIIIII");
    else if(ene >= 50 && ene < 60)
    	format(msg,sizeof(msg),"Energy: IIIII");
    else if(ene >= 40 && ene < 50)
    	format(msg,sizeof(msg),"Energy: IIII");
	else if(ene >= 30 && ene < 40)
    	format(msg,sizeof(msg),"Energy: III");
    else if(ene >= 20 && ene < 30)
    	format(msg,sizeof(msg),"~r~Energy: II");
    else if(ene >= 10 && ene < 20)
    	format(msg,sizeof(msg),"~r~Energy: I");
    else if(ene >= 0 && ene < 10)
    	format(msg,sizeof(msg),"~r~Energy: Critical");

	TextDrawSetString(NanosuitTD[playerid][0],msg);

	if(ene >= 30)
    	format(msg,sizeof(msg),"(%d%%)",ene);
	else
    	format(msg,sizeof(msg),"~r~(%d%%)",ene);

	TextDrawSetString(NanosuitTD[playerid][1],msg);
	return 1;
}

forward ResetKey(playerid, key);
public ResetKey(playerid, key)
{
	if(key == 0)
	{
	    SetPVarInt(playerid, "PressedJump",0);
	}
	else if(key == 1)
	{
	    SetPVarInt(playerid, "PressedSprint",0);
	}
	else if(key == 2)
	{
	    SetPVarInt(playerid, "PressedAlt",0);
	}
	return 1;
}

stock InactiveNanoSuit(playerid)
{
	SetPVarInt(playerid,"SelectedRow",3);
	TextDrawBoxColor(Nanosuit[playerid][0], 0x008080AA);
	TextDrawBoxColor(Nanosuit[playerid][2], 0x008080AA);
	TextDrawBoxColor(Nanosuit[playerid][3], 0x00DDDDAA);
	HideNanoSuitText(playerid);
	ShowNanoSuitText(playerid);
	return 1;
}

forward WasteEnergy(playerid);
public WasteEnergy(playerid)
{
	SetPVarInt(playerid,"Energy", GetPVarInt(playerid,"Energy") - 1);
	if(GetPVarInt(playerid,"Energy") <= 0)
	{
	    KillTimer(RecoverEnergyTimer[playerid]);
	    KillTimer(WasteEnergyTimer[playerid]);
	    SetPVarInt(playerid,"Energy",0);
		RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",200,true,"i",playerid);
        TextDrawBoxColor(Nanosuit[playerid][1], 0x008080AA);
		DisableNanoSuit(playerid);
	    InactiveNanoSuit(playerid);
	    GameTextForPlayer(playerid,"~r~Energy Wasted ~n~Disabling Nanosuit",3000,3);
	}
	FormatNanoEnergy(playerid);
	return 1;
}

forward RecoverEnergy(playerid);
public RecoverEnergy(playerid)
{
	if(GetPVarInt(playerid,"NanoShield") == 0)
	{
	    SetPVarInt(playerid,"Energy", GetPVarInt(playerid,"Energy") + 1);

		if(GetPVarInt(playerid,"Energy") >= 100)
		{
		    KillTimer(RecoverEnergyTimer[playerid]);
		    SetPVarInt(playerid,"Energy",100);
		    GameTextForPlayer(playerid,"~g~~h~Maximun Energy",3000,3);
		}

		FormatNanoEnergy(playerid);
	}
	else
	{
	    new Float:Armour;
	    GetPlayerArmour(playerid, Armour);
	    if(Armour < 200)
	    {
	    	SetPlayerArmour(playerid, Armour+2.5);
	    	WasteEnergy(playerid);
		}
		else
		{
		    SetPlayerArmour(playerid, 200);
		    GameTextForPlayer(playerid, "~g~~h~Maximun Armour reached",3000,3);

		    if(GetPVarInt(playerid,"NanoSpeed") == 1)
		       	DisableNanoSuit(playerid,1);
			else
			    DisableNanoSuit(playerid);

		    KillTimer(RecoverEnergyTimer[playerid]);
	    	InactiveNanoSuit(playerid);

	    	if(GetPVarInt(playerid,"NanoSpeed") == 0)
		    	RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",200,true,"i",playerid);

		}
	}
	return 1;
}

stock CreateNanoSuitTexts(playerid)
{
    Nanosuit[playerid][1] = TextDrawCreate(503.000000, 428.000000, "PWR");
	TextDrawAlignment(Nanosuit[playerid][1], 2);
	TextDrawBackgroundColor(Nanosuit[playerid][1], 255);
	TextDrawFont(Nanosuit[playerid][1], 1);
	TextDrawLetterSize(Nanosuit[playerid][1], 0.250000, 1.100000);
	TextDrawColor(Nanosuit[playerid][1], -1);
	TextDrawSetOutline(Nanosuit[playerid][1], 1);
	TextDrawSetProportional(Nanosuit[playerid][1], 1);
	TextDrawUseBox(Nanosuit[playerid][1], 1);
	TextDrawBoxColor(Nanosuit[playerid][1], 0x008080AA);
	TextDrawTextSize(Nanosuit[playerid][1], -40.000000, -29.000000);

	Nanosuit[playerid][0] = TextDrawCreate(529.000000, 428.000000, "SHLD");
	TextDrawAlignment(Nanosuit[playerid][0], 2);
	TextDrawBackgroundColor(Nanosuit[playerid][0], 255);
	TextDrawFont(Nanosuit[playerid][0], 1);
	TextDrawLetterSize(Nanosuit[playerid][0], 0.250000, 1.100000);
	TextDrawColor(Nanosuit[playerid][0], -1);
	TextDrawSetOutline(Nanosuit[playerid][0], 1);
	TextDrawSetProportional(Nanosuit[playerid][0], 1);
	TextDrawUseBox(Nanosuit[playerid][0], 1);
	TextDrawBoxColor(Nanosuit[playerid][0], 0x008080AA);
	TextDrawTextSize(Nanosuit[playerid][0], -40.000000, -29.000000);

	Nanosuit[playerid][2] = TextDrawCreate(555.000000, 428.000000, "STLH");
	TextDrawAlignment(Nanosuit[playerid][2], 2);
	TextDrawBackgroundColor(Nanosuit[playerid][2], 255);
	TextDrawFont(Nanosuit[playerid][2], 1);
	TextDrawLetterSize(Nanosuit[playerid][2], 0.250000, 1.100000);
	TextDrawColor(Nanosuit[playerid][2], -1);
	TextDrawSetOutline(Nanosuit[playerid][2], 1);
	TextDrawSetProportional(Nanosuit[playerid][2], 1);
	TextDrawUseBox(Nanosuit[playerid][2], 1);
	TextDrawBoxColor(Nanosuit[playerid][2], 0x008080AA);
	TextDrawTextSize(Nanosuit[playerid][2], -40.000000, -29.000000);

	Nanosuit[playerid][3] = TextDrawCreate(582.000000, 428.000000, "NONE");
	TextDrawAlignment(Nanosuit[playerid][3], 2);
	TextDrawBackgroundColor(Nanosuit[playerid][3], 255);
	TextDrawFont(Nanosuit[playerid][3], 1);
	TextDrawLetterSize(Nanosuit[playerid][3], 0.250000, 1.100000);
	TextDrawColor(Nanosuit[playerid][3], -1);
	TextDrawSetOutline(Nanosuit[playerid][3], 1);
	TextDrawSetProportional(Nanosuit[playerid][3], 1);
	TextDrawUseBox(Nanosuit[playerid][3], 1);
	TextDrawBoxColor(Nanosuit[playerid][3], 0x008080AA);
	TextDrawTextSize(Nanosuit[playerid][3], -45.000000, -32.000000);

	NanosuitTD[playerid][0] = TextDrawCreate(489.000000, 410.000000, " "); // Nanosuit Energy
	TextDrawBackgroundColor(NanosuitTD[playerid][0], 255);
	TextDrawFont(NanosuitTD[playerid][0], 1);
	TextDrawLetterSize(NanosuitTD[playerid][0], 0.390000, 1.300000);
	TextDrawColor(NanosuitTD[playerid][0], 16777130);
	TextDrawSetOutline(NanosuitTD[playerid][0], 1);
	TextDrawSetProportional(NanosuitTD[playerid][0], 1);

	NanosuitTD[playerid][1] = TextDrawCreate(555.000000, 404.000000, " ");
	TextDrawAlignment(NanosuitTD[playerid][1], 2);
	TextDrawBackgroundColor(NanosuitTD[playerid][1], 255);
	TextDrawFont(NanosuitTD[playerid][1], 1);
	TextDrawLetterSize(NanosuitTD[playerid][1], 0.170000, 0.699999);
	TextDrawColor(NanosuitTD[playerid][1], 16777130);
	TextDrawSetOutline(NanosuitTD[playerid][1], 1);
	TextDrawSetProportional(NanosuitTD[playerid][1], 1);

	TextDrawSetString(NanosuitTD[playerid][0],"Energy: IIIIIIIIII");
	TextDrawSetString(NanosuitTD[playerid][1],"(100%)");
	return 1;
}

stock DestroyNanoSuitTexts(playerid)
{
	for(new i = 0; i < 2; i ++)
	{
		TextDrawDestroy(NanosuitTD[playerid][i]);
	}
	for(new i = 0; i < 4; i ++)
	{
		TextDrawDestroy(Nanosuit[playerid][i]);
	}

	return 1;
}

stock ShowNanoSuitText(playerid)
{
    for(new i = 0; i < 4; i ++)
	{
		TextDrawShowForPlayer(playerid,Nanosuit[playerid][i]);
	}
	return 1;
}

stock HideNanoSuitText(playerid)
{
    for(new i = 0; i < 4; i ++)
	{
		TextDrawHideForPlayer(playerid,Nanosuit[playerid][i]);
	}
	return 1;
}

stock DisableNanoSuit(playerid,type = 0)
{
    for(new i = 0; i < PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			ShowPlayerNameTagForPlayer(i, playerid, true);
		}
	}
	SetPlayerColor(playerid,0xFFFFFFFF);
	if(type == 0)
	{
		if(!IsPlayerInAnyVehicle(playerid) && GetPVarInt(playerid,"NanoSpeed") == 1)
		{
		    SetPVarInt(playerid, "NanoSpeed",0);
			ClearAnimations(playerid);
		}
	}
	SetPVarInt(playerid, "NanoStr",0);
	SetPVarInt(playerid, "NanoShield",0);
	SetPVarInt(playerid, "StealthMode", 0);
	if(GetPVarInt(playerid, "StealthMode") == 1)
	{
		SendClientMessage(playerid, 0xFFFFFFAA,"{FF66FF}NANO SUIT MESSAGE: {FFFFFF}You ran off energy, Stealth mode has been disabled!");
	}
	return 1;
}


stock Shield(playerid)
{
    GameTextForPlayer(playerid, "~w~Nano armour Regeneration Enabled",3000,3);
    SetPVarInt(playerid, "NanoShield", 1);
    RecoverEnergyTimer[playerid] = SetTimerEx("RecoverEnergy",500,true,"i",playerid);
	return 1;
}

stock PlayerName(playerid)
{
	new name[24];
  	GetPlayerName(playerid, name, 255);
  	return name;
}

CMD:nanosuit(playerid, params[])
{
    if(!strlen(params)) return SendClientMessage(playerid,0xFFFF00FF, "USAGE: {ffffff}/nanosuit");

	if(GetPVarInt(playerid,"Nanosuit") == 0)
	{
		SetPVarInt(playerid, "PreSkin",GetPlayerSkin(playerid));
		CreateNanoSuitTexts(playerid);
		SetPlayerColor(playerid, 0xBBBBBBFF);
		TextDrawBoxColor(Nanosuit[playerid][3], 0x00DDDDAA);
		SetPVarInt(playerid, "Nanosuit",1);
		SetPVarInt(playerid,"Energy", 100);
		SetPlayerSkin(playerid, 285);
		ShowNanoSuitText(playerid);

		TextDrawShowForPlayer(playerid, NanosuitTD[playerid][0]);
		TextDrawShowForPlayer(playerid, NanosuitTD[playerid][1]);

		GameTextForPlayer(playerid,"~w~Loading all Inner Systems... ~n~~g~Strength, Stealth, Armour & Speed - ready~n~~w~Nanosuit 2.0 is now ~p~Online",10000,5);

		SendClientMessage(playerid, COLOR_WHITE,"{FF66FF}Nano Suit information: {FFFFFF}Nanosuit 2.0 is now online, to switch the nanosuit modules press the Walking key. (~k~~KEY_WALK~)");
	}
	else
	{
		SetPVarInt(playerid, "Nanosuit",0);
		SetPlayerSkin(playerid, GetPVarInt(playerid,"PreSkin"));
		SetPlayerColor(playerid, 0xFFFFFFFF);
		KillTimer(RecoverEnergyTimer[playerid]);
		KillTimer(WasteEnergyTimer[playerid]);
		DisableNanoSuit(playerid);
        HideNanoSuitText(playerid);
        DestroyNanoSuitTexts(playerid);
		GameTextForPlayer(playerid,"~w~Unloading all Inner Systems... ~n~~r~Strength, Stealth, Armour & Speed - unloaded~n~~w~Nanosuit 2.0 is now ~r~Offline",10000,5);
	}
	return 1;
}