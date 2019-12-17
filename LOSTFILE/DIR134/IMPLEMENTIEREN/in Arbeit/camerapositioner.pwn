#include <a_samp>

#define FILTERSCRIPT
#if defined FILTERSCRIPT

#define green 0x33FF33AA
#define red 0xFF0000AA

public OnFilterScriptInit()
{
        print("-------------------------------");
        print(" Camera positioner v1.5 loaded ");
        print("-------------------------------");
        return 1;
}

#endif

public OnPlayerCommandText(playerid, cmdtext[])
{
        new cmd[256], idx;
        cmd = strtok(cmdtext, idx);

        if (strcmp("/setcam", cmd, true) == 0)
        {
                new var1;
                new tmp1[256];
                tmp1 = strtok(cmdtext, idx);
                if(!strlen(tmp1)) return SendClientMessage(playerid, red, "Use: /setcam [pos1] [pos2] [pos3]");
                var1 = strval(tmp1);

                new var2;
                new tmp2[256];
                tmp2 = strtok(cmdtext, idx);
                if(!strlen(tmp2)) return SendClientMessage(playerid, red, "Use: /setcam [pos1] [pos2] [pos3]");
                var2 = strval(tmp2);

                new var3;
                new tmp3[256];
                tmp3 = strtok(cmdtext, idx);
                if(!strlen(tmp3)) return SendClientMessage(playerid, red, "Use: /setcam [pos1] [pos2] [pos3]");
                var3 = strval(tmp3);

                SetPlayerCameraPos(playerid, var1, var2, var3);

                new string[100];
                format(string, sizeof(string), "Your camera is now positioned at %d, %d, %d", var1, var2, var3);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/setcamhere", cmdtext, true) == 0)
        {
                new Float:X, Float:Y, Float:Z;
                GetPlayerPos(playerid, X, Y, Z);

                SetPlayerCameraPos(playerid, X, Y, Z);

                new string[100];
                format(string, sizeof(string), "Your camera is now positioned at %0.0f, %0.0f, %0.0f", X, Y, Z);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/lookat", cmd, true) == 0)
        {
                new var1;
                new tmp1[256];
                tmp1 = strtok(cmdtext, idx);
                if(!strlen(tmp1)) return SendClientMessage(playerid, red, "Use: /lookat [pos1] [pos2] [pos3]");
                var1 = strval(tmp1);

                new var2;
                new tmp2[256];
                tmp2 = strtok(cmdtext, idx);
                if(!strlen(tmp2)) return SendClientMessage(playerid, red, "Use: /lookat [pos1] [pos2] [pos3]");
                var2 = strval(tmp2);

                new var3;
                new tmp3[256];
                tmp3 = strtok(cmdtext, idx);
                if(!strlen(tmp3)) return SendClientMessage(playerid, red, "Use: /lookat [pos1] [pos2] [pos3]");
                var3 = strval(tmp3);

                SetPlayerCameraLookAt(playerid, var1, var2, var3);

                new string[100];
                format(string, sizeof(string), "Your camera is now looking at %d, %d, %d", var1, var2, var3);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/lookathere", cmdtext, true) == 0)
        {
                new Float:X, Float:Y, Float:Z;
                GetPlayerPos(playerid, X, Y, Z);

                SetPlayerCameraLookAt(playerid, X, Y, Z);

                new string[100];
                format(string, sizeof(string), "Your camera is now looking at %0.0f, %0.0f, %0.0f", X, Y, Z);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/gotopos", cmd, true) == 0)
        {
                new var1;
                new tmp1[256];
                tmp1 = strtok(cmdtext, idx);
                if(!strlen(tmp1)) return SendClientMessage(playerid, red, "Use: /gotopos [pos1] [pos2] [pos3]");
                var1 = strval(tmp1);

                new var2;
                new tmp2[256];
                tmp2 = strtok(cmdtext, idx);
                if(!strlen(tmp2)) return SendClientMessage(playerid, red, "Use: /gotopos [pos1] [pos2] [pos3]");
                var2 = strval(tmp2);

                new var3;
                new tmp3[256];
                tmp3 = strtok(cmdtext, idx);
                if(!strlen(tmp3)) return SendClientMessage(playerid, red, "Use: /gotopos [pos1] [pos2] [pos3]");
                var3 = strval(tmp3);

                SetPlayerPos(playerid, var1, var2, var3);

                new string[100];
                format(string, sizeof(string), "Your position is now %d, %d, %d", var1, var2, var3);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/wereami", cmdtext, true) == 0)
        {
                new Float:X, Float:Y, Float:Z;
                GetPlayerPos(playerid, X, Y, Z);

                new string[100];
                format(string, sizeof(string), "Your position is %0.0f, %0.0f, %0.0f", X, Y, Z);
                SendClientMessage(playerid, green, string);
                return 1;
        }

        if (strcmp("/resetcam", cmdtext, true) == 0)
        {
                SetCameraBehindPlayer(playerid);
                SendClientMessage(playerid, green, "Your camera is reset");
                return 1;
        }
        return 0;
}

