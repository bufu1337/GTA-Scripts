ProfileInput(playerid, text[])
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	switch(ProfileContinue[playerid])
	{
		case 2:
		{
			dUserSet(playername).("Age",text);
			Age[playerid] = dUser(playername).("Age");
			ProfileContinue[playerid] = 3;
			GiveProfileOptions(playerid);			
		}
		case 3:
		{
			dUserSet(playername).("Gender",text);
			Gender[playerid] = dUser(playername).("Gender");
			ProfileContinue[playerid] = 4;
			GiveProfileOptions(playerid);
		}
		case 4:
		{
			dUserSet(playername).("State/Providence",text);
			State[playerid] = dUser(playername).("State/Providence");
			ProfileContinue[playerid] = 5;
			GiveProfileOptions(playerid);
		}
		case 5:
		{
			dUserSet(playername).("Country",text);
			Country[playerid] = dUser(playername).("Country");
			ProfileContinue[playerid] = 6;
			GiveProfileOptions(playerid);
		}
		case 6:
		{
			dUserSet(playername).("Likes",text);
			Likes[playerid] = dUser(playername).("Likes");
			ProfileContinue[playerid] = 7;
			GiveProfileOptions(playerid);
		}
		case 7:
		{
			dUserSet(playername).("Dislikes",text);
			Dislikes[playerid] = dUser(playername).("Dislikes");
			ProfileContinue[playerid] = 8;
			GiveProfileOptions(playerid);
		}
		case 8:
		{
			dUserSet(playername).("Sport",text);
			Sport[playerid] = dUser(playername).("Sport");
			ProfileContinue[playerid] = 9;
			GiveProfileOptions(playerid);
		}
		case 9:
		{
			dUserSet(playername).("Music",text);
	 		Music[playerid] = dUser(playername).("Music");
			ProfileContinue[playerid] = 10;
			GiveProfileOptions(playerid);
		}
		case 10:
		{
			dUserSet(playername).("Moreinfo",text);
	  		Moreinfo[playerid] = dUser(playername).("Moreinfo");
			ProfileContinue[playerid] = 11;
			GiveProfileOptions(playerid);
		}
	}
	return 1;
}

public GiveProfileOptions(playerid)
{
	switch(ProfileContinue[playerid])
	{
		case 2:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your age.");
		}
		case 3:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your gender.");
		}
		case 4:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your state / providence.");
		}
		case 5:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your country.");
		}
		case 6:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify what you like.");
		}
		case 7:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify what you dislike.");
		}
		case 8:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your favourite sports.");
		}
		case 9:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify your favourite music / bands.");
		}
		case 10:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Please specify more information about yourself.");
		}
		case 11:
		{
			SendClientMessage(playerid, COLOUR_GREEN, "Your profile has been configured. Have lots of fun!");
			SpawnPlayer(playerid);
			TogglePlayerControllable(playerid, true);
			return;
		}
	}
}