/*
 *            MySqlUsers 1.0
*
 * author    	: Red-Zero
 * date      	: 6th Feb 2008
 * required   : sampmysql 0.12
 *
 *
 */

#if defined _sqlusers_included
  #endinput
#endif
#define _sqlusers_included
#pragma library sampmysql

#include <string>


// check if an account exists in the database (nickname check, example: Account_Exists("Red_Zero");  )
stock Account_Exists(account[])
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT nickname FROM accounts WHERE nickname='%s'",account);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	if (strlen(resultline)) return true;
	return false;
}


// Create a new account in the database, checking if this one already exists
stock Account_Create(account[], pw[])
{
	if(!Account_Exists(account))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "INSERT INTO accounts(nickname,password) VALUES ('%s', (SELECT md5('%s')))",account,pw);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}

stock Set_Password(account[], pw[])
{
	if(!Account_Exists(account))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "UPDATE accounts SET password = md5('%s') WHERE nickname = '%s'",pw, account);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}

stock Account_Remove(account[])
{
	if(Account_Exists(account))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "DELETE FROM accounts WHERE nickname='%s'",account);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}
		

// Save an integer value in an account (example: SavePlayerIntStat("Red_Zero", "money", 100000);  ) 
stock SavePlayerIntStat(pname[], variable[], value)
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: SavePlayerIntStat(%s, %s, %d))",pname, pname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE accounts SET %s = '%d' WHERE nickname = '%s'", variable, value, pname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SavePlayerFloatStat(pname[], variable[], Float:value)
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: SavePlayerFloatStat(%s, %s, %f))",pname, pname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE accounts SET %s = '%f' WHERE nickname = '%s'", variable, value, pname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}


// Save a string value in an account (example: SavePlayerIntStat("Red_Zero", "password", "hashedpassowrd");  ) 
stock SavePlayerStringStat(pname[], variable[], value[])
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: SavePlayerIntStat(%s, %s, %s))",pname, pname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE accounts SET %s = '%s' WHERE nickname = '%s'", variable, value, pname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else
	return true;
}


// Return a string or an integer from the sql account. IMPORTANT: you must know which type of variable is returned _before_, an integer can't contain a string and vice-versa.
stock GetPlayerIntStat(pname[], variable[])
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: GetPlayerIntStat(%s, %s))",pname, pname, variable);
		return false;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM accounts WHERE nickname='%s'",variable,pname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return strval(resultline);
}

stock Float:GetPlayerFloatStat(pname[], variable[])
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: GetPlayerFloatStat(%s, %s))",pname, pname, variable);
		return 0.666;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM accounts WHERE nickname='%s'",variable,pname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return floatstr(resultline);
}

stock GetPlayerStringStat(pname[], variable[])
{
	if(!Account_Exists(pname))
	{
		new status[256];
		strcpy(status, "Error");
		printf("Error: Account %s doesn't exists (function: GetPlayerStringStat(%s, %s))",pname, pname, variable);
		return status;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM accounts WHERE nickname='%s'",variable,pname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return resultline;
}

stock CheckLogin(pname[],pwd[]) 
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: CheckLogin(%s, %s))",pname, pname, pwd);
		return false;
	}
	new qstring[1024],resultline[33],inpass[33],dbpass[33];
	format(qstring, sizeof(qstring), "SELECT password FROM accounts WHERE nickname = '%s'",pname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	strcpy(dbpass, resultline);
//	printf("Passoword database = %s",dbpass);
	format(qstring, sizeof(qstring), "SELECT md5('%s')",pwd);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	strcpy(inpass, resultline);
//	printf("Passoword inserted = %s",inpass);
	if(strcmp(inpass, dbpass, false)==0) return true;
	return false;
}

stock ChangePassword(pname[], newpw[])
{
	if(!Account_Exists(pname))
	{
		printf("Error: Account %s doesn't exists (function: ChangePass(%s, %s))",pname, pname, newpw);
		return false;
	}
	new qstring[512],resultline[33],inpass[33];
	format(qstring, sizeof(qstring), "SELECT md5('%s')",newpw);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	strcpy(inpass, resultline);
	SavePlayerStringStat(pname, "password", inpass);
	return true;
}



