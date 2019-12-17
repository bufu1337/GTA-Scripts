// FilterScript developed by CaioTJF (Forum SA-MP Profile:  http://forum.sa-mp.com/member.php?u=178553)
// If you use this in your server, please contact me to see.
// Version: 2.0
// Official topic PT-BR: http://forum.sa-mp.com/showthread.php?p=3653596
// Official topic EN: http://forum.sa-mp.com/showthread.php?p=3655514

//-------------------------------------------------------------------//
//************************** -Includes- *****************************//
//-------------------------------------------------------------------//

#include <a_samp>
#include <zcmd> // This is for the command /additem
#include <sscanf2> // This is for the command /additem

//-------------------------------------------------------------------//
//************************** -Defines- ******************************//
//-------------------------------------------------------------------//

#define MAX_INVENTORY_SLOTS 	15 // Don't change
#define MAX_ITENS_WORLD 		500
#define TIMER_ITEM_WORLD        60*10

//-------------------------------------------------------------------//
//************************ -Enumerações- ****************************//
//-------------------------------------------------------------------//

enum enum_Itens
{
	item_id,
 	item_tipo,
  	item_modelo,
 	item_nome[24],
	item_limite,
	bool:item_canbedropped,
	Float:item_previewrot[4],
	item_description[200]
}

enum
{
	ITEM_TYPE_WEAPON,
	ITEM_TYPE_HELMET,
	ITEM_TYPE_NORMAL,
	ITEM_TYPE_BODY,
	ITEM_TYPE_AMMO,
	ITEM_TYPE_BACKPACK,
	ITEM_TYPE_MELEEWEAPON
}

enum enum_pInventory
{
	invSlot[MAX_INVENTORY_SLOTS],
	invSelectedSlot,
	invSlotAmount[MAX_INVENTORY_SLOTS],
	Float:invArmourStatus[MAX_INVENTORY_SLOTS]
}

enum enum_pCharacter
{
	charSlot[7],
	charSelectedSlot,
	Float:charArmourStatus
}

enum enum_Player
{
	bool:inInventory,
	bool:MessageInventory,
	MessageInventoryTimer,
	Language
}

enum enum_ItensWorld
{
	bool:world_active,
	world_itemid,
	world_model,
	world_amount,
	world_object,
	world_timer,
	Text3D:world_3dtext,
	Float:world_armourstatus,
	Float:world_position[3],

}

new Itens[][enum_Itens] =
{
	{0, 	ITEM_TYPE_NORMAL,		19382, 		"Nada", 				0,			false,		{0.0,0.0,0.0,0.0}, 								"N/A"},
	{1, 	ITEM_TYPE_HELMET, 		18645, 		"Capacete", 			1,			true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Protege contra headshots."},
	{2, 	ITEM_TYPE_WEAPON, 		348, 		"Deagle", 				1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"Pistola de alto calibre.~n~~n~~g~Headshot habilitado."},
	{3, 	ITEM_TYPE_WEAPON, 		356, 		"M4", 					1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Fuzil de longo alcance~n~com média precisão."},
	{4, 	ITEM_TYPE_AMMO, 		2061, 		"Munição", 				200, 		true,		{0.000000, 0.000000, 0.000000, 2.000000}, 		"Munição para armas de fogo."},
	{5, 	ITEM_TYPE_WEAPON, 		344, 		"Molotov", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Arma incendiaria caseira."},
	{6, 	ITEM_TYPE_BODY, 		19142, 		"Colete", 				1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Colete aprova de balas."},
	{7, 	ITEM_TYPE_BACKPACK, 	3026, 		"Mochila Média",		1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Mochila que aumenta seu~n~inventário."},
	{8, 	ITEM_TYPE_BACKPACK, 	3026, 		"Mochila Grande",		1,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Mochila que aumenta seu~n~inventário."},
    {9, 	ITEM_TYPE_WEAPON, 		355, 		"AK-47", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Fuzil de longo alcance~n~com média precisão."},
    {10, 	ITEM_TYPE_WEAPON, 		349, 		"Shotgun", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Shotgun de curto alcance~n~com um grande poder de fogo.~n~~n~~g~Headshot habilitado."},
    {11, 	ITEM_TYPE_MELEEWEAPON,	335, 		"Faca", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Arma de corpo-a-corpo."},
    {12, 	ITEM_TYPE_MELEEWEAPON,	334, 		"Cacetete", 			1, 			true,		{0.000000, -30.00000, 0.000000, 1.500000}, 		"Arma de corpo-a-corpo."},
    {13, 	ITEM_TYPE_WEAPON, 		352, 		"Uzi", 					1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"Micro metralhadora~n~de duas mãos.."},
    {14, 	ITEM_TYPE_WEAPON, 		347, 		"Usp", 					1, 			true,		{0.000000, -30.00000, 0.000000, 1.200000}, 		"Pistola com silenciador.~n~~n~~g~Headshot habilitado."},
    {15, 	ITEM_TYPE_WEAPON, 		353, 		"MP5", 					1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Micro metralhadora."},
    {16, 	ITEM_TYPE_WEAPON, 		358, 		"Sniper", 				1, 			true,		{0.000000, -30.00000, 0.000000, 2.200000}, 		"Rifle de longo alcance.~n~~n~~g~Headshot habilitado."},
    {17, 	ITEM_TYPE_WEAPON, 		342, 		"Granada", 				5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Explosivo poderoso."},
    {18, 	ITEM_TYPE_NORMAL, 		11738, 		"Kit Médico", 			5,	 		true,		{0.000000, 0.000000, 0.000000, 1.000000}, 		"Kit de primeiro socorros~n~que recupera sua vida."}
};

//-------------------------------------------------------------------//
//************************* -Variables- *****************************//
//-------------------------------------------------------------------//

new pInventory[MAX_PLAYERS][enum_pInventory];
new pCharacter[MAX_PLAYERS][enum_pCharacter];
new Player[MAX_PLAYERS][enum_Player];
new ItensWorld[MAX_ITENS_WORLD][enum_ItensWorld];
new String[256];
new LastItemID;

//-------------------------------------------------------------------//
//************************* -TextDraws- *****************************//
//-------------------------------------------------------------------//

new PlayerText:inventario_index[MAX_PLAYERS][15];
new PlayerText:inventario_skin[MAX_PLAYERS];
new PlayerText:inventario_textos[MAX_PLAYERS][11];
new PlayerText:inventario_description[MAX_PLAYERS][4];
new PlayerText:inventario_personagemindex[MAX_PLAYERS][7];
new PlayerText:inventario_mensagem[MAX_PLAYERS];

new Text:inventario_usar;
new Text:inventario_split[2];
new Text:inventario_drop[2];
new Text:inventario_close[2];
new Text:inventario_backgrounds[5];
new Text:inventario_remover;

//-------------------------------------------------------------------//
//********************** -FilterScript- *****************************//
//-------------------------------------------------------------------//

forward @TimerOneSecond();
forward HideMessageInventory(playerid);
forward Float:GetPlayerArmourEx(playerid);

public OnFilterScriptInit()
{
	SetTimer("@TimerOneSecond", 1000, true);

	LoadTextDraws();

	LastItemID = 0;
	return 1;
}

public OnPlayerConnect(playerid)
{
	ResetVariables(playerid);

    for(new i = 0; i < 10; i++)
	   	RemovePlayerAttachedObject(playerid, i);

    pInventory[playerid][invSelectedSlot] = -1;
    pCharacter[playerid][charSelectedSlot] = -1;
    Player[playerid][Language] = 2;

   	LoadPlayerTextDraws(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(Player[playerid][MessageInventory])
	    KillTimer(Player[playerid][MessageInventoryTimer]);

    ResetVariables(playerid);
	return true;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerSkin(playerid, 292);
	return true;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
	{
	    if(Player[playerid][inInventory])
	    	HideInventory(playerid);
	}
    else if(clickedid == inventario_close[0])
    {
        HideInventory(playerid);
    }
    else if(clickedid == inventario_usar)
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

		new slot = pInventory[playerid][invSelectedSlot];

		pInventory[playerid][invSelectedSlot] = -1;
        UseItem(playerid, slot, Itens[pInventory[playerid][invSlot][slot]][item_id]);
    }
    else if(clickedid == inventario_split[0])
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

        if(IsInventoryFull(playerid))
			return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));

        new slot = pInventory[playerid][invSelectedSlot];

		if(pInventory[playerid][invSlotAmount][slot] == 1)
			return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Você não pode dividir esse item.",
			"~r~ERROR: ~w~You can't divide this item."));

        SplitItem(playerid, pInventory[playerid][invSelectedSlot]);
    }
    else if(clickedid == inventario_drop[0])
    {
        if(pInventory[playerid][invSelectedSlot] == -1)
            return 0;

        new slot = pInventory[playerid][invSelectedSlot];
        new itemid = pInventory[playerid][invSlot][slot];
        new amount = pInventory[playerid][invSlotAmount][slot];
        new Float:armourstatus = pInventory[playerid][invArmourStatus][slot];
		new Float:pos[3];

		if(!Itens[itemid][item_canbedropped])
		    return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Você não pode derrubar esse item.",
			"~r~ERROR: ~w~You can't drop this item."));

		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

		if(itemid == 6)
			DropItem(pos[0], pos[1], pos[2], itemid, amount, armourstatus);
		else
	    	DropItem(pos[0], pos[1], pos[2], itemid, amount);

		RemoveItemFromInventory(playerid, slot);

	   	for(new a = 0; a < 4; a++)
		   	PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

		TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

		pInventory[playerid][invSelectedSlot] = -1;

    }
    else if(clickedid == inventario_remover)
    {
        if(pCharacter[playerid][charSelectedSlot] == -1)
            return 0;

  	    if(IsInventoryFull(playerid))
            return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Seu inventário está cheio.",
			"~r~ERROR: ~w~Your inventory is full."));

        new selected = pCharacter[playerid][charSelectedSlot];

		if(selected == 2)
        	if(GetSlotsInUse(playerid) > 5)
        	    return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
				"~r~ERRO: ~w~Esvazie seu inventário.",
				"~r~ERROR: ~w~Clean your inventory."));

  		if(selected == 2)
        	if(GetSlotsInUse(playerid) >= 5)
        	    return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
				"~r~ERRO: ~w~Não tem espaço no seu inventário.",
				"~r~ERROR: ~w~You don't have space in your inventory."));

        if(selected == 1)
            AddItem(playerid, pCharacter[playerid][charSlot][selected], 1, pCharacter[playerid][charArmourStatus]);
        else if(Itens[pCharacter[playerid][charSlot][selected]][item_id] == 5 || Itens[pCharacter[playerid][charSlot][selected]][item_id] == 17)
        {
	        new weapons[13][2];

	        for (new s = 0; s <= 12; s++)
			    GetPlayerWeaponData(playerid, s, weapons[s][0], weapons[s][1]);

            AddItem(playerid, pCharacter[playerid][charSlot][selected], weapons[8][1]);
		}
        else
        	AddItem(playerid, pCharacter[playerid][charSlot][selected], 1);

        RemoveItemFromCharacter(playerid, selected);

		pCharacter[playerid][charSelectedSlot] = -1;
    }

	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
    	if(playertextid == inventario_index[playerid][i])
    	{
    	    if(pInventory[playerid][invSlot][i] == 0)
    	        break;

    	    if(pInventory[playerid][invSelectedSlot] == i)
    	    {
    	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);
    	        pInventory[playerid][invSelectedSlot] = -1;
    	        PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
				PlayerTextDrawShow(playerid, inventario_index[playerid][i]);

				for(new a = 0; a < 4; a++)
		    		PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

                TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

               	TextDrawHideForPlayer(playerid, inventario_usar);
				TextDrawHideForPlayer(playerid, inventario_split[0]);
				TextDrawHideForPlayer(playerid, inventario_split[1]);
				TextDrawHideForPlayer(playerid, inventario_drop[0]);
				TextDrawHideForPlayer(playerid, inventario_drop[1]);

				PlayerTextDrawHide(playerid, inventario_textos[playerid][9]);

				break;
			}
			else if(pInventory[playerid][invSelectedSlot] != -1)
			{
    	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]], 96);
    	        PlayerTextDrawHide(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]]);
				PlayerTextDrawShow(playerid, inventario_index[playerid][pInventory[playerid][invSelectedSlot]]);
			}

            PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 0xFFFFFF50);

			PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
			PlayerTextDrawShow(playerid, inventario_index[playerid][i]);

			// Descrição do Item

			PlayerTextDrawSetPreviewModel(playerid, inventario_description[playerid][0], Itens[pInventory[playerid][invSlot][i]][item_modelo]);
            PlayerTextDrawSetPreviewRot(playerid, inventario_description[playerid][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
            PlayerTextDrawShow(playerid, inventario_description[playerid][0]);

			PlayerTextDrawSetString(playerid, inventario_description[playerid][1], ConvertToGameText(Itens[pInventory[playerid][invSlot][i]][item_nome]));
			PlayerTextDrawSetString(playerid, inventario_description[playerid][2], ConvertToGameText(Itens[pInventory[playerid][invSlot][i]][item_description]));

			if(Itens[pInventory[playerid][invSlot][i]][item_tipo] == ITEM_TYPE_BODY)
			    format(String, sizeof(String), "%s: %.1f", Translate(Player[playerid][Language], "Durabilidade", "Durability"), pInventory[playerid][invArmourStatus][i]);
			else if(pInventory[playerid][invSlotAmount][i] > 1)
				format(String, sizeof(String), "%s: %d", Translate(Player[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][i]);
			else
				String = " ";

			PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

			if(pInventory[playerid][invSelectedSlot] == -1)
			{
	            TextDrawShowForPlayer(playerid, inventario_usar);
			    TextDrawShowForPlayer(playerid, inventario_split[0]);
			    TextDrawShowForPlayer(playerid, inventario_split[1]);
			    TextDrawShowForPlayer(playerid, inventario_drop[0]);
			    TextDrawShowForPlayer(playerid, inventario_drop[1]);
			    PlayerTextDrawShow(playerid, inventario_textos[playerid][9]);

			    for(new a = 0; a < 4; a++)
    				PlayerTextDrawShow(playerid, inventario_description[playerid][a]);

                TextDrawShowForPlayer(playerid, inventario_backgrounds[4]);
			}

		    pInventory[playerid][invSelectedSlot] = i;
			break;
    	}

    for(new i = 0; i < 7; i++)
    	if(playertextid == inventario_personagemindex[playerid][i])
		{
		    if(pCharacter[playerid][charSlot][i] == 0)
    	        break;

		    if(pCharacter[playerid][charSelectedSlot] == i)
    	    {
    	        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 96);
    	        PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);
				PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);
    	        pCharacter[playerid][charSelectedSlot] = -1;

				PlayerTextDrawHide(playerid, inventario_textos[playerid][10]);
				TextDrawHideForPlayer(playerid, inventario_remover);
				break;
    	    }
    	    else if(pCharacter[playerid][charSelectedSlot] != -1)
    	    {
    	        new char_slot = pCharacter[playerid][charSelectedSlot];
    	        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][char_slot], 96);
    	        PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][char_slot]);
				PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][char_slot]);
    	    }

		    PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 0xFFFFFF50);
			PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);
			PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);

			if(pCharacter[playerid][charSelectedSlot] == -1)
			{
				PlayerTextDrawShow(playerid, inventario_textos[playerid][10]);
				TextDrawShowForPlayer(playerid, inventario_remover);
			}

			pCharacter[playerid][charSelectedSlot] = i;
			break;
		}

	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	new bool:valid_shot = true;

    new ammu_slot = GetAmmunationSlot(playerid);

	if(ammu_slot == -1)
	{
	    for(new s = 3; s < 7; s ++)
    	    if(Itens[pCharacter[playerid][charSlot][s]][item_tipo] != ITEM_TYPE_MELEEWEAPON)
	    	    if(pCharacter[playerid][charSlot][s] != 0)
	    	    {
				    AddItem(playerid, pCharacter[playerid][charSlot][s], 1);
			    	RemoveItemFromCharacter(playerid, s);
				}

		return false;
	}

    pInventory[playerid][invSlotAmount][GetAmmunationSlot(playerid)] --;
	SetPlayerAmmo(playerid, weaponid, GetAmmunation(playerid));

	if(GetAmmunation(playerid) <= 0)
	    for(new s = 3; s < 7; s ++)
    	    if(Itens[pCharacter[playerid][charSlot][s]][item_tipo] != ITEM_TYPE_MELEEWEAPON)
	    	    if(pCharacter[playerid][charSlot][s] != 0)
	    	    {
				    AddItem(playerid, pCharacter[playerid][charSlot][s], 1);
			    	RemoveItemFromCharacter(playerid, s);
			    	valid_shot = false;
				}

	if(pInventory[playerid][invSlotAmount][ammu_slot] <= 0)
		RemoveItemFromInventory(playerid, ammu_slot);

	if(valid_shot == false)
		return false;

	return true;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
    if(newkeys == KEY_NO)
	    if(!Player[playerid][inInventory])
		    ShowInventory(playerid);

 	if(newkeys == KEY_WALK)
        for(new i = 0; i < MAX_ITENS_WORLD; i++)
        {
            if(ItensWorld[i][world_active])
            {
                if(IsPlayerInRangeOfPoint(playerid, 2.0, ItensWorld[i][world_position][0], ItensWorld[i][world_position][1], ItensWorld[i][world_position][2]))
                {
                    new bool:sucess = false;

                    if(!IsInventoryFull(playerid))
                    {
	                    AddItem(playerid, ItensWorld[i][world_itemid], ItensWorld[i][world_amount], ItensWorld[i][world_armourstatus]);
	                    DeleteItemWorld(i);
	                    sucess = true;
					}

					if(!sucess)
	                    for(new a = 0; a < GetSlotsInventory(playerid); a ++)
							if(pInventory[playerid][invSlot][a] == ItensWorld[i][world_itemid])
					            if(Itens[ItensWorld[i][world_itemid]][item_limite] >= ItensWorld[i][world_amount]+pInventory[playerid][invSlotAmount][a])
								{
								    AddItem(playerid, ItensWorld[i][world_itemid], ItensWorld[i][world_amount], ItensWorld[i][world_armourstatus]);
	                   				DeleteItemWorld(i);
	                   				sucess = true;
	                                break;
								}

					if(!sucess)
						ShowMessageInventory(playerid, Translate(Player[playerid][Language],
						"~r~ERRO: ~w~Seu inventário está cheio.",
						"~r~ERROR: ~w~Your inventory is full."));

					break;
				}
            }
        }

	return true;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
    if(issuerid != INVALID_PLAYER_ID )
        if(bodypart == 9)
            if(weaponid == 23 || weaponid == 24 || weaponid == 25 || weaponid == 34)
	  			if(pCharacter[playerid][charSlot][0] != 0)
				    RemoveItemFromCharacter(playerid, 0);
				else
					SetPlayerHealth(playerid, 0.0);

 	return true;
}

public OnPlayerUpdate(playerid)
{
    new weapons[13][2];
    new bool:have_fuzil = false;

    for (new s = 0; s <= 12; s++)
	    GetPlayerWeaponData(playerid, s, weapons[s][0], weapons[s][1]);

    for(new s = 3; s < 7; s ++)
    {
        if(weapons[8][0] == 18 && weapons[8][1] == 0)
        	if(pCharacter[playerid][charSlot][s] == 5)
		        RemoveItemFromCharacter(playerid, s);

    	if(weapons[8][0] == 16 && weapons[8][1] == 0)
			if(pCharacter[playerid][charSlot][s] == 17)
		        RemoveItemFromCharacter(playerid, s);

	    if(pCharacter[playerid][charSlot][s] == 3 || pCharacter[playerid][charSlot][s] == 9)
		{
		    new weaponid = GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][item_modelo]);

		    if(GetPlayerWeapon(playerid) != weaponid)
		        SetPlayerAttachedObject(playerid, 3, Itens[pCharacter[playerid][charSlot][s]][item_modelo], 1, 0.015999,-0.125999,-0.153000,0.000000,-22.700004,0.400000,1.000000,1.000000,1.000000);
		    else
		        RemovePlayerAttachedObject(playerid, 3);

			have_fuzil = true;
		}

		if(!have_fuzil && pCharacter[playerid][charSlot][s] == 16)
		{
	        new weaponid = GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][item_modelo]);

		    if(GetPlayerWeapon(playerid) != weaponid)
		        SetPlayerAttachedObject(playerid, 3, Itens[pCharacter[playerid][charSlot][s]][item_modelo], 1, 0.015999,-0.125999,-0.153000,0.000000,-22.700004,0.400000,1.000000,1.000000,1.000000);
		    else
		        RemovePlayerAttachedObject(playerid, 3);
		}

		if(pCharacter[playerid][charSlot][s] == 10)
		{
		    new weaponid = GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][item_modelo]);

		    if(GetPlayerWeapon(playerid) != weaponid)
		    	SetPlayerAttachedObject(playerid, 4, Itens[pCharacter[playerid][charSlot][s]][item_modelo],1,-0.032000,-0.127000,0.000999,20.600004,29.900007,-2.599998,1.000000,1.000000,1.000000);
		    else
		        RemovePlayerAttachedObject(playerid, 4);
		}

		if(pCharacter[playerid][charSlot][s] == 2)
		{
		    new weaponid = GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][item_modelo]);

		    if(GetPlayerWeapon(playerid) != weaponid)
				SetPlayerAttachedObject(playerid, 5, Itens[pCharacter[playerid][charSlot][s]][item_modelo],1,-0.053999,0.005999,-0.207000,67.899978,-177.600006,-0.400004,1.000000,1.000000,1.000000);
            else
		        RemovePlayerAttachedObject(playerid, 5);
		}

		new itemid = pCharacter[playerid][charSlot][s];
		if(Itens[itemid][item_tipo] == ITEM_TYPE_MELEEWEAPON)
		{
		    new weaponid = GetWeaponIDFromModel(Itens[pCharacter[playerid][charSlot][s]][item_modelo]);

		    if(GetPlayerWeapon(playerid) != weaponid)
                SetPlayerAttachedObject(playerid,6,Itens[pCharacter[playerid][charSlot][s]][item_modelo],1,-0.226999,-0.034999,0.211999,-97.999916,-88.000083,3.600018,1.000000,1.000000,1.000000);
			else
		        RemovePlayerAttachedObject(playerid, 6);
		}
	}

	return true;
}

//----------------------------------------------------------

@TimerOneSecond()
{
	for(new i = 0; i < MAX_ITENS_WORLD; i++)
	    if(ItensWorld[i][world_active])
   		{
     		ItensWorld[i][world_timer]--;

  			if(ItensWorld[i][world_timer] == 0)
				DeleteItemWorld(i);
		}

	for(new playerid=0; playerid < MAX_PLAYERS; playerid++)
    {
  		if(pCharacter[playerid][charSlot][1] != 0)
		    if(GetPlayerArmourEx(playerid) > 0.0)
			    pCharacter[playerid][charArmourStatus] = GetPlayerArmourEx(playerid);
			else
			    RemoveItemFromCharacter(playerid, 1);
	}
}

//----------------------------------------------------------

stock AddItem(playerid, itemid, amount, Float:armorstatus = 100.0)
{
	new bool:sucess = false;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
    {
		if(pInventory[playerid][invSlot][i] == itemid && Itens[pInventory[playerid][invSlot][i]][item_limite] > 1 && pInventory[playerid][invSlotAmount][i] != Itens[pInventory[playerid][invSlot][i]][item_limite])
        {
            new check = amount + pInventory[playerid][invSlotAmount][i];

			if(check > Itens[pInventory[playerid][invSlot][i]][item_limite])
			{
                pInventory[playerid][invSlotAmount][i] = Itens[itemid][item_limite];

                for(new a = 0; a < MAX_INVENTORY_SLOTS; a ++)
                {
                	if(pInventory[playerid][invSlot][a] == 0)
                	{
                    	pInventory[playerid][invSlot][a] = itemid;
						new resto = Itens[itemid][item_limite] - check;
                    	pInventory[playerid][invSlotAmount][a] = resto*-1;

                    	if(Player[playerid][inInventory])
						{
	                    	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][a], Itens[itemid][item_modelo]);
	 						PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][a], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

							PlayerTextDrawHide(playerid, inventario_index[playerid][a]);
	            			PlayerTextDrawShow(playerid, inventario_index[playerid][a]);
						}

						break;
					}
				}
			}
			else
			{
            	pInventory[playerid][invSlotAmount][i] += amount;

            	if(Player[playerid][inInventory])
				{
				    if(pInventory[playerid][invSelectedSlot] == i)
					{
						if(pInventory[playerid][invSlotAmount][i] > 1)
							format(String, sizeof(String), "%s: %d", Translate(Player[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][i]);
						else
							String = " ";

						PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

					    PlayerTextDrawHide(playerid, inventario_description[playerid][3]);
					    PlayerTextDrawShow(playerid, inventario_description[playerid][3]);
					}
				}
			}

			sucess = true;
         	break;
		}
	}

	if(sucess)
	    return true;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
 	{
		if(pInventory[playerid][invSlot][i] == 0)
	    {
		    pInventory[playerid][invSlot][i] = itemid;
	        pInventory[playerid][invSlotAmount][i] = amount;

	        if(itemid == 6)
	        	pInventory[playerid][invArmourStatus][i] = armorstatus;

	        if(Player[playerid][inInventory])
			{
			    PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[itemid][item_modelo]);
				PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

	            PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
	            PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
			}

			break;
		}
	}

	return true;
}

//----------------------------------------------------------

stock SplitItem(playerid, slot)
{
    new result = pInventory[playerid][invSlotAmount][slot]/2;

	for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
        if(pInventory[playerid][invSlot][i] == 0)
        {
            pInventory[playerid][invSlotAmount][slot] = pInventory[playerid][invSlotAmount][slot]/2;

            pInventory[playerid][invSlot][i] = pInventory[playerid][invSlot][slot];
            pInventory[playerid][invSlotAmount][i] = result;

    		PlayerTextDrawHide(playerid, inventario_index[playerid][i]);
    		PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_modelo]);
 			PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
       		PlayerTextDrawShow(playerid, inventario_index[playerid][i]);

			if(pInventory[playerid][invSlotAmount][slot] > 1)
				format(String, sizeof(String), "%s: %d", Translate(Player[playerid][Language], "Quantidade", "Amount"), pInventory[playerid][invSlotAmount][slot]);
			else
				String = " ";

			PlayerTextDrawSetString(playerid, inventario_description[playerid][3], String);

       		PlayerTextDrawHide(playerid, inventario_description[playerid][3]);
       		PlayerTextDrawShow(playerid, inventario_description[playerid][3]);
    		break;
        }
}

//----------------------------------------------------------

stock UseItem(playerid, slot, item)
{
	if(Itens[item][item_tipo] == ITEM_TYPE_HELMET)
	{
		if(pCharacter[playerid][charSlot][0] == 0)
		{
		    AddItemCharacter(playerid, 0, item);
		    RemoveItemFromInventory(playerid, slot);
		}
		else
		{
		    RemoveItemFromInventory(playerid, slot);
		    AddItem(playerid, pCharacter[playerid][charSlot][0], 1);
		    RemoveItemFromCharacter(playerid, 0);
		    AddItemCharacter(playerid, 0, item);
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_WEAPON || Itens[item][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
	    if(GetAmmunation(playerid) <= 0 && Itens[item][item_tipo] == ITEM_TYPE_WEAPON)
	    {
	        if(item != 4 && item != 17)
	        {
		        pInventory[playerid][invSelectedSlot] = slot;
		        return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
				"~r~ERRO: ~w~Você não tem munição.", "~r~ERROR: ~w~You don't have ammunation."));
			}
	    }

	    new weapons[13][2];

		for (new i = 0; i <= 12; i++)
		    GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);

		new weaponid = GetWeaponIDFromModel(Itens[item][item_modelo]);
		new weaponslot = GetWeaponSlot(weaponid);

		if(weapons[weaponslot][0] != 0 && weapons[weaponslot][1] > 0)
		{
		    pInventory[playerid][invSelectedSlot] = slot;
			return ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Não é possivel equipar duas armas do mesmo tipo.",
			"~r~ERROR: ~w~It's not possible to equip two weapons of the same kind."));
		}

	    new bool:have_slot;

	    for(new i = 3; i < 7; i ++)
	    {
	        if(pCharacter[playerid][charSlot][i] == item)
			{
			    pInventory[playerid][invSelectedSlot] = slot;
                ShowMessageInventory(playerid, Translate(Player[playerid][Language],
				"~r~ERRO: ~w~Não é possivel equipar duas armas iguais.",
				"~r~ERROR: ~w~It's not possible to equip two identical weapons."));
			    have_slot = true;
			    break;
			}

	    	if(pCharacter[playerid][charSlot][i] == 0)
			{
			    AddItemCharacter(playerid, i, item, pInventory[playerid][invSlotAmount][slot]);
			    RemoveItemFromInventory(playerid, slot);
		    	have_slot = true;
                break;
			}
		}

		if(!have_slot)
		{
		    pInventory[playerid][invSelectedSlot] = slot;
		    ShowMessageInventory(playerid, Translate(Player[playerid][Language],
			"~r~ERRO: ~w~Não é possivel equipar mais armas.",
			"~r~ERROR: ~w~It's not possible to equip more weapons."));
		    return true;
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_BODY)
	{
	    if(pCharacter[playerid][charSlot][1] == 0)
		{
	    	AddItemCharacter(playerid, 1, item, 0, pInventory[playerid][invArmourStatus][slot]);
			RemoveItemFromInventory(playerid, slot);
		}
		else
		{
		    RemoveItemFromInventory(playerid, slot);
		    AddItem(playerid, pCharacter[playerid][charSlot][1], 1);
		    RemoveItemFromCharacter(playerid, 1);
		    AddItemCharacter(playerid, 1, item);
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_BACKPACK)
	{
	    if(pCharacter[playerid][charSlot][2] == 0)
		{
		    AddItemCharacter(playerid, 2, item);
			RemoveItemFromInventory(playerid, slot);
		}
		else
		{
		    RemoveItemFromInventory(playerid, slot);
		    AddItem(playerid, pCharacter[playerid][charSlot][2], 1);
		    RemoveItemFromCharacter(playerid, 2);
		    AddItemCharacter(playerid, 2, item);
		}

		OrganizeInventory(playerid);

		for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    	PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

        for(new i = 0; i < GetSlotsInventory(playerid); i++)
		{
			PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_modelo]);
	 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);

			PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
		}
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_AMMO)
	{
        pInventory[playerid][invSelectedSlot] = slot;
        return true;
	}
	else if(Itens[item][item_tipo] == ITEM_TYPE_NORMAL)
	{
	    if(item == 18) // Medic Kit
	    {
	        SetPlayerHealth(playerid, 100.0);
	        RemoveItemFromInventory(playerid, slot, 1);
	    }
	}

	if(Player[playerid][inInventory])
	{
	   	for(new a = 0; a < 4; a++)
		   	PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

		TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

		TextDrawHideForPlayer(playerid, inventario_usar);
		TextDrawHideForPlayer(playerid, inventario_split[0]);
		TextDrawHideForPlayer(playerid, inventario_split[1]);
		TextDrawHideForPlayer(playerid, inventario_drop[0]);
		TextDrawHideForPlayer(playerid, inventario_drop[1]);
		PlayerTextDrawHide(playerid, inventario_textos[playerid][9]);
	}

	return true;
}

//----------------------------------------------------------

stock AddItemCharacter(playerid, slot, itemid, quantidade = 0, Float:armourstatus = 0.0)
{
	if(itemid == 1)
	{
	    switch(GetPlayerSkin(playerid))
		{
		    #define HelmetAttach{%0,%1,%2,%3,%4,%5} SetPlayerAttachedObject(playerid, 0, 18645, 2, (%0), (%1), (%2), (%3), (%4), (%5));
			case 0, 65, 74, 149, 208, 273:  HelmetAttach{0.070000, 0.000000, 0.000000, 88.000000, 75.000000, 0.000000}
			case 1..6, 8, 14, 16, 22, 27, 29, 33, 41..49, 82..84, 86, 87, 119, 289: HelmetAttach{0.070000, 0.000000, 0.000000, 88.000000, 77.000000, 0.000000}
			case 7, 10: HelmetAttach{0.090000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
			case 9: HelmetAttach{0.059999, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
			case 11..13: HelmetAttach{0.070000, 0.019999, 0.000000, 88.000000, 90.000000, 0.000000}
			case 15: HelmetAttach{0.059999, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000}
			case 17..21: HelmetAttach{0.059999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 23..26, 28, 30..32, 34..39, 57, 58, 98, 99, 104..118, 120..131: HelmetAttach{0.079999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 40: HelmetAttach{0.050000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 50, 100..103, 148, 150..189, 222: HelmetAttach{0.070000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 51..54: HelmetAttach{0.100000, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 55, 56, 63, 64, 66..73, 75, 76, 78..81, 133..143, 147, 190..207, 209..219, 221, 247..272, 274..288, 290..293: HelmetAttach{0.070000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 59..62: HelmetAttach{0.079999, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 77: HelmetAttach{0.059999, 0.019999, 0.000000, 87.000000, 82.000000, 0.000000}
			case 85, 88, 89: HelmetAttach{0.070000, 0.039999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 90..97: HelmetAttach{0.050000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 132: HelmetAttach{0.000000, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 144..146: HelmetAttach{0.090000, 0.000000, 0.000000, 88.000000, 82.000000, 0.000000}
			case 220: HelmetAttach{0.029999, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 223, 246: HelmetAttach{0.070000, 0.050000, 0.000000, 88.000000, 82.000000, 0.000000}
			case 224..245: HelmetAttach{0.070000, 0.029999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 294: HelmetAttach{0.070000, 0.019999, 0.000000, 91.000000, 84.000000, 0.000000}
			case 295: HelmetAttach{0.050000, 0.019998, 0.000000, 86.000000, 82.000000, 0.000000}
			case 296..298: HelmetAttach{0.064999, 0.009999, 0.000000, 88.000000, 82.000000, 0.000000}
			case 299..306: HelmetAttach{0.064998, 0.019999, 0.000000, 88.000000, 82.000000, 0.000000}
		}
	}
	else if(Itens[itemid][item_tipo] == ITEM_TYPE_WEAPON || Itens[itemid][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
	    new modelid = Itens[itemid][item_modelo];

	    if(itemid == 5 || itemid == 17)
	        GivePlayerWeapon(playerid, GetWeaponIDFromModel(modelid), quantidade);
	    else
		    GivePlayerWeapon(playerid, GetWeaponIDFromModel(modelid), GetAmmunation(playerid));
	}
	else if(itemid == 6)
	{
	    SetPlayerArmour(playerid, armourstatus);
	    pCharacter[playerid][charArmourStatus] = armourstatus;

        switch(GetPlayerSkin(playerid))
		{
		    case 292:
				SetPlayerAttachedObject(playerid, 1, 19142, 1, 0.103999,0.034999,0.001000,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
	}
	else if(Itens[itemid][item_tipo] == ITEM_TYPE_BACKPACK)
	{
	    switch(GetPlayerSkin(playerid))
		{
		    case 292:
		        SetPlayerAttachedObject(playerid, 2, 3026,1,-0.129000,-0.078999,-0.003999,0.000000,0.000000,0.000000,1.000000,1.000000,1.000000);
		}
	}

	pCharacter[playerid][charSlot][slot] = itemid;

	PlayerPlaySound(playerid,1052,0.0,0.0,0.0);

    if(Player[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][slot], Itens[itemid][item_modelo]);
		PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][slot], Itens[itemid][item_previewrot][0], Itens[itemid][item_previewrot][1], Itens[itemid][item_previewrot][2], Itens[itemid][item_previewrot][3]);

	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][slot]);
	   	PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][slot]);
	}
}
//----------------------------------------------------------

stock RemoveItemFromInventory(playerid, slot, amount = 0)
{

    if(amount == 0)
    {
        pInventory[playerid][invSlot][slot] = 0;
		pInventory[playerid][invSlotAmount][slot] = 0;
	}
	else
	{
	    pInventory[playerid][invSlotAmount][slot] -= amount;

	    if(pInventory[playerid][invSlotAmount][slot] == 0)
	        pInventory[playerid][invSlot][slot] = 0;

	}

	if(Player[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][slot], Itens[pInventory[playerid][invSlot][slot]][item_modelo]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][slot], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][0], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][1], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][2], Itens[pInventory[playerid][invSlot][slot]][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][slot], 96);

		PlayerTextDrawHide(playerid, inventario_index[playerid][slot]);
		PlayerTextDrawShow(playerid, inventario_index[playerid][slot]);
	}
}

//----------------------------------------------------------

stock RemoveItemFromCharacter(playerid, slot)
{
	if(Itens[pCharacter[playerid][charSlot][slot]][item_tipo] == ITEM_TYPE_WEAPON)
	{
	    new modelid = Itens[pCharacter[playerid][charSlot][slot]][item_modelo];
	    SetPlayerAmmo(playerid, GetWeaponIDFromModel(modelid), 0);

        new itemid = Itens[pCharacter[playerid][charSlot][slot]][item_id];

        pCharacter[playerid][charSlot][slot] = 0;

	    if(itemid == 3 || itemid == 9)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 3))
     			RemovePlayerAttachedObject(playerid, 3);

        if(itemid == 10)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 4))
      			RemovePlayerAttachedObject(playerid, 4);

      	if(itemid == 2)
	    	if(IsPlayerAttachedObjectSlotUsed(playerid, 5))
      			RemovePlayerAttachedObject(playerid, 5);

	}
	else if(Itens[pCharacter[playerid][charSlot][slot]][item_tipo] == ITEM_TYPE_MELEEWEAPON)
	{
	    new modelid = Itens[pCharacter[playerid][charSlot][slot]][item_modelo];
	    RemovePlayerWeapon(playerid, GetWeaponIDFromModel(modelid));

	    if(IsPlayerAttachedObjectSlotUsed(playerid, 6))
      		RemovePlayerAttachedObject(playerid, 6);
	}

	if(slot == 0) // Helmet
	{
	    RemovePlayerAttachedObject(playerid, 0);
	}
	else if(slot == 1) // Armour
	{
	    RemovePlayerAttachedObject(playerid, 1);
	    SetPlayerArmour(playerid, 0);
	    pCharacter[playerid][charArmourStatus] = 0.0;
	}
	else if(slot == 2) // Backpack
	{
	    RemovePlayerAttachedObject(playerid, 2);
	    pCharacter[playerid][charSlot][slot] = 0;

	    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    	PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

        for(new i = 0; i < GetSlotsInventory(playerid); i++)
		{
			PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_modelo]);
	 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
	        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);

			PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
		}
	}

    pCharacter[playerid][charSlot][slot] = 0;
    PlayerPlaySound(playerid,1053,0.0,0.0,0.0);

    if(Player[playerid][inInventory])
	{
	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][slot], Itens[0][item_modelo]);
	 	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][slot], Itens[0][item_previewrot][0], Itens[0][item_previewrot][1], Itens[0][item_previewrot][2], Itens[0][item_previewrot][3]);
		PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][slot], 96);

	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][slot]);
	   	PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][slot]);

	   	PlayerTextDrawHide(playerid, inventario_textos[playerid][10]);
		TextDrawHideForPlayer(playerid, inventario_remover);
	}
}
//----------------------------------------------------------

stock DropItem(Float:x, Float:y, Float:z, itemid, amount, Float:armourstatus = 0.0)
{
    ItensWorld[LastItemID][world_timer] = TIMER_ITEM_WORLD;
	ItensWorld[LastItemID][world_itemid] = itemid;
	ItensWorld[LastItemID][world_model] = Itens[itemid][item_modelo];
	ItensWorld[LastItemID][world_amount] = amount;
	ItensWorld[LastItemID][world_position][0] = x;
	ItensWorld[LastItemID][world_position][1] = y;
	ItensWorld[LastItemID][world_position][2] = z;

	if(itemid == 6)
	    ItensWorld[LastItemID][world_armourstatus] = armourstatus;

    ItensWorld[LastItemID][world_object] = CreateObject(ItensWorld[LastItemID][world_model], x, y, z-0.90, -90,0,0);

	if(amount > 1)
		format(String, sizeof(String), "%s (%d)", Itens[itemid][item_nome], amount);
	else
		format(String, sizeof(String), "%s", Itens[itemid][item_nome]);

	ItensWorld[LastItemID][world_3dtext] = Create3DTextLabel(String, -1, x, y,z-0.90, 5.0, 0, 0);

	ItensWorld[LastItemID][world_active] = true;

	if(LastItemID == MAX_ITENS_WORLD-1)
		LastItemID = 0;
	else
	    LastItemID++;
}

//----------------------------------------------------------

stock DeleteItemWorld(worlditemid)
{
    ItensWorld[worlditemid][world_active] = false;
    DestroyObject(ItensWorld[worlditemid][world_object]);
    Delete3DTextLabel(ItensWorld[worlditemid][world_3dtext]);
}

//----------------------------------------------------------

stock IsItemInInventory(playerid, itemid, amount)
{
	new bool:sucess = false;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
         if(pInventory[playerid][invSlot][i] == itemid)
            if(pInventory[playerid][invSlotAmount][i] >= amount)
                sucess = true;

	if(!sucess)
	    return false;
	else
	    return true;
}

//----------------------------------------------------------

stock GetSlotsFree(playerid)
{
	new count = 0;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 0)
            count++;

	return count;
}

//----------------------------------------------------------

stock GetSlotsInUse(playerid)
{
    new count = 0;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] != 0)
            count++;

	return count;
}

//----------------------------------------------------------

stock IsInventoryFull(playerid)
{
    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 0)
            return false;

	return true;
}

//----------------------------------------------------------

stock GetSlotsInventory(playerid)
{
    new slots;

	if(pCharacter[playerid][charSlot][2] == 0)
	    slots = 5;
	else if(pCharacter[playerid][charSlot][2] == 7)
	    slots = 10;
    else if(pCharacter[playerid][charSlot][2] == 8)
	    slots = 15;

	return slots;
}

//----------------------------------------------------------

stock GetAmmunation(playerid)
{
	new total;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 4)
			total += pInventory[playerid][invSlotAmount][i];

	return total;
}

//----------------------------------------------------------

stock GetAmmunationSlot(playerid)
{
	new slot = -1;

    for(new i = 0; i < GetSlotsInventory(playerid); i ++)
        if(pInventory[playerid][invSlot][i] == 4)
        {
            slot = i;
            break;
		}

	return slot;
}

//----------------------------------------------------------

stock OrganizeInventory(playerid)
{
    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    if(pInventory[playerid][invSlot][i] != 0)
		    for(new a = 0; a < MAX_INVENTORY_SLOTS; a++)
		        if(pInventory[playerid][invSlot][a] == 0)
		        {
			        pInventory[playerid][invSlot][a] = pInventory[playerid][invSlot][i];
			        pInventory[playerid][invSlotAmount][a] = pInventory[playerid][invSlotAmount][i];
                    pInventory[playerid][invArmourStatus][a] = pInventory[playerid][invArmourStatus][i];
			        pInventory[playerid][invSlot][i] = 0;
			        pInventory[playerid][invSlotAmount][i] = 0;
			        pInventory[playerid][invArmourStatus][i] = 0;
				}
}

//----------------------------------------------------------

stock GetWeaponSlot(weaponid)
{
	new slot;

	switch(weaponid)
	{
		case 0,1: slot = 0;
		case 2 .. 9: slot = 1;
		case 10 .. 15: slot = 10;
		case 16 .. 18, 39: slot = 8;
		case 22 .. 24: slot =2;
		case 25 .. 27: slot = 3;
		case 28, 29, 32: slot = 4;
		case 30, 31: slot = 5;
		case 33, 34: slot = 6;
		case 35 .. 38: slot = 7;
		case 40: slot = 12;
		case 41 .. 43: slot = 9;
		case 44 .. 46: slot = 11;
	}

	return slot;
}

//----------------------------------------------------------

stock ShowInventory(playerid)
{
    Player[playerid][inInventory] = true;
    SelectTextDraw(playerid, 0xFFFFFFFF);

    // Globais

    TextDrawShowForPlayer(playerid, inventario_close[0]);
	TextDrawShowForPlayer(playerid, inventario_close[1]);

	for(new i = 0; i < 5; i++)
	    if(i != 4)
	    	TextDrawShowForPlayer(playerid, inventario_backgrounds[i]);

	// Player

	for(new i = 0; i < GetSlotsInventory(playerid); i++)
	{
		PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_modelo]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][i], Itens[pInventory[playerid][invSlot][i]][item_previewrot][0], Itens[pInventory[playerid][invSlot][i]][item_previewrot][1], Itens[pInventory[playerid][invSlot][i]][item_previewrot][2], Itens[pInventory[playerid][invSlot][i]][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][i], 96);

		PlayerTextDrawShow(playerid, inventario_index[playerid][i]);
	}

	PlayerTextDrawSetString(playerid, inventario_textos[playerid][0], Translate(Player[playerid][Language], "Personagem", "Character"));
	PlayerTextDrawSetString(playerid, inventario_textos[playerid][1], Translate(Player[playerid][Language], ConvertToGameText("Seu Inventário"), "Your Inventory"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][2], Translate(Player[playerid][Language], ConvertToGameText("Cabeça"), "Head"));
	PlayerTextDrawSetString(playerid, inventario_textos[playerid][3], Translate(Player[playerid][Language], "Mochila", "Backpack"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][4], Translate(Player[playerid][Language], "Corpo", "Body"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][5], Translate(Player[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][6], Translate(Player[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][7], Translate(Player[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][8], Translate(Player[playerid][Language], "Arma", "Weapon"));
    PlayerTextDrawSetString(playerid, inventario_textos[playerid][9], Translate(Player[playerid][Language], "Usar", "Use"));

	for(new i = 0; i < 11; i++)
	    if(i != 10 && i != 9)
	    	PlayerTextDrawShow(playerid, inventario_textos[playerid][i]);

	for(new i = 0; i < 7; i++)
	{
	    new char_slot = pCharacter[playerid][charSlot][i];

	    PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][i], Itens[char_slot][item_modelo]);
 		PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][i], Itens[char_slot][item_previewrot][0], Itens[char_slot][item_previewrot][1], Itens[char_slot][item_previewrot][2], Itens[char_slot][item_previewrot][3]);
        PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][i], 96);

	    PlayerTextDrawShow(playerid, inventario_personagemindex[playerid][i]);
	}

	PlayerTextDrawSetPreviewModel(playerid, inventario_skin[playerid], GetPlayerSkin(playerid));
	PlayerTextDrawShow(playerid, inventario_skin[playerid]);
}

//----------------------------------------------------------

stock HideInventory(playerid)
{
	TextDrawHideForPlayer(playerid, inventario_usar);
	TextDrawHideForPlayer(playerid, inventario_split[0]);
	TextDrawHideForPlayer(playerid, inventario_split[1]);
	TextDrawHideForPlayer(playerid, inventario_drop[0]);
	TextDrawHideForPlayer(playerid, inventario_drop[1]);
	TextDrawHideForPlayer(playerid, inventario_close[0]);
	TextDrawHideForPlayer(playerid, inventario_close[1]);

	for(new i = 0; i < 5; i++)
	    if(i != 4)
	    	TextDrawHideForPlayer(playerid, inventario_backgrounds[i]);

    for(new i = 0; i < MAX_INVENTORY_SLOTS; i++)
	    PlayerTextDrawHide(playerid, inventario_index[playerid][i]);

    for(new i = 0; i < 11; i++)
	    PlayerTextDrawHide(playerid, inventario_textos[playerid][i]);

	for(new i = 0; i < 7; i++)
	    PlayerTextDrawHide(playerid, inventario_personagemindex[playerid][i]);

	PlayerTextDrawHide(playerid, inventario_skin[playerid]);
	TextDrawHideForPlayer(playerid, inventario_remover);

	TextDrawHideForPlayer(playerid, inventario_backgrounds[4]);

	for(new a = 0; a < 4; a++)
    	PlayerTextDrawHide(playerid, inventario_description[playerid][a]);

    pInventory[playerid][invSelectedSlot] = -1;
    pCharacter[playerid][charSelectedSlot] = -1;
    Player[playerid][inInventory] = false;
    CancelSelectTextDraw(playerid);
}

//----------------------------------------------------------

stock GetWeaponIDFromModel(modelid)
{
    new idweapon;

    switch(modelid)
	{
       	case 331: idweapon = 1; // Brass Knuckles
       	case 333: idweapon = 2; // Golf Club
       	case 334: idweapon = 3; // Nightstick
      	case 335: idweapon = 4; // Knife
       	case 336: idweapon = 5; // Baseball Bat
       	case 337: idweapon = 6; // Shovel
       	case 338: idweapon = 7; // Pool Cue
       	case 339: idweapon = 8; // Katana
       	case 341: idweapon = 9; // Chainsaw
       	case 321: idweapon = 10; // Double-ended Dildo
       	case 325: idweapon = 14; // Flowers
       	case 326: idweapon = 15; // Cane
       	case 342: idweapon = 16; // Grenade
       	case 343: idweapon = 17; // Tear Gas
       	case 344: idweapon = 18; // Molotov Cocktail
       	case 346: idweapon = 22; // 9mm
       	case 347: idweapon = 23; // Silenced 9mm
       	case 348: idweapon = 24; // Desert Eagle
       	case 349: idweapon = 25; // Shotgun
       	case 350: idweapon = 26; // Sawnoff
       	case 351: idweapon = 27; // Combat Shotgun
       	case 352: idweapon = 28; // Micro SMG/Uzi
       	case 353: idweapon = 29; // MP5
       	case 355: idweapon = 30; // AK-47
       	case 356: idweapon = 31; // M4
       	case 372: idweapon = 32; // Tec-9
       	case 357: idweapon = 33; // Country Rifle
       	case 358: idweapon = 34; // Sniper Rifle
       	case 359: idweapon = 35; // RPG
       	case 360: idweapon = 36; // HS Rocket
       	case 361: idweapon = 37; // Flamethrower
       	case 362: idweapon = 38; // Minigun
       	case 363: idweapon = 39;// Satchel Charge + Detonator
       	case 365: idweapon = 41; // Spraycan
       	case 366: idweapon = 42; // Fire Extinguisher
	}

	return idweapon;
}

//----------------------------------------------------------

stock RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12];
	new plyAmmo[12];

	for(new slot = 0; slot != 12; slot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, slot, wep, ammo);

		if(wep != weaponid)
		{
			GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
		}
	}

	ResetPlayerWeapons(playerid);
	for(new slot = 0; slot != 12; slot++)
	{
		GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
	}
}

//----------------------------------------------------------

public Float:GetPlayerArmourEx(playerid)
{
	new Float:pColete;
	GetPlayerArmour(playerid, pColete);
	return Float:pColete;
}
//----------------------------------------------------------

stock ShowMessageInventory(playerid, string[], time = 5000)
{
	if (Player[playerid][MessageInventory])
	{
	    PlayerTextDrawHide(playerid, inventario_mensagem[playerid]);
	    KillTimer(Player[playerid][MessageInventoryTimer]);
	}

	PlayerTextDrawSetString(playerid, inventario_mensagem[playerid], ConvertToGameText(string));
	PlayerTextDrawShow(playerid, inventario_mensagem[playerid]);

	Player[playerid][MessageInventory] = true;
	Player[playerid][MessageInventoryTimer] = SetTimerEx("HideMessageInventory", time, false, "d", playerid);
	return true;
}

//----------------------------------------------------------

public HideMessageInventory(playerid)
{
	if (!Player[playerid][MessageInventory])
	    return 0;

	Player[playerid][MessageInventory] = false;
	return PlayerTextDrawHide(playerid, inventario_mensagem[playerid]);
}

//----------------------------------------------------------

stock ConvertToGameText(in[])
{
    new string[256];
    for(new i = 0; in[i]; ++i)
    {
        string[i] = in[i];
        switch(string[i])
        {
            case 0xC0 .. 0xC3: string[i] -= 0x40;
            case 0xC7 .. 0xC9: string[i] -= 0x42;
            case 0xD2 .. 0xD5: string[i] -= 0x44;
            case 0xD9 .. 0xDC: string[i] -= 0x47;
            case 0xE0 .. 0xE3: string[i] -= 0x49;
            case 0xE7 .. 0xEF: string[i] -= 0x4B;
            case 0xF2 .. 0xF5: string[i] -= 0x4D;
            case 0xF9 .. 0xFC: string[i] -= 0x50;
            case 0xC4, 0xE4: string[i] = 0x83;
            case 0xC6, 0xE6: string[i] = 0x84;
            case 0xD6, 0xF6: string[i] = 0x91;
            case 0xD1, 0xF1: string[i] = 0xEC;
            case 0xDF: string[i] = 0x96;
            case 0xBF: string[i] = 0xAF;
        }
    }
    return string;
}

//----------------------------------------------------------

stock ResetVariables(playerid)
{
    // Inventory

    for(new i = 0; i < MAX_INVENTORY_SLOTS; i ++)
    {
        pInventory[playerid][invSlot][i] = 0;
        pInventory[playerid][invSlotAmount][i] = 0;
        pInventory[playerid][invArmourStatus][i] = 0;
	}

	pInventory[playerid][invSelectedSlot] = 0;

	// Character

	for(new i = 0; i < 7; i ++)
        pCharacter[playerid][charSlot][i] = 0;

	pCharacter[playerid][charArmourStatus] = 0;
	pCharacter[playerid][charSelectedSlot] = 0;


	// Player

	for(new enum_Player:i; i < enum_Player; ++i)
	    Player[playerid][i] = 0;
}

//----------------------------------------------------------

stock Translate(language, text_PT[], text_EN[])
{
    new string[256];

    if(language == 1)
        format(string, sizeof(string), text_PT);
    else if(language == 2)
        format(string, sizeof(string), text_EN);

    return string;
}

//----------------------------------------------------------


CMD:additem(playerid, params[])
{
    new
	    id, item, amount;

	if(sscanf(params, "uii", id, item, amount))
		return SendClientMessage(playerid, -1, "/additem <id/nick> <id do item> <quantidade>");

   	AddItem(id, item, amount);

   	if(IsItemInInventory(playerid, item, amount))
   	    return false;

	format(String, sizeof(String), "additem (%d) (%d) (%d)", id, item, amount);
	SendClientMessage(playerid, -1, String);
	return true;
}

//----------------------------------------------------------

stock LoadTextDraws()
{
    inventario_backgrounds[0] = TextDrawCreate(63.900207, 120.000030, "box");
	TextDrawLetterSize(inventario_backgrounds[0], 0.000000, 28.450004);
	TextDrawTextSize(inventario_backgrounds[0], 308.250335, 0.000000);
	TextDrawAlignment(inventario_backgrounds[0], 1);
	TextDrawColor(inventario_backgrounds[0], -1);
	TextDrawUseBox(inventario_backgrounds[0], 1);
	TextDrawBoxColor(inventario_backgrounds[0], 128);
	TextDrawSetShadow(inventario_backgrounds[0], 0);
	TextDrawSetOutline(inventario_backgrounds[0], 0);
	TextDrawBackgroundColor(inventario_backgrounds[0], 255);
	TextDrawFont(inventario_backgrounds[0], 2);
	TextDrawSetProportional(inventario_backgrounds[0], 1);
	TextDrawSetShadow(inventario_backgrounds[0], 0);

	inventario_backgrounds[1] = TextDrawCreate(313.099792, 120.000030, "box");
	TextDrawLetterSize(inventario_backgrounds[1], 0.000000, 28.450004);
	TextDrawTextSize(inventario_backgrounds[1], 578.247741, 0.000000);
	TextDrawAlignment(inventario_backgrounds[1], 1);
	TextDrawColor(inventario_backgrounds[1], -1);
	TextDrawUseBox(inventario_backgrounds[1], 1);
	TextDrawBoxColor(inventario_backgrounds[1], 128);
	TextDrawSetShadow(inventario_backgrounds[1], 0);
	TextDrawSetOutline(inventario_backgrounds[1], 0);
	TextDrawBackgroundColor(inventario_backgrounds[1], 255);
	TextDrawFont(inventario_backgrounds[1], 1);
	TextDrawSetProportional(inventario_backgrounds[1], 1);
	TextDrawSetShadow(inventario_backgrounds[1], 0);

	inventario_backgrounds[2] = TextDrawCreate(66.100158, 122.233367, "box");
	TextDrawLetterSize(inventario_backgrounds[2], 0.000000, 1.200001);
	TextDrawTextSize(inventario_backgrounds[2], 306.499542, 0.000000);
	TextDrawAlignment(inventario_backgrounds[2], 1);
	TextDrawColor(inventario_backgrounds[2], -1);
	TextDrawUseBox(inventario_backgrounds[2], 1);
	TextDrawBoxColor(inventario_backgrounds[2], 128);
	TextDrawSetShadow(inventario_backgrounds[2], 0);
	TextDrawSetOutline(inventario_backgrounds[2], 0);
	TextDrawBackgroundColor(inventario_backgrounds[2], 255);
	TextDrawFont(inventario_backgrounds[2], 1);
	TextDrawSetProportional(inventario_backgrounds[2], 1);
	TextDrawSetShadow(inventario_backgrounds[2], 0);

	inventario_backgrounds[3] = TextDrawCreate(314.599426, 122.233375, "box");
	TextDrawLetterSize(inventario_backgrounds[3], 0.000000, 1.200001);
	TextDrawTextSize(inventario_backgrounds[3], 576.602294, 0.000000);
	TextDrawAlignment(inventario_backgrounds[3], 1);
	TextDrawColor(inventario_backgrounds[3], -1);
	TextDrawUseBox(inventario_backgrounds[3], 1);
	TextDrawBoxColor(inventario_backgrounds[3], 128);
	TextDrawSetShadow(inventario_backgrounds[3], 0);
	TextDrawSetOutline(inventario_backgrounds[3], 0);
	TextDrawBackgroundColor(inventario_backgrounds[3], 255);
	TextDrawFont(inventario_backgrounds[3], 1);
	TextDrawSetProportional(inventario_backgrounds[3], 1);
	TextDrawSetShadow(inventario_backgrounds[3], 0);

	inventario_backgrounds[4] = TextDrawCreate(317.000000, 314.434112, "box");
	TextDrawLetterSize(inventario_backgrounds[4], 0.000000, 6.285005);
	TextDrawTextSize(inventario_backgrounds[4], 499.247772, 0.000000);
	TextDrawAlignment(inventario_backgrounds[4], 1);
	TextDrawColor(inventario_backgrounds[4], -1);
	TextDrawUseBox(inventario_backgrounds[4], 1);
	TextDrawBoxColor(inventario_backgrounds[4], 128);
	TextDrawSetShadow(inventario_backgrounds[4], 0);
	TextDrawSetOutline(inventario_backgrounds[4], 0);
	TextDrawBackgroundColor(inventario_backgrounds[4], 255);
	TextDrawFont(inventario_backgrounds[4], 1);
	TextDrawSetProportional(inventario_backgrounds[4], 1);
	TextDrawSetShadow(inventario_backgrounds[4], 0);

    inventario_usar = TextDrawCreate(504.388427, 312.249938, "");
	TextDrawLetterSize(inventario_usar, 0.000000, 0.000000);
	TextDrawTextSize(inventario_usar, 71.019790, 18.579967);
	TextDrawAlignment(inventario_usar, 1);
	TextDrawColor(inventario_usar, -1);
	TextDrawSetShadow(inventario_usar, 0);
	TextDrawSetOutline(inventario_usar, 0);
	TextDrawBackgroundColor(inventario_usar, 866792304);
	TextDrawFont(inventario_usar, 5);
	TextDrawSetProportional(inventario_usar, 0);
	TextDrawSetShadow(inventario_usar, 0);
	TextDrawSetPreviewModel(inventario_usar, 19382);
	TextDrawSetPreviewRot(inventario_usar, 0.000000, 0.000000, 0.000000, 1.000000);
	TextDrawSetSelectable(inventario_usar, true);

    inventario_split[0] = TextDrawCreate(504.593688, 333.316314, "");
	TextDrawLetterSize(inventario_split[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_split[0], 71.019790, 18.579967);
	TextDrawAlignment(inventario_split[0], 1);
	TextDrawColor(inventario_split[0], -1);
	TextDrawSetShadow(inventario_split[0], 0);
	TextDrawSetOutline(inventario_split[0], 0);
	TextDrawBackgroundColor(inventario_split[0], -65472);
	TextDrawFont(inventario_split[0], 5);
	TextDrawSetProportional(inventario_split[0], 0);
	TextDrawSetShadow(inventario_split[0], 0);
	TextDrawSetSelectable(inventario_split[0], true);
	TextDrawSetPreviewModel(inventario_split[0], 19382);
	TextDrawSetPreviewRot(inventario_split[0], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_drop[0] = TextDrawCreate(504.793701, 354.617614, "");
	TextDrawLetterSize(inventario_drop[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_drop[0], 71.019790, 18.579967);
	TextDrawAlignment(inventario_drop[0], 1);
	TextDrawColor(inventario_drop[0], -1);
	TextDrawSetShadow(inventario_drop[0], 0);
	TextDrawSetOutline(inventario_drop[0], 0);
	TextDrawBackgroundColor(inventario_drop[0], 0xAA333370);
	TextDrawFont(inventario_drop[0], 5);
	TextDrawSetProportional(inventario_drop[0], 0);
	TextDrawSetShadow(inventario_drop[0], 0);
	TextDrawSetSelectable(inventario_drop[0], true);
	TextDrawSetPreviewModel(inventario_drop[0], 19382);
	TextDrawSetPreviewRot(inventario_drop[0], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_remover = TextDrawCreate(149.847900, 344.867553, "");
	TextDrawLetterSize(inventario_remover, 0.000000, 0.000000);
	TextDrawTextSize(inventario_remover, 76.040008, 19.899997);
	TextDrawAlignment(inventario_remover, 1);
	TextDrawColor(inventario_remover, -1);
	TextDrawSetShadow(inventario_remover, 0);
	TextDrawSetOutline(inventario_remover, 0);
	TextDrawBackgroundColor(inventario_remover, 0xAA333370);
	TextDrawFont(inventario_remover, 5);
	TextDrawSetProportional(inventario_remover, 0);
	TextDrawSetShadow(inventario_remover, 0);
	TextDrawSetSelectable(inventario_remover, true);
	TextDrawSetPreviewModel(inventario_remover, 19382);
	TextDrawSetPreviewRot(inventario_remover, 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_split[1] = TextDrawCreate(540.294372, 334.449981, "split");
	TextDrawLetterSize(inventario_split[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_split[1], 2);
	TextDrawColor(inventario_split[1], -1);
	TextDrawSetShadow(inventario_split[1], 0);
	TextDrawSetOutline(inventario_split[1], 0);
	TextDrawBackgroundColor(inventario_split[1], 255);
	TextDrawFont(inventario_split[1], 2);
	TextDrawSetProportional(inventario_split[1], 1);
	TextDrawSetShadow(inventario_split[1], 0);
	TextDrawSetSelectable(inventario_split[1], false);

	inventario_drop[1] = TextDrawCreate(540.762878, 355.451263, "drop");
	TextDrawLetterSize(inventario_drop[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_drop[1], 2);
	TextDrawColor(inventario_drop[1], -1);
	TextDrawSetShadow(inventario_drop[1], 0);
	TextDrawSetOutline(inventario_drop[1], 0);
	TextDrawBackgroundColor(inventario_drop[1], 255);
	TextDrawFont(inventario_drop[1], 2);
	TextDrawSetProportional(inventario_drop[1], 1);
	TextDrawSetShadow(inventario_drop[1], 0);
	TextDrawSetSelectable(inventario_drop[1], false);

	inventario_close[1] = TextDrawCreate(565.100341, 119.433311, "X");
	TextDrawTextSize(inventario_close[1], 574.999511, 0.000000);
	TextDrawLetterSize(inventario_close[1], 0.400000, 1.600000);
	TextDrawAlignment(inventario_close[1], 1);
	TextDrawColor(inventario_close[1], -1);
	TextDrawSetShadow(inventario_close[1], 0);
	TextDrawSetOutline(inventario_close[1], 0);
	TextDrawBackgroundColor(inventario_close[1], 255);
	TextDrawFont(inventario_close[1], 2);
	TextDrawSetProportional(inventario_close[1], 1);
	TextDrawSetShadow(inventario_close[1], 0);
	TextDrawSetSelectable(inventario_close[1], true);

	inventario_close[0] = TextDrawCreate(564.079284, 120.583320, "");
	TextDrawLetterSize(inventario_close[0], 0.000000, 0.000000);
	TextDrawTextSize(inventario_close[0], 14.000000, 14.000000);
	TextDrawAlignment(inventario_close[0], 1);
	TextDrawColor(inventario_close[0], -1);
	TextDrawSetShadow(inventario_close[0], 0);
	TextDrawSetOutline(inventario_close[0], 0);
	TextDrawBackgroundColor(inventario_close[0], 80);
	TextDrawFont(inventario_close[0], 5);
	TextDrawSetProportional(inventario_close[0], 0);
	TextDrawSetShadow(inventario_close[0], 0);
	TextDrawSetSelectable(inventario_close[0], true);
	TextDrawSetPreviewModel(inventario_close[0], 19382);
	TextDrawSetPreviewRot(inventario_close[0], 0.000000, 0.000000, 0.000000, 1.000000);

}

//----------------------------------------------------------

LoadPlayerTextDraws(playerid)
{
    inventario_index[playerid][0] = CreatePlayerTextDraw(playerid, 315.500152, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][0], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][0], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][0], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][0], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][0], 0.000000, -30, 0.000000, 2.2);

	inventario_index[playerid][1] = CreatePlayerTextDraw(playerid, 368.803405, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][1], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][1], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][1], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][1], 0.000000, -30, 0.000000, 2.2);

    inventario_index[playerid][10] = CreatePlayerTextDraw(playerid, 315.500152, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][10], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][10], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][10], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][10], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][10], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][5] = CreatePlayerTextDraw(playerid, 315.500152, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][5], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][5], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][5], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][5], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][2] = CreatePlayerTextDraw(playerid, 422.506683, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][2], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][2], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][2], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][3] = CreatePlayerTextDraw(playerid, 475.509918, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][3], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][3], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][3], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][3], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][4] = CreatePlayerTextDraw(playerid, 528.508117, 150.692352, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][4], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][4], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][4], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][4], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][6] = CreatePlayerTextDraw(playerid, 368.903411, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][6], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][6], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][6], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][6], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][7] = CreatePlayerTextDraw(playerid, 422.406677, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][7], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][7], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][7], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][7], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][7], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][8] = CreatePlayerTextDraw(playerid, 476.009948, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][8], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][8], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][8], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][8], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][8], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][9] = CreatePlayerTextDraw(playerid, 528.908020, 201.795471, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][9], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][9], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][9], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][9], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][9], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][11] = CreatePlayerTextDraw(playerid, 369.203430, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][11], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][11], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][11], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][11], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][11], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][11], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][12] = CreatePlayerTextDraw(playerid, 422.806701, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][12] , 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][12] , 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][12] , 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][12] , -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][12] , 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][12] , 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][12], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][12], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][12], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][13] = CreatePlayerTextDraw(playerid, 476.209960, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][13], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][13], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][13], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][13], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][13], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][13], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][13], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_index[playerid][14] = CreatePlayerTextDraw(playerid, 529.507873, 253.698638, "");
	PlayerTextDrawLetterSize(playerid, inventario_index[playerid][14], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_index[playerid][14], 46.000000, 45.000000);
	PlayerTextDrawAlignment(playerid, inventario_index[playerid][14], 1);
	PlayerTextDrawColor(playerid, inventario_index[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_index[playerid][14], 96);
	PlayerTextDrawFont(playerid, inventario_index[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, inventario_index[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid,inventario_index[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_index[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_index[playerid][14], 19382);
	PlayerTextDrawSetPreviewRot(playerid, inventario_index[playerid][14], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_skin[playerid] = CreatePlayerTextDraw(playerid, 73.300109, 138.366668, "");
	PlayerTextDrawLetterSize(playerid, inventario_skin[playerid], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_skin[playerid], 227.000000, 202.000000);
	PlayerTextDrawAlignment(playerid, inventario_skin[playerid], 1);
	PlayerTextDrawColor(playerid, inventario_skin[playerid], -1);
	PlayerTextDrawSetShadow(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_skin[playerid], 43520);
	PlayerTextDrawFont(playerid, inventario_skin[playerid], 5);
	PlayerTextDrawSetProportional(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetShadow(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_skin[playerid], 0);
	PlayerTextDrawSetPreviewRot(playerid, inventario_skin[playerid], 0.000000, 0.000000, 0.000000, 1.000000);

    inventario_textos[playerid][0] = CreatePlayerTextDraw(playerid, 68.199996, 120.716636, "personagem");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][0], 0.326999, 1.284999);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][0], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][0], 0);

	inventario_textos[playerid][1] = CreatePlayerTextDraw(playerid, 315.710540, 120.716636, ConvertToGameText("Seu inventário"));
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][1], 0.326999, 1.284999);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][1], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][1], 0);

	inventario_textos[playerid][2] = CreatePlayerTextDraw(playerid, 248.200164, 144.800033, ConvertToGameText("Cabeça"));
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][2], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][2], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][2], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][2], 0);

	inventario_textos[playerid][3] = CreatePlayerTextDraw(playerid, 247.399932, 189.833389, "mochila");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][3], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][3], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][3], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][3], 0);

	inventario_textos[playerid][4] = CreatePlayerTextDraw(playerid, 128.199707, 180.250152, "corpo");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][4], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][4], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][4], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][4], 0);

	inventario_textos[playerid][5] = CreatePlayerTextDraw(playerid, 127.499824, 232.683532, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][5], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][5], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][5], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][5], 0);

	inventario_textos[playerid][6] = CreatePlayerTextDraw(playerid, 247.099945, 236.100448, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][6], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][6], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][6], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][6], 0);

	inventario_textos[playerid][7] = CreatePlayerTextDraw(playerid, 246.600036, 285.667083, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][7], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][7], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][7], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][7], 0);

	inventario_textos[playerid][8] = CreatePlayerTextDraw(playerid, 127.800155, 284.950317, "arma");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][8], 0.172995, 0.870832);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][8], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][8], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][8], 0);

	inventario_description[playerid][0] = CreatePlayerTextDraw(playerid, 317.699981, 314.833312, "");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_description[playerid][0], 65.000000, 56.000000);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][0], -208);
	PlayerTextDrawFont(playerid, inventario_description[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_description[playerid][0], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_description[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
    PlayerTextDrawSetSelectable(playerid, inventario_description[playerid][0], true);

	inventario_description[playerid][1] = CreatePlayerTextDraw(playerid, 388.099884, 314.099884, "CAPACETE");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][1], 0.290499, 1.226665);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][1], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][1], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][1], 0);

	inventario_description[playerid][2] = CreatePlayerTextDraw(playerid, 388.699920, 330.400878, "PROTEGE_CONTRA_HEADSHOTS");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][2], 0.157499, 0.882498);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_description[playerid][2], -168430192);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][2], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][2], 0);

	inventario_description[playerid][3] = CreatePlayerTextDraw(playerid, 499.401489, 363.984985, "QUANTIDADE:_1");
	PlayerTextDrawLetterSize(playerid, inventario_description[playerid][3], 0.157499, 0.882498);
	PlayerTextDrawAlignment(playerid, inventario_description[playerid][3], 3);
	PlayerTextDrawColor(playerid, inventario_description[playerid][3], -168430208);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_description[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_description[playerid][3], 255);
	PlayerTextDrawFont(playerid, inventario_description[playerid][3], 2);
	PlayerTextDrawSetProportional(playerid, inventario_description[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, inventario_description[playerid][3], 0);

	inventario_textos[playerid][9] = CreatePlayerTextDraw(playerid, 540.294372, 313.548706, "usar");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][9], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][9], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][9], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_textos[playerid][9], false);

    inventario_personagemindex[playerid][0] = CreatePlayerTextDraw(playerid, 231.000305, 153.250015, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][0], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][0], 33.000000, 32.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][0], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][0], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][0], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][0], 0.000000, 0.000000, 0.000000, 1.000000);
    PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][0], true);

	inventario_personagemindex[playerid][1] = CreatePlayerTextDraw(playerid, 110.600074, 189.283264, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][1], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][1], 33.000000, 32.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][1], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][1], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][1], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][1], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][2] = CreatePlayerTextDraw(playerid, 230.500000, 198.749984, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][2], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][2], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][2], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][2], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][3] = CreatePlayerTextDraw(playerid, 110.400032, 242.366851, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][3], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][3], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][3], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][3], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][3], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][4] = CreatePlayerTextDraw(playerid, 230.405273, 244.750305, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][4], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][4], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][4], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][4], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][4], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][5] = CreatePlayerTextDraw(playerid, 230.505279, 294.150360, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][5], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][5], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][5], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][5], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][5], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_personagemindex[playerid][6] = CreatePlayerTextDraw(playerid, 110.400032, 294.070007, "");
	PlayerTextDrawLetterSize(playerid, inventario_personagemindex[playerid][6], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, inventario_personagemindex[playerid][6], 33.000000, 36.000000);
	PlayerTextDrawAlignment(playerid, inventario_personagemindex[playerid][6], 1);
	PlayerTextDrawColor(playerid, inventario_personagemindex[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_personagemindex[playerid][6], 112);
	PlayerTextDrawFont(playerid, inventario_personagemindex[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, inventario_personagemindex[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, inventario_personagemindex[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, inventario_personagemindex[playerid][6], 18645);
	PlayerTextDrawSetPreviewRot(playerid, inventario_personagemindex[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	inventario_textos[playerid][10] = CreatePlayerTextDraw(playerid, 187.721237, 347.616729, "remover");
	PlayerTextDrawLetterSize(playerid, inventario_textos[playerid][10], 0.325504, 1.407498);
	PlayerTextDrawAlignment(playerid, inventario_textos[playerid][10], 2);
	PlayerTextDrawColor(playerid, inventario_textos[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, inventario_textos[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, inventario_textos[playerid][10], 255);
	PlayerTextDrawFont(playerid, inventario_textos[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, inventario_textos[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, inventario_textos[playerid][10], 0);

	inventario_mensagem[playerid] = CreatePlayerTextDraw(playerid, 321.224029, 381.983398, "error_msg");
	PlayerTextDrawLetterSize(playerid, inventario_mensagem[playerid], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, inventario_mensagem[playerid], 2);
	PlayerTextDrawColor(playerid, inventario_mensagem[playerid], -2147483393);
	PlayerTextDrawSetShadow(playerid, inventario_mensagem[playerid], 0);
	PlayerTextDrawSetOutline(playerid, inventario_mensagem[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, inventario_mensagem[playerid], 255);
	PlayerTextDrawFont(playerid, inventario_mensagem[playerid], 2);
	PlayerTextDrawSetProportional(playerid, inventario_mensagem[playerid], 1);
	PlayerTextDrawSetShadow(playerid, inventario_mensagem[playerid], 0);

}

//----------------------------------------------------------