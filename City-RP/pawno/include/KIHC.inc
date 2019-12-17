#if defined KIHC
	#endinput
#endif

#define KIHC

#include <struct>
#include <steam>

forward kihc_OnPlayerCommandText(playerid, cmdtext[]);
forward kihc_OnPlayerSpawn(playerid);
forward kihc_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
forward kihc_OnPlayerPickUpPickup(playerid,pickupid);
forward kihc_OnGameModeInit();

enum house_enum
{
	Float:ox,
	Float:oy,
	Float:oz,
	Float:ix,
	Float:iy,
	Float:iz,
	Float:ia,
	ii,
	enterpickup,
	exitpickup
};

new house[200][house_enum];

enum house_interior_enum
{
	Float:dx,
	Float:dy,
	Float:dz,
	Float:ix,
	Float:iy,
	Float:iz,
	Float:ia,
	ii
};

new house_interior[][house_interior_enum] =
{
	{2468.8335,-1698.3372,1013.5078,2466.2402,-1698.4056,1013.5078,81.0580,2},
	{2233.7041,-1115.2631,1050.8828,2233.9314,-1113.1801,1050.8828,2.1440,5},
	{2317.8181,-1026.7645,1050.2178,2319.6548,-1023.9469,1050.2109,345.2238,9},
	{235.2415,1186.6791,1080.2578,234.7631,1189.4911,1080.2578,1.8073,3},
	{226.7886,1239.9746,1082.1406,223.6205,1240.1162,1082.1406,86.6981,2},
	{223.0716,1287.0757,1082.1406,222.9491,1288.8225,1082.1406,338.9104,1},
	{226.2976,1114.3260,1080.9929,228.7505,1114.4025,1080.9922,258.8259,5},
	{226.5253,1114.1793,1080.9941,228.6586,1114.3998,1080.9922,264.1760,5},
	{261.0645,1284.3698,1080.2578,260.8488,1286.7084,1080.2578,359.4302,4},
	{221.8144,1140.1963,1082.6094,221.5325,1142.1240,1082.6094,359.3834,4},
	{-260.4867,1456.7488,1084.3672,-263.7732,1455.6582,1084.3672,76.1274,4},
	{22.7631,1403.3254,1084.4370,22.6653,1405.8599,1084.4297,352.7800,5},
	{234.1961,1063.7218,1084.2123,233.8985,1065.7357,1084.2094,350.2733,6},
	{-68.7103,1351.1992,1080.2109,-69.0125,1353.2493,1080.2109,351.5266,6},
	{2807.5771,-1174.7576,1025.5703,2807.5320,-1172.3373,1025.5703,346.9565,8},
	{2218.4021,-1076.3384,1050.4844,2215.1995,-1076.3181,1050.4844,82.2106,1},
	{2365.2217,-1135.5981,1050.8826,2365.3535,-1133.1183,1050.8750,10.4800,8},
	{-42.5949,1405.4702,1084.4297,-42.6963,1407.6703,1084.4297,355.7766,8},
	{83.1322,1322.2809,1083.8662,84.6236,1325.8396,1083.8594,351.0999,9},
	{260.7566,1237.2318,1084.2578,261.3616,1240.1266,1084.2578,0.2100,9}
};

enum
{
	nothing,
	buy,
	rent,
	unrent,
	withdraw,
	deal
};

new key[MAX_PLAYERS] = { nothing,... };

stock getsequence(houseid)
{
	new id = 1;
	for(new i = 1;i < houseid;i++)
	{
	    if(id >= sizeof(house_interior)-1)
	    {
	        id = 0;
	    }
	    id++;
	}
	return id;
}
new HouseBuy[MAX_PLAYERS];
new HouseSell[MAX_PLAYERS];
new HouseCost[MAX_PLAYERS];

stock strtok( const string[], &index, const seperator[] = " " )
{
	new
		index2,
		result[ 30 ];

	index2 =  strfind(string, seperator, false, index);


	if(index2 == -1)
	{
		if(strlen(string) > index)
		{
			strmid(result, string, index, strlen(string), 30);
			index = strlen(string);
		}
		return result;
	}
	if(index2 > (index + 29))
	{
		index2 = index + 29;
		strmid(result, string, index, index2, 30);
		index = index2;
		return result;
	}
	strmid(result, string, index, index2, 30);
	index = index2 + 1;
	return result;
}

stock BuildHouse(Float:x,Float:y,Float:z,cost = 75000)
{
	static houseid = 0;
	houseid++;
	house[houseid][ox] = x;
	house[houseid][oy] = y;
	house[houseid][oz] = z;
	new Float:_ix,Float:_iy,Float:_iz,_ii,Float:_ia;
	new house_interior_random = getsequence(houseid);
	_ix = house_interior[house_interior_random][ix];
	_iy = house_interior[house_interior_random][iy];
	_iz = house_interior[house_interior_random][iz];
	_ia = house_interior[house_interior_random][ia];
	_ii = house_interior[house_interior_random][ii];
	house[houseid][ix] = _ix;
	house[houseid][iy] = _iy;
	house[houseid][iz] = _iz;
	house[houseid][ia] = _ia;
	house[houseid][ii] = _ii;
	_ix = house_interior[house_interior_random][dx];
	_iy = house_interior[house_interior_random][dy];
	_iz = house_interior[house_interior_random][dz];
	house[houseid][enterpickup] = CreatePickup(1318,2,x,y,z);
	house[houseid][exitpickup] = CreatePickup(1318,23,_ix,_iy,_iz);
	AddStaticIcon(x,y,z,31,0);
	new shouse[10];
	new scost[20];
	valstr(scost,cost);
	format(shouse,10,"House%d",houseid);
	if(!isDS("KIHC",shouse))
	{
	    setDS("KIHC",shouse,"owner","none");
	    setDS("KIHC",shouse,"cost",scost);
	    setDS("KIHC",shouse,"rent","75");
	    setDS("KIHC",shouse,"bank","0");
	}
	return houseid;
}
stock BuildHouseEx(Float:outsidex,Float:outsidey,Float:outsidez,Float:insidex,Float:insidey,Float:insidez,insidei,cost = 75000)
{
	static houseid = 0;
	houseid++;
	house[houseid][ox] = outsidex;
	house[houseid][oy] = outsidey;
	house[houseid][oz] = outsidez;

	house[houseid][ix] = insidex;
	house[houseid][iy] = insidey;
	house[houseid][iz] = insidez;
	house[houseid][ia] = 0;
	house[houseid][ii] = insidei;

	house[houseid][enterpickup] = CreatePickup(1318,2,outsidex,outsidey,outsidez);
	house[houseid][exitpickup] = -1;
	AddStaticIcon(outsidex,outsidey,outsidez,31,0);
	new shouse[10];
	new scost[20];
	valstr(scost,cost);
	format(shouse,10,"House%d",houseid);
	if(!isDS("KIHC",shouse))
	{
	    setDS("KIHC",shouse,"owner","none");
	    setDS("KIHC",shouse,"cost",scost);
	    setDS("KIHC",shouse,"rent","75");
	    setDS("KIHC",shouse,"bank","0");
	}
	return houseid;
}

stock IsHousePickup(pickupid)
{
	for(new i = 1; i < 200;i++)
	{
	    if(house[i][enterpickup] == pickupid) return i;
	    if(house[i][exitpickup] == pickupid) return i;
	}
	return 0;
}

stock name(playerid)
{
	new name_s[23];
	GetPlayerName(playerid,name_s,23);
	return name_s;
}


stock GetClosestInHousePickup(playerid)
{
	new Float:x,Float:y,Float:z;
	new Float:closest = 9999.9;
	new id = 0;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 1;i < 200;i++)
	{
	    if(house[i][enterpickup])
	    {
	        new Float:dis = distance(x,y,z,house[i][ix],house[i][iy],house[i][iz]);
			if(dis < closest)
			{
			    dis = closest;
			    id = i;
			}
	    }
	}
	return id;
}

stock GetClosestOutHousePickup(playerid)
{
	new Float:x,Float:y,Float:z;
	new Float:closest = 9999.9;
	new id = 0;
	GetPlayerPos(playerid,x,y,z);
	for(new i = 1;i < 200;i++)
	{
	    if(house[i][exitpickup])
	    {
	        new Float:dis = distance(x,y,z,house[i][ox],house[i][oy],house[i][oz]);
			if(dis < closest)
			{
			    dis = closest;
			    id = i;
			}
	    }
	}
	return id;
}

public OnGameModeInit()
{
	BuildHouse( 1958.3783, 1343.1572, 15.3746);
	CallLocalFunction("kihc_OnGameModeInit","");
	return 1;
}

public OnPlayerPickUpPickup(playerid,pickupid)
{
	new houseid = IsHousePickup(pickupid);
	if(houseid)
	{
	   	if(house[houseid][exitpickup] == pickupid)
		{
		    SetPlayerPos(playerid,house[houseid][ox],house[houseid][oy],house[houseid][oz]);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			OnPlayerKeyStateChange(playerid, KEY_SPRINT, 0);

		}
		else
		{
			new shouse[10];
			format(shouse,10,"House%d",houseid);
			if(isDS("KIHC",shouse,"owner","none"))
			{
		        SendClientMessage(playerid,0x9ACD32AA," ");
			    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /info for information about the house.");
			    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /leave to leave the house.");
		    	SetPlayerPos(playerid,house[houseid][ix],house[houseid][iy],house[houseid][iz]);
				SetPlayerInterior(playerid,house[houseid][ii]);
				SetPlayerVirtualWorld(playerid,houseid);
				new string[256];
				new scost[256];
				getDS(scost,"KIHC",shouse,"cost");
				format(string,256,"*** This house cost $%s, press 'RETURN' to buy it, 'SPACE' to ignore.",scost);
				SendClientMessage(playerid,0x9ACD32AA,string);
				key[playerid] = buy;
		        SendClientMessage(playerid,0x9ACD32AA," ");
			}
			else
			{
				if(isDS("KIHC",shouse,"owner",name(playerid))) // owner
				{
			        SendClientMessage(playerid,0x9ACD32AA,"  ");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /rent to change thhe house rent.");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /sell to sell the house .");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /info for information about the house.");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /leave to leave the house.");
				    
				   	SetPlayerPos(playerid,house[houseid][ix],house[houseid][iy],house[houseid][iz]);
					SetPlayerInterior(playerid,house[houseid][ii]);
					SetPlayerVirtualWorld(playerid,houseid);

					new string[256];
					new scost[256];
					getDS(scost,"KIHC",shouse,"bank");
					format(string,256,"*** Press 'RETURN' to withdraw $%s from your house bank.",scost);
					SendClientMessage(playerid,0x9ACD32AA,string);
					key[playerid] = withdraw;
			        SendClientMessage(playerid,0x9ACD32AA,"  ");
				}
				else if(isDS("KIHC",name(playerid),shouse)) // tenent
				{
			        SendClientMessage(playerid,0x9ACD32AA," ");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /info for information about the house.");
				    SendClientMessage(playerid,0x9ACD32AA,"*** You can do /leave to leave the house.");
			    	SetPlayerPos(playerid,house[houseid][ix],house[houseid][iy],house[houseid][iz]);
					SetPlayerInterior(playerid,house[houseid][ii]);
					SetPlayerVirtualWorld(playerid,houseid);

					SendClientMessage(playerid,0x9ACD32AA,"*** Press 'RETURN' to unrent from this house, 'SPACE' to ignore.");
					key[playerid] = unrent;
			        SendClientMessage(playerid,0x9ACD32AA," ");
				}
				else // guest
				{
			        SendClientMessage(playerid,0x9ACD32AA,"  ");
					TogglePlayerControllable(playerid,1);
					SendClientMessage(playerid,0x9ACD32AA,"*** Press 'RETURN' to rent this house, 'SPACE' to ignore.");
					key[playerid] = rent;
			        SendClientMessage(playerid,0x9ACD32AA,"  ");
				}
			}
		}
	}
	CallLocalFunction("kihc_OnPlayerPickUpPickup","ii",playerid,pickupid);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{

	if(newkeys == KEY_SPRINT)
	{
	    if((key[playerid] == deal) || (key[playerid] == buy) || (key[playerid] == rent) || (key[playerid] == unrent) || (key[playerid] == withdraw))
		{
			key[playerid] = nothing;
	 		TogglePlayerControllable(playerid,1);
	 		if(key[playerid] == deal)
	 		{
	 		    SendClientMessage(HouseBuy[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** The house buy request was cancelled.");
	 		    SendClientMessage(HouseSell[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** The house sell request was cancelled.");
				key[HouseSell[GetPlayerVirtualWorld(playerid)]] == nothing;
				key[HouseBuy[GetPlayerVirtualWorld(playerid)]] == nothing;
			    TogglePlayerControllable(HouseSell[GetPlayerVirtualWorld(playerid)],1);
				TogglePlayerControllable(HouseBuy[GetPlayerVirtualWorld(playerid)],1);
				HouseSell[GetPlayerVirtualWorld(playerid)] = 0;
				HouseBuy[GetPlayerVirtualWorld(playerid)] = 0;
				HouseCost[GetPlayerVirtualWorld(playerid)] = 0;
			}
		}
	}
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
	    if(key[playerid] == buy)
		{
		    new houseid = GetPlayerVirtualWorld(playerid);
			new shouse[10];
			format(shouse,10,"House%d",houseid);
			new scost[256];
			getDS(scost,"KIHC",shouse,"cost");
		    new cost = strval(scost);
		    if(isDS("KIHC",shouse,"owner","none"))
		    {
		 		getDS(scost,"KIHC",shouse,"cost");
		        if(GetPlayerMoney(playerid) >= cost)
		        {
		            setDS("KIHC",shouse,"owner",name(playerid));
		            setDS("KIHC",name(playerid),shouse);
					GivePlayerMoney(playerid,-cost);
					SendClientMessage(playerid,0x9ACD32AA,"*** Congrats, now you own this house.");
		        }
		        else
		        {
		            SendClientMessage(playerid,0x9ACD32AA,"*** You dont have enough money.");
		            key[playerid] = nothing;
		        }
		    }
		    else
		    {
		        SendClientMessage(playerid,0x9ACD32AA,"*** The house is no longer for sale.");
		        key[playerid] = nothing;
		    }
		}
		if(key[playerid] == withdraw)
		{
		    new houseid = GetPlayerVirtualWorld(playerid);
		    new shouse[10];
			format(shouse,10,"House%d",houseid);
			if(isDS("KIHC",shouse,"owner",name(playerid)))
			{
			    new bank[256];
			    getDS(bank,"KIHC",shouse,"bank");
			    GivePlayerMoney(playerid,strval(bank));
			    setDS(bank,"KIHC",shouse,"bank","0");
			    key[playerid] = nothing;
			    new string[256];
			    format(string,256,"*** You have withdraw $%s from your house bank.",bank);
			    SendClientMessage(playerid,0x9ACD32AA,string);
			}
			else
			{
			    SendClientMessage(playerid,0x9ACD32AA,"*** You are not the owner of this house.");
			    key[playerid] = nothing;
			}
		}
		if(key[playerid] == unrent)
		{
		    new houseid = GetPlayerVirtualWorld(playerid);
		    new shouse[10];
			format(shouse,10,"House%d",houseid);
			if(isDS("KIHC",name(playerid),shouse))
			{
				setDS("KIHC",name(playerid),"none");
				SendClientMessage(playerid,0x9ACD32AA,"*** You no longer are a tenent of thie house.");
			}
			else
			{
				SendClientMessage(playerid,0x9ACD32AA,"*** You are not a tenent of this house.");
			}
			key[playerid] = nothing;
		}
		if(key[playerid] == rent)
		{
		    new houseid = GetClosestOutHousePickup(playerid);
		    if(houseid)
		    {
		        new srent[256];
			    new shouse[10];
				format(shouse,10,"House%d",houseid);
				getDS(srent,"KIHC",shouse,"rent");
				new cost = strval(srent);
				if(GetPlayerMoney(playerid) >= cost)
				{
				    GivePlayerMoney(playerid,-cost);
				    new sbank[256];
				    getDS(sbank,"KIHC",shouse,"bank");
				    new amount = strval(sbank) + cost;
					valstr(sbank,amount);
					setDS("KIHC",shouse,sbank);
					setDS("KIHC",name(playerid),shouse);
					SendClientMessage(playerid,0x9ACD32AA,"*** Congrats, now you are a tenent at this house.");
				}
				else
				{
				    SendClientMessage(playerid,0x9ACD32AA,"*** You dont have enough money.");
				}
				key[playerid] = nothing;
			}
		}
		if(key[playerid] == deal)
		{
		    new houseid = GetPlayerVirtualWorld(playerid);
			if(HouseBuy[houseid] == playerid)
			{
			    new id = HouseSell[houseid];
			    new cost = HouseCost[houseid];
				if(GetPlayerMoney(playerid) >= cost)
				{
				    GivePlayerMoney(playerid,-cost);
				    GivePlayerMoney(id,cost);
				    new shouse[10];
				    format(shouse,10,"House%d",houseid);
					setDS("KIHC",shouse,"owner",name(playerid));
		 		    SendClientMessage(HouseBuy[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** Congrats, Now you own this house.");
		 		    SendClientMessage(HouseSell[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** Your house was sold successfully.");
				}
				else
				{
				    SendClientMessage(playerid,0x9ACD32AA,"*** You dont have enough money.");
		 		    SendClientMessage(HouseBuy[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** The house buy request was cancelled.");
		 		    SendClientMessage(HouseSell[GetPlayerVirtualWorld(playerid)],0x9ACD32AA,"*** The house sell request was cancelled.");
				}
			    TogglePlayerControllable(playerid,1);
			    TogglePlayerControllable(id,1);
				key[HouseSell[GetPlayerVirtualWorld(playerid)]] == nothing;
				key[HouseBuy[GetPlayerVirtualWorld(playerid)]] == nothing;
				HouseSell[GetPlayerVirtualWorld(playerid)] = 0;
				HouseBuy[GetPlayerVirtualWorld(playerid)] = 0;
				HouseCost[GetPlayerVirtualWorld(playerid)] = 0;

			}
		}
	}
	CallLocalFunction("kihc_OnPlayerKeyStateChange","iii",playerid,newkeys,oldkeys);
}


public OnPlayerSpawn(playerid)
{
	if(!isDS("KIHC",name(playerid)))	setDS("KIHC",name(playerid),"none");
	new shouse[256];
	getDS(shouse,"KIHC",name(playerid));
	if(strcmp(shouse,"none",true))
	{
		new houseid = strval(shouse[5]);
		SetPlayerPos(playerid,house[houseid][ix],house[houseid][iy],house[houseid][iz]);
		SetPlayerInterior(playerid,house[houseid][ii]);
		if(!isDS("KIHC",shouse,"owner",name(playerid)))
		{
		    new scost[256];
			getDS(scost,"KIHC",shouse,"rent");
			new cost = strval(scost);
			if(GetPlayerMoney(playerid) >= cost)
			{
				GivePlayerMoney(playerid,-cost);
				new sbank[256];
				getDS(sbank,"KIHC",shouse,"bank");
				new bank = strval(sbank) + cost;
				valstr(sbank,bank);
				setDS("KIHC",shouse,"bank",sbank);
			}
			else
			{
			    setDS("KIHC",name(playerid),"none");
			    SendClientMessage(playerid,0x9ACD32AA,"*** You are out of money.");
			    SendClientMessage(playerid,0x9ACD32AA,"*** You no longer are a tenent at this house.");
			}
		}
	}
	CallLocalFunction("kihc_OnPlayerSpawn","i",playerid);
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
	if(strcmp("/buildhouse",cmdtext,true,11)==0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
		    static houses = 0;
		    houses++;
			if(!fexist("Houses.txt"))
			{
				new File:t = fopen("Houses.txt",io_write);
				fwrite(t,"/* [ Function ] [Yr|Mt|Dt|Hr|Mn|Sc] [ Comment ] */\r\n\r\n");
				fclose(t);
			}
		    new File:f = fopen("Houses.txt",io_append);
		    new string[256];
			new Float:x,Float:y,Float:z;
			GetPlayerPos(playerid,x,y,z);
			new r,m,d,h,n,s;
			getdate(r,m,d);
			gettime(h,n,s);
			if(strlen(cmdtext) > 11)
			{
				format(string,256,"BuildHouse( %.2f , %.2f , %.2f ); // [%2d|%2d|%2d|%2d|%2d|%2d] %s\r\n",x,y,z,r,m,d,h,n,s,cmdtext[11]);
			}
			else
			{
				format(string,256,"BuildHouse( %.2f , %.2f , %.2f ); // [%2d|%2d|%2d|%2d|%2d|%2d] \r\n",x,y,z,r,m,d,h,n,s);
		    }
		    fwrite(f,string);
		    format(string,256,"Total number of HOUSES this session: %d.",houses);
		    SendClientMessage(playerid,0x9ACD32AA,string);
			fclose(f);
			CreateObject(1273,x,y,z,0,0,0);
		}
  	}

	if(GetPlayerVirtualWorld(playerid))
	{
	    new houseid = GetPlayerVirtualWorld(playerid);
		new idx;
		new cmd[30];
		cmd = strtok(cmdtext,idx);
		if(strcmp("/rent",cmd,true)==0)
		{
		    if(houseid)
		    {
				new shouse[10];
				new amount = strval(strtok(cmdtext,idx));
				format(shouse,10,"House%d",houseid);
				if(amount)
				{
				    if(isDS("KIHC",shouse,"owner",name(playerid)))
				    {
				        new str[20];
						valstr(str,amount);
						setDS("KIHC",shouse,"rent",str);
						SendClientMessage(playerid,0x9ACD32AA,"*** House rent has been updated.");
				    }
				    else
				    {
						SendClientMessage(playerid,0x9ACD32AA,"*** You are not the owner of this house.");
				    }
				}
				else
				{
				    SendClientMessage(playerid,0x9ACD32AA,"*** Usage: /rent <amount>.");
				}
		    }
		}
		if(strcmp("/sell",cmd,true)==0)
		{
			new id = strval(strtok(cmdtext,idx));
			new amount = strval(strtok(cmdtext,idx));
			if(amount)
			{
				new shouse[10];
				format(shouse,10,"House%d",houseid);
				if(isDS("KIHC",shouse,"owner",name(playerid)))
				{
				    TogglePlayerControllable(playerid,0);
				    TogglePlayerControllable(id,0);
				    
					new string[256];
					SendClientMessage(id,0x9ACD32AA,"  ");
					format(string,256,"*** %s wants to sell his house for $%d.",name(playerid),amount);
					SendClientMessage(id,0x9ACD32AA,string);
					SendClientMessage(id,0x9ACD32AA,"*** Press 'ENTER' to buy it, 'SPACE' to ignore.");
					SendClientMessage(id,0x9ACD32AA,"  ");
					format(string,256,"*** You have requested %s to buy your house for $%d.",name(id),amount);
					SendClientMessage(playerid,0x9ACD32AA,"  ");
					SendClientMessage(playerid,0x9ACD32AA,"*** Press 'SPACE' to ignore.");
					SendClientMessage(playerid,0x9ACD32AA,string);
					SendClientMessage(playerid,0x9ACD32AA,"  ");
				    HouseBuy[houseid] = id;
				    HouseSell[houseid] = playerid;
				    HouseCost[houseid] = amount;
				    key[playerid] = deal;
				    key[id] = deal;
				    
				}
				else
				{
				    SendClientMessage(playerid,0x9ACD32AA,"*** You are not the owner of the house.");
				}
			}
			else
			{
			    SendClientMessage(playerid,0x9ACD32AA,"*** Usage: /sell <id> <amount>.");
			}
		}
		if(strcmp("/leave",cmd,true)==0)
		{
		    if(houseid)
		    {
				SetPlayerPos(playerid,house[houseid][ox],house[houseid][oy],house[houseid][oz]);
				SetPlayerInterior(playerid,0);
		    }
		}
		if(strcmp("/info",cmd,true)==0)
		{
		    if(houseid)
		    {
		        new string[256];
		        new shouse[10];
		        format(shouse,10,"House%d",houseid);
		        SendClientMessage(playerid,0x9ACD32AA," ");
		        format(string,256,"%s %d","*** House:",houseid);
		        SendClientMessage(playerid,0x9ACD32AA,string);
		        new str[256];
		        getDS(str,"KIHC",shouse,"owner");
		        format(string,256,"%s %s","*** Owner:",str);
		        SendClientMessage(playerid,0x9ACD32AA,string);
		        getDS(str,"KIHC",shouse,"cost");
		        format(string,256,"%s %s","*** Cost:",str);
		        SendClientMessage(playerid,0x9ACD32AA,string);
		        getDS(str,"KIHC",shouse,"rent");
		        format(string,256,"%s %s","*** Rent:",str);
		        SendClientMessage(playerid,0x9ACD32AA,string);
		        SendClientMessage(playerid,0x9ACD32AA," ");
		    }
		}
	}
	CallLocalFunction("kihc_OnPlayerCommandText","is",playerid,cmdtext);
	return 1;
}

#define OnPlayerCommandText kihc_OnPlayerCommandText
#define OnPlayerSpawn kihc_OnPlayerSpawn
#define OnPlayerKeyStateChange kihc_OnPlayerKeyStateChange
#define OnPlayerPickUpPickup kihc_OnPlayerPickUpPickup
#define steam_OnGameModeInit kihc_OnGameModeInit

