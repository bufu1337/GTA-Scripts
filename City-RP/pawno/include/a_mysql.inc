/**
*
*	SA:MP - MySQL Native Functions
*	(c) Copyright 2008-2009, G-sTyLeZzZ
*
*	More information about the function usage at mysql.com.
*
**/

#if defined mysql_included
	#endinput
#endif
#define mysql_included

#define mysql_fetch_row(%1) mysql_fetch_row_format(%1," ")
#define mysql_get_field(%1,%2) mysql_fetch_field_row(%1,%2)
#define mysql_get_int() mysql_fetch_int()
#define mysql_get_float(%1) mysql_fetch_float(%1)
#define mysql_reconnect() mysql_reload()

native mysql_connect(const host[],const user[],const database[],const password[]);
native mysql_query(query[],resultid = (-1));
native mysql_real_escape_string(const source[],destination[]);
native mysql_fetch_row_format(string[],const delimiter[] = "|");
native mysql_num_rows();
native mysql_num_fields();
native mysql_affected_rows();
native mysql_warning_count();
native mysql_ping();
native mysql_store_result();
native mysql_free_result();
native mysql_stat(const destination[]);
native mysql_errno();
native mysql_field_count();
native mysql_close();
native mysql_fetch_int();
native mysql_fetch_float(&Float:result);
native mysql_fetch_field(fieldnr,dest[]);
native mysql_fetch_field_row(string[],const fieldname[]);
native mysql_debug(enable = 1);
native mysql_reload();
native mysql_insert_id();

forward OnQueryFinish(query[],resultid);
