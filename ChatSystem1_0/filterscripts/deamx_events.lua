g_SAMPEventParamNames = {
	OnFilterScriptInit = {},
	OnFilterScriptExit = {},
	OnGameModeInit = {},
	OnGameModeExit = {},
	OnPlayerRequestClass = {'playerid', 'classid'},
	OnPlayerRequestSpawn = {'playerid'},
	OnPlayerConnect = {'playerid'},
	OnPlayerDisconnect = {'playerid', 'reason'},
	OnPlayerSpawn = {'playerid'},
	OnPlayerDeath = {'playerid', 'killerid', 'reason'},
	OnVehicleSpawn = {'vehicleid'},
	OnVehicleDeath = {'vehicleid', 'killerid'},
	OnPlayerText = {'playerid', 'text'},
	OnPlayerPrivmsg = {'playerid', 'receiverid', 'text'},
	OnPlayerCommandText = {'playerid', 'cmdtext'},
	OnPlayerInfoChange = {'playerid'},
	OnPlayerEnterVehicle = {'playerid', 'vehicleid', 'ispassenger'},
	OnPlayerExitVehicle = {'playerid', 'vehicleid'},
	OnPlayerKeyStateChange = {'playerid', 'newkeys', 'oldkeys'},
	OnPlayerStateChange = {'playerid', 'newstate', 'oldstate'},
	OnPlayerEnterCheckpoint = {'playerid'},
	OnPlayerLeaveCheckpoint = {'playerid'},
	OnPlayerEnterRaceCheckpoint = {'playerid'},
	OnPlayerLeaveRaceCheckpoint = {'playerid'},
	OnRconCommand = {'cmd'},
	OnObjectMoved = {'objectid'},
	OnPlayerObjectMoved = {'playerid', 'objectid'},
	OnPlayerPickUpPickup = {'playerid', 'pickupid'},
	OnPlayerSelectedMenuRow = {'playerid', 'row'},
	OnPlayerExitedMenu = {'playerid'}
}