/*       2008 Pixels^      */
/*       To Modify or Redistribute you need my permission    */


/*native MakeDirectory(Directory[])*/

stock MakeDirectory(Directory[])
{
	new str[30],File:log=fopen("MkDir.txt",io_append);;
	format(str,sizeof(str),"%s",Directory);
	fwrite(log,str);
	fclose(log);
	return 1;
}