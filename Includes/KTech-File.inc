/*
#################################
#     K's Technology - File     #
#           Ver. 0.1b           #
#      Created by K_POLAND      #
#                               #
#     Copyright © K_POLAND      #
#################################
*/

#include a_samp

#define SYMBOL '='
#define K'sEXTENSION ".KTech"

stock GetStrFromFile(fname[], str[])
{
	new File:f = fopen(fname, io_read),
		result[128];

	if(!fexist(fname)) return result;

	while(fread(f, result, sizeof(result)))
	{
	    if(!strcmp(str, result, true, strlen(str)))
	    {
			if(result[strlen(str)] == SYMBOL)
			{
			    if(result[strlen(result)-1] == '\n' || result[strlen(result)-1] == '\r')
			    {
			    	result[strlen(result)-1] = EOS;
			    	if(result[strlen(result)-1] == '\n' || result[strlen(result)-1] == '\n')
					{
				    	result[strlen(result)-1] = EOS;
					}
			    }
				strdel(result, 0, strlen(str)+1);
				fclose(f);
				return result;
			}
	    }
		result[0] = EOS;
	}
	fclose(f);
	return result;
}

stock GetIntFromFile(fname[], str[])
	return strval(GetStrFromFile(fname, str));

stock Float:GetFloatFromFile(fname[], str[])
	return floatstr(GetStrFromFile(fname, str));

stock GetBoolFromFile(fname[], str[])
{
    if(!strval(GetStrFromFile(fname, str))) return false;
	return true;
}

stock CreateFile(fname[])
{
	if(fexist(fname))
		return 0;
	new File:f = fopen(fname);
	fclose(f);
	return 1;
}

stock RemoveFile(fname[])
{
	if(!fexist(fname))
		return 0;
	fremove(fname);
	return 1;
}

stock RenameFile(fname[], newname[])
{
	if(!fexist(fname) || fexist(newname))
		return 0;

	if(!strcmp(fname, newname, false))
		return 0;

	new File:f = fopen(fname, io_read),
		File:nf = fopen(newname, io_append),
	    buffer,
		flen = flength(f);
	while(flen != 0)
	{
		fputchar(nf, fgetchar(f, buffer,false), false);
		flen--;
	}
	fclose(nf);
	fclose(f);
	fremove(fname);
	return 1;
}

stock CopyFile(fname[], newname[])
{
	if(!fexist(fname) || fexist(newname))
		return 0;

	if(!strcmp(fname, newname, false))
		return 0;

	new File:f = fopen(fname, io_read),
		File:nf = fopen(newname, io_append),
	    buffer,
		flen = flength(f);
	while(flen != 0)
	{
		fputchar(nf, fgetchar(f, buffer,false), false);
		flen--;
	}
	fclose(nf);
	fclose(f);
	return 1;
}

stock FileExists(fname[])
{
	if(!fexist(fname))
		return 0;
	return 1;
}

stock SetStrOption(fname[], opt[], str[])
{
	if(!fexist(fname))
		return 0;

	new File:f,
	    File:Kf,
		buffer[256],
		KfName[128],
		option[128],
		bool:x = false;

	format(option, sizeof(option), "%s%c", opt, SYMBOL);
	strcat(KfName, fname, sizeof(KfName));
	strcat(KfName, K'sEXTENSION, sizeof(KfName));

	if(fexist(KfName))
		return 0;

	f = fopen(fname, io_readwrite);
	Kf = fopen(KfName, io_readwrite);

	while(fread(f, buffer, sizeof(buffer)))
	{
 		if(!strcmp(option, buffer, true, strlen(option)))
	    {
			format(buffer, sizeof(buffer), "%s%s\r\n", option, str);
			x = true;
		}
		fwrite(Kf, buffer);
	}
	fclose(f);
	fclose(Kf);
	fremove(fname);
	RenameFile(KfName, fname);
	if(x == false)
	{
		f = fopen(fname, io_append);
    	format(buffer, sizeof(buffer), "%s%s\r\n", option, str);
    	fwrite(f, buffer);
    	fclose(f);
	}
	return 0;
}

stock SetIntOption(fname[], opt[], integer)
{
	new s[128];
	format(s, sizeof(s), "%d", integer);
	return SetStrOption(fname, opt, s);
}

stock SetFloatOption(fname[], opt[], Float:fl)
{
	new s[128];
	format(s, sizeof(s), "%f", fl);
	return SetStrOption(fname, opt, s);
}

stock SetBoolOption(fname[], opt[], bool:b)
{
	new s[128];
	format(s, sizeof(s), "%d", b);
	return SetStrOption(fname, opt, s);
}

stock UnsetOption(fname[], opt[])
{
	if(!fexist(fname))
		return 0;

	new File:f,
	    File:Kf,
		buffer[256],
		KfName[128];

	strcat(KfName, fname, sizeof(KfName));
	strcat(KfName, K'sEXTENSION, sizeof(KfName));

	if(fexist(KfName))
		return 0;

	f = fopen(fname, io_readwrite);
	Kf = fopen(KfName, io_readwrite);

	while(fread(f, buffer, sizeof(buffer)))
	{
 		if(!strcmp(opt, buffer, true, strlen(opt)))
	    {
			buffer[0] = EOS;
		}
		fwrite(Kf, buffer);
	}
	fclose(f);
	fclose(Kf);
	fremove(fname);
	RenameFile(KfName, fname);
	return 0;
}

stock Write(fname[], const str[])
{
	if(!fexist(fname))
		return 0;

	new File:f = fopen(fname, io_append);
	fwrite(f, str);
	fclose(f);
	return 0;
}

stock Read(fname[], line)
{
	new File:f = fopen(fname, io_read),
		buffer[256];

	if(!fexist(fname))
		return buffer;

	for(new a = 0; a < line; a++)
	{
	    fread(f, buffer, sizeof(buffer));
	    if(buffer[strlen(buffer)-1] == '\n' || buffer[strlen(buffer)-1] == '\r')
		{
			buffer[strlen(buffer)-1] = EOS;
			if(buffer[strlen(buffer)-1] == '\n' || buffer[strlen(buffer)-1] == '\n')
			{
				buffer[strlen(buffer)-1] = EOS;
			}
		}
	}
	fclose(f);
	return buffer;
}

stock SaveToArray(fname[], line, array[], maxlength)
	return strcat(array, Read(fname, line), maxlength);

stock ROT13(text[])
{
	new a,
		r[256];
	while(text[a] != 0)
	{
		switch(text[a])
		{
			case 65..77: r[a]=text[a]+13;
			case 97..109: r[a]=text[a]+13;
			case 78..90: r[a]=text[a]-13;
			case 110..122: r[a]=text[a]-13;
			default: r[a] = text[a];
		}
		a++;
	}
	return r;
}

stock KEncrypt(text[])
{
	new a,
		r[2][256];

	while(text[a] != 0)
	{
		format(r[0], 256, "%dK", text[a]*3);
		strcat(r[1], r[0], 256);
		a++;
	}
	return r[1];
}

stock KDecrypt(text[])
{
	new r[256],
	    o,
		a,
		k;

	while(text[a] != 0)
	{
	    if(text[a] == 'K')
	    {
	    	r[o] = k/3;
		    o++;
		    k = 0;
		    strdel(text, 0, a);
		    a = 0;
		}
		else
		{
			k = k * 10 + text[a] - 48;
		}
		a++;
	}
	return r;
}

stock KSEM(text[]) // K's Super Encrypt Method
{
	new a,
		r[512],
		omfg[512];

	while(text[a] != 0)
	{
		format(omfg, 512, "%d", text[a]*13);
		strcat(r, omfg, 512);
		a++;
	}
	return r;
}

stock SetPassword(fname[], opt[], pass[], method[])
{
	if(!strcmp(method, "ROT13", true))
		return SetStrOption(fname, opt, ROT13(pass));
	else if(!strcmp(method, "K", true))
        return SetStrOption(fname, opt, KEncrypt(pass));
	else if(!strcmp(method, "KSEM", true))
        return SetStrOption(fname, opt, KSEM(pass));
	return 0;
}

stock GetPassword(fname[], opt[], method[], array[], maxlength)
{
	array[0] = EOS; // I'm sorry :P
	if(!strcmp(method, "ROT13", true))
		return strcat(array, ROT13(GetStrFromFile(fname, opt)), maxlength);
	else if(!strcmp(method, "K", true))
		return strcat(array, KDecrypt(GetStrFromFile(fname, opt)), maxlength);
	return 0;
}

stock CompareKSEMPasswords(fname[], opt[], password[])
{
	if(strcmp_ex(GetStrFromFile(fname, opt), KSEM(password))==0)
		return 0;
	return 1;
}

stock strcmp_ex(const f[], const pass[])
{
	new strlenf = strlen(f)-1;
	if(strlenf != strlen(pass))
	    return 0;
	for(new a = 0; a < strlenf; a++)
	{
		if(f[a] != pass[a])
	    	return 0;
	}
	return 1;
}

/*
native FileExists(fname[]);
native CreateFile(fname[]);
native RemoveFile(fname[]);
native CopyFile(fname[], newname[]);
native RenameFile(fname[], newname[]);
native 
native GetStrFromFile(fname[], option[]);
native GetIntFromFile(fname[], option[]);
native GetFloatFromFile(fname[], option[]);
native GetBoolFromFile(fname[], option[]);
native GetPassword(fname[], option[], method[], array[], maxlength);
native CompareKSEMPasswords(fname[], option[], password[]);
native 
native SetStrOption(fname[], option[], str[]);
native SetIntOption(fname[], option[], integer);
native SetFloatOption(fname[], option[], Float);
native SetBoolOption(fname[], option[], bool);
native SetPassword(fname[], option[], password[], method[]);
native UnsetOption(fname[], option[]);
native 
native Write(fname[], str[]);
native Read(fname[], line);
native SaveToArray(fname[], line, array[], maxlength);
native 
native ROT13(text[]);
native KEncrypt(text[]);
native KDecrypt(text[]);
native KSEM(text[]);
*/