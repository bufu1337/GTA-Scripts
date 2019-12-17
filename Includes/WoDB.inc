/*
 *            WoDB.inc 1.0 Beta
 *       (c) Copyright 2009 by JIexa & GaTa
 *
 * @authors    : JIexa & GaTa
 * @date      : 13th March 2009
 * @require   : a_sampdb and straight hands :D
 *
 * This file is provided as is (no warranties).
 *
 * Feel free to use it, a little message in
 * about box is honouring thing, isn't it?
 *
 */
/*		Natives 	
native db_OnFilterScriptInit();
native db_OnFilterScriptExit();
native db_Is_Table_Exists(tablename[]);
native db_Table_Create(tablename[], string[]);
native db_Table_Remove(tablename[]);
native db_NewString(tablename[], keys[], values[]);
native db_Set(tablename[], key[], value[], ifkey[], ifvalue[]);
native db_UnSet(tablename[], ifkey[], ifvalue[]);
native db_IsSet(table[], key[], titul[], value[]);
native db_Get(tablename[], key[], titul[], value[]);
*/
#if defined _WoDB_included
  #endinput
#endif

#define _WoDB_included
#pragma library a_sampdb

#include <a_samp>

new DB:DataBase;
new DBResult:Result;
new DBQuery[256];

stock db_OnFilterScriptInit() DataBase = db_open("MainDB.db");
stock db_OnFilterScriptExit() db_close(DataBase);

stock db_Is_Table_Exists(tablename[])
{
	format(DBQuery, sizeof(DBQuery), "SELECT * FROM %s LIMIT 1;", tablename);
	Result = db_query(DataBase, DBQuery);
	db_get_field(Result, 0, DBQuery, 255);
	db_free_result(Result);
	if(strlen(DBQuery) > 1) return true;
	return false;
}

stock db_Table_Create(tablename[], string[])
{
	format(DBQuery,256,"CREATE TABLE IF NOT EXISTS %s (%s);",tablename, string);
	db_query(DataBase, DBQuery);
	print("Table: Create Table.");
	return 1;
}

stock db_Table_Remove(tablename[])
{
	format(DBQuery, sizeof(DBQuery), "DROP TABLE %s;", tablename);
	db_query(DataBase, DBQuery);
	return true;
}

stock db_NewString(tablename[], keys[], values[])
{
	format(DBQuery, sizeof(DBQuery) ,"INSERT INTO %s (%s) VALUES (%s);",tablename,keys,values);
	db_query(DataBase, DBQuery);
	print(DBQuery);
    return true;
}

stock db_Set(tablename[], key[], value[], ifkey[], ifvalue[])
{
	format(DBQuery,256,"UPDATE %s SET %s='%s' WHERE LOWER(%s) = LOWER('%s');",tablename, key, value, ifkey, ifvalue);
	db_query(DataBase, DBQuery);
	print(DBQuery);
	return 1;
}

stock db_UnSet(tablename[], ifkey[], ifvalue[])
{
	format(DBQuery, sizeof(DBQuery), "DELETE FROM %s WHERE LOWER(%s) = LOWER('%s');", tablename, ifkey, ifvalue);
	db_query(DataBase, DBQuery);
	print(DBQuery);
	return 1;
}

stock db_IsSet(table[], key[], titul[], value[])
{
	format(DBQuery, sizeof(DBQuery), "SELECT %s FROM %s WHERE LOWER(%s) = LOWER('%s') LIMIT 1;", key, table, titul,value);
	Result = db_query(DataBase, DBQuery);
	db_get_field(Result, 0, DBQuery, 256);
	db_free_result(Result);
	if(strcmp(DBQuery,"(null)")) return 0;
	{
	print("Done");
	return 1;
	}
}   

stock db_Get(tablename[], key[], titul[], value[])
{
	format(DBQuery, sizeof(DBQuery), "SELECT %s FROM %s WHERE LOWER(%s) = LOWER('%s') LIMIT 1;", key, tablename, titul,value);
	Result = db_query(DataBase, DBQuery);
	db_get_field(Result, 0, DBQuery, 256);
	db_free_result(Result);
	return DBQuery;
}