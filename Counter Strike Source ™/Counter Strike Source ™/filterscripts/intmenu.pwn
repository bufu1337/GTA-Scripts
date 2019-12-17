#include <a_samp>

#define DIALOGID3 1338

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/intmenu", cmdtext, true, 10) == 0)
	{
		ShowPlayerDialog(playerid, DIALOGID3, DIALOG_STYLE_LIST, "Interior List", "Burglar Houses\nBusinesses\nBars n Clubs\nRestaurants\nGirlfriends Houses\nHomies Houses\nP.I.M.P Clubs\nMiscellaneous", "Select", "Cancel");
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOGID3)
	{
		if(response)
		{
			if(listitem == 0) // Burglar Houses
			{
				ShowPlayerDialog(playerid, DIALOGID3+1, DIALOG_STYLE_LIST, "Select an Interior", "House 1\nHouse 2\nHouse 3\nHouse 4\nHouse 5\nHouse 6\nHouse 7\nHouse 8\nHouse 9\nHouse 10\nHouse 11\nHouse 12\nHouse 13\nHouse 14\nHouse 15\nHouse 16\nHouse 17\nHouse 18\nHouse 19\nHouse 20\nHouse 21\nHouse 22\nHouse 23\nHouse 24\nHouse 25\nHouse 26\nHouse 27\nHouse 28\nHouse 29\nHouse 30", "Select", "Cancel");
			}
			if(listitem == 1) // Businesses
			{
				ShowPlayerDialog(playerid, DIALOGID3+2, DIALOG_STYLE_LIST, "Select an Interior", "Budget Inn Motel room\nJefferson Motel\nOff Track Betting\nSex Shop\nSindacco Meat Factory/nZero's RC Shop/nGas Station(Dilimore)", "Select", "Cancel");
			}
			if(listitem == 2) // Bars n' C;ubs
			{
				ShowPlayerDialog(playerid, DIALOGID3+2, DIALOG_STYLE_LIST, "Select an Interior", "Alhambra\nPool Table Bar\nLil'Prob Inn", "Select", "Cancel");
			}
			if(listitem == 3) // Rastaurants
			{
				ShowPlayerDialog(playerid, DIALOGID3+4, DIALOG_STYLE_LIST, "Select an Interior", "Jay's Diner\nGant Bridge Res\nWorld of Coq\nWelcome Pump Dinner", "Select", "Cancel");
			}
			if(listitem == 4) // Girlfriends Houses
			{
				ShowPlayerDialog(playerid, DIALOGID3+5, DIALOG_STYLE_LIST, "Select an Interior", "Denise Robinson\nKatie Zhan\nHelena Wankstein\nMichelle Cannes\nBarbara Schternvart\nMillie Perkins", "Select", "Cancel");
			}
			if(listitem == 5) // Homies Houses
			{
				ShowPlayerDialog(playerid, DIALOGID3+6, DIALOG_STYLE_LIST, "Select an Interior", "Ryder House\nSweet House\nBig Smoke CF\nBig Smoke CF2", "Select", "Cancel");
			}
			if(listitem == 6) // P.I.M.P Clubs
			{
				ShowPlayerDialog(playerid, DIALOGID3+7, DIALOG_STYLE_LIST, "Select an Interior", "Stript Club\nWhore House\nTiger Skin Brothel\nJizzy Club", "Select", "Cancel");
			}
			if(listitem == 7) // Misc
			{
				ShowPlayerDialog(playerid, DIALOGID3+8, DIALOG_STYLE_LIST, "Select an Interior", "Crack Lab\nColonel Furhberger\nDrug Den\nUnused Safe House\nRC Battlefield", "Select", "Cancel");
			}
		}
		return 1;
	}
	
    if(dialogid == DIALOGID3+1) // Burglar Houses
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);
                SetPlayerInterior(playerid,1);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);
                SetPlayerInterior(playerid,7);
			}
			if(listitem == 4)
			{
				SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 5)
			{
				SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 6)
			{
				SetPlayerPos(playerid,385.803986,1471.769897,1080.209961);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 7)
			{
				SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 8)
			{
				SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 9)
			{
				SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);
                SetPlayerInterior(playerid,1);
			}
            if(listitem == 10)
			{
				SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);
                SetPlayerInterior(playerid,7);
			}
			if(listitem == 11)
			{
				SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 12)
			{
				SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 13)
			{
				SetPlayerPos(playerid,385.803986,1471.769897,1080.209961);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 14)
			{
				SetPlayerPos(playerid,375.971985,1417.269897,1081.409912);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 15)
			{
				SetPlayerPos(playerid,490.810974,1401.489990,1080.339966);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 16)
			{
				SetPlayerPos(playerid,447.734985,1400.439941,1084.339966);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 17)
			{
				SetPlayerPos(playerid,227.722992,1114.389893,1081.189941);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 18)
			{
				SetPlayerPos(playerid,260.983978,1286.549927,1080.299927);
                SetPlayerInterior(playerid,4);
			}
			if(listitem == 19)
			{
				SetPlayerPos(playerid,221.666992,1143.389893,1082.679932);
                SetPlayerInterior(playerid,4);
			}
			if(listitem == 20)
			{
				SetPlayerPos(playerid,27.132700,1341.149902,1084.449951);
                SetPlayerInterior(playerid,10);
			}
			if(listitem == 21)
			{
				SetPlayerPos(playerid,-262.601990,1456.619995,1084.449951);
                SetPlayerInterior(playerid,4);
			}
			if(listitem == 22)
			{
				SetPlayerPos(playerid,22.778299,1404.959961,1084.449951);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 23)
			{
 				SetPlayerPos(playerid,140.278000,1368.979980,1083.969971);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 24)
			{
				SetPlayerPos(playerid,234.045990,1064.879883,1084.309937);
                SetPlayerInterior(playerid,6);
			}
			if(listitem == 25)
			{
				SetPlayerPos(playerid,-68.294098,1353.469971,1080.279907);
                SetPlayerInterior(playerid,6);
			}
			if(listitem == 26)
			{
				SetPlayerPos(playerid,-285.548981,1470.979980,1084.449951);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 27)
			{
				SetPlayerPos(playerid,-42.581997,1408.109985,1084.449951);
                SetPlayerInterior(playerid,8);
			}
			if(listitem == 28)
			{
				SetPlayerPos(playerid,83.345093,1324.439941,1083.889893);
                SetPlayerInterior(playerid,9);
			}
			if(listitem == 29)
			{
				SetPlayerPos(playerid,260.941986,1238.509888,1084.259888);
                SetPlayerInterior(playerid,9);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+2) // Businesses
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,446.622986,509.318970,1001.419983);
                SetPlayerInterior(playerid,12);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,2216.339844,-1150.509888,1025.799927);
                SetPlayerInterior(playerid,15);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,833.818970,7.418000,004.179993);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,-100.325996,-22.816500,1000.741943);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 4)
			{
				SetPlayerPos(playerid,964.376953,2157.329834,1011.019958);
                SetPlayerInterior(playerid,1);
			}
			if(listitem == 5)
			{
				SetPlayerPos(playerid,-2239.569824,130.020996,1035.419922);
                SetPlayerInterior(playerid,6);
			}
			if(listitem == 6)
			{
				SetPlayerPos(playerid,662.641601,-571.398803,16.343263);
                SetPlayerInterior(playerid,0);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+3) // Bars n' C;ubs
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,493.390991,-22.722799,1000.686951);
                SetPlayerInterior(playerid,17);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,501.980988,-69.150200,998.834961);
                SetPlayerInterior(playerid,11);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,-227.028000,1401.229980,27.769798);
                SetPlayerInterior(playerid,18);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+4) // Restaurants
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,460.099976,-88.428497,999.621948);
                SetPlayerInterior(playerid,4);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,454.973950,-110.104996,999.717957);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,452.489990,-18.179699,1001.179993);
                SetPlayerInterior(playerid,1);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,681.474976,-451.150970,-25.616798);
                SetPlayerInterior(playerid,1);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+5) // Girlfriends Houses
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,244.411987,305.032990,999.231995);
                SetPlayerInterior(playerid,1);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,271.884979,306.631989,999.325989);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,291.282990,310.031982,999.154968);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,302.181000,300.722992,999.231995);
                SetPlayerInterior(playerid,4);
			}
			if(listitem == 4)
			{
				SetPlayerPos(playerid,322.197998,302.497986,999.231995);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 5)
			{
				SetPlayerPos(playerid,346.870025,309.259033,999.155700);
                SetPlayerInterior(playerid,6);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+6) // Hommies Houses
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,2464.109863,-1698.659912,1013.509949);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,2526.459961,-1679.089966,1015.500000);
                SetPlayerInterior(playerid,1);
			}
			if(listitem == 2)
			{
	  			SetPlayerPos(playerid,2549.0225,-1294.5924,1060.9844);
                SetPlayerInterior(playerid,2);
			}
			if(listitem == 3)
			{
	  		    SetPlayerPos(playerid,2547.268310,-1295.931762,1054.640625);
                SetPlayerInterior(playerid,2);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+7) // P.I.M.P Clubs
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,1212.019897,-28.663099,1001.089966);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,744.542969,1437.669922,1102.739990);
                SetPlayerInterior(playerid,6);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,964.106995,-53.205498,1001.179993);
                SetPlayerInterior(playerid,3);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,-2661.009766,1415.739990,923.305969);
                SetPlayerInterior(playerid,3);
			}
		}
		return 1;
	}

	if(dialogid == DIALOGID3+8) // Misc
	{
		if(response)
		{
			if(listitem == 0)
			{
				SetPlayerPos(playerid,2350.339844,-1181.649902,1028.000000);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 1)
			{
				SetPlayerPos(playerid,2807.619873,-1171.899902,1025.579956);
                SetPlayerInterior(playerid,8);
			}
			if(listitem == 2)
			{
				SetPlayerPos(playerid,318.564972,1118.209961,1083.979980);
                SetPlayerInterior(playerid,5);
			}
			if(listitem == 3)
			{
				SetPlayerPos(playerid,2324.419922,-1147.539917,1050.719971);
                SetPlayerInterior(playerid,12);
			}
			if(listitem == 4)
			{
				SetPlayerPos(playerid,-972.4957,1060.983,1345.669);
                SetPlayerInterior(playerid,10);
			}
		}
		return 1;
	}

	return 0;
 }
