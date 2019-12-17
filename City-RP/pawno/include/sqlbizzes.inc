/*
 *            MySqlBizzes 1.0
*
 * author    	: Red-Zero
 * date      	: 6th Feb 2008
 * required   : sampmysql 0.12
 *
 *
 */

#if defined _sqlbizzes_included
  #endinput
#endif
#define _sqlbizzes_included
#pragma library sampmysql

#include <string>

enum bizcoords
{
	Float:x,
	Float:y,
	Float:z,
	Float:a
}

stock Biz_Exists(bizname[])
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT bizname FROM bizzes WHERE bizname='%s'", bizname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	if (strlen(resultline)) return true;
	return false;
}

stock Biz_Create(bizname[], Float:out_x,Float:out_y,Float:out_z, Float:in_x,Float:in_y,Float:in_z, bizint, bizvirtual, type)
{
	if(!Biz_Exists(bizname))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "INSERT INTO bizzes(bizname,outpos_x,outpos_y,outpos_z,insidepos_x,insidepos_y,insidepos_z,bizinterior,bizvirtual, biztype) VALUES ('%s','%f','%f','%f','%f','%f','%f','%d','%d','%b')", bizname,out_x,out_y,out_z,in_x,in_y,in_z,bizint,bizvirtual,type);
		if(samp_mysql_query(qstring))
		return true;
	}
	return false;
}

stock Biz_Remove(bizname[])
{
	if(Biz_Exists(biz))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "DELETE FROM bizzes WHERE bizname='%s'", bizname);
		if(samp_mysql_query(qstring)) return true;
	}
	return false;
}

stock SaveBizIntStat(bizname[], variable[], value)
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: SaveBizIntStat(%s, %s, %d))", bizname, bizname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE bizzes SET %s = '%d' WHERE bizname = '%s' LIMIT 1", variable, value, bizname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SaveBizFloatStat(bizname[], variable[], Float:value)
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: SaveBizIntStat(%s, %s, %f))", bizname, bizname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE bizzes SET %s = '%f' WHERE bizname = '%s' LIMIT 1", variable, value, bizname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SaveBizStringStat(bizname[], variable[], value[])
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: SaveBizIntStat(%s, %s, %s))", bizname, bizname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE bizzes SET %s = '%s' WHERE bizname = '%s' LIMIT 1", variable, value, bizname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SaveBizBinStat(bizname[], variable[], value)
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: SaveBizIntStat(%s, %s, %b))", bizname, bizname, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE bizzes SET %s = '%b' WHERE bizname = '%s' LIMIT 1", variable, value, bizname);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock GetBizIntStat(bizname[], variable[])
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: GetBizIntStat(%s, %s)", bizname, bizname, variable);
		return false;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM bizzes WHERE bizname='%s'", variable, bizname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return strval(resultline);
}

stock Float:GetBizFloatStat(bizname[], variable[])
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: GetBizIntStat(%s, %s)", bizname, bizname, variable);
		return 0.666;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM bizzes WHERE bizname='%s'", variable, bizname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return floatstr(resultline);
}

stock GetBizBinStat(bizname[], variable[])
{
	if(!Biz_Exists(bizname))
	{
		printf("Error: Biz '%s' doesn't exists (function: GetBizIntStat(%s, %b)", bizname, bizname, variable);
		return false;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM bizzes WHERE bizname='%s'", variable, bizname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	new temp[16];
	format(temp, sizeof(temp), "%b", resultline);
	//printf("Function on resultline = %b", resultline);
	return strval(resultline);
}

stock GetBizStringStat(bizname[], variable[])
{
	new status[256];
	if(!Biz_Exists(bizname))
	{
		strcpy(status, "Error");
		printf("Error: Biz '%s' doesn't exists (function: GetBizIntStat(%s, %b)", bizname, bizname, variable);
		return status;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM bizzes WHERE bizname='%s'", variable, bizname);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return resultline;
}

stock GetVehicleBizIntStat(vehicledbid, variable[])
{
	new qstring[1024],resultline2[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM vehicles WHERE id = '%d'",variable, vehicledbid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	new temp[256]; strcpy(temp, resultline2);
	return strval(temp);
}

stock Float:GetVehicleBizFloatStat(vehicledbid, variable[])
{
	new qstring[1024],resultline2[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM vehicles WHERE id = '%d'",variable, vehicledbid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline2);
	new temp[256]; strcpy(temp, resultline2);
	return floatstr(temp);
}
	
