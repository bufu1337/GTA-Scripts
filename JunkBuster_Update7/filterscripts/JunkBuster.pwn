#define FILTERSCRIPT

#include <a_samp>
#include <JunkBuster>

public OnFilterScriptInit()
{
	print("\n+---------------------------------------------+");
	print("¦            JunkBuster Anti-Cheat              ¦");
	print("¦                     by                        ¦");
	print("¦               Double-O-Seven                  ¦");
	print("¦           loaded as filterscript!             ¦");
	print("+-----------------------------------------------+\n");
	print("You are now using JunkBuster as filterscript!");
	print("Make sure that you have included JunkBuster_Cient.inc");
	print("in all your other script! You must include JunkBuster.inc");
	print("in ONLY ONE script! In this case, it's this filterscript!");
	print("Use JunkBuster_Client.inc in your other scripts!");
	return 1;
}
