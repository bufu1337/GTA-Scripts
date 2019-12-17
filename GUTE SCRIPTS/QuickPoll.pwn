#include <a_samp>
#define COLOR_ERROR 0x9999CCFF
#define COLOR_START 0xCC9999FF
#define COLOR_QUESTION 0x99CC99FF
#define COLOR_ANSWERS 0xCC99CCFF
#define MAX_ANSWERS 5 //Adjustable! 5 is maximum with line adjustment command (forgot what it was)
#define MAX_ANSWER_SIZE 30
#define DIALOG_ID 2010 //2.1~ billion
#define DIALOG_NONE 0
#define DIALOG_START_POLL 1
#define DIALOG_SET_ANSWERS 2
#define DIALOG_SET_TIME 3
#define DIALOG_VOTE 4
forward StartPoll();
forward EndPoll();
new gQuestion[1024];
new pVote[MAX_PLAYERS]={-1,...}; //0 = not voted, otherwise vote=answer
new gAnswer[MAX_ANSWERS][MAX_ANSWER_SIZE];
new gTimeRemaining; //In seconds
new PollLeader=INVALID_PLAYER_ID; //The player id of the person starting the poll, only s/he can stop the poll.
new LeaderStep;
public OnPlayerDisconnect(playerid)
{
	pVote[playerid]=-1;
	if(playerid==PollLeader)EndPoll();
	return 1;
}
public OnPlayerCommandText(playerid,cmdtext[])
{
	if(!strcmp(cmdtext[1],"startpoll",true))
	{
	    if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid,COLOR_ERROR,"    You do not obtain the authority to begin a poll.");
	    if(PollLeader!=INVALID_PLAYER_ID)return SendClientMessage(playerid,COLOR_ERROR,"    A poll has already begun or is in the midst of being created.");
	    PollLeader=playerid;
	    ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Question","Type in question of your poll.","Continue","Cancel");
	    LeaderStep=DIALOG_START_POLL;
	    new pname[MAX_PLAYER_NAME];
	    GetPlayerName(playerid,pname,sizeof(pname));
	    printf("\t%s has begun creating a poll.",pname);
	    return 1;
	}
	if(!strcmp(cmdtext[1],"vote",true))
	{
	    if(LeaderStep!=DIALOG_VOTE)return SendClientMessage(playerid,COLOR_ERROR,"    No poll is currently active.");
	    if(pVote[playerid]>-1)return SendClientMessage(playerid,COLOR_ERROR,"    You have already voted.");
	    new list[MAX_ANSWER_SIZE*MAX_ANSWERS];
	    new answers;
	    while(gAnswer[answers][0])
	    {
	        format(list,sizeof(list),"%s(%d)%s\n",list,answers+1,gAnswer[answers]);
	        answers++;
			if(answers==MAX_ANSWERS)break;
	    }
	    ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_LIST,"Vote",list,"Vote","Close");
	    return 1;
	}
	if(!strcmp(cmdtext[1],"cancel",true))
	{
	    if(!IsPlayerAdmin(playerid))return SendClientMessage(playerid,COLOR_ERROR,"    You do not obtain the authority to cancel a poll.");
	    if(LeaderStep!=DIALOG_VOTE)return SendClientMessage(playerid,COLOR_ERROR,"    No poll is currently active.");
	    new pname[MAX_PLAYER_NAME];
	    GetPlayerName(playerid,pname,sizeof(pname));
	    printf("\t%s ended a poll prematurely.",pname);
	    EndPoll();
	    return 1;
	}
	if(!strcmp(cmdtext[1],"pollhelp",true))
	{
	    if(IsPlayerAdmin(playerid))
	    {
	        SendClientMessage(playerid,COLOR_ANSWERS,"/StartPoll -- If no poll is active, gives dialog sequence to begin a poll.");
	        SendClientMessage(playerid,COLOR_ANSWERS,"/Cancel -- If a poll is active, ends a poll prematurely.");
	    }
        SendClientMessage(playerid,COLOR_ANSWERS,"/Vote -- If a poll is active, gives you the voting dialog.");
        return 1;

	}
	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid!=DIALOG_ID)return 1;
	switch(LeaderStep)
	{
	    case DIALOG_START_POLL:
	    {
			if(playerid!=PollLeader)return 1;
	        if(!response)
	        {
	            PollLeader=INVALID_PLAYER_ID;
	            LeaderStep=DIALOG_NONE;
	        }else{
	            LeaderStep=DIALOG_SET_ANSWERS;
	            ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 1","Type in the first answer.","Continue","Back");
	            format(gQuestion,sizeof(gQuestion),"%s",inputtext);
	        }
	    }
	    case DIALOG_SET_ANSWERS:
	    {
			if(playerid!=PollLeader)return 1;
	        new answer;
			while(gAnswer[answer][0])answer++;
			if(answer>1)
			{
			    if(!response)
			    {
			        gAnswer[answer-1][0]=0;
				    new tmp[128];
				    if(answer>2)
				    {
					    format(tmp,sizeof(tmp),"Answer %d",answer);
					    ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,tmp,"Type in an answer.\n(type nothing to pass)","Continue","Back");
				    }else{
         				ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 2","Type in the second answer.","Continue","Back");
				    }
			        return 1;
			    }
			    if(!inputtext[0])
			    {
			        LeaderStep=DIALOG_SET_TIME;
			        ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Time","Type in how long the poll will last.\n(in seconds)","Start Poll","Back");
			        return 1;
			    }
			    answer++;
			    format(gAnswer[answer-1],MAX_ANSWER_SIZE,"%s",inputtext);
			    if(answer==MAX_ANSWERS)
			    {
			        LeaderStep=DIALOG_SET_TIME;
			        ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Time","Type in how long the poll will last.\n(in seconds)","Start Poll","Back");
			        return 1;
			    }
			    new tmp[128];
			    format(tmp,sizeof(tmp),"Answer %d",answer+1);
			    ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,tmp,"Type in an answer.\n(type nothing to pass)","Continue","Back");
			    return 1;
			}else{
			    if(!response)
			    {
			        if(!gAnswer[0][0])
			        {
			            LeaderStep=DIALOG_START_POLL;
	    				ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Question","Type in question of your poll.","Continue","Cancel");
			        }else{
						gAnswer[0][0]=0;
	            		ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 1","Type in the first answer.","Continue","Back");
			        }
			        return 1;
			    }
			    if(!gAnswer[0][0])
			    {
			        format(gAnswer[0],MAX_ANSWER_SIZE,"%s",inputtext);
         			ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 2","Type in the second answer.","Continue","Back");
			    }else{
			        format(gAnswer[1],MAX_ANSWER_SIZE,"%s",inputtext);
         			ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 3","Type in an answer.\n(type nothing to pass)","Continue","Back");
			    }
			    return 1;
			}
	    }
	    case DIALOG_SET_TIME:
	    {
			if(playerid!=PollLeader)return 1;
	        if(!response)
	        {
		        new answer;
		        LeaderStep=DIALOG_SET_ANSWERS;
				while(gAnswer[answer][0]){printf("%s",gAnswer[answer]);answer++;}
		        gAnswer[answer-1][0]=0;
				new tmp[128];
				if(answer>2)
				{
				    format(tmp,sizeof(tmp),"Answer %d",answer);
				    ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,tmp,"Type in an answer.\n(type nothing to pass)","Continue","Back");
			    }else{
       				ShowPlayerDialog(playerid,DIALOG_ID,DIALOG_STYLE_INPUT,"Answer 2","Type in the second answer.","Continue","Back");
			    }
		        return 1;
			}else{
			    gTimeRemaining=strval(inputtext);
			    StartPoll();
			    SendClientMessageToAll(COLOR_START,"A poll has begun!");
			    SendClientMessageToAll(COLOR_START,"______________________________");
			    SendClientMessageToAll(COLOR_QUESTION,gQuestion);
			    SendClientMessageToAll(COLOR_START,"______________________________");
			    new o;
				new answertext[MAX_ANSWER_SIZE+3];
			    while(gAnswer[o][0])
				{
				    format(answertext,sizeof(answertext),"(%d)%s",o+1,gAnswer[o]);
					SendClientMessageToAll(COLOR_ANSWERS,answertext);
					o++;
					if(o==MAX_ANSWERS)break;
				}
			    LeaderStep=DIALOG_VOTE;
			    SetTimer("StartPoll",1000,0);
			    new pname[MAX_PLAYER_NAME];
			    GetPlayerName(playerid,pname,sizeof(pname));
			    printf("[Poll Begin] %s has begun a poll.",pname);
			}
	    }
	    case DIALOG_VOTE:
	    {
	        if(!response)return 1;
	        pVote[playerid]=listitem;
			SendClientMessage(playerid,COLOR_QUESTION,"Vote successful!");
	    }
	}
	return 1;
}
public StartPoll()
{
	if(PollLeader==INVALID_PLAYER_ID)return;
	if(gTimeRemaining)
	{
		gTimeRemaining--;
		SetTimer("StartPoll",1000,0);
	}else EndPoll();
	return;
}
public EndPoll()
{
	new answers[MAX_ANSWERS];
	new totalanswers;
	new top=-1;
	new answer;
	new winmessage[128];
	for(new o; o< MAX_PLAYERS; o++)
	{
		if(IsPlayerConnected(o))
		{
		    if(pVote[o]>-1){answers[pVote[o]]++;totalanswers++;}
		    pVote[o]=-1;
		}
	}
	while(gAnswer[answer][0])
	{
	    if((top==-1)||(answers[top]<answers[answer]))top=answer;
		answer++;
		if(answer==MAX_ANSWERS)break;
	}
	if(answers[top]==0)format(winmessage,sizeof(winmessage),"No one voted!");
	else format(winmessage,sizeof(winmessage),"\"(%d)%s\" obtained the most votes with %d votes!",top+1,gAnswer[top],answers[top]);
	SendClientMessageToAll(COLOR_START,"The poll has ended!");
	SendClientMessageToAll(COLOR_QUESTION,winmessage);
	printf("[Poll Ended] %s",winmessage);
	format(gQuestion,sizeof(gQuestion),"");
	PollLeader=INVALID_PLAYER_ID;
	LeaderStep=DIALOG_NONE;
	answer=0;
	gTimeRemaining=0;
	while(gAnswer[answer][0])
	{
		format(gAnswer[answer],MAX_ANSWER_SIZE,"");
		answer++;
        if(answer==MAX_ANSWERS)break;
	}
	return;
}
