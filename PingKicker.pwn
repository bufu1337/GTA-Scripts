#define MAX_PING 1000
#define PING_CHECKS 5
new avgcount[MAX_PLAYERS];
new pping[MAX_PLAYERS];
SetTimer("Ping_Timer", 5000, true);
forward Ping_Timer();
public Ping_Timer()
{
    foreach(Player, i)
    {
        avgcount[i]++;
        new ping = pping[i];
        pping[i] = GetPlayerPing(i);
        pping[i] = ping + pping[i];
        if((avgcount[i]%PING_CHECKS) == 0)
        {
            pping[i] = (pping[i]/avgcount[i]);
            if(pping[i] > MAX_PING)
            {
                new name[24], string[128];
                GetPlayerName(i, name, sizeof(name));
                format(string, sizeof(string), "[PLUTO AC]: %s has been kicked for high ping (%d/%d)", name, pping[i], MAX_PING);
                SendClientMessageToAll(COLOR_REDONLY, string);
                Kick(i);
            }
            else pping[i] = 0;
        }
    }
}