#include <a_samp>
// Map-radar of players by O.K.Style™
new Text:Map[5], Text:Player[MAX_PLAYERS], Text:Stats[MAX_PLAYERS];
new Text:Test;
new PlayerRainbowColors[511] = {
/*OKStyle*/ 0x000022FF, 0x000044FF, 0x000066FF, 0x000088FF, 0x0000AAFF, 0x0000CCFF, 0x0000EEFF,
0x002200FF, 0x002222FF, 0x002244FF, 0x002266FF, 0x002288FF, 0x0022AAFF, 0x0022CCFF, 0x0022EEFF,
0x004400FF, 0x004422FF, 0x004444FF, 0x004466FF, 0x004488FF, 0x0044AAFF, 0x0044CCFF, 0x0044EEFF,
0x006600FF, 0x006622FF, 0x006644FF, 0x006666FF, 0x006688FF, 0x0066AAFF, 0x0066CCFF, 0x0066EEFF,
0x008800FF, 0x008822FF, 0x008844FF, 0x008866FF, 0x008888FF, 0x0088AAFF, 0x0088CCFF, 0x0088EEFF,
0x00AA00FF, 0x00AA22FF, 0x00AA44FF, 0x00AA66FF, 0x00AA88FF, 0x00AAAAFF, 0x00AACCFF, 0x00AAEEFF,
0x00CC00FF, 0x00CC22FF, 0x00CC44FF, 0x00CC66FF, 0x00CC88FF, 0x00CCAAFF, 0x00CCCCFF, 0x00CCEEFF,
0x00EE00FF, 0x00EE22FF, 0x00EE44FF, 0x00EE66FF, 0x00EE88FF, 0x00EEAAFF, 0x00EECCFF, 0x00EEEEFF,

0x220000FF, 0x220022FF, 0x220044FF, 0x220066FF, 0x220088FF, 0x2200AAFF, 0x2200CCFF, 0x2200FFFF,
0x222200FF, 0x222222FF, 0x222244FF, 0x222266FF, 0x222288FF, 0x2222AAFF, 0x2222CCFF, 0x2222EEFF,
0x224400FF, 0x224422FF, 0x224444FF, 0x224466FF, 0x224488FF, 0x2244AAFF, 0x2244CCFF, 0x2244EEFF,
0x226600FF, 0x226622FF, 0x226644FF, 0x226666FF, 0x226688FF, 0x2266AAFF, 0x2266CCFF, 0x2266EEFF,
0x228800FF, 0x228822FF, 0x228844FF, 0x228866FF, 0x228888FF, 0x2288AAFF, 0x2288CCFF, 0x2288EEFF,
0x22AA00FF, 0x22AA22FF, 0x22AA44FF, 0x22AA66FF, 0x22AA88FF, 0x22AAAAFF, 0x22AACCFF, 0x22AAEEFF,
0x22CC00FF, 0x22CC22FF, 0x22CC44FF, 0x22CC66FF, 0x22CC88FF, 0x22CCAAFF, 0x22CCCCFF, 0x22CCEEFF,
0x22EE00FF, 0x22EE22FF, 0x22EE44FF, 0x22EE66FF, 0x22EE88FF, 0x22EEAAFF, 0x22EECCFF, 0x22EEEEFF,

0x440000FF, 0x440022FF, 0x440044FF, 0x440066FF, 0x440088FF, 0x4400AAFF, 0x4400CCFF, 0x4400FFFF,
0x442200FF, 0x442222FF, 0x442244FF, 0x442266FF, 0x442288FF, 0x4422AAFF, 0x4422CCFF, 0x4422EEFF,
0x444400FF, 0x444422FF, 0x444444FF, 0x444466FF, 0x444488FF, 0x4444AAFF, 0x4444CCFF, 0x4444EEFF,
0x446600FF, 0x446622FF, 0x446644FF, 0x446666FF, 0x446688FF, 0x4466AAFF, 0x4466CCFF, 0x4466EEFF,
0x448800FF, 0x448822FF, 0x448844FF, 0x448866FF, 0x448888FF, 0x4488AAFF, 0x4488CCFF, 0x4488EEFF,
0x44AA00FF, 0x44AA22FF, 0x44AA44FF, 0x44AA66FF, 0x44AA88FF, 0x44AAAAFF, 0x44AACCFF, 0x44AAEEFF,
0x44CC00FF, 0x44CC22FF, 0x44CC44FF, 0x44CC66FF, 0x44CC88FF, 0x44CCAAFF, 0x44CCCCFF, 0x44CCEEFF,
0x44EE00FF, 0x44EE22FF, 0x44EE44FF, 0x44EE66FF, 0x44EE88FF, 0x44EEAAFF, 0x44EECCFF, 0x44EEEEFF,

0x660000FF, 0x660022FF, 0x660044FF, 0x660066FF, 0x660088FF, 0x6600AAFF, 0x6600CCFF, 0x6600FFFF,
0x662200FF, 0x662222FF, 0x662244FF, 0x662266FF, 0x662288FF, 0x6622AAFF, 0x6622CCFF, 0x6622EEFF,
0x664400FF, 0x664422FF, 0x664444FF, 0x664466FF, 0x664488FF, 0x6644AAFF, 0x6644CCFF, 0x6644EEFF,
0x666600FF, 0x666622FF, 0x666644FF, 0x666666FF, 0x666688FF, 0x6666AAFF, 0x6666CCFF, 0x6666EEFF,
0x668800FF, 0x668822FF, 0x668844FF, 0x668866FF, 0x668888FF, 0x6688AAFF, 0x6688CCFF, 0x6688EEFF,
0x66AA00FF, 0x66AA22FF, 0x66AA44FF, 0x66AA66FF, 0x66AA88FF, 0x66AAAAFF, 0x66AACCFF, 0x66AAEEFF,
0x66CC00FF, 0x66CC22FF, 0x66CC44FF, 0x66CC66FF, 0x66CC88FF, 0x66CCAAFF, 0x66CCCCFF, 0x66CCEEFF,
0x66EE00FF, 0x66EE22FF, 0x66EE44FF, 0x66EE66FF, 0x66EE88FF, 0x66EEAAFF, 0x66EECCFF, 0x66EEEEFF,

0x880000FF, 0x880022FF, 0x880044FF, 0x880066FF, 0x880088FF, 0x8800AAFF, 0x8800CCFF, 0x8800FFFF,
0x882200FF, 0x882222FF, 0x882244FF, 0x882266FF, 0x882288FF, 0x8822AAFF, 0x8822CCFF, 0x8822EEFF,
0x884400FF, 0x884422FF, 0x884444FF, 0x884466FF, 0x884488FF, 0x8844AAFF, 0x8844CCFF, 0x8844EEFF,
0x886600FF, 0x886622FF, 0x886644FF, 0x886666FF, 0x886688FF, 0x8866AAFF, 0x8866CCFF, 0x8866EEFF,
0x888800FF, 0x888822FF, 0x888844FF, 0x888866FF, 0x888888FF, 0x8888AAFF, 0x8888CCFF, 0x8888EEFF,
0x88AA00FF, 0x88AA22FF, 0x88AA44FF, 0x88AA66FF, 0x88AA88FF, 0x88AAAAFF, 0x88AACCFF, 0x88AAEEFF,
0x88CC00FF, 0x88CC22FF, 0x88CC44FF, 0x88CC66FF, 0x88CC88FF, 0x88CCAAFF, 0x88CCCCFF, 0x88CCEEFF,
0x88EE00FF, 0x88EE22FF, 0x88EE44FF, 0x88EE66FF, 0x88EE88FF, 0x88EEAAFF, 0x88EECCFF, 0x88EEEEFF,

0xAA0000FF, 0xAA0022FF, 0xAA0044FF, 0xAA0066FF, 0xAA0088FF, 0xAA00AAFF, 0xAA00CCFF, 0xAA00FFFF,
0xAA2200FF, 0xAA2222FF, 0xAA2244FF, 0xAA2266FF, 0xAA2288FF, 0xAA22AAFF, 0xAA22CCFF, 0xAA22EEFF,
0xAA4400FF, 0xAA4422FF, 0xAA4444FF, 0xAA4466FF, 0xAA4488FF, 0xAA44AAFF, 0xAA44CCFF, 0xAA44EEFF,
0xAA6600FF, 0xAA6622FF, 0xAA6644FF, 0xAA6666FF, 0xAA6688FF, 0xAA66AAFF, 0xAA66CCFF, 0xAA66EEFF,
0xAA8800FF, 0xAA8822FF, 0xAA8844FF, 0xAA8866FF, 0xAA8888FF, 0xAA88AAFF, 0xAA88CCFF, 0xAA88EEFF,
0xAAAA00FF, 0xAAAA22FF, 0xAAAA44FF, 0xAAAA66FF, 0xAAAA88FF, 0xAAAAAAFF, 0xAAAACCFF, 0xAAAAEEFF,
0xAACC00FF, 0xAACC22FF, 0xAACC44FF, 0xAACC66FF, 0xAACC88FF, 0xAACCAAFF, 0xAACCCCFF, 0xAACCEEFF,
0xAAEE00FF, 0xAAEE22FF, 0xAAEE44FF, 0xAAEE66FF, 0xAAEE88FF, 0xAAEEAAFF, 0xAAEECCFF, 0xAAEEEEFF,

0xCC0000FF, 0xCC0022FF, 0xCC0044FF, 0xCC0066FF, 0xCC0088FF, 0xCC00AAFF, 0xCC00CCFF, 0xCC00FFFF,
0xCC2200FF, 0xCC2222FF, 0xCC2244FF, 0xCC2266FF, 0xCC2288FF, 0xCC22AAFF, 0xCC22CCFF, 0xCC22EEFF,
0xCC4400FF, 0xCC4422FF, 0xCC4444FF, 0xCC4466FF, 0xCC4488FF, 0xCC44AAFF, 0xCC44CCFF, 0xCC44EEFF,
0xCC6600FF, 0xCC6622FF, 0xCC6644FF, 0xCC6666FF, 0xCC6688FF, 0xCC66AAFF, 0xCC66CCFF, 0xCC66EEFF,
0xCC8800FF, 0xCC8822FF, 0xCC8844FF, 0xCC8866FF, 0xCC8888FF, 0xCC88AAFF, 0xCC88CCFF, 0xCC88EEFF,
0xCCAA00FF, 0xCCAA22FF, 0xCCAA44FF, 0xCCAA66FF, 0xCCAA88FF, 0xCCAAAAFF, 0xCCAACCFF, 0xCCAAEEFF,
0xCCCC00FF, 0xCCCC22FF, 0xCCCC44FF, 0xCCCC66FF, 0xCCCC88FF, 0xCCCCAAFF, 0xCCCCCCFF, 0xCCCCEEFF,
0xCCEE00FF, 0xCCEE22FF, 0xCCEE44FF, 0xCCEE66FF, 0xCCEE88FF, 0xCCEEAAFF, 0xCCEECCFF, 0xCCEEEEFF,

0xEE0000FF, 0xEE0022FF, 0xEE0044FF, 0xEE0066FF, 0xEE0088FF, 0xEE00AAFF, 0xEE00CCFF, 0xEE00FFFF,
0xEE2200FF, 0xEE2222FF, 0xEE2244FF, 0xEE2266FF, 0xEE2288FF, 0xEE22AAFF, 0xEE22CCFF, 0xEE22EEFF,
0xEE4400FF, 0xEE4422FF, 0xEE4444FF, 0xEE4466FF, 0xEE4488FF, 0xEE44AAFF, 0xEE44CCFF, 0xEE44EEFF,
0xEE6600FF, 0xEE6622FF, 0xEE6644FF, 0xEE6666FF, 0xEE6688FF, 0xEE66AAFF, 0xEE66CCFF, 0xEE66EEFF,
0xEE8800FF, 0xEE8822FF, 0xEE8844FF, 0xEE8866FF, 0xEE8888FF, 0xEE88AAFF, 0xEE88CCFF, 0xEE88EEFF,
0xEEAA00FF, 0xEEAA22FF, 0xEEAA44FF, 0xEEAA66FF, 0xEEAA88FF, 0xEEAAAAFF, 0xEEAACCFF, 0xEEAAEEFF,
0xEECC00FF, 0xEECC22FF, 0xEECC44FF, 0xEECC66FF, 0xEECC88FF, 0xEECCAAFF, 0xEECCCCFF, 0xEECCEEFF,
0xEEEE00FF, 0xEEEE22FF, 0xEEEE44FF, 0xEEEE66FF, 0xEEEE88FF, 0xEEEEAAFF, 0xEEEECCFF, 0xEEEEEEFF,
};
public OnFilterScriptInit()
{
	SetTimer("UpdateMap", 3000, 1);
// Important
	Test = TextDrawCreate(0.0, 0.0, "_");
	TextDrawFont(Map[0], 0);
	TextDrawTextSize(Map[0], 1.0, 1.0);
//
	Map[0] = TextDrawCreate(0.0, 0.0, "samaps:gtasamapbit1");
	TextDrawFont(Map[0], 4);
	TextDrawBoxColor(Map[0], 0xFFFFFFAA);
	TextDrawTextSize(Map[0], 320.0, 224.0);

	Map[1] = TextDrawCreate(320.0, 0.0, "samaps:gtasamapbit2");
	TextDrawFont(Map[1], 4);
	TextDrawBoxColor(Map[0], 0xFFFFFFAA);
	TextDrawTextSize(Map[1], 320.0, 224.0);

	Map[2] = TextDrawCreate(0.0, 224.0, "samaps:gtasamapbit3");
	TextDrawFont(Map[2], 4);
	TextDrawBoxColor(Map[0], 0xFFFFFFAA);
	TextDrawTextSize(Map[2], 320.0, 224.0);

	Map[3] = TextDrawCreate(320.0, 224.0, "samaps:gtasamapbit4");
	TextDrawFont(Map[3], 4);
	TextDrawBoxColor(Map[0], 0xFFFFFFAA);
	TextDrawTextSize(Map[3], 320.0, 224.0);

	Map[4] = TextDrawCreate(0.0, 0.0, "samaps:map");
	TextDrawFont(Map[4], 4);
	TextDrawBoxColor(Map[0], 0xFFFFFFAA);
	TextDrawTextSize(Map[4], 640.0, 448.0);

	ConnectNPC("Den_Kimyra", "blank");
	ConnectNPC("Tomas_Angelo", "blank");
	ConnectNPC("Jessy_James", "blank");
	ConnectNPC("Michle_Jackson", "blank");
	ConnectNPC("Sergio_Armani", "blank");
	ConnectNPC("Mike_Tyson", "blank");
	ConnectNPC("Andy_Smith", "blank");
	ConnectNPC("Angelo_Melan", "blank");
	ConnectNPC("Ahmed_Simonov", "blank");
	ConnectNPC("Alex_McNally", "blank");
	ConnectNPC("Frank_Lampard", "blank");
	ConnectNPC("Anya_Molen", "blank");
	ConnectNPC("Masha_Angel", "blank");
	ConnectNPC("Misha_Potapov", "blank");
	ConnectNPC("Jenny_Smith", "blank");
	ConnectNPC("Semen_Mironov", "blank");
	ConnectNPC("Mose_Larsen", "blank");
	ConnectNPC("Masa_Debose", "blank");
	ConnectNPC("Mickle_Melan", "blank");
	ConnectNPC("Fedya_Lomanov", "blank");
	ConnectNPC("Roman_Beztolov", "blank");
	ConnectNPC("Rick_Mick", "blank");
	ConnectNPC("Lenny_Smith", "blank");
	ConnectNPC("Mac_Ferrary", "blank");
	ConnectNPC("Dage_Sen", "blank");
	ConnectNPC("Angela_Kimyra", "blank");
	ConnectNPC("Den_Simpson", "blank");
	ConnectNPC("Mo_Debose", "blank");
	ConnectNPC("Denny_Dese", "blank");
	ConnectNPC("Marry_Jack", "blank");
	ConnectNPC("Seck_Mack", "blank");
	ConnectNPC("Danny_Dense", "blank");
	ConnectNPC("Masha_Kimmy", "blank");
	ConnectNPC("Leonardo_Da_Vinci", "blank");
	ConnectNPC("Mick_Toobig", "blank");
	ConnectNPC("Tycon_Jake", "blank");
	ConnectNPC("James_Dreas", "blank");
	ConnectNPC("Armani_Ot_Armani", "blank");
	ConnectNPC("Tender_Medlton", "blank");
	ConnectNPC("Kate_Jackson", "blank");
	ConnectNPC("Den_Jackson", "blank");
	ConnectNPC("Lebron_James", "blank");
	ConnectNPC("Shil_Herro", "blank");
	ConnectNPC("Fred_Melan", "blank");
	ConnectNPC("Drake_House", "blank");
	ConnectNPC("Alf_House", "blank");
	ConnectNPC("Denis_Lebronov", "blank");
	ConnectNPC("Misha_Portov", "blank");
	ConnectNPC("Kirill_Lenio", "blank");
	ConnectNPC("Morse_Debo", "blank");
	ConnectNPC("Anoma_De_Arich", "blank");
	ConnectNPC("Fred_McEazzy", "blank");
	ConnectNPC("Dick_Mich", "blank");
	ConnectNPC("Roman_Zlatov", "blank");
	ConnectNPC("Rick_Rich", "blank");
	ConnectNPC("Lenny_Meane", "blank");
	ConnectNPC("Fill_Tern", "blank");
	ConnectNPC("Zein_Bermont", "blank");
	ConnectNPC("Masha_Cole", "blank");
	ConnectNPC("Jonny_Smith", "blank");
	ConnectNPC("Holly_Wood", "blank");
	ConnectNPC("Mersedes_Melan", "blank");
	ConnectNPC("Jake_Tyler", "blank");
	ConnectNPC("Oleg_Horyainov", "blank");
	ConnectNPC("Sean_McKinly", "blank");
	ConnectNPC("Den_Shnaider", "blank");
	ConnectNPC("Mike_Jordan", "blank");
	ConnectNPC("Lenon_Lerby", "blank");
	ConnectNPC("Unly_Tolife", "blank");
	ConnectNPC("Jack_Tack", "blank");
	ConnectNPC("Melany_Fox", "blank");
	ConnectNPC("Tommy_Kolombo", "blank");
	ConnectNPC("Zein_Bern", "blank");
	ConnectNPC("Homer_Simpson", "blank");
	ConnectNPC("Den_Lampard", "blank");
	ConnectNPC("Only_Deas", "blank");
	ConnectNPC("Hender_Smith", "blank");
	ConnectNPC("Kind_Ferron", "blank");
	ConnectNPC("Tomas_Heran", "blank");
	ConnectNPC("Ben_Moran", "blank");
	ConnectNPC("Lacio_Rio_Postern", "blank");
	ConnectNPC("Din_Bin", "blank");
	ConnectNPC("Usama_Bin_Laden", "blank");
	ConnectNPC("Misha_Medvedev", "blank");

    return 1;
}
public OnFilterScriptExit()
{
	for(new i; i < sizeof(Map); i++)
	{
		TextDrawHideForAll(Map[i]);
		TextDrawDestroy(Map[i]);
	}
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		TextDrawHideForAll(Player[i]);
		TextDrawDestroy(Player[i]);
		TextDrawHideForAll(Stats[i]);
		TextDrawDestroy(Stats[i]);
		if(IsPlayerNPC(i)) Kick(i);
		if(GetPVarInt(i, "ShowMap") == 1) SetPVarInt(i, "ShowMap", 0);
//		ShowPlayerDialog(i, -1, DIALOG_STYLE_PASSWORD, "_", "_", "", "");
	}
	return 1;
}
public OnPlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
	{
		if(playerid < 20)
		{
			SetPlayerPos(playerid, 40.0 * playerid, 40.0 * playerid, 10.0);
		}
		else if(playerid > 19 && playerid < 40)
		{
		    SetPlayerPos(playerid, -40.0 * playerid, -40.0 * playerid, 10.0);
		}
		else if(playerid > 39 && playerid < 60)
		{
		    SetPlayerPos(playerid, -40.0 * playerid, 40.0 * playerid, 10.0);
		}
		else if(playerid > 59 && playerid < 90)
		{
		    SetPlayerPos(playerid, 40.0 * playerid, -40.0 * playerid, 10.0);
		}
	}
	TextDrawShowForPlayer(playerid, Test);
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp(cmdtext, "/map", true) == 0)
	{
	    new mstatus[30], tstatus[30], sstatus[30];
	    mstatus[0] = 0; tstatus[0] = 0; sstatus[0] = 0;
		if(GetPVarInt(playerid, "ShowMap") == 1) strcat(mstatus, "{FF0000}[OFF]");
		else if(GetPVarInt(playerid, "ShowMap") == 0) strcat(mstatus, "{00FF00}[ON]");
		if(GetPVarInt(playerid, "MapType") == 1) strcat(tstatus, "{FFFF00}[LQ]");
		else if(GetPVarInt(playerid, "MapType") == 0) strcat(tstatus, "{FF00FF}[HQ]");
		if(GetPVarInt(playerid, "MapStat") == 1) strcat(sstatus, "{FF0000}[OFF]");
		else if(GetPVarInt(playerid, "MapStat") == 0) strcat(sstatus, "{00FF00}[ON]");
	    new string[138];
	    format(string, sizeof(string), "Map-Radar\t\t\t%s\n{FFFFFF}Quality of Image\t\t%s\n{FFFFFF}Additional Info\t%s", mstatus, tstatus, sstatus);
	    ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_LIST, "Map-Radar", string, "Select", "Cancel");
		return 1;
	}
	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1337)
	{
		if(response)
		{
			switch(listitem)
			{
		        case 0:
		        {
		            if(GetPVarInt(playerid, "ShowMap") == 1)
		            {
		  				SetPVarInt(playerid, "ShowMap", 0);
						if(GetPVarInt(playerid, "MapType") == 0)
				  		{
							TextDrawHideForPlayer(playerid, Map[0]);
							TextDrawHideForPlayer(playerid, Map[1]);
							TextDrawHideForPlayer(playerid, Map[2]);
							TextDrawHideForPlayer(playerid, Map[3]);
						}
						else if(GetPVarInt(playerid, "MapType") == 1)
						{
							TextDrawHideForPlayer(playerid, Map[4]);
						}
			   			for(new i, j = GetMaxPlayers(); i != j; i++)
					    {
				    		TextDrawHideForPlayer(playerid, Player[i]);
				    		TextDrawHideForPlayer(playerid, Stats[i]);
					    }
				    }
		            else if(GetPVarInt(playerid, "ShowMap") == 0)
		            {
		  				SetPVarInt(playerid, "ShowMap", 1);
						if(GetPVarInt(playerid, "MapType") == 0)
				  		{
							TextDrawShowForPlayer(playerid, Map[0]);
							TextDrawShowForPlayer(playerid, Map[1]);
							TextDrawShowForPlayer(playerid, Map[2]);
							TextDrawShowForPlayer(playerid, Map[3]);
						}
						else if(GetPVarInt(playerid, "MapType") == 1)
						{
							TextDrawShowForPlayer(playerid, Map[4]);
						}
					}
				    new mstatus[30], tstatus[30], sstatus[30];
				    mstatus[0] = 0; tstatus[0] = 0; sstatus[0] = 0;
					if(GetPVarInt(playerid, "ShowMap") == 1) strcat(mstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "ShowMap") == 0) strcat(mstatus, "{00FF00}[ON]");
					if(GetPVarInt(playerid, "MapType") == 1) strcat(tstatus, "{FFFF00}[LQ]");
					else if(GetPVarInt(playerid, "MapType") == 0) strcat(tstatus, "{FF00FF}[HQ]");
					if(GetPVarInt(playerid, "MapStat") == 1) strcat(sstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "MapStat") == 0) strcat(sstatus, "{00FF00}[ON]");
				    new string[138];
				    format(string, sizeof(string), "Map-Radar\t\t\t%s\n{FFFFFF}Quality of Image\t\t%s\n{FFFFFF}Additional Info\t%s", mstatus, tstatus, sstatus);
				    ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_LIST, "Map-Radar", string, "Select", "Cancel");
		        }
		        case 1:
		        {
					if(GetPVarInt(playerid, "MapType") == 0)
			  		{
						TextDrawHideForPlayer(playerid, Map[0]);
						TextDrawHideForPlayer(playerid, Map[1]);
						TextDrawHideForPlayer(playerid, Map[2]);
						TextDrawHideForPlayer(playerid, Map[3]);
					}
					else if(GetPVarInt(playerid, "MapType") == 1)
					{
						TextDrawHideForPlayer(playerid, Map[4]);
					}

					if(GetPVarInt(playerid, "MapType") == 0) SetPVarInt(playerid, "MapType", 1);
					else if(GetPVarInt(playerid, "MapType") == 1) SetPVarInt(playerid, "MapType", 0);

					if(GetPVarInt(playerid, "ShowMap") == 1)
					{
						if(GetPVarInt(playerid, "MapType") == 0)
				  		{
							TextDrawShowForPlayer(playerid, Map[0]);
							TextDrawShowForPlayer(playerid, Map[1]);
							TextDrawShowForPlayer(playerid, Map[2]);
							TextDrawShowForPlayer(playerid, Map[3]);
						}
						else if(GetPVarInt(playerid, "MapType") == 1)
						{
							TextDrawShowForPlayer(playerid, Map[4]);
						}
					}

					new mstatus[30], tstatus[30], sstatus[30];
					mstatus[0] = 0; tstatus[0] = 0; sstatus[0] = 0;
					if(GetPVarInt(playerid, "ShowMap") == 1) strcat(mstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "ShowMap") == 0) strcat(mstatus, "{00FF00}[ON]");
					if(GetPVarInt(playerid, "MapType") == 1) strcat(tstatus, "{FFFF00}[LQ]");
					else if(GetPVarInt(playerid, "MapType") == 0) strcat(tstatus, "{FF00FF}[HQ]");
					if(GetPVarInt(playerid, "MapStat") == 1) strcat(sstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "MapStat") == 0) strcat(sstatus, "{00FF00}[ON]");
					new string[138];
					format(string, sizeof(string), "Map-Radar\t\t\t%s\n{FFFFFF}Quality of Image\t\t%s\n{FFFFFF}Additional Info\t%s", mstatus, tstatus, sstatus);
				    ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_LIST, "Map-Radar", string, "Select", "Cancel");
				}
				case 2:
		        {
					if(GetPVarInt(playerid, "MapStat") == 0) SetPVarInt(playerid, "MapStat", 1);
					else if(GetPVarInt(playerid, "MapStat") == 1) SetPVarInt(playerid, "MapStat", 0);

					new mstatus[30], tstatus[30], sstatus[30];
					mstatus[0] = 0; tstatus[0] = 0; sstatus[0] = 0;
					if(GetPVarInt(playerid, "ShowMap") == 1) strcat(mstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "ShowMap") == 0) strcat(mstatus, "{00FF00}[ON]");
					if(GetPVarInt(playerid, "MapType") == 1) strcat(tstatus, "{FFFF00}[LQ]");
					else if(GetPVarInt(playerid, "MapType") == 0) strcat(tstatus, "{FF00FF}[HQ]");
					if(GetPVarInt(playerid, "MapStat") == 1) strcat(sstatus, "{FF0000}[OFF]");
					else if(GetPVarInt(playerid, "MapStat") == 0) strcat(sstatus, "{00FF00}[ON]");
					new string[138];
					format(string, sizeof(string), "Map-Radar\t\t\t%s\n{FFFFFF}Quality of Image\t\t%s\n{FFFFFF}Additional Info\t%s", mstatus, tstatus, sstatus);
				    ShowPlayerDialog(playerid, 1337, DIALOG_STYLE_LIST, "Map-Radar", string, "Select", "Cancel");
		        }
			}
		}
	}
	return 0;
}
forward UpdateMap();
public UpdateMap()
{
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		TextDrawHideForAll(Player[i]);
		TextDrawDestroy(Player[i]);
		TextDrawHideForAll(Stats[i]);
		TextDrawDestroy(Stats[i]);
	}
	new Float:x, Float:y, Float:z, PlayerName[MAX_PLAYER_NAME], Float:HP, Float:AP, string[128];
	for(new i, j = GetMaxPlayers(); i != j; i++)
	{
		if(!IsPlayerConnected(i)) continue;
//		if(IsPlayerNPC(i)) continue;
		GetPlayerPos(i, x, y, z);
		if(y < -3000 || y > 3000 || x < -3000 || x > 3000) continue;
		new Float:PosX, Float:PosY;
// (316.0 ; 207.0) Scale center
		if(y < 0) PosY = 207 + 224 * -y / 3000;
		else if(y >= 0) PosY = 207 - 224 * y / 3000;
		if(x < 0) PosX = 316 - -x * 320 / 3000;
		else if(x >= 0) PosX = 316 + x * 320 / 3000;

		Player[i] = TextDrawCreate(PosX, PosY, "-");
		TextDrawFont(Player[i], 1);
		TextDrawLetterSize(Player[i], 0.49, 2.9);
		TextDrawColor(Player[i], PlayerRainbowColors[210 + i]);
		TextDrawSetOutline(Player[i], 1);

		GetPlayerName(i, PlayerName, sizeof(PlayerName));
		GetPlayerHealth(i, HP);
		GetPlayerArmour(i, AP);

		format(string, sizeof(string), "ID: %d NAME: %s HP: %.1f AP: %.1f~n~X: %.4f Y: %.4f Z: %.4f", i, PlayerName, HP, AP, x, y, z);
		Stats[i] = TextDrawCreate(PosX, PosY, string);
		TextDrawFont(Stats[i], 1);
		TextDrawLetterSize(Stats[i], 0.16, 0.6);
		TextDrawColor(Stats[i], 0xFFFFFFFF);
		TextDrawSetOutline(Stats[i], 1);

		for(new h, k = GetMaxPlayers(); h != k; h++)
		{
			if(!IsPlayerConnected(h)) continue;
			if(IsPlayerNPC(h)) continue;
			if(GetPVarInt(h, "ShowMap") == 0) continue;
			TextDrawShowForPlayer(h, Player[i]);
			if(GetPVarInt(h, "MapStat") == 1) TextDrawShowForPlayer(h, Stats[i]);
		}
	}
	return 1;
}