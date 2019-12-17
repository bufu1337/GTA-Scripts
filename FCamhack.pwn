#include <a_samp>

#define SPEED_ROTATE_LEFTRIGHT_SLOW 0.5
#define SPEED_ROTATE_LEFTRIGHT_FAST 2.0

#define SPEED_ROTATE_UPDOWN_SLOW 0.05
#define SPEED_ROTATE_UPDOWN_FAST 0.15

#define SPEED_MOVE_UPDOWN_SLOW 0.25
#define SPEED_MOVE_UPDOWN_FAST 1.0

#define SPEED_MOVE_FORWARDBACKWARD_SLOW 0.4
#define SPEED_MOVE_FORWARDBACKWARD_FAST 2.0

#define SPEED_MOVE_LEFTRIGHT_SLOW 0.4
#define SPEED_MOVE_LEFTRIGHT_FAST 2.0



#define ScriptVersion 2.0

//Cameradefines:
new Float:PCP[MAX_PLAYERS][3]; // PCP = PlayerCameraPosition
new Float:PCL[MAX_PLAYERS][3]; // PCL = PlayerCameraLookat
new Float:PCA[MAX_PLAYERS];    // PCA = PlayerCameraAngle

//Playerdefines:
new IsSpawned[MAX_PLAYERS];
new IsInCameraMode[MAX_PLAYERS];
new KeyTimer[MAX_PLAYERS];
new KeyState[MAX_PLAYERS];
new CameraLocked[MAX_PLAYERS];
new FollowOn[MAX_PLAYERS];

//V2:
new Float:SavedPCP[MAX_PLAYERS][3][3];
new Float:SavedPCL[MAX_PLAYERS][3][3];
new Float:SavedPCA[MAX_PLAYERS][3];
new SlotUsed[MAX_PLAYERS][3];

public OnFilterScriptInit()
{
	print("\n\n ----------------------------------------------------------");
	printf("|    Flying Camera Filterscript [V%.1f] by Sandra loaded!   |", ScriptVersion);
	print(" ----------------------------------------------------------\n\n");
	return 1;
}

public OnFilterScriptExit()
{

	return 1;
}

public OnPlayerConnect(playerid)
{
    IsSpawned[playerid] = 0;
    IsInCameraMode[playerid] = 0;
    KeyState[playerid] = 0;
    CameraLocked[playerid] = 0;
    FollowOn[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsInCameraMode[playerid] == 1)
	{
	    KillTimer(KeyTimer[playerid]);
		IsInCameraMode[playerid] = 0;
	}
	for(new i=1; i<4; i++)
	{
	    SavedPCP[playerid][i][0] = 0.0;
	    SavedPCP[playerid][i][1] = 0.0;
	    SavedPCP[playerid][i][2] = 0.0;
	    SavedPCL[playerid][i][0] = 0.0;
	    SavedPCL[playerid][i][1] = 0.0;
	    SavedPCL[playerid][i][2] = 0.0;
	    SavedPCA[playerid][i] = 0.0;
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
    IsSpawned[playerid] = 1;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    IsSpawned[playerid] = 0;
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new cmd[256], idx, tmp[256];
	cmd = strtok(cmdtext, idx);
	if (strcmp("/spawn", cmd, true) == 0)
	{
	    IsSpawned[playerid] = 1;
		return 1;
	}
    if (strcmp("/camerahelp", cmd, true) == 0)
	{
		SendClientMessage(playerid, 0xFA8072AA, "Flying Camera Help:");
		SendClientMessage(playerid, 0xFA8072AA, "*/fc*  Start Flying Camera Mode");
	    SendClientMessage(playerid, 0xFA8072AA, "*Arrow-keys*: Move camera forward/backward/left/right");
	    SendClientMessage(playerid, 0xFA8072AA, "*Walk-key + Arrow-keys*: *Move camera up/down");
	    SendClientMessage(playerid, 0xFA8072AA, "*Crouch-key + Arrow-keys*: *Rotate camera up/down/left/right");
	    SendClientMessage(playerid, 0xFA8072AA, "*Sprint-key*: Speeds up every movement");
	    SendClientMessage(playerid, 0xFA8072AA, "*/lock* Locks the camera and player is free to move.");
	    SendClientMessage(playerid, 0xFA8072AA, "*/follow* Locks the camera and keeps looking at player.");
	    SendClientMessage(playerid, 0xFA8072AA, "*/savecam [1-3]*  */loadcam [1-3]*");
	    return 1;
	}
	if (strcmp("/fc", cmd, true) == 0)
	{
	    if(IsSpawned[playerid] == 1)
	    {
			if(IsInCameraMode[playerid] == 0)
			{
			    TogglePlayerControllable(playerid, 0);
			    CameraLocked[playerid] = 0;
	            IsInCameraMode[playerid] = 1;
	            FollowOn[playerid] = 0;
	 			GetPlayerPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
	 			GetPlayerFacingAngle(playerid, PCA[playerid]);
	 			if(IsPlayerInAnyVehicle(playerid))
	 			{
					GetVehicleZAngle(GetPlayerVehicleID(playerid), PCA[playerid]);
				}
				PCL[playerid][0] = PCP[playerid][0];
				PCL[playerid][1] = PCP[playerid][1];
				PCL[playerid][2] = PCP[playerid][2];
				PCP[playerid][0] = PCP[playerid][0] - (5.0 * floatsin(-PCA[playerid], degrees));
				PCP[playerid][1] = PCP[playerid][1] - (5.0 * floatcos(-PCA[playerid], degrees));
				PCP[playerid][2] = PCP[playerid][2]+2.0;
				SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
				KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 70, 1, "i", playerid);
			}
			else
			{
			    TogglePlayerControllable(playerid, 1);
			    KillTimer(KeyTimer[playerid]);
				IsInCameraMode[playerid] = 0;
				SetCameraBehindPlayer(playerid);
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
		}
		return 1;
	}
	if (strcmp("/lock", cmd, true) == 0)
	{
	    if(IsSpawned[playerid] == 1)
	    {
			if(IsInCameraMode[playerid] == 1)
			{
			    if(FollowOn[playerid] == 0)
			    {
				    if(CameraLocked[playerid] == 0)
				    {
					    CameraLocked[playerid] = 1;
					    KillTimer(KeyTimer[playerid]);
					    TogglePlayerControllable(playerid, 1);
					    SendClientMessage(playerid, 0x00FF00AA, "Camera locked, player unlocked!");
					}
					else
					{
					    CameraLocked[playerid] = 0;
					    KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 70, 1, "i", playerid);
					    TogglePlayerControllable(playerid, 0);
					    SendClientMessage(playerid, 0x00FF00AA, "Camera unlocked, player locked!");
					}
				}
				else
				{
				    SendClientMessage(playerid, 0xFF0000AA, "Please turn the follow-mode off first! /follow");
				}
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
		}
		return 1;
	}
	
	if (strcmp("/follow", cmd, true) == 0)
	{
	    if(IsSpawned[playerid] == 1)
	    {
			if(IsInCameraMode[playerid] == 1)
			{
			    if(CameraLocked[playerid] == 0)
				{
				    if(FollowOn[playerid] == 0)
				    {
				        FollowOn[playerid] = 1;
					    TogglePlayerControllable(playerid, 1);
				        KillTimer(KeyTimer[playerid]);
					    KeyTimer[playerid] = SetTimerEx("FollowPlayer", 70, 1, "i", playerid);
					    SendClientMessage(playerid, 0x00FF00AA, "Following player toggled on!");
					}
					else
					{
				        FollowOn[playerid] = 0;
					    TogglePlayerControllable(playerid, 0);
					    KillTimer(KeyTimer[playerid]);
					    KeyTimer[playerid] = SetTimerEx("CheckKeyPress", 70, 1, "i", playerid);
					    SendClientMessage(playerid, 0x00FF00AA, "Following player toggled off!");
					}
				}
				else
				{
				    SendClientMessage(playerid, 0xFF0000AA, "Please unlock the camera first! /lock");
				}
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
		}
		return 1;
	}
	
	if (strcmp("/savecamtofile", cmd, true) == 0 || strcmp("/sctf", cmd, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
		    if(IsSpawned[playerid] == 1)
		    {
				if(IsInCameraMode[playerid] == 1)
				{
				    new str[128];
				    new File:file;
				    if (!fexist("SavedCameraPositions.txt"))
				    {
						file=fopen("SavedCameraPositions.txt",io_write);
						fclose(file);
					}
					file=fopen("SavedCameraPositions.txt",io_write);
					format(str, 128, "SetPlayerCameraPos(playerid, %.2f, %.2f, %.2f);", PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
 					fwrite(file,str);
					fwrite(file,"\r\n");
					format(str, 128, "SetPlayerCameraLookAt(playerid, %.2f, %.2f, %.2f);", PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
 					fwrite(file,str);
 					fwrite(file,"\r\n");
 					fwrite(file,"\r\n");
 					fclose(file);
 					SendClientMessage(playerid, 0x00FF00AA, "Cameraposition saved in SavedCameraPositions.txt!!");
				}
				else
				{
				    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
				}
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
			}
			return 1;
		}
	}
	if (strcmp("/saveclassselection", cmd, true) == 0 || strcmp("/scs", cmd, true) == 0)
	{
	    if(IsPlayerAdmin(playerid))
	    {
		    if(IsSpawned[playerid] == 1)
		    {
				if(IsInCameraMode[playerid] == 1)
				{
				    new str[128];
				    new File:file;
				    if (!fexist("SavedClassSelections.txt"))
				    {
						file=fopen("SavedClassSelections.txt",io_write);
						fclose(file);
					}
					file=fopen("SavedClassSelections.txt",io_write);
					new Float:X, Float:Y, Float:Z, Float:A, interior;
					GetPlayerPos(playerid, X, Y, Z);
					GetPlayerFacingAngle(playerid, A);
					interior = GetPlayerInterior(playerid);
					
					fwrite(file,"public OnPlayerRequestClass(playerid, classid)");
					fwrite(file,"\r\n");
					fwrite(file,"{");
					fwrite(file,"\r\n");
					
					format(str, 128, "    SetPlayerInterior(playerid, %d);", interior);
 					fwrite(file,str);
 					fwrite(file,"\r\n");
					
					format(str, 128, "    SetPlayerPos(playerid, %.2f, %.2f, %.2f);", X, Y, Z);
 					fwrite(file,str);
 					fwrite(file,"\r\n");
 					
 					format(str, 128, "    SetPlayerFacingAngle(playerid, %.2f);", A);
 					fwrite(file,str);
 					fwrite(file,"\r\n");
 					
					format(str, 128, "    SetPlayerCameraPos(playerid, %.2f, %.2f, %.2f);", PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
 					fwrite(file,str);
					fwrite(file,"\r\n");
					
					format(str, 128, "    SetPlayerCameraLookAt(playerid, %.2f, %.2f, %.2f);", PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
 					fwrite(file,str);
 					fwrite(file,"\r\n");
 					fwrite(file,"    return 1;");
					fwrite(file,"\r\n");
					fwrite(file,"}");
					fwrite(file,"\r\n");
 					fwrite(file,"\r\n");
 					fclose(file);
 					SendClientMessage(playerid, 0x00FF00AA, "ClassSelection-screen saved in SavedClassSelections.txt!!");
				}
				else
				{
				    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
				}
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
			}
			return 1;
		}
	}

	if (strcmp("/savecam", cmd, true) == 0)
	{
	    if(IsSpawned[playerid] == 1)
	    {
			if(IsInCameraMode[playerid] == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
				    SendClientMessage(playerid, 0xFF0000AA, "[Error] Use: /savecam [1-3]");
					return 1;
				}
				new slot = strval(tmp);
				if(slot < 1 || slot > 3)
				{
				    SendClientMessage(playerid, 0xFF0000AA, "[Error] Use: /savecam [1-3]");
					return 1;
				}
				new str[128];
				slot--;
				SavedPCP[playerid][slot][0] = PCP[playerid][0];
				SavedPCP[playerid][slot][1] = PCP[playerid][1];
				SavedPCP[playerid][slot][2] = PCP[playerid][2];
				SavedPCL[playerid][slot][0] = PCL[playerid][0];
				SavedPCL[playerid][slot][1] = PCL[playerid][1];
				SavedPCL[playerid][slot][2] = PCL[playerid][2];
				SavedPCA[playerid][slot] = PCA[playerid];
				SlotUsed[playerid][slot] = 1;
				slot++;
				format(str, 128, "CameraPosition saved into slot '%d'. Use \"/loadcam %d\" to go back to this cameraview", slot, slot);
				SendClientMessage(playerid, 0x00FF00AA, str);
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
		}
		return 1;
	}
	
	if (strcmp("/loadcam", cmd, true) == 0)
	{
	    if(IsSpawned[playerid] == 1)
	    {
			if(IsInCameraMode[playerid] == 1)
			{
				tmp = strtok(cmdtext, idx);
				if(!strlen(tmp))
				{
				    SendClientMessage(playerid, 0xFF0000AA, "[Error] Use: /loadcam [1-3]");
					return 1;
				}
				new slot = strval(tmp);
				if(slot < 1 || slot > 3)
				{
				    SendClientMessage(playerid, 0xFF0000AA, "[Error] Use: /loadcam [1-3]");
					return 1;
				}
				slot--;
				if(SlotUsed[playerid][slot] == 0)
				{
				    SendClientMessage(playerid, 0xFF0000AA, "[Error] This slot is empty!");
					return 1;
				}
 				PCP[playerid][0] = SavedPCP[playerid][slot][0];
				PCP[playerid][1] = SavedPCP[playerid][slot][1];
				PCP[playerid][2] = SavedPCP[playerid][slot][2];
				PCL[playerid][0] = SavedPCL[playerid][slot][0];
				PCL[playerid][1] = SavedPCL[playerid][slot][1];
				PCL[playerid][2] = SavedPCL[playerid][slot][2];
				PCA[playerid] = SavedPCA[playerid][slot];
				SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else
			{
			    SendClientMessage(playerid, 0xFF0000AA, "You're not in the Flying Camera Mode!");
			}
		}
		else
		{
		    SendClientMessage(playerid, 0xFF0000AA, "Please spawn first!");
		}
		return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys == KEY_CROUCH)
	{
	    KeyState[playerid] = 1;
	}
	else if(newkeys == KEY_SPRINT)
	{
	    KeyState[playerid] = 2;
	}
	else if(newkeys == (KEY_CROUCH+KEY_SPRINT))
	{
	    KeyState[playerid] = 3;
	}
	else if(newkeys == KEY_WALK)
	{
	    KeyState[playerid] = 4;
	}
	else if(newkeys == (KEY_WALK+KEY_SPRINT))
	{
	    KeyState[playerid] = 5;
	}
	else
	{
	    KeyState[playerid] = 0;
	}
	return 1;
}

forward CheckKeyPress(playerid);
public CheckKeyPress(playerid)
{
    new keys, updown, leftright;
    GetPlayerKeys(playerid, keys, updown, leftright);
    
    //==================================================
    //ROTATING CAMERA
    //==================================================
    if(KeyState[playerid] == 1 || KeyState[playerid] == 3)
    {
		if(leftright == KEY_RIGHT)
		{
		    if(KeyState[playerid] == 3)
		    {
		        PCA[playerid] = (PCA[playerid]-SPEED_ROTATE_LEFTRIGHT_FAST);
		    }
		    else
		    {
		    	PCA[playerid] = (PCA[playerid]-SPEED_ROTATE_LEFTRIGHT_SLOW);
			}
			if(PCA[playerid] <= 0)
			{
			    PCA[playerid] = (360-PCA[playerid]);
			}
			MovePlayerCamera(playerid);
		}
		if(leftright == KEY_LEFT)
		{
		    if(KeyState[playerid] == 3)
		    {
		        PCA[playerid] = (PCA[playerid]+SPEED_ROTATE_LEFTRIGHT_FAST);
		    }
		    else
		    {
		    	PCA[playerid] = (PCA[playerid]+SPEED_ROTATE_LEFTRIGHT_SLOW);
			}
			if(PCA[playerid] >= 360)
			{
			    PCA[playerid] = (PCA[playerid]-360);
			}
			MovePlayerCamera(playerid);
		}
		if(updown == KEY_UP)
		{
		    if(PCL[playerid][2] < (PCP[playerid][2]+5))
		    {
				if(KeyState[playerid] == 3)
				{
				    PCL[playerid][2] = PCL[playerid][2]+SPEED_ROTATE_UPDOWN_FAST;
				}
				else
				{
				    PCL[playerid][2] = PCL[playerid][2]+SPEED_ROTATE_UPDOWN_SLOW;
				}
			}
			MovePlayerCamera(playerid);
		}
		if(updown == KEY_DOWN)
		{
		    if(PCL[playerid][2] > (PCP[playerid][2]-5))
		    {
				if(KeyState[playerid] == 3)
				{
				    PCL[playerid][2] = PCL[playerid][2]-SPEED_ROTATE_UPDOWN_FAST;
				}
				else
				{
				    PCL[playerid][2] = PCL[playerid][2]-SPEED_ROTATE_UPDOWN_SLOW;
				}
			}
			MovePlayerCamera(playerid);
		}
	}
	
	//==================================================
    //MOVING CAMERA UP/DOWN
    //==================================================
	if(KeyState[playerid] == 4 || KeyState[playerid] == 5)
	{
		if(updown == KEY_UP)
		{
		    if(KeyState[playerid] == 4)  //Slow Up
		    {
		        PCP[playerid][2] = (PCP[playerid][2]+SPEED_MOVE_UPDOWN_SLOW);
		        PCL[playerid][2] = (PCL[playerid][2]+SPEED_MOVE_UPDOWN_SLOW);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else if(KeyState[playerid] == 5)  //Fast Up
		    {
		        PCP[playerid][2] = (PCP[playerid][2]+SPEED_MOVE_UPDOWN_FAST);
		        PCL[playerid][2] = (PCL[playerid][2]+SPEED_MOVE_UPDOWN_FAST);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
		if(updown == KEY_DOWN)
		{
		    if(KeyState[playerid] == 4)  //Slow Down
		    {
		        PCP[playerid][2] = (PCP[playerid][2]-SPEED_MOVE_UPDOWN_SLOW);
		        PCL[playerid][2] = (PCL[playerid][2]-SPEED_MOVE_UPDOWN_SLOW);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else if(KeyState[playerid] == 5)  //Fast Down
		    {
		        PCP[playerid][2] = (PCP[playerid][2]-SPEED_MOVE_UPDOWN_FAST);
		        PCL[playerid][2] = (PCL[playerid][2]-SPEED_MOVE_UPDOWN_FAST);
                SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
	}
		        
	
	
	//==================================================
    //MOVING CAMERA
    //==================================================
	else if(KeyState[playerid] == 2 || KeyState[playerid] == 0)
	{
	    if(leftright == KEY_RIGHT)
		{
            new Float:Angle;
			Angle = PCA[playerid];
			Angle -= 90.0;
		    if(KeyState[playerid] == 2)
			{
		        
		        PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
		    }
		    else
			{
		    	PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
			}
			SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
			SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
		}
		if(leftright == KEY_LEFT)
		{
		    new Float:Angle;
			Angle = PCA[playerid];
			Angle += 90.0;
		    if(KeyState[playerid] == 2)
			{
		        PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_FAST);
		    }
		    else
			{
		    	PCP[playerid][0] = PCP[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCP[playerid][1] = PCP[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][0] = PCL[playerid][0] + floatmul(floatsin(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
				PCL[playerid][1] = PCL[playerid][1] + floatmul(floatcos(-Angle, degrees), SPEED_MOVE_LEFTRIGHT_SLOW);
			}
			SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
			SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
		}
		
		if(updown == KEY_UP)
		{
		    new Float:X, Float:Y, Float:Z;
      		if(KeyState[playerid] == 2)
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], SPEED_MOVE_FORWARDBACKWARD_FAST, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
				X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], SPEED_MOVE_FORWARDBACKWARD_SLOW, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
				X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}

		if(updown == KEY_DOWN)
		{
		    new Float:X, Float:Y, Float:Z;
			if(KeyState[playerid] == 2)
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], -SPEED_MOVE_FORWARDBACKWARD_FAST, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
			    X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
			else
			{
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], -SPEED_MOVE_FORWARDBACKWARD_SLOW, X, Y, Z);
			    PCP[playerid][0] = X;
			    PCP[playerid][1] = Y;
			    PCP[playerid][2] = Z;
			    X = 0.0; Y=0.0; Z=0.0;
			    GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PCL[playerid][0], PCL[playerid][1], PCL[playerid][2], 5.0, X, Y, Z);
			    PCL[playerid][0] = X;
			    PCL[playerid][1] = Y;
			    PCL[playerid][2] = Z;
			    SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
				SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
			}
		}
	}
}

stock MovePlayerCamera(playerid)
{
	PCL[playerid][0] = PCP[playerid][0] + (floatmul(5.0, floatsin(-PCA[playerid], degrees)));
	PCL[playerid][1] = PCP[playerid][1] + (floatmul(5.0, floatcos(-PCA[playerid], degrees)));
	SetPlayerCameraPos(playerid, PCP[playerid][0], PCP[playerid][1], PCP[playerid][2]);
	SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
}

GetCoordsOnLine3D(Float:startX, Float:startY, Float:startZ, Float:endX, Float:endY, Float:endZ, Float:length, &Float:RX, &Float:RY, &Float:RZ) //Original function by Nubotron. Slightly edited by me.
{
    RX = startX - endX;
    RY = startY - endY;
    RZ = startZ - endZ;
    new Float:sqrt = floatsqroot((RX * RX) + (RY * RY) + (RZ * RZ));
    if (sqrt < 0.01)
        sqrt = 0.01;
    RX = -length * (RX / sqrt) + startX;
    RY = -length * (RY / sqrt) + startY;
    RZ = -length * (RZ / sqrt) + startZ;
}

stock Float:GetAngle(playerid, Float:x, Float:y)  //Original function by Fallout. Edited by me.
{
	new Float: Pa;
	Pa = floatabs(atan((y-PCP[playerid][1])/(x-PCP[playerid][0])));
	if (x <= PCP[playerid][0] && y >= PCP[playerid][1]) Pa = floatsub(180, Pa);
	else if (x < PCP[playerid][0] && y < PCP[playerid][1]) Pa = floatadd(Pa, 180);
	else if (x >= PCP[playerid][0] && y <= PCP[playerid][1]) Pa = floatsub(360.0, Pa);
	Pa = floatsub(Pa, 90.0);
	if (Pa >= 360.0) Pa = floatsub(Pa, 360.0);
	return Pa;
}


forward FollowPlayer(playerid);
public FollowPlayer(playerid)
{
	new Float:PX, Float:PY, Float:PZ;
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, PX, PY, PZ);
	GetCoordsOnLine3D(PCP[playerid][0], PCP[playerid][1], PCP[playerid][2], PX, PY, PZ, 5.0, X, Y, Z);
	PCL[playerid][0] = X;
    PCL[playerid][1] = Y;
    PCL[playerid][2] = Z;
    PCA[playerid] = GetAngle(playerid, PX, PY);
	SetPlayerCameraLookAt(playerid, PCL[playerid][0], PCL[playerid][1], PCL[playerid][2]);
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}
	new offset = index, result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
