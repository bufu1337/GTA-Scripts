/*
 *            MySqlVehicles 1.0
*
 * author    	: Red-Zero
 * date      	: 6th Feb 2008
 * required   : sampmysql 0.12
 *
 *
 */

#if defined _sqlvehicles_included
  #endinput
#endif
#define _sqlvehicles_included
#pragma library sampmysql

#include <string>


// check if an account exists in the database (owner check, example: Vehicle_Exists("Red_Zero");  )
stock Vehicle_Exists(owner[], carUid)
{
	new qstring[1024],resultline[1024];
	format(qstring, sizeof(qstring), "SELECT owner FROM vehicles WHERE owner='%s' AND carUid = '%d' LIMIT 1", owner, carUid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	if (strlen(resultline)) return true;
	return false;
}


// Create a new account in the database, checking if this one already exists
stock Vehicle_Porperty_Create(vmodel, owner[], fuel, Float:vpos_x, Float:vpos_y, Float:vpos_z, Float:vpos_a, biza, carUid)
{
	if(!Vehicle_Exists(owner, carUid))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "INSERT INTO vehicles(vehiclemodel,owner,fuel,pos_x,pos_y,pos_z,pos_a,bizassoc,carUid) VALUES (%d,'%s','%d','%f','%f','%f','%f','%d','%d')", vmodel,owner,fuel,vpos_x,vpos_y,vpos_z,vpos_a,biza, carUid);
		if(samp_mysql_query(qstring))
		return true;
	}
	return false;
}

/*stock Set_Password(account[], pw[])
{
	if(!Vehicle_Exists(account))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "UPDATE vehicles SET password = md5('%s') WHERE owner = '%s'",pw, account);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}*/

stock Vehicle_Remove(owner[], carUid)
{
	if(Vehicle_Exists(owner, carUid))
	{
		new qstring[1024];
		format(qstring, sizeof(qstring), "DELETE FROM vehicles WHERE owner='%s' AND carUid = '%d'", owner, carUid);
		samp_mysql_query(qstring);
		return true;
	}
	return false;
}
		

// Save an integer value in an account (example: SaveVehicleIntStat("Red_Zero", "money", 100000);  ) 
stock SaveVehicleIntStat(owner[], carUid, variable[], value)
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: SaveVehicleIntStat(%s, %s, %d))", owner, owner, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE vehicles SET %s = '%d' WHERE owner = '%s' AND carUid = '%d' LIMIT 1", variable, value, owner, carUid);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}

stock SaveVehicleFloatStat(owner[], carUid, variable[], Float:value)
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: SaveVehicleFloatStat(%s, %s, %f))", owner, owner, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE vehicles SET %s = '%f' WHERE owner = '%s' AND carUid = '%d' LIMIT 1", variable, value, owner, carUid);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else 
	return true;
}


// Save a string value in an account (example: SaveVehicleIntStat("Red_Zero", "password", "hashedpassowrd");  ) 
stock SaveVehicleStringStat(owner[], carUid, variable[], value[])
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: SaveVehicleIntStat(%s, %s, %s))",owner, owner, variable, value);
		return false;
	}
	new qstring[1024];
	format(qstring, sizeof(qstring), "UPDATE vehicles SET %s = '%s' WHERE owner = '%s' AND carUid = '%d' LIMIT 1", variable, value, owner, carUid);
	if(!samp_mysql_query(qstring))
	{
		printf("Error during the query: '%s'",qstring);
		return false;
	} else
	return true;
}


// Return a string or an integer from the sql account. IMPORTANT: you must know which type of variable is returned _before_, an integer can't contain a string and vice-versa.
stock GetVehicleIntStat(owner[], carUid, variable[])
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: GetVehicleIntStat(%s, %s))",owner, owner, variable);
		return false;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM vehicles WHERE owner='%s' AND carUid = '%d'",variable,owner,carUid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return strval(resultline);
}

stock Float:GetVehicleFloatStat(owner[], carUid, variable[])
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: GetVehicleFloatStat(%s, %s))",owner, owner, variable);
		return 0.666;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM vehicles WHERE owner='%s' AND carUid = '%d'",variable,owner,carUid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return floatstr(resultline);
}

stock GetVehicleStringStat(owner[], carUid, variable[])
{
	if(!Vehicle_Exists(owner, carUid))
	{
		new status[256];
		strcpy(status, "Error");
		printf("Error: Vehicle of %s doesn't exists (function: GetVehicleStringStat(%s, %s))",owner, owner, variable);
		return status;
	}
	new qstring[1024],resultline[256];
	format(qstring, sizeof(qstring), "SELECT %s FROM vehicles WHERE owner='%s' AND carUid = '%d'",variable,owner,carUid);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	return resultline;
}

/*stock CheckLogin(owner[],pwd[]) 
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: CheckLogin(%s, %s))",owner, owner, pwd);
		return false;
	}
	new qstring[1024],resultline[33],inpass[33],dbpass[33];
	format(qstring, sizeof(qstring), "SELECT password FROM vehicles WHERE owner = '%s'",owner);
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
}*/

/*stock ChangeOwner(oldowner[], newowner[])
{
	if(!Vehicle_Exists(owner, carUid))
	{
		printf("Error: Vehicle of %s doesn't exists (function: ChangePass(%s, %s))",owner, owner, newpw);
		return false;
	}
	new qstring[512],resultline[33];
	format(qstring, sizeof(qstring), "SELECT md5('%s')",newpw);
	samp_mysql_query(qstring);
	samp_mysql_store_result();
	samp_mysql_fetch_row(resultline);
	strcpy(inpass, resultline);
	SaveVehicleStringStat(owner, "password", inpass);
	return true;
}*/



