/*
    SA-MP Audio Plugin v0.4
    Copyright © 2010 Incognito

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#define BOOST_ALL_NO_LIB
#define MAX_BUFFER (512)
#define PLUGIN_VERSION "0.4"

#include <ws2tcpip.h>
#include <windows.h>
#include <shlobj.h>
#include <shlwapi.h>
#include "Libraries/BASS/bass.h"
#include "Libraries/BASS/bassmix.h"
#include "Libraries/BASS/basswma.h"
#include "Libraries/boost/algorithm/string.hpp"
#include "Libraries/boost/crc.hpp"
#include "Libraries/boost/cstdint.hpp"
#include "Libraries/boost/filesystem.hpp"
#include "Libraries/boost/format.hpp"
#include "Libraries/boost/lexical_cast.hpp"
#include "Libraries/boost/thread.hpp"
#include "Libraries/curl/curl.h"
#include "Libraries/SimpleIni/SimpleIni.h"

void
	Initialize();
