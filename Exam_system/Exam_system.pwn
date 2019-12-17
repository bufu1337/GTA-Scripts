/*================================================================================================
				exams system by James_Alex,create your exam with desired
				   Questions and Answers, then give it to a player
==================================================================================================*/

//=======================================|Include|================================================//
#include <a_samp>
//=======================================|Defines|================================================//
#define COLOR_LIGHTRED 0xFF6347AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_WHITE 0xFFFFFFAA
//=======================================|Forwards|================================================//
forward FinishExam();
forward Score();
forward UpdateTextDraw();
forward ResetPlayer();
//=======================================|News|================================================//
//---------------------------------------|Exam|-----------------------------------------------//
new ExamCreated;
new ExamQuestions;
new EX;
new RP;
//---------------------------------------|Player|---------------------------------------------------//
new PlayerWroteFQ[MAX_PLAYERS];
new PlayerWroteSQ[MAX_PLAYERS];
new PlayerWroteTQ[MAX_PLAYERS];
new PlayerWroteFOQ[MAX_PLAYERS];
new PlayerWroteFIQ[MAX_PLAYERS];

new PlayerWroteFA[MAX_PLAYERS];
new PlayerWroteSA[MAX_PLAYERS];
new PlayerWroteTA[MAX_PLAYERS];
new PlayerWroteFOA[MAX_PLAYERS];
new PlayerWroteFIA[MAX_PLAYERS];

new PlayerWroteFN[MAX_PLAYERS];
new PlayerWroteSN[MAX_PLAYERS];
new PlayerWroteTN[MAX_PLAYERS];
new PlayerWroteFON[MAX_PLAYERS];
new PlayerWroteFIN[MAX_PLAYERS];

new PlayerSFE[MAX_PLAYERS];

new PlayerWroteR1Q[MAX_PLAYERS];
new PlayerWroteR2Q[MAX_PLAYERS];
new PlayerWroteR3Q[MAX_PLAYERS];
new PlayerWroteR4Q[MAX_PLAYERS];
new PlayerWroteR5Q[MAX_PLAYERS];

new A1[MAX_PLAYERS][256];
new A2[MAX_PLAYERS][256];
new A3[MAX_PLAYERS][256];
new A4[MAX_PLAYERS][256];
new A5[MAX_PLAYERS][256];

new pScore[MAX_PLAYERS];

new pCreateExam[MAX_PLAYERS];

new Float:X;
new Float:Y;
new Float:Z;
//---------------------------------------|Questions|------------------------------------------------//
new Exam1Q[256];
new Exam2Q[256];
new Exam3Q[256];
new Exam4Q[256];
new Exam5Q[256];
//---------------------------------------|Answers|-------------------------------------------------//
new Exam1A[256];
new Exam2A[256];
new Exam3A[256];
new Exam4A[256];
new Exam5A[256];
//---------------------------------------|Notes|-------------------------------------------------//
new Exam1N;
new Exam2N;
new Exam3N;
new Exam4N;
new Exam5N;

public OnFilterScriptInit()
{
	print("\n======================================");
	print(" exams_system Filterscript by James_Alex");
	print("======================================\n");

	SetTimer("UpdateTextDraw", 1000, 0);
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[256];
	new pName[MAX_PLAYER_NAME];

	if (strcmp("/createexam", cmdtext, true, 10) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
		    if(ExamCreated == 0)
		    {
				ExamCreated = 1;
				SendClientMessage(playerid, COLOR_YELLOW, "You succefully started creating an exam, now press 'T' or 'F6' and wrote your exam first question.");
				PlayerWroteFQ[playerid] = 1;
                pCreateExam[playerid] = 1;
			}
			else
			{
			    SendClientMessage(playerid, COLOR_LIGHTRED, "There is already an exam created !");
			    return 1;
			}
		}
		return 1;
	}
	if (strcmp("/startexam", cmdtext, true, 10) == 0)
	{
		if(IsPlayerConnected(playerid))
		{
			if(ExamCreated == 1)
			{
				if(PlayerSFE[playerid] == 0)
	    		{
					GetPlayerPos(playerid, X, Y, Z);
					SendClientMessage(playerid, COLOR_YELLOW, "now press 'T' or 'F6' and wrote the first reponse");
					format(string, sizeof(string), "1-%s", Exam1Q);
					SendClientMessage(playerid, COLOR_GREEN, string);
					PlayerSFE[playerid] = 1;
					PlayerWroteR1Q[playerid] = 1;
					TogglePlayerControllable(playerid, 0);
					return 1;
				}
     			else
     			{
     	    		SendClientMessage(playerid, COLOR_LIGHTRED, "You are already setting for an exam !");
     	    		return 1;
				}
		 	}
     		else
     		{
     	    	SendClientMessage(playerid, COLOR_LIGHTRED, "There aren't an exam to seat for it !");
     	    	return 1;
   	 		}
   	 	}
	}
	if (strcmp("/stopexam", cmdtext, true, 10) == 0)
	{
		if(pCreateExam[playerid] == 1)
		{
			GetPlayerName(playerid, pName, sizeof(pName));
			format(string, sizeof(string), "%s has stoped the exam", pName);
	    	SendClientMessage(playerid, COLOR_LIGHTRED, string);
	    	ExamCreated = 0;
	    }
	    else
	    {
	    	SendClientMessage(playerid, COLOR_LIGHTRED, "you haven't created an exam");
	    	return 1;
	    }
	}
	return 0;
}

public OnPlayerConnect(playerid)
{
	PlayerWroteFQ[playerid] = 0;
	PlayerWroteSQ[playerid] = 0;
	PlayerWroteTQ[playerid] = 0;
	PlayerWroteFOQ[playerid] = 0;
	PlayerWroteFIQ[playerid] = 0;
	PlayerWroteFA[playerid] = 0;
	PlayerWroteSA[playerid] = 0;
	PlayerWroteTA[playerid] = 0;
	PlayerWroteFOA[playerid] = 0;
	PlayerWroteFIA[playerid] = 0;
	PlayerSFE[playerid] = 0;
	PlayerWroteR1Q[playerid] = 0;
	PlayerWroteR2Q[playerid] = 0;
	PlayerWroteR3Q[playerid] = 0;
	PlayerWroteR4Q[playerid] = 0;
	PlayerWroteR5Q[playerid] = 0;
	pCreateExam[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	if(pCreateExam[playerid] == 1)
	{
		new plname[MAX_PLAYER_NAME];
		new string[256];
		GetPlayerName(playerid, plname, sizeof(plname));
		format(string, sizeof(string), "%s has disconnected, so the exam will finish.", plname);
		SendClientMessageToAll(COLOR_LIGHTRED, string);
		pCreateExam[playerid] = 0;
	    ExamCreated = 0;
        format(Exam1Q,256,"");
        format(Exam2Q,256,"");
        format(Exam3Q,256,"");
        format(Exam4Q,256,"");
        format(Exam5Q,256,"");
        format(Exam1A,256,"");
        format(Exam2A,256,"");
        format(Exam3A,256,"");
        format(Exam4A,256,"");
        format(Exam5A,256,"");
		return 1;
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[256];
	if(PlayerWroteFQ[playerid] == 1)
	{
		format(Exam1Q,256,"%s",text);
		PlayerWroteFQ[playerid] = 0;
        PlayerWroteFA[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's answer");
		ExamQuestions += 1;
		return 0;
	}
	else if(PlayerWroteFA[playerid] == 1)
	{
		format(Exam1A,256,"%s",text);
		PlayerWroteFA[playerid] = 0;
		PlayerWroteFN[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's note");
		return 0;
	}
	else if(PlayerWroteFN[playerid] == 1)
	{
		Exam1N = strval(text);
		if(Exam1N > 100) { SendClientMessage(playerid, COLOR_LIGHTRED, "don't go above 100 in one question !"); return 0; }
		PlayerWroteFN[playerid] = 0;
		PlayerWroteSQ[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the second question");
		return 0;
	}
	else if(PlayerWroteSQ[playerid] == 1)
	{
		format(Exam2Q,256,"%s",text);
		PlayerWroteSQ[playerid] = 0;
		PlayerWroteSA[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's answer");
		ExamQuestions += 1;
		return 0;
	}
	else if(PlayerWroteSA[playerid] == 1)
	{
		format(Exam2A,256,"%s",text);
		PlayerWroteSA[playerid] = 0;
		PlayerWroteSN[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's note");
		return 0;
	}
	else if(PlayerWroteSN[playerid] == 1)
	{
		Exam2N = strval(text);
		if(Exam2N+Exam1N > 100) { SendClientMessage(playerid, COLOR_LIGHTRED, "don't go above 100 in two questions !"); return 0; }
		PlayerWroteSN[playerid] = 0;
		PlayerWroteTQ[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the third question");
		return 0;
	}
	else if(PlayerWroteTQ[playerid] == 1)
	{
		format(Exam3Q,256,"%s",text);
		PlayerWroteTQ[playerid] = 0;
		PlayerWroteTA[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's answer");
		ExamQuestions += 1;
		return 0;
	}
	else if(PlayerWroteTA[playerid] == 1)
	{
		format(Exam3A,256,"%s",text);
		PlayerWroteTA[playerid] = 0;
		PlayerWroteTN[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's note");
		return 0;
	}
	else if(PlayerWroteTN[playerid] == 1)
	{
		Exam3N = strval(text);
		if(Exam2N+Exam1N+Exam3N > 100) { SendClientMessage(playerid, COLOR_LIGHTRED, "don't go above 100 in three questions !"); return 0; }
		PlayerWroteTN[playerid] = 0;
		PlayerWroteFOQ[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the fourth question");
		return 0;
	}
	else if(PlayerWroteFOQ[playerid] == 1)
	{
		format(Exam4Q,256,"%s",text);
		PlayerWroteFOQ[playerid] = 0;
		PlayerWroteFOA[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's answer");
		ExamQuestions += 1;
		return 0;
	}
	else if(PlayerWroteFOA[playerid] == 1)
	{
		format(Exam4A,256,"%s",text);
		PlayerWroteFOA[playerid] = 0;
		PlayerWroteFON[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's note");
		return 0;
	}
	else if(PlayerWroteFON[playerid] == 1)
	{
		Exam4N = strval(text);
		if(Exam2N+Exam1N+Exam3N+Exam4N > 100) { SendClientMessage(playerid, COLOR_LIGHTRED, "don't go above 100 in four questions !"); return 0; }
		PlayerWroteFON[playerid] = 0;
		PlayerWroteFIQ[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the fivth question");
		return 0;
	}
	else if(PlayerWroteFIQ[playerid] == 1)
	{
		format(Exam5Q,256,"%s",text);
		PlayerWroteFIQ[playerid] = 0;
		PlayerWroteFIA[playerid] = 1;
        SendClientMessage(playerid, COLOR_YELLOW, "now wrote the question's answer");
		ExamQuestions += 1;
		return 0;
	}
	else if(PlayerWroteFIA[playerid] == 1)
	{
		format(Exam5A,256,"%s",text);
		PlayerWroteFIA[playerid] = 0;
		PlayerWroteFIN[playerid] = 1;
		SendClientMessageToAll(COLOR_YELLOW, "now wrote the question's note");
		return 0;
	}
	else if(PlayerWroteFIN[playerid] == 1)
	{
		new plname[MAX_PLAYER_NAME];
	//	new string[256];
		Exam5N = strval(text);
		if(Exam2N+Exam1N+Exam3N+Exam4N+Exam5N > 100) { SendClientMessage(playerid, COLOR_LIGHTRED, "don't go above 100 in five questions !"); return 0; }
		PlayerWroteFIN[playerid] = 0;
		GetPlayerName(playerid, plname, sizeof(plname));
		format(string, sizeof(string), "%s has created an exam, (/startexam) to seat for it.", plname);
		SendClientMessageToAll(COLOR_GREEN, string);
		return 0;
	}
    else if(PlayerWroteR1Q[playerid] == 1)
	{
		PlayerWroteR1Q[playerid] = 0;
		format(A1[playerid],256,"%s",text);
		if(ExamQuestions > 1)
		{
		PlayerWroteR2Q[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "now answer the second");
		format(string, sizeof(string), "2-%s", Exam2Q);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 0;
		}
		else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "you have finished the exam, wait a few seconds to see your result");
		EX = SetTimerEx("FinishExam", 5000, 0, "d", playerid);
		return 0;
		}
	}
 	else if(PlayerWroteR2Q[playerid] == 1)
	{
		PlayerWroteR2Q[playerid] = 0;
		format(A2[playerid],256,"%s",text);
		if(ExamQuestions > 2)
		{
		PlayerWroteR3Q[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "now answer the third");
		format(string, sizeof(string), "3-%s", Exam3Q);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 0;
		}
		else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "you have finished the exam, wait a few seconds to see your result");
		EX = SetTimerEx("FinishExam", 5000, 0, "d", playerid);
		return 0;
		}
	}
 	else if(PlayerWroteR3Q[playerid] == 1)
	{
		PlayerWroteR3Q[playerid] = 0;
		format(A3[playerid],256,"%s",text);
		if(ExamQuestions > 3)
		{
		PlayerWroteR4Q[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "now answer the fourth");
		format(string, sizeof(string), "4-%s", Exam4Q);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 0;
		}
		else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "you have finished the exam, wait a few seconds to see your result");
		EX = SetTimerEx("FinishExam", 5000, 0, "d", playerid);
		return 0;
		}
	}
 	else if(PlayerWroteR4Q[playerid] == 1)
	{
		PlayerWroteR4Q[playerid] = 0;
		format(A4[playerid],256,"%s",text);
		if(ExamQuestions > 4)
		{
		PlayerWroteR5Q[playerid] = 1;
		SendClientMessage(playerid, COLOR_YELLOW, "now answer the fiveth");
		format(string, sizeof(string), "5-%s", Exam5Q);
		SendClientMessage(playerid, COLOR_GREEN, string);
		return 0;
		}
		else
		{
		SendClientMessage(playerid, COLOR_YELLOW, "you have finished the exam, wait a few seconds to see your result");
		EX = SetTimerEx("FinishExam", 5000, 0, "d", playerid);
		return 0;
		}
	}
 	else if(PlayerWroteR5Q[playerid] == 1)
	{
		PlayerWroteR5Q[playerid] = 0;
		format(A5[playerid],256,"%s",text);
		SendClientMessage(playerid, COLOR_YELLOW, "you have finished the exam, wait a few seconds to see your result");
		EX = SetTimerEx("FinishExam", 5000, 0, "d", playerid);
		return 0;
	}
	return 1;
}

public Score()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if(strcmp(A1[i], Exam1A, true) == 0)
		{
	    	pScore[i] += Exam1N;
		}
		if(strcmp(A2[i], Exam2A, true) == 0)
		{
	    	pScore[i] += Exam2N;
		}
		if(strcmp(A3[i], Exam3A, true) == 0)
		{
	    	pScore[i] += Exam3N;
		}
		if(strcmp(A4[i], Exam4A, true) == 0)
		{
	    	pScore[i] += Exam4N;
		}
		if(strcmp(A5[i], Exam5A, true) == 0)
		{
	    	pScore[i] += Exam5N;
		}
	}
	return 1;
}

public FinishExam()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	Score();
	PlayerSFE[i] = 0;
	new string[256];
	format(string, sizeof(string), "your score is %d/100", pScore[i]);
 	SendClientMessage(i, COLOR_WHITE, string);
 	KillTimer(EX);
 	PlayerSFE[i] = 0;
 	RP = SetTimerEx("ResetPlayer", 5000, 0, "d", i);
	return 1;
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_SECONDARY_ATTACK)
	{
	    if(PlayerWroteFQ[playerid] == 1 || PlayerWroteSQ[playerid] == 1 || PlayerWroteTQ[playerid] == 1 || PlayerWroteFOQ[playerid] == 1 || PlayerWroteFIQ[playerid] == 1)
	    {
			new plname[MAX_PLAYER_NAME];
			new string[256];
			GetPlayerName(playerid, plname, sizeof(plname));
			format(string, sizeof(string), "%s has created an exam, (/startexam) to seat for it.", plname);
			SendClientMessageToAll(COLOR_GREEN, string);
			PlayerWroteFQ[playerid] = 0;
			PlayerWroteSQ[playerid] = 0;
			PlayerWroteTQ[playerid] = 0;
			PlayerWroteFOQ[playerid] = 0;
			PlayerWroteFIQ[playerid] = 0;
		}
	}
	return 1;
}

public ResetPlayer()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
	KillTimer(RP);
	pScore[i] = 0;
	format(A1[i], 256, "");
	format(A2[i], 256, "");
	format(A3[i], 256, "");
	format(A4[i], 256, "");
	format(A5[i], 256, "");
	TogglePlayerControllable(i, 1);
	SetPlayerPos(i, X, Y, Z);
	return 1;
	}
	return 1;
	
}
/*================================================================================================
		 								Finish, Enjoy
==================================================================================================*/


