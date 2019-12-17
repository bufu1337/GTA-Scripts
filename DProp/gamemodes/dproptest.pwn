#include <a_samp>
#include <dprop>
public OnGameModeInit()
{
    printf("");
    printf("  DPROP-Gamemode started");
    printf("__________________________");
    printf("");
    if (PropertyExists("Id1")) printf(" >Id1 exists");
    printf(" >Id1=%s",PropertyGet("Id1"));
    return 1;
}

public main() {
}


