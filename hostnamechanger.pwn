#include <a_samp>
#define FILTERSCRIPT
forward mapname();
forward mapname2();
forward hostname();
forward hostname2();
#define mapnamechangetime 3000 // Change "3000" to the value how often the mapname is changed, 1000 = 1 second
#define hostnamechangetime 3000 // Change "3000" to the value how often the hostname is changed, 1000 = 1 second

//----------------------------------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Advanced mapname and hostname changer ");
	print(" By Mo3 aka TheFailFactor");
	print("--------------------------------------\n");
	SetTimer("mapname", 3000, 0);
	SetTimer("hostname", 3000, 0);
	return 1;
}

//----------------------------------------------------------------------------

public mapname()
{
      SendRconCommand("mapname [YOUR FIRST MAPNAME HERE]");
      SetTimer("mapname2", mapnamechangetime, 0);
	  return 1;
}
public mapname2()
{
      SendRconCommand("mapname [YOUR SECOND MAPNAME HERE]");
      SetTimer("mapname", mapnamechangetime, 0);
	  return 1;
}
public hostname()
{
      SendRconCommand("hostname [YOUR FIRST HOSTNAME HERE]");
      SetTimer("hostname", hostnamechangetime, 0);
	  return 1;
}
public hostname2()
{
      SendRconCommand("hostname [YOUR SECOND HOSTNAME HERE]~ ");
      SetTimer("hostname2", hostnamechangetime, 0);
	  return 1;
}
