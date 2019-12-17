/*******************************************************************************
////			////////////////////////////////////////////////            ////
\\\\			\\\\                               			\\\\            \\\\
////           	////    	   loggo player FS by Teddy     	    ////            ////
\\\\            \\\\                               			\\\\            \\\\
////            ////////////////////////////////////////////////            ////
\\\\            \\\\\\\\	     Version: 1.0       \\\\\\\\\\\\            \\\\
////            ////////  	Relese Date: 18/02/2013 ////////////            ////
\\\\            \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\            \\\\
////    Change Teddy and Network on SetObjectMaterialText [put your text]   \\\\
////            ////////////////////////////////////////////////            ////
\\\\            \\\\                                		\\\\            \\\\
////            //// You CAN edit this FS to you liking     ////            ////
\\\\            \\\\ You CANNOT clame this as your own  	\\\\            \\\\
////            //// You CANNOT re-release or post this on  ////            ////
\\\\            \\\\ 	other sites without my permission   \\\\            \\\\
////            ////////////////////////////////////////////////            ////
*******************************************************************************/
#define FILTERSCRIPT
#include <a_samp>
#define COLOR_RED 0xAA3333AA

new test1;
new test2;
public OnFilterScriptInit()
{
		return 1;
}
public OnFilterScriptExit()
{
		return 1;
}
public OnPlayerConnect(playerid)
{
	   return 1;
}
public OnPlayerDisconnect(playerid,reason)
{
	    DestroyObject(test1);
		DestroyObject(test2);
		return 1;
}
public OnPlayerCommandText(playerid, cmdtext[])
{
//=========================================================================================
	if(strcmp(cmdtext, "/putloggo", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
			test1 = CreateObject(19326,0,0,0,0,0,0);
			test2 = CreateObject(19326,0,0,0,0,0,0);
			SetObjectMaterialText(test1, "{6EF83C}(*•.¸{F81414})({6EF83C}¸.•*´)", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 15,1, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	        SetObjectMaterialText(test2, "{B700FF}•°.{F81414}Teddy{B700FF}.°•\n{6EF83C}(¸.•*´{F300FF}||{6EF83C}`*•.¸)", 0, OBJECT_MATERIAL_SIZE_256x128, "Gabriola", 28, 1, -16776961, 0,OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
			AttachObjectToPlayer(test1, playerid, 0.000000, -0.120000, 0.40000, 0.000000, 0.00000, 0.000000);
			AttachObjectToPlayer(test2,playerid, 0.000000, -0.125000, 0.100000, 0.00000, 0.00000, 0.00000);
		}
		return 1;
	}
	if(strcmp(cmdtext, "/deleteloggo", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
		    DestroyObject(test1);
			DestroyObject(test2);
		}
		return 1;
	}
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}
/*******************************************************************************
/////     	 			 ///// End Of File \\\\\						  \\\\\\
******************************************************************************/
