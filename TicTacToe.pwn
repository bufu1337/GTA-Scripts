#include <a_samp>

#define kmd(%1)	if(!strcmp(%1,cmd,true))
#define if_%1()	if(!strcmp(%1,cmd,true))

#define CheckStarted(); \
    if(started == J)\
	{\
		print("The game is already runing, type \"exitgame\" to start a new game later");\
		return 1;\
	}

#define Z        (0)
#define J        (1)

#define X 		 (11)
#define O 		 (12)

#define N 		 (-1)

#define easy 	 (0)
#define normal   (1)
#define hard 	 (2)

#define D        (10)

#define s_edge   (0)
#define s_center (1)
#define s_corner (2)

new
	 started
	,movecount = 0
	,enemymovecount = 0
	,diff
	,strategy = N
	,side
	,block[9]
	,win
	,ai
	,winblock[8][3] =
	{
		{0,1,2},
		{3,4,5},
		{6,7,8},
		{0,3,6},
		{1,4,7},
		{2,5,8},
		{2,4,6},
		{0,4,8}
	}
;

public OnFilterScriptInit()
{
	print("Welcome to PAWN-tic-tac-toe");
	print("Choose your side:(type X or O [and all other commands] in console without the \"/\" character)");

	print("+------------+-----------+");
	print("|     X      |     O     |");
	print("+-------+----+---+-------+");
	print("|   XX  |   OO   |  XX   |");
	print("|   XX  |   OO   |  XX   |");
	print("+-------+--------+-------+");
	print("|   OO  |   XX   |  OO   |");
	print("|   OO  |   XX   |  OO   |");
	print("+-------+--------+-------+");
	print("|   XX  |   OO   |  XX   |");
	print("|   XX  |   OO   |  XX   |");
	print("+-------+--------+-------+");

	started   = Z;
	diff      = normal;

	block[0]  = N;
	block[1]  = N;
	block[2]  = N;
	block[3]  = N;
	block[4]  = N;
	block[5]  = N;
	block[6]  = N;
	block[7]  = N;
	block[8]  = N;

	win       = N;
	ai        = J;
	side      = X;
	strategy  = N;

	movecount = 0;
	enemymovecount = 0;

	return 1;
}

forward Reset();
public Reset()
{
	print("Welcome to PAWN-tic-tac-toe");
	print("Choose your side:(type X or O [and all other commands] in console without the \"/\" character)");

	print("+------------+-----------+");
	print("|     X      |     O     |");
	print("+-------+----+---+-------+");
	print("|   XX  |   OO   |  XX   |");
	print("|   XX  |   OO   |  XX   |");
	print("+-------+--------+-------+");
	print("|   OO  |   XX   |  OO   |");
	print("|   OO  |   XX   |  OO   |");
	print("+-------+--------+-------+");
	print("|   XX  |   OO   |  XX   |");
	print("|   XX  |   OO   |  XX   |");
	print("+-------+--------+-------+");

	started   = Z;
	diff      = normal;

	block[0]  = N;
	block[1]  = N;
	block[2]  = N;
	block[3]  = N;
	block[4]  = N;
	block[5]  = N;
	block[6]  = N;
	block[7]  = N;
	block[8]  = N;

	win       = N;
	ai        = J;
	side      = X;
	strategy  = N;

	movecount = 0;
	enemymovecount = 0;

	return 1;
}

public OnRconCommand(cmd[])
{

	kmd("human")
	{
	    CheckStarted();

		ai = Z;
		side = X;
	    print("You have chosen the Human VS Human Mode, type \"startgame\" to start the game");
	    return 1;
	}

	kmd("ai")
	{
	    CheckStarted();

		ai = J;
	    print("You have chosen the Human VS AI Mode, type \"startgame\" to start the game");
	    return 1;
	}

	kmd("X")
	{
	    CheckStarted();

		side = X;
	    print("You have chosen \"X\" as your side, type \"startgame\" to start the game");
	    return 1;
	}

	kmd("O")
	{
	    CheckStarted();

	    side = O;
	    print("You have chosen \"O\" as your side, type \"startgame\" to start the game");
	    print("WARNING: Chosing O as first side enables Human VS AI mode! Human VS Human disabled.");
	    ai = J;
	    return 1;
	}

	kmd("easy")
	{
	    CheckStarted();

		diff = easy;
	    print("You have chosen \"EASY\" , type \"startgame\" to start the game");
	    return 1;
	}

	kmd("normal")
	{
	    CheckStarted();

		diff = normal;
	    print("You have chosen \"NORMAL\" , type \"startgame\" to start the game");
	    return 1;
	}

	kmd("hard")
	{
	    CheckStarted();

		diff = hard;
	    print("You have chosen \"HARD\" , type \"startgame\" to start the game");
	    return 1;
	}

	kmd("startgame")
	{
	    if(side == N)return print("Choose a side first! (\"X\" or \"O\")");

	    CheckStarted();

		started = J;

		if(side == X)
		{
		    DrawBoard();
		    print("Choose a number to place your X");
		}
		else
		if(side == O)
		{
		    PlaceEnemy();

		    print("Choose a number to place your O");
		}
	    return 1;
	}

	kmd("exitgame")
	{
		Reset();
	    return 1;
	}

	for(new i; i < 9; i++)
	{
	    new command[256];
	    format(command,256,"%d",i+1);
		kmd(command)
		{
		    if(started == Z)
			{
				print("The game is not running, type \"startgame\" to start a new game");
				return 1;
		    }

		    PlaceMe(i);
		    return 1;
		}
	}

	return 1;
}

forward PlaceMe(field);
public PlaceMe(field)
{
	if(block[field] != (N))return print("The chosen field is already taken, choose another one");

	if(side == X)block[field] = X;
	else
	if(side == O)block[field] = O;

	printf("You have chosen \"%d\" , object has been placed",field+1);

	movecount++;

	DrawBoard();

	win = CheckWinner();

	if(win == X)
	{
		print("End of game, resetting all... Please start a new game :)");
 		print("---X--- HAS WON THE GAME!! :)");
		Reset();
	}
	else
	if(win == O)
	{
		print("End of game, resetting all... Please start a new game :)");
		print("---O--- HAS WON THE GAME!! :)");
		Reset();
	}
	else
	if(win == D)
	{
		print("End of game, resetting all... Please start a new game :)");
        print("Nobody has won... :P");
        Reset();
	}
	else
	{
	    if(ai == J)
		{
			PlaceEnemy();
		}
		else
		{
		    print("Next side turn, please choose a number");
		    if(side == X)
			{
		        side = O;
		        return O;
			}
			else
			{
			    side = X;
			    return X;
			}
		}
	}
	return 5;
}

forward PlaceEnemy();
public PlaceEnemy()
{
    enemymovecount++;
	print("Enemy turn...");
	if(side == X)
	{
	    if(diff == easy)
		{
			EasyPlace(O);
	    }
		else if(diff == normal)
		{
			NormalPlace(O);
	    }
	    else if(diff == hard)
	    {
	        HardPlace(O);
	    }
	}
	else
	if(side == O)
	{
	    if(diff == easy)
		{
			EasyPlace(X);
	    }
		else if(diff == normal)
		{
			NormalPlace(X);
	    }
	    else if(diff == hard)
	    {
			HardPlace(X);
	    }
	}

	DrawBoard();
	win = CheckWinner();

	if(win == X)
	{
		print("End of game, resetting all... Please start a new game :)");
 		print("---X--- HAS WON THE GAME!! :)");
		Reset();
	}
	else
	if(win == O)
	{
		print("End of game, resetting all... Please start a new game :)");
		print("---O--- HAS WON THE GAME!! :)");
		Reset();
	}
	else
	if(win == D)
	{
		print("End of game, resetting all... Please start a new game :)");
        print("Nobody has won... :P");
        Reset();
	}

	return 1;
}

forward DrawBoard();
public DrawBoard()
{
	print("+-------+");

	new
		 string[3][10]
		,_char
		,pos
		,index
		;

	format(string[0],10,"| 1 2 3 |");
	format(string[1],10,"| 4 5 6 |");
	format(string[2],10,"| 7 8 9 |");

	for(new d; d < 3; d++)
	{
		for(new i; i < 3; i++)
		{
		    index = i+(d*3);
		    pos = ((i*2)+2);
		    if(block[index] == X)
			{
				_char = 'X';
				string[d][pos] = _char;
			}
			else if(block[index] == O)
		    {
				_char = 'O';
				string[d][pos] = _char;
			}
		}
		print(string[d]);
	}

	print("+-------+");
}

forward CheckWinner();
public CheckWinner()
{
	for(new i; i < 8; i++)
	{
	    if(block[(winblock[i][0])] == X && block[(winblock[i][1])] == X && block[(winblock[i][2])] == X)return X;
	    if(block[(winblock[i][0])] == O && block[(winblock[i][1])] == O && block[(winblock[i][2])] == O)return O;
	}

	if(
		(block[0] != (N)) &&
		(block[1] != (N)) &&
		(block[2] != (N)) &&
		(block[3] != (N)) &&
		(block[4] != (N)) &&
		(block[5] != (N)) &&
		(block[6] != (N)) &&
		(block[7] != (N)) &&
		(block[8] != (N))
	)
	return D;

	return N;
}

forward IsFieldClear();
public IsFieldClear()
{
	for(new i; i < 9; i++)if(block[i] != N)return 0;
	return 1;
}

forward EasyPlace(param);
public EasyPlace(param)//theoretically possible infite loop so watch out.
{
    new rand;
    begin:
    rand = random(9);
    if(block[rand] == N)block[rand] = param;else
	goto begin;//because of this
}

forward NormalPlace(param);
public NormalPlace(param)
{
	new tryblock;
	if(param == X)
	{
		tryblock = EstimateWinblock(X);

		if(tryblock != N && block[tryblock] == N)
		{
		    block[tryblock] = X;
		}
		else
		{
			tryblock = EstimateWinblock(O);
			if(tryblock != N && block[tryblock] == N)
			{
			    block[tryblock] = X;
			}
			else
			{
				EasyPlace(X);
			}
		}
	}
	else if(param == O)
	{
		tryblock = EstimateWinblock(O);

		if(tryblock != N && block[tryblock] == N)
		{
		    block[tryblock] = O;
		}
		else
		{
			tryblock = EstimateWinblock(X);
			if(tryblock != N && block[tryblock] == N)
			{
			    block[tryblock] = O;
			}
			else
			{
				EasyPlace(O);
			}
		}
	}
}

forward IsEdge(_block);
public IsEdge(_block)
{
	if(_block == 1 || _block == 3 || _block == 5 || _block == 7)return J;
	return Z;
}

forward IsCorner(_block);
public IsCorner(_block)
{
	if(_block == 0 || _block == 2 || _block == 6 || _block == 8)return J;
	return Z;
}

forward IsCenter(_block);
public IsCenter(_block)
{
	if(_block == 4)return J;
	return Z;
}

forward TotalMoves();
public TotalMoves()
{
	return movecount+enemymovecount;
}

forward BlockCount(param);
public BlockCount(param)
{
	new count = 0;
	for(new i; i < 9; i++)if(block[i] == param)count++;
	return count;
}

forward GetOnlyBlock(param);
public GetOnlyBlock(param)
{
	for(new i; i < 9; i++)if(block[i] == param)return i;
	return N;
}

forward HardPlace(param);
public HardPlace(param)
{
	if(param == X)
	{
		if(TotalMoves() == J)
		{
			block[4] = X;
		}
		else
		{
		    if(BlockCount(O) == J && BlockCount(X) == J && strategy == N)
		    {
		        new id = GetOnlyBlock(O);
		        if(id != N)
		        {
		            if(IsEdge(id) == J)
		            {
		                new rand = random(2);
		                if(id == 1)
		                {
		                    if(rand == 0)block[6] = X;else
                            block[8] = X;
		                }
		                else
		                if(id == 3)
		                {
		                    if(rand == 0)block[8] = X;else
                            block[2] = X;
		                }
		                else
		                if(id == 5)
		                {
		                    if(rand == 0)block[0] = X;else
                            block[6] = X;
		                }
		                else
		                if(id == 7)
		                {
		                    if(rand == 0)block[2] = X;else
                            block[0] = X;
		                }
		                strategy = s_edge;
		            }
		            else
		            {
		                new tryblock = EstimateLine_corner();
						block[tryblock] = X;
		                strategy = s_corner;
		            }
		        }
		    }
		    else if(strategy == s_edge)
		    {
				new tryblock = EstimateWinblock(X);

				if(tryblock != N && block[tryblock] == N)
				{
				    block[tryblock] = X;
				}
				else
				{
					tryblock = EstimateWinblock(O);
					if(tryblock != N && block[tryblock] == N)
					{
					    block[tryblock] = X;
					}
					else
					{
						EasyPlace(X);
					}
				}
		    }
		    else if(strategy == s_corner)
		    {
				new tryblock = EstimateWinblock(X);
				if(tryblock != N && block[tryblock] == N)
				{
				    block[tryblock] = X;
				}
				else
				{
					tryblock = EstimateWinblock(O);
					if(tryblock != N && block[tryblock] == N)
					{
					    block[tryblock] = X;
					}
					else
					{
						EasyPlace(X);
					}
				}
		    }
		}
	}
	else if(param == O)
	{
		if(TotalMoves() == 2)
		{
			new id = GetOnlyBlock(X);
		    if(id != N)
		    {
		        if(IsCenter(id) == J)strategy = s_center;else
		    	if(IsEdge(id) == J)strategy = s_edge;else
		    	strategy = s_corner;
			}
			if(strategy == s_center)
			{
			    block[6] = O;
			}
			else if(strategy == s_edge)
			{
			    block[4] = O;
			}
			else if(strategy == s_corner)
			{
			    block[4] = O;
			}
		}
		else
		{
			if(strategy == s_center)
			{
				new tryblock = EstimateWinblock(O);
				if(tryblock != N && block[tryblock] == N)
				{
				    block[tryblock] = O;
				}
				else
				{
					tryblock = EstimateWinblock(X);
					if(tryblock != N && block[tryblock] == N)
					{
					    block[tryblock] = O;
					}
					else
					{
						EasyPlace(O);
					}
				}
			}
			else if(strategy == s_edge)
			{
				new tryblock = EstimateWinblock(O);
				if(tryblock != N && block[tryblock] == N)
				{
				    block[tryblock] = O;
				}
				else
				{
					tryblock = EstimateWinblock(X);
					if(tryblock != N && block[tryblock] == N)
					{
					    block[tryblock] = O;
					}
					else
					{
						EasyPlace(O);
					}
				}
			}
			else if(strategy == s_corner)
			{
				new tryblock = EstimateWinblock(O);
				if(tryblock != N && block[tryblock] == N)
				{
				    block[tryblock] = O;
				}
				else
				{
					tryblock = EstimateWinblock(X);
					if(tryblock != N && block[tryblock] == N)
					{
					    block[tryblock] = O;
					}
					else
					{
						EasyPlace(O);
					}
				}
			}
		}
	}
	return J;
}

forward EstimateWinblock(type);
public EstimateWinblock(type)
{
	new r = N;
	for(new i; i < 8; i++)
	{
	    if(block[(winblock[i][0])] == type && block[(winblock[i][1])] == type)
			r = winblock[i][2];
		if(r != N)if(block[r] == N)return r;
	    if(block[(winblock[i][0])] == type && block[(winblock[i][2])] == type)
			r = winblock[i][1];
		if(r != N)if(block[r] == N)return r;
	    if(block[(winblock[i][1])] == type && block[(winblock[i][2])] == type)
			r = winblock[i][0];
        if(r != N)if(block[r] == N)return r;
	}
	return r;
}

forward EstimateLine();
public EstimateLine()
{
	new r = N;
	for(new i; i < 8; i++)
	{
	    if(block[(winblock[i][0])] == X && block[(winblock[i][1])] == O)
			r = winblock[i][2];
	    if(block[(winblock[i][0])] == O && block[(winblock[i][1])] == X)
			r = winblock[i][2];
	    if(block[(winblock[i][0])] == X && block[(winblock[i][2])] == O)
			r = winblock[i][1];
	    if(block[(winblock[i][0])] == O && block[(winblock[i][2])] == X)
			r = winblock[i][1];
	    if(block[(winblock[i][1])] == X && block[(winblock[i][2])] == O)
			r = winblock[i][0];
	    if(block[(winblock[i][1])] == O && block[(winblock[i][2])] == X)
			r = winblock[i][0];
	}
	return r;
}

forward EstimateLine_corner();
public EstimateLine_corner()
{
	new r = N;
    if(block[4] == X)
	{
		if(block[0] == O)r = 8;else
		if(block[2] == O)r = 6;else
		if(block[6] == O)r = 2;else
		if(block[8] == O)r = 0;
	}
	else
    if(block[4] == O)
	{
		if(block[0] == X)r = 8;else
		if(block[2] == X)r = 6;else
		if(block[6] == X)r = 2;else
		if(block[8] == X)r = 0;
	}
	return r;
}