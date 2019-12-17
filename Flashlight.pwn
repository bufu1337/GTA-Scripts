#include <zcmd>
//------------------------Flashlight by Redreaper666----------------------------
CMD:flashlight1(playerid)
{
if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
SetPlayerAttachedObject(playerid, 1,18656, 5, 0.1, 0.038, -0.1, -90, 180, 0, 0.03, 0.03, 0.03);
SetPlayerAttachedObject(playerid, 2,18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
return 1;
}
CMD:flashlight2(playerid)
{
if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
SetPlayerAttachedObject(playerid, 1,18656, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
SetPlayerAttachedObject(playerid, 2,18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
return 1;
}
CMD:flashlight3(playerid)
{
if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
SetPlayerAttachedObject(playerid, 1,18656, 6, 0.25, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.03, 0.03);//light18656
SetPlayerAttachedObject(playerid, 2,18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
return 1;
}
CMD:flashlight4(playerid)
{
if(IsPlayerAttachedObjectSlotUsed(playerid,1)) RemovePlayerAttachedObject(playerid,1);
if(IsPlayerAttachedObjectSlotUsed(playerid,2)) RemovePlayerAttachedObject(playerid,2);
SetPlayerAttachedObject(playerid, 1,18656, 6, 0.16, -0.0155, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);//light18656
SetPlayerAttachedObject(playerid, 2,18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
return 1;
}