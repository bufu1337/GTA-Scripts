/*
 *            DJson 1.6.2
 *       (c) Copyright 2008-2010 by DracoBlue
 *
 * @author    : DracoBlue (http://dracoblue.com)
 * @date      : 20th Aug 2008
 * @update    : 8th May 2010
 *
 * This file is provided as is (no warranties).
 *
 * DJson is released under the terms of MIT License
 *
 * Feel free to use it, a little message in
 * about box is honoring thing, isn't it?
 *
 */

#define DJSON_MAX_DEPTH 20

#if !defined DJSON_MAX_STRING
#define DJSON_MAX_STRING 255
#endif

#define DJSON_RUN_TESTCASES_AT_INIT 0

#pragma dynamic 4000000

#define DJSON_CACHE_USE_TEMPTABLES 1
#define DJSON_ALLOW_STYLED_OUTPUT 1

/**
 * @access private
 * @ingroup private
 */
new DJSON_cache_file_name[DJSON_MAX_STRING];

/**
 * @access public
 */
new DJSON_LastError[DJSON_MAX_STRING];

/**
 * 1 = Can not open File
 * 2 = Syntax Error in File
 * 3 = Error In djson Parser, please report to DracoBlue
 * 4 = This path you trying to access is not set, falling back to default value
 * 5 = File was not loaded, can't commit!
 * 6 = The path is invalid
 * @access public
 */
new DJSON_LastErrorCode=0;

/**
 * @access private
 * @ingroup private
 */
new DJSON_path[DJSON_MAX_DEPTH][DJSON_MAX_STRING];

/**
 * @access private
 * @ingroup private
 */
new DJSON_path_id[DJSON_MAX_DEPTH];

/**
 * @access private
 * @ingroup private
 */
new DJSON_path_type[DJSON_MAX_DEPTH];

/**
 * @access private
 * @ingroup private
 */
new DJSON_path_arraypos[DJSON_MAX_DEPTH];

/**
 * @access private
 * @ingroup private
 */
new DJSON_autocommit = true;

#if DJSON_ALLOW_STYLED_OUTPUT
/**
 * @access private
 * @ingroup private
 */
new DJSON_styled_output = false;

#endif
/**
 * @access private
 * @ingroup private
 */
stock DJSON_ret_memcpy(source[],index=0,numbytes) {
	new tmp[DJSON_MAX_STRING];
	new i=0;
	tmp[0]=0;
	if (index>=strlen(source)) return tmp;
	if (numbytes+index>=strlen(source)) numbytes=strlen(source)-index;
	if (numbytes<=0) return tmp;
	for (i=index;i<numbytes+index;i++) {
		tmp[i-index]=source[i];
		if (source[i]==0) return tmp;
	}
	tmp[numbytes]=0;
	return tmp;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_implode(c,path_pos) {
	new tmp[DJSON_MAX_STRING];
	for (new i=0;i<path_pos;i++) {
		if (i==path_pos-1) {
			format(tmp,DJSON_MAX_STRING,"%s%s",tmp,DJSON_path[i]);
		} else {
			format(tmp,DJSON_MAX_STRING,"%s%s%c",tmp,DJSON_path[i],c);
		}
	}
	return tmp;
}

/**
 * @access private
 * @ingroup private
 */
new DB:DJSON_cache_db;

/**
 * @access private
 * @ingroup private
 */
#define DJSON_TYPE_OBJECT 1

/**
 * @access private
 * @ingroup private
 */
#define DJSON_TYPE_ARRAY 2

/**
 * @access private
 * @ingroup private
 */
#define DJSON_TYPE_NUMBER 3

/**
 * @access private
 * @ingroup private
 */
#define DJSON_TYPE_STRING 4

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_init() {
	new max_id = 1000;
	new id;

	while (max_id++) {
		id = random(max_id);
		format(DJSON_cache_file_name,DJSON_MAX_STRING,"djson-db-cache.%d.db",id);
		if (!fexist(DJSON_cache_file_name)) {
			break;
		}
	}
	DJSON_cache_db=db_open(DJSON_cache_file_name);

#if DJSON_CACHE_USE_TEMPTABLES
	db_query(DJSON_cache_db,"PRAGMA journal_mode = OFF;");
	db_query(DJSON_cache_db,"PRAGMA temp_store = MEMORY;");

	db_query(DJSON_cache_db,"DROP TABLE IF EXISTS `c`");
	db_query(DJSON_cache_db,"CREATE TEMPORARY TABLE IF NOT EXISTS `c` ( `file` varchar(255),  `id` INTEGER PRIMARY KEY, `path` varchar(255), `value` varchar(255), `type` int(6),`parent` int(6),`pos` int(6))");

	db_query(DJSON_cache_db,"DROP TABLE IF EXISTS `is_c`");
	db_query(DJSON_cache_db,"CREATE TEMPORARY TABLE IF NOT EXISTS `is_c` ( `file` varchar(255))");
#else
	db_query(DJSON_cache_db,"DROP TABLE IF EXISTS `c`");
	db_query(DJSON_cache_db,"CREATE TABLE IF NOT EXISTS `c` ( `file` varchar(255),  `id` INTEGER PRIMARY KEY, `path` varchar(255), `value` varchar(255), `type` int(6),`parent` int(6),`pos` int(6))");

	db_query(DJSON_cache_db,"DROP TABLE IF EXISTS `is_c`");
	db_query(DJSON_cache_db,"CREATE TABLE IF NOT EXISTS `is_c` ( `file` varchar(255))");
#endif
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_close() {
	db_close(DJSON_cache_db);
	fremove(DJSON_cache_file_name);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_strreplace(trg[],newstr[],src[]) {
    new f=0;
    new s1[DJSON_MAX_STRING];
    new tmp[DJSON_MAX_STRING];
    if (strlen(src)==0) return tmp;
    format(s1,sizeof(s1),"%s",src);
    f = strfind(s1,trg);
    tmp[0]=0;
    while (f>=0) {
        strcat(tmp,DJSON_ret_memcpy(s1, 0, f));
        strcat(tmp,newstr);
        format(s1,sizeof(s1),"%s",DJSON_ret_memcpy(s1, f+strlen(trg), strlen(s1)-f));
        f = strfind(s1,trg);
    }
    strcat(tmp,s1);
    return tmp;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_sql_escape(src[]) {
	new tmp[DJSON_MAX_STRING];
	new src_len = strlen(src);
	new nxt_trg_pos = 0;
	new i = 0;
	while (i<src_len) {
		switch (src[i]) {
			case '\'': {
				tmp[nxt_trg_pos]='\'';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='\'';
			}
			default: {
				tmp[nxt_trg_pos] = src[i];
			}
		}
		nxt_trg_pos++;
		i++;
	}
	tmp[nxt_trg_pos] = 0;
	return tmp;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_json_escape(src[]) {
	new tmp[DJSON_MAX_STRING];
	new src_len = strlen(src);
	new nxt_trg_pos = 0;
	new i = 0;
	while (i<src_len) {
		switch (src[i]) {
			case 10: {
				tmp[nxt_trg_pos]='\\';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='n';
			}
			case 13: {
				tmp[nxt_trg_pos]='\\';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='r';
			}
			case '"': {
				tmp[nxt_trg_pos]='\\';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='"';
			}
			case 9: {
				tmp[nxt_trg_pos]='\\';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='t';
			}
			case '\\': {
				tmp[nxt_trg_pos]='\\';
				nxt_trg_pos++;
				tmp[nxt_trg_pos]='\\';
			}
			default: {
				tmp[nxt_trg_pos] = src[i];
			}
		}
		nxt_trg_pos++;
		i++;
	}
	tmp[nxt_trg_pos] = 0;
	return tmp;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createNode(file[],key[],type_id,value[],parent,pos=-1) {
	new query[DJSON_MAX_STRING];
	format(query,DJSON_MAX_STRING,"INSERT INTO `c` (`id`,`file`,`path`,`value`,`type`, `pos`,`parent`) VALUES ((SELECT max(`id`) FROM `c`)+1,'%s','%s','%s',%d,%d,%d)",DJSON_sql_escape(file),DJSON_sql_escape(key),DJSON_sql_escape(value),type_id,pos,parent);
	db_query(DJSON_cache_db,query);
	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT `id` FROM `c` WHERE file = '%s' AND path = '%s'",DJSON_sql_escape(file),DJSON_sql_escape(key));
	res = db_query(DJSON_cache_db,query);
	new has_next = db_num_rows(res) != 0;
	new the_id[DJSON_MAX_STRING]="-1";
	if (has_next) {
		db_get_field(res,0,the_id,DJSON_MAX_STRING);
	}
	db_free_result(res);
	return strval(the_id);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_updateNode(file[],key[],type_id,value[]) {
	new query[DJSON_MAX_STRING];
	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT `id` FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(key));
	res = db_query(DJSON_cache_db,query);
	if (db_num_rows(res) != 0) {
		// it exists
		new the_id[DJSON_MAX_STRING]="-1";
		db_get_field(res,0,the_id,DJSON_MAX_STRING);
		db_free_result(res);

		format(query,DJSON_MAX_STRING,"UPDATE `c` SET `value`='%s',type=%d WHERE file='%s' AND path='%s'",DJSON_sql_escape(value),type_id,DJSON_sql_escape(file),DJSON_sql_escape(key));
		db_query(DJSON_cache_db,query);

		return strval(the_id);
	} else {
		db_free_result(res);

		return 0;
	}
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createArrayNode(file[],key[],parent,pos=-1) {
	return DJSON_cache_createNode(file,key,DJSON_TYPE_ARRAY,"",parent,pos);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createObjectNode(file[],key[],parent,pos=-1) {
	return DJSON_cache_createNode(file,key,DJSON_TYPE_OBJECT,"",parent,pos);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createString(file[],key[],value[],parent,pos=-1) {
	return DJSON_cache_createNode(file,key,DJSON_TYPE_STRING,value,parent,pos);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_updateString(file[],key[],value[]) {
	return DJSON_cache_updateNode(file,key,DJSON_TYPE_STRING,value);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_updateArrayNode(file[],key[]) {
	return DJSON_cache_updateNode(file,key,DJSON_TYPE_ARRAY,"");
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createNumberFromStr(file[],key[],value[],parent,pos=-1) {
	return DJSON_cache_createNode(file,key,DJSON_TYPE_NUMBER,value,parent,pos);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_updateNumberFromStr(file[],key[],value[]) {
	return DJSON_cache_updateNode(file,key,DJSON_TYPE_NUMBER,value);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_createNumber(file[],key[],value,parent,pos=-1) {
	new tmp[DJSON_MAX_STRING];
	format(tmp,DJSON_MAX_STRING,"%d",value);
	return DJSON_cache_createNode(file,key,DJSON_TYPE_NUMBER,tmp,parent,pos);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_updateNumber(file[],key[],value) {
	new tmp[DJSON_MAX_STRING];
	format(tmp,DJSON_MAX_STRING,"%d",value);
	return DJSON_cache_updateNode(file,key,DJSON_TYPE_NUMBER,tmp);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_putchartofile(File:fhnd,stream[DJSON_MAX_STRING],&stream_pos,c) {
	if (stream_pos==DJSON_MAX_STRING-1) {
		stream[stream_pos] = 0;
		fwrite(fhnd,stream);
		stream_pos = 0;
	}
	stream[stream_pos] = c;
	stream_pos++;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_putstringtofile(File:fhnd,stream[DJSON_MAX_STRING],&stream_pos,str[]) {
	new strl = strlen(str);
	new i = 0;
	if (strl+stream_pos<DJSON_MAX_STRING-1) {
		// if it's smaller anyways, we can do a fast copy
		while (i<strl) {
			stream[stream_pos] = str[i];
			stream_pos++;
			i++;
		}
	} else {
		// if it's bigger, we need to be careful
		while (i<strl) {
			if (stream_pos<DJSON_MAX_STRING-1) {
				stream[stream_pos] = str[i];
				stream_pos++;
				i++;
			} else {
				stream[stream_pos] = 0;
				fwrite(fhnd,stream);
				stream_pos = 0;
			}
		}
	}
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_debug_save_file(file[],tofile[]) {
#if DJSON_ALLOW_STYLED_OUTPUT
	if (DJSON_styled_output) return DJSON_cache_save_file_indented(file,tofile);
#endif
	new DBResult:res;
	new query[DJSON_MAX_STRING];
	format(query,DJSON_MAX_STRING,"SELECT `path`,`value`,`type`,`id`,`parent`,`pos` FROM `c` WHERE file='%s' ORDER BY `path`",DJSON_sql_escape(file));
	res = db_query(DJSON_cache_db,query);
	new has_next = db_num_rows(res) != 0;

	new cur_parent[DJSON_MAX_DEPTH];
	new cur_type[DJSON_MAX_DEPTH];
	new cur_el[DJSON_MAX_DEPTH];
	new cur_path[DJSON_MAX_DEPTH][DJSON_MAX_STRING];
	new c_d = 0;
	new tmp[DJSON_MAX_STRING];
	cur_parent[c_d]=0;
	cur_type[c_d]=DJSON_TYPE_OBJECT;
	cur_el[c_d]=0;
	cur_path[c_d][0]=0;

	new row_path[DJSON_MAX_STRING];
	new row_value[DJSON_MAX_STRING];
	new row_id = 0;
	new row_parent = 0;
	new row_type = 0;

	new File:fhnd=fopen(tofile,io_write);

	new stream[DJSON_MAX_STRING];
	new stream_pos = 0;

	if (!fhnd) {
		format(DJSON_LastError,DJSON_MAX_STRING,"Can not open File for writing!");
		DJSON_LastErrorCode = 2;
		return false;
	}

	if (has_next) {
		db_get_field(res,0,row_path,DJSON_MAX_STRING);
		db_get_field(res,1,row_value,DJSON_MAX_STRING);
		db_get_field(res,2,tmp,DJSON_MAX_STRING);
		row_type = strval(tmp);
		db_get_field(res,3,tmp,DJSON_MAX_STRING);
		row_id = strval(tmp);
		db_get_field(res,4,tmp,DJSON_MAX_STRING);
		row_parent = strval(tmp);
	}

	DJSON_cache_putchartofile(fhnd,stream, stream_pos,'{');

	while (row_id != 0) {

		while (row_parent != cur_parent[c_d]) {
			// this is not the correct parent yet, so we need to get down.
			if (cur_type[c_d] == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,']');
			c_d--;
		}

		if (cur_type[c_d] == DJSON_TYPE_OBJECT || cur_type[c_d] == DJSON_TYPE_ARRAY) {
			cur_el[c_d]++;
			if (cur_el[c_d]>1) {
				DJSON_cache_putchartofile(fhnd,stream,stream_pos,',');
			}
		}

		if (cur_type[c_d] == DJSON_TYPE_OBJECT) {
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			if (strlen(cur_path[c_d])>0) {
				DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_path[strlen(cur_path[c_d])+1]);
			} else {
				DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_path);
			}
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,':');
		}

		if (row_type == DJSON_TYPE_NUMBER) {
			DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_value);
		}

		if (row_type == DJSON_TYPE_STRING) {
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			DJSON_cache_putstringtofile(fhnd,stream,stream_pos,DJSON_json_escape(row_value));
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
		}

		if (row_type == DJSON_TYPE_OBJECT || row_type == DJSON_TYPE_ARRAY) {
			if (row_type == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'{'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,'[');
			c_d++;
			format(cur_path[c_d],DJSON_MAX_STRING,"%s",row_path);
			cur_parent[c_d] = row_id;
			cur_type[c_d] = row_type;
			cur_el[c_d] = 0;
		}

		has_next = db_next_row(res);

		if (has_next) {
			db_get_field(res,0,row_path,DJSON_MAX_STRING);
			db_get_field(res,1,row_value,DJSON_MAX_STRING);
			db_get_field(res,2,tmp,DJSON_MAX_STRING);
			row_type = strval(tmp);
			db_get_field(res,3,tmp,DJSON_MAX_STRING);
			row_id = strval(tmp);
			db_get_field(res,4,tmp,DJSON_MAX_STRING);
			row_parent = strval(tmp);
		} else {
			row_id = 0;
		}
	}

	while (0 != cur_parent[c_d]) {
		// this is not the correct parent yet, so we need to get down.
		if (cur_type[c_d] == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,']');
		c_d--;
	}

	DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}');

	if (stream_pos>0) {
		stream[stream_pos]=0;
		fwrite(fhnd,stream);
	}
	fclose(fhnd);

	db_free_result(res);
	return true;

}

#if DJSON_ALLOW_STYLED_OUTPUT
/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_save_file_indented(file[],tofile[]) {
	new DBResult:res;
	new query[DJSON_MAX_STRING];
	format(query,DJSON_MAX_STRING,"SELECT `path`,`value`,`type`,`id`,`parent`,`pos` FROM `c` WHERE file='%s' ORDER BY `path`",DJSON_sql_escape(file));
	res = db_query(DJSON_cache_db,query);
	new has_next = db_num_rows(res) != 0;

	new cur_parent[DJSON_MAX_DEPTH];
	new cur_type[DJSON_MAX_DEPTH];
	new cur_el[DJSON_MAX_DEPTH];
	new cur_path[DJSON_MAX_DEPTH][DJSON_MAX_STRING];
	new c_d = 0;
	new tmp[DJSON_MAX_STRING];
	cur_parent[c_d]=0;
	cur_type[c_d]=DJSON_TYPE_OBJECT;
	cur_el[c_d]=0;
	cur_path[c_d][0]=0;

	new row_path[DJSON_MAX_STRING];
	new row_value[DJSON_MAX_STRING];
	new row_id = 0;
	new row_parent = 0;
	new row_type = 0;

	new File:fhnd=fopen(tofile,io_write);

	new stream[DJSON_MAX_STRING];
	new stream_pos = 0;

	if (!fhnd) {
		format(DJSON_LastError,DJSON_MAX_STRING,"Can not open File for writing!");
		DJSON_LastErrorCode = 2;
		return false;
	}

	if (has_next) {
		db_get_field(res,0,row_path,DJSON_MAX_STRING);
		db_get_field(res,1,row_value,DJSON_MAX_STRING);
		db_get_field(res,2,tmp,DJSON_MAX_STRING);
		row_type = strval(tmp);
		db_get_field(res,3,tmp,DJSON_MAX_STRING);
		row_id = strval(tmp);
		db_get_field(res,4,tmp,DJSON_MAX_STRING);
		row_parent = strval(tmp);
	}

	DJSON_cache_putchartofile(fhnd,stream, stream_pos,'{');

	new indention_string[DJSON_MAX_STRING];

	format(indention_string,DJSON_MAX_STRING,"\r\n  ");

	while (row_id != 0) {

		while (row_parent != cur_parent[c_d]) {
			// this is not the correct parent yet, so we need to get down.
			format(indention_string,DJSON_MAX_STRING,"\r\n%s",indention_string[4]);
			DJSON_cache_putstringtofile(fhnd,stream,stream_pos,indention_string);
			if (cur_type[c_d] == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,']');
			c_d--;
		}

		if (cur_type[c_d] == DJSON_TYPE_OBJECT || cur_type[c_d] == DJSON_TYPE_ARRAY) {
			cur_el[c_d]++;
			if (cur_el[c_d]>1) {
				DJSON_cache_putchartofile(fhnd,stream,stream_pos,',');
			}
		}

		DJSON_cache_putstringtofile(fhnd,stream,stream_pos,indention_string);

		if (cur_type[c_d] == DJSON_TYPE_OBJECT) {
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			if (strlen(cur_path[c_d])>0) {
				DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_path[strlen(cur_path[c_d])+1]);
			} else {
				DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_path);
			}
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,':');
		}

		if (row_type == DJSON_TYPE_NUMBER) {
			DJSON_cache_putstringtofile(fhnd,stream,stream_pos,row_value);
		}

		if (row_type == DJSON_TYPE_STRING) {
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
			DJSON_cache_putstringtofile(fhnd,stream,stream_pos,DJSON_json_escape(row_value));
			DJSON_cache_putchartofile(fhnd,stream,stream_pos,'"');
		}

		if (row_type == DJSON_TYPE_OBJECT || row_type == DJSON_TYPE_ARRAY) {
			if (row_type == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'{'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,'[');
			format(indention_string,DJSON_MAX_STRING,"%s  ",indention_string);
			c_d++;
			format(cur_path[c_d],DJSON_MAX_STRING,"%s",row_path);
			cur_parent[c_d] = row_id;
			cur_type[c_d] = row_type;
			cur_el[c_d] = 0;
		}

		has_next = db_next_row(res);

		if (has_next) {
			db_get_field(res,0,row_path,DJSON_MAX_STRING);
			db_get_field(res,1,row_value,DJSON_MAX_STRING);
			db_get_field(res,2,tmp,DJSON_MAX_STRING);
			row_type = strval(tmp);
			db_get_field(res,3,tmp,DJSON_MAX_STRING);
			row_id = strval(tmp);
			db_get_field(res,4,tmp,DJSON_MAX_STRING);
			row_parent = strval(tmp);
		} else {
			row_id = 0;
		}
	}

	while (0 != cur_parent[c_d]) {
		// this is not the correct parent yet, so we need to get down.
		format(indention_string,DJSON_MAX_STRING,"\r\n%s",indention_string[4]);
		DJSON_cache_putstringtofile(fhnd,stream,stream_pos,indention_string);
		if (cur_type[c_d] == DJSON_TYPE_OBJECT) DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}'); else DJSON_cache_putchartofile(fhnd,stream,stream_pos,']');
		c_d--;
	}

	DJSON_cache_putstringtofile(fhnd,stream,stream_pos,"\r\n");
	DJSON_cache_putchartofile(fhnd,stream,stream_pos,'}');

	if (stream_pos>0) {
		stream[stream_pos]=0;
		fwrite(fhnd,stream);
	}
	fclose(fhnd);

	db_free_result(res);
	return true;

}

#endif
/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_debug_print() {
	new DBResult:res;
	res = db_query(DJSON_cache_db,"SELECT `file`,`path`,`value`,`type`,`id`,`parent`,`pos` FROM `c` ORDER BY path");
	new i = 0;
	new file[DJSON_MAX_STRING];
	new key[DJSON_MAX_STRING];
	new value[DJSON_MAX_STRING];
	new type[DJSON_MAX_STRING];
	new id[DJSON_MAX_STRING];
	new pos[DJSON_MAX_STRING];
	new parent[DJSON_MAX_STRING];
	new has_next = db_num_rows(res) != 0;
	new cur_file[DJSON_MAX_STRING] = "\\";
	while (has_next) {
		i++;
		db_get_field(res,0,file,DJSON_MAX_STRING);
		db_get_field(res,1,key,DJSON_MAX_STRING);
		db_get_field(res,2,value,DJSON_MAX_STRING);
		db_get_field(res,3,type,DJSON_MAX_STRING);
		db_get_field(res,4,id,DJSON_MAX_STRING);
		db_get_field(res,5,parent,DJSON_MAX_STRING);
		db_get_field(res,6,pos,DJSON_MAX_STRING);

		new type_id = strval(type);
		if (type_id == 0) {
			type = "---";
		} else if (type_id == DJSON_TYPE_ARRAY) {
			type = "ARR";
		} else if (type_id == DJSON_TYPE_OBJECT) {
			type = "OBJ";
		} else if (type_id == DJSON_TYPE_NUMBER) {
			type = "NUM";
		} else if (type_id == DJSON_TYPE_STRING) {
			type = "STR";
		}

		new line[DJSON_MAX_STRING];
		if (strcmp(cur_file,file,true)) {
			printf(">>%s<<",file);
			cur_file = file;
		}
		format(line,DJSON_MAX_STRING," [%s/%s/%s] '%s' #%s / value:'%s'",id,parent,type,key,pos,value);
		print(line);
		has_next = db_next_row(res);
	}
	db_free_result(res);
}


#define DJSON_STATE_A 1
#define DJSON_STATE_B 2
#define DJSON_STATE_C 3
#define DJSON_STATE_D 4
#define DJSON_STATE_E 5
#define DJSON_STATE_F 6
#define DJSON_STATE_C2 7
#define DJSON_STATE_C3 8
#define DJSON_STATE_C4 9
#define DJSON_STATE_C5 10
#define DJSON_STATE_D2 11
#define DJSON_STATE_F2 12
#define DJSON_STATE_B2 13
#define DJSON_STATE_C6 14

#define DJSON_STATE_G 15

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_UnloadFile(filename[]) {
	new query[DJSON_MAX_STRING];
	format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file='%s'",DJSON_sql_escape(filename));
	db_query(DJSON_cache_db,query);
	format(query,DJSON_MAX_STRING,"DELETE FROM `is_c` WHERE file='%s'",DJSON_sql_escape(filename));
	db_query(DJSON_cache_db,query);
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_IsFileCached(filename[]) {
	new query[DJSON_MAX_STRING];
	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT * FROM `is_c` WHERE file='%s'",DJSON_sql_escape(filename));
	res = db_query(DJSON_cache_db,query);
	new is_cached = db_num_rows(res) != 0;
	db_free_result(res);
	return is_cached;
}

/**
 * @access private
 * @ingroup private
 */
stock DJSON_cache_ReloadFile(filename[]) {
	DJSON_cache_UnloadFile(filename);

	new path_pos = 0;
	new states[DJSON_MAX_DEPTH];
	new states_pos = 0;

	new s = DJSON_STATE_A;
	new pos = 0;

	new File:fohnd;
	new c=0;
	fohnd=fopen(filename,io_read);
	if (!fohnd) {
		format(DJSON_LastError,DJSON_MAX_STRING,"Can not open file %s",filename);
		DJSON_LastErrorCode = 1;
		return false;
	}

	c = fgetchar(fohnd,1);

	new cur_str[DJSON_MAX_STRING];

	new bool:dont_read_next = false;

	while (c!=-1 && s != DJSON_STATE_G) {
		while (c!=-1 && (
					s == DJSON_STATE_C4 ||
					s == DJSON_STATE_C5 ||
					s == DJSON_STATE_C6 ||
					s == DJSON_STATE_C ||
					s == DJSON_STATE_B ||
					s == DJSON_STATE_B2 ||
					s == DJSON_STATE_A
				) && c<33
			) {
			pos++;
			c = fgetchar(fohnd,1);
			if (c==-1) c=-1;
		}

		if (c==-1) {
			fclose(fohnd);
			return true;
		}

		if (s == DJSON_STATE_A) {
			if (c == '[') {
				s = DJSON_STATE_B;
				format(DJSON_path[path_pos],DJSON_MAX_STRING,"%d",0);
				DJSON_path_type[path_pos] = DJSON_TYPE_ARRAY;
				DJSON_path_id[path_pos] = DJSON_cache_createArrayNode(filename,DJSON_implode('/',path_pos),DJSON_path_id[path_pos-1],DJSON_path_arraypos[path_pos-1]-1);
				DJSON_path_arraypos[path_pos]=1;
				path_pos++;
			} else if (c == '{') {
				s = DJSON_STATE_C;

				DJSON_path_type[path_pos] = DJSON_TYPE_OBJECT;
				DJSON_path_id[path_pos] = path_pos==0 ? 0 : DJSON_cache_createObjectNode(filename,DJSON_implode('/',path_pos),path_pos==0 ? 0 : DJSON_path_id[path_pos-1],path_pos==0 ? -1 : DJSON_path_arraypos[path_pos-1]-1);

			} else if (c == '"') {
				cur_str[0] = 0;
				s = DJSON_STATE_D;
			} else if (c == '0') {
				format(cur_str,DJSON_MAX_STRING,"0");
				s = DJSON_STATE_E;
			} else if (c == '-') {
				format(cur_str,DJSON_MAX_STRING,"%c",c);
				s = DJSON_STATE_F;
			} else if (c > '0' && c<='9') {
				format(cur_str,DJSON_MAX_STRING,"%c",c);
				s = DJSON_STATE_F;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %s in DJSON_STATE_A'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_B) {
			if (c == ']') {
				path_pos--;
				s = DJSON_STATE_G;
			} else {
				states[states_pos]=DJSON_STATE_B2;
				states_pos++;
				s = DJSON_STATE_A;
				dont_read_next = true;
			}
		} else if (s == DJSON_STATE_B2) {
			if (c == ']') {
				path_pos--;
				s = DJSON_STATE_G;
			} else if (c == ',') {
				DJSON_path_arraypos[path_pos-1]++;
				format(DJSON_path[path_pos-1],DJSON_MAX_STRING,"%d",DJSON_path_arraypos[path_pos-1]-1);
				states[states_pos]=DJSON_STATE_B2;
				states_pos++;
				s = DJSON_STATE_A;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_B2'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_C) {
			if (c == '}') {
				s = DJSON_STATE_G;
			} else if (c == '"') {
				cur_str[0] = 0;
				s = DJSON_STATE_C2;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_C'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_C2) {
			if (c == '"') {
				s = DJSON_STATE_C4;
			} else if (c == '\\') {
				s = DJSON_STATE_C3;
			} else {
				format(cur_str,DJSON_MAX_STRING,"%s%c",cur_str,c);
			}
		} else if (s == DJSON_STATE_C3) {
			// escaper in string
			if (c == '\\') {
				strcat(cur_str,"\\");
			} else if (c == 'n') {
				strcat(cur_str,"\n");
			} else if (c == 'b') {
				strcat(cur_str,"\b");
			} else if (c == 'f') {
				strcat(cur_str,"\f");
			} else if (c == '"') {
				strcat(cur_str,"\"");
			} else if (c == 'r') {
				strcat(cur_str,"\r");
			} else if (c == 't') {
				strcat(cur_str,"\t");
				format(cur_str,DJSON_MAX_STRING,"%s\t",cur_str);
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_C3'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
			s = DJSON_STATE_C2;
		} else if (s == DJSON_STATE_C4) {
			if (c == ':') {
				format(DJSON_path[path_pos],DJSON_MAX_STRING,"%s",cur_str);
				path_pos++;
				states[states_pos]=DJSON_STATE_C6;
				states_pos++;
				s = DJSON_STATE_A;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_C4'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_C5) {
			if (c == '"') {
				cur_str[0]=0;
				s = DJSON_STATE_C2;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_C5'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_C6) {
			if (c == '}') {
				path_pos--;
				s = DJSON_STATE_G;
			} else if (c == ',') {
				path_pos--;
				s = DJSON_STATE_C5;
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_C6'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
		} else if (s == DJSON_STATE_D) {
			// string
			if (c == '\\') {
				s = DJSON_STATE_D2;
			} else if (c == '"') {
				DJSON_cache_createString(filename,DJSON_implode('/',path_pos),cur_str,DJSON_path_id[path_pos-1],DJSON_path_arraypos[path_pos-1]-1);
				s = DJSON_STATE_G;
			} else {
				format(cur_str,DJSON_MAX_STRING,"%s%c",cur_str,c);
			}
		} else if (s == DJSON_STATE_D2) {
			// escaper in string
			if (c == '\\') {
				format(cur_str,DJSON_MAX_STRING,"%s\\",cur_str);
			} else if (c == 'n') {
				format(cur_str,DJSON_MAX_STRING,"%s\n",cur_str);
			} else if (c == 'b') {
				format(cur_str,DJSON_MAX_STRING,"%s\b",cur_str);
			} else if (c == 'f') {
				format(cur_str,DJSON_MAX_STRING,"%s\f",cur_str);
			} else if (c == '"') {
				format(cur_str,DJSON_MAX_STRING,"%s\"",cur_str);
			} else if (c == 'r') {
				format(cur_str,DJSON_MAX_STRING,"%s\r",cur_str);
			} else if (c == 't') {
				format(cur_str,DJSON_MAX_STRING,"%s\t",cur_str);
			} else {
				format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid Token %c in DJSON_STATE_D2'",c);
				DJSON_LastErrorCode = 2;
				fclose(fohnd);
				return false;
			}
			s = DJSON_STATE_D;
		} else if (s == DJSON_STATE_E) {
			if (c == '.') {
				format(cur_str,DJSON_MAX_STRING,"%s.",cur_str);
				s = DJSON_STATE_F2;
			} else {
				DJSON_cache_createNumberFromStr(filename,DJSON_implode('/',path_pos),cur_str,DJSON_path_id[path_pos-1],DJSON_path_arraypos[path_pos-1]-1);
				dont_read_next=true;
				s = DJSON_STATE_G;
			}
		} else if (s == DJSON_STATE_F) {
			if (c >= '0' && c<='9') {
				format(cur_str,DJSON_MAX_STRING,"%s%c",cur_str,c);
			} else if (c=='.') {
				format(cur_str,DJSON_MAX_STRING,"%s%c",cur_str,c);
				s = DJSON_STATE_F2;
			} else {
				DJSON_cache_createNumberFromStr(filename,DJSON_implode('/',path_pos),cur_str,DJSON_path_id[path_pos-1],DJSON_path_arraypos[path_pos-1]-1);
				dont_read_next=true;
				s = DJSON_STATE_G;
			}
		} else if (s == DJSON_STATE_F2) {
			if (c >= '0' && c<='9') {
				format(cur_str,DJSON_MAX_STRING,"%s%c",cur_str,c);
			} else {
				DJSON_cache_createNumberFromStr(filename,DJSON_implode('/',path_pos),cur_str,DJSON_path_id[path_pos-1],DJSON_path_arraypos[path_pos-1]-1);
				dont_read_next=true;
				s = DJSON_STATE_G;
			}
		} else {
			format(DJSON_LastError,DJSON_MAX_STRING,"'Invalid State %d'",s);
			DJSON_LastErrorCode = 3;
			fclose(fohnd);
			return false;
		}

		if (!dont_read_next) {
			pos++;
			c = fgetchar(fohnd,1);
		} else {
			dont_read_next = false;
		}
		if (s == DJSON_STATE_G) {
			if (states_pos!=0) {
				states_pos--;
				s = states[states_pos];
			}
		}
	}
	DJSON_LastErrorCode = 0;

	new query[DJSON_MAX_STRING];
	format(query,DJSON_MAX_STRING,"INSERT INTO `is_c` (`file`) VALUES ('%s')",DJSON_sql_escape(filename));
	db_query(DJSON_cache_db,query);

	fclose(fohnd);
	return true;
}

/**
 * @access private
 * @ingroup private
 * @return int id of the element
 */
stock DJSON_prepareTreeForPath(file[],path[]) {
	if (!DJSON_cache_IsFileCached(file)) {
		DJSON_cache_ReloadFile(file);
		if (DJSON_LastErrorCode == 1) {
			new File:fhnd = fopen(file,io_write);
			if (!fhnd) {
				// ok, we can't even create it!
				return 0;
			}
			fwrite(fhnd,"{}");
			fclose(fhnd);
		}
	}
	new query[DJSON_MAX_STRING];

	// Secure, that everypart is available:
	new path_len = strlen(path);
	new current_path_depth=0;
	new current_path_part[DJSON_MAX_STRING];
	new current_path_part_len = 0;
	new current_path[DJSON_MAX_DEPTH][DJSON_MAX_STRING];

	new parent_id = 0;

	new tmp[DJSON_MAX_STRING];
	new our_current_path[DJSON_MAX_STRING];

	for (new i=0;i<path_len;i++) {
		if (path[i]=='/') {
			if (current_path_part_len == 0) {
				DJSON_LastErrorCode = 6;
				format(DJSON_LastError,DJSON_MAX_STRING,"The path %s is invalid",path);
				return 0;
			}

			new DBResult:res;
			format(our_current_path,DJSON_MAX_STRING,"%s",DJSON_ret_memcpy(path,0,i));
			format(query,DJSON_MAX_STRING,"SELECT id,`type`,`pos` FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),our_current_path);
			res = db_query(DJSON_cache_db,query);
			if (db_num_rows(res) == 1) {
				// it exists

				db_get_field(res,2,query,DJSON_MAX_STRING);
				new prev_pos = strval(query);
				db_get_field(res,0,query,DJSON_MAX_STRING);
				new prev_parent_id = parent_id;
				parent_id = strval(query);
				db_get_field(res,1,tmp,DJSON_MAX_STRING);
				db_free_result(res);

				if (strval(tmp)!=DJSON_TYPE_OBJECT && strval(tmp)!=DJSON_TYPE_ARRAY) {
					// it is _no_ object nor an array, so we have to remove it :/.
					format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file = '%s' AND path = '%s'",DJSON_sql_escape(file),our_current_path);
					db_query(DJSON_cache_db,query);
					format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file = '%s' AND path LIKE '%s/%s'",DJSON_sql_escape(file),our_current_path,"%");
					db_query(DJSON_cache_db,query);

					parent_id = DJSON_cache_createObjectNode(file,DJSON_ret_memcpy(path,0,i),prev_parent_id,prev_pos);
				}
			} else {
				// The something/this is missing, so we can't create something/this/that
				// thatswhy we create something/this first
				db_free_result(res);
				parent_id = DJSON_cache_createObjectNode(file,DJSON_ret_memcpy(path,0,i),parent_id);
			}

			format(current_path[current_path_depth],DJSON_MAX_STRING,"%s",current_path_part);
			current_path_depth++;
			current_path_part_len=0;
			current_path_part[0]=0;
		} else {
			current_path_part[current_path_part_len] = path[i];
			current_path_part_len++;
		}
	}

	// Unset its children
	format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file = '%s' AND path LIKE '%s/%s'",DJSON_sql_escape(file),DJSON_sql_escape(path),"%");
	db_query(DJSON_cache_db,query);

	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT id,`type` FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),path);
	res = db_query(DJSON_cache_db,query);

	if (db_num_rows(res) != 1) {
		db_free_result(res);
		// it does not exist, let's create it!

		return DJSON_cache_createString(file,path,"",parent_id);
	} else {
		// it does exist, great!
		db_get_field(res,0,query,DJSON_MAX_STRING);
		new id = strval(query);
		db_free_result(res);
		return id;
	}
}

/**
 * Calculate the Items of a djson-Array
 *
 * @param string file Name of the file
 * @param string path Path you want to count
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @ingroup djson
 * @return int Number of items in the djson Array
 */
stock djCount(file[],path[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);
	new query[DJSON_MAX_STRING];
	new DBResult:res;

	format(query,DJSON_MAX_STRING,"SELECT id,type FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(path));
	res = db_query(DJSON_cache_db,query);
	new parent_id;
	if (db_num_rows(res) == 1) {
		// it exists ...
		db_get_field(res,0,query,DJSON_MAX_STRING);
		parent_id = strval(query);
		db_get_field(res,1,query,DJSON_MAX_STRING);
		db_free_result(res);
		if (strval(query)!=DJSON_TYPE_ARRAY) {
			format(DJSON_LastError,DJSON_MAX_STRING,"The path %s, is not an array!",path);
			DJSON_LastErrorCode = 7;
			return 0;
		}
	} else {
		db_free_result(res);
		// does not exist!
		return 0;
	}
	format(query,DJSON_MAX_STRING,"SELECT COUNT(pos) m_p FROM `c` WHERE file = '%s' AND parent = %d",DJSON_sql_escape(file),parent_id);
	res = db_query(DJSON_cache_db,query);
	if (db_num_rows(res) == 1) {
		db_get_field(res,0,query,DJSON_MAX_STRING);
		db_free_result(res);
		return strval(query);
	} else {
		db_free_result(res);
		return 0;
	}
}


/**
 * Checks if a specific path in the json-file exists
 *
 * Example:
 * 	djIsSet("draco.json","player/name")
 * will return true if the draco.json looks like that:
 *  {"player":{"name":"DracoBlue"}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @return bool If the path is available
 * @ingroup djson
 */
stock djIsSet(file[],path[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);
	new query[DJSON_MAX_STRING];
	if (DJSON_LastErrorCode) {
		return false;
	}

	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT `value` FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(path));
	res = db_query(DJSON_cache_db,query);
	if (db_num_rows(res) == 1) {
		db_free_result(res);
		return true;
	} else {
		db_free_result(res);
		return false;
	}
}

/**
 * Unsets a specific path in a json-file
 *
 * Example:
 * 	djUnset("draco.json","player/pos")
 * will unset
 *  {"player":{"name":"DracoBlue"}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @return bool If it was posssible to unset the value
 * @see djAutocommit
 * @see djCommit
 * @ingroup djson
 */
stock djUnset(file[],path[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);
	new query[DJSON_MAX_STRING];
	if (DJSON_LastErrorCode) {
		return false;
	}

	// let's find out, if the entry is an item of an array
	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT parent,pos FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(path));
	res = db_query(DJSON_cache_db,query);
	if (db_num_rows(res) == 1) {
		// it exists ...
		new parent_id, pos_in_array;
		db_get_field(res,0,query,DJSON_MAX_STRING);
		parent_id = strval(query);
		db_get_field(res,1,query,DJSON_MAX_STRING);
		pos_in_array = strval(query);
		db_free_result(res);

		// first of all: let's remove the item, we'll take care of the rest later!
		format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file = '%s' AND path = '%s'",DJSON_sql_escape(file),DJSON_sql_escape(path));
		db_query(DJSON_cache_db,query);
		format(query,DJSON_MAX_STRING,"DELETE FROM `c` WHERE file = '%s' AND path LIKE '%s/%s'",DJSON_sql_escape(file),DJSON_sql_escape(path),"%");
		db_query(DJSON_cache_db,query);

		// is direct child of an array ?
		if (pos_in_array!=-1) {
			// so we need to rearrange the items now.

			format(query,DJSON_MAX_STRING,"SELECT path FROM `c` WHERE file = '%s' AND id = %d LIMIT 1",DJSON_sql_escape(file),parent_id);
			res = db_query(DJSON_cache_db,query);
			new parent_path[DJSON_MAX_STRING];
			db_get_field(res,0,parent_path,DJSON_MAX_STRING);
			db_free_result(res);

			new shifting_min = pos_in_array+1;
			new shifting_max;

			format(query,DJSON_MAX_STRING,"SELECT COUNT(id) m_p FROM `c` WHERE file = '%s' AND parent = %d",DJSON_sql_escape(file),parent_id);
			res = db_query(DJSON_cache_db,query);
			if (db_num_rows(res) == 1) {
				db_get_field(res,0,query,DJSON_MAX_STRING);
				shifting_max = strval(query);
			} else {
				shifting_max = shifting_min;
			}
			db_free_result(res);

			new shifting_pos = shifting_min - 1;
			new its_id = 0;
			new has_next = false;
			while (shifting_pos<shifting_max) {
				shifting_pos++;

				// receive all items, which are in children of the parts, except the direct children!
				format(query,DJSON_MAX_STRING,"SELECT id,path FROM `c` WHERE file = '%s' AND path LIKE '%s/%d/%s'",DJSON_sql_escape(file),DJSON_sql_escape(parent_path),shifting_pos,"%");
				res = db_query(DJSON_cache_db,query);
				has_next = (db_num_rows(res) > 0);
				while (has_next) {
					db_get_field(res,0,query,DJSON_MAX_STRING);
					its_id = strval(query);
					db_get_field(res,1,query,DJSON_MAX_STRING);
					// query = items path, its_id = id

					format(query,DJSON_MAX_STRING,"UPDATE `c` SET path='%s/%d%s' WHERE file = '%s' AND id = %d",DJSON_sql_escape(parent_path),shifting_pos-1,query[strlen(parent_path)+floatround(shifting_pos/10)+2],DJSON_sql_escape(file),its_id);
					db_query(DJSON_cache_db,query);

					has_next = db_next_row(res);
				}
				db_free_result(res);
			}

			// receive all items now, which are direct children!
			format(query,DJSON_MAX_STRING,"SELECT id,pos FROM `c` WHERE file = '%s' AND parent=%d AND pos>%d",DJSON_sql_escape(file),parent_id,shifting_min-1);
			res = db_query(DJSON_cache_db,query);
			has_next = (db_num_rows(res) > 0);
			new cur_pos = 0;
			while (has_next) {
				db_get_field(res,0,query,DJSON_MAX_STRING);
				its_id = strval(query);
				db_get_field(res,1,query,DJSON_MAX_STRING);
				cur_pos = strval(query);

				format(query,DJSON_MAX_STRING,"UPDATE `c` SET path='%s/%d',pos=%d WHERE file = '%s' AND id = %d",DJSON_sql_escape(parent_path),cur_pos-1,cur_pos-1,DJSON_sql_escape(file),its_id);
				db_query(DJSON_cache_db,query);

				has_next = db_next_row(res);
			}
			db_free_result(res);
		}

		if (DJSON_autocommit) djCommit(file);

		return true;
	} else {
		// it does not ..., but it's unset: true!
		db_free_result(res);
		return true;
	}
}


/**
 * Append an item to a djson-Array
 * @param string file Name of the file
 * @param string path Path you want to append to
 * @param string value String you want to append
 * @param bool use_cached_value Set this to false, if you want to reload the file every time
 * @return bool If it was possible to append the value
 * @ingroup djson
 * @see djAutocommit
 * @see djCommit
 */
stock djAppend(file[],path[],value[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);
	new query[DJSON_MAX_STRING];
	if (DJSON_LastErrorCode) {
		return false;
	}

	// let's find out, if the entry is an item of an array
	new DBResult:res;
	new parent_id;
	format(query,DJSON_MAX_STRING,"SELECT id,type FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(path));
	res = db_query(DJSON_cache_db,query);
	new the_pos = 0;
	if (db_num_rows(res) == 1) {

		new row_type;
		db_get_field(res,0,query,DJSON_MAX_STRING);
		parent_id = strval(query);
		db_get_field(res,1,query,DJSON_MAX_STRING);
		row_type = strval(query);
		db_free_result(res);
		if (row_type != DJSON_TYPE_ARRAY) {
			DJSON_LastErrorCode = 7;
			format(DJSON_LastError,DJSON_MAX_STRING,"The path %s, is not an array!",path);
			return false;
		}

		format(query,DJSON_MAX_STRING,"SELECT COUNT(pos) m_p FROM `c` WHERE file = '%s' AND parent = %d",DJSON_sql_escape(file),parent_id);
		res = db_query(DJSON_cache_db,query);
		if (db_num_rows(res) == 1) {
			db_get_field(res,0,query,DJSON_MAX_STRING);
			the_pos = strval(query);
		} else {
			the_pos = 0;
		}
		db_free_result(res);
	} else {
		db_free_result(res);
		// it does not exist yet!

		parent_id = DJSON_prepareTreeForPath(file,path);

		// if creating the tree path, failed :(
		if (DJSON_LastErrorCode) {
			return false;
		}

		parent_id = DJSON_cache_updateArrayNode(file,path);
	}

	new tmp[DJSON_MAX_STRING];
	format(tmp,DJSON_MAX_STRING,"%s/%d",path,the_pos);

	DJSON_cache_createNode(file,tmp,DJSON_TYPE_STRING,value,parent_id,the_pos);

	if (DJSON_autocommit) djCommit(file);

	return true;
}

/**
 * Set a specific path string value
 *
 * Example:
 * 	djSet("draco.json","player/name","Hans")
 * will set
 *  {"player":{"name":"Hans"}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param string new_value The new value
 * @param bool use_cached_value Set this to false, if you want to reload the file every time
 * @return bool If it was posssible to set the value
 * @see djAutocommit
 * @see djCommit
 * @ingroup djson
 */
stock djSet(file[],path[],new_value[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);

	DJSON_prepareTreeForPath(file,path);

	// And update it:
	DJSON_cache_updateString(file,path,new_value);

	if (DJSON_autocommit) djCommit(file);
	return true;
}

/**
 * Set a specific path integer value
 *
 * Example:
 * 	djSetInt("draco.json","player/id",5)
 * will set
 *  {"player":{"name":"Hans","id":5}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param int new_value The new value
 * @param bool use_cached_value Set this to false, if you want to reload the file every time
 * @return bool If it was posssible to set the value
 * @see djAutocommit
 * @see djCommit
 * @ingroup djson
 */
stock djSetInt(file[],path[],new_value,use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);

	DJSON_prepareTreeForPath(file,path);

	// And update it:
	DJSON_cache_updateNumber(file,path,new_value);

	if (DJSON_autocommit) djCommit(file);
	return true;
}

/**
 * Set a specific path integer value
 *
 * Example:
 * 	djSetFloat("draco.json","player/pos/x",15.5)
 * will set
 *  {"player":{"name":"Hans","pos":{"x":15.5}}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param float new_value The new value
 * @param bool use_cached_value Set this to false, if you want to reload the file every time
 * @return bool If it was posssible to set the value
 * @see djAutocommit
 * @see djCommit
 * @ingroup djson
 */
stock djSetFloat(file[],path[],Float:new_value,use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);

	DJSON_prepareTreeForPath(file,path);

	// And update it:
	new tmp[DJSON_MAX_STRING];
	format(tmp,DJSON_MAX_STRING,"%f",new_value);
	DJSON_cache_updateNumberFromStr(file,path,tmp);

	if (DJSON_autocommit) djCommit(file);
	return true;
}

/**
 * Reads a specific value from a json-File by path
 *
 * Example:
 * 	dj("draco.json","player/name")
 * will return "DracoBlue" if the draco.json looks like that:
 *  {"player":{"name":"DracoBlue"}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @return string The value of the path or ""
 * @ingroup djson
 */
stock dj(file[],path[],use_cached_value=true) {
	DJSON_LastErrorCode=0;
	if (!DJSON_cache_IsFileCached(file) || !use_cached_value) DJSON_cache_ReloadFile(file);
	new query[DJSON_MAX_STRING];
	if (DJSON_LastErrorCode) {
		query[0] = 0;
		return query;
	}

	new DBResult:res;
	format(query,DJSON_MAX_STRING,"SELECT `value` FROM `c` WHERE file = '%s' AND path = '%s' LIMIT 1",DJSON_sql_escape(file),DJSON_sql_escape(path));
	res = db_query(DJSON_cache_db,query);
	if (db_num_rows(res) == 1) {
		db_get_field(res,0,query,DJSON_MAX_STRING);
	} else {
		query[0] = 0;
		DJSON_LastErrorCode = 4;
		format(DJSON_LastError,DJSON_MAX_STRING,"The path %s is not set",path);
	}
	db_free_result(res);
	return query;
}

/**
 * Reads a specific value from a json-File by path
 *
 * Example:
 * 	djInt("draco.json","player/id")
 * will return 2 if the draco.json looks like that:
 *  {"player":{"name":"DracoBlue","id":2}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @return int The value of the path or 0
 * @ingroup djson
 */
stock djInt(file[],path[],use_cached_value=true) {
	return strval(dj(file,path,use_cached_value));
}

/**
 * Reads a specific value from a json-File by path
 *
 * Example:
 * 	djInt("draco.json","player/posx")
 * will return 15.5 if the draco.json looks like that:
 *  {"player":{"name":"DracoBlue","pos":{"x":15.5,"y":20.0"}}}
 * @param string file Name of the json file
 * @param string path Name of the path in the file
 * @param bool use_cached_value Set this to false, if you want to reload the file everytime
 * @return float The value of the path or 0.0
 * @ingroup djson
 */
stock Float:djFloat(file[],path[],use_cached_value=true) {
	return floatstr(dj(file,path,use_cached_value));
}

/**
 * Activates and deactivates djson autocommit
 * @param bool toggle Set this true to enable autocommit, set it to false to disable!
 * @ingroup djson
 * @see djRevert
 * @see djCommit
 */
stock djAutocommit(toggle) {
	DJSON_autocommit = toggle;
}

/**
 * Commit changes to a json file to the filesystem
 * @param string file Name of the json file
 * @return bool If it was possible to commit the changes
 * @ingroup djson
 * @see djAutocommit
 * @see djRevert
 */
stock djCommit(file[]) {
	DJSON_LastErrorCode = 0;
	DJSON_cache_debug_save_file(file,file);
	return (DJSON_LastErrorCode == 0);
}

/**
 * Revert changes from a json file and reload from disk
 * @param string file Name of the json file
 * @return bool If it was possible to revert the changes
 * @ingroup djson
 * @see djAutocommit
 * @see djCommit
 */
stock djRevert(file[]) {
	DJSON_LastErrorCode = 0;
	DJSON_cache_ReloadFile(file);
	return (DJSON_LastErrorCode == 0);
}

#if DJSON_ALLOW_STYLED_OUTPUT
/**
 * Activates and deactivates djson styled output
 * @param bool toggle Set this true to enable indented json file output
 * @ingroup djson
 */
stock djStyled(toggle) {
	DJSON_styled_output = toggle;
}
#endif

/**
 * Creates a new dj-File
 * @param string file Name of the json file
 * @return bool If it was possible to create it
 * @ingroup djson
 */
stock djCreateFile(file[]) {
	DJSON_LastErrorCode=0;
	new File:fhnd = fopen(file,io_write);
	if (!fhnd) {
		DJSON_LastErrorCode = 1;
		format(DJSON_LastError,DJSON_MAX_STRING,"File %s was not created, can't open file!",file);
		return false;
	}
	fwrite(fhnd,"{}");
	fclose(fhnd);
	if (DJSON_cache_IsFileCached(file)) DJSON_cache_UnloadFile(file);
	return true;
}

/**
 * Removes a dj-File
 * @param string file Name of the json file
 * @return bool If it was possible to remove it
 * @ingroup djson
 */
stock djRemoveFile(file[]) {
	DJSON_LastErrorCode=0;
	if (DJSON_cache_IsFileCached(file)) DJSON_cache_UnloadFile(file);
	if (fremove(file)) {
		DJSON_LastErrorCode = 1;
		format(DJSON_LastError,DJSON_MAX_STRING,"File %s was not accessible, can't remove file!",file);
		return false;
	}
	return true;
}

/**
 * Initializes the djson-Engine, _must_ be executed on gamemode init!
 * @ingroup callback
 * @see djson_GameModeExit
 */
djson_GameModeInit() {
	DJSON_cache_init();

#if DJSON_RUN_TESTCASES_AT_INIT

	printf("[djson] Initializing TestCases");

	printf(" o Creating djson_test.json");
	print(" 	\"player\": {");
	print(" 	  \"name\": \"Draco\",");
	print(" 	  \"pos\": {");
	print(" 	    \"x\": 15.0,");
	print(" 	    \"y\": 20");
	print(" 	  }");
	print(" 	}");
	new File:fhnd = fopen("djson_test.json",io_write);
	fwrite(fhnd,"{\"player\":{\"name\":\"Draco\",\"pos\":{\"x\":15.0,\"y\":20}}}");
	fclose(fhnd);

	new BEFORE_AUTOCOMMIT_VAL = DJSON_autocommit;

	// Even though this is the default, reforce it!
	djAutocommit(true);

	if (DJSON_cache_ReloadFile("djson_test.json")) {
		print(" o Loading djson_test.json worked!");
	} else {
		printf(" x Error loading djson_test.json: %s", DJSON_LastError);
		return ;
	}

	djStyled(true);
	DJSON_cache_debug_save_file("djson_test.json","djson_test_styled.json");
	djStyled(false);

	// try loading all data, and check if correct
	new tmp[DJSON_MAX_STRING];
	new tmp_int;
	new Float:tmp_float;

	format(tmp,DJSON_MAX_STRING,dj("djson_test.json","player/name"));
	if (strcmp(tmp,"Draco")!=0 && strlen(tmp)==0) printf(" x Error reading: player/name, was: %s",tmp);
		else printf(" o Read: player/name, is: %s",tmp);

	if (djFloat("djson_test.json","player/pos/x")!=15.0) printf(" x Error reading: player/pos/x, was: %f",djFloat("djson_test.json","player/pos/x"));
		else printf(" o Read: player/pos/x, is: %f",djFloat("djson_test.json","player/pos/x"));

	if (djInt("djson_test.json","player/pos/y")!=20) printf(" x Error reading: player/pos/y, was: %d",djInt("djson_test.json","player/pos/y"));
		else printf(" o Read: player/pos/y, is: %d",djInt("djson_test.json","player/pos/y"));

	if (djInt("djson_test.json","player/pos/d")!=0) printf(" x Error reading: player/pos/d, was: %d",djInt("djson_test.json","player/pos/d"));
		else printf(" o Read: player/pos/d, is: %d",djInt("djson_test.json","player/pos/d"));

	if (djInt("djson_test.json","player/pos/y")!=20) printf(" x Error reading: player/pos/y, was: %d",djInt("djson_test.json","player/pos/y"));
		else printf(" o Read: player/pos/y, is: %d",djInt("djson_test.json","player/pos/y"));
		
	// Create a player/id entry
	if (djIsSet("djson_test.json","player/id")) printf(" x Error player/id should not be set");
		else printf(" o Check player/id is not set, yet: correct!");

	if (!djSetInt("djson_test.json","player/id",2)) printf(" x Error creating player/id");
		else printf(" o Created player/id");

	if (djInt("djson_test.json","player/id")!=2) printf(" x Error reading: player/id, was: %d",djInt("djson_test.json","player/id"));
		else printf(" o Read: player/id, is: %d",djInt("djson_test.json","player/id"));


	// some complicated testing now
	if (!djSet("djson_test.json","this/is/a/path","a value")) printf(" x Error creating this/is/a/path");
		else printf(" o Created this/is/a/path");

	if (!djUnset("djson_test.json","this/is/a")) printf(" x Error unsetting this/is/a");
		else printf(" o Unset this/is/a");

	if (djIsSet("djson_test.json","this/is/a")) printf(" x Error this/is/a should not be set");
		else printf(" o Check this/is/a is not set, yet: correct!");

	if (djIsSet("djson_test.json","this/is/a/path")) printf(" x Error this/is/a/path should not be set");
		else printf(" o Check this/is/a/path is not set, yet: correct!");

	if (!djIsSet("djson_test.json","this/is")) printf(" x Error this/is should be set");
		else printf(" o Check this/is should be set, yet: correct!");

	if (!djSet("djson_test.json","this/is","a value")) printf(" x Error setting this/is");
		else printf(" o Setting this/is");

	format(tmp,DJSON_MAX_STRING,dj("djson_test.json","this/is"));
	if (strcmp(tmp,"a value")!=0 && strlen(tmp)==0) printf(" x Error reading: this/is, was: %s",tmp);
		else printf(" o Read: this/is, is: %s",tmp);

	if (!djUnset("djson_test.json","this")) printf(" x Error unsetting this");
		else printf(" o Unset this");


	// we'll create something strange now, to check if the auto-path-creation works
	if (!djSet("djson_test.json","player/about/web/site","http://dracoblue.net")) printf(" x Error creating player/about/web/site");
		else printf(" o Created player/about/web/site");

	if (!djIsSet("djson_test.json","player/about/web")) printf(" x Error player/about/web should be set");
		else printf(" o Check player/about/web should be set, yet: correct!");

	format(tmp,DJSON_MAX_STRING,dj("djson_test.json","player/about/web/site"));
	if (strcmp(tmp,"http://dracoblue.net")!=0 && strlen(tmp)==0) printf(" x Error reading: player/about/web/site, was: %s",tmp);
		else printf(" o Read: player/about/web/site, is: %s",tmp);


	// Now let's have some fun with the arrays
	if (!djAppend("djson_test.json","vehicle/ids","35")) printf(" x Error not existant vehicle/ids should be possible to append.");
		else printf(" o The non existant vehicle/ids should be possible to append: correct!");

	if (!djAppend("djson_test.json","vehicle/ids","12")) printf(" x Error vehicle/ids should be appendable");
		else printf(" o The vehicle/ids should be appendable: correct!");

	if (!djAppend("djson_test.json","vehicle/ids","2")) printf(" x Error vehicle/ids should be appendable");
		else printf(" o The vehicle/ids should be appendable: correct!");

	if (!djAppend("djson_test.json","vehicle/ids","234")) printf(" x Error vehicle/ids should be appendable");
		else printf(" o The vehicle/ids should be appendable: correct!");

	tmp_int = djInt("djson_test.json","vehicle/ids/3");
	if (tmp_int!=234) printf(" x Error reading: vehicle/ids/3, was: %d",tmp_int);
		else printf(" o Read: vehicle/ids/3, is: %d",tmp_int);

	if (!djAppend("djson_test.json","vehicle/ids","123")) printf(" x Error vehicle/ids should be appendable");
		else printf(" o The vehicle/ids should be appendable: correct!");

	DJSON_cache_debug_print();

	if (!djUnset("djson_test.json","vehicle/ids/0")) printf(" x Error unsetting vehicle/ids/2");
		else printf(" o Unset vehicle/ids/0");

	if (!djUnset("djson_test.json","vehicle/ids/2")) printf(" x Error unsetting vehicle/ids/2");
		else printf(" o Unset vehicle/ids/2");

	DJSON_cache_debug_print();

	tmp_int = djInt("djson_test.json","vehicle/ids/2");
	if (tmp_int!=123) printf(" x Error reading: vehicle/ids/2, was: %d",tmp_int);
		else printf(" o Read: vehicle/ids/2, is: %d",tmp_int);

	// Check the value now
	tmp_int = djInt("djson_test.json","vehicle/ids/0");
	if (tmp_int!=12) printf(" x Error reading: vehicle/ids/0, was: %d",tmp_int);
		else printf(" o Read: vehicle/ids/0, is: %d",tmp_int);
	tmp_int = djInt("djson_test.json","vehicle/ids/1");
	if (tmp_int!=2) printf(" x Error reading: vehicle/ids/1, was: %d",tmp_int);
		else printf(" o Read: vehicle/ids/1, is: %d",tmp_int);

	tmp_int = djCount("djson_test.json","vehicle/ids");
	if (tmp_int!=3) printf(" x Error counting the vehicleids, were: %d",tmp_int);
		else printf(" o Found a total of %d vehicle/ids",tmp_int);

	// now check the autocommit feature
	djAutocommit(false);
	if (!djSetFloat("djson_test.json","player/id",1.0)) printf(" x Error creating player/id");
		else printf(" o Set player/id to cache");

	if (!djSetInt("djson_test.json","player/id",1)) printf(" x Error setting player/id");
		else printf(" o Set player/id to cache");

	if (djInt("djson_test.json","player/id")!=1) printf(" x Error reading: player/id, was: %d",djInt("djson_test.json","player/id"));
		else printf(" o Read: player/id from cache, is: %d",djInt("djson_test.json","player/id"));

	if (djInt("djson_test.json","player/id")!=1) printf(" x Error reading: player/id, was: %d",djInt("djson_test.json","player/id"));
		else printf(" o Read: player/id from cache, is: %d",djInt("djson_test.json","player/id"));

	tmp_int = djInt("djson_test.json","player/id",false);
	if (tmp_int!=2) printf(" x Error reading: player/id from file, was: %d",tmp_int);
		else printf(" o Read: player/id from file (instead of cache), is: %d",tmp_int);

	// Now doing that again, but commiting the changes
	if (!djSetInt("djson_test.json","player/id",1)) printf(" x Error creating player/id");
		else printf(" o Set player/id to cache");

	djCommit("djson_test.json");

	tmp_int = djInt("djson_test.json","player/id",false);
	if (tmp_int!=1) printf(" x Error reading: player/id from file, was: %d",tmp_int);
		else printf(" o Read: player/id from file (instead of cache), is: %d",tmp_int);


	printf(" o Testing reference values:");
	print("	 {");
	print("	   \"player\":{");
	print("	     \"about\":{");
	print("	       \"web\":{");
	print("	       \"site\":\"http://dracoblue.net\"");
	print("	       }");
	print("	     },");
	print("	     \"id\":1,");
	print("	     \"name\":\"Draco\",");
	print("	     \"pos\":{");
	print("	       \"x\":15.0,");
	print("	       \"y\":20");
	print("	     }");
	print("	   },");
	print("	   \"vehicle\":{");
	print("	     \"ids\":[");
	print("	       \"12\",");
	print("	       \"2\",");
	print("	       \"123\"");
	print("	     ]");
	print("	   }");
	print("	 }");

	// now let's check if the file is correct
	fhnd = fopen("djson_test.json",io_read);
	fread(fhnd,tmp,DJSON_MAX_STRING);
	fclose(fhnd);
	new what_we_want[] = "{\"player\":{\"about\":{\"web\":{\"site\":\"http://dracoblue.net\"}},\"id\":1,\"name\":\"Draco\",\"pos\":{\"x\":15.0,\"y\":20}},\"vehicle\":{\"ids\":[\"12\",\"2\",\"123\"]}}";
	new what_we_want_pos = 0;
	new was_correct = true;
	while (what_we_want_pos<strlen(what_we_want)) {
		if (what_we_want[what_we_want_pos]!=tmp[what_we_want_pos]) {
			printf(" x Character %d (%c!=%c) was wrong in generated djson_test.json!",what_we_want_pos,tmp[what_we_want_pos],what_we_want[what_we_want_pos]);
			was_correct = false;
		}
		what_we_want_pos++ ;
	}

	if (was_correct) printf(" o Checked generated djson_test.json: correct!");

	DJSON_cache_debug_print();

	DJSON_cache_UnloadFile("djson_test.json");


	printf("%s",dj("djson_simple_test.json","test2"));

	djAutocommit(true);

	// now let's test a simple testcase:
	djCreateFile("djson_simple_test.json");

	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/0","Hallo");
	DJSON_cache_debug_print();
	djSet("djson_simple_test.json","items/0/id","2");
	DJSON_cache_debug_print();

	djUnset("djson_simple_test.json","items/0");
	DJSON_cache_debug_print();

	djCommit("djson_simple_test.json");
	djRemoveFile("djson_simple_test.json");

	// now let's do a simple different testcase:
	djCreateFile("djson_simple_test.json");

	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/0/id","123");
	djSet("djson_simple_test.json","items/0/name","A");
	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/1/id","234");
	djSet("djson_simple_test.json","items/1/name","\"B\"");
	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/2/id","345");
	djSet("djson_simple_test.json","items/2/name","C");
	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/3/id","456");
	djSet("djson_simple_test.json","items/3/name","D");
	djAppend("djson_simple_test.json","items","");
	djSet("djson_simple_test.json","items/4/id","567");
	djSet("djson_simple_test.json","items/4/name","E");


	DJSON_cache_debug_print();

	printf("unsetting ...");
	djUnset("djson_simple_test.json","items/2");
	printf("unsetting ... done!");

	DJSON_cache_debug_print();

	printf("reading something with \" and  \" ...");
	DJSON_cache_UnloadFile("djson_simple_test.json");
	format(tmp,DJSON_MAX_STRING,dj("djson_simple_test.json","items/1/name"));
	if (strcmp(tmp,"\"B\"")!=0 || strlen(tmp)==0) printf(" X Could not read the escaped value back, it's: %s", tmp);
		else printf(" o Could read the escaped value back, it's: %s", tmp);

	printf("reading something with \" and  \" ... done");

	djCreateFile("djson_number_test.json");
	djAutocommit(true);

	djSetInt("djson_number_test.json","number/one/is",200);
	djSetInt("djson_number_test.json","number/two/is",-210);
	djSetInt("djson_number_test.json","number/three",0);
	djSetFloat("djson_number_test.json","number/four",0.5);
	djSetFloat("djson_number_test.json","number/five",-0.1);
	djSetFloat("djson_number_test.json","number/six",-1.2);
	djSetFloat("djson_number_test.json","number/seven",-1.0);

	DJSON_cache_UnloadFile("djson_number_test.json");

	tmp_int = djInt("djson_number_test.json","number/one/is",false);
	if (tmp_int!=200) printf(" x Error reading: number/one/is from file, was: %d",tmp_int);
		else printf(" o Read: number/one/is from file, is: %d",tmp_int);

	tmp_int = djInt("djson_number_test.json","number/two/is",false);
	if (tmp_int!=-210) printf(" x Error reading: number/two/is from file, was: %d",tmp_int);
		else printf(" o Read: number/two/is from file, is: %d",tmp_int);

	tmp_int = djInt("djson_number_test.json","number/three",false);
	if (tmp_int!=0) printf(" x Error reading: number/three from file, was: %d",tmp_int);
		else printf(" o Read: number/three from file, is: %d",tmp_int);

	tmp_float = djFloat("djson_number_test.json","number/four",false);
	if (tmp_float!=0.5) printf(" x Error reading: number/four from file, was: %f",tmp_float);
		else printf(" o Read: number/four from file, is: %f",tmp_float);

	tmp_float = djFloat("djson_number_test.json","number/five",false);
	if (tmp_float!=-0.1) printf(" x Error reading: number/five from file, was: %f",tmp_float);
		else printf(" o Read: number/five from file, is: %f",tmp_float);

	tmp_float = djFloat("djson_number_test.json","number/six",false);
	if (tmp_float!=-1.2) printf(" x Error reading: number/six from file, was: %f",tmp_float);
		else printf(" o Read: number/six from file, is: %f",tmp_float);

	tmp_float = djFloat("djson_number_test.json","number/seven",false);
	if (tmp_float!=-1.0) printf(" x Error reading: number/seven from file, was: %f",tmp_float);
		else printf(" o Read: number/seven from file, is: %f",tmp_float);

	// testing negative, positive and numbers which are non of that :-)
	fremove("djson_number_test.json");

	DJSON_cache_UnloadFile("djson_number_test.json");
	DJSON_cache_UnloadFile("djson_simple_test.json");
	DJSON_cache_UnloadFile("djson_test.json");

	djCreateFile("djappend_test.json");
	djAppend("djappend_test.json","Object","");
	djAppend("djappend_test.json", "Object", "TestValue1");
	format(tmp,DJSON_MAX_STRING,dj("djappend_test.json","Object/1"));
	if (strcmp(tmp,"TestValue1")!=0 || strlen(tmp)==0) printf(" X Could not append Testvalue1 to Object");
		else printf(" o Append TestValue1 to Object");

	tmp_int = djSet("djappend_test_between.json", "Dummy", "0");
	if (tmp_int) printf(" o Set Dummy to 0");
		else printf(" X Could not set Dummy 0");

	djAppend("djappend_test.json", "Object", "TestValue2");
	format(tmp,DJSON_MAX_STRING,dj("djappend_test.json","Object/2"));
	if (strcmp(tmp,"TestValue2")!=0 || strlen(tmp)==0) printf(" X Could not append Testvalue2 to Object");
		else printf(" o Append TestValue2 to Object");

	// Reset to default before test started
	djAutocommit(BEFORE_AUTOCOMMIT_VAL);

	djSet("djson_simple_test.json","test2","1");

	printf("done!");

#endif
}

/**
 * Destroys the djson-Engine, _must_ be executed on gamemode exit!
 * @ingroup callback
 * @see djson_GameModeInit
 */
djson_GameModeExit() {
	DJSON_cache_close();
}
