#define MAX_MENUS								(128)
#define INVALID_MENU							(0xFF)

native Menu:CreateMenu(const title[], columns, Float:x, Float:y, Float:col1width, Float:col2width = 0.0);
native DestroyMenu(Menu:menuid);
native AddMenuItem(Menu:menuid, column, const menutext[]);
native SetMenuColumnHeader(Menu:menuid, column, const columnheader[]);
native ShowMenuForPlayer(Menu:menuid, playerid);
native HideMenuForPlayer(Menu:menuid, playerid);
native IsValidMenu(Menu:menuid);
native DisableMenu(Menu:menuid);
native DisableMenuRow(Menu:menuid, row);
native Menu:GetPlayerMenu(playerid);

forward OnPlayerSelectedMenuRow(playerid, row);
public OnPlayerSelectedMenuRow(playerid, row) _SelectedMenuRow(playerid, row);

forward OnPlayerExitedMenu(playerid);
public OnPlayerExitedMenu(playerid) _ExitedMenu(playerid);
