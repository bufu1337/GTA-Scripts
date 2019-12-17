#include <DUDB>
forward OnGameModeInit1();
forward OnGameModeInit2();
forward OnPlayerPickUpPickup1(playerid, pickupid);
forward OnPlayerSelectedMenuRow1(playerid, row);
forward OnPlayerExitedMenu1(playerid);

new Mname[25] = " ";
new Info[256] = "Info";
new Buy[256] = "Buy"; 
new Rent[256] = "Rent";
new Exit[256] = "Get Out";
new Enter[256] = "Enter";
new Sell[256] = "Sell";
new Lock[256] = "Lock";
new EatFood[256] = "Eat Food";
new Exercise[256] = "Exercise";
new Menu:gMenux[256];

new tot = 0;
new Rmoney = 750;
new Omoney = 50000;
new houseo[256];
new housep[256];
forward OnBuy(playerid,HouseNo);
forward OnRent(playerid,HouseNo);
forward OnPlayerCmdText(playerid,cmdtext[]);
forward OnPlayerSelectMenuRow(playerid,row); 
forward TakePlayerMoney(playerid,money);
forward OnInfo(playerid,HouseNo);
forward OnEnter(playerid,HouseNo);
forward SellHouse(playerid,HouseNo);
forward LockHouse(playerid,HouseNo);
forward LockTest(playerid,HouseNo);
forward OnPlayerExitMenu(playerid);
forward DestroyCurrentMenu(playerid);
forward DestroyAllMenus();
public OnPlayerCmdText(playerid, cmdtext[])
{
if (strcmp("/build house small", cmdtext, true) == 0)
	{

if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Add this under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n// Add this under OnPlayerPickUpPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n// Add this under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(4);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,1);";
housep = "SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2262.83,-1137.71,1050.63);";
}
if (ran == 4){
houseo = "SetPlayerInterior(playerid,9);";
housep = "SetPlayerPos(playerid,2251.85,-1138.16,1050.63);";
}
format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}",totS);
fwrite(Step5,line1);



format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }}}",totS);
fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);
fclose(Step5);

new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Add this under OnPlayerExitedMenu");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n// Add this under  OnGameModeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
	}

if (strcmp("/build house medium", cmdtext, true) == 0)
	{

if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Add this under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n// Add this under OnPlayerPickUpPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n// Add this under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(3);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,2451.77, -1699.80,1013.51);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,385.803986,1471.769897,1080.209961  );";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2260.76,-1210.45,1049.02);";
}

format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }}}",totS);fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);

format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);


fclose(Step5);
new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Add this under OnPlayerExitedMenu");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n// Add this under OnGameModeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);

SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
	}
if (strcmp("/build house large", cmdtext, true) == 0)
	{

if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Add this under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n// Add this under OnPlayerPickUpPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n// Add this under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(3);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,3);";
housep = "SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,7);";
housep = "SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,8);";
housep = "SetPlayerPos(playerid,2807.63,-1170.15,1025.57);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,1 );";
housep = "SetPlayerPos(playerid,-2158.72,641.29,1052.38);";
}
format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);

format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }}}",totS);fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);

format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);

format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);

format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);


fclose(Step5);
new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n// Under OnPlayerExitMenu");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);

format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n// Under OnGameModeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");}
	

if (strcmp("/build", cmdtext, true)==0)
{
gMenux[255] = CreateMenu(Mname, 2, 100, 200, 175, 50);
AddMenuItem(gMenux[255],0,"Small House");
AddMenuItem(gMenux[255],0,"Medium House");
AddMenuItem(gMenux[255],0,"Large House");
AddMenuItem(gMenux[255],0,"Restart All");
AddMenuItem(gMenux[255],0," <---");
AddMenuItem(gMenux[255],1,"[/build house small]");
AddMenuItem(gMenux[255],1,"[/build house medium]");
AddMenuItem(gMenux[255],1,"[/build house large]");
AddMenuItem(gMenux[255],1,"[/restartall]");
AddMenuItem(gMenux[255],1,"Cancel");
ShowMenuForPlayer(gMenux[255],playerid);
TogglePlayerControllable(playerid,0);
}

if (strcmp("/restartall", cmdtext, true) == 0){
if (fexist("Setup.sts")){fremove("Setup.sts");}
if (fexist("Step2.txt")){fremove("Step2.txt");}
if (fexist("Step1.txt")){fremove("Step1.txt");}
if (fexist("Step4.txt")){fremove("Step4.txt");}
if (fexist("Step5.txt")){fremove("Step5.txt");}
if (fexist("Step6.txt")){fremove("Step6.txt");}
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Restart Was Successfull.");
}


return 1;
}





public OnPlayerSelectMenuRow(playerid, row)
{
new Menu:Current = GetPlayerMenu(playerid);
if (Current == gMenux[255]) {
switch(row) {
case 0: {

if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n// Under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n//Under OnPlayerPickupPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n//Under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(4);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,1);";
housep = "SetPlayerPos(playerid,223.043991,1289.259888,1082.199951);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,295.138977,1474.469971,1080.519897);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,328.493988,1480.589966,1084.449951);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2262.83,-1137.71,1050.63);";
}
if (ran == 4){
houseo = "SetPlayerInterior(playerid,9);";
housep = "SetPlayerPos(playerid,2251.85,-1138.16,1050.63);";
}
format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }}}",totS);fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);


fclose(Step5);
new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n//Under OnPlayerExitMenu");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n//Under OnGamemodeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
TogglePlayerControllable(playerid,1);	

}

case 1:
	{
DestroyCurrentMenu(playerid);

if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n//Under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n//Under OnPlayerPickupPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n// Under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(3);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,225.756989,1240.000000,1082.149902);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,2);";
housep = "SetPlayerPos(playerid,2451.77, -1699.80,1013.51);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,15);";
housep = "SetPlayerPos(playerid,385.803986,1471.769897,1080.209961  );";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,10);";
housep = "SetPlayerPos(playerid,2260.76,-1210.45,1049.02);";
}

format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);}}}");fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\n ",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\n ",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);


fclose(Step5);
new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n//Under OnPlayerExitedMenu");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n//Under GameModeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
TogglePlayerControllable(playerid,1);
	
}
case 2:
	{
DestroyCurrentMenu(playerid);


if (fexist("Setup.sts")){}
else{new File:sts0 = fopen("Setup.sts",io_write);fclose(sts0);}
new File:sts1 = fopen("Setup.sts",io_read);
new stsS[256];
new stsV =0 ;
new tot1 = 0;
new totS[256];
new totvS[256];
fread(sts1,stsS,256,false);
stsV = strval(stsS);
tot = stsV;
tot1 = tot + 1;
valstr(totS,tot,false);
valstr(totvS,tot1,false);
new File:sts2 = fopen("Setup.sts",io_write);
fwrite(sts2,totvS);
fclose(sts2);

new Float:X,Float:Y,Float:Z;
GetPlayerPos(playerid,X,Y,Z);
CreateObject(1272,X,Y,Z,0,0,0);
new File:Step2 = fopen("Step2.txt",io_append);
new AdStaticPickup[256];
if (tot == 0){
format(AdStaticPickup,150,"\r\n//Under OnGameModeInit");fwrite(Step2,AdStaticPickup);}
format(AdStaticPickup,255,"\r\nAddStaticPickup(1273,2,%f,%f,%f);//Pickup Id %s;",X,Y,Z,totS);
fwrite(Step2,AdStaticPickup);
fclose(Step2);


new File:Step1 = fopen("Step1.txt",io_append);
new gMenu[256];
if (tot == 0){
format(gMenu,150,"\r\n// Add this at the top of your script");fwrite(Step1,gMenu);}
format(gMenu,256,"\r\nnew Menu:gMenu%s[256];",totS);fwrite(Step1,gMenu);
format(gMenu,256,"\r\nnew Menu:gMenue%s[256];",totS);fwrite(Step1,gMenu);
fclose(Step1);

new File:Step4 = fopen("Step4.txt",io_append);
new pickup1[256];

if (tot == 0){
format(pickup1,150,"\r\n//Under OnPlayerPickupPickup");fwrite(Step4,pickup1);}
format(pickup1,256,"\r\nif ( pickupid == %s ){",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nShowMenuForPlayer(gMenu%s[255],playerid);",totS);fwrite(Step4,pickup1);
format(pickup1,256,"\r\nTogglePlayerControllable(playerid,0);}",totS);fwrite(Step4,pickup1);

fclose(Step4);

new File:Step5 = fopen("Step5.txt",io_append);
new line1[256];

if (tot == 0){
format(line1,150,"\r\n//Under OnPlayerSelectedMenuRow");fwrite(Step5,line1);
format(line1,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step5,line1);}
format(line1,256,"\r\nif (Current == gMenu%s[255]) {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");
fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
new ran = random(3);
if (ran == 0){
houseo = "SetPlayerInterior(playerid,3);";
housep = "SetPlayerPos(playerid,235.508994,1189.169897,1080.339966);";
}
if (ran == 1){
houseo = "SetPlayerInterior(playerid,7);";
housep = "SetPlayerPos(playerid,225.630997,1022.479980,1084.069946);";
}
if (ran == 2){
houseo = "SetPlayerInterior(playerid,8);";
housep = "SetPlayerPos(playerid,2807.63,-1170.15,1025.57);";
}
if (ran == 3){
houseo = "SetPlayerInterior(playerid,1 );";
housep = "SetPlayerPos(playerid,-2158.72,641.29,1052.38);";
}
format(line1,256,"\r\nOnInfo(playerid,%s);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 1:	{");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);");
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnEnter(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s }}",housep,totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 2: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnBuy(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 3: {");
fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nif (OnRent(playerid,%s)==1){",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",houseo);
fwrite(Step5,line1);
format(line1,256,"\r\n%s",housep);
fwrite(Step5,line1);
format(line1,256," }}",totS);
fwrite(Step5,line1);
format(line1,256,"\r\ncase 4: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nSellHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }",totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 5: {");fwrite(Step5,line1);
format(line1,256,"\r\nDestroyCurrentMenu(playerid);",totS);
fwrite(Step5,line1);
format(line1,256,"\r\nLockHouse(playerid,%s);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nTogglePlayerControllable(playerid,1); }}}",totS);fwrite(Step5,line1);


format(line1,256,"\r\nif (Current == gMenue%s[255]) {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nswitch(row) {");fwrite(Step5,line1);
format(line1,256,"\r\ncase 0: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Chealth;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerHealth(playerid,Chealth);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerHealth(playerid,Chealth+25);");fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 1: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nnew Float:Carmour;");fwrite(Step5,line1);
format(line1,256,"\r\nGetPlayerArmour(playerid,Carmour);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerArmour(playerid,Carmour+2);",X,Y,Z);fwrite(Step5,line1);
format(line1,256,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS,totS);fwrite(Step5,line1);

format(line1,256,"\r\ncase 2: {",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerInterior(playerid,0);",totS);fwrite(Step5,line1);
format(line1,256,"\r\nSetPlayerPos(playerid,%f,%f,%f);}}}",X,Y,Z,totS);
fwrite(Step5,line1);


fclose(Step5);
new File:Step6 = fopen("Step6.txt",io_append);
new line2[150];
if (tot == 0){
format(line2,150,"\r\n//Under OnPlayerExitedMenuRow");fwrite(Step6,line2);
format(line2,150,"\r\nnew Menu:Current = GetPlayerMenu(playerid);");fwrite(Step6,line2);}
format(line2,150,"\r\nif( Current == gMenu%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nTogglePlayerControllable(playerid,1);}");fwrite(Step6,line2);
format(line2,150,"\r\nif( Current == gMenue%s[255]){",totS);fwrite(Step6,line2);
format(line2,150,"\r\nShowMenuForPlayer(gMenue%s[255],playerid);}",totS);fwrite(Step6,line2);
fclose(Step6);
new File:Step3 = fopen("Step3.txt",io_append);
new line6[150];
if (tot == 0){
format(line6,150,"\r\n//Under OnGameModeInit");fwrite(Step3,line6);}
format(line6,256,"\r\ngMenu%s[255] = CreateMenu(Mname, 2, 50, 200, 41, 30);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Info);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Enter);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Buy);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Rent);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Sell);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenu%s[255],0,%s);",totS,Lock);fwrite(Step3,line6);
format(line6,256,"\r\ngMenue%s[255] = CreateMenu(Mname,1,50,200,50,25);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,EatFood);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exercise);",totS);fwrite(Step3,line6);
format(line6,256,"\r\nAddMenuItem(gMenue%s[255],0,Exit);",totS);fwrite(Step3,line6);
fclose(Step3);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: A Blue Print For The House Was Successfully Generated.");
TogglePlayerControllable(playerid,1);

	}
case 3: {
if (fexist("Setup.sts")){fremove("Setup.sts");}
if (fexist("Step2.txt")){fremove("Step2.txt");}
if (fexist("Step1.txt")){fremove("Step1.txt");}
if (fexist("Step4.txt")){fremove("Step4.txt");}
if (fexist("Step5.txt")){fremove("Step5.txt");}
if (fexist("Step6.txt")){fremove("Step6.txt");}
TogglePlayerControllable(playerid,1);
SendClientMessage(playerid,0xFFFFFFAA,"KIHC: Restart Was Successfull.");

}
case 4: {
DestroyMenu(gMenux[255]);
TogglePlayerControllable(playerid,1);
}}}




return 1;
}


public OnBuy(playerid,HouseNo){
new HouseName[256];
new pname[25];
new file[25];
GetPlayerName(playerid,pname,25);
format(HouseName,256,"House%d",HouseNo);
format(file,25,"%s.dudb.sav",HouseName);

if (fexist(file)){
SendClientMessage(playerid,0xFF0000AA,"GAME: The House Is Not For Sale.");
return 0;
}
else{
if (TakePlayerMoney(playerid,Omoney)==1){
GameTextForPlayer(playerid,"Congrats For Your New House",5000,5);
udb_Create(HouseName,"lol");
dUserSet(HouseName).("Owner",pname);
dUserSet(HouseName).("Tenent1","none");
dUserSet(HouseName).("Tenent2","none");
dUserSet(HouseName).("Tenent3","none");
dUserSet(HouseName).("Tenent4","none");
dUserSet(HouseName).("Tenent5","none");
dUserSet(HouseName).("Lock","No");
return 1;
}
}
return 0;
}
public OnRent(playerid,HouseNo){
new SHouseNo[256];
new HouseName[256];
new pname[25];
new file[25];
valstr(SHouseNo,HouseNo,true);
GetPlayerName(playerid,pname,25);
format(HouseName,256,"House%d",HouseNo);
format(file,25,"%s.dudb.sav",HouseName);
if (fexist(file)){
if (TakePlayerMoney(playerid,Rmoney)==1){

new T1[255];
T1 = dUser(HouseName).("Tenent1");
if (strcmp(T1,"none",true)==0){
dUserSet(HouseName).("Tenent1",pname);
SendClientMessage(playerid,0xFF0000AA,"GAME: Now You Rent This House.");
return 1;
}
else{
T1 = dUser(HouseName).("Tenent2");
if (strcmp(T1,"none",true)==0){
dUserSet(HouseName).("Tenent2",pname);
SendClientMessage(playerid,0xFF0000AA,"GAME: Now You Rent This House.");
return 1;
}
else{
T1 = dUser(HouseName).("Tenent3");
if (strcmp(T1,"none",true)==0){
dUserSet(HouseName).("Tenent3",pname);
SendClientMessage(playerid,0xFF0000AA,"GAME: Now You Rent This House.");
return 1;
}

else{
T1 = dUser(HouseName).("Tenent4");
if (strcmp(T1,"none",true)==0){
dUserSet(HouseName).("Tenent4",pname);
SendClientMessage(playerid,0xFF0000AA,"GAME: Now You Rent This House.");
return 1;
}

else{
T1 = dUser(HouseName).("Tenent5");
if (strcmp(T1,"none",true)==0){
dUserSet(HouseName).("Tenent5",pname);
SendClientMessage(playerid,0xFF0000AA,"GAME: Now You Rent This House.");
return 1;
}

else{
SendClientMessage(playerid,0xFF0000AA,"GAME: There Are No Empty Rooms Available In This House.");

}}}}}}

}
else{
}
return 0;
}
public TakePlayerMoney(playerid,money)
{
new Cmoney = GetPlayerMoney(playerid);
if (Cmoney <= money){
SendClientMessage(playerid,0xFF0000AA,"GAME: You Dont Have Enough Money.");
return 0; }
else {
GivePlayerMoney(playerid,-money);
return 1;}
}
public OnInfo(playerid,HouseNo){
new HouseName[25];
new file[250];
format(file,250,"house%d.dudb.sav",HouseNo);
format(HouseName,250,"house%d",HouseNo);
if (fexist(file)){
new Owner[256];
Owner = dUser(HouseName).("Owner");
new string[256];
format(string,255,"-( House Owner: %s )-~n~-( House Rent: %d )-",Owner,Rmoney);
GameTextForPlayer(playerid,string,5000,5);
}
else{
new string[256];
format(string,255,"-( House Owner: None )-~n~-( House Cost: %d )-",Omoney);
GameTextForPlayer(playerid,string,5000,5);
}
TogglePlayerControllable(playerid,1);
}
public OnEnter(playerid,HouseNo){
new HouseName[256];
new File[256];
new Pname[256];
GetPlayerName(playerid,Pname,25);
format(HouseName,255,"House%d",HouseNo);
format(File,255,"%s.dudb.sav",HouseName);
if (fexist(File)){
new Who[256];
Who = dUser(HouseName).("Lock");
if (strcmp(Who,"Yes",true)==0){
GameTextForPlayer(playerid,"The House is LOCKED",5000,5);
return 0;
}
Who = dUser(HouseName).("Owner");
if (strcmp(Who,Pname,true)==0){return 1;}
Who = dUser(HouseName).("Tenent1");
if (strcmp(Who,Pname,true)==0){return 1;}
Who = dUser(HouseName).("Tenent2");
if (strcmp(Who,Pname,true)==0){return 1;}
Who = dUser(HouseName).("Tenent3");
if (strcmp(Who,Pname,true)==0){return 1;}
Who = dUser(HouseName).("Tenent4");
if (strcmp(Who,Pname,true)==0){return 1;}
Who = dUser(HouseName).("Tenent5");
if (strcmp(Who,Pname,true)==0){return 1;}
}
else{
return 1;
}
return 0;
}
public SellHouse(playerid,HouseNo){

new Pname[256];
new Owns[256];
new HouseName[256];
new file[256];
format(HouseName,255,"House%d",HouseNo);
format(file,255,"%s.dudb.sav",HouseName);
GetPlayerName(playerid,Pname,25);
Owns = dUser(HouseName).("Owner");
if (fexist(file)){
if (strcmp(Owns,Pname,true)==0){
fremove(file);
SendClientMessage(playerid,0xFFFF00AA,"GAME: House Was Sold To The Government.");
GivePlayerMoney(playerid,Omoney);}}
else{
SendClientMessage(playerid,0xFFFF00AA,"GAME: You Dont Own That House.");
}}

public LockHouse(playerid,HouseNo){
LockTest(playerid,HouseNo);
}

public LockTest(playerid,HouseNo){
new HouseName[256];
new File[256];
new Pname[256];
GetPlayerName(playerid,Pname,25);
format(HouseName,255,"House%d",HouseNo);
format(File,255,"%s.dudb.sav",HouseName);
if (fexist(File)){
new Who[256];
new How[256];

Who = dUser(HouseName).("Owner");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"unlocked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"locked",5000,5);}}


Who = dUser(HouseName).("Tenent1");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"locked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"unlocked",5000,5);}}

Who = dUser(HouseName).("Tenent2");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"locked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"unlocked",5000,5);}}

Who = dUser(HouseName).("Tenent3");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
Who = dUser(HouseName).("Lock");
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"locked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"unlocked",5000,5);}}

Who = dUser(HouseName).("Tenent4");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"locked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"unlocked",5000,5);}}

Who = dUser(HouseName).("Tenent5");
if (strcmp(Who,Pname,true)==0){
How = dUser(HouseName).("Lock");
if (strcmp(How,"Yes",true)==0){
dUserSet(HouseName).("Lock","No");
GameTextForPlayer(playerid,"locked",5000,5);}
else{
dUserSet(HouseName).("Lock","Yes");
GameTextForPlayer(playerid,"unlocked",5000,5);}}
}
else {GameTextForPlayer(playerid,"you dont have the keys",5000,5);}
}
public OnPlayerExitMenu(playerid)
{
new Menu:Current = GetPlayerMenu(playerid);
if (Current == gMenux[255]) {
ShowMenuForPlayer(gMenux[255],playerid);
}
}
public DestroyCurrentMenu(playerid)
{
//--- Function Removed Due to BUG's MOTHER !

}
