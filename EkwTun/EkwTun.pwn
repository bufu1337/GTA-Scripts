#include <a_samp>

#define dcmd(%1,%2,%3) if((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define COLOR_GREEN 0x33AA33AA
#define COLOR_ZIELONY 0xFF00FF

new Maluj[21]= {
0,1,2,4,8,-2,-3,-4,-6,-8,-9,-10,-11,-12,-13,-14,-15,-16,-17,-19,-20,
};

public OnFilterScriptInit()
{
    print("EwkTun by Ekwador 4YOU!");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

main()
{
	print("EwkTun by Ekwador 4YOU!");
}

public OnPlayerCommandText(playerid, cmdtext[])
{
dcmd(tuning,6,cmdtext);

if(strcmp(cmdtext,"/about",true)== 0) {
SendClientMessage(playerid, COLOR_ZIELONY, "Paintjobs By Ekwador!");
return 1;}
return 0;}

dcmd_tuning(playerid, cmdtext[]) {
#pragma unused cmdtext
new vehicleid = GetPlayerVehicleID(playerid);
new cartype = GetVehicleModel(vehicleid);
if(cartype == 562) {
AddVehicleComponent(vehicleid,1034);
AddVehicleComponent(vehicleid,1035);
AddVehicleComponent(vehicleid,1036);
AddVehicleComponent(vehicleid,1040);
AddVehicleComponent(vehicleid,1149);
AddVehicleComponent(vehicleid,1171);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 560) {
AddVehicleComponent(vehicleid,1026);
AddVehicleComponent(vehicleid,1027);
AddVehicleComponent(vehicleid,1029);
AddVehicleComponent(vehicleid,1032);
AddVehicleComponent(vehicleid,1149);
AddVehicleComponent(vehicleid,1141);
AddVehicleComponent(vehicleid,1169);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 559) {
AddVehicleComponent(vehicleid,1162);
AddVehicleComponent(vehicleid,1159);
AddVehicleComponent(vehicleid,1160);
AddVehicleComponent(vehicleid,1069);
AddVehicleComponent(vehicleid,1070);
AddVehicleComponent(vehicleid,1067);
AddVehicleComponent(vehicleid,1065);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 575) {
AddVehicleComponent(vehicleid,1042);
AddVehicleComponent(vehicleid,1044);
AddVehicleComponent(vehicleid,1174);
AddVehicleComponent(vehicleid,1176);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 558) {
AddVehicleComponent(vehicleid,1088);
AddVehicleComponent(vehicleid,1089);
AddVehicleComponent(vehicleid,1090);
AddVehicleComponent(vehicleid,1094);
AddVehicleComponent(vehicleid,1166);
AddVehicleComponent(vehicleid,1168);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 561) {
AddVehicleComponent(vehicleid,1055);
AddVehicleComponent(vehicleid,1056);
AddVehicleComponent(vehicleid,1062);
AddVehicleComponent(vehicleid,1058);
AddVehicleComponent(vehicleid,1064);
AddVehicleComponent(vehicleid,1154);
AddVehicleComponent(vehicleid,1155);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 565) {
AddVehicleComponent(vehicleid,1046);
AddVehicleComponent(vehicleid,1047);
AddVehicleComponent(vehicleid,1051);
AddVehicleComponent(vehicleid,1054);
AddVehicleComponent(vehicleid,1150);
AddVehicleComponent(vehicleid,1153);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 576) {
AddVehicleComponent(vehicleid,1134);
AddVehicleComponent(vehicleid,1136);
AddVehicleComponent(vehicleid,1137);
AddVehicleComponent(vehicleid,1190);
AddVehicleComponent(vehicleid,1192);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 535) {
AddVehicleComponent(vehicleid,1113);
AddVehicleComponent(vehicleid,1115);
AddVehicleComponent(vehicleid,1117);
AddVehicleComponent(vehicleid,1118);
AddVehicleComponent(vehicleid,1120);
AddVehicleComponent(vehicleid,1109);
//Complmentary
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);
ChangeVehiclePaintjob(vehicleid,Maluj[random(sizeof(Maluj))]);}
if(cartype == 411) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 506) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 477) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 541) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 409) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 451) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 402) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 480) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 567) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 429) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 507) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 421) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 549) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 420) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
if(cartype == 415) {
AddVehicleComponent(vehicleid,1073);
AddVehicleComponent(vehicleid,1087);}
return 1;}

public OnPlayerConnect(playerid) {
SendClientMessage(playerid, COLOR_ZIELONY, "This server use EkwTun By Ekwador!");
SendClientMessage(playerid, COLOR_ZIELONY, "Use /about or /tuning");
return 1;}
