#include <a_samp>
//#include <JB>
#define YES 1
#define NO 0


new porta[11];
new stado;
new owner[7];
new driving[7];
new jugadores[7];
new names[7][256] =
{
{"USS JB"},
{"USS KOMMANDANT"},
{"NAUTILUS"},
{"SUB-ZERO"},
{"USS DESTOYER"},
{"Profound Mommy"},
{"Quiet Pupil"}
};

new gangzones[8];
new jugador;
//new barril;
new vehicleModel[254];
new rustler;
new Float:posaa;
new Float:posbb;
new Float:poscc;
//new torpedos;
new sub[7];
new torpedo[7];
new cameramode[7];
new fired[7];
new hundidocarrier;
new hundido[7];
new timer2;
new timer1;
new Menu:subs;
new timerexplot;
new timer3;


//new timer3;
//forward IsObjectNearObject(objectid1,objectid2,radius);
forward volver();
forward golpear();
forward balancear();
forward timer();
forward getpos();
forward getpos2();
forward getpos3();
forward nuevo();
forward gangdestroy();
forward camera();
forward torpedotimer();
forward explode();
forward resetcam();
forward AddVehicle(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,color1,color2);
forward explode2();

forward get();

//new player[MAX_PLAYERS];


public OnFilterScriptInit()
{
	print("---\n PORTAVIONES POR JB [Der_Kommandant]\n---");
    print("--- SUB By JB [Der_Kommandant] \n---");

    sub[0] = CreateObject(9958,6500.00, -2957.0100,0.2051, 0.0000, 0.0000, 90.0000); // USS JB
    sub[1] = CreateObject(9958,-1360.0133,390.3428,0.2051, 0.0000, 0.0000, 90.0000); //USS KOMMANDANT
    sub[2] = CreateObject(9958,-1358.3513,426.7680,-0.5439, 0.0000, 0.0000, 90.0000); //NAUTILUS
    sub[3] = CreateObject(9958,-1352.7549,355.2697,-0.4749, 0.0000, 0.0000, 90.0000); //SUB-ZERO
    sub[4] = CreateObject(9958,6800.00, -2657.0100,-15.2051, 0.0000, 0.0000, 90.0000); //USS DESTROYER
    sub[5] = CreateObject(9958,806.6816,-2027.1234,-0.6739, 0.0000, 0.0000, 0.0000); //USS Mommy
    sub[6] = CreateObject(9958,29.2452,-2072.8572,-23.1965, 0.0000, 0.0000, 90.0000); //USS Quiet Pupil
    
	subs = CreateMenu("Subs",1,440,140,150,40);
	AddMenuItem(subs,0,"USS JB");
	AddMenuItem(subs,0,"USS KOMMANDANT");
	AddMenuItem(subs,0,"NAUTILUS");
	AddMenuItem(subs,0,"SUB-ZERO");
	AddMenuItem(subs,0,"USS DESTROYER");
	AddMenuItem(subs,0,"Profound Mommy"); //http://forum.sa-mp.com/index.php?topic=61217.15
	AddMenuItem(subs,0,"Quiet Pupil");
	for(new i=0;i<7;i++){
	driving[i] = NO;
	hundido[i] = NO;
	cameramode[i] = 1;
    jugadores[i]=-1;
    fired[i]=NO;
	}
	hundidocarrier = NO;
	SetTimer("gangdestroy",60000,true);
	
	porta[0] = CreateObject(10770,6541.14, -2927.2800, 37.5800, 0.0000, 0.0000, 0.0000);
	porta[1] = CreateObject(10771, 6537.67, -2919.6300, 4.66000, 0.0000, 0.0000, 0.0000);
	porta[2] = CreateObject(11237, 6541.00, -2927.0100, 35.3800, 0.0000, 0.0000, 0.0000);
	porta[3] = CreateObject(10772, 6538.90, -2920.0800, 16.4400, 0.0000, 0.0000, 0.0000);
	porta[4] = CreateObject(11146, 6528.84, -2918.8000, 11.3800, 0.0000, 0.0000, 0.0000);
	porta[5] = CreateObject(11148, 6529.03, -2919.4300, 12.9800, 0.0000, 0.0000, 0.0000);
	porta[6] = CreateObject(11145, 6475.00, -2919.7000, 3.30000, 0.0000, 0.0000, 0.0000);
	porta[7] = CreateObject(11149, 6531.78, -2924.9000, 10.9000, 0.0000, 0.0000, 0.0000);
	porta[8] = CreateObject(3114, 6480.870, -2904.6600, 15.79000, 0.0000, 0.0000, 0.0000);
	porta[9] = CreateObject(3115, 6438.570, -2919.7900, 16.0100, 0.0000, 0.0000, 0.0000);
	porta[10] = CreateObject(3113, 6430.43, -2919.55, 0.25, 0.00, 0.00, 0.00);
	//torpedos = 3790;
	
	posaa = 6441.4097;
	posbb = -2920.3464;
	poscc = 17.8794;
	rustler = AddVehicle(476,posaa,posbb,poscc+3,267.6705,1,53); //
	//AddStaticVehicle(513,6475.4868,-2927.3081,17.9912,269.3712,55,20); //
	jugador=-1;
	SetTimer("balancear",4000,true);

	stado = NO;
	hundidocarrier = NO;
	return 1;
}

public OnFilterScriptExit()
{
	for(new i=0;i<100;i++){
	if(IsValidObject(porta[i])){
	DestroyObject(porta[i]);
	}
	if(IsValidObject(torpedo[i])){
	DestroyObject(torpedo[i]);
	}
	if(IsValidObject(sub[i])){
	DestroyObject(sub[i]);
	}
	}
}


//------------------------------------------------------------------------------



public OnPlayerKeyStateChange(playerid, newkeys, oldkeys){

	for(new i=0;i<7;i++){
	if(jugadores[i]==playerid){
	if(driving[i] == YES){
	new keys, updown, leftright;
	new Float:X, Float:Y, Float:Z;
    new Float:A, Float:M, Float:D;
	GetPlayerKeys(jugadores[i], keys, updown, leftright);
 	GetObjectRot(sub[i],A,M,D);
 	
 	
 	if((updown & KEY_UP) == KEY_UP)/*(updown == KEY_DOWN)*/{

    GetObjectRot(sub[i],A,M,D);
	SetObjectRot(sub[i],A,M,0);
	}
	if((updown & KEY_DOWN) == KEY_DOWN)/*(updown == KEY_UP)*/{

    GetObjectRot(sub[i],A,M,D);
	SetObjectRot(sub[i],A,M,180);
	}

	if((leftright & KEY_RIGHT) == KEY_RIGHT)/*(leftright == KEY_RIGHT)*/{

    GetObjectRot(sub[i],A,M,D);
	SetObjectRot(sub[i],A,M,90);
	}

	if((leftright & KEY_LEFT) == KEY_LEFT){

    GetObjectRot(sub[i],A,M,D);
	SetObjectRot(sub[i],A,M,270);
	}
 	
 	
 	

 	if(keys==KEY_ANALOG_RIGHT){

    GetObjectPos(sub[i],X,Y,Z);
    if(Z < -3){
	MoveObject(sub[i],X,Y,Z+5,3);
	}
	}
	
	if(keys == 1024){
	SetTimer("explode",1,false); //reload
	SetTimer("explode2",1,false);
	KillTimer(timerexplot);
	KillTimer(timer3);
	fired[i]=NO;
	SendClientMessage(jugadores[i], 0x33CCFFAA, "Torpedoes Reloaded");
	}
	
	if(keys==KEY_ANALOG_LEFT){

    GetObjectPos(sub[i],X,Y,Z);
    if(Z > -45){
	MoveObject(sub[i],X,Y,Z-5,3);
	}
	}

	if( ((keys & KEY_FIRE) == KEY_FIRE) || ((keys & KEY_ACTION) == KEY_ACTION)){

	if(D==180){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X,Y+5,Z,11);
	}
	if(D==0){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X,Y-5,Z,11);
	}
	if(D==270){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X-5,Y,Z,11);
	}
	if(D==90){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X+5,Y,Z,11);
	}
	
	}


	if(keys == KEY_SPRINT){
	if(D==180){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X,Y-5,Z,0.5);
	}
	if(D==0){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X,Y+5,Z,0.5);
	}
	if(D==270){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X+5,Y,Z,0.5);
	}
	if(D==90){
	GetObjectPos(sub[i], X, Y, Z);
	MoveObject(sub[i],X-5,Y,Z,0.5);
	}
	}

	if(keys == KEY_JUMP){
	
	if(hundido[i]==NO){
    if(fired[i]==NO){
	new Float:b, Float:n, Float:m;
	new Float:F, Float:G, Float:H;
	GetObjectRot(sub[i], F, G, H);
    GetObjectPos(sub[i], b, n, m);
    SendClientMessage(jugadores[i], 0x33CCFFAA, "Torpedo Launched");
	fired[i]=YES;
	torpedo[GetPlayerSub(playerid)] = CreateObject(3790,b,n,m-3,F,G,H);
	owner[i] = torpedo[i];
	SetTimer("torpedotimer",1000,false);
	MoveObject(torpedo[i],b,n,m-15,7);
	}
	}
  	}


	if(keys == KEY_CROUCH){
    if(cameramode[i]==1 || cameramode[i]==2 || cameramode[i]==3){
    cameramode[i] = cameramode[i] + 1;
    SetTimer("camera",250,false);
    SetTimer("resetcam",250,false);
    timer1 = SetTimer("camera",10000,true);
    new dim[256];
    format(dim, sizeof(dim), "Camera mode: %i", cameramode[i]);
    SendClientMessage(playerid, 0xDEEE20FF, dim);
    }
    else{cameramode[i]=1;SetTimer("camera",2500,false); timer1 = SetTimer("camera",10000,true);}
	}
	}
	}
 	}


	if(stado == YES){

	new keys, updown, leftright;
	new Float:X, Float:Y, Float:Z;


	for(new maxporta=0; maxporta < porta[10]; maxporta++){


	GetPlayerKeys(jugador, keys, updown, leftright);
	if(updown == KEY_UP){

	GetObjectPos(porta[maxporta], X, Y, Z);
	MoveObject(porta[maxporta],X+5,Y,Z,3);

	}

	if(updown == KEY_DOWN){

	GetObjectPos(porta[maxporta], X, Y, Z);
	MoveObject(porta[maxporta],X-5,Y,Z,0.5);

	}
	}

	}
}
public OnPlayerCommandText(playerid, cmdtext[])
	{


	if(strcmp(cmdtext, "/sub", true) == 0) {

	ShowMenuForPlayer(subs,playerid);
	return 1;
	}
	
	if(strcmp(cmdtext, "/mysub", true) == 0) {
	new a;
	a = GetPlayerSub(playerid);
	switch(a){
	case 0:{
	SendClientMessage(playerid, 0x33CCFFAA, "USS JB");
	}
	case 1:{
    SendClientMessage(playerid, 0x33CCFFAA, "USS KOMMANDANT");
	}
	case 2:{
    SendClientMessage(playerid, 0x33CCFFAA, "USS NAUTILUS");
	}
	case 3:{
    SendClientMessage(playerid, 0x33CCFFAA, "SUB-ZERO");
	}
	case 4:{
    SendClientMessage(playerid, 0x33CCFFAA, "USS DESTROYER");
	}
	case 5:{
    SendClientMessage(playerid, 0x33CCFFAA, "Profound Mommy");
	}
	case 6:{
    SendClientMessage(playerid, 0x33CCFFAA, "Quiet Pupil");
	}

	default:{
	SendClientMessage(playerid, 0x33CCFFAA, "You don´t have a Sub");
	}
	//else{}
	}
	return 1;
	}
	



	if(strcmp(cmdtext, "/off", true) == 0) {
	
	for(new j=0;j<7;j++){
	if(jugadores[j] == playerid){
	if(driving[j] == YES){
	if(hundido[j]==NO){
	KillTimer(timer1);
	driving[j] = NO;
	new Float:x,Float:y,Float:z;
	GetObjectPos(sub[j],x,y,z);
	SetPlayerPos(j,x,y,z+6);
	SetCameraBehindPlayer(jugadores[j]);
	TogglePlayerControllable(jugadores[j],true);
	jugadores[j]=-1;
	return 1;
	}
	}
	}
	}
	}

	if(strcmp(cmdtext, "/camera2", true) == 0) {
	for(new i=0;i<7;i++){
	if(playerid==jugadores[i]){
	cameramode[i]=2;
	SetTimer("camera",250,false);
	return 1;
	}
	}
	}
	if(strcmp(cmdtext, "/camera1", true) == 0) {
	for(new i=0;i<7;i++){
	if(playerid==jugadores[i]){
	cameramode[i]=1;
	SetTimer("camera",250,false);
	return 1;
	}
	}
	}
	if(strcmp(cmdtext, "/camera3", true) == 0) {
	for(new i=0;i<7;i++){
	if(playerid==jugadores[i]){
	cameramode[i]=3;
	SetTimer("camera",250,false);
	return 1;
	}
	}
	}
	if(strcmp(cmdtext, "/camerastop", true) == 0) {
	for(new i=0;i<7;i++){
	if(playerid==jugadores[i]){
	cameramode[i]=-1;
	SetTimer("camera",250,false);
	return 1;
	}
	}
	}
	
	if(strcmp(cmdtext, "/manejar", true) == 0) {
	if(hundidocarrier==NO){
	if(jugador==-1){
	new Float:h,Float:j,Float:k;
	GetObjectPos(porta[3],h,j,k);
	SetPlayerCameraPos(playerid,h+30,j-30,k+100);
	SetPlayerCameraLookAt(playerid,h,j,k);
	SetTimer("OnPlayerKeyStateChange",10,true);
	TogglePlayerControllable(playerid,false);
	stado = YES;
	jugador = playerid;
	}else{SendClientMessage(playerid, 0x33CCFFAA, "The Carrier is ocuppied");}
	return 1;
	}
	}
	if(strcmp(cmdtext, "/rustler", true) == 0) {
	if(hundidocarrier==NO){
	PutPlayerInVehicle(playerid,rustler,0);

	return 1;
	}
	}
	if(strcmp(cmdtext, "/porta2", true) == 0) {
	if(hundidocarrier==NO){
	new Float:h,Float:j,Float:k;
	GetObjectPos(porta[3],h,j,k);
	SetPlayerPos(playerid,h+3,j,k);
	return 1;
	}
	}
	if(strcmp(cmdtext, "/manejaroff", true) == 0) {
	if(hundidocarrier==NO){
	stado = NO;
	TogglePlayerControllable(playerid,true);
	new Float:h,Float:j,Float:k;
	GetObjectPos(porta[3],h,j,k);
	SetPlayerPos(playerid,h+3,j,k);
	SetCameraBehindPlayer(playerid);
	jugador=-1;
	return 1;
	}
	}
	
	/*if(strcmp(cmdtext, "/back", true) == 0) {
	if(hundidocarrier==YES){
	new Float:X, Float:Y, Float:Z;
    new Float:A, Float:M, Float:D;
	stado = NO;
	for(new maxporta=0; maxporta < porta[10]; maxporta++){
    GetObjectPos(porta[3], X, Y, Z);
    GetObjectPos(porta[maxporta], A, M, D);
	SetObjectRot(porta[maxporta],0,0,0);
	MoveObject(porta[maxporta],A-7,M,D+72,1.5);
	SetTimer("getpos2",60000,false);
	}
	return 1;
	}
	}*/
	return 0;
}
//------------------------------------------------------------------------------

public AddVehicle(modelid,Float:spawn_x,Float:spawn_y,Float:spawn_z,Float:z_angle,color1,color2) {
	vehicleModel[AddStaticVehicle(modelid,spawn_x,spawn_y,spawn_z,z_angle,color1,color2)-1]=modelid;
	return 1;
}

public balancear(){
	new Float:A, Float:M, Float:D;

	for(new maxporta=0; maxporta < porta[7]; maxporta++){
	GetObjectRot(porta[maxporta],A,M,D);
	//GetObjectPos(porta[maxporta], X, Y, Z);
 	SetObjectRot(porta[maxporta],1,M,D);
	
	timer2 = SetTimer("volver",2000,false);
	}

}

public volver(){
new Float:A, Float:M, Float:D;
for(new maxporta=0; maxporta < porta[7]; maxporta++){
	GetObjectRot(porta[maxporta],A,M,D);
	//GetObjectPos(porta[maxporta], X, Y, Z);
	SetObjectRot(porta[maxporta],0,M,D);
	KillTimer(timer2);
	//	timer3 = SetTimer("golpear",2000,false);
	}

}

public getpos(){
   	GetObjectPos(porta[9],posaa,posbb,poscc);
    SetVehiclePos(rustler,posaa,posbb,poscc+3);
	return 1;
}

public OnVehicleSpawn(vehicleid){

if(vehicleid==rustler){
    SetTimer("getpos",1000,false);
}
return 1;
}
public getpos2(){
	hundidocarrier = NO;
	return 1;
}
public getpos3(){
	hundidocarrier = YES;
	return 1;
}


public camera(){
    for(new i=0; i<7;i++){
	for(new l=0; l<MAX_PLAYERS;l++){
	if(jugadores[i]==l){
	if(driving[i] == YES){
	new Float:h,Float:j,Float:k;
	GetObjectPos(sub[i],h,j,k);
	SetPlayerPos(jugadores[i],h,j,k-5);
	if(cameramode[i]==1){
	SetPlayerCameraPos(jugadores[i],h-33.2203,j-0.1037,k+1);
	SetPlayerCameraLookAt(jugadores[i],h,j,k+5);
	}
	if(cameramode[i]==2){
	SetPlayerCameraPos(jugadores[i],h+46.9784,j+7,k+1);
	SetPlayerCameraLookAt(jugadores[i],h+30,j,k);
	}
	if(cameramode[i]==3){
	SetPlayerCameraPos(jugadores[i],h+30,j-30,k);
	SetPlayerCameraLookAt(jugadores[i],h,j,k);

	}
	}
	}
	}
	}
}
public OnPlayerDisconnect(playerid){
	for(new i=0;i<7;i++){
	if(jugadores[i]==playerid){
	jugadores[i]=-1;
	driving[i]=-1;
	}
	}
	if(jugador==playerid){
	jugador=-1;
	}
	}


public torpedotimer(){
	
	for(new i=0;i<7;i++){
    new Float:E, Float:R, Float:T;
    new Float:x, Float:y, Float:z;
	if(IsValidObject(torpedo[i])){
   // StopObject(torpedo[i]);
    GetObjectPos(torpedo[i], x, y, z);
	GetObjectRot(sub[i], E, R, T);
	
	timerexplot = SetTimer("explode2",250,true);
	
	if(T==180){
	SetObjectRot(torpedo[i],0,0,T+90);
	MoveObject(torpedo[i],x,y+700,z,25);
	}
	if(T==0){
	SetObjectRot(torpedo[i],0,0,T+90);
	MoveObject(torpedo[i],x,y-700,z,25);
	}
	if(T==90){
	SetObjectRot(torpedo[i],0,0,T+90);
	MoveObject(torpedo[i],x+700,y,z,25);
	//SetObjectRot(torpedo,E,R,180);
	}
	if(T==270){
	SetObjectRot(torpedo[i],0,0,T+90);
	MoveObject(torpedo[i],x-700,y,z,25);
	//SetObjectRot(torpedo,E,R,0);
	}
	timer3 = SetTimer("explode",7000,false);
	}
	}
	}

public explode(){
	new Float:x, Float:y, Float:z;
	for(new i=0;i<7;i++){
	
	if(IsValidObject(torpedo[i])){
	fired[GetPlayerSub(jugadores[i])]=NO;
    GetObjectPos(torpedo[i], x, y, z);
    CreateExplosion(x,y,z,7,8000);
    DestroyObject(torpedo[i]);
    
    }
    }
}
public resetcam(){
    for(new i=0;i<7;i++){
    for(new dd=0;dd<MAX_PLAYERS;dd++){
	if(dd==jugadores[i]){
	if(cameramode[i]>=5){
	cameramode[i]=1;
	}
	}
	}
	}
}

public explode2(){


	//--NUEVO
	
    new dim[256];
	new Float:c,Float:v,Float:b;
	new Float:h,Float:u,Float:y;
	for(new i=0;i<7;i++){

	if(IsValidObject(torpedo[i])){//el jugador 3 lanza el torpedo 3, el torpedo[3] es valido
	
	for(new j=0;j<7;j++){
	if(IsValidObject(sub[j]) && j!=i){//el sub 4 es valido y es distinto que 3
	GetObjectPos(sub[j],c,v,b); //posiciones

	if(IsObjectInRectangle(torpedo[i],c-25,v-25,c+25,v+25,b-30,b+30)){
	//&& i!=GetPlayerSub(i)
//	if(i!=GetPlayerSub(i)){//problema
    fired[j]= NO;
    //SendClientMessageToAll(0xDEEE20FF, "le pego");
	//if(IsValidObject(sub[j])){
    if(hundido[j]==NO){
  	gangzones[j]=GangZoneShowForAll(GangZoneCreate(c-25,v-25,c+25,v+25),0xDEEE20FF);
  	/*new string[256];
  	format(string, sizeof(string), "i = %i j= %i", i,j);
    SendClientMessageToAll(0xDEEE20FF, string);*/
    //------
    GetObjectPos(sub[j],c,v,b);
    GetObjectPos(torpedo[i],h,u,y);
    fired[i]= NO;
    format(dim, sizeof(dim), "The ship %s was sunk at coords: X=%f Y=%f Z=%f", names[j],c,v,b);
    SendClientMessageToAll(0xDEEE20FF, dim);

	CreateExplosion(c,v,b,7,400);
	CreateExplosion(h,u,y,7,400);
	DestroyObject(sub[j]);
	hundido[j]=YES;
	DestroyObject(torpedo[i]);
	for(new p=0; p<MAX_PLAYERS;p++){
	if(p==jugadores[j]){
	TogglePlayerControllable(p,true);
	SetPlayerHealth(p,-1);
	SpawnPlayer(p);
	jugadores[j] = -100;
	KillTimer(timerexplot);
	}
	}
	
 }
 }
    }
	}
	}
	}

	
	

	//sink carrier
	for(new i=0;i<7;i++){
	new Float:x,Float:f,Float:z;
    new Float:U,Float:I,Float:O;
	if(IsValidObject(torpedo[i])){
	GetObjectPos(torpedo[i],x,f,z);
	GetObjectPos(porta[2],U,I,O);
	
	//if(IsObjectNearObject(torpedo[i],porta[3],20)){
    if(IsObjectInRectangle(torpedo[i],U-200,I-50,U+200,I+50,O-70,O+70)){
	if(hundidocarrier==NO){
	new Float:X, Float:Y, Float:Z;
    new Float:A, Float:M, Float:D;
	gangzones[7]=GangZoneShowForAll(GangZoneCreate(U-200,I-70,U+200,I+70),0xFF0000AA);
	SetPlayerHealth(jugador,-1);
	stado = NO;
	hundidocarrier= YES;
	GetObjectPos(torpedo[i], x, f, z);
    CreateExplosion(x,f,z,7,8000);
    DestroyObject(torpedo[i]);
	
	for(new maxporta=0; maxporta < porta[10]; maxporta++){
    GetObjectPos(porta[3], X, Y, Z);
    GetObjectPos(porta[maxporta], A, M, D);
	SetObjectRot(porta[maxporta],-1,0,0);
	MoveObject(porta[maxporta],A+7,M,D-72,1.5);
	CreateExplosion(X,Y,Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(19 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(22 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(27 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(24 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(23 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(23 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(5 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(9 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(13 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(45 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(17 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(22 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(4 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(6 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(5 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(13 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(11 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(12 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(23 * 2),Z,7,900);
	CreateExplosion(X+random(30 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X+random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(30 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(30 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(30 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(30 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);
	CreateExplosion(X-random(60 * 2),Y+random(15 * 2),Z,7,900);

	fired[i]=NO;
    
 }
    fired[i]=NO;
 	SetTimer("nuevo",3000,false);
	format(dim, sizeof(dim), "The carrier was sunk at coords: X=%f Y=%f Z=%f", X,Y,Z);
    SendClientMessageToAll(0xDEEE20FF, dim);
	}
	}

	}
	}

}

public nuevo(){
    KillTimer(timerexplot);
	}

public OnPlayerSelectedMenuRow(playerid, row)
	{

    new Menu:Current = GetPlayerMenu(playerid);
    
   	if(Current == subs)

	if(playerid!=jugadores[0] && playerid!=jugadores[1] && playerid!=jugadores[2] && playerid!=jugadores[3] && playerid!=jugadores[4] && playerid!=jugadores[5] && playerid!=jugadores[6]){
	switch(row)
	{
		//JB
	    case 0:{
	    if(jugadores[0]==-1){
	    if(hundido[0]==NO){
		new Float:h,Float:j,Float:k;
		GetObjectPos(sub[0],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[0] = YES;
		jugadores[0] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
		
	    }
	    //Kommandant
	    case 1:{
	    if(jugadores[1]==-1){
	    if(hundido[1]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[1],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[1] = YES;
		jugadores[1] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    
	    }
	    //NAUTILUS
	    case 2:{
	    if(jugadores[2]==-1){
	    if(hundido[2]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[2],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[2] = YES;
		jugadores[2] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    
	    }
     	//SUB-ZERO
	    case 3:{
	    if(jugadores[3]==-1){
	    if(hundido[3]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[3],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[3] = YES;
		jugadores[3] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    
	    }
     	//DESTROYER
	    case 4:{
	    if(jugadores[4]==-1){
	    if(hundido[4]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[4],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[4] = YES;
		jugadores[4] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    
	    }
	    //MUMMY
	    case 5:{
	    if(jugadores[5]==-1){
	    if(hundido[5]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[5],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[5] = YES;
		jugadores[5] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied or sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    
	    }
	    //PUPIL
	    case 6:{
	    if(jugadores[6]==-1){
	    if(hundido[6]==NO){
	    new Float:h,Float:j,Float:k;
		GetObjectPos(sub[6],h,j,k);
		timer1 = SetTimer("camera",250,false);
		timer1 = SetTimer("camera",10000,true);
		SetTimer("OnPlayerKeyStateChange",10,true);
		TogglePlayerControllable(playerid,false);
		driving[6] = YES;
		jugadores[6] = playerid;
	    }
	    else{SendClientMessage(playerid, 0xFF0000AA, "This Sub was sunk");}
	    }else{SendClientMessage(playerid, 0xFF0000AA, "This Sub is occupied");}
	    }
	    
	    
        }
		
        
		}else{SendClientMessage(playerid, 0xFF0000AA, "You Already have a Sub");}
		
        }

        


stock IsObjectInArea(objectid,Float:min_x,Float:min_y,Float:max_x,Float:max_y)
{
    new Float:X,Float:Y,Float:Z;
    GetObjectPos(objectid, X, Y, Z);
    if((X <= max_x && X >= min_x) && (Y <= max_y && Y >= min_y)) return 1;
    return 0;}
    
stock IsObjectInRectangle(objectid,Float:min_x,Float:min_y,Float:max_x,Float:max_y,Float:min_z,Float:max_z)
	{
    new Float:X,Float:Y,Float:Z;
    GetObjectPos(objectid, X, Y, Z);
    if((X <= max_x && X >= min_x) && (Y <= max_y && Y >= min_y) && (Z <= max_z && Z >= min_z)) return 1;
    return 0;}
    
    
stock IsObjectInLevel(objectid,Float:min_z,Float:max_z)
{
    new Float:X,Float:Y,Float:Z;
    GetObjectPos(objectid, X, Y, Z);
    if((Z <= max_z && X >= min_z)) return 1;
    return 0;}
    
stock GetPlayerSub(playerid)
{
    for(new i=0;i<7;i++){
	if(jugadores[i]==playerid){
    return i;
    }
    }
    return -2;
    }
    
stock GetSubOrTorpedo(playerid)
{
    for(new i=0;i<7;i++){
    
	if(jugadores[i]==playerid){
	
	if(driving[i]==YES){
    return i;
    }
    }
    }

    return -2;}
    
stock SetTorpedo(playerid)
{

    for(new i=0;i<7;i++){
	if(jugadores[i]==playerid){

	if(driving[i]==YES){
	torpedo[i]=i;
	
    return i;
    }
    }
    }
    return 0;}

public gangdestroy(){
	for(new i=0;i<8;i++){
	GangZoneDestroy(gangzones[i]);
	}
}
    
stock IsPlayerNearObject(playerid,objectid,radius)
	{
    new Float:X,Float:Y,Float:Z;
    new Float:A,Float:M,Float:D;
    GetObjectPos(objectid, X, Y, Z);
    GetPlayerPos(playerid,A,M,D);
    if((X <= A+radius && X >= A-radius) && (Y <= M+radius && Y >= M-radius) && (Z <= D+radius && X >= D-radius)) return 1;
    return 0;}
    
stock IsObjectNearObject(objectid1,objectid2,radius)
	{
    new Float:X,Float:Y,Float:Z;
    new Float:A,Float:M,Float:D;

    GetObjectPos(objectid1, X, Y, Z);
    
    GetObjectPos(objectid2,A,M,D);
    //GangZoneCreate(A-100,M-100,A+100,M+100);
    if((X <= A+radius && X >= A-radius) && (Y <= M+radius && Y >= M-radius) && (Z <= D+radius && X >= D-radius)) return 1;
    return 0;}

public get(){
	new keys,updown,leftright;
	new strin[256];
 	GetPlayerKeys(0,keys,updown,leftright);
 	
 	format(strin, sizeof(strin), "KEYS= %i UPDOWN= %i LEFTRIGHT= %i",keys,updown,leftright );
    SendClientMessageToAll(0x33CCFFAA, strin);
}

