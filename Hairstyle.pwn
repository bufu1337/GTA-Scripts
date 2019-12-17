/* Ulric Hair System by Xaviour212
	Now you can change your skin hair.
	Sorry if the hair is not solid because it used the coordinates of the head of Carl Johnson. */
#include <a_samp>
#include <sscanf>
#define blue 		0x00C2ECFF
#define green 0x45E01FFF
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
public OnFilterScriptInit(){
	print("\n==========================================");
	print(" Ulric Hair System by Xaviour212.");
	print("==========================================\n");
	return 1;
}
public OnPlayerCommandText(playerid, cmdtext[]){
	dcmd(hairhelp,8,cmdtext);
	dcmd(hair,4,cmdtext);
	dcmd(default,7,cmdtext);
	return 0;
}
dcmd_hairhelp(playerid, params[]){
    SendClientMessage(playerid, blue, "Ulric Hair System by Xaviour212/Dimas_Rizward");
    SendClientMessage(playerid, green, "Use /hair to change a your character hair. ");
    SendClientMessage(playerid, green, "Use /default to use default hair.");
    SendClientMessage(playerid, green, "You must in barber to change your hair.");
    return 1;
}
dcmd_hair(playerid, params[]){
    new hair;
    if(IsPlayerInRangeOfPoint(playerid, 20, 421.4878, -78.2720, 1001.8047))     {
	    if(sscanf(params,"i", hair))return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]Usage: /hair [1 - 5]");
	    if(hair > 5)return SendClientMessage(playerid,0xFF0000AA,"Only 5 available Hair.");
	    if(hair == 1)    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 18640, 2, 0.081841, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "You character hair now is Afro");
	        GivePlayerMoney(playerid, -200);
	    }
	    if(hair == 2)	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 18975, 2, 0.128191, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "You character hair now is Afro 2");
	        GivePlayerMoney(playerid, -210);
	    }
	    if(hair == 3)	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19077, 2, 0.124588, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "You character hair now is Police Hair");
	        GivePlayerMoney(playerid, -250);
	    }
	    if(hair == 4)	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19136, 2, 0.141113, 0.006911, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "You character hair now is Rockstar Hair");
	        GivePlayerMoney(playerid, -350);
	    }
	    if(hair == 5)	    {
	        if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
			SetPlayerAttachedObject( playerid, 3, 19274, 2, 0.099879, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000 );
	        SendClientMessage(playerid,green, "You character hair now is Clown Hair");
	        GivePlayerMoney(playerid, -150);
	    }
	}
 	return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]You must in barber to use this command");
}
dcmd_default(playerid, params[]){
    if(IsPlayerInRangeOfPoint(playerid, 20, 421.4878, -78.2720, 1001.8047)) return SendClientMessage(playerid, 0xFF0000AA, "[ERROR]You must in barber to use this command");
    if(IsPlayerAttachedObjectSlotUsed(playerid,3)) RemovePlayerAttachedObject(playerid,3);
    SendClientMessage(playerid, green, "You use a default hair.");
    GivePlayerMoney(playerid, -50);
    return 1;
}