#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

new bool:slot1, bool:slot2, bool:slot3, bool:slot4, bool:slot5, bool:slot6, bool:slot7, bool:slot8, bool:slot9, bool:slot10, bool:slot11;
new IsTraining[MAX_PLAYERS] = 0;
new slotb1[MAX_PLAYERS], slotb2[MAX_PLAYERS], slotb3[MAX_PLAYERS]; //
new pWeapons[11];
new pAmmo[11];
new Skills[11] = 0;
new Float:OldX, Float:OldY, Float:OldZ;
new TerminateTimer[MAX_PLAYERS];

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Weapon Training System by battlezone Loaded");
	print("--------------------------------------\n");
	CreateObject(978, 805.40039, 1669.8002, 5.1, 0, 0, 0);
	CreateObject(978, 796.5, 1669.8, 5.1, 0, 0, 0);
	Create3DTextLabel("Slot 1", 0xFFC0CBAA , 809.09,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 2", 0xFFC0CBAA , 807.66,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 3", 0xFFC0CBAA , 806.17,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 4", 0xFFC0CBAA , 804.64,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 5", 0xFFC0CBAA , 803.12,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 6", 0xFFC0CBAA , 801.66,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 7", 0xFFC0CBAA , 800.16,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 8", 0xFFC0CBAA , 798.59,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 9", 0xFFC0CBAA , 797.18,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 10", 0xFFC0CBAA , 795.68,1668.89,5.28, 40.0, 0, 0);
	Create3DTextLabel("Slot 11", 0xFFC0CBAA , 794.23,1668.89,5.28, 40.0, 0, 0);
	return 1;
}

CMD:train(playerid, params[])
{
	if(IsTraining[playerid] != 0) return SendClientMessage(playerid, 0xAA3333AA, "You are already training!");
	ShowPlayerDialog(playerid, 5555, DIALOG_STYLE_LIST, "Training menu : Choose your weapon", "9mm\n9mm Silenced\nDesert Eagle\nSawnoff Shotgun\nCombat shotgun\nMicro SMG\nMP5 Thompson\nAK47\nM4\nSniper", "Start", "Cancel");
	return 1;
}

CMD:myskills(playerid, params[])
{
	new str[120];
	format(str, sizeof str, "Pistol: %d\nSilenced 9mm: %d\nDesert Eagle: %d\nSawnOff: %d\nSpas12 Shotgun: %d\nMicro UZI: %d\nMP5: %d\nAK47: %d\nM4: %d\nSniper: %d", Skills[0], Skills[1], Skills[2], Skills[4], Skills[5], Skills[6], Skills[7], Skills[8], Skills[9],  Skills[10]);
    ShowPlayerDialog(playerid, 5556, DIALOG_STYLE_MSGBOX, "My weapon skills", str, "Exit", "");
    return 1;
}

CMD:gimme(playerid)
{
	new Float:X, Float:Y, Float:Z, Float:Angle;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, Angle);
	CreateVehicle(411, X, Y, Z + 2.0, Angle + 90.0, -1, -1, 5000);
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case 5555:
		{
	  		if(!response) return SendClientMessage(playerid, 0xAA3333AA, "You have canceled the training!");
	  		if(listitem < 3) { if(Skills[listitem] > 999) return SendClientMessage(playerid, -1, "You have already reached max skill level with this weapon!"); }
	  		else if(Skills[listitem + 1] > 999) return SendClientMessage(playerid, -1, "You have already reached max skill level with this weapon!");
			cmd_go(playerid);
	  		if(IsTraining[playerid] != 0)
	  		{
		  		GetPlayerPos(playerid, OldX, OldY, OldZ);
		  		SendClientMessage(playerid, 0xFFFF00AA, "Your weapons will be temporarily reset during the training");
		  		for(new i=0; i < 11; i++)	GetPlayerWeaponData(playerid,i,pWeapons[i],pAmmo[i]);
				ResetPlayerWeapons(playerid);
				switch(listitem)
				{
				    case 0: GivePlayerWeapon(playerid, 22, 9999);
				    case 1: GivePlayerWeapon(playerid, 23, 9999);
				    case 2: GivePlayerWeapon(playerid, 24, 9999);
				    case 3: GivePlayerWeapon(playerid, 26, 9999);
				    case 4: GivePlayerWeapon(playerid, 27, 9999);
				    case 5: GivePlayerWeapon(playerid, 28, 9999);
				    case 6: GivePlayerWeapon(playerid, 29, 9999);
				    case 7: GivePlayerWeapon(playerid, 30, 9999);
				    case 8: GivePlayerWeapon(playerid, 31, 9999);
				    case 9: GivePlayerWeapon(playerid, 34, 9999);
				}
			}
		}
	}
    return 0;
}
CMD:go(playerid)
{
	IsTraining[playerid] ++;
	if(!slot1) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot2) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot3) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot4) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot5) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot6) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot7) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot8) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot9) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot10) return train(playerid);
	IsTraining[playerid] ++;
	if(!slot11) return train(playerid);
	IsTraining[playerid] = 0;
	SendClientMessage(playerid, 0xFF9900AA, "No slots available");
	return 1;
}

stock train(playerid)
{
	switch(IsTraining[playerid])
	{
	    case 1:
		{
		    SetPlayerPos(playerid, 809.2548,1669.2346,5.2813);
		    slot1 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 809.2759,1659.0176,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 2:
		{
		    SetPlayerPos(playerid, 807.7926,1668.8962,5.2813);
		    slot2 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 807.7242,1659.3212,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
	    case 3:
		{
		    SetPlayerPos(playerid, 806.1575,1668.9023,5.2813);
		    slot3 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 806.2162,1659.4495,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 4:
		{
		    SetPlayerPos(playerid, 804.6766,1668.8965,5.2813);
		    slot4 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 804.5635,1659.4337,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 5:
		{
		    SetPlayerPos(playerid, 803.3358,1668.8965,5.2813);
		    slot5 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 803.3602,1659.4086,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 6:
		{
		    SetPlayerPos(playerid, 801.6914,1668.9021,5.2813);
		    slot6 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 801.7728,1659.4193,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 7:
		{
		    SetPlayerPos(playerid, 800.3949,1668.9005,5.2813);
		    slot7 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 800.5167,1659.3779,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 8:
		{
		    SetPlayerPos(playerid, 798.8149,1668.8967,5.2813);
		    slot8 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 798.8743,1659.3169,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 9:
		{
		    SetPlayerPos(playerid, 797.1765,1668.8967,5.2813);
		    slot9 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 797.2021,1659.2546,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 10:
		{
		    SetPlayerPos(playerid, 795.8724,1668.8964,5.2813);
		    slot10 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 795.8489,1659.2040,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
		case 11:
		{
		    SetPlayerPos(playerid, 794.3159,1668.8964,5.2813);
		    slot11 = true;
		    slotb1[playerid] = CreatePlayerObject(playerid, 1486, 794.1432,1659.1403,4.4813, 0.0, 0.0, 0.0, 100.00);
		}
	}
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	if(hittype == 3)
	{
	    if(hitid == slotb1[playerid])
		{
		    switch(IsTraining[playerid])
		    {
		    	case 1:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 809.6979,1645.6659,4.4826, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 2:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 807.9756,1645.3145,4.4826, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 3:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 806.5139,1645.0021,4.4826, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 4:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 805.0288,1645.0342,4.4826, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 5:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 803.3965,1645.0092,4.4826, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 6:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 801.6772,1644.6831,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 7:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 800.4271,1644.5623,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 8:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 798.6858,1644.7762,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 9:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 797.1193,1644.7615,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 10:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 795.4224,1644.7452,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
				case 11:
				{
				    slotb2[playerid] = CreatePlayerObject(playerid, 1486, 793.9834,1644.4231,4.4826, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb1[playerid]);
				}
			}
			PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
		}
	    if(hitid == slotb2[playerid])
		{
		    switch(IsTraining[playerid])
		    {
		        case 1:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 810.3208,1618.1469,4.4813, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 2:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 809.3016,1618.1086,4.4813, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 3:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 808.1950,1618.0488,4.4813, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 4:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 806.1711,1617.9402,4.4813, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 5:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 805.2635,1617.8916,4.4813, 0.0, 0.0, 0.0, 100.00);
		            DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 6:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 804.1240,1617.8302,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 7:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 802.3339,1617.7347,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 8:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 800.9711,1617.6616,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 9:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486, 798.8643,1617.5491,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 10:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486,  796.9112,1617.4443,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
		        case 11:
		        {
		            slotb3[playerid] = CreatePlayerObject(playerid, 1486,  793.8408,1617.3242,4.4813, 0.0, 0.0, 0.0, 100.00);
	            	DestroyPlayerObject(playerid, slotb2[playerid]);
		        }
			}
			PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
		}
		if(hitid == slotb3[playerid])
		{
			PlayerPlaySound(playerid, 17802, 0.0, 0.0, 0.0);
		    DestroyPlayerObject(playerid, slotb3[playerid]);
		    DestroyPlayerObject(playerid, slotb2[playerid]);
		    DestroyPlayerObject(playerid, slotb1[playerid]);
		    slotb1[playerid] = 0;
		    slotb2[playerid] = 0;
		    slotb3[playerid] = 0;
		    TerminateTimer[playerid] = SetTimerEx("TerminateTraining", 3000, 0, "d", playerid);
	        GameTextForPlayer(playerid, "~b~Training Session ~g~Finished!", 3000, 6);
		}
	}
	return 1;
}

forward TerminateTraining(playerid);
public TerminateTraining(playerid)
{
    new adder = random(50);
    Skills[GetSkillSlot(GetPlayerWeapon(playerid))] += adder;
    if(adder == 0) SendClientMessage(playerid, 0x00FF7FAA, "You did not get any skill this time!");
	else
	{
	    new str[100];
		format(str, sizeof(str), "Congratulations! You got + %d skill on this weapon!", adder);
	    SendClientMessage(playerid, 0x00FF7FAA, str);
	}
    SetPlayerSkillLevel(playerid, GetSkillSlot(GetPlayerWeapon(playerid)), Skills[GetSkillSlot(GetPlayerWeapon(playerid))]);
	ResetPlayerWeapons(playerid);
	for(new i=0; i < 11; i++)
	GivePlayerWeapon(playerid,pWeapons[i],pAmmo[i]);
	SetPlayerPos(playerid, OldX, OldY, OldZ);
	switch(IsTraining[playerid])
    {
        case 1: slot1 = false;
        case 2: slot2 = false;
        case 3: slot3 = false;
        case 4: slot4 = false;
        case 5: slot5 = false;
        case 6: slot6 = false;
        case 7: slot7 = false;
        case 8: slot8 = false;
        case 9: slot9 = false;
        case 10: slot10 = false;
        case 11: slot11 = false;
	}
	IsTraining[playerid] = 0;
	return 1;
}
stock GetSkillSlot(weaponid)
{
	new slot;
	switch(weaponid)
	{
        case 22: slot = 0;
        case 23: slot = 1;
        case 24: slot = 2;
        case 25: slot = 3;
        case 26: slot = 4;
        case 27: slot = 5;
        case 28 | 32: slot = 6;
        case 29: slot = 7;
        case 30: slot = 8;
        case 31: slot = 9;
        case 34: slot = 10;
	}
	return slot;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(IsTraining[playerid] != 0)
	{
		switch(IsTraining[playerid])
		{
		    case 1:	slot1 = false;
		    case 2:	slot2 = false;
		    case 3:	slot3 = false;
		    case 4:	slot4 = false;
		    case 5:	slot5 = false;
		    case 6:	slot6 = false;
		    case 7:	slot7 = false;
		    case 8:	slot8 = false;
		    case 9:	slot9 = false;
		    case 10:	slot10 = false;
		    case 11:	slot11 = false;
		}
		IsTraining[playerid] = 0;
		KillTimer(TerminateTimer[playerid]);
		DestroyPlayerObject(playerid, slotb3[playerid]);
	    DestroyPlayerObject(playerid, slotb2[playerid]);
	    DestroyPlayerObject(playerid, slotb1[playerid]);
	    slotb1[playerid] = 0;
	    slotb2[playerid] = 0;
	    slotb3[playerid] = 0;
        GameTextForPlayer(playerid, "~r~Training Session Failed!", 3000, 6);
	}
   	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(IsTraining[playerid] != 0)
	{
		switch(IsTraining[playerid])
		{
		    case 1:	slot1 = false;
		    case 2:	slot2 = false;
		    case 3:	slot3 = false;
		    case 4:	slot4 = false;
		    case 5:	slot5 = false;
		    case 6:	slot6 = false;
		    case 7:	slot7 = false;
		    case 8:	slot8 = false;
		    case 9:	slot9 = false;
		    case 10:	slot10 = false;
		    case 11:	slot11 = false;
		}
		IsTraining[playerid] = 0;
		KillTimer(TerminateTimer[playerid]);
		DestroyPlayerObject(playerid, slotb3[playerid]);
	    DestroyPlayerObject(playerid, slotb2[playerid]);
	    DestroyPlayerObject(playerid, slotb1[playerid]);
	    slotb1[playerid] = 0;
	    slotb2[playerid] = 0;
	    slotb3[playerid] = 0;
	}
	return 1;
}