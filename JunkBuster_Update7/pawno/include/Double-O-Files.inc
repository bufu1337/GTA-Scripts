#include <a_samp>
#include <dutils>

#if defined _dof_included
	#endinput
#endif
#define _dof_included

#if !defined isnull
	#define isnull(%1) \
				((!(%1[0])) || (((%1[0]) == '\1') && (!(%1[1]))))
#endif

#define MAX_ENTRIES 768 // Eintraege zum lesen
#define MAX_KEY_SIZE 64 // Muss kleiner oder gleich als MAX_VALUE_SIZE sei
#define MAX_VALUE_SIZE 256
#define MAX_FILE_SIZE 64

#define USER_FILE_PATH "Accounts/%s.dudb.sav"

//#define DOF_DEBUG
#define DUDB_CONVERT
#define DINI_CONVERT

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

new LoadedFile[MAX_FILE_SIZE+1];
new LoadedEntries;
new FileChanged=false;
new Keys[MAX_ENTRIES][MAX_KEY_SIZE+1];
new Values[MAX_ENTRIES][MAX_VALUE_SIZE+1];

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

/*
native DOF_Clear();
native DOF_SetFile(file[]);
native DOF_LoadFile();
native DOF_SaveFile();
native DOF_PrintFile(comment[]="");
native DOF_GetString(file[],key[]);
native DOF_GetStringEx(file[],key[],result[],len);
native DOF_GetFloat(file[],key[]);
native DOF_GetInt(file[],key[]);
native DOF_GetBool(file[],key[]);
native DOF_SetString(file[],key[],value[]);
native DOF_Unset(file[],key[]);
native DOF_IsSet(file[],key[]);
native DOF_SetFloat(file[],key[],Float:value);
native DOF_SetInt(file[],key[],value);
native DOF_SetBool(file[],key[],bool:value);
native DOF_FileExists(file[]);
native DOF_RemoveFile(file[]);
native DOF_CreateFile(file[],password[]="");
native DOF_RenameFile(oldfile[],newfile[]);
native DOF_CheckLogin(file[],password[]);
native DOF_File(file[]);
*/

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

DOF_Exit()//Bei OnGameModeExit:
{
	DOF_SaveFile();
}

stock DOF_Clear()
{
	LoadedEntries=0;
	for(new i=0;i<MAX_ENTRIES;i++)
	{
	    new j;
	    for(j=0;j<MAX_KEY_SIZE;j++)
	    {
	        Keys[i][j]=0;
	        Values[i][j]=0;
		}
		for(j=MAX_KEY_SIZE;j<MAX_VALUE_SIZE;j++)
	        Values[i][j]=0;
	}
}

stock DOF_SetFile(file[])
{
	if(!isnull(file))
	    return format(LoadedFile,sizeof(LoadedFile),file);
	return 0;
}

stock DOF_LoadFile()
{
	if(!isnull(LoadedFile))
	{
		DOF_Clear();
		new File:f=fopen(LoadedFile,io_read),string[MAX_VALUE_SIZE+MAX_KEY_SIZE+5],pos,pos2;
		while(fread(f,string,sizeof(string)) && LoadedEntries<MAX_ENTRIES)
		{
			StripNewLine(string);
			if(!isnull(string))
			{
			    pos=0;
			    while(string[pos]!='=' && string[pos])
			    {
			        if(pos<MAX_KEY_SIZE)
			        	Keys[LoadedEntries][pos]=string[pos];
					pos++;
			    }
			    pos++;
			    pos2=pos;
			    while(string[pos2] && (pos2-pos)<MAX_VALUE_SIZE)
			    {
			        Values[LoadedEntries][pos2-pos]=string[pos2];
			        pos2++;
			    }
			    LoadedEntries++;
			}
		}
		fclose(f);
		return LoadedEntries;
	}
	return 0;
}

stock DOF_SaveFile()
{
    if(!isnull(LoadedFile))
	{
	    #if defined DOF_DEBUG
			//DOF_PrintFile();
			printf("[DOF] Schreibe Datei ('%s') neu!",LoadedFile);
	    #endif
	    fremove(LoadedFile);
	    new File:f=fopen(LoadedFile,io_append),string[MAX_VALUE_SIZE+MAX_KEY_SIZE+5];
	    for(new i=0;i<LoadedEntries;i++)
	    {
	        format(string,sizeof(string),"%s=%s\r\n",Keys[i],Values[i]);
	        fwrite(f,string);
	    }
		FileChanged=false;
	    return fclose(f);
	}
	return 0;
}

stock DOF_PrintFile(comment[]="")
{
	if(!isnull(LoadedFile))
	{
	    printf("[DOF] Geladene Datei: '%s'",LoadedFile);
	    for(new i=0;i<LoadedEntries;i++)
	        printf("%s=%s",Keys[i],Values[i]);
		printf("(%d Eintraege)",LoadedEntries);
		if(!isnull(comment))
		    printf("* Kommentar: %s",comment);
		return 1;
	}
	
	print("[DOF] Keine Datei geladen!");
	return 0;
}

stock DOF_GetString(file[],key[])
{
	new result[MAX_VALUE_SIZE];
	if(!isnull(file) && !isnull(key))
	{
	    if(DOF_FileExists(file))
	    {
			if(isnull(LoadedFile) || strcmp(file,LoadedFile,false))//Neue Datei laden.
			{
			    if(FileChanged)
					DOF_SaveFile();
			    #if defined DOF_DEBUG
			        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
			    #endif
			    DOF_SetFile(file);
			    DOF_LoadFile();
			}

			for(new i=0;i<LoadedEntries;i++)
			{
			    if(!strcmp(Keys[i],key,true))
			    {
			        format(result,sizeof(result),Values[i]);
					return result;
				}
			}
		}
	}
	return result;
}

stock DOF_GetStringEx(file[],key[],result[],len)
{
    if(!isnull(file) && !isnull(key))
	{
	    if(DOF_FileExists(file))
	    {
			if(isnull(LoadedFile) || strcmp(file,LoadedFile,false))//Neue Datei laden.
			{
			    if(FileChanged)
					DOF_SaveFile();
			    #if defined DOF_DEBUG
			        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
			    #endif
			    DOF_SetFile(file);
			    DOF_LoadFile();
			}

			for(new i=0;i<LoadedEntries;i++)
			    if(!strcmp(Keys[i],key,true))
			        return format(result,len,Values[i]);
		}
	}
	return 0;
}

stock Float:DOF_GetFloat(file[],key[])
	return floatstr(DOF_GetString(file,key));
	
stock DOF_GetInt(file[],key[])
	return strval(DOF_GetString(file,key));
	
stock bool:DOF_GetBool(file[],key[])
{
	if(strval(DOF_GetString(file,key)))
	    return (bool:1);
	return (bool:0);
}

stock DOF_SetString(file[],key[],value[])
{
    if(!isnull(file) && !isnull(key))
	{
	    if(DOF_FileExists(file))
	    {
			if(isnull(LoadedFile) || strcmp(file,LoadedFile,false))//Neue Datei laden.
			{
			    if(FileChanged)
					DOF_SaveFile();
			    #if defined DOF_DEBUG
			        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
			    #endif
			    DOF_SetFile(file);
			    DOF_LoadFile();
			}

            FileChanged=true;
			for(new i=0;i<LoadedEntries;i++)
			    if(!strcmp(Keys[i],key,true))
		        	return format(Values[i],MAX_VALUE_SIZE+1,value);

			//Key existiert nicht:
			if(LoadedEntries<MAX_ENTRIES)
			{
			    format(Keys[LoadedEntries],MAX_KEY_SIZE+1,key);
			    format(Values[LoadedEntries],MAX_VALUE_SIZE+1,value);
			    LoadedEntries++;
			    return 1;
			}
		}
	}
	return 0;
}

stock DOF_IsSet(file[],key[])
{
	if(!isnull(file) && !isnull(key))
	{
	    if(DOF_FileExists(file))
	    {
			if(isnull(LoadedFile) || strcmp(file,LoadedFile,false))//Neue Datei laden.
			{
			    if(FileChanged)
					DOF_SaveFile();
			    #if defined DOF_DEBUG
			        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
			    #endif
			    DOF_SetFile(file);
			    DOF_LoadFile();
			}

			for(new i=0;i<LoadedEntries;i++)
			    if(!strcmp(Keys[i],key,true))
					return 1;
		}
	}
	return 0;
}

stock DOF_Unset(file[],key[])
{
    if(!isnull(file) && !isnull(key))
	{
	    if(DOF_FileExists(file))
	    {
			if(isnull(LoadedFile) || strcmp(file,LoadedFile,false))//Neue Datei laden.
			{
			    if(FileChanged)
					DOF_SaveFile();
			    #if defined DOF_DEBUG
			        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
			    #endif
			    DOF_SetFile(file);
			    DOF_LoadFile();
			}

			for(new i=0;i<LoadedEntries;i++)
			{
			    if(!strcmp(Keys[i],key,true))
			    {
			        FileChanged=true;
			        LoadedEntries--;
			        for(new j=i;j<LoadedEntries;j++)
			        {
			            Keys[j]=Keys[j+1];
			            Values[j]=Values[j+1];
					}
		        	return 1;
				}
			}
		}
	}
	return 0;
}

stock DOF_SetFloat(file[],key[],Float:value)
{
	new fvalue[MAX_VALUE_SIZE];
	format(fvalue,sizeof(fvalue),"%.8f",value);
	return DOF_SetString(file,key,fvalue);
}

stock DOF_SetInt(file[],key[],value)
{
	new ivalue[MAX_VALUE_SIZE];
	format(ivalue,sizeof(ivalue),"%d",value);
	return DOF_SetString(file,key,ivalue);
}

stock DOF_SetBool(file[],key[],bool:value)
{
	if(value)
	    return DOF_SetString(file,key,"1");
	return DOF_SetString(file,key,"0");
}

stock DOF_FileExists(file[])
	return fexist(file);
	
stock DOF_RemoveFile(file[])
{
	if(!isnull(file))
	{
	    if(!isnull(LoadedFile) && !strcmp(file,LoadedFile,false))//Gespeicherte Datei löschen, falls die gespeicherte Datei die ist, welche gelöscht werden soll.
	    {
			LoadedFile[0]=0;
			DOF_Clear();
		}
		return fremove(file);
	}
	return 0;
}

stock DOF_CreateFile(file[],password[]="")
{
	if(!isnull(file))
	{
	    if(!DOF_FileExists(file))
	    {
            DOF_SaveFile();
            #if defined DOF_DEBUG
		        printf("[DOF] Alte Datei ('%s') gespeichert, lade neue ('%s')!",LoadedFile,file);
		    #endif
            DOF_Clear();
            new File:f=fopen(file,io_append);
            fclose(f);
            DOF_SetFile(file);
            if(!isnull(password))
				DOF_SetInt(file,"password_hash",num_hash(password));
            return DOF_SaveFile();
	    }
	}
	return 0;
}

stock DOF_RenameFile(oldfile[],newfile[])
{
	if(!isnull(oldfile) && !isnull(newfile))
	{
	    if(DOF_FileExists(oldfile) && !DOF_FileExists(newfile))
	    {
	        if(FileChanged)
				DOF_SaveFile();//Derzeitige Datei speichern
	        DOF_SetFile(oldfile);
	        DOF_LoadFile();
	        fremove(oldfile);
	        DOF_SetFile(newfile);
	        return DOF_SaveFile();
	    }
	}
	return 0;
}

stock DOF_CheckLogin(file[],password[])
{
	if(!isnull(file) && !isnull(password))
	    if(num_hash(password)==DOF_GetInt(file,"password_hash"))
			return 1;
	return 0;
}

stock DOF_File(file[])
{
	new newfile[MAX_FILE_SIZE];
	format(newfile,sizeof(newfile),USER_FILE_PATH,DOF_udb_encode(file));
	return newfile;
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//Aus DUDB entnommen:

stock DOF_udb_encode(nickname[]) {
	new tmp[255];
	set(tmp,nickname);
	tmp=strreplace("_","_00",tmp);
	tmp=strreplace(";","_01",tmp);
	tmp=strreplace("!","_02",tmp);
	tmp=strreplace("/","_03",tmp);
	tmp=strreplace("\\","_04",tmp);
	tmp=strreplace("[","_05",tmp);
	tmp=strreplace("]","_06",tmp);
	tmp=strreplace("?","_07",tmp);
	tmp=strreplace(".","_08",tmp);
	tmp=strreplace("*","_09",tmp);
	tmp=strreplace("<","_10",tmp);
	tmp=strreplace(">","_11",tmp);
	tmp=strreplace("{","_12",tmp);
	tmp=strreplace("}","_13",tmp);
	tmp=strreplace(" ","_14",tmp);
	tmp=strreplace("\"","_15",tmp);
	tmp=strreplace(":","_16",tmp);
	tmp=strreplace("|","_17",tmp);
	tmp=strreplace("=","_18",tmp);
	return tmp;
}

stock DOF_udb_decode(nickname[]) {
	new tmp[255];
	set(tmp,nickname);
	tmp=strreplace("_01",";",tmp);
	tmp=strreplace("_02","!",tmp);
	tmp=strreplace("_03","/",tmp);
	tmp=strreplace("_04","\\",tmp);
	tmp=strreplace("_05","[",tmp);
	tmp=strreplace("_06","]",tmp);
	tmp=strreplace("_07","?",tmp);
	tmp=strreplace("_08",".",tmp);
	tmp=strreplace("_09","*",tmp);
	tmp=strreplace("_10","<",tmp);
	tmp=strreplace("_11",">",tmp);
	tmp=strreplace("_12","{",tmp);
	tmp=strreplace("_13","}",tmp);
	tmp=strreplace("_14"," ",tmp);
	tmp=strreplace("_15","\"",tmp);
	tmp=strreplace("_16",":",tmp);
	tmp=strreplace("_17","|",tmp);
	tmp=strreplace("_18","=",tmp);
	tmp=strreplace("_00","_",tmp);
	return tmp;
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

#if defined DUDB_CONVERT

	#define dUser(%0).( 			DOF_GetString(DOF_File(%0),
	#define dUserSet(%0).( 			DOF_SetString(DOF_File(%0),
	#define dUserINT(%0).( 			DOF_GetInt(DOF_File(%0),
	#define dUserSetINT(%0).( 		DOF_SetInt(DOF_File(%0),
	#define dUserFLOAT(%0).( 		DOF_GetFloat(DOF_File(%0),
	#define dUserSetFLOAT(%0).( 	DOF_SetFloat(DOF_File(%0),
	#define udb_Create(%0,%1)		DOF_CreateFile(DOF_File(%0),%1)
	#define udb_RenameUser(%0,%1)   DOF_RenameFile(DOF_File(%0),DOF_File(%1))
	#define udb_Exists(%0)          DOF_FileExists(DOF_File(%0))
	#define udb_Remove(%0)          DOF_RemoveFile(DOF_File(%0))
	#define udb_CheckLogin(%0,%1)   DOF_CheckLogin(DOF_File(%0),%1)
	#define udb_hash            	num_hash
	#define udb_encode              DOF_udb_encode
	#define udb_decode              DOF_udb_decode
	
	#if !defined _dudb_included
		#define _dudb_included
	#endif
#endif

#if defined DINI_CONVERT

	#define dini_Exists		        DOF_FileExists
	#define dini_Remove         	DOF_RemoveFile
	#define dini_Create         	DOF_CreateFile
	#define dini_Set			    DOF_SetString
	#define dini_Get         		DOF_GetString
	#define dini_IntSet   			DOF_SetInt
	#define dini_Int         		DOF_GetInt
	#define dini_BoolSet            DOF_SetBool
	#define dini_Bool               DOF_GetBool
	#define dini_FloatSet 			DOF_SetFloat
	#define dini_Float      		DOF_GetFloat
	#define dini_Unset       		DOF_Unset
	#define dini_Isset       		DOF_IsSet
	
	#if !defined _dini_included
		#define _dini_included
	#endif
#endif
