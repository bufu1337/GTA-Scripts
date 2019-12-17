/*

------------Laptop System by Compton's_Eazy_E-------------

*/

#include <a_samp>
#include <dini>
#include "../include/gl_common.inc"

new InChat[MAX_PLAYERS];
forward LapUsersMssg(color,const string[]);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

new RandomMSG[][] =
{
    "Have Fun Web Searching!",
    "Porn, No Way Turn your internet off!",
    "Page Could Not Load",
    "Page Detected as a Malaware/Spyware Firefox will not let you continue!",
    "You Got Rick Roll'd!"
};

public OnPlayerText(playerid, text[])
{
    if(InChat[playerid] == 1)
    {
        new string[128];
  		new name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(string, sizeof(string), "%s.ini", name );
		new virus = dini_Int(string, "Virus");
		if(virus == 1)
		{
 		SendClientMessage(playerid, 0xFFFFFFFF, "Your Computer is Infected With Win32:Vitro!");
 		return 0;
		}
		new strings[56];
		GetPlayerName(playerid, name, sizeof(name));
  		format(strings, sizeof(strings), "[MSN %s] says: %s", name, text);
	 	LapUsersMssg(0xDEEE20FF, strings);
	 	new types[56];
	 	format(types, sizeof(types), "%s types on his laptop", name);
	 	ProxDetector(20.0, playerid, types, 0xDEEE20FF,0xDEEE20FF,0xDEEE20FF,0xDEEE20FF,0xDEEE20FF);
        return 0;
	}
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new idx;
	new tmp[256];
	new gMessage[256];
	new Message[128];
	new iName[128];
	new pName[128];
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd, "/lad", true) == 0 || strcmp(cmd, "/ladvertise", true) == 0)
		{
		    new string[128];
  			new name[MAX_PLAYER_NAME];
  			GetPlayerName(playerid, name, sizeof(name));
	 		format(string, sizeof(string), "%s.ini", name );
			new virus = dini_Int(string, "Virus");
			if(virus == 1)
			{
    		SendClientMessage(playerid, 0xFFFFFFFF, "Your Computer is Infected With Win32:Vitro!");
    		return 0;
			}
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
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
				SendClientMessage(playerid, 0xDEEE20FF, "USAGE: /[ad]vertise [TEXT]");
				return 1;
			}
			new pNames[MAX_PLAYER_NAME];
    		GetPlayerName(playerid, pNames, sizeof(pNames));
			format(string,sizeof(string), "[Popup by %s]: %s",pNames, result);
			LapUsersMssg(0xDEEE20FF, result);
		 	new types[56];
		 	format(types, sizeof(types), "%s types on his laptop", name);
		 	ProxDetector(20.0, playerid, types, 0xDEEE20FF,0xDEEE20FF,0xDEEE20FF,0xDEEE20FF,0xDEEE20FF);
			}
    		return 1;
     	}
	if(strcmp("/email", cmd, true) == 0)
	{
		tmp = strtok(cmdtext,idx);

		if(!strlen(tmp) || strlen(tmp) > 5) {
			SendClientMessage(playerid,0xDEEE20FF,"/email (id) (message)");
			return 1;
		}

		new id = strval(tmp);
        gMessage = strrest(cmdtext,idx);

		if(!strlen(gMessage)) {
			SendClientMessage(playerid,0xDEEE20FF,"/email (id) (message)");
			return 1;
		}
		if(playerid != id)
		{
		    new name[MAX_PLAYER_NAME];
			new string[56];
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
				GetPlayerName(id,iName,sizeof(iName));
				GetPlayerName(playerid,pName,sizeof(pName));
				format(Message,sizeof(Message),"[YOU GOT MAIL!] %s(%d): %s",iName,id,gMessage);
				SendClientMessage(playerid,0xDEEE20FF,Message);
				format(Message,sizeof(Message),"[MESSAGE SENT!] %s(%d): %s",pName,playerid,gMessage);
				SendClientMessage(id,0xDEEE20FF,Message);
			}
			else
			{
			
			}
		}
		else
		{
			GetPlayerName(id,iName,sizeof(iName));
			GetPlayerName(playerid,pName,sizeof(pName));
			format(Message,sizeof(Message),"[YOU GOT MAIL!] %s(%d): %s",iName,id,gMessage);
			SendClientMessage(playerid,0xDEEE20FF,Message);
			format(Message,sizeof(Message),"[MESSAGE SENT!] %s(%d): %s",pName,playerid,gMessage);
			SendClientMessage(id,0xDEEE20FF,Message);
		}
		return 1;
	}
	if (strcmp(cmd, "/laptophelp", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: :: Commands :: - /about, /buylaptop, /selllaptop, /email, /chatroom");
      		SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: :: Commands :: - /leaveroom, /[lad]vertise, /internet, /buyantivirus");
      		SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: :: Commands :: - /runCD");
	        return 1;
		}
	}
	if (strcmp(cmd, "/internet", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new name[MAX_PLAYER_NAME];
			new string[56];
  			GetPlayerName(playerid, name, sizeof(name));
	 		format(string, sizeof(string), "%s.ini", name );
			new virus = dini_Int(string, "Virus");
			if(virus == 1)
			{
    		SendClientMessage(playerid, 0xFFFFFFFF, "Your Computer is Infected With Win32:Vitro!");
    		return 0;
			}
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
   				new s[128];
			    new loginname[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,loginname,MAX_PLAYER_NAME);
			    format(s,sizeof(s),"Welcome %s to Firefox\nPowered by Mozilla\nInternet Explorer is trash\nThats why you downloaded\nThis Browser!",loginname);
			    ShowPlayerDialog(playerid,1,DIALOG_STYLE_INPUT,"Type in Your Web Address",s,"Go","Cancel");
			}
			else
			{
	    		SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Don't Have a Laptop!");
			}
		}
	}
	if (strcmp(cmd, "/runCD", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	    	new name[MAX_PLAYER_NAME];
			new string[56];
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new hasanti = dini_Int(string, "AntiVirus");
			if(hasanti == 1)
			{
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Running CD......");
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Avast Anti-Virus Loaded..");
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Removing Virus!");
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Removal Complete!");
			    dini_IntSet(string, "Virus", 0);
			}
			else
			{
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: you dont have avast!");
			}
		}
	}
	if (strcmp(cmd, "/leaveroom", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new name[MAX_PLAYER_NAME];
			new string[56];
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
			    format(string, sizeof(string), "%s Has Left the Chatroom!", name );
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You left the chat room to rejoin type /chatroom");
                LapUsersMssg(0xDEEE20FF, string);
                InChat[playerid] = 0;
			}
			else
			{
	    		SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Don't Have a Laptop!");
			}
		}
	}
	if (strcmp(cmd, "/chatroom", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new name[MAX_PLAYER_NAME];
			new string[56];
			GetPlayerName(playerid, name, sizeof(name));
		 	format(string, sizeof(string), "%s.ini", name );
			new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
			    format(string, sizeof(string), "%s Has Joined the Chatroom!", name );
			    SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Press F6 To Type A Message To The ChatRoom!");
                LapUsersMssg(0xDEEE20FF, string);
                InChat[playerid] = 1;
			}
			else
			{
	    		SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Don't Have a Laptop!");
			}
	    }
	}
	if (strcmp(cmd, "/about", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Laptop System Created By Comptons_Eazy_E");
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Credits to Dragoblue for dudb and and dini");
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Do not Remove Credits for Either Dragoblue or me (Comptons_Eazy_E)");
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: As Thing was released and downloaded from the sa-mp forums!");
	        SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: If you need help about the laptop system use /laptophelp");
		}
	}
	if (strcmp(cmd, "/buyantivirus", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(GetPlayerMoney(playerid) >= 5500)
	        {
	            if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53) || PlayerToPoint(100, playerid, -22.1740,-138.6172,1003.5469))//centerpoint 24-7
				{
	 				new name[MAX_PLAYER_NAME];
		            new string[56];
		            GetPlayerName(playerid, name, sizeof(name));
		            format(string, sizeof(string), "%s.ini", name );
				    GivePlayerMoney(playerid, -5500);
				    dini_IntSet(string, "AntiVirus", 1);
	            	SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Bought A Anti-Virus[AVAST]");
				}
				else
	            {
	                SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You're not at a 24-7");
				}
            }
	        else
	        {
	            SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Get some money [5500]");
	        }
		}
	}
	if (strcmp(cmd, "/buylaptop", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if(GetPlayerMoney(playerid) >= 3500)
	        {
	            if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53) || PlayerToPoint(100, playerid, -22.1740,-138.6172,1003.5469))//centerpoint 24-7
				{
	            new name[MAX_PLAYER_NAME];
	            new string[56];
	            GetPlayerName(playerid, name, sizeof(name));
	            printf("%s Bought a New Laptop!", name);
	            format(string, sizeof(string), "%s.ini", name );
	            dini_IntSet(string, "Laptop", 1);
	            SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You bought a laptop!");
	            GivePlayerMoney(playerid, -3500);
	            }
	            else
	            {
	                SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You're not at a 24-7");
				}
	        }
	        else
	        {
	            SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: Get some money [$3500]");
	        }
		}
	}
	if (strcmp(cmd, "/selllaptop", true) ==0 )
	{
	    if(IsPlayerConnected(playerid))
	    {
	        new name[MAX_PLAYER_NAME];
         	new string[56];
          	GetPlayerName(playerid, name, sizeof(name));
	        format(string, sizeof(string), "%s.ini", name );
         	new haslap = dini_Int(string, "Laptop");
			if(haslap == 1)
			{
			    if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53) || PlayerToPoint(100, playerid, -22.1740,-138.6172,1003.5469))//centerpoint 24-7
				{
   				printf("%s Sold his Laptop!", name);
	            dini_IntSet(string, "Laptop", 0);
	            SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Sold your laptop");
	            GivePlayerMoney(playerid, 3500);
	            }
	            else
	            {
	                SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You're not at a 24-7");
				}
			}
			else
			{
	            SendClientMessage(playerid, 0xDEEE20FF, "[ Eazy's Laptop System ]: You Don't Have a Laptop!");
	        }
		}
	}
	return 0;
}


public OnPlayerConnect(playerid)
{
	new string[50];
	new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    format(string, sizeof(string), "%s.ini", name );
    if(!dini_Exists(string))
	{
 		dini_Create(string);
	    dini_Set(string, "Laptop", "0");
	    dini_IntSet(string, "Virus", 0);
	    printf("%s Laptop File Created", name);
	}
	else
	{
        dini_Get(string, "Laptop");
        dini_Get(string, "Virus");
        printf("%s Laptop File Loaded", name);
	}
    return 1;
}

public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Laptop System by Compton's_Eazy_E Loaded");
    print("--------------------------------------\n");
    return 1;
}

public OnFilterScriptExit()
{
	print("\n--------------------------------------");
    print(" Laptop System by Compton's_Eazy_E UnLoaded");
	print("--------------------------------------\n");
	return 1;
}


public LapUsersMssg(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			new name[MAX_PLAYER_NAME];
			new strings[56];
			GetPlayerName(i, name, sizeof(name));
		 	format(strings, sizeof(strings), "%s.ini", name );
			new haslap = dini_Int(strings, "Laptop");
			if(haslap == 1 && InChat[i] == 1)
			{
			    SendClientMessage(i, color, string);
			    PlayerPlaySound(i,1085,0.0,0.0,0.0);
			}
		}
	}
	return 1;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
					GetPlayerPos(i, posx, posy, posz);
					tempposx = (oldposx -posx);
					tempposy = (oldposy -posy);
					tempposz = (oldposz -posz);
					//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col1, string);
						}
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
                        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
                        {
							SendClientMessage(i, col2, string);
						}
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col3, string);
						}
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
					    if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
					    {
							SendClientMessage(i, col4, string);
						}
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
                        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid))
                        {
							SendClientMessage(i, col5, string);
						}
					}
    	}
				else
				{
					SendClientMessage(i, col1, string);
				}
		}
	}//not connected
	return 1;
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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == 1)
    {
        if(!response) SendClientMessage(playerid, 0xFFFFFFFF, "You canceled!");
        new message[196];
        format(message, sizeof(message), "Firefox - Loading %s........", inputtext);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
        new randMSG = random(sizeof(RandomMSG)); 
		SendClientMessage(playerid, 0xFFFFFFFF, RandomMSG[randMSG]);
		new Rand = random(1);
  		new name[MAX_PLAYER_NAME];
   		new string[56];
     	GetPlayerName(playerid, name, sizeof(name));
       	format(string, sizeof(string), "%s.ini", name );
		dini_IntSet(string, "Virus", Rand);
        return 1;
    }
    return 1;
}

