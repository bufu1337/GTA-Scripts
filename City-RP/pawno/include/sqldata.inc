/*
 *            MySqlData 1.0
*
 * author    	: Red-Zero
 * date      	: 6th Feb 2008
 * required   : sampmysql 0.12
 *
 *
 */

#if defined _sqldata_included
  #endinput
#endif
#define _sqldata_included
#pragma library sampmysql

#include <string>


stock New_Table(tablename[]) // id column is autocreated on every call
{
	new querystring[1024];
	format(querystring, sizeof(querystring), "CREATE TABLE %s(`id` INT NOT NULL AUTO_INCREMENT, PRIMARY KEY ( `id` )) ENGINE = MYISAM ", tablename);
	if(samp_mysql_query(querystring)) return true;
	return false;
}

stock  Table_Exists(tablename[])
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT * FROM %s LIMIT 1;",tablename); 
	if(samp_mysql_query(qstring))
	{
		samp_mysql_store_result();
		samp_mysql_fetch_row(resultline);
		return true;
	}
	return false;
}

stock Delete_Table(tablename[])
{
	if(Table_Exists(tablename))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "DROP TABLE %s", tablename);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}

stock Get_Rows(tablename[])
{
	if(Table_Exists(tablename))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "SELECT * FROM %s", tablename);
		samp_mysql_query(qstring);
		samp_mysql_store_result();
		return samp_mysql_num_rows();
	}
	return 0;
}

stock Stat_Exists(table[], variable[])
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT %s FROM %s LIMIT 1", variable, table);
	if(samp_mysql_query(qstring))
	{
		samp_mysql_store_result();
		samp_mysql_fetch_row(resultline);
		return true;
	}
	return false;
}

stock Line_Exists(table[], identifier[], value)
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT %s FROM %s WHERE %s='%d'", identifier, table, identifier, value);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	if (strlen(resultline)) return true;
	return false;
}

stock Line_Create(table[], field[], value)
{
	if(!Line_Exists(table, field, value))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "INSERT INTO %s(%s) VALUES ('%s')", table, field, value);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}

stock SetIntStat(table[], id, variable[], value)
{
	if(!Stat_Exists(table, variable))
	{
		printf("Debug Error: Stat %s doesn't exists (function: SaveIntStat(%s, %s, %d))",variable, table, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE %s SET %s = '%d' WHERE id = '%d'", table, variable, value, id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SetFloatStat(table[], id, variable[], Float:value)
{
	if(!Stat_Exists(table, variable))
	{
		printf("Debug Error: Stat %s doesn't exists (function: SaveIntStat(%s, %s, %f))",variable, table, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE %s SET %s = '%f' WHERE id = '%d'", table, variable, value, id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SetStringStat(table[], id, variable[], value[])
{
	if(!Stat_Exists(table, variable))
	{
		printf("Debug Error: Stat %s doesn't exists (function: SaveStringStat(%s, %s, %s))",variable, table, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE %s SET %s = '%s' WHERE id = '%d'", table, variable, value, id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock GetIntStat(table[], id ,variable[])
{
	if(!Stat_Exists(table, variable))
	{
		printf("Debug Error: Stat %s doesn't exists (function: GetIntStat(%s, %d, %s, %s))",variable, table, id, variable);
		return false;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM %s WHERE id = '%d'",variable, table,id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	}
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return strval(resultline);
}

stock Float:GetFloatStat(table[], id, variable[])
{
	if(!Stat_Exists(table, variable))
	{
		printf("Debug Error: Stat %s doesn't exists (function: GetFloatStat(%s, %d, %s, %s))",variable, table, id, variable);
		return 0.666;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM %s WHERE id = '%d'",variable, table, id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return 0.666;
	}
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return floatstr(resultline);
}

stock GetStringStat(table[], id[], variable[])
{
	new status[256];
	if(!Stat_Exists(table, variable))
	{
		strcpy(status, "Error");
		printf("Error: Stat %s doesn't exists (function: GetStringStat(%s, %d, %s, %s))",variable, table, id, variable);
		return status;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM %s WHERE %s",variable, table, id);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		strcpy(status, "Error");
		return status;
	}
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return resultline;
}