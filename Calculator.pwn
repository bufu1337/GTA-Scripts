#include <a_samp>

//Peach Colour
#define COLOUR 0xFF8080FF

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

new IsWaiting[MAX_PLAYERS], Number1, Number2, What[5], total;

public OnPlayerSpawn(playerid)
{
	SendClientMessage(playerid, COLOUR, "[CALCULATOR] Type /calc to see the calculator commands");
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(IsWaiting[playerid] == 1)
	{
		Number1 = strval(text);
		IsWaiting[playerid] = 2;
		SendClientMessage(playerid, COLOUR, "Now enter your operator");
		SendClientMessage(playerid, COLOUR, "+ (Add) | - (Subtract) | * (Multiply) | _ (Divide)");
		return 0;
	}
	else if(IsWaiting[playerid] == 2)
	{
		if(sizeof(What) > strlen(text))
		{
			strdel(What, 0, 5);
			strins(What, text, 0, sizeof(What));
			IsWaiting[playerid] = 3;
			SendClientMessage(playerid, COLOUR, "Now enter your second number");
		}
		else
		{
			SendClientMessage(playerid, COLOUR, "Calculation Failed, incorrect operator");
			IsWaiting[playerid] = 0;
		}
		return 0;
	}
	else if(IsWaiting[playerid] == 3)
	{
	    Number2 = strval(text);
	    IsWaiting[playerid] = 0;
	    SendClientMessage(playerid, COLOUR, "Thank You!");
	    if(strcmp(What, "+") == 0)
	    {
	        total = Number1 + Number2;
	    }
	    else if(strcmp(What, "-") == 0)
	    {
	        total = Number1 - Number2;
	    }
	    else if(strcmp(What, "*") == 0)
	    {
			total = Number1 * Number2;
	    }
	    else if(strcmp(What, "_") == 0)
	    {
	        total = Number1 / Number2;
	    }
		new string[128];
		format(string, sizeof(string), "Your calculation: %i %s %i equals %i", Number1, What, Number2, total);
		SendClientMessage(playerid, COLOUR, string);
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(calc, 4, cmdtext);
	dcmd(calculate, 9, cmdtext);
	return 1;
}

dcmd_calc(playerid, params[])
{
	SendClientMessage(playerid, COLOUR, "[CALCULATOR]");
	SendClientMessage(playerid, COLOUR, "This calculator can perform basic calculator functions");
	SendClientMessage(playerid, COLOUR, "Add, Subtract, Multiply and Divide");
	SendClientMessage(playerid, COLOUR, "Use /calculate to activate the 'calculator'");
	#pragma unused params
	return 1;
}

dcmd_calculate(playerid, params[])
{
	SendClientMessage(playerid, COLOUR, "[CALCULATOR]");
	SendClientMessage(playerid, COLOUR, "To begin your calculation, type a number and press enter");
	#pragma unused params
	IsWaiting[playerid] = 1;
}