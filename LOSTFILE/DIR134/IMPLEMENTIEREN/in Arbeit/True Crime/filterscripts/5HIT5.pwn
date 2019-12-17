#include <a_samp>
#define C 0xFFFFFFFF // White text

new msv[256];	// My String Variable
new howmany=0; 	// INITIALISES THE NUMBER OF VISITS COUNTER
new hvn=6;

main()
{
print("--------------------------------------");
print("Spectre's Hidden Interiors Tour Script");
print("--------------------------------------");
}

public OnGameModeInit()
{
    // THIS IS WHERE THEY ACTUALLY SPAWN WHEN SELECTED
	print("GameModeInit()");SetWorldTime(12);
	SetGameModeText("Spectre's Hidden Interiors Tour Script");
	AddPlayerClass(137,349.0,303.361275,1000.130493,90,0,0,0,0,0,0);
	///// HELIS OUTSIDE THE GYMS /////
	AddStaticVehicle(487,2230.583007,-1732.297607,12.382312,90,-1,-1);
    AddStaticVehicle(487,-2256.115722,-156.851593,34.171875,00,-1,-1);
    AddStaticVehicle(487,1953.772705,2283.268066,009.671875,90,-1,-1);
	///// CARS OUTSIDE THE GYMS /////
	AddStaticVehicle(559,2220.583007,-1732.297607,12.382312,90,-1,-1);
    AddStaticVehicle(559,-2256.115722,-146.851593,34.171875,00,-1,-1);
    AddStaticVehicle(559,1943.772705,2283.268066,009.671875,90,-1,-1);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	// THIS IS WHERE THEY ALL DISPLAY WHILE BEING SELECTED
	printf("OnPlayerRequestClass(%d, %d)", playerid, classid);
	SetPlayerInterior(playerid,6);SetPlayerFacingAngle(playerid,90);
	SetPlayerPos(playerid,349.899993,303.361275,1000.130493);
	SetPlayerCameraPos(playerid,346.967376,303.361275,1000);
	SetPlayerCameraLookAt(playerid,349.899993,303.361275,1000.130493);
	return 1;
}

public OnPlayerConnect(playerid)
{
	printf("OnPlayerConnect(%d)", playerid);
  	howmany=0;// SETS NUMBER OF VISITS FOR INTRODUCTION DISPLAY PURPOSES
 	return 1;
}

public OnPlayerSpawn(playerid)
{
	new name[256];
	new string[256];
	
 	printf("OnPlayerSpawn(%d)",playerid);wiper(playerid);hvn=6;
	SetPlayerInterior(playerid,6);SetPlayerFacingAngle(playerid,270);
 	howmany++;// ADVANCES NUMBER OF VISITS FOR INTRODUCTION DISPLAY PURPOSES BELOW

 	if (playerid,howmany==1)
	{
	GetPlayerName(playerid,name,sizeof(name));
	format(string,sizeof(string),"Welcome %s!",name);
	GameTextForPlayer(playerid,string,6000,5);wiper(playerid);
	SendClientMessage(playerid,C,"Just look at you.  Now tell me you don't look like you need to chill a bit.");
	SendClientMessage(playerid,C,"Well, you've come to the right place.  Your money's no good here and there ");
	SendClientMessage(playerid,C,"are no scores, weapons or cheaters to worry about. So just relax and enjoy.");
	SendClientMessage(playerid,C,"\n");
	SendClientMessage(playerid,C,"Welcome to Spectre's Hidden Interiors Tour Script.  Most of the coordinates");
	SendClientMessage(playerid,C,"came directly from the main.scm but others were adjusted or selected by me ");
	SendClientMessage(playerid,C,"for their aesthetic properties.  Where possible I tried to add interesting ");
	SendClientMessage(playerid,C,"facts from the game itself and other GTA trivia.");
	SendClientMessage(playerid,C,"\n");
	SendClientMessage(playerid,C,"type /MORE1 to continue or /MENU to get right to it...");
	}else{
	GameTextForPlayer(playerid,"Have a nice dirt nap?",6000,5);wiper(playerid);
	SendClientMessage(playerid,C,"Here's a list of the available commands:");
	SendClientMessage(playerid,C,"\n");
	SendClientMessage(playerid,C,"/MORE1 - re-read the Introduction (boy are YOU bored!)");
	SendClientMessage(playerid,C,"/INFO  - this page");
	SendClientMessage(playerid,C,"/WIPE  - clears the text from the screen");
	SendClientMessage(playerid,C,"/KILL  - in case you get stuck somewhere");
	SendClientMessage(playerid,C,"/MENU thru /MENU4  - displays a list of the Interior categories");
	SendClientMessage(playerid,C,"/?     - displays current position, angle and Interior");
	SendClientMessage(playerid,C,"\n");
	SendClientMessage(playerid,C,"type /MENU to get started...Enjoy/Spectre");
	}
	return 1;
	}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256],idx;cmd=strtok(cmdtext,idx);
	new s[256],t[256],u[256],v,w,Float:x,Float:y,Float:z;

///////////////////////// 24/7 /////////////////////////
if(strcmp(cmd,"/247",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== 24/7 Stores ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/2471 - Version 1 - Big - L-shaped - NO EXIT");
SendClientMessage(playerid,C,"/2472 - Version 2 - Big - Oblong   - NO EXIT");
SendClientMessage(playerid,C,"/2473 - Version 3 - Med - Square   - Creek, LV");
SendClientMessage(playerid,C,"/2474 - Version 4 - Med - Square   - NO EXIT");
SendClientMessage(playerid,C,"/2475 - Version 5 - Sml - Long     - Mulholland");
SendClientMessage(playerid,C,"/2476 - Version 6 - Sml - Square   - Whetstone");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/2471",true)==0){s="Large - Lshaped";t="24/7 (V1)";u="X7_11D";
v=17;w=0;x=-25.884499;y=-185.868988;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2472",true)==0){s="Large - Oblong";t="24/7 (V2) - (large)";u="X711S3";
v=10;w=0;x=6.091180;y=-29.271898;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2473",true)==0){s="Medium - Square";t="24/7 (V3)";u="X7_11B";
v=18;w=0;x=-30.946699;y=-89.609596;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2474",true)==0){s="Medium - Square";t="24/7 (V4)";u="X7_11C";
v=16;w=0;x=-25.132599;y=-139.066986;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2475",true)==0){s="Small - Long";t="24/7 (V5)";u="X711S2";
v=4;w=0;x=-27.312300;y=-29.277599;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/2476",true)==0){s="Small - Square";t="24/7 (V6)";u="X7_11S";
v=6;w=0;x=-26.691599;y=-55.714897;z=1003.549988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// AERODYNAMICS /////////////////////////
if(strcmp(cmd,"/AIR",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== ALL THINGS AERODYNAMIC ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/AIR1 - Francis Intn'l Airport - Ticket sales");
SendClientMessage(playerid,C,"/AIR2 - Francis Intn'l Airport - Baggage claim");
SendClientMessage(playerid,C,"/AIR3 - Shamal cabin (good jump spot)");
SendClientMessage(playerid,C,"/AIR4 - Andromada cargo hold");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/AIR1",true)==0){s="Remove your shoes please...";
t="Francis Int. Airport (Front Exterior & Ticket Sales)";u="AIRPORT";
v=14;w=0;x=-1827.147338;y=7.207418;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR2",true)==0){s="Why is your bag ticking sir?";
t="Francis Int. Airport (Baggage Claim)";u="AIRPOR2";
v=14;w=0;x=-1855.568725;y=41.263156;z=1061.143554;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR3",true)==0){s="Nice jump area in back";t="Shamal Interior";u="JETINT";
v=1;w=0;x=2.384830;y=33.103397;z=1199.849976;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AIR4",true)==0){s="Cargo Hold";t="Andromada";u="Spectre";
v=9;w=0;x=315.856170;y=1024.496459;z=1949.797363;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// AMMUNATION /////////////////////////
if(strcmp(cmd,"/AMU",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Ammunations ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/AMU1 - Ocean Flats, SF");
SendClientMessage(playerid,C,"/AMU2 - Palomino Creek, LV");
SendClientMessage(playerid,C,"/AMU3 - Angel Pine, SF");
SendClientMessage(playerid,C,"/AMU4 - (2 story)");
SendClientMessage(playerid,C,"/AMU5 - El Quebrados, LV");
SendClientMessage(playerid,C,"/AMU6 - Inside the booths");
SendClientMessage(playerid,C,"/AMU7 - Inside the range");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/AMU1",true)==0){s="NONE";t="Ammunation (V2)";u="AMMUN1";
v=1;w=315;x=286.148987;y=-40.644398;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU2",true)==0){s="NONE";t="Ammunation (V3)";u="AMMUN2";
v=4;w=315;x=286.800995;y=-82.547600;z=1001.539978;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU3",true)==0){s="NONE";t="Ammunation (V4)";u="AMMUN3";
v=6;w=90;x=296.919983;y=-108.071999;z=1001.569946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU4",true)==0){s="Check the machine to your right";t="Ammunation (V1)(2 floors)";u="AMMUN4";
v=7;w=45;x=314.820984;y=-141.431992;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU5",true)==0){s="NONE";t="Ammunation (V5)";u="AMMUN5";
v=6;w=45;x=316.524994;y=-167.706985;z=999.661987;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU6",true)==0){s="Lock and Load";t="Ammunation Booths";u="Spectre";
v=7;w=0;x=302.292877;y=-143.139099;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/AMU7",true)==0){s="Now you know what a target sees";t="Ammunation Range";u="Spectre";
v=7;w=270;x=280.795104;y=-135.203353;z=1004.062500;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BURGLARY HOUSES /////////////////////////
if(strcmp(cmd,"/BUR",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== BURGLARY HOUSES ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"I've counted 23 burglary houses and will call them X1 thru X23...");
SendClientMessage(playerid,C,"Some of these were obviously tests that R* never removed (they do that");
SendClientMessage(playerid,C,"a lot). A lot of them have bad textures, doors that go nowhere, etc..");
SendClientMessage(playerid,C,"Some are clearly early models of later and better designed safe houses");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"Clan folk - You'll probably find some of these perfect for home bases.");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/X1",true)==0){s="Large/2 story/3 bedrooms/clone of X9";t="X1";u="LAHSB4";
v=3;w=0;x=235.508994;y=1189.169897;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X2",true)==0){s="Medium/1 story/1 bedroom";t="X2";u="LAHS1A";
v=2;w=90;x=225.756989;y=1240.000000;z=1082.149902;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X3",true)==0){s="Small/1 story/1 bedroom";t="X3";u="LAHS1B";
v=1;w=0;x=223.043991;y=1289.259888;z=1082.199951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X4",true)==0){s="VERY Large/2 story/4 bedrooms";t="X4";u="LAHSB2";
v=7;w=0;x=225.630997;y=1022.479980;z=1084.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X5",true)==0){s="Small/1 story/2 bedrooms";t="X5";u="VGHSS1";
v=15;w=0;x=295.138977;y=1474.469971;z=1080.519897;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X6",true)==0){s="Small/1 story/2 bedrooms";t="X6";u="VGSHS2";
v=15;w=0;x=328.493988;y=1480.589966;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X7",true)==0){s="Small/1 story/1 bedroom/NO BATHROOM!";t="X7";u="VGSHM2";
v=15;w=90;x=385.803986;y=1471.769897;z=1080.209961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X8",true)==0){s="Small/1 story/1 bedroom";t="X8";u="VGSHM3";
v=15;w=90;x=375.971985;y=1417.269897;z=1081.409912;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X9",true)==0){s="Large/2 story/3 bedrooms/clone of X1";t="X9";u="VGHSB3";
v=2;w=0;x=490.810974;y=1401.489990;z=1080.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X10",true)==0){s="Medium/1 story/2 bedrooms";t="X10";u="VGHSB1";
v=2;w=0;x=447.734985;y=1400.439941;z=1084.339966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X11",true)==0){s="Large/2 story/4 bedrooms";t="X11";u="LAHSB3";
v=5;w=270;x=227.722992;y=1114.389893;z=1081.189941;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X12",true)==0){s="Small/1 story/1 bedroom";t="X12";u="LAHS2A";
v=4;w=0;x=260.983978;y=1286.549927;z=1080.299927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X13",true)==0){s="Small/1 story/1 bedroom/NO BATHROOM!";t="X13";u="LAHSS6";
v=4;w=0;x=221.666992;y=1143.389893;z=1082.679932;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X14",true)==0){s="Medium/2 story/1 bedroom";t="X14";u="VGHSM3";
v=10;w=0;x=27.132700;y=1341.149902;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X15",true)==0){s="Large/2 story/1 bedroom/NO BATHROOM!";t="X15";u="SFHSM2";
v=4;w=90;x=-262.601990;y=1456.619995;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X16",true)==0){s="Medium/1 story/2 bedrooms/NO BATHROOM or DOORS!";t="X16";u="VGHSM2";
v=5;w=0;x=22.778299;y=1404.959961;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X17",true)==0){s="Large/2 story/4 bedrooms/NO BATHROOM!";t="X17";u="SFHSB1";
v=5;w=0;x=140.278000;y=1368.979980;z=1083.969971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X18",true)==0){s="Large/2 story/3 bedrooms";t="X18";u="LAHSB1";
v=6;w=0;x=234.045990;y=1064.879883;z=1084.309937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X19",true)==0){s="Small/1 story/NO BEDROOM!";t="X19";u="SFHSS2";
v=6;w=0;x=-68.294098;y=1353.469971;z=1080.279907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X20",true)==0){s="Something is SERIOUSLY wrong with this model";t="X20";u="SFHSM1";
v=15;w=0;x=-285.548981;y=1470.979980;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X21",true)==0){s="Small/1 story/NO BEDROOM!";t="X21";u="SFHSS1";
v=8;w=0;x=-42.581997;y=1408.109985;z=1084.449951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X22",true)==0){s="Medium/2 story/2 bedrooms";t="X22";u="SFHSB3";
v=9;w=0;x=83.345093;y=1324.439941;z=1083.889893;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/X23",true)==0){s="Small/1 story/1 bedroom";t="X23";u="LAHS2B";
v=9;w=0;x=260.941986;y=1238.509888;z=1084.259888;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BUSINESSES /////////////////////////
if(strcmp(cmd,"/BUS",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== BLANK ===");
SendClientMessage(playerid,C,"/BUS1 - Blastin' Fools Records hallway");
SendClientMessage(playerid,C,"/BUS2 - Budget Inn Motel room");
SendClientMessage(playerid,C,"/BUS3 - Jefferson Motel");
SendClientMessage(playerid,C,"/BUS4 - Off Track Betting");
SendClientMessage(playerid,C,"/BUS5 - Sex Shop");
SendClientMessage(playerid,C,"/BUS6 - Sindacco Meat Processing Plant");
SendClientMessage(playerid,C,"/BUS7 - Zero's RC Shop");
SendClientMessage(playerid,C,"/BUS8 - Gasso gas station in Dillimore");
SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
if(strcmp(cmd,"/BUS1",true)==0){s="ONLY THE FLOOR IS SOLID!";t="Blastin' Fools Records corridor";u="STUDIO";
v=3;w=0;x=1038.509888;y=-0.663752;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS2",true)==0){s="MOtel ROOM";t="Budget Inn Motel Room";u="MOROOM";
v=12;w=0;x=446.622986;y=509.318970;z=1001.419983;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS3",true)==0){s="NONE";t="Jefferson Motel";u="MOTEL1";
v=15;w=0;x=2216.339844;y=-1150.509888;z=1025.799927;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS4",true)==0){s="GENeric Off Track Betting";t="Off Track Betting";u="GENOTB";
v=3;w=90;x=833.818970;y=7.418000;z=1004.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS5",true)==0){s="Uh, because they sell sex stuff?";t="Sex Shop";u="SEXSHOP";
v=3;w=45;x=-100.325996;y=-22.816500;z=1000.741943;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS6",true)==0){s="We've found Jimmy Hoffa!";t="Sindacco Meat Processing Plant";u="ABATOIR";
v=1;w=180;x=964.376953;y=2157.329834;z=1011.019958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS7",true)==0){s="NONE";t="Zero's RC Shop";u="RCPLAY";
v=6;w=0;x=-2239.569824;y=130.020996;z=1035.419922; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/BUS8", true)==0){s="Northern wall and shelves are non-solid";t="Gasso gas station in Dillimore";u="Spectre";
v=0;w=90;x=662.641601;y=-571.398803;z=16.343263;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// CAR MOD SHOPS /////////////////////////
if(strcmp(cmd,"/CAR",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== CAR MOD SHOPS ===");
SendClientMessage(playerid,C,"YOU ARE NOT SUPPOSED TO BE IN A MOD SHOP WHILE NOT IN A VEHICLE!");
SendClientMessage(playerid,C,"These coordinates are safe but MOVE AND YOU RISK A MAJOR CRASH!");
SendClientMessage(playerid,C,"/CAR1 - Transfenders - safely on the roof.../CAR1X - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR2 - Loco Low Co - safely on the roof.../CAR2X - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR3 - Wheels Arch Angels - safely on the roof.../CAR3Xx - inside - DANGER!");
SendClientMessage(playerid,C,"/CAR4 - Michelle's Garage - safely on the roof - camera goes funny if inside");
SendClientMessage(playerid,C,"/CAR5 - CJ's Garage in SF - camera acts funny*");
SendClientMessage(playerid,C,"* If you believe the calendar, the game is set in 1998 as that's the only year Jan starts on a Thursday");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CAR1x",true)==0){s="YOU HAVE BEEN WARNED!";t="Transfenders - inside";u="CARDMOD1";
v=1;w=0;x=614.581420;y=-23.066856;z=1004.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR2x",true)==0){s="YOU HAVE BEEN WARNED!";t="Loco Low Co - inside";u="CARMOD2";
v=2;w=180;x=620.420410;y=-72.015701;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR3x",true)==0){s="YOU HAVE BEEN WARNED!";t="Wheels Arch Angels - inside";u="CARMOD3";
v=3;w=315;x=612.508605;y=-129.236114;z=997.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR1",true)==0){s="You're safe up here";t="Transfenders";u="CARMOD1 - on the roof";
v=1;w=0;x=614.581420;y=-23.066856;z=1009.781250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR2",true)==0){s="You're safe up here";t="Loco Low Co";u="CARMOD2 - on the roof";
v=2;w=180;x=620.420410;y=-72.015701;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR3",true)==0){s="You're safe up here";t="Wheels Arch Angels";u="CARMOD3 - on the roof";
v=3;w=315;x=612.508605;y=-129.236114;z=1001.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR4",true)==0){s="You're safe up here";t="Michelle's Garage";u="Spectre";
v=0;w=0;x=-1786.603759;y=1215.553466;z=28.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAR5",true)==0){s="Go in the oil pits";t="CJ's Garage in SF";u="Spectre";
v=1;w=0;x=-2048.605957;y=162.093444;z=28.835937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

////////////////// CASINO ODDITIES /////////////////////////
if(strcmp(cmd,"/CAS",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== CASINO ODDITIES ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CAS1 - Caligula's locked basement");
SendClientMessage(playerid,C,"/CAS2 - FDC Janitor's office");
SendClientMessage(playerid,C,"/CAS3 - FDC Woozie's office (downstairs");
SendClientMessage(playerid,C,"/CAS4 - FDC Woozie's office (upstairs)");
SendClientMessage(playerid,C,"/CAS5 - Redsands West Casino");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /Menu to return to the full category list");return 1;}
if(strcmp(cmd,"/CAS1",true)==0){s="Only open during one mission";t="Caligulas locked basement";u="Spectre";
v=1;w=0;x=2170.284;y=1618.629;z=999.9766;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS2",true)==0){s="Small, ain't it? DON'T LEAVE THE ROOM!";t="Four Dragons Casino Janitor's office";u="FDJANITOR";
v=10;w=270;x=1889.975;y=1018.055;z=31.88281;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS3",true)==0){s="Woozie's office - (teller area)";
t="Woozie's Office in the FDC - TRY LEAVING THROUGH DOOR!";u="WUZIBET";
v=1;w=90;x=-2158.719971;y=641.287964;z=1052.369995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS4",true)==0){s="Woozie's office - wish he could see it!";
t="Woozie's Office in the FDC";u="Spectre";
v=1;w=270;x=-2169.846435;y=642.365905;z=1057.586059;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CAS5",true)==0){s="Don't remember seeing it playing the game!";
t="Small Casino in Redsands West";u="CASINO2";
v=12;w=0;x=1133.069946;y=-9.573059;z=1000.750000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// CLOTHING STORES /////////////////////////
if(strcmp(cmd,"/CLO",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Clothing Stores ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CLO1 - Binco");
SendClientMessage(playerid,C,"/CLO2 - Didier Sachs");
SendClientMessage(playerid,C,"/CLO3 - ProLaps");
SendClientMessage(playerid,C,"/CLO4 - SubUrban");
SendClientMessage(playerid,C,"/CLO5 - Victim");
SendClientMessage(playerid,C,"/CLO6 - Zip");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CLO1",true)==0){s="Clothing Store/CHeaP";t="Binco (cheap)";u="CSCHP";
v=15;w=0;x=207.737991;y=-109.019997;z=1005.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO2",true)==0){s="Clothing Store EXcLusive";t="Didier Sachs (exclusive)";u="CSEXL";
v=14;w=0;x=204.332993;y=-166.694992;z=1000.578979;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO3",true)==0){s="Clothing Store/SPoRT";t="ProLaps (sport)";u="CSSPRT";
v=3;w=0;x=207.054993;y=-138.804993;z=1003.519958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO4",true)==0){s="Rockstar refers to Los Santos as Los Angeles a lot --- LA Clothing Store?";t="SubUrban";u="LACS1";
v=1;w=0;x=203.778000;y=-48.492397;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO5",true)==0){s="Clothing Store/DESiGNer";t="Victim (designer)";u="CSDESGN";
v=5;w=90;x=226.293991;y=-7.431530;z=1002.259949; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLO6",true)==0){s="Clothing Store like the GaP? General Purpose?";t="Zip (general purpose)";u="CLOTHGP";
v=18;w=0;x=161.391006;y=-93.159156;z=1001.804687; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// BARS & CLUBS /////////////////////////
if(strcmp(cmd,"/CLU",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== BARS & CLUBS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CLU1 - Dance Club template");
SendClientMessage(playerid,C,"/CLU2 - Dance Club DJ room");
SendClientMessage(playerid,C,"/CLU3 - 'Pool Table' Bar template");
SendClientMessage(playerid,C,"/CLU4 - Lil' Probe Inn");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/CLU1",true)==0){s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club template";u="BAR1";
v=17;w=0;x=493.390991;y=-22.722799;z=1000.686951;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU2",true)==0){s="Alhambra, Gaydar Station, The 'Artwork' Club east of the Camel's Toe";t="Dance Club DJ room";u="Spectre";
v=17;w=270;x=476.068328;y=-14.893922;z=1003.695312;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU3",true)==0){s="Misty's, the Craw Bar, 10 Green bottles";t="'Pool table' Bar template";u="BAR2";
v=11;w=180;x=501.980988;y=-69.150200;z=998.834961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/CLU4",true)==0){s="based on the real life Little A'le'Inn near Area 51";t="Lil' Probe Inn";u="UFOBAR";
v=18;w=315;x=-227.028000;y=1401.229980;z=27.769798;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// EATERIES /////////////////////////
if(strcmp(cmd,"/EAT",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Diners & Restaurants ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/EAT1 - Jay's Diner");
SendClientMessage(playerid,C,"/EAT2 - Diner near Gant Bridge");
SendClientMessage(playerid,C,"/EAT3 - Secret Valley Diner (no solid surfaces)");
SendClientMessage(playerid,C,"/EAT4 - World of Coq");
SendClientMessage(playerid,C,"/EAT5 - Welcome Pump Truck Stop Diner*");
SendClientMessage(playerid,C,"* complete but unused in game - DON'T GO OUT DOOR!");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/EAT1",true)==0){s="I don't remember this being used";t="Jay's Diner";u="DINER1";
v=4;w=90;x=460.099976;y=-88.428497;z=999.621948; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT2",true)==0){s="Only booth seats are solid!";t="Unnamed Diner (near Gant Bridge)";u="DINER2";
v=5;w=90;x=454.973950;y=-110.104996;z=999.717957; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT3",true)==0){s="View from Jay's Diner thanx to -[HTB]-Kfgus3";t="Secret Valley Diner (No solid surfaces)";u="REST2";
v=6;w=337;x=435.271331;y=-80.958938;z=999.554687;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT4",true)==0){s="FooD RESTaurant - DON'T FALL OFF!";t="World of Coq";u="FDREST1";
v=1;w=45;x=452.489990;y=-18.179699;z=1001.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/EAT5",true)==0){s="Complete but unused in game";t="Welcome Pump Truck Stop Diner";u="TSDINER";
v=1;w=180;x=681.474976;y=-451.150970;z=-25.616798; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// FAST FOOD /////////////////////////
if(strcmp(cmd,"/FST",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Fast Food ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/FST1 - Burger Shot");
SendClientMessage(playerid,C,"/FST2 - Cluckin' Bell");
SendClientMessage(playerid,C,"/FST3 - Well Stacked Pizza");
SendClientMessage(playerid,C,"/FST4 - Rusty Brown's Donuts*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* complete but unused in game");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/FST1",true)==0){s="FooD/BURGers";t="Burger Shot";u="FDBURG";
v=10;w=315;x=366.923980;y=-72.929359;z=1001.507812; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST2",true)==0){s="FooD CHICKen";t="Cluckin' Bell";u="FDCHICK";
v=9;w=315;x=365.672974;y=-10.713200;z=1001.869995; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST3",true)==0){s="FooD PIZzA";t="Well Stacked Pizza";u="FDPIZA";
v=5;w=0;x=372.351990;y=-131.650986;z=1001.449951; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/FST4",true)==0){s="FooD/DONUTs - complete but unused in game";
t="Rusty Brown's Donuts";u="FDDONUT";v=17;w=0;x=377.098999;y=-192.439987;z=1000.643982;
showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GIRLFRIENDS /////////////////////////
if(strcmp(cmd,"/GRL",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Girlfriend Bedrooms ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GRL1 - Denise Robinson (Home Girl/Violent tendencies)");
SendClientMessage(playerid,C,"/GRL2 - Katie Zhan (Nurse/Neurotic)");
SendClientMessage(playerid,C,"/GRL3 - Helena Wankstein (Lawyer/Gun Nut)");
SendClientMessage(playerid,C,"/GRL4 - Michelle Cannes (Mechanic/Speed Freak)");
SendClientMessage(playerid,C,"/GRL5 - Barbara Schternvart (Cop/Control Freak)");
SendClientMessage(playerid,C,"/GRL6 - Millie Perkins (Croupier/Sex Fiend)");
SendClientMessage(playerid,C,"   --- THERE ARE NO EXITS FROM THESE ROOMS! ---");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GRL1",true)==0){s="Rewards: Pimp suit & Green Hustler";t="Denise's Bedroom";u="GF1";
v=1;w=235;x=244.411987;y=305.032990;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL2",true)==0){s="Rewards: Medic outfit & White Romero";t="Katie's Bedroom";u="GF2";
v=2;w=90;x=271.884979;y=306.631989;z=999.325989;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL3",true)==0){s="Rewards: Coveralls & Bandito";t="Helena's Bedroom (barn) - limited movement";
u="GF3";v=3;w=90;x=291.282990;y=310.031982;z=999.154968;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL4",true)==0){s="Rewards: Racing outfit & Monster Truck";t="Michelle's Bedroom";u="GF4";
v=4;w=0;x=302.181000;y=300.722992;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL5",true)==0){s="Rewards: Police uniform & Ranger";t="Barbara's Bedroom";u="GF5";
v=5;w=0;x=322.197998;y=302.497986;z=999.231995;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GRL6",true)==0){s="Rewards: Gimp suit & Pink Club";t="Millie's Bedroom";u="GF6";
v=6;w=180;x=346.870025;y=309.259033;z=999.155700;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GOVERNMENT /////////////////////////
if(strcmp(cmd,"/GOV",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== GOVERNMENT BUILDINGS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GOV1 - Sherman Dam");
SendClientMessage(playerid,C,"/GOV2 - Planning Department");
SendClientMessage(playerid,C,"/GOV3 - Area 69 - Upper level entrance");
SendClientMessage(playerid,C,"/GOV4 - Area 69 - Middle level - Map room");
SendClientMessage(playerid,C,"/GOV5 - Area 69 - Lowest level - Jetpack room");
SendClientMessage(playerid,C,"/GOV6 - Area 69 - Secret Vent entrance");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GOV1",true)==0){s="sherman DAM INside";t="Sherman Dam";u="DAMIN";
v=17;w=180;x=-959.873962;y=1952.000000;z=9.044310;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV2",true)==0){s="This place is HUGE!  Make your own spawn points!";t="Planning Department";u="PAPER";
v=3;w=90;x=388.871979;y=173.804993;z=1008.389954;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV3",true)==0){s="Wasn't this easy during the game...";t="AREA 69 entrance";u="Spectre";
v=0;w=90;x=220.4109;y=1862.277;z=13.147;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV4",true)==0){s="Great spawn screen possibilities!";t="AREA 69 Map room";u="Spectre";
v=0;w=90;x=226.853637;y=1822.760498;z=7.414062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV5",true)==0){s="Lowest point in game not underwater?";t="AREA 69 Jetpack room";u="Spectre";
v=0;w=180;x=268.725585;y=1883.816406;z=-30.093750;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GOV6",true)==0){s="Now what are you gonna do?";t="AREA 69 Vent entrance";u="Spectre";
v=0;w=120;x=245.696197;y=1862.490844;z=18.070953;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// GYMS /////////////////////////
if(strcmp(cmd,"/GYM",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== GYMS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GYM1 - Ganton, LS");
SendClientMessage(playerid,C,"/GYM2 - Cobra Gym in Garcia, SF");
SendClientMessage(playerid,C,"/GYM3 - Below the Belt Gym in Redsands East, LV");
SendClientMessage(playerid,C,"/GYM4 - Verona Beach Gym in LS*");
SendClientMessage(playerid,C,"/GYM5 - Madd Dogg's in Mulholland, LS*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* I threw these in because they ARE Gyms, Interior or not");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/GYM1",true)==0){s="Instrumental in initially reaching the Interiors";t="Ganton Gym in Ganton, LS";u="GYM1";
v=5;w=0;x=772.112000;y=-3.898650;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM2",true)==0){s="Sign outside misspells MarTIal as MarITal";t="Cobra Gym in Garcia, SF";u="GYM2";
v=6;w=0;x=774.213989;y=-48.924297;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM3",true)==0){s="The graffiti to your left is backwards";t="Below The Belt Gym in Redsands East, LV";u="GYM3";
v=7;w=0;x=773.579956;y=-77.096695;z=1000.687988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM4",true)==0){s="I know it's not an Interior but it IS a Gym";t="Verona Beach Gym";u="Spectre";
v=0;w=90;x=668.393188;y=-1867.325439;z=5.453720;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/GYM5",true)==0){s="Mentioned for continuity purposes only";t="Madd Dogg's Gym in Mulholland, LS";u="Spectre";
v=5;w=0;x=1234.144409;y=-764.087158;z=1084.007202; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// HOMIES ////////////////////////
if(strcmp(cmd,"/HOM",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== HOME BOYS ===");
SendClientMessage(playerid,C,"/HOM1 & /HOM2 - B Dup's Apt. & Crack pad");
SendClientMessage(playerid,C,"/HOM3 - Carl's Mom's House");
SendClientMessage(playerid,C,"/HOM4 thru /HOM6 - Madd Dogg's Mansion");
SendClientMessage(playerid,C,"/HOM7 - OG Loc's");
SendClientMessage(playerid,C,"/HOM8 - Ryder's House");
SendClientMessage(playerid,C,"/HOM9 - Sweet's House");
SendClientMessage(playerid,C,"/HOM10 thru /HOM17 - Big Smoke's Palace*");
SendClientMessage(playerid,C,"* The Crack Factory from the ground floor up");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/HOM1",true)==0){s="ONLY THE FLOOR IS SOLID!";t="B Dup's Apartment";u="BDUPS";
v=3;w=0;x=1527.229980;y=-11.574499;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM2",true)==0){s="ONLY THE FLOOR IS SOLID!";t="B Dup's Crack Pad";u="BDUPS1";
v=2;w=0;x=1523.509888;y=-47.821198;z=1002.269958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM3",true)==0){s="There's no place like home";t="CJ's Mom's House in Ganton, LS";u="CARLS";
v=3;w=180;x=2496.049805;y=-1693.929932;z=1014.750000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM4",true)==0){s="Upper (West) Entrance";t="Madd Dogg's Mansion (West door)";u="MADDOGS";
v=5;w=0;x=1263.079956;y=-785.308960;z=1091.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM5",true)==0){s="Lower (East) Entrance";t="Madd Dogg's Mansion (East door)";u="MDDOGS";
v=5;w=0;x=1299.079956;y=-795.226990;z=1084.029907;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM6",true)==0){s="Helipad";t="Madd Dogg's Mansion Helipad";u="Spectre";
v=0;w=90;x=1291.725341;y=-788.319885;z=96.460937;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM7",true)==0){s="ONLY FLOOR IS SOLID! (Check front door)";t="OG Loc's House";u="OGLOCS";
v=3;w=0;x=516.650;y=-18.611898;z=1001.459961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM8",true)==0){s="Funky lighting in the kitchen";t="Ryder's house";u="RYDERS";
v=2;w=90;x=2464.109863;y=-1698.659912;z=1013.509949;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM9",true)==0){s="DON'T GO ON SOUTH SIDE OF HOUSE!";t="Sweet's House";u="SWEETS";
v=1;w=270;x=2526.459961;y=-1679.089966;z=1015.500000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM10",true)==0){s="Ground floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2543.659912;y=-1303.629883;z=1025.069946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM11",true)==0){s="Warehouse floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=270;x=2530.980468;y=-1294.163085;z=1031.421875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM12",true)==0){s="Warehouse office";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2569.185058;y=-1281.929809;z=1037.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM13",true)==0){s="Factory floor";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=90;x=2564.201171;y=-1297.117797;z=1044.125000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM14",true)==0){s="Factory office";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2526.605468;y=-1281.239259;z=1048.289062;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM15",true)==0){s="Waiting Room";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=180;x=2535.017822;y=-1281.242553;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM16",true)==0){s="Statue Hallway (Check out side rooms)";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=0;x=2547.268310;y=-1295.931762;z=1054.640625;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/HOM17",true)==0){s="Outside the Living Area (Check the doormat!)";t="Big Smoke's Crack Factory";u="Spectre";
v=2;w=90;x=2580.114501;y=-1300.392944;z=1060.992187;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// PLACES OF ILL REPUTE /////////////////////////
if(strcmp(cmd,"/ILL",true)==0)	{wiper(playerid);
SendClientMessage(playerid,C,"=== PLACES OF ILL REPUTE ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/ILL1 - Big Spread Ranch");
SendClientMessage(playerid,C,"/ILL2 - Fanny Batter's Whore House");
SendClientMessage(playerid,C,"/ILL3 & /ILL4- World Class Topless Girls Strip Club & Private room");
SendClientMessage(playerid,C,"/ILL5 - Unnamed Brothel");
SendClientMessage(playerid,C,"/ILL6 - 'Tiger Skin Rug' Brothel");
SendClientMessage(playerid,C,"/ILL7 & /ILL8 - Jizzy's Pleasure Domes");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/ILL1",true)==0){s="NONE";t="Big Spread Ranch Strip Club";u="STRIP2";
v=3;w=180;x=1212.019897;y=-28.663099;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL2",true)==0){s="Check out the artwork";t="Fanny Batter's Whore House*";u="BROTHEL";
v=6;w=290;x=744.542969;y=1437.669922;z=1102.739990;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL3",true)==0){s="This is also the Pig Pen Interior";t="World Class Topless Girls Strip Club in Old Venturas Strip, LV";u="LASTRIP";
v=2;w=0;x=1204.809937;y=-11.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL4",true)==0){s="ONLY THE FLOOR IS SOLID!";
t="World Class Topless Girls Strip Club Private Dance Room";u="Spectre";
v=2;w=0;x=1204.809937;y=13.586800;z=1001.089966;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL5",true)==0){s="Furniture not solid";t="Unnamed Brothel";u="BROTHL1";
v=3;w=0;x=940.921997;y=-17.007000;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL6",true)==0){s="VERY Elaborate and NO, you can't ride the horsey!";
t="Tiger Skin Rug Brothel";u="BROTHL2";
v=3;w=90;x=964.106995;y=-53.205498;z=1001.179993;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL7",true)==0){s="Pleasure DOMES (roof scaffolding)";t="Jizzy's Pleasure Domes";u="PDOMES";
v=3;w=180;x=-2661.009766;y=1415.739990;z=923.305969;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/ILL8",true)==0){s="Pleasure DOMES (front entrance)";t="Jizzy's Pleasure Domes";u="PDOMES2";
v=3;w=90;x=-2637.449951;y=1404.629883;z=906.457947;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// LIBERTY CITY /////////////////////////
if(strcmp(cmd,"/LIB",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Liberty City ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/LIB1 - Marco's Bistro (from the street)");
SendClientMessage(playerid,C,"/LIB2 - Marco's Bistro Front Patio");
SendClientMessage(playerid,C,"/LIB3 - Marco's Bistro Inside/Upstairs");
SendClientMessage(playerid,C,"/LIB4 - Marco's Bistro Back yard");
SendClientMessage(playerid,C,"/LIB5 - Marco's Bistro Roof (Photo Op)");
SendClientMessage(playerid,C,"/LIB6 - Marco's Bistro Kitchen");
SendClientMessage(playerid,C,"There's not much up here but everybody wants to get here!");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/LIB1",true)==0){s="Positioning is mine";t="Marco's Bistro (from the street)";u="Spectre";
v=1;w=40;x=-735.5619504;y=484.351318;z=1371.952270;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB2",true)==0){s="Positioning is mine";t="Marco's Bistro Front Patio";u="Spectre";
v=1;w=90;x=-777.7556764;y=500.178070;z=1376.600463;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB3",true)==0){s="Positioning is mine";t="Marco's Bistro Inside/Upstairs";u="Spectre";
v=1;w=0;x=-794.8064;y=491.6866;z=1376.195;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB4",true)==0){s="Positioning is mine";t="Marco's Bistro Back Yard";u="Spectre";
v=1;w=0;x=-835.2504;y=500.9161;z=1358.305;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB5",true)==0){s="Positioning is mine (good photo op)";t="Marco's Bistro Rooftop";u="Spectre";
v=1;w=90;x=-813.431518;y=533.231079;z=1390.782958;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/LIB6",true)==0){s="Positioning is mine";t="Marco's Bistro Kitchen";u="Spectre";
v=1;w=180;x=-789.432800;y=509.146972;z=1367.374511;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// MISCELLANEOUS /////////////////////////
if(strcmp(cmd,"/MSC",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== MISCELLANEOUS STUFF === ");
SendClientMessage(playerid,C,"/MSC1 - Burning Desire Gang House");
SendClientMessage(playerid,C,"/MSC2 - Colonel Furburgher's House");
SendClientMessage(playerid,C,"/MSC3 - Crack Den");
SendClientMessage(playerid,C,"/MSC4 & /MSC5 -  2 Warehouses (4-empty/5-pillars)");
SendClientMessage(playerid,C,"/MSC6 - Sweet's Garage");
SendClientMessage(playerid,C,"/MSC7 - Lil' Probe Inn bathroom");
SendClientMessage(playerid,C,"/MSC8 - Unused Safe House");
SendClientMessage(playerid,C,"/MSC9 & /MSC10 - RC Battlefield (roof & inside)");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/MSC1",true)==0){s="Where you 1st meet Denise";t="Burning Desire Gang House";u="GANG";
v=5;w=90;x=2350.339844;y=-1181.649902;z=1028.000000; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC2",true)==0){s="Built a lot like CJ's house";t="Colonel Furhberger's";u="BURHOUS";
v=8;w=0;x=2807.619873;y=-1171.899902;z=1025.579956;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC3",true)==0){s="Notorious for the back room couch bj";t="Crack House";u="LACRAK";
v=5;w=0;x=318.564972;y=1118.209961;z=1083.979980; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC4",true)==0){s="Big & empty with no roof";t="Warehouse";u="SMASHTV";
v=1;w=135;x=1412.639893;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC5",true)==0){s="GENeric WaReHouSe - Lots of pillars";t="Warehouse";u="GENWRHS";
v=18;w=135;x=1302.519897;y=-1.787510;z=1000.931946;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC6",true)==0){s="Would make a good jail cell";t="Inside Sweet's Garage";u="Spectre";
v=0;w=90;x=2522.0;y=-1673.383911;z=14.8;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC7",true)==0){s="Would make a good jail cell";t="Lil' Probe Inn bathroom";u="Spectre";
v=18;w=90;x=-219.322601;y=1410.444824;z=27.773437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC8",true)==0){s="Pretty nice place...BUT NO BATHROOM!",t="Unused Safe House";u="SVLABIG";
v=12;w=0;x=2324.419922;y=-1147.539917;z=1050.719971;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC9",true)==0){s="On the roof";t="RC Battlefield (on the roof)";u="Spectre";
v=10;w=90;x=-972.4957;y=1060.983;z=1358.914;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/MSC10",true)==0){s="On the Battlefield";t="RC Battlefield (on the field)";u="Spectre";
v=10;w=90;x=-972.4957;y=1060.983;z=1345.669;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// PERSONAL GROOMING /////////////////////////
if(strcmp(cmd,"/PER",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== Barber Shops & Tattoo Parlors ===");
SendClientMessage(playerid,C,"/PER1 - Old Reece's Hair Facial Studio in Idlewood, LS");
SendClientMessage(playerid,C,"/PER2 - Gay Gordo's Barber Shop in Dillimore, the");
SendClientMessage(playerid,C,"               Barber's Pole in Queens, SF and");
SendClientMessage(playerid,C,"               Gay Gordo's Boufon Boutique in Redsands East, LV");
SendClientMessage(playerid,C,"/PER3 - Macisla's Unisex Hair Salon in Playa Del Seville, LS");
SendClientMessage(playerid,C,"/PER4 - Unnamed Tattoo Parlor in Idlewood, LS");
SendClientMessage(playerid,C,"/PER5 - Hemlock Tattoo parlor in Hashbury, SF");
SendClientMessage(playerid,C,"/PER6 - Unnamed Tattoo parlor in Redsands East, LV");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/PER1",true)==0){s="Check out the Jackson 5 pix on the wall!";
t="Old Reece's Hair Facial Studio in Idlewood,LS";u="BARBERS";
v=2;w=315;x=411.625977;y=-21.433298;z=1001.799988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER2",true)==0){s="Gay Gordo's got a shop in 'Queens'? Go figure.";
t="Gay Gordo's Barber Shop in Dillimore, The Barber's Pole in Queens and Gay Gordo's Boufon Boutique in Redsands East"
;u="BARBER2";v=3;w=0;x=418.652985;y=-82.639793;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER3",true)==0){s="The writing on the windows isn't visible from the outside!";
t="Macisla's Unisex Hair Salon";u="BARBER3";
v=12;w=270;x=412.021973;y=-52.649899;z=1001.959961;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER4",true)==0){s="NONE";t="Unnamed Tattoo Parlor Idlewood & Willowfield";u="TATTOO";
v=16;w=315;x=-204.439987;y=-26.453999;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER5",true)==0){s="TATTOo Parlor on Island 2";t="Hemlock Tattoo parlor in Hashbury, SF";u="TATTO2";
v=17;w=315;x=-204.439987;y=-8.469600;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/PER6",true)==0){s="TATTOo Parlor on Island 3";t="Unnamed Tattoo parlor in Redsands East, LV";u="TATTO3";
v=3;w=315;x=-204.439987;y=-43.652496;z=1002.299988;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// POLICE DEPARTMENTS /////////////////////////
if(strcmp(cmd,"/POL",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== POLICE DEPARTMENTS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/POL1 - Los Santos");
SendClientMessage(playerid,C,"/POL2 - San Fierro");
SendClientMessage(playerid,C,"/POL3 - Las Venturas (upper entrance)");
SendClientMessage(playerid,C,"/POL4 - Las Venturas (street entrance)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/POL1",true)==0){s="NONE";t="Los Santos PD";u="POLICE1";
v=6;w=0;x=246.783997;y=63.900200;z=1003.639954; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL2",true)==0){s="NONE";t="San Fierro PD";u="POLICE2";
v=10;w=0;x=246.375992;y=109.245995;z=1003.279968; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL3",true)==0){s="NONE";t="Las Venturas PD (upper entrance)";u="POLICE3";
v=3;w=0;x=288.745972;y=169.350998;z=1007.179993; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/POL4",true)==0){s="NONE";t="Las Venturas PD (street entrance)";u="POLICE4";
v=3;w=0;x=238.661987;y=141.051987;z=1003.049988; showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// SCHOOLS /////////////////////////
if(strcmp(cmd,"/SCH",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== SCHOOLS ===");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/SCH1 - Cycle School");
SendClientMessage(playerid,C,"/SCH2 - Automobile School");
SendClientMessage(playerid,C,"/SCH3 - Plane School");
SendClientMessage(playerid,C,"/SCH4 - Boat School*");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"* added for continuity purposes");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/SCH1",true)==0){s="BIKe SCHool";t="Bike School";u="BIKESCH";
v=3;w=90;x=1494.429932;y=1305.629883;z=1093.289917;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH2",true)==0){s="DRIVE School";t="Driving School";u="DRIVES";
v=3;w=90;x=-2029.719971;y=-115.067993;z=1035.169922;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH3",true)==0){s="DESerted HOUSe? DESert HOUSE?";t="Abandoned AC tower";u="DESHOUS";
v=10;w=45;x=420.484985;y=2535.589844;z=10.020289;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/SCH4",true)==0){s="Mentioned for continuity purposes only";t="Boat School";u="Spectre";
v=0;w=45;x=-2184.751464;y=2413.111816;z=5.156250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///////////////////////// STADIUMS /////////////////////////
if(strcmp(cmd,"/STA",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"=== STADIUMS ===");
SendClientMessage(playerid,C,"/STA1 - 8Track");
SendClientMessage(playerid,C,"/STA2 & /STA3 - Bloodbowl - lowel/upper levels");
SendClientMessage(playerid,C,"/STA4 - DirtBike");
SendClientMessage(playerid,C,"/STA5 - Kickstart");
SendClientMessage(playerid,C,"/STA6 - Vice Street Racers");
SendClientMessage(playerid,C,"/STA7 - Bandits Baseball Field");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"(all the coordinates are of my choosing)");
SendClientMessage(playerid,C,"type /MENU to return to the full category list");return 1;}
if(strcmp(cmd,"/STA1",true)==0){s="Um, 'cause it's shaped like an eight?";t="8-Track Stadium";u="8TRACK";
v=7;w=90;x=-1397.782470;y=-203.723114;z=1051.346801;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA2",true)==0){s="On the garage roof";t="Bloodbowl Stadium (in the bowl)";u="Spectre";
v=15;w=0;x=-1398.103515;y=933.445434;z=1041.531250;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA3",true)==0){s="Lighting is strange";t="Bloodbowl Stadium (upper loop)";u="Spectre";
v=15;w=315;x=-1396.110351;y=903.513671;z=1041.525390;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA4",true)==0){s="DIRt BIKE";t="Dirtbike Stadium";u="DIRBIKE";
v=4;w=45;x=-1428.809448;y=-663.595886;z=1060.219848;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA5",true)==0){s="This is just TOO cool!";t="Kickstart Stadium";u="Spectre";
v=14;w=225;x=-1486.861816;y=1642.145996;z=1060.671875;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA6",true)==0){s="Only center area is solid";t="Vice Stadium";u="Spectre";
v=1;w=90;x=-1401.830000;y=107.051300;z=1032.273000;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}
if(strcmp(cmd,"/STA7",true)==0){s="Included for continuity purposes";t="Bandits Baseball field";u="Spectre";
v=0;w=135;x=1382.615600;y=2184.345703;z=11.023437;showinfo(playerid,s,t,u,v,w,x,y,z);return 1;}

///// ///// ///// ///// ///// ///// ///// FUNCTIONAL OPTIONS ///// ///// ///// ///// ///// /////

if(strcmp(cmd,"/wipe",true)==0){wiper(playerid);return 1;}

if(strcmp(cmd,"/?",true)==0){wiper(playerid);GetPlayerPos(playerid,x,y,z);
GetPlayerFacingAngle(playerid,Float:w);
SendClientMessage(playerid,C,"\n");SendClientMessage(playerid,C,"=============");
format(msv,sizeof(msv), "Angle: %d", floatround(Float:w));SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv), "Interior: %d", hvn);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv), "X: %f", x);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv), "Y: %f", y);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv), "Z: %f", z);SendClientMessage(playerid,C,msv);
SendClientMessage(playerid,C,"=============");SendClientMessage(playerid,C,"\n");
return 1;}

if(strcmp(cmd,"/up",true)==0){wiper(playerid);
GetPlayerPos(playerid,x,y,z);GetPlayerFacingAngle(playerid,Float:w);
SetCameraBehindPlayer(playerid);SetPlayerInterior(playerid,hvn);
SetPlayerFacingAngle(playerid,w);SetPlayerPos(playerid,x,y,z+5);return 1;}

if(strcmp(cmd,"/dn",true)==0){wiper(playerid);
GetPlayerPos(playerid,x,y,z);GetPlayerFacingAngle(playerid,Float:w);
SetCameraBehindPlayer(playerid);SetPlayerInterior(playerid,hvn);
SetPlayerFacingAngle(playerid,w);SetPlayerPos(playerid,x,y,z-3);return 1;}

///// ///// ///// ///// ///// ///// INTRODUCTION OPTIONS ///// ///// ///// ///// ///// /////

if(strcmp(cmd,"/MORE1",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"What I've done here is compile a fairly comprehensive list of 'Hidden");
SendClientMessage(playerid,C,"Interiors', some of which are of my own choosing.  You can either view");
SendClientMessage(playerid,C,"them for the novelty of it or use them for your own script's startup screen.");
SendClientMessage(playerid,C,"Any time you type /? it will provide you with your current XYZ coordinates,");
SendClientMessage(playerid,C,"player angle and Interior number.  (Don't forget to mark the position for the");
SendClientMessage(playerid,C,"camera too!).  Or you could use one of the Burglary Houses for your Clan's");
SendClientMessage(playerid,C,"homebase.  Or one of the plane interiors for parachute practice (the Shamal's");
SendClientMessage(playerid,C,"got a great spot at the rear of the cabin).  Whatever you can dream up.");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MORE2 to continue or /MENU to get right to it...");
return 1;}

if(strcmp(cmd,"/MORE2",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"Chat has been disabled so you don't clutter up the screen.  Besides, what");
SendClientMessage(playerid,C,"have you got to talk about?  There's no game/money/weapons/vehicles here.");
SendClientMessage(playerid,C,"Only Interiors.  You can, however, clear the screen text at any time by typing");
SendClientMessage(playerid,C,"/wipe (in case you want to take a screen shot).  The radar map you'll have to");
SendClientMessage(playerid,C,"to turn off by yourself but the HUD can't currently be removed though.       ");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /INFO to continue or /MENU to get right to it...");
return 1;}

if(strcmp(cmd,"/INFO",true)==0){wiper(playerid);
SendClientMessage(playerid,C,"Here's a list of the available commands:");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/MORE1 - re-read the Introduction (boy are YOU bored!)");
SendClientMessage(playerid,C,"/INFO  - this page");
SendClientMessage(playerid,C,"/WIPE  - clears the text from the screen (photo ops)");
SendClientMessage(playerid,C,"/KILL  - in case you get stuck somewhere");
SendClientMessage(playerid,C,"/MENU thru /MENU4  - displays a list of the Interiors subcategories");
SendClientMessage(playerid,C,"/?     - displays your current position, angle and Interior *");
SendClientMessage(playerid,C,"* player Interior will display incorrectly while in the 'real' world");
SendClientMessage(playerid,C,"Enjoy/Spectre");return 1;}

if(strcmp(cmd,"/MENU",true)==0){wiper(playerid);
SendClientMessage(playerid,C," --- Main Menu  --- to see the submenus type /code (ex: /MENU1)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/MENU1 - 24/7s thru Car Mod shops");
SendClientMessage(playerid,C,"/MENU2 - Casino Oddities thru Girlfriends");
SendClientMessage(playerid,C,"/MENU3 - Government thru Miscellaneous");
SendClientMessage(playerid,C,"/MENU4 - Personal Grooming thru Stadiums");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU1",true)==0){wiper(playerid);
SendClientMessage(playerid,C," --- Menu 1 --- to see the submenus type /code (ex: /AIR)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/247 - 24/7s (6)");
SendClientMessage(playerid,C,"/AIR - All things aerodynamic (4)");
SendClientMessage(playerid,C,"/AMU - Ammunations (6)");
SendClientMessage(playerid,C,"/BUR - Burglary Houses (23)");
SendClientMessage(playerid,C,"/BUS - Businesses (8)");
SendClientMessage(playerid,C,"/CAR - Car Mod shops (5) (DANGER!...CRASH HAZARD!)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU1 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU2",true)==0){wiper(playerid);
SendClientMessage(playerid,C," --- Menu 2 --- to see the submenus type /code (ex: /CAS)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/CAS - Casino oddities (5)");
SendClientMessage(playerid,C,"/CLO - Clothing shops (6)");
SendClientMessage(playerid,C,"/CLU - Bars & Clubs (4)");
SendClientMessage(playerid,C,"/EAT - Diners & Eateries (5)");
SendClientMessage(playerid,C,"/FST - Fast Food joints (4)");
SendClientMessage(playerid,C,"/GRL - Girlfriend Bedrooms (6)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU2 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU3",true)==0){wiper(playerid);
SendClientMessage(playerid,C," --- Menu 3 --- to see the submenus type /code (ex: /GOV)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/GOV - Government related businesses (6)");
SendClientMessage(playerid,C,"/GYM - Gyms (5)");
SendClientMessage(playerid,C,"/HOM - Homies (17)");
SendClientMessage(playerid,C,"/ILL - Places of Ill Repute (8)");
SendClientMessage(playerid,C,"/LIB - Liberty City (6) (pretty boring actually)");
SendClientMessage(playerid,C,"/MSC - Miscellaneous stuff (8)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU3 to return to this screen...");return 1;}

if(strcmp(cmd,"/MENU4",true)==0){wiper(playerid);
SendClientMessage(playerid,C," --- Menu 4 --- to see the submenus type /code (ex: /PER)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"/PER - Personal Grooming (6) (Barbershops & Tattoo parlors)");
SendClientMessage(playerid,C,"/POL - Police Departments (4)");
SendClientMessage(playerid,C,"/SCH - Vehicle Schools (4)");
SendClientMessage(playerid,C,"/STA - Stadiums (8)");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"\n");
SendClientMessage(playerid,C,"type /MENU4 to return to this screen...");return 1;}

return OnPlayerCommandText(playerid,"/INFO");
}

///// ///// ///// ///// ///// ///// ///// NOMINAL GAME FUNCTIONS ///// ///// ///// ///// ///// ///// //////
public OnGameModeExit(){print("GameModeExit()");return 1;}
public OnPlayerInfoChange(playerid){printf("OnPlayerInfoChange(%d)");return 1;}
public OnPlayerStateChange(playerid,newstate,oldstate)
{printf("OnPlayerStateChange(%d, %d, %d)",playerid,newstate,oldstate);return 1;}
public OnVehicleSpawn(vehicleid){printf("OnVehicleSpawn(%d)",vehicleid);return 1;}
public OnPlayerEnterVehicle(playerid,vehicleid,ispassenger)
{printf("OnPlayerEnterVehicle(%d, %d, %d)",playerid,vehicleid,ispassenger);return 1;}
public OnPlayerDisconnect(playerid){printf("OnPlayerDisconnect(%d)",playerid);return 1;}
public OnPlayerEnterCheckpoint(playerid){printf("OnPlayerEnterCheckpoint(%d)",playerid);return 1;}
public OnPlayerLeaveCheckpoint(playerid){printf("OnPlayerLeaveCheckpoint(%d)",playerid);return 1;}
public OnVehicleDeath(vehicleid,killerid){printf("OnVehicleDeath(%d, %d)",vehicleid,killerid);return 1;}
public OnPlayerExitVehicle(playerid,vehicleid){printf("OnPlayerExitVehicle(%d, %d)",playerid,vehicleid);return 1;}
public OnPlayerDeath(playerid,killerid,reason){printf("OnPlayerDeath(%d, %d, %d)",playerid,killerid,reason);	return 1;}
public OnPlayerText(playerid){printf("OnPlayerText(%d)",playerid);return 0; }// I TURNED OFF ALL CHAT
///// ///// ///// ///// ///// ///// ///// NOMINAL GAME FUNCTIONS ///// ///// ///// ///// ///// ///// //////

strtok(const string[],&index){new length=strlen(string);
while((index<length)&&(string[index]<=' ')){index++;}new offset = index;new result[20];
while((index<length)&&(string[index]>' ')&&((index-offset)<(sizeof(result)-1)))
{result[index-offset]=string[index];index++;}result[index-offset]=EOS;return result;}

///// ///// ///// ///// ///// ///// ----- MY SUBROUTINES ----- ///// ///// ///// ///// ///// /////

wiper(playerid) // CLEAR SCREEN TEXT AND RESET PLAYER STATS
{for (new a=1;a<=10;a++){SendClientMessage(playerid,C,"\n");}
SetPlayerScore(playerid,0);ResetPlayerMoney(playerid);
ResetPlayerWeapons(playerid);SetPlayerHealth(playerid,100);return 1;}

showinfo(playerid,s[],t[],u[],v,w,Float:x,Float:y,Float:z){
wiper(playerid);GameTextForPlayer(playerid,t,6000,6);hvn=v;
format(msv,sizeof(msv),"Angle: %d",w);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Interior: %d",hvn);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"X: %f",x);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Y: %f",y);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Z: %f",z);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Title: %s",t);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Scm/User name: %s",u);SendClientMessage(playerid,C,msv);
format(msv,sizeof(msv),"Comments: %s",s);SendClientMessage(playerid,C,msv);
SetCameraBehindPlayer(playerid);SetPlayerInterior(playerid,hvn);
SetPlayerFacingAngle(playerid,w);SetPlayerPos(playerid,x,y,z);return 1;}

////////////////////////////////////////////////////////////////////////////////
