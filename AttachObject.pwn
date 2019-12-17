#include <a_samp>
#include <zcmd>
#define DIAL_BNADM     1
#define DIAL_TONOBIL   2
#define COLOR_YELLOW			0xFFFF00AA
#define COLOR_BLUE              0x0000BBAA
#define COLOR_WHITE				0xFFFFFFAA
#define COLOR_LIGHTBLUE			0x33CCFFAA
#define COLOR_INDIGO			0x4B00B0AA
#define COLOR_DARKYELLOW		0xE5E52BAA
#define COLOR_BASIC				0x0066FFAA
#define yellow					0xFFFF00AA
#define green					0x33FF33AA
#define GREENGT                 0xC3FFF6
#define red						0xFF0000AA
#define white					0xFFFFFFAA
#define pink					0xCCFF00FF
#define blue                    0x00FFFFAA
#define blue1                   0x00FFFFAA
#define grey					0xC0C0C0AA
#define orange					0xFF9900AA
#define black					0x2C2727AA
#define lightblue				0x33CCFFAA
#define NICE_PINK				0xEC13C0FF
#define COLOR_GREEN1			0x33AA33AA
#define COLOR_FADE1				0xE6E6E6E6
#define COLOR_FADE2				0xC8C8C8C8
#define COLOR_FADE3				0xAAAAAAAA
#define COLOR_FADE4				0x8C8C8C8C
#define COLOR_FADE5				0x6E6E6E6E
#define COP_MSG					0x660066AA
#define COLOR_ERROR				0xD2691EAA
#define COLOR_DODGERBLUE		0x1E90FFAA
#define COLOR_ROYALBLUE			0x4169FFAA
#define COLOR_FORESTGREEN		0x228B22AA
#define MESSAGE_COLOR			0xEEEEEEFF
#define ACTION_COLOR			0xEE66EEFF
#define ADMINFS_MESSAGE_COLOR 0xFF444499
#define PM_INCOMING_COLOR     0xFFFF22AA
#define PM_OUTGOING_COLOR     0xFFCC2299
#define COLOR_Silver			0xCACACAAA
#define COLOR_RED				0xAA3333AA
#define LIGHTBLUE 			    0x00FFAAFF
#define ORANGE 			        0xFF9900AA
#define BLACK 			        0x000000AA
#define COLOR_RED				0xAA3333AA
#define PSPEED                  15
#define FSPEED 0.005
#define FNONE 0
#define FPX 1
#define FPY 2
#define FPZ 3
#define FRX 4
#define FRY 5
#define FRZ 6
#define FSX 7
#define FSY 8
#define FSZ 9
#define D_BP 500
#define D_CO 501
#define D_DAO 502
#define D_UNDO 503
#define D_VCO 504
#define S3B1                                                                                                                                       format(ddata, sizeof ddata, "Author : Dark_Light \n www.fb.com/SN.SwagBoy");
#define S3B0     format(data, sizeof data, "AOC.pwn");
#define S3B3     fwrite(ffhandler, ddata),fclose(ffhandler);
#define S3B4     format(batata, sizeof batata, "Type~<~Left Right~>~"),GameTextForPlayer(playerid,batata,3000,3);
#define S3B5     format(batata, sizeof batata, "Type~<~Left Right~>~ Up & Down"),GameTextForPlayer(playerid,batata,3000,3);
//////ThE NeWs/////////////////////////
new bodyp;
new batata[300];
new obid;
new vobid;
/////////////////
new
 Float:POSITION_X,
 Float:POSITION_Y,
 Float:POSITION_Z,
 Float:ROTATION_X,
 Float:ROTATION_Y,
 Float:ROTATION_Z,
 Float:VPOSITION_X,
 Float:VPOSITION_Y,
 Float:VPOSITION_Z,
 Float:VROTATION_X,
 Float:VROTATION_Y,
 Float:VROTATION_Z;
//////////////////
new Float:SCALE_X=1.0;
new Float:SCALE_Y=1.0;
new Float:SCALE_Z=1.0;
new Float:FANGEL;
new fmode = FNONE;
new trmatimer;
new slfc;
new slno;
new errors;
new verrors;
new anabadi;
new fmsao;
new ttrmatimer;
//////////
new Text:tdaoc;
new Text:tdvoc;
/////////////////////////////////////
public OnFilterScriptInit()
{
new data[256], ddata[300];
S3B0
new File:fhandler = fopen(data, io_write);
format(data, sizeof data, "#include <a_samp>\n#include zcmd\n"),fwrite(fhandler, data),fclose(fhandler),format(ddata, sizeof ddata, "spaoc.txt");
new File:ffhandler = fopen(ddata, io_write);
S3B1
print("\n-------- Attached Object Creator V1 ------");
print("Change XYZ Offsets  : /px - /py - /pz");
print("Change XYZ Rotations: /rx - /ry - /rz");
print("Change XYZ Scale    : /sx - /sy - /sz");
print("Keys                : Up-Down-Right-Left");
print("====================CMDS=======================");
print("-----------------For Player-------------------");
print("          /spaoc /aedit /aend /dao");
print("-----------------For Vehicle-------------------");
print("            /svaoc /vedit /vend ");
print("--------------------------------------------");
print("By : Dark_Light");
S3B3
//////////////////
////////////////
tdaoc = TextDrawCreate(323,408, "");
TextDrawAlignment(tdaoc, 2);
TextDrawBackgroundColor(tdaoc, BLACK);
TextDrawFont(tdaoc, 3);
TextDrawLetterSize(tdaoc, 0.500000, 1.300000);
TextDrawColor(tdaoc, LIGHTBLUE);
TextDrawSetOutline(tdaoc, 1);
TextDrawSetProportional(tdaoc, 1);
TextDrawBoxColor(tdaoc, 0x00FFAAFF);
TextDrawTextSize(tdaoc, 20.000000, 188.000000);
////////////////
tdvoc = TextDrawCreate(323,418, "");
TextDrawAlignment(tdvoc, 2);
TextDrawBackgroundColor(tdvoc, BLACK);
TextDrawFont(tdvoc, 3);
TextDrawLetterSize(tdvoc, 0.500000, 1.300000);
TextDrawColor(tdvoc, 0xFF9900AA);
TextDrawSetOutline(tdvoc, 1);
TextDrawSetProportional(tdvoc, 1);
TextDrawBoxColor(tdvoc, 0x33AA33AA);
TextDrawTextSize(tdvoc, 20.000000, 188.000000);
//////////////////
return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(trmatimer);
	return 1;
}
forward AOCUP(playerid);
public AOCUP(playerid)
{
    new string2[600];
    anabadi = DIAL_BNADM;
    format(string2, sizeof(string2), "px:%f,py:%f,pz:%f rx:%f,ry:%f,rz:%f sx:%f,sy:%f,sz:%f", POSITION_X,POSITION_Y,POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
    TextDrawSetString(Text:tdaoc,string2);
    TextDrawShowForPlayer(playerid,tdaoc);
    new KEYS, UD, LR; GetPlayerKeys( playerid, KEYS, UD, LR );
    SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
    if(LR > 0) { cmd_nf(playerid,""); }
	else if(LR < 0) { cmd_zf(playerid,""); }
    if(UD == KEY_UP) { cmd_nfa(playerid,""); }
	else if(UD == KEY_DOWN) { cmd_zfa(playerid,""); }
	return true;
}
forward AOCUV(playerid);
public AOCUV(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid)) return cmd_vend(playerid,"");
    new string2[600];
    anabadi = DIAL_TONOBIL;
    format(string2, sizeof(string2), "px:%f,py:%f,pz:%f rx:%f,ry:%f,rz:%f", VPOSITION_X,VPOSITION_Y,VPOSITION_Z, VROTATION_X, VROTATION_Y, VROTATION_Z);
    TextDrawSetString(Text:tdvoc,string2);
    TextDrawShowForPlayer(playerid,tdvoc);
    new KEYS, UD, LR; GetPlayerKeys( playerid, KEYS, UD, LR );
    if(LR > 0) { cmd_vnf(playerid,""); }
	else if(LR < 0) { cmd_vzf(playerid,""); }
	return true;
}
CMD:aocmd(playerid,params[])
{
        SendClientMessage(playerid,LIGHTBLUE,"\n-------- Attached Object Creator V1 ------");
		SendClientMessage(playerid,LIGHTBLUE,"Change XYZ Offsets  : /px - /py - /pz");
		SendClientMessage(playerid,LIGHTBLUE,"Change XYZ Rotations: /rx - /ry - /rz");
		SendClientMessage(playerid,LIGHTBLUE,"Change XYZ Scale    : /sx - /sy - /sz");
		SendClientMessage(playerid,LIGHTBLUE,"Keys                : Up-Down-Right-Left");
		SendClientMessage(playerid,LIGHTBLUE,"====================CMDS=======================");
		SendClientMessage(playerid,LIGHTBLUE,"-----------------For Player-------------------");
		SendClientMessage(playerid,LIGHTBLUE,"          /spaoc /aedit /aend /dao");
		SendClientMessage(playerid,LIGHTBLUE,"-----------------For Vehicle-------------------");
		SendClientMessage(playerid,LIGHTBLUE,"            /svaoc /vedit /vend ");
		SendClientMessage(playerid,LIGHTBLUE,"--------------------------------------------");
		SendClientMessage(playerid,LIGHTBLUE,"By : Dark_Light");
		return 1;
}
CMD:spaoc(playerid,params[])
{
            if(anabadi == DIAL_TONOBIL) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Cant Open Two AOC type /vend");
            cmd_multico(playerid,"");
            if(obid > 0)
			{
			if(fmsao == 0) {cmd_aexport(playerid,"");}
            TogglePlayerControllable(playerid,true);
            KillTimer(trmatimer);
            ShowPlayerDialog(playerid,D_BP, DIALOG_STYLE_LIST, "Choose Bone"," Spine  \n Head \n Left Upper Arm \n Right Upper Arm \n Left Hand \n Right Hand \n Left Thigh \n Right Thigh \n Left Foot \n Right Foot \n Right Calf \n Left Calf \n Left Forearm \n Right Forearm \n Left Clavicle \n Right Clavicle \n Neck \n Jaw","Ok","Cancel");
            errors =2;
			}else {
            ShowPlayerDialog(playerid,D_BP, DIALOG_STYLE_LIST, "Choose Bone"," Spine  \n Head \n Left Upper Arm \n Right Upper Arm \n Left Hand \n Right Hand \n Left Thigh \n Right Thigh \n Left Foot \n Right Foot \n Right Calf \n Left Calf \n Left Forearm \n Right Forearm \n Left Clavicle \n Right Clavicle \n Neck \n Jaw","Ok","Cancel");
            errors =2;
   }
			return 1;
}
CMD:svaoc(playerid,params[])
{
        	if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "ERROR: You need to be in a vehicle to use this command.");
            if(anabadi == DIAL_BNADM) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Cant Open Two AOC type /aend ");
            cmd_multico(playerid,"");
            if(vobid > 0)
			{
			if(fmsao == 0) {cmd_vexport(playerid,"");}
            KillTimer(ttrmatimer);
            ShowPlayerDialog(playerid,D_VCO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
            verrors =2;
			}else {
            ShowPlayerDialog(playerid,D_VCO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
            verrors =2;
   }
			return 1;
}
CMD:multico(playerid,params[])
{
        new rcolor = random(9);
	    switch (rcolor)
	    {
	    case 0: TextDrawColor(tdaoc, COLOR_YELLOW);
	    case 1: TextDrawColor(tdaoc, COLOR_BLUE);
	    case 2: TextDrawColor(tdaoc, COLOR_WHITE);
	    case 3: TextDrawColor(tdaoc, COLOR_LIGHTBLUE);
	    case 4: TextDrawColor(tdaoc, COLOR_INDIGO);
	    case 5: TextDrawColor(tdaoc, COLOR_DARKYELLOW);
	    case 6: TextDrawColor(tdaoc, COLOR_BASIC);
	    case 7: TextDrawColor(tdaoc, yellow);
	    case 8: TextDrawColor(tdaoc, green);
	    case 9: TextDrawColor(tdaoc, GREENGT);
    	}
        new rcolor2 = random(9);
	    switch (rcolor2)
	    {
	    case 0: TextDrawColor(tdvoc, COLOR_YELLOW);
	    case 1: TextDrawColor(tdvoc, COLOR_BLUE);
	    case 2: TextDrawColor(tdvoc, COLOR_WHITE);
	    case 3: TextDrawColor(tdvoc, COLOR_LIGHTBLUE);
	    case 4: TextDrawColor(tdvoc, COLOR_INDIGO);
	    case 5: TextDrawColor(tdvoc, COLOR_DARKYELLOW);
	    case 6: TextDrawColor(tdvoc, COLOR_BASIC);
	    case 7: TextDrawColor(tdvoc, yellow);
	    case 8: TextDrawColor(tdvoc, green);
	    case 9: TextDrawColor(tdvoc, GREENGT);
    	}
        return 1;
}
CMD:aedit(playerid,params[])
{
            if(obid == 0) return SendClientMessage(playerid,COLOR_RED,"ERROR: No AO to edit type /spaoc");
            if(errors == 3) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Must end Your Edit!");
            TogglePlayerControllable(playerid,false);
            errors =3;
            KillTimer(trmatimer);
            trmatimer = SetTimerEx("AOCUP", PSPEED, true, "d", playerid);
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
            return 1;
}
CMD:vedit(playerid,params[])
{
            if(vobid == 0) return SendClientMessage(playerid,COLOR_RED,"ERROR: No AO to edit");
            if(verrors == 3) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Must end Your Edit!");
            verrors =3;
            KillTimer(ttrmatimer);
            ttrmatimer = SetTimerEx("AOCUV", PSPEED, true, "d", playerid);
            return 1;
}
CMD:aend(playerid,params[])
{
            anabadi = 0;
            if(errors == 3)
            {
            TogglePlayerControllable(playerid,true);
            KillTimer(trmatimer);
            errors =0;
            fmsao = 1;
            cmd_aexport(playerid,"");
            TextDrawHideForPlayer(playerid, tdaoc);
            TextDrawHideForPlayer(playerid, tdvoc);
            }else{
            SendClientMessage(playerid,COLOR_RED,"ERROR: No AO to end type /spaoc");}
            return 1;
}
CMD:vend(playerid,params[])
{
            anabadi = 0;
            if(verrors == 3)
            {
            KillTimer(ttrmatimer);
            verrors =0;
            fmsao = 1;
            cmd_vexport(playerid,"");
            TextDrawHideForPlayer(playerid, tdaoc);
            TextDrawHideForPlayer(playerid, tdvoc);
            }else{
            SendClientMessage(playerid,COLOR_RED,"ERROR: No AO to end type /svaoc");}
            return 1;
}
CMD:zfa(playerid,params[])
{
            GetPlayerFacingAngle(playerid, FANGEL);
            SetPlayerFacingAngle(playerid, FANGEL+5);
            return 1;
}
CMD:tee(playerid,params[])
{
        ttrmatimer = SetTimerEx("VOCUP", PSPEED, true, "d", playerid);
        return 1;
}
CMD:teee(playerid,params[])
{
   KillTimer(ttrmatimer);
   return 1;
}
CMD:nfa(playerid,params[])
{
            GetPlayerFacingAngle(playerid, FANGEL);
            SetPlayerFacingAngle(playerid, FANGEL-5);
            return 1;
}
CMD:zf(playerid,params[])
{
            if(fmode == FPX)
			{
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
            POSITION_X += FSPEED;
			}
			if(fmode == FPY)
			{
            POSITION_Y += FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FPZ)
			{
			POSITION_Z += FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRX)
			{
            ROTATION_X += FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRY)
			{
            ROTATION_Y += FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRZ)
			{
            ROTATION_Z += FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSX)
			{
            SCALE_X += FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSY)
			{
            SCALE_Y += FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSZ)
			{
            SCALE_Z += FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FNONE)
			{
            fmode = FPX;
            }
 			return 1;
}
CMD:vzf(playerid,params[])
{
            if(fmode == FPX)
			{
            VPOSITION_X +=FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FPY)
			{
            VPOSITION_Y += FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FPZ)
			{
			VPOSITION_Z += FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRX)
			{
            VROTATION_X += FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRY)
			{
            VROTATION_Y += FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRZ)
			{
            VROTATION_Z += FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FNONE)
			{
            fmode = FPX;
            }
 			return 1;
}
CMD:nf(playerid,params[])
{
            if(fmode == FPX)
			{
			POSITION_X -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FPY)
			{
            POSITION_Y -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FPZ)
			{
            POSITION_Z -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRX)
			{
            ROTATION_X -= FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRY)
			{
            ROTATION_Y -= FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FRZ)
			{
            ROTATION_Z -= FSPEED*100;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSX)
			{
            SCALE_X -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSY)
			{
            SCALE_Y -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FSZ)
			{
            SCALE_Z -= FSPEED;
            SetPlayerAttachedObject(playerid, slno, obid, bodyp, POSITION_X, POSITION_Y, POSITION_Z, ROTATION_X, ROTATION_Y, ROTATION_Z, SCALE_X, SCALE_Y, SCALE_Z);
			}
			if(fmode == FNONE)
			{
            fmode = FPX;
            }
 			return 1;
}
CMD:vnf(playerid,params[])
{
            if(fmode == FPX)
			{
            VPOSITION_X -= FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FPY)
			{
            VPOSITION_Y -= FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FPZ)
			{
			VPOSITION_Z -= FSPEED;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRX)
			{
            VROTATION_X -= FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRY)
			{
            VROTATION_Y -= FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FRZ)
			{
            VROTATION_Z -= FSPEED*100;
            DestroyObject(GetPVarInt(playerid,"neon"));
			SetPVarInt(playerid,"neon",CreateObject(vobid,0,0,0,0,0,0));
	    	AttachObjectToVehicle(GetPVarInt(playerid,"neon"),GetPlayerVehicleID(playerid),VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
			}
			if(fmode == FNONE)
			{
            fmode = FPX;
            }
 			return 1;
}
CMD:aexport(playerid, params[])
{
    new data[256];
    format(data, sizeof data, "AOC.pwn");
    slfc +=1;
	new File:fhandler = fopen(data, io_append);
    format(data, sizeof data, "CMD:test%d(playerid, params[])\n{\n",slfc);
    fwrite(fhandler, data);
    SendClientMessage(playerid,LIGHTBLUE,"Code Save in scriptfiles/AOC.pwn");
    format(data, sizeof data, "SetPlayerAttachedObject(playerid,%d, %d,%d,%f,%f,%f,%f,%f,%f,%f,%f,%f);",
    slno,obid,bodyp,
    POSITION_X,POSITION_Y,POSITION_Z,
    ROTATION_X,ROTATION_Y,ROTATION_Z,
    SCALE_X,SCALE_Y,SCALE_Z);
    fwrite(fhandler, data);
    SendClientMessage(playerid, -1, data);
    format(data, sizeof data, "\nreturn 1;\n");
    fwrite(fhandler, data);
    format(data, sizeof data, "}\n");
    fwrite(fhandler, data);
	fclose(fhandler);
	cmd_rall(playerid,"");
	return true;
}
CMD:vexport(playerid, params[])
{
    new data[256];
    format(data, sizeof data, "AOC.pwn");
    slfc +=1;
	new File:fhandler = fopen(data, io_append);
    format(data, sizeof data, "CMD:test%d(playerid, params[])\n{\nnew obdd = CreateObject(%d,0,0,-1000,0,0,0,100);",slfc,vobid);
    fwrite(fhandler, data);
    SendClientMessage(playerid,LIGHTBLUE,"Code Save in scriptfiles/AOC.pwn");
    format(data, sizeof data, "\nAttachObjectToVehicle(obdd, GetPlayerVehicleID(playerid),%f,%f,%f,%f,%f,%f);",VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z);
    fwrite(fhandler, data);
    format(data, sizeof data, "\nreturn 1;\n");
    fwrite(fhandler, data);
    format(data, sizeof data, "}\n");
    fwrite(fhandler, data);
	fclose(fhandler);
    format(data, sizeof data, "\nAttachObjectToVehicle(%d, GetPlayerVehicleID(playerid),%f,%f,%f,%f,%f,%f);",vobid,VPOSITION_X,VPOSITION_Y,VPOSITION_Z,VROTATION_X,VROTATION_Y,VROTATION_Z),    SendClientMessage(playerid, -1, data);
	cmd_rall(playerid,"");
	return true;
}
CMD:rall(playerid,params[])
{
 POSITION_X =0,
 POSITION_Y=0,
 POSITION_Z=0,
 ROTATION_X=0,
 ROTATION_Y=0,
 ROTATION_Z=0,
 SCALE_X=1.0,
 SCALE_Y=1.0,
 SCALE_Z=1.0;
 return 1;
}
CMD:rall2(playerid,params[])
{
 VPOSITION_X =0,
 VPOSITION_Y=0,
 VPOSITION_Z=0,
 VROTATION_X=0,
 VROTATION_Y=0,
 VROTATION_Z=0;
 return 1;
}
CMD:px(playerid,params[])
{
            fmode = FPX;
            return 1;
}
CMD:py(playerid,params[])
{
            fmode = FPY;
            return 1;
}
CMD:pz(playerid,params[])
{
            fmode = FPZ;
            return 1;
}
CMD:rx(playerid,params[])
{
            fmode = FRX;
            return 1;
}
CMD:ry(playerid,params[])
{
            fmode = FRY;
            return 1;
}
CMD:rz(playerid,params[])
{
            fmode = FRZ;
            return 1;
}
CMD:sx(playerid,params[])
{
            fmode = FSX;
            return 1;
}
CMD:sy(playerid,params[])
{
            fmode = FSY;
            return 1;
}
CMD:sz(playerid,params[])
{
            fmode = FSZ;
            return 1;
}
CMD:dao(playerid,params[])
{
            if(errors == 3) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Must end Your Edit!");
            if(errors == 1) return SendClientMessage(playerid,COLOR_RED,"ERROR: You Must end You AO!");
        	ShowPlayerDialog(playerid, D_DAO, DIALOG_STYLE_MSGBOX, "###:.Delete Attached Object.:###", " -AO = Undo \n All = All Attached Objects ", "-AO", "All AO");
            return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
 	if(dialogid == D_BP)
        {
        if(response)
                {
                        if(listitem == 0)
                        {
bodyp = 1;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 1)
                        {
bodyp = 2;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 2)
                        {
bodyp = 3;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 3)
                        {
bodyp = 4;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 4)
                        {
bodyp = 5;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 5)
                        {
bodyp = 6;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 6)
                        {
bodyp = 7;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 7)
                        {
bodyp = 8;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 8)
                        {
bodyp = 9;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 9)
                        {
bodyp = 10;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 10)
                        {
bodyp = 11;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 11)
                        {
bodyp = 12;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 12)
                        {
bodyp = 13;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 13)
                        {
bodyp = 14;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 14)
                        {
bodyp = 15;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 15)
                        {
bodyp = 16;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 16)
                        {
bodyp = 17;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        if(listitem == 17)
                        {
bodyp = 18;
ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                        }
                        return 1;
			  }
	}
	if(dialogid == D_CO)
    {
        if(response)
        {
            new zobid = strval(inputtext);
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
            if(zobid < 1 || zobid > 19901)
            {
			    SendClientMessage(playerid, -1, "Invalid Object ID.");
                ShowPlayerDialog(playerid,D_CO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                return 1;
            }
            else
            {
                obid =zobid;
                slno +=1;
                fmsao = 0;
                KillTimer(trmatimer);
                //
                TextDrawShowForPlayer(playerid,tdaoc);
                //
                S3B5
                cmd_aedit(playerid,"");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, -1, "Object ID selection canceled.");
        }
    }
	if(dialogid == D_VCO)
    {
        if(response)
        {
            new zobid = strval(inputtext);
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid,D_VCO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
            if(zobid < 1 || zobid > 19901)
            {
			    SendClientMessage(playerid, -1, "Invalid Object ID.");
                ShowPlayerDialog(playerid,D_VCO, DIALOG_STYLE_INPUT, "Object ID","{00FFFF}Type Object ID.","Ok","Cancel");
                return 1;
            }
            else
            {
                vobid =zobid;
                slno +=1;
                fmsao = 0;
                KillTimer(trmatimer);
                //
                TextDrawShowForPlayer(playerid,tdvoc);
                //
                S3B4
                cmd_vedit(playerid,"");
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, -1, "Object ID selection canceled.");
        }
    }
	if(dialogid == D_DAO)
    {
        if(response)
        {
                if(slno <= 0) return SendClientMessage(playerid,COLOR_RED,"ERROR: No Attached Object to Delete.");
                RemovePlayerAttachedObject( playerid, slno );
                slno -=1;
             	ShowPlayerDialog(playerid, D_DAO, DIALOG_STYLE_MSGBOX, "###:.Delete Attached Object.:###", "Delete AO ", "Undo", "Quit");
                return 1;
        }
        else
        {
            for ( new i = 0; i < 300; i ++ )
     		if ( IsPlayerAttachedObjectSlotUsed( playerid, i ) )
			RemovePlayerAttachedObject( playerid, i );
        }
    }
	if(dialogid == D_UNDO)
    {
        if(response)
        {
                if(slno <= 0) return SendClientMessage(playerid,COLOR_RED,"ERROR: No Attached Object to Delete.");
                RemovePlayerAttachedObject( playerid, slno );
                slno -=1;
             	ShowPlayerDialog(playerid, D_UNDO, DIALOG_STYLE_MSGBOX, "###:.Delete Attached Object.:###", "Delete AO ", "Undo", "Quit");
                return 1;
        }
    }
	return 1;
}