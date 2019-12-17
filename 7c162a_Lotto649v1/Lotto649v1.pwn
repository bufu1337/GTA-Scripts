/*
Lotto 6/49
Version one
By Zezombia
*/

#include <a_samp>

#define FILTERSCRIPT
#if defined FILTERSCRIPT

#define yellow 0xFFFF00AA
#define red 0xFF0000AA
#define green 0x33FF33AA

new HaveTicket[MAX_PLAYERS];
new PlayerNumber[6][MAX_PLAYERS];
new Number[6];

forward TicketDraw();

public OnFilterScriptInit()
{
	SetTimer("TicketDraw", 600000, 1);
	return 1;
}

#endif

public OnPlayerConnect(playerid)
{
	HaveTicket[playerid] = 0;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/BuyTicket", cmdtext, true) == 0)
	{
		if(HaveTicket[playerid] == 1) return SendClientMessage(playerid, red, "You already have a Lotto 6/49 ticket");
		if(GetPlayerMoney(playerid) < 1) return SendClientMessage(playerid, red, "Lotto 6/49 tickets are $1");

		GivePlayerMoney(playerid, -1);
		HaveTicket[playerid] = 1;
		MakePlayerNumber(playerid);

		new string[256];
		format(string, sizeof(string), "Your Lotto 6/49 numbers are: %d, %d, %d, %d, %d, %d", PlayerNumber[0][playerid], PlayerNumber[1][playerid], PlayerNumber[2][playerid], PlayerNumber[3][playerid], PlayerNumber[4][playerid], PlayerNumber[5][playerid]);
		SendClientMessage(playerid, yellow, string);
		return 1;
	}
	if (strcmp("/MyTicket", cmdtext, true) == 0)
	{
		if(HaveTicket[playerid] == 0) return SendClientMessage(playerid, red, "You do not have a Lotto 6/49 ticket");

		new string[256];
		format(string, sizeof(string), "Your Lotto 6/49 numbers are: %d, %d, %d, %d, %d, %d", PlayerNumber[0][playerid], PlayerNumber[1][playerid], PlayerNumber[2][playerid], PlayerNumber[3][playerid], PlayerNumber[4][playerid], PlayerNumber[5][playerid]);
		SendClientMessage(playerid, yellow, string);
		return 1;
	}
	if (strcmp("/LottoTest", cmdtext, true) == 0)
	{
		if(IsPlayerAdmin(playerid) == 0) return 0;

		TicketDraw();
		return 1;
	}
	return 0;
}

public TicketDraw()
{
	MakeNumber();
	new Winning[MAX_PLAYERS];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(HaveTicket[i] == 1)
		{
			for(new n = 0; n < 6; n++)
			{
				if(PlayerNumber[0][i] == Number[n])
				{
					Winning[i]++;
				}
				if(PlayerNumber[1][i] == Number[n])
				{
					Winning[i]++;
				}
				if(PlayerNumber[2][i] == Number[n])
				{
					Winning[i]++;
				}
				if(PlayerNumber[3][i] == Number[n])
				{
					Winning[i]++;
				}
				if(PlayerNumber[4][i] == Number[n])
				{
					Winning[i]++;
				}
				if(PlayerNumber[5][i] == Number[n])
				{
					Winning[i]++;
				}
			}
			new string[256];

			SendClientMessage(i, green, "=== Lotto 6/47 ===");

			format(string, sizeof(string), "Your Lotto 6/49 numbers: %d, %d, %d, %d, %d, %d", PlayerNumber[0][i], PlayerNumber[1][i], PlayerNumber[2][i], PlayerNumber[3][i], PlayerNumber[4][i], PlayerNumber[5][i]);
			SendClientMessage(i, green, string);

			format(string, sizeof(string), "The winning Lotto 6/49 numbers: %d, %d, %d, %d, %d, %d", Number[0], Number[1], Number[2], Number[3], Number[4], Number[5]);
			SendClientMessage(i, green, string);

			if(Winning[i] == 0)
			{
				SendClientMessage(i, green, "You got 0 correct");
				SendClientMessage(i, green, "Earnings: $0");
			}
			if(Winning[i] == 1)
			{
				SendClientMessage(i, green, "You got 1 correct");
				SendClientMessage(i, green, "Earnings: $5");
				GivePlayerMoney(i, 5);
			}
			if(Winning[i] == 2)
			{
				SendClientMessage(i, green, "You got 2 correct");
				SendClientMessage(i, green, "Earnings: $10");
				GivePlayerMoney(i, 10);
			}
			if(Winning[i] == 3)
			{
				SendClientMessage(i, green, "You got 3 correct");
				SendClientMessage(i, green, "Earnings: $63");
				GivePlayerMoney(i, 63);
			}
			if(Winning[i] == 4)
			{
				SendClientMessage(i, green, "You got 4 correct");
				SendClientMessage(i, green, "Earnings: $1,730");
				GivePlayerMoney(i, 1730);
			}
			if(Winning[i] == 5)
			{
				SendClientMessage(i, green, "You got 5 correct");
				SendClientMessage(i, green, "Earnings: $65,128");
				GivePlayerMoney(i, 65128);
			}
			if(Winning[i] == 6)
			{
				SendClientMessage(i, green, "You got 6 correct");
				SendClientMessage(i, green, "Earnings: $32,000,000");
				GivePlayerMoney(i, 32000000);
			}
			HaveTicket[i] = 0;
		}
	}
}

MakeNumber()
{
	Number[0] = random(99);
	Number[1] = random(99);
	Number[2] = random(99);
	Number[3] = random(99);
	Number[4] = random(99);
	Number[5] = random(99);
}

MakePlayerNumber(playerid)
{
	PlayerNumber[0][playerid] = random(99);
	PlayerNumber[1][playerid] = random(99);
	PlayerNumber[2][playerid] = random(99);
	PlayerNumber[3][playerid] = random(99);
	PlayerNumber[4][playerid] = random(99);
	PlayerNumber[5][playerid] = random(99);
}
