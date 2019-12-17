//----------------------------------------------------------
//
//   SA-MP Multiplayer Modification For GTA:SA
//   Copyright 2004-2010 SA-MP Team
//
//   Author: Kye 10 Jan 2010
//
//----------------------------------------------------------

#pragma once

#define NATIVE_PREFIX "MapAndreas_"

#define DECL_AMX_NATIVE(a) PLUGIN_EXTERN_C cell AMX_NATIVE_CALL n_##a (AMX* amx, cell* params)
#define DECL_AMX_MAP(a) { NATIVE_PREFIX #a, n_##a }

/*
native MapAndreas_Init(mode);
native MapAndreas_FindZ_For2DCoord(Float:X, Float:Y, &Float:Z);
*/

DECL_AMX_NATIVE(Init);
DECL_AMX_NATIVE(FindZ_For2DCoord);
