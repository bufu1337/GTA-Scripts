InstallInput(playerid, text[])
{
switch(ConfigContinue[playerid])
{
    	case 2:
	{
		switch(text[0])
		{
			case '0':
			{
			    AntiHealthHack = 0;
			    dini_IntSet(CONFIG_FILE, "AntiHealthHack",0);
 		          	    ConfigContinue[playerid] = 3;
 		  	    GiveConfigOptions(playerid);
			}
			case '1':
			{
			    AntiHealthHack = 1;
			    dini_IntSet(CONFIG_FILE,"AntiHealthHack",1);
	    	  	    ConfigContinue[playerid] = 3;
    		  	    GiveConfigOptions(playerid);
			}
		}
	}
	case 3:
	{
	    switch(text[0])
	    {
	    	case '0':
	    	{
	    	    AntiSpam = 0;
	    	    dini_IntSet(CONFIG_FILE,"AntiSpam",0);
    	          ConfigContinue[playerid] = 4;
    	   	    GiveConfigOptions(playerid);
		}
		case '1':
		{
		    AntiSpam = 1;
		    dini_IntSet(CONFIG_FILE,"AntiSpam",1);
    		    ConfigContinue[playerid] = 4;
    		    GiveConfigOptions(playerid);
		}
	    }
    	}
	case 4:
	{
		switch(text[0])
		{
			case '0':
			{
				AntiDriveBy = 0;
				dini_IntSet(CONFIG_FILE, "AntiDriveBy",0);
				ConfigContinue[playerid] = 5;
				GiveConfigOptions(playerid);
			}
			case '1':
			{
				AntiDriveBy = 1;
				dini_IntSet(CONFIG_FILE, "AntiDriveBy", 1);
				ConfigContinue[playerid] = 5;
				GiveConfigOptions(playerid);
			}
		}
	}
	case 5:
	{	
		switch(text[0])
		{
		 			case '1':
		    			{
		    	    		MaxDriveBys = 1;
		    	    		dini_IntSet(CONFIG_FILE,"MaxDriveBys",1);
      	  				ConfigContinue[playerid] = 6;
      	  				GiveConfigOptions(playerid);
					}
					case '2':
					{
					    MaxDriveBys = 2;
			    	    dini_IntSet(CONFIG_FILE,"MaxDriveBys",2);
    	  				ConfigContinue[playerid] = 6;
    	  				GiveConfigOptions(playerid);
					}
					case '3':
					{
					    MaxDriveBys = 3;
			    	    dini_IntSet(CONFIG_FILE,"MaxDriveBys",3);
    	  				ConfigContinue[playerid] = 6;
    	  				GiveConfigOptions(playerid);
					}
					case '4':
					{
					    MaxDriveBys = 4;
			    	    dini_IntSet(CONFIG_FILE,"MaxDriveBys",4);
    	  				ConfigContinue[playerid] = 6;
    	  				GiveConfigOptions(playerid);
					}
					case '5':
					{
					    MaxDriveBys = 5;
			    	   dini_IntSet(CONFIG_FILE,"MaxDriveBys",5);
    	  				ConfigContinue[playerid] = 6;
    	  				GiveConfigOptions(playerid);
					}
				}
		
	}
		case 6:
		{
		    switch(text[0])
		    {
		    	case '0':
		    	{
		    	    AntiIntKill = 0;
		    	    dini_IntSet(CONFIG_FILE,"AntiIntKill",0);
				IntKillPunishment = 0;
			   	dini_IntSet(CONFIG_FILE,"IntKillPunishment",0);
       	  			ConfigContinue[playerid] = 8;
       	  			GiveConfigOptions(playerid);
			}
			case '1':
			{
			    AntiIntKill = 1;
				dini_IntSet(CONFIG_FILE,"AntiIntKill",1);
    	  			ConfigContinue[playerid] = 7;
    		  			GiveConfigOptions(playerid);
				}
			}
    		}
			case 7:
			{
			    switch(text[0])
			    {
			   	case '1':
			   	{
			   	    IntKillPunishment = 1;
			   	    dini_IntSet(CONFIG_FILE,"IntKillPunishment",1);
    	   			ConfigContinue[playerid] = 8;
    	   			GiveConfigOptions(playerid);
				}
				case '2':
				{
			   	    IntKillPunishment = 2;
			  	    dini_IntSet(CONFIG_FILE,"IntKillPunishment",2);
    				ConfigContinue[playerid] = 8;
    				GiveConfigOptions(playerid);
				}
				case '3':
				{
			   	    IntKillPunishment = 3;
			   	    dini_IntSet(CONFIG_FILE,"IntKillPunishment",3);
    				ConfigContinue[playerid] = 8;
    				GiveConfigOptions(playerid);
				}
			}
		}
		case 8:
		{
		    switch(text[0])
		    {
		    	case '0':
		    	{
		    	    ProfileAllowed = 0;
		    	    dini_IntSet(CONFIG_FILE,"ProfileAllowed",0);
      	  		    ConfigContinue[playerid] = 9;
      	  		    GiveConfigOptions(playerid);
			}
			case '1':
			{
				ProfileAllowed = 1;
				dini_IntSet(CONFIG_FILE, "ProfileAllowed",1);
    	  			ConfigContinue[playerid] = 9;
    	  			GiveConfigOptions(playerid);
			}
		    }
		}
		
		case 9:
		{
		    if ((strcmp("end", text, true, strlen(text)) == 0) && (strlen(text) == strlen("end")))
		    {
                ConfigContinue[playerid] = 10;
	  			GiveConfigOptions(playerid);
	  			return 1;
		    }
		    if ((strcmp("cheaterwatch", text, true, strlen(text)) == 0) && (strlen(text) == strlen("cheaterwatch")))
		    {
                			fremove(CLANBAN_FILE);
                			fcopy(CW_CLANBAN_FILE,CLANBAN_FILE);
				ConfigContinue[playerid] = 10;
	  			GiveConfigOptions(playerid);
	  			return 1;
		    }
		    if(fexist(CLANBAN_FILE))
			{
				new File:fhandle;
				new temp[256];
				fhandle = fopen(CLANBAN_FILE,io_append);
				format(temp,sizeof(temp),"%s",text);
				fwrite(fhandle,temp);
				fclose(fhandle);
			}
		}
		case 10:
		{
		    if ((strcmp("end", text, true, strlen(text)) == 0) && (strlen(text) == strlen("end")))
		    {
                ConfigContinue[playerid] = 11;
	  			GiveConfigOptions(playerid);
	  			return 1;
		    }
		    if ((strcmp("cheaterwatch", text, true, strlen(text)) == 0) && (strlen(text) == strlen("cheaterwatch")))
		    {
                fremove(PLAYERBAN_FILE);
                fcopy(CW_BAN_FILE,PLAYERBAN_FILE);
				ConfigContinue[playerid] = 11;
	  			GiveConfigOptions(playerid);
	  			return 1;
		    }
		    if(fexist(PLAYERBAN_FILE))
			{
				new File:fhandle;
				new temp[256];
				fhandle = fopen(PLAYERBAN_FILE,io_append);
				format(temp,sizeof(temp),"%s",text);
				fwrite(fhandle,temp);
				fclose(fhandle);
			}
		}
	}
return 1;
}

public GiveConfigOptions(playerid) // Displays information for the player configuring Delta
{
	  switch(ConfigContinue[playerid])
	  {
	  	case 2:
		{
			SendClientMessage(playerid, COLOUR_YELLOW, "Step 1 = Configuration file");
			SendClientMessage(playerid, COLOUR_GREY, "Anti health hack (0 or 1)?");
		}
		case 3:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Anti spam protection (0 Or 1)?");
		}
		case 4:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Anti drive-by abuse (0 Or 1)?");
		}
		case 5:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Max Driveby's (0 - 5)?");
		}
		case 6:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Anti interior kill (0 Or 1)?");
		}
 		case 7:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Punishment for interior killers (Kick = 1, Ban = 2, Reset = 3)?");
		}
		case 8:
		{
			SendClientMessage(playerid, COLOUR_GREY, "Allow player profiles (0 Or 1)?");
		}
		case 9:
		{
			SendClientMessage(playerid, COLOUR_YELLOW, "Step 2 = Clanban file");
			SendClientMessage(playerid, COLOUR_GREY, "Please specify the clans you dont want on this server.");
			SendClientMessage(playerid, COLOUR_GREY, "Eg. [CKB](New Line)[FTW] then when finished type 'end'");
			SendClientMessage(playerid, COLOUR_GREEN, "Available Libraries (Using a library will delete existing data):");
			SendClientMessage(playerid, COLOUR_GREY, "You can type 'cheaterwatch' to use their library");
		}
		case 10:
		{
			SendClientMessage(playerid, COLOUR_YELLOW, "Step 3 = Player Ban file");
			SendClientMessage(playerid, COLOUR_GREY, "Please specify the players you dont want on this server.");
			SendClientMessage(playerid, COLOUR_GREY, "Eg. 'cereal'(New Line)'wang' then when finished type 'end'");
			SendClientMessage(playerid, COLOUR_GREEN, "Available Libraries (Using a library will delete existing data):");
			SendClientMessage(playerid, COLOUR_GREY, "You can type 'cheaterwatch' to use their library");
		}
		case 11:
		{
			SendClientMessage(playerid, COLOUR_GREEN, "Delta All-In-One has been configured successfully!");
			SpawnPlayer(playerid);
			TogglePlayerControllable(playerid, true);
			ReadConfig();
			return;
		}
	}
}

public FindAnAdmin()  // Finds an admin because Delta has not been installed
{
    for(new i = 0; i <= MAX_PLAYERS; i++)
    {
		if(IsPlayerConnected(i))
		{
			if(IsPlayerAdmin(i) == 0) return;
			KillTimer(InstallRefresh);
			InstallPrivs = i;
			StartInstall();
			break;
		}
	}
}

StartInstall() // Starts the install for the first use of Delta
{
	new iName[256];
	GetPlayerName(InstallPrivs, iName, sizeof(iName));
	SendClientMessage(InstallPrivs, COLOUR_GREY, "SERVER: Delta AllInOne requires installation");
	SendClientMessage(InstallPrivs, COLOUR_GREY, "SERVER: Please type /install to continue");
	InstallContinue[InstallPrivs] = 1;
}