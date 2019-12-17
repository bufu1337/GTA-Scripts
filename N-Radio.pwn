/*
              ,,              ,,            ,,
`7MN.   `7MF' db              db          `7MM        MMM"""AMV
  MMN.    M                                 MM        M'   AMV
  M YMb   M `7MM  `7MMpMMMb.`7MM  ,6"Yb.    MMpMMMb.  '   AMV
  M  `MN. M   MM    MM    MM  MM 8)   MM    MM    MM     AMV
  M   `MM.M   MM    MM    MM  MM  ,pm9MM    MM    MM    AMV   ,
  M     YMM   MM    MM    MM  MM 8M   MM    MM    MM   AMV   ,M
.JML.    YM .JMML..JMML  JMML.MM `Moo9^Yo..JMML  JMML.AMVmmmmMM
                           QO MP
                           `bmP
Credits to Me - Making Script
Credits to SA-MP Team - for a_samp
Credits to Y_less for YSI/y_Commands,Sscanf2
*/
//--------------------------[ FILTERSCRIPT ]------------------------------------
#define 					FILTERSCRIPT
//--------------------------[ GENERAL INCLUDES ]--------------------------------
#include 					<a_samp>
#include 					<YSI\y_commands>
#include 					<sscanf2>
//--------------------------[ COLORS ]------------------------------------------
#define 					COLOR_RED 							0xFF0000FF
#define 					COLOR_BLUE 							0x0000BBAA
#define						COLOR_ORANGE						0xFF8000FF
#define						COLOR_YELLOW						0xFFFF00AA
#define						COLOR_GREEN							0x33AA33AA
#define						COLOR_BLACK							0x000000AA
#define						COLOR_WHITE							0xFFFFFFAA
#define						COLOR_FADE1							0xE6E6E6E6
#define						COLOR_FADE2							0xC8C8C8C8
#define						COLOR_FADE3							0xAAAAAAAA
#define						COLOR_FADE4							0x8C8C8C8C
#define						COLOR_FADE5							0x6E6E6E6E
#define						COLOR_LIGHTRED						0xFF6347AA
#define						COLOR_LIGHTBLUE						0x33CCFFAA
#define						COLOR_REALRED						0xFF0606FF
//--------------------------[ CUSTOM DEFINES ]----------------------------------
#define 					SCM									SendClientMessage
#define                     SPD                                 ShowPlayerDialog
#define						PASFP                               PlayAudioStreamForPlayer
#define						SASFP   							StopAudioStreamForPlayer
//--------------------------[ DIALOGS ]-----------------------------------------
#define 					DIALOG_RADIO  						1870
#define 					DIALOG_GENRES     					1871
#define 					DIALOG_CURL     					1872
#define						DIALOG_OUTOFCARSETRADIO             1873
#define                     DIALOG_OUTOFCARSR                   1874
//--------------------------[ GENRE'S DIALOGS ]---------------------------------
#define 					DIALOG_POP 							1875
#define 					DIALOG_RAP  						1876
#define 					DIALOG_REGGAE   					1877
#define 					DIALOG_ELECTRONIC  					1878
#define 					DIALOG_ALTERNATIVE 					1880
#define 					DIALOG_BLUES     					1881
#define 					DIALOG_CLASSICAL  					1882
#define 					DIALOG_COUNTRY     					1883
#define 					DIALOG_DECADES     					1884
#define 					DIALOG_EASYLISTENING     			1885
#define 					DIALOG_FOLK     					1886
#define 					DIALOG_INSPIRATIONAL     			1887
#define 					DIALOG_INTERNATIONAL     			1888
#define 					DIALOG_JAZZ     					1889
#define 					DIALOG_LATIN     					1890
#define 					DIALOG_METAL     					1891
#define 					DIALOG_MISC      					1892
#define 					DIALOG_NEWAGE     					1893
#define 					DIALOG_PUBLICRADIO     				1894
#define 					DIALOG_RNBURBAN      				1895
#define 					DIALOG_ROCK     					1896
#define 					DIALOG_TALK     					1897
#define                     DIALOG_TECHNO                       1111
#define                     DIALOG_RADIOHELP                    1112
#pragma tabsize 0
//
public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" RadioSystem by NinjahZ Loaded!");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
    print("Radio System by NinjahZ Unloaded!");
	return 1;
}

public OnPlayerConnect(playerid)
{
    SASFP(playerid);
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    SASFP(killerid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(oldstate == PLAYER_STATE_DRIVER)
	{
        SASFP(playerid);
    }
    if(oldstate == PLAYER_STATE_PASSENGER)
	{
        SASFP(playerid);
    }
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    SCM(playerid, COLOR_RED, "You can select a radio station with (/setradio)");
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    SASFP(playerid);
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
		if (dialogid == DIALOG_GENRES) //==RADIOSTATION==//
		{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==PoP==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SPD(playerid, DIALOG_OUTOFCARSR, DIALOG_STYLE_MSGBOX, "Stop Radio","You must be in a vehicle to stop a custom Radio station!", "Okay", "Cancel");
                SPD(playerid,DIALOG_POP, DIALOG_STYLE_LIST, "Pop Radio Selection", "{BB0000}Power 181.FM\n{BB0000}Radio Paloma\n{BB0000}MUSIK.MAIN\n{BB0000}.977 The Hitz Channel\n{BB0000}Lux.FM\n{BB0000}Radio VHR\n{BB0000}ChartHits.FM\n{BB0000}Sky.FM\n{BB0000}PRO.FM", "Listen", "Cancel");
            }
			if(listitem == 1) //==RaP==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_RAP, DIALOG_STYLE_LIST, "Rap Radio Selection", "{BB0000}HOT 108 JAMZ\n{BB0000}MUSIK.JAM\n{BB0000}181.FM The BEAT\n{BB0000}Smoothbeats\n{BB0000}108.FM THE HITLIST\n{BB0000}TrueHipHop\n{BB0000}A1Jamz\n{BB0000}True Beats\n{BB0000}MKM URBAN\n{BB0000}G'D Up Radio", "Listen", "Cancel");
            }
            if(listitem == 2) //==Reggae==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_REGGAE, DIALOG_STYLE_LIST, "Reggae Radio Selection", "{BB0000}RRS.FM\n{BB0000}La Grosse\n{BB0000}BigUpRadio\n{BB0000}RaggaKings\n{BB0000}PONdENDS\n{BB0000}Reggae141\n{BB0000}RRR.FM\n{BB0000}1.FM ReggaeTrade\n{BB0000}Black Roots Radio", "Listen", "Cancel");
            }
            if(listitem == 3) //==Electronic==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_ELECTRONIC, DIALOG_STYLE_LIST, "Electronic Radio Selection", "{BB0000}TechnoBase\n{BB0000}VocalTrance\n{BB0000}M.H Funky\n{BB0000}TC.FM\n{BB0000}HouseTime.FM\n{BB0000}Dubstep.FM\n{BB0000}54House.FM\n{BB0000}DrumStep.FM\n{BB0000}HardBase.FM\n{BB0000}Techno4Ever.FM", "Listen", "Cancel");
            }
            if(listitem == 4) //==Alternative==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_ALTERNATIVE, DIALOG_STYLE_LIST, "Alternative Radio Selection", "{BB0000}Idobi Radio\n{BB0000}181.FM The Buzz\n{BB0000}RauteMusik.FM\n{BB0000}FM4\n{BB0000}ChroniX Radio\n{BB0000}Pinguin Radio\n{BB0000}KEXP\n{BB0000}KCRW Simulcas\n{BB0000}Metal Only\n{BB0000}1.FM Channel X", "Listen", "Cancel");
            }
            if(listitem == 5) //==Blues==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_BLUES, DIALOG_STYLE_LIST, "Blues Radio Selection", "{BB0000}1.FM Blues\n{BB0000}BellyUp4Blues\n{BB0000}CALMRADIO\n{BB0000}KOQS Blues\n{BB0000}GotRadio\n{BB0000}Radioio Blues\n{BB0000}Polski Radio\n{BB0000}Big Blue Swing\n{BB0000}City Sounds Radio", "Listen", "Cancel");
            }
            if(listitem == 6) //==Classical==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_CLASSICAL, DIALOG_STYLE_LIST, "Classical Radio Selection", "{BB0000}Classical 102\n{BB0000}Iowa Public Radio\n{BB0000}181.FM Classic Hits\n{BB0000}Cinemix\n{BB0000}Venice Classic Radio\n{BB0000}Sky.FM Piano\n{BB0000}SKY.FM Mostly Classic\n{BB0000}Adagio.FM\n{BB0000}Classical 96.3FM CFMZ\n{BB0000}Abacus.FM Mozart Piano", "Listen", "Cancel");
            }
            if(listitem == 7) //==Country==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_COUNTRY, DIALOG_STYLE_LIST, "Country Radio Selection", "{BB0000}181.FM Kickin' Country\n{BB0000}Allways Country\n{BB0000}Country 108\n{BB0000}181.FM Highway\n{BB0000}HPR1.FM\n{BB0000}Radio Positiva\n{BB0000}1.FM Country\n{BB0000}Boot Liquor\n{BB0000}Absolute COUNTRY Hits\n{BB0000}181.FM Real Country", "Listen", "Cancel");
            }
            if(listitem == 8) //==Decades==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_DECADES, DIALOG_STYLE_LIST, "Decades Radio Selection", "{BB0000}101.6 Big R Radio\n{BB0000}The Hawk Big R Radio\n{BB0000}100.7 The Mix\n{BB0000}Vintage Jazz\n{BB0000}Oldies104\n{BB0000}1.FM 50's N 60's\n{BB0000}The Doo-Wop Express\n{BB0000}Beatless Radio\n{BB0000}1.FM 80's Channel\n{BB0000}SKY.FM 80's", "Listen", "Cancel");
            }
            if(listitem == 9) //==EasyListening==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_EASYLISTENING, DIALOG_STYLE_LIST, "EasyListening Radio Selection", "{BB0000}Slow Radio\n{BB0000}MUSIK.LOUNGE\n{BB0000}Blue.FM\n{BB0000}SKY.FM\n{BB0000}Radio227\n{BB0000}COOL93\n{BB0000}KLUX 89.5HD\n{BB0000}AbidingRadio\n{BB0000}Louge Radio\n{BB0000}1.FM The Chillout Lounge", "Listen", "Cancel");
            }
            if(listitem == 10) //==Folk==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_FOLK, DIALOG_STYLE_LIST, "Folk Radio Selection", "{BB0000}Free Vermont\n{BB0000}Pink Narodna Muzika\n{BB0000}Dzungla Radio\n{BB0000}Folk Alley\n{BB0000}Radio BN\n{BB0000}Radio Glas Drine\n{BB0000}COOL Radio\n{BB0000}Antioch OT\n{BB0000}A&P-R Network\n{BB0000}New Age SKY.FM", "Listen", "Cancel");
            }
            if(listitem == 11) //==Inspirational==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_INSPIRATIONAL, DIALOG_STYLE_LIST, "Inspirational Radio Selection", "{BB0000}Russian Christian Radio\n{BB0000}AbidingRadio\n{BB0000}1 NATION FM\n{BB0000}XL Radio\n{BB0000}Radio Lumiere\n{BB0000}Ancient Faith\n{BB0000}Bautista Radio\n{BB0000}Radio Nueva\n{BB0000}ChristianRock\n{BB0000}FBC Radio", "Listen", "Cancel");
            }
            if(listitem == 12) //==International==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_INTERNATIONAL, DIALOG_STYLE_LIST, "International Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 13) //==Jazz==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_JAZZ, DIALOG_STYLE_LIST, "Jazz Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 14) //==Latin==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_LATIN, DIALOG_STYLE_LIST, "Latin Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 15) //==Metal==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_METAL, DIALOG_STYLE_LIST, "Metal Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 16) //==Misc==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_MISC, DIALOG_STYLE_LIST, "Misc Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 17) //==NewAge==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_NEWAGE, DIALOG_STYLE_LIST, "NewAge Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 18) //==PublicRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_PUBLICRADIO, DIALOG_STYLE_LIST, "Public Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 19) //==UrbanRnB==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_RNBURBAN, DIALOG_STYLE_LIST, "Urban RnB Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 20) //==Rock==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_ROCK, DIALOG_STYLE_LIST, "Rock Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
            if(listitem == 21) //==Talk==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid,DIALOG_TALK, DIALOG_STYLE_LIST, "Talk Radio Selection", "{BB0000} Radioparty\n{BB0000} Dronezone\n{BB0000} Energy.FM\n{BB0000} Pulseradio", "Listen", "Cancel");
            }
		}
	}
	if (dialogid == DIALOG_POP) //==POP==//
	{
	    if(!response) // If they clicked the right button
        {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
            SCM(playerid, COLOR_RED, "You Canceled the PoP Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==POWER=181.FM==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
				PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283896");
			}
			if(listitem == 1) //==Radio=Paloma==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=710507");
            }
            if(listitem == 2) //==MUSIK.MAIN==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275878");
            }
            if(listitem == 3) //==.977=The=Hitz=Channel==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280356");
			}
			if(listitem == 4) //==Lux.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=967434");
			}
			if(listitem == 5) //==Radio=VHR==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=117838");
			}
			if(listitem == 6) //==ChartHits.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=43280");
			}
			if(listitem == 7) //==SKY.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=728272");
			}
			if(listitem == 8) //==Pop=Radio=One==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=128879");
			}
		}
	}
	if (dialogid == DIALOG_RAP) //==RAP==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
            SendClientMessage(playerid, COLOR_RED, "You Canceled the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==HOT 108 JAMZ==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
				PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281016");
			}
			if(listitem == 1) //==MUSIK.JAM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269742");
            }
            if(listitem == 2) //==181.FM THE BEAT==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=166078");
            }
            if(listitem == 3) //==Smoothbeats==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9054");
            }
            if(listitem == 4) //==181.FM THE HITLIST==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1282490");
            }
            if(listitem == 5) //==TrueHipHop==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3083251");
            }
            if(listitem == 6) //==A1JAMZ==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=49567");
            }
            if(listitem == 7) //==True Beats==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1267461");
            }
            if(listitem == 8) //==MKM URBAN==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1818926");
            }
            if(listitem == 9) //==G'D Up Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1504548");
            }
		}
	}
	if (dialogid == DIALOG_REGGAE) //==REGGAE==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
            SendClientMessage(playerid, COLOR_RED, "You Canceled the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RRS.FM==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
				PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=695657");
			}
			if(listitem == 1) //==La Grosse==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=5661");
            }
            if(listitem == 2) //==BigUpRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269793");
            }
            if(listitem == 3) //==RaggaKings==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=123431");
            }
            if(listitem == 4) //==PONdENDS==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=221874");
            }
            if(listitem == 5) //==Reggae141==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280855");
            }
            if(listitem == 6) //==RRR.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1266989");
            }
            if(listitem == 7) //==1.FM ReggaeTrade==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272779");
            }
            if(listitem == 8) //==BlackRoots Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=231554");
            }
		}
	}
	if (dialogid == DIALOG_ELECTRONIC) //==Electronic==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
            SendClientMessage(playerid, COLOR_RED, "You Canceled the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==TechnoBase.FM==//
			{
      			 if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377200");
			}
			if(listitem == 1) //==Vocal Trance==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1177953");
            }
            if(listitem == 2) //==MUSIK.HOUSE Funky==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2128868");
            }
            if(listitem == 3) //==Trance Channel==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1193516");
            }
            if(listitem == 4) //==HouseTime.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377360");
            }
            if(listitem == 5) //==Dubstep.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=7225");
            }
            if(listitem == 6) //==54House.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2808203");
            }
            if(listitem == 7) //==MUSIK.DRUMSTEP==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=46883");
            }
            if(listitem == 8) //==HardBase.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377430");
            }
            if(listitem == 9) //==Techno4EverMain.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=226769");
            }
		}
	}
	if (dialogid == DIALOG_ALTERNATIVE) //==ALTERNATIVE==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Idobi Radio==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=21585");
			}
			if(listitem == 1) //==181.FM The Buzz==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=37586");
            }
            if(listitem == 2) //==FM4==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=581319");
            }
            if(listitem == 3) //==CHRONIX==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377260");
            }
            if(listitem == 4) //==Pinguin Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=199753");
            }
            if(listitem == 5) //==KEXP==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272835");
            }
            if(listitem == 6) //==KCRW Simulcas==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269598");
            }
            if(listitem == 7) //==Metal Only==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=477309");
            }
            if(listitem == 8) //==1.FM Channel X==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274225");
            }
   		}
	}
	if (dialogid == DIALOG_BLUES) //==Blues==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==1.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1270282");
            }
            if(listitem == 1) //==bellyupblues==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=11408");
            }
            if(listitem == 2) //==calmradio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=205177");
            }
            if(listitem == 3) //==koqx==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271824");
            }
            if(listitem == 4) //==gotradio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=533805");
            }
            if(listitem == 5) //==radioio blues==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1278494");
            }
            if(listitem == 6) //==polskie radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1044755");
            }
            if(listitem == 7) //==big blue swing==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377377");
            }
            if(listitem == 8) //==city sounds radio blues==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=20151");
            }
   		}
	}
	if (dialogid == DIALOG_CLASSICAL) //==Classical==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Classical 102==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1676910");
			}
			if(listitem == 1) //==Iowa Public Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=177883");
            }
            if(listitem == 2) //==181.FM classical hits==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==Cinemix==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=614375");
            }
            if(listitem == 4) //==Venice Classic Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1704166");
            }
            if(listitem == 5) //==Solo Piano SKY.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=600682");
            }
            if(listitem == 6) //==Mostly Classical==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=744232");
            }
            if(listitem == 7) //==Adagio.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=212505");
            }
            if(listitem == 8) //==Classical 96.3FM CFMZ==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2271823");
            }
            if(listitem == 9) //==Abacus.fm Mozart Piano==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=119965");
            }
   		}
	}
	if (dialogid == DIALOG_COUNTRY) //==Country==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==181.FM==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687");
			}
			if(listitem == 1) //==Always Country==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274260");
            }
            if(listitem == 2) //==Country 108==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=668943");
            }
            if(listitem == 3) //==Highway 181==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=147942");
            }
            if(listitem == 4) //==HPR1==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1270526");
            }
            if(listitem == 5) //==Radio Positiva Sertaneja==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2890335");
            }
            if(listitem == 6) //==1.FM Country==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274603");
            }
            if(listitem == 7) //==Boot Liquor==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377561");
            }
            if(listitem == 8) //==Absolute COUNTRY Hits==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268458");
            }
            if(listitem == 9) //==181.FM Real Country==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=163622");
            }
   		}
	}
	if (dialogid == DIALOG_DECADES) //==Decades==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Big R Radio Warm 101.6==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=33097");
			}
			if(listitem == 1) //==Big R Radio The Hawk==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=211531");
            }
            if(listitem == 2) //==Big R Radio 100.7 The Mix==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=61826");
            }
            if(listitem == 3) //==Abacus.fm Vintage Jazz==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=242774");
            }
            if(listitem == 4) //==Oldies104==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271826");
            }
            if(listitem == 5) //==1.FM 50s and 60s==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=37833");
            }
            if(listitem == 6) //==The Doo-Wop Express==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=727560");
            }
            if(listitem == 7) //==Beatles Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1273220");
            }
            if(listitem == 8) //==1.FM 80s Channel==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274599");
            }
            if(listitem == 9) //==SKY.FM 80s==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=737152");
            }
   		}
	}
	if (dialogid == DIALOG_EASYLISTENING) //==Easy Listening==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Slow Radio==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1658657");
			}
			if(listitem == 1) //==MUSIK.LOUNGE==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=130940");
            }
            if(listitem == 2) //==Blue FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=48138");
            }
            if(listitem == 3) //==SKY.FM Mostly Classical==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=744232");
            }
            if(listitem == 4) //==Radio227 Easy Listening==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2313198");
            }
            if(listitem == 5) //==COOL93==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=63135");
            }
            if(listitem == 6) //==KLUX 89.5HD==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1697");
            }
            if(listitem == 7) //==AbidingRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=470854");
            }
            if(listitem == 8) //==Lounge Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1288934");
            }
            if(listitem == 9) //==1.FM The Chillout Lounge==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268725");
            }
   		}
	}
	if (dialogid == DIALOG_FOLK) //==Folk==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Radio Free Vermont==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=168942");
			}
			if(listitem == 1) //==Pink Narodna Muzika==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=883729");
            }
            if(listitem == 2) //==Dzungla Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279638");
            }
            if(listitem == 3) //==Folk Alley==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1273365");
            }
            if(listitem == 4) //==Radio BN==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=29949");
            }
            if(listitem == 5) //==Radio Glas Drine==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1841408");
            }
            if(listitem == 6) //==COOL radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=550002");
            }
            if(listitem == 7) //==AM 1710 Antioch OT==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2699");
            }
            if(listitem == 8) //==A&P Radio Network==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=563824");
            }
            if(listitem == 9) //==New Age SKY.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093");
            }
   		}
	}
	if (dialogid == DIALOG_INSPIRATIONAL) //==Inspirational==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Russian Christian Radio==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280598");
			}
			if(listitem == 1) //==AbidingRadio INSTRUMENTAL==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=470854");
            }
            if(listitem == 2) //==1-ONE NATION FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1988533");
            }
            if(listitem == 3) //==XL Radio Gurbani Kirtan==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=272693");
            }
            if(listitem == 4) //==Radio Lumiere Miami==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=341387");
            }
            if(listitem == 5) //==Ancient Faith Music==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=2010550");
            }
            if(listitem == 6) //==Bautista Radio 89.7 FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=347942");
            }
            if(listitem == 7) //==Radio Nueva Vida==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=208506");
            }
            if(listitem == 8) //==ChristianRock==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=1266649");
            }
            if(listitem == 9) //==FBC Radio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=95154");
            }
   		}
	}
	if (dialogid == DIALOG_INTERNATIONAL) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_JAZZ) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
       			if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_LATIN) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_METAL) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_MISC) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_NEWAGE) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_PUBLICRADIO) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_RNBURBAN) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_ROCK) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}
	if (dialogid == DIALOG_TALK) //==TECHNO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==RadioParty==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3732");
			}
			if(listitem == 1) //==DroneZone==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=69013");
            }
            if(listitem == 2) //==Energy.FM==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=9455066");
            }
            if(listitem == 3) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
            if(listitem == 4) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
            if(listitem == 5) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
            if(listitem == 6) //==PulseRadio==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                PASFP(playerid,"http://yp.shoutcast.com/sbin/tunein-station.pls?id=3026");
            }
   		}
	}

	if (dialogid == DIALOG_RADIO) //==RADIO==//
	{
	    if(!response) // If they clicked 'Cancel' or pressed esc
        {
            SCM(playerid, COLOR_RED, "You exited the Radio Selection.");
        }
		if(response) //means if they clicked left button
		{
			if(listitem == 0) //==Genres==//
			{
			    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a custom Radio station!");
                SPD(playerid, DIALOG_GENRES, DIALOG_STYLE_LIST, "Radio Selection","{BB0000}Pop\n{BB0000}Rap\n{BB0000}Reggae\n{BB0000}Dubstep\n{BB0000}Techno\n{BB0000}Alternative\n{BB0000}Blues\n{BB0000}Classical\n{BB0000}Country\n{BB0000}Decades\n{BB0000}Easy Listening\n{BB0000}Folk\n{BB0000}Inspirational\n{BB0000}International\n{BB0000}Jazz\n{BB0000}Latin\n{BB0000}Metal\n{BB0000}Misc\n{BB0000}NewAge\n{BB0000}Public Radio\n{BB0000}RnB/Urban\n{BB0000}Rock\n{BB0000}Talk", "Select", "Cancel");
			}
			if(listitem == 1) //==Insert-URL==//
            {
                if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_RED, "You must be in a vehicle to select a Custom URL Radio station!");
                SPD(playerid,DIALOG_CURL,DIALOG_STYLE_INPUT,"Input URL","Type your URL here.","Listen","Cancel");
            }
            if(listitem == 2) //==Stop=Radio==//
            {
            if(!IsPlayerInAnyVehicle(playerid)) return SPD(playerid, DIALOG_OUTOFCARSR, DIALOG_STYLE_MSGBOX, "Stop Radio","You must be in a vehicle to stop a custom Radio station!", "Okay", "Cancel");
			SASFP(playerid);
            }
   		}
	}
	if(dialogid == DIALOG_CURL)
	{
	    	if(!response) // If they clicked 'Cancel' or pressed esc
        	{
           	 	SCM(playerid, COLOR_RED, "You exited the Custom-URL Selection.");
        	}
        	if(strlen(inputtext) < 64 || strlen(inputtext) > 0)
        	{
            	PASFP(playerid, inputtext);
        	}
	}
	return 1;
}

YCMD:setradio(playerid, params[],help)
{
    if(!IsPlayerInAnyVehicle(playerid)) return SPD(playerid, DIALOG_OUTOFCARSETRADIO, DIALOG_STYLE_MSGBOX, "Set Radio","You must be in a vehicle to set a custom Radio station!", "Okay", "Cancel");
	SPD(playerid, DIALOG_RADIO, DIALOG_STYLE_LIST, "Radio Selection","{BB0000}Genres\n{BB0000}Insert-URL\n{BB0000}Stop Radio", "Select", "Cancel");
	return 1;
}
YCMD:radiohelp(playerid, params[],help)
{
    SPD(playerid, DIALOG_RADIOHELP, DIALOG_STYLE_MSGBOX, "Radio Help","{BB0000}(/setradio)", "Okay", "Cancel");
    return 1;
}