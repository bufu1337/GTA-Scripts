#include <a_samp>

#define USE_DIALOG_ID 2

#define MAX_PACES 20
#define MIN_SPEED 1
#define MAX_SPEED 5
#define RIG_SPEED 2 //This add or subtracts the randomizer when using the Rigging features (Steroids and Sleeping Pills)
#define RIG_PIT_STOP_TIME 2000 //This time in milliseconds a cow will wait if affected by Pit Stop
#define RACE_INTERVAL 30000 //Milliseconds in between races

#define COLOR_COW_1 0xCC0000FF
#define COLOR_COW_2 0xFFAAAAFF
#define COLOR_COW_3 0xFFFF00FF
#define COLOR_COW_4 0x4444FFFF
#define COLOR_COW_5 0xCCCC00FF
#define COLOR_INTERMISSION 0x888888FF
#define COLOR_RACE_BEGINNING 0xFF1111FF
#define COLOR_ON_YOUR_MARK 0xDD0000FF
#define COLOR_GET_SET 0xDD8800FF
#define COLOR_GO_GO_GO 0x00DD00FF
#define COLOR_WINNER 0x00FF00FF
#define COLOR_WINDOW_CLOSE 0xFF0000FF

forward OnRaceUpdate();
forward OnRaceEnd();

new PlayersCanRig=1; //Set to 0 if you don't want players to be able to rig the race
//The cost of the rig, set to 0 to deactivate
new RigSteroids=1000; //Make for a better chance to go faster cancels out SleepingPills
new RigSleepingPills=750; //Make for a better chance to go slower
new RigFinalStretch=1200; //Cow will not change speeds for the last 5 paces
new RigPitStop=1350; //Forces a cow to stop for a certain amount of time before continuing 5 paces before end

new BetBooth[2]; //Must be near these to place bets
new CowRacer[5]; //Here he comes, here comes Cow Racer; he's a demon of beef!
new MapObject[32]; //Should be deleted if unloaded

new RaceStep;
new RaceWinner;
new CowStep[5];

new CowsRigged[5][4]; //[Cows][Rigs]

new LabelIsOn[5];
new Text3D:CowNames[5];
new Text3D:RaceStart;
new Text3D:Booths[2];

new Float:XPaces[5]; //1 X Pace per racer
new Float:YPaces[MAX_PACES]; //The Y Coordinate where the cow's speed randomly changes

stock SetPaces()
{
	new Float:space=(1572.270019-1522.773559)/MAX_PACES;
	for(new pace;pace<MAX_PACES;pace++)YPaces[pace]=1522.773559+(space*pace);
	XPaces[0]=1101.841552;
	XPaces[1]=1098.581389;
	XPaces[2]=1095.321227;
	XPaces[3]=1092.061065;
	XPaces[4]=1088.800903;
}

stock ShowRigDialog(playerid)
{
	new list[256];
	if(RigSteroids)format(list,256,"%sSteroids - $%d\n",list,RigSteroids);
	if(RigSleepingPills)format(list,256,"%sSleeping Pills - $%d\n",list,RigSleepingPills);
	if(RigFinalStretch)format(list,256,"%sFinal Stretch - $%d\n",list,RigFinalStretch);
	if(RigPitStop)format(list,256,"%sPit Stop - $%d\n",list,RigPitStop);
	ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Rig",list,"Select","Back");
	SetPVarInt(playerid,"DIALOG",3);
}
stock ShowRigRacerDialog(playerid)
{
	new list[256];
	format(list,256,"%s\n%s\n%s\n%s\n%s",GetRacerName(0),GetRacerName(1),GetRacerName(2),GetRacerName(3),GetRacerName(4));
	ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Racer to Rig",list,"Rig","Back");
	SetPVarInt(playerid,"DIALOG",4);
}

stock SetTexts()
{
	LabelIsOn[0]=1;
	CowNames[0]=Create3DTextLabel(GetRacerName(0),COLOR_COW_1,1101.841552,1522.773559,10,100.0,0,1);
	LabelIsOn[1]=1;
	CowNames[1]=Create3DTextLabel(GetRacerName(1),COLOR_COW_2,1098.581389,1522.773559,10,100.0,0,1);
	LabelIsOn[2]=1;
	CowNames[2]=Create3DTextLabel(GetRacerName(2),COLOR_COW_3,1095.321227,1522.773559,10,100.0,0,1);
	LabelIsOn[3]=1;
	CowNames[3]=Create3DTextLabel(GetRacerName(3),COLOR_COW_4,1092.061065,1522.773559,10,100.0,0,1);
	LabelIsOn[4]=1;
	CowNames[4]=Create3DTextLabel(GetRacerName(4),COLOR_COW_5,1088.800903,1522.773559,10,100.0,0,1);
	RaceStart=Create3DTextLabel("Intermission",COLOR_INTERMISSION,1095.321227,1545.773559,12,100.0,0,1);
	Booths[0]=Create3DTextLabel("Betting Booth\nPress F",COLOR_INTERMISSION,1107.177734,1525.321166,8.484739,100.0,0,1);
	Booths[1]=Create3DTextLabel("Betting Booth\nPress F",COLOR_INTERMISSION,1083.677734,1525.320312,8.484739,100.0,0,1);
}

stock BeginCowRace()
{
	for(new step;step<5;step++)CowStep[step]=1;
	for(new object;object<5;object++)MoveObject(CowRacer[object],XPaces[object],YPaces[1],8.695835,float(random(MAX_SPEED+((CowsRigged[object][0]==1)?(RIG_SPEED):(0))-MIN_SPEED+((CowsRigged[object][1]==1)?(-RIG_SPEED):(0)))+MIN_SPEED));
}
stock ResetCowRace()
{
    for(new step;step<5;step++)
	{
		CowStep[step]=0;
		CowsRigged[step][0]=0;
		CowsRigged[step][1]=0;
		CowsRigged[step][2]=0;
		CowsRigged[step][3]=0;
	}
    for(new object;object<5;object++)MoveObject(CowRacer[object],XPaces[object],YPaces[0],8.695835,10);
    for(new label;label<5;label++)
    {
        if(LabelIsOn[label])Delete3DTextLabel(CowNames[label]);
        CowNames[label]=Create3DTextLabel(GetRacerName(label),GetRacerColor(label),XPaces[label],YPaces[0],10,100,0,1);
    }
}

stock GetRacerName(racer)
{
	new tmp[24];
	switch(racer)
	{
	    case 0:tmp="Blinky";
	    case 1:tmp="Pinky";
	    case 2:tmp="Pac-Man";
	    case 3:tmp="Inky";
	    case 4:tmp="Clyde";
	}
	return tmp;
}
stock GetRacerColor(racer)
{
	switch(racer)
	{
	    case 0:return COLOR_COW_1;
	    case 1:return COLOR_COW_2;
	    case 2:return COLOR_COW_3;
	    case 3:return COLOR_COW_4;
	    case 4:return COLOR_COW_5;
	}
	return 0;
}

public OnFilterScriptInit()
{
	MapObject[0]=CreateObject(6959,1093.778564,1570.288818,6.849679,0.000000,0.000000,0.000000);//object (vegasNbball1) (2  --  Interior 0
	MapObject[1]=CreateObject(6959,1093.778564,1530.300048,6.789999,180.000000,0.000000,0.000000);//object (vegasNbball1) (3  --  Interior 0
	MapObject[2]=CreateObject(9163,1071.030029,1562.988037,10.856634,0.000000,0.000000,0.000000);//object (shop04_lvs) (1)"  --  Interior 0
	MapObject[3]=CreateObject(9163,1071.036865,1523.015747,10.856634,0.000000,0.000000,0.000000);//object (shop04_lvs) (2)"  --  Interior 0
	MapObject[4]=CreateObject(9163,1120.029296,1562.987304,10.856634,0.000000,0.000000,0.000000);//object (shop04_lvs) (4)"  --  Interior 0
	MapObject[5]=CreateObject(9163,1120.029296,1523.015625,10.856634,0.000000,0.000000,0.000000);//object (shop04_lvs) (5)"  --  Interior 0
	MapObject[6]=CreateObject(6959,1093.778320,1530.299804,14.315003,180.000000,0.000000,0.000000);//object (vegasNbball1) (4  --  Interior 0
	MapObject[7]=CreateObject(6959,1093.778320,1570.288085,14.371999,0.000000,0.000000,0.000000);//object (vegasNbball1) (5  --  Interior 0
	MapObject[8]=CreateObject(3819,1108.621459,1559.768676,7.816188,0.000000,0.000000,0.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[9]=CreateObject(9163,1095.103515,1511.685546,10.856634,0.000000,0.000000,90.000000);//object (shop04_lvs) (6)"  --  Interior 0
	MapObject[10]=CreateObject(9163,1096.544433,1583.744750,10.856634,0.000000,0.000000,90.000000);//object (shop04_lvs) (7)"  --  Interior 0
	MapObject[11]=CreateObject(3819,1108.621459,1551.164672,7.816188,0.000000,0.000000,0.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[12]=CreateObject(3819,1108.621459,1542.554687,7.816188,0.000000,0.000000,0.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[13]=CreateObject(3819,1108.621459,1533.952880,7.816188,0.000000,0.000000,0.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[14]=CreateObject(3819,1082.185791,1533.952880,7.816188,0.000000,0.000000,180.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[15]=CreateObject(3819,1082.185791,1542.554687,7.816188,0.000000,0.000000,180.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[16]=CreateObject(3819,1082.185791,1551.164062,7.816188,0.000000,0.000000,180.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[17]=CreateObject(3819,1082.185791,1559.768554,7.816188,0.000000,0.000000,180.000000);//object (bleacher_SFSx) (  --  Interior 0
	MapObject[18]=CreateObject(973,1087.406616,1570.500000,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[19]=CreateObject(973,1087.406616,1561.150024,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[20]=CreateObject(973,1087.406250,1561.149414,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[21]=CreateObject(973,1103.382812,1551.774047,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[22]=CreateObject(973,1087.406616,1542.409423,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[23]=CreateObject(973,1087.406616,1533.029785,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[24]=CreateObject(973,1087.406616,1523.650512,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[25]=CreateObject(973,1103.382812,1570.500000,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[26]=CreateObject(973,1087.406250,1561.149414,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[27]=CreateObject(973,1103.382812,1561.149414,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[28]=CreateObject(973,1087.406250,1551.773437,7.658649,0.000000,0.000000,90.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[29]=CreateObject(973,1103.382812,1542.409179,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[30]=CreateObject(973,1103.382812,1533.029296,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0
	MapObject[31]=CreateObject(973,1103.382812,1523.650390,7.658649,0.000000,0.000000,270.000000);//object (sub_roadbarrier)  --  Interior 0

	CowRacer[0]=CreateObject(16442,1101.841552,1522.773559,8.695835,0.000000,0.000000,90.000000);//Cow Racer 1
	CowRacer[1]=CreateObject(16442,1098.581389,1522.773559,8.695835,0.000000,0.000000,90.000000);//Cow Racer 2
	CowRacer[2]=CreateObject(16442,1095.321227,1522.773559,8.695835,0.000000,0.000000,90.000000);//Cow Racer 3
	CowRacer[3]=CreateObject(16442,1092.061065,1522.773559,8.695835,0.000000,0.000000,90.000000);//Cow Racer 4
	CowRacer[4]=CreateObject(16442,1088.800903,1522.773559,8.695835,0.000000,0.000000,90.000000);//Cow Racer 5

	/*
	1101.841552,1572.270019,8.695835
 	1098.581389,1572.270019,8.695835
	1095.321227,1572.270019,8.695835 //Ending positions for the cows
	1092.061065,1572.270019,8.695835
	1088.800903,1572.270019,8.695835
	*/

	BetBooth[0]=CreateObject(3430,1107.177734,1525.321166,8.484739,0.000000,0.000000,0.000000);//Bet Booth 1
	BetBooth[1]=CreateObject(3430,1083.677734,1525.320312,8.484739,0.000000,0.000000,0.000000);//Bet Booth 2

	SetPaces();
	SetTexts();
	OnRaceUpdate();
}

public OnFilterScriptExit()
{
	for(new object;object<32;object++)DestroyObject(MapObject[object]);
	for(new object;object<5;object++)DestroyObject(CowRacer[object]),Delete3DTextLabel(CowNames[object]);
	for(new object;object<2;object++)DestroyObject(BetBooth[object]),Delete3DTextLabel(Booths[object]);
	Delete3DTextLabel(RaceStart);
	return 1;
}

public OnRaceUpdate()
{
	switch(RaceStep)
	{
	    case 0: //Race is going to begin in 5 seconds
	    {
	        Update3DTextLabelText(RaceStart,COLOR_RACE_BEGINNING,"The race is going to begin.");
	        RaceStep=1;
	        SetTimer("OnRaceUpdate",5000,0);
	        for(new playerid;playerid<MAX_PLAYERS;playerid++)
	        {
	            if(!IsPlayerConnected(playerid))continue;
	            if(GetPVarInt(playerid,"DIALOG"))
	            {
	                ShowPlayerDialog(playerid,-1,-1,"","","","");
	                SendClientMessage(playerid,COLOR_WINDOW_CLOSE,"The race is beginning and all bets are final!");
	                SetPVarInt(playerid,"DIALOG",0);
	            }
	        }
	    }
	    case 1:
	    {
	        Update3DTextLabelText(RaceStart,COLOR_ON_YOUR_MARK,"On Your Mark!");
	        RaceStep=2;
	        SetTimer("OnRaceUpdate",1000,0);
	    }
	    case 2:
	    {
	        Update3DTextLabelText(RaceStart,COLOR_GET_SET,"Get Set!");
	        RaceStep=3;
	        SetTimer("OnRaceUpdate",1000,0);
	    }
	    case 3:
	    {
	        Update3DTextLabelText(RaceStart,COLOR_GO_GO_GO,"Go Go Go!");
	        RaceStep=4;
	        BeginCowRace();
	    }
	    case 4:
	    {
	        new string[64];
	        format(string,64,"%s\nis the winner!",GetRacerName(RaceWinner));
			Update3DTextLabelText(CowNames[RaceWinner],COLOR_WINNER,string);
			Update3DTextLabelText(RaceStart,COLOR_WINNER,string);
			OnRaceEnd();
			RaceStep=5;
			SetTimer("OnRaceUpdate",5000,0);
	    }
	    case 5:
	    {
	        ResetCowRace();
	        Update3DTextLabelText(CowNames[RaceWinner],GetRacerColor(RaceWinner),GetRacerName(RaceWinner));
			Update3DTextLabelText(RaceStart,COLOR_INTERMISSION,"Intermission");
			RaceStep=0;
			SetTimer("OnRaceUpdate",RACE_INTERVAL,0);
	    }
	}
}

public OnObjectMoved(objectid)
{
	if(RaceStep==4)
	{
		for(new racer;racer<5;racer++)
		{
			if(objectid==CowRacer[racer])
			{
				CowStep[racer]++;
				if(CowStep[racer]==MAX_PACES)
				{
				    RaceWinner=racer;
					OnRaceUpdate();
				    return 1;
				}
				if(CowStep[racer]==MAX_PACES-5)
				{
				    if(CowsRigged[racer][3]==1)
					{
					    CowStep[racer]--;
					    CowsRigged[racer][3]=0; //So it doesn't repeat >.<
						return SetTimerEx("OnObjectMoved",RIG_PIT_STOP_TIME,0,"i",objectid);
					}
				    if(CowsRigged[racer][2]==1)CowStep[racer]=MAX_PACES-1;
				}
				MoveObject(CowRacer[racer],XPaces[racer],YPaces[CowStep[racer]],8.695835,random(MAX_SPEED+((CowsRigged[racer][0]==1)?(RIG_SPEED):(0))-MIN_SPEED+((CowsRigged[racer][1]==1)?(-RIG_SPEED):(0)))+MIN_SPEED);
				if(LabelIsOn[racer])Delete3DTextLabel(CowNames[racer]);
				CowNames[racer]=Create3DTextLabel(GetRacerName(racer),GetRacerColor(racer),XPaces[racer],YPaces[CowStep[racer]],10,100,0,1);
			}
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid==USE_DIALOG_ID)
	{
		switch(GetPVarInt(playerid,"DIALOG"))
		{
		    case 1:
		    {
		        if(!response)
				{
	                SetPVarInt(playerid,"DIALOG",0);
					return 1;
				}
				if(listitem<5)
				{
			        SetPVarInt(playerid,"DIALOG",2);
			        SetPVarInt(playerid,"BETEE",listitem);
			        ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_INPUT,GetRacerName(GetPVarInt(playerid,"BETEE")),"Type in the amount you want to bet on this racer.","Place Bet","Back");
		        }else{
		            ShowRigDialog(playerid);
		        }
		    }
		    case 2:
		    {
		        if(response)
		        {
		            if(GetPlayerMoney(playerid)>=strval(inputtext))
		            {
			            new string[12];
			            format(string,12,"BET%d",GetPVarInt(playerid,"BETEE"));
			       		SetPVarInt(playerid,string,strval(inputtext));
			       		GivePlayerMoney(playerid,-strval(inputtext));
		       		}else{
		       		    ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_INPUT,GetRacerName(listitem),"Type in the amount you want to bet on this racer.\nYou don't have that much money!","Place Bet","Back");
		       		    return 1;
		       		}
		        }
		        new string[256];
		        format(string,256,"%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d%s",GetRacerName(0),GetPVarInt(playerid,"BET0"),GetRacerName(1),GetPVarInt(playerid,"BET1"),GetRacerName(2),GetPVarInt(playerid,"BET2"),GetRacerName(3),GetPVarInt(playerid,"BET3"),GetRacerName(4),GetPVarInt(playerid,"BET4"),(PlayersCanRig==1)?("\nRig the Race"):(""));
				SetPVarInt(playerid,"DIALOG",1);
			    ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Racer",string,"Select","Close");
		    }
		    case 3:
		    {
		        if(!response)
		        {
			        new string[256];
			        format(string,256,"%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d%s",GetRacerName(0),GetPVarInt(playerid,"BET0"),GetRacerName(1),GetPVarInt(playerid,"BET1"),GetRacerName(2),GetPVarInt(playerid,"BET2"),GetRacerName(3),GetPVarInt(playerid,"BET3"),GetRacerName(4),GetPVarInt(playerid,"BET4"),(PlayersCanRig==1)?("\nRig the Race"):(""));
					SetPVarInt(playerid,"DIALOG",1);
				    ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Racer",string,"Select","Close");
				    return 1;
		        }
		        new price;
		        if(!strcmp(inputtext,"Steroids",true,8))price=RigSteroids;
		        if(!strcmp(inputtext,"Sleeping Pills",true,13))price=RigSleepingPills;
		        if(!strcmp(inputtext,"Final Stretch",true,12))price=RigFinalStretch;
		        if(!strcmp(inputtext,"Pit Stop",true,8))price=RigPitStop;
		        if(GetPlayerMoney(playerid)<price)
		        {
		            ShowRigDialog(playerid);
		            SendClientMessage(playerid,COLOR_WINDOW_CLOSE,"You do not have enough cash for that.");
		            return 1;
		        }
		        SetPVarString(playerid,"RIGSEL",inputtext);
		        ShowRigRacerDialog(playerid);
		    }
		    case 4:
		    {
		        if(!response)
		        {
		            ShowRigDialog(playerid);
		            return 1;
		        }
				new price;
			    new string[256];
			    GetPVarString(playerid,"RIGSEL",string,256);
			    new rig;
		        if(!strcmp(string,"Steroids",true,8))price=RigSteroids,CowsRigged[listitem][0]=1,rig=0;
		        if(!strcmp(string,"Sleeping Pills",true,13))price=RigSleepingPills,CowsRigged[listitem][1]=1,rig=1;
		        if(!strcmp(string,"Final Stretch",true,12))price=RigFinalStretch,CowsRigged[listitem][2]=1,rig=2;
		        if(!strcmp(string,"Pit Stop",true,8))price=RigPitStop,CowsRigged[listitem][3]=1,rig=3;
		        GivePlayerMoney(playerid,-price);
		        format(string,256,"%s has been rigged with %s. -$%d",GetRacerName(listitem),(rig==0)?("Steroids"):(rig==1)?("Sleeping Pills"):(rig==2)?("Final Stretch"):(rig==3)?("Pit Stop"):("nothing"),price);
		        SendClientMessage(playerid,COLOR_WINNER,string);
			    format(string,256,"%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d%s",GetRacerName(0),GetPVarInt(playerid,"BET0"),GetRacerName(1),GetPVarInt(playerid,"BET1"),GetRacerName(2),GetPVarInt(playerid,"BET2"),GetRacerName(3),GetPVarInt(playerid,"BET3"),GetRacerName(4),GetPVarInt(playerid,"BET4"),(PlayersCanRig==1)?("\nRig the Race"):(""));
				SetPVarInt(playerid,"DIALOG",1);
				ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Racer",string,"Select","Close");
				return 1;
		    }
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid,newkeys,oldkeys)
{
	if(RaceStep==0)
	{
		if(newkeys&KEY_SECONDARY_ATTACK)
		{
		    if(IsPlayerInRangeOfPoint(playerid,5.0,1107.177734,1525.321166,8.484739)||IsPlayerInRangeOfPoint(playerid,5.0,1083.677734,1525.320312,8.484739))
		    {
		        new string[256];
		        format(string,256,"%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d\n%s: $%d%s",GetRacerName(0),GetPVarInt(playerid,"BET0"),GetRacerName(1),GetPVarInt(playerid,"BET1"),GetRacerName(2),GetPVarInt(playerid,"BET2"),GetRacerName(3),GetPVarInt(playerid,"BET3"),GetRacerName(4),GetPVarInt(playerid,"BET4"),(PlayersCanRig==1)?("\nRig the Race"):(""));
				SetPVarInt(playerid,"DIALOG",1);
			    ShowPlayerDialog(playerid,USE_DIALOG_ID,DIALOG_STYLE_LIST,"Choose a Racer",string,"Select","Close");
			    return 1;
			}
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid,cmdtext[])
{
	if(!cmdtext[1])return 0;
	if(!strcmp(cmdtext[1],"gotoraces",true))
	{
	    SetPlayerPos(playerid,1095.321227,1545.773559,12);
	    return 1;
	}
	if(!strcmp(cmdtext[1],"bAddCash",true))
	{
		GivePlayerMoney(playerid,500);
	    return 1;
	}
	return 0;
}

public OnRaceEnd()
{
	for(new playerid;playerid<MAX_PLAYERS;playerid++)
	{
	    if(!IsPlayerConnected(playerid))continue;
	    new string[64];
	    new pvar[5];
	    format(pvar,5,"BET%d",RaceWinner);
	    SetPVarInt(playerid,pvar,GetPVarInt(playerid,pvar)*2);
	    if(GetPVarInt(playerid,pvar))
	    {
	        format(string,64,"You won $%d for betting on %s!",GetPVarInt(playerid,pvar),GetRacerName(RaceWinner));
	        SendClientMessage(playerid,COLOR_WINNER,string);
	        GivePlayerMoney(playerid,GetPVarInt(playerid,pvar));
		}
		for(new bet;bet<5;bet++)
		{
		    format(pvar,5,"BET%d",bet);
		    SetPVarInt(playerid,pvar,0);
		}
	}
	return 1;
}