//-_-_-_-_-_-_-_-_-_-_-_-_Neon System By [EDT]Quattro-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
//-_-_-_-_-_-_-_-_-_-_-_-_-_-Do Not Remove Credits_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
//-_-_-_-_-_-_-_-_-_-_-_-_-Commands: /neonshop /neon-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_Enjoy Using It!-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-
//-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

#include <a_samp>
#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print("Neon System By [EDT]Quattro Loaded!");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Neon System By [EDT]Quattro Loaded!");
	print("----------------------------------\n");
}

#endif
public OnGameModeInit()
{
		CreateObject(8954, -1984.5048828125, 426.61761474609, 28.943223953247, 0, 0, 184);
		CreateObject(11326, -1994.1408691406, 437.97189331055, 28.679206848145, 0, 0, 0.25);
		CreateObject(7191, -1956.515625, 448.09234619141, 28.587062835693, 0, 0, 95.25);
		CreateObject(1173, -1980.5299072266, 435.47134399414, 30.378553390503, 0, 0, 0);
		CreateObject(1172, -1980.4494628906, 435.71505737305, 29.489776611328, 0, 0, 0);
		CreateObject(1171, -1981.2755126953, 435.64346313477, 29.886144638062, 0, 178, 354.75);
		CreateObject(1169, -1981.0889892578, 435.56182861328, 29.487819671631, 0, 0, 0);
		CreateObject(1168, -1975.2124023438, 435.77593994141, 30.412317276001, 0, 0, 178);
		CreateObject(1167, -1975.1953125, 435.8342590332, 29.416021347046, 0, 0, 178);
		CreateObject(1163, -1984.1585693359, 439.34622192383, 30.586503982544, 274, 0, 269.75);
		CreateObject(1162, -1984.1672363281, 441.52844238281, 30.722972869873, 270, 179.40661621094, 87.406616210938);
		CreateObject(1139, -1984.2535400391, 443.72668457031, 30.460748672485, 280.19604492188, 191.37036132813, 98.445404052734);
		CreateObject(1112, -1973.9462890625, 437.38125610352, 29.646976470947, 3.9391174316406, 349.97607421875, 0.6956787109375);
		CreateObject(1098, -1974.1801757813, 440.46667480469, 29.947492599487, 0, 0, 6);
		CreateObject(1098, -1974.1300048828, 440.42913818359, 28.843486785889, 0, 0, 4);
		CreateObject(1097, -1974.123046875, 438.56341552734, 29.941816329956, 0, 0, 180.5);
		CreateObject(1097, -1974.0185546875, 438.56216430664, 28.837507247925, 0, 0, 2);
		CreateObject(1096, -1974.1331787109, 442.32843017578, 29.935081481934, 0, 0, 181.25);
		CreateObject(1096, -1974.1580810547, 442.26931762695, 28.77064704895, 0, 0, 0);
		CreateObject(1089, -1977.2879638672, 447.44540405273, 30.869338989258, 0, 0, 0);
		CreateObject(1085, -1974.0982666016, 444.29943847656, 29.984083175659, 0, 0, 179.25);
		CreateObject(1085, -1974.0404052734, 444.24810791016, 28.742120742798, 0, 0, 0);
		CreateObject(1080, -1973.9967041016, 436.78811645508, 28.870197296143, 0, 0, 0.75);
		CreateObject(1080, -1974.0190429688, 436.87274169922, 30.091676712036, 0, 0, 181);
		CreateObject(1065, -1975.4147949219, 447.41397094727, 30.93871307373, 0, 0, 0);
		CreateObject(1047, -1984.2227783203, 440.37838745117, 29.250276565552, 0, 0, 181.5);
		CreateObject(1039, -1984.2292480469, 443.45150756836, 29.330806732178, 0, 0, 184);
		CreateObject(1036, -1984.1687011719, 437.39694213867, 29.339908599854, 0, 0, 178);
		CreateObject(1010, -1984.2023925781, 437.30276489258, 30.272491455078, 0, 90, 0);
		CreateObject(1009, -1984.2290039063, 437.81698608398, 30.226253509521, 0, 90.500061035156, 0);
		CreateObject(1008, -1984.1997070313, 436.64154052734, 30.228116989136, 0, 88.5, 0);
		#pragma tabsize 0
		#define COLOR_YELLOW 0xFFFF00AA
}

public OnGameModeExit()
{
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
    new cartype = GetPlayerVehicleID(playerid);
	new State=GetPlayerState(playerid);


		if(strcmp(cmdtext, "/neonshop", true) == 0)
     	{

		SetPlayerInterior(playerid,0);
		{if(State!=PLAYER_STATE_DRIVER)
 		{SetPlayerPos(playerid,-1980.0026,474.2643,29);}
		else if(IsPlayerInVehicle(playerid, cartype) == 1)
		{SetVehiclePos(cartype,-1980.0026,474.2643,29);
		SetVehicleZAngle(cartype,180.1530);}
		else
		{SetPlayerPos(playerid,-1980.0026,474.2643,29);}
		SendClientMessage(playerid, COLOR_YELLOW,"Type /neon in the garage to pick a neon!");}

        return 1;}

	if (strcmp(cmdtext, "/neon", true)==0)
	{
	 if(IsPlayerInRangeOfPoint(playerid, 7.0, -1979.3672,440.1091,27))
    {

    ShowPlayerDialog(playerid, 8899, DIALOG_STYLE_LIST, "Pick Neon Color", "Blue\nRed\nGreen\nWhite\nPink\nYellow\nPolice Strobe\nInterior Lights\nBack Neon\nFront neon\nUndercover Roof Light\nRemove All Neon", "Select", "Cancel");
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 10.0);
}
return 1;}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

 if(dialogid == 8899)
	{
		if(response)
		{
			if(listitem == 0)
			{


			//blue
			SetPVarInt(playerid, "Status", 1);
            SetPVarInt(playerid, "neon", CreateObject(18648,0,0,0,0,0,0));
            SetPVarInt(playerid, "neon1", CreateObject(18648,0,0,0,0,0,0));
            AttachObjectToVehicle(GetPVarInt(playerid, "neon"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
            AttachObjectToVehicle(GetPVarInt(playerid, "neon1"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
   			 }
			if(listitem == 1)
			{


			 //red
				SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon2", CreateObject(18647,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon3", CreateObject(18647,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon2"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon3"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

}
			if(listitem == 2)
			{


			//green
		   	   SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon4", CreateObject(18649,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon5", CreateObject(18649,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon4"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon5"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

	            }
			if(listitem == 3)
			{

			//white
		   	   SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon6", CreateObject(18652,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon7", CreateObject(18652,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon6"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon7"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

}
			if(listitem == 4)
			{


			//pink
		   	   SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon8", CreateObject(18651,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon9", CreateObject(18651,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon8"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon9"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

}
			if(listitem == 5)
			{


			//yellow
  				 SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon10", CreateObject(18650,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon11", CreateObject(18650,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon10"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon11"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

}
			if(listitem == 6)
			{


			//police
   	 		   SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "neon12", CreateObject(18646,0,0,0,0,0,0));
	            SetPVarInt(playerid, "neon13", CreateObject(18646,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon12"), GetPlayerVehicleID(playerid), -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "neon13"), GetPlayerVehicleID(playerid), 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "neon installed");

	            }

	           	if(listitem == 7)
				{
	            SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "interior", CreateObject(18646,0,0,0,0,0,0));
	            SetPVarInt(playerid, "interior1", CreateObject(18646,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "interior"), GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0, 3.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "interior1"), GetPlayerVehicleID(playerid), 0, -0.0, 0, 2.0, 2.0, 3.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Interior lights installed");

	            }
          	if(listitem == 8)
			{

			//back
	            SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "back", CreateObject(18646,0,0,0,0,0,0));
	            SetPVarInt(playerid, "back1", CreateObject(18646,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "back"), GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0, 2.0, 3.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "back1"), GetPlayerVehicleID(playerid), -0.0, -1.5, -1, 2.0, 2.0, 3.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Back neon installed");
	            }
            	if(listitem == 9)
				{

				//front
	            SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "front", CreateObject(18646,0,0,0,0,0,0));
	            SetPVarInt(playerid, "front1", CreateObject(18646,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "front"), GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6, 2.0, 2.0, 3.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "front1"), GetPlayerVehicleID(playerid), -0.0, 1.5, -0.6, 2.0, 2.0, 3.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Front neon installed");
	            }
	            if(listitem == 10)
				{
	            //undercover
	            SetPVarInt(playerid, "Status", 1);
	            SetPVarInt(playerid, "undercover", CreateObject(18646,0,0,0,0,0,0));
	            SetPVarInt(playerid, "undercover1", CreateObject(18646,0,0,0,0,0,0));
	            AttachObjectToVehicle(GetPVarInt(playerid, "undercover"), GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0);
	            AttachObjectToVehicle(GetPVarInt(playerid, "undercover1"), GetPlayerVehicleID(playerid), -0.5, -0.2, 0.8, 2.0, 2.0, 3.0);
	            SendClientMessage(playerid, 0xFFFFFFAA, "Undercover lights installed");
	            }
			if(listitem == 11)
			{
			//remove neon
            DestroyObject(GetPVarInt(playerid, "neon"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon1"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon2"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon3"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon4"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon5"));
			DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon6"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon7"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon8"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon9"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon10"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon11"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon12"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "neon13"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "interior"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "interior1"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "back"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "back1"));
            DeletePVar(playerid, "Status");
			DestroyObject(GetPVarInt(playerid, "front"));
			DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "front1"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "undercover"));
            DeletePVar(playerid, "Status");
            DestroyObject(GetPVarInt(playerid, "undercover1"));

            DeletePVar(playerid, "Status");


	 	      }
		 }
		 }
		 	return 0;}

		public OnPlayerConnect()
		{
		new playerid;
		SendClientMessage(playerid, COLOR_YELLOW,"This server is using neon system by [EDT]Quattro. Use /neonshop!");
		return 1;
		}
		//do not remove credits please...