/*================================================================================================
						Ultimate Phone system v1.0 by James_Alex, The cell phone
					    			 system, SMS, call, save calls...
											by: James_Alex.
==================================================================================================*/

//=======================================|Includes|================================================//
#include <a_samp>
#include <dini>
//=======================================|Defines|================================================//
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x9EC73DAA
#define COLOR_GROVE 0x00FF00FF
#define COLOR_RED 0xAA3333AA
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_LIGHTGREEN 0x9ACD32AA
#define COLOR_YELLOW 0xDABB3EAA
#define COLOR_YELLOW2 0xF5DEB3AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define COLOR_NEWS 0x458E1DAA
#define COLOR_AMOD 0x00FF00FF
#define COLOR_ALVL2 0xFFFF80FF
#define COLOR_ALVL3 0xFFFF00FF
#define COLOR_ALVL4 0xFF8040FF
#define COLOR_ALEAD 0x8080FFFF
//=======================================|Forwards|================================================//
forward HangPhone(playerid);
forward Call(playerid, number);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
forward SMS(playerid, number, message[]);
forward SendSMS(playerid, target, message[]);
forward SendSMSF(playerid);
forward AddNumb(playerid, number, name[]);
forward AddToCall(playerid, target);
forward CallCost(playerid, target);
//=======================================|News|================================================//
new pCalled[MAX_PLAYERS];
new pPhone[MAX_PLAYERS];
new cName[MAX_PLAYERS][128];
new cCost[MAX_PLAYERS];
//=======================================|Enums|================================================//
enum pPh
{
	pNumber,
	pOwnPhone,
	pOwnChip,
};
new PlayerPhone[MAX_PLAYERS][pPh];
//=======================================|Others|================================================//
public OnFilterScriptInit()
{
	print("\n               |==================================================|");
	print("               | James_Alex's Phone filterscript Loaded succefully|");
	print("               |==================================================|\n");
	return 1;
}

public OnFilterScriptExit()
{

	return 1;
}

public OnPlayerConnect(playerid)
{
	pCalled[playerid] = 255;
	pPhone[playerid] = 255;
	PlayerPhone[playerid][pOwnPhone] = 0;
 	PlayerPhone[playerid][pOwnChip] = 0;
 	cCost[playerid] = 0;
	new string[128], Nstr[128];
	new str[256], plname[MAX_PLAYER_NAME], str2[256], str3[256];
	GetPlayerName(playerid, plname, sizeof(plname));
	format(str, sizeof(str), "Phones/Users/%s.ini", plname);
	format(str2, sizeof(str2), "Phones/Calls/%s.ini", plname);
	format(str3, sizeof(str3), "Phones/Friends/%s.ini", plname);
	if(dini_Exists(str))
	{
	    PlayerPhone[playerid][pNumber] = dini_Int(str, "number");
	    PlayerPhone[playerid][pOwnPhone] = dini_Int(str, "OwnPhone");
	    PlayerPhone[playerid][pOwnChip] = dini_Int(str, "OwnChip");
	    if(PlayerPhone[playerid][pOwnChip] == 1)
	    {
			format(string, 128, "Your phone number is %d", PlayerPhone[playerid][pNumber]);
	    	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	    	if(dini_Exists(str2))
	    	{
	        	if(dini_Exists(str3))
	        	{
	        	}
	        	else
	        	{
	            	dini_Create(str3);
					format(Nstr, 128, "%d", PlayerPhone[playerid][pNumber]);
					dini_Set(str3, Nstr, plname);
	            	return 1;
				}
	    	}
	    	else
	    	{
	        	dini_Create(str2);
				new File:cFile;
				cFile = fopen(str2, io_append);
				fwrite(cFile, "Your phone calls:");
				fwrite(cFile, "\r\n");
				fwrite(cFile, "-------------------------------------------------------------");
				fwrite(cFile, "\r\n");
				fclose(cFile);
	        	if(dini_Exists(str3))
	        	{
	        	}
	        	else
	        	{
	            	dini_Create(str3);
					format(Nstr, 128, "%d", PlayerPhone[playerid][pNumber]);
					dini_Set(str3, Nstr, plname);
					return 1;
				}
				return 1;
	    	}
			return 1;
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_LIGHTBLUE, "Go buy a chip in the 24/7");
	    	if(dini_Exists(str2))
	    	{
	        	if(dini_Exists(str3))
	        	{
	        	}
	        	else
	        	{
	            	dini_Create(str3);
					format(Nstr, 128, "%d", PlayerPhone[playerid][pNumber]);
					dini_Set(str3, Nstr, plname);
					return 1;
				}
	    	}
	    	else
	    	{
	        	dini_Create(str2);
				new File:cFile;
				cFile = fopen(str2, io_append);
				fwrite(cFile, "Your phone calls:");
				fwrite(cFile, "\r\n");
				fwrite(cFile, "-------------------------------------------------------------");
				fwrite(cFile, "\r\n");
				fclose(cFile);
	        	if(dini_Exists(str3))
	        	{
	        	}
	        	else
	        	{
	            	dini_Create(str3);
					format(Nstr, 128, "%d", PlayerPhone[playerid][pNumber]);
					dini_Set(str3, Nstr, plname);
					return 1;
				}
				return 1;
	    	}

	    }

	}
	else
	{
	    new numb;
	    numb = random(999999);
	    PlayerPhone[playerid][pNumber] = numb;
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, "Go buy a chip and a phone in the 24/7");
	    dini_Create(str);
    	if(dini_Exists(str2))
    	{
    		if(dini_Exists(str3))
     		{
      		}
       		else
        	{
        		dini_Create(str3);
         		return 1;
			}
  		}
   		else
    	{
    		dini_Create(str2);
			new File:cFile;
			cFile = fopen(str2, io_append);
			fwrite(cFile, "Your phone calls:");
			fwrite(cFile, "\r\n");
			fwrite(cFile, "-------------------------------------------------------------");
			fwrite(cFile, "\r\n");
			fclose(cFile);
     		if(dini_Exists(str3))
      		{
       		}
        	else
        	{
        		dini_Create(str3);
         		return 1;
			}
			return 1;
  		}
		return 1;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new tmp[256];
	new idx;
	new cmd[256];
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/phone", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
		    SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone [Action]");
		    SendClientMessage(playerid, COLOR_GREY, "Actions: call, sms, addnumber, mynumbers, getcalls, pickup, hangup");
		    SendClientMessage(playerid, COLOR_GREY, "Actions: clearnumbers, clearcalls");
			return 1;
		}
		if(strcmp(tmp, "call", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You are already in a call !");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
		    	SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone call [number]");
				return 1;
			}
			new num;
			num = strval(tmp);
			//if(nt != 6) { SendClientMessage(playerid, COLOR_LIGHTRED, "Number must be with only 6 numbers !"); return 1; }
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			Call(playerid, num);
			return 1;
		}
		if(strcmp(tmp, "sms", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You are already in a call !");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
		    	SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone sms [number] [message]");
				return 1;
			}
			new num;
			num = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone sms [number] [message]");
				return 1;
			}
			if(PlayerPhone[playerid][pNumber] == (num))
			{
				SendClientMessage(playerid, COLOR_GREY, "Sending...");
				SetTimerEx("SendSMS", 5000, false, "iis", playerid, playerid, result);
				return 1;
		    }
		    else
		    {
		  		SMS(playerid, num, result);
			}
			return 1;
		}
		if(strcmp(tmp, "hangup", true) == 0)
		{
			if(pCalled[playerid] == 255 && pPhone[playerid] == 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You haven't recived a call !");
			    return 1;
			}
			SendClientMessage(pPhone[playerid], COLOR_GREY, "They hang up...");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			SetPlayerSpecialAction(pPhone[playerid], SPECIAL_ACTION_STOPUSECELLPHONE);
			SendClientMessage(pCalled[playerid], COLOR_GREY, "They hang up...");
			if(cCost[playerid] == 0)
			{
				GivePlayerMoney(pPhone[playerid], -cCost[pPhone[playerid]]);
				format(string, 128, "~w~Call Cost: ~n~~r~$%d", cCost[pPhone[playerid]]);
				GameTextForPlayer(cCost[pPhone[playerid]], string, 6000, 3);
				return 1;
			}
			else
			{
				GivePlayerMoney(playerid, -cCost[playerid]);
				format(string, 128, "Call Cost: $%d", cCost[playerid]);
				GameTextForPlayer(playerid, string, 6000, 3);
			}
			pCalled[pCalled[playerid]] = 255;
			pPhone[pPhone[playerid]] = 255;
	    	pPhone[playerid] = 255;
			pCalled[playerid] = 255;
			SendClientMessage(playerid, COLOR_GREY, "You hang up .");
   		 	return 1;
		}
		if(strcmp(tmp, "pickup", true) == 0)
		{
			if(pPhone[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You are already in a call !");
			    return 1;
			}
			if(pCalled[playerid] == 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You haven't recived a call !");
			    return 1;
			}
			SendClientMessage(pCalled[playerid], COLOR_GREY, "They pick up...");
			pPhone[pCalled[playerid]] = playerid;
	    	pPhone[playerid] = pCalled[playerid];
			pCalled[pCalled[playerid]] = 255;
	    	pCalled[playerid] = 255;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendClientMessage(playerid, COLOR_GREY, "You pick up .");
   		 	return 1;
		}
		if(strcmp(tmp, "clearnumbers", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't clear numbers in a call !");
			    return 1;
			}
  			new strF[256];
			new plname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, plname, sizeof(plname));
			format(strF, sizeof(strF), "Phones/Friends/%s.ini", plname);
			new File: nFile;
			nFile = fopen(strF, io_write);
			fwrite(nFile, ""); new Nstr[128];
			format(Nstr, 128, "%d", PlayerPhone[playerid][pNumber]);
			dini_Set(strF, Nstr, plname);
			SendClientMessage(playerid, COLOR_GREY, "You cleared your numbers list.");
			return 1;
		}
		if(strcmp(tmp, "addnumber", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't add number in a call !");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
		    	SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone addnumber [number] [name]");
		    	SendClientMessage(playerid, COLOR_GREY, "NOTE: type 'name' to register the number with his original name.");
				return 1;
			}
			new num;
			num = strval(tmp);
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
		    	SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone addnumber [number] [name]");
		    	SendClientMessage(playerid, COLOR_GREY, "NOTE: type 'name' to register the number with his original name.");
				return 1;
			}
			if(PlayerPhone[playerid][pNumber] == 54)
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You can't add yourself !");
				return 1;
		    }
		    else
		    {
            	new strF[256];
				new plname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, plname, sizeof(plname));
				format(strF, sizeof(strF), "Phones/Friends/%s.ini", plname);
				new Nstr[128];
				format(Nstr, 128, "%d", num);
				if(strcmp(dini_Get(strF, Nstr), " ", true) == 0)
				{
					AddNumb(playerid, num, result);
					return 1;
				}
				else
				{
					SendClientMessage(playerid, COLOR_LIGHTRED, "This number is already in your list !");
					//return 1;
				}
			}
			return 1;
		}
		if(strcmp(tmp, "mynumbers", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255 && pPhone[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't see numbers in a call !");
			    return 1;
			}
		 	new Fstring[100], strF[256];
			new plname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, plname, sizeof(plname));
			format(strF, sizeof(strF), "Phones/Friends/%s.ini", plname);
			SendClientMessage(playerid, COLOR_GREEN, "numbers = names");
			SendClientMessage(playerid, COLOR_GREEN, "-------------------------");
			new File: nFile;
			if((nFile = fopen(strF, io_read)))
			{
				while(fread(nFile,Fstring))
				{
					for(new i = 0, j = strlen(Fstring); i < j; i++) if(Fstring[i] == '\n' || Fstring[i] == '\r') Fstring[i] = '\0';
					new Nstr[128];
					format(Nstr, 128, "%s", Fstring);
					SendClientMessage(playerid, COLOR_WHITE, Nstr);
				}
				fclose(nFile);
			}
			return 1;
		}
		if(strcmp(tmp, "getcalls", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255 && pPhone[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't get calls in a call !");
			    return 1;
			}
		 	new Fstring[100], strF[256];
			new plname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, plname, sizeof(plname));
			format(strF, sizeof(strF), "Phones/Calls/%s.ini", plname);
			new File: nFile;
			if((nFile = fopen(strF, io_read)))
			{
				while(fread(nFile,Fstring))
				{
					for(new i = 0, j = strlen(Fstring); i < j; i++) if(Fstring[i] == '\n' || Fstring[i] == '\r') Fstring[i] = '\0';
					new Nstr[128];
					format(Nstr, 128, "%s", Fstring);
					SendClientMessage(playerid, COLOR_WHITE, Nstr);
				}
				fclose(nFile);
			}
		}
		if(strcmp(tmp, "clearcalls", true) == 0)
		{
			if(PlayerPhone[playerid][pOwnPhone] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a phone !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 0)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You don't own a chip !");
			    return 1;
			}
			if(pCalled[playerid] != 255)
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You can't clear calls in a call !");
			    return 1;
			}
  			new strF[256];
			new plname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, plname, sizeof(plname));
			format(strF, sizeof(strF), "Phones/Calls/%s.ini", plname);
			new File: nFile;
			nFile = fopen(strF, io_write);
			fwrite(nFile, "Your phone calls:");
			fwrite(nFile, "\r\n");
			fwrite(nFile, "-------------------------------------------------------------");
			fwrite(nFile, "\r\n");
			SendClientMessage(playerid, COLOR_GREY, "You cleared your calls list.");
			return 1;
		}
  		SendClientMessage(playerid, COLOR_GREY, "USAGE: /phone [Action]");
    	SendClientMessage(playerid, COLOR_GREY, "Actions: call, sms, addnumber, mynumbers, getcalls, pickup, hangup");
	    SendClientMessage(playerid, COLOR_GREY, "Actions: clearnumbers, clearcalls");
		return 1;
	}
	if(strcmp(cmd, "//buy", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
		    SendClientMessage(playerid, COLOR_GREY, "USAGE: //buy [phone/chip]");
		    return 1;
		}
		if(strcmp(tmp, "chip", true) == 0)
		{
			if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in a 24-7 !");
				return 1;
			}
			if(GetPlayerMoney(playerid) < 5000)
		    {
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You haven't enough money($5000) !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnChip] == 1)
		    {
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You already own a chip !");
			    return 1;
			}
			PlayerPhone[playerid][pOwnChip] = 1;
			format(string, sizeof(string), "You bought a chip for $5000, your number is now %d", PlayerPhone[playerid][pNumber]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
			GivePlayerMoney(playerid, -5000);
			return 1;
		}
		if(strcmp(tmp, "phone", true) == 0)
		{
			if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))
			{
				SendClientMessage(playerid, COLOR_LIGHTRED, "You are not in a 24-7 !");
				return 1;
			}
			if(GetPlayerMoney(playerid) < 10000)
		    {
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You haven't enough money($10000) !");
			    return 1;
			}
			if(PlayerPhone[playerid][pOwnPhone] == 1)
		    {
			    SendClientMessage(playerid, COLOR_LIGHTRED, "You already own a phone !");
			    return 1;
			}
			PlayerPhone[playerid][pOwnPhone] = 1;
			SendClientMessage(playerid, COLOR_YELLOW, "You bought a phone for $10000, you can now call your friends");
			GivePlayerMoney(playerid, -10000);
			return 1;
		}
		SendClientMessage(playerid, COLOR_LIGHTRED, "Use '//buy [phone/chip]' !");
		return 1;
	}
	return 0;
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

public Call(playerid, number)
{
	if(IsPlayerConnected(playerid))
	{
		if(number == PlayerPhone[playerid][pNumber])
		{
		    SendClientMessage(playerid, COLOR_GREY, "You have juste called yourself !");
		    SetTimerEx("HangPhone", 5000, false, "d", playerid);
		    return 1;
		}
		else
		{
			for(new i = 0; i < MAX_PLAYERS; i ++)
	    	{
	        	if(IsPlayerConnected(i))
	        	{
	            	if(PlayerPhone[i][pNumber] == number && pCalled[i] == 255 && pPhone[i] == 255)
	            	{
	                	pCalled[playerid] = i;
	                	pCalled[i] = playerid;
	                	new str[128], str2[128];
	                	new cstr[128]; format(cstr, 128, "%d", number);
	                	new ctext[128];
						new plname[MAX_PLAYER_NAME];
						GetPlayerName(i, plname, sizeof(plname));
						format(str2, sizeof(str2), "Phones/Friends/%s.ini", plname);
						strmid(ctext, dini_Get(str2, cstr), 0, strlen(dini_Get(str2, cstr)), 255);
						if(strcmp(ctext, " ", true) == 0)
	                	{
	                		format(str, 128, "Your mobile is ringing, caller: %d (use /phone pickup, hangup).", PlayerPhone[playerid][pNumber]);
	                		SendClientMessage(i, COLOR_GREY, str);
	                		format(str, 128, "Your are calling %d, wait for his answer.", number);
	                		SendClientMessage(playerid, COLOR_GREY, str);
	                		PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
	                		strmid(cName[i], PlayerPhone[playerid][pNumber], 0, strlen(PlayerPhone[playerid][pNumber]), 255);
	                		SetTimerEx("CallCost", 100, true, "ii", playerid, i);
	                		AddToCall(playerid, i);
						}
						else
						{
	                		format(str, 128, "Your mobile is ringing, caller: %s (use /phone pickup, hangup).", ctext);
	                		SendClientMessage(i, COLOR_GREY, str);
	                		format(str, 128, "Your are calling %d, wait for his answer.", number);
	                		SendClientMessage(playerid, COLOR_GREY, str);
	                		PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
	                		strmid(cName[i], ctext, 0, strlen(ctext), 255);
	                		SetTimerEx("CallCost", 100, true, "ii", playerid, i);
	                		AddToCall(playerid, i);
	                	}
					}
	            	else
	            	{
	                	SendClientMessage(playerid, COLOR_GREY, "You get a busy tone or you have typed a wrong number !");
	                	SetTimerEx("HangPhone", 5000, false, "d", playerid);
					}
				}
			}
			return 1;
		}
		//return 1;
    }
    return 0;
}

public AddToCall(playerid, target)
{
	new pName[MAX_PLAYER_NAME], tName[MAX_PLAYER_NAME];
	new ptext[MAX_PLAYERS][20], ttext[MAX_PLAYERS][20];
	GetPlayerName(playerid, pName, sizeof(pName)); GetPlayerName(target, tName, sizeof(tName));
	ttext[target] = "calls you"; ptext[playerid] = "you called";
	new day, month, year, sec, minu, hour;
	gettime(hour, minu, sec); getdate(year, month, day);
	new str[256], str2[256];
	format(str, sizeof(str), "Phones/Calls/%s.ini", tName);	format(str2, sizeof(str2), "Phones/Calls/%s.ini", pName);
	new string[128];
	format(string, 128, "%s %s in: %d/%d/%d at: %d:%d:%d", cName[target], ttext[target], day, month, year, hour, minu, sec);
	new File:cFile;
	cFile = fopen(str, io_append);
	fwrite(cFile, string);
	fwrite(cFile, "\r\n");
	fclose(cFile);
	format(string, 128, "%s %s in: %d/%d/%d at: %d:%d:%d", ptext[playerid], cName[playerid], day, month, year, hour, minu, sec);
	new File:cFile2;
	cFile2 = fopen(str2, io_append);
	fwrite(cFile2, string);
	fwrite(cFile2, "\r\n");
	fclose(cFile2);
	return 1;
}

public CallCost(playerid, target)
{
	if(IsPlayerConnected(playerid))
	{
		if(pPhone[playerid] != 255)
  		{
    		cCost[playerid] += 1;
      		return 1;
    	}
	    else
	    {
     		cCost[playerid] = 0;
       		return 1;
	    }
	}
	return 1;
}

public AddNumb(playerid, number, name[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new i = 0; i < MAX_PLAYERS; i ++)
 		{
  			if(IsPlayerConnected(i))
    		{
     			if(PlayerPhone[i][pNumber] == number && PlayerPhone[i][pOwnPhone] == 1 && PlayerPhone[i][pOwnChip] == 1)
       			{
					new str[128], Fstr[256], num[128], pname[MAX_PLAYER_NAME];
					GetPlayerName(playerid, pname, sizeof(pname));
					format(num, 128, "%d", number);
					format(Fstr, sizeof(Fstr), "Phones/Friends/%s.ini", pname);
          			dini_Set(Fstr, num, name);
          			format(str, 128, "You have added %s((%d)).", name, number);
          			SendClientMessage(playerid, COLOR_YELLOW, str);
           		}
            	else
            	{
            		SendClientMessage(playerid, COLOR_GREY, "Unfinded number !");
           		}
			}
		}
		return 1;
    }
    return 0;
}

public SMS(playerid, number, message[])
{
	if(IsPlayerConnected(playerid))
	{
		for(new i = 0; i < MAX_PLAYERS; i ++)
 		{
  			if(IsPlayerConnected(i))
    		{
     			if(PlayerPhone[i][pNumber] == number && pCalled[i] == 255 && pPhone[playerid] == 255)
       			{
					SendClientMessage(playerid, COLOR_GREY, "Sending...");
					SetTimerEx("SendSMS", 5000, false, "iis", playerid, i, message);
    			}
      			else
        		{
         			SendClientMessage(playerid, COLOR_GREY, "Sending...");
           			SetTimerEx("SendSMSF", 5000, false, "i", playerid);
				}
	        }
		}
	}
    return 1;
}

public SendSMS(playerid, target, message[])
{
	new msg[128];
	format(msg, 128, "%s", message);
	new str2[256];
	new cstr[128]; format(cstr, 128, "%d", PlayerPhone[playerid][pNumber]);
	new ctext[128];
	new plname[MAX_PLAYER_NAME];
	GetPlayerName(target, plname, sizeof(plname));
	format(str2, sizeof(str2), "Phones/Friends/%s.ini", plname);
	strmid(ctext, dini_Get(str2, cstr), 0, strlen(dini_Get(str2, cstr)), 255);
	if(strcmp(ctext, " ", true) == 0)
	{
 		strmid(cName[target], PlayerPhone[playerid][pNumber], 0, strlen(PlayerPhone[playerid][pNumber]), 255);
 		return 1;
	}
	else
	{
 		strmid(cName[target], ctext, 0, strlen(ctext), 255);
	}
	new string[128];
	format(string, 128, "SMS from %s:((%s))", cName[target], msg);
	SendClientMessage(target, COLOR_WHITE, string);
	GivePlayerMoney(playerid, -60);
	GameTextForPlayer(playerid, "~w~SMS sended ~n~~r~-$60", 8000, 3);
	return 1;
}

public SendSMSF(playerid)
{
	SendClientMessage(playerid, COLOR_GREY, "You have typed a wrong number or this number is in a call !");
	return 1;
}

public HangPhone(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[128];
	if(pPhone[playerid] != 255)
	{
		format(string, sizeof(string), "%s(phone):((%s))", cName[pPhone[playerid]], text);
		SendClientMessage(pPhone[playerid], COLOR_WHITE, string);
		new str2[256];
		new cstr[128]; format(cstr, 128, "%d", PlayerPhone[pPhone[playerid]][pNumber]);
		new ctext[128];
		new plname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, plname, sizeof(plname));
		format(str2, sizeof(str2), "Phones/Friends/%s.ini", plname);
		strmid(ctext, dini_Get(str2, cstr), 0, strlen(dini_Get(str2, cstr)), 255);
		if(strcmp(ctext, " ", true) == 0)
		{
 			strmid(cName[playerid], PlayerPhone[pPhone[playerid]][pNumber], 0, strlen(PlayerPhone[pPhone[playerid]][pNumber]), 255);
 			return 1;
		}
		else
		{
 			strmid(cName[playerid], ctext, 0, strlen(ctext), 255);
		}
		format(string, sizeof(string), "%s(phone):((%s))", cName[playerid], text);
		SendClientMessage(playerid, COLOR_WHITE, string);
		return 0;
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(pPhone[playerid] != 255)
	{
		SendClientMessage(pPhone[playerid], COLOR_GREY, "They hang up...");
		pPhone[pPhone[playerid]] = 255;
	    pPhone[playerid] = 255;
	    return 1;
	}
	if(pCalled[playerid] != 255)
	{
		SendClientMessage(pCalled[playerid], COLOR_GREY, "They hang up...");
		pCalled[pCalled[playerid]] = 255;
	    pCalled[playerid] = 255;
	    return 1;
	}
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	new str[256], plname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, plname, sizeof(plname));
	format(str, sizeof(str), "Phones/Users%s.ini", plname);
	dini_IntSet(str, "number", PlayerPhone[playerid][pNumber]);
	dini_IntSet(str, "OwnPhone", PlayerPhone[playerid][pOwnPhone]);
	dini_IntSet(str, "OwnChip", PlayerPhone[playerid][pOwnChip]);
	if(pPhone[playerid] != 255)
	{
		SendClientMessage(pPhone[playerid], COLOR_GREY, "They hang up...");
		pPhone[pPhone[playerid]] = 255;
	    pPhone[playerid] = 255;
	    return 1;
	}
	if(pCalled[playerid] != 255)
	{
		SendClientMessage(pCalled[playerid], COLOR_GREY, "They hang up...");
		pCalled[pCalled[playerid]] = 255;
	    pCalled[playerid] = 255;
	    return 1;
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
