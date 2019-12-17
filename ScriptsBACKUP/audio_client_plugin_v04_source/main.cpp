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

#include "main.h"
#include "Source/CAudio.h"
#include "Source/CCurl.h"
#include "Source/CCore.h"
#include "Source/CNetwork.h"
#include "Source/CProgram.h"

void
	Initialize()
{
	boost::this_thread::sleep(boost::posix_time::seconds(5));
	HMODULE
		handle = GetModuleHandleW(L"samp.dll");
	unsigned int
		sampAddress = NULL;
	__asm
	{
		mov sampAddress, eax
	}
	if (sampAddress != NULL)
	{
		CAudio::CAudio();
		CProgram::CProgram();
		CProgram::divideLog();
		CProgram::logText(L"------------------------------");
		CProgram::logText(L"SA-MP Audio Plugin initialized");
		CProgram::logText(L"------------------------------");
		std::wstring
			commandLine = GetCommandLineW();
		std::vector<std::wstring>
			splitCommandLine;
		if (commandLine.find(L"-c") != std::wstring::npos)
		{
			boost::algorithm::split(splitCommandLine, commandLine.substr(commandLine.find(L"-c")), boost::algorithm::is_any_of(L" "));
		}
		if (splitCommandLine.size() >= 7)
		{
			for (std::vector<std::wstring>::iterator s = splitCommandLine.begin(); s != splitCommandLine.end(); ++s)
			{
				if (!(* s).compare(L"-n"))
				{
					std::advance(s, 1);
					CCore::program.name = * s;
				}
				else if (!(* s).compare(L"-h"))
				{
					std::advance(s, 1);
					CCore::program.server = * s;
				}
				else if (!(* s).compare(L"-p"))
				{
					try
					{
						std::advance(s, 1);
						CCore::program.port = boost::lexical_cast<unsigned int>(* s);
					}
					catch (boost::bad_lexical_cast &) {}
				}
			}
			if (CCore::program.name.empty())
			{
				CProgram::logText(L"Error obtaining player name");
			}
			if (CCore::program.server.empty())
			{
				CProgram::logText(L"Error obtaining server address");
			}
			if (!CCore::program.port)
			{
				CProgram::logText(L"Error obtaining server port");
			}
			WSADATA
				wsadata;
			if (WSAStartup(MAKEWORD(2,2), &wsadata) != NO_ERROR)
			{
				CProgram::logText(L"Error initializing Winsock");
			}
			if (!BASS_Init(-1, 44100, BASS_DEVICE_3D, NULL, NULL))
			{
				CProgram::logText(L"Error initializing audio device");
			}
			BASS_PluginLoad("plugins\\bassflac.dll", 0);
			BASS_PluginLoad("plugins\\basswma.dll", 0);
			BASS_PluginLoad("plugins\\basswv.dll", 0);
			BASS_PluginLoad("plugins\\bass_spx.dll", 0);
			BASS_PluginLoad("plugins\\bass_mpc.dll", 0);
			BASS_PluginLoad("plugins\\bass_ac3.dll", 0);
			BASS_PluginLoad("plugins\\bass_aac.dll", 0);
			BASS_PluginLoad("plugins\\bass_alac.dll", 0);
			BASS_PluginLoad("plugins\\bass_tta.dll", 0);
			BASS_PluginLoad("plugins\\bass_ape.dll", 0);
			BASS_PluginLoad("plugins\\bass_ofr.dll", 0);
			BASS_SetConfig(BASS_CONFIG_NET_PLAYLIST, 1);
			BASS_SetConfig(BASS_CONFIG_NET_PREBUF, 0);
			BASS_SetConfig(BASS_CONFIG_WMA_BASSFILE, 1);
			std::wstring
				filePath = boost::str(boost::wformat(L"%1%\\audio.ini") % CCore::program.savePath);
			if (boost::filesystem::exists(filePath))
			{
				CSimpleIniW
					ini(true, false, true);
				SI_Error
					error = ini.LoadFile(filePath.c_str());
				if (!error)
				{
					const wchar_t
						* value[9];
					value[0] = ini.GetValue(L"settings", L"playback_volume");
					value[1] = ini.GetValue(L"settings", L"automatically_reconnect");
					value[2] = ini.GetValue(L"settings", L"mute_playback_when_minimized");
					value[3] = ini.GetValue(L"settings", L"transfer_files_from_server");
					value[4] = ini.GetValue(L"settings", L"stream_files_from_internet");
					value[5] = ini.GetValue(L"settings", L"extract_files_from_game");
					value[6] = ini.GetValue(L"settings", L"reconnect_attempts");
					value[7] = ini.GetValue(L"settings", L"reconnect_delay");
					value[8] = ini.GetValue(L"settings", L"enable_logging");
					if (value[0] != NULL)
					{
						try
						{
							CCore::program.volume = boost::lexical_cast<unsigned int>(value[0]);
						}
						catch (boost::bad_lexical_cast &) {}
						if (CCore::program.volume < 0 || CCore::program.volume > 100)
						{
							CCore::program.volume = 100;
						}
					}
					if (value[1] != NULL)
					{
						try
						{
							CCore::settings.autoReconnect = boost::lexical_cast<bool>(value[1]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[2] != NULL)
					{
						try
						{
							CCore::settings.mutePlayback = boost::lexical_cast<bool>(value[2]);
						}
						catch (boost::bad_lexical_cast &)
						{
							CCore::settings.mutePlayback = true;
						}
					}
					if (value[3] != NULL)
					{
						try
						{
							CCore::settings.transferFiles = boost::lexical_cast<bool>(value[3]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[4] != NULL)
					{
						try
						{
							CCore::settings.streamFiles = boost::lexical_cast<bool>(value[4]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[5] != NULL)
					{
						try
						{
							CCore::settings.extractFiles = boost::lexical_cast<bool>(value[5]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[6] != NULL)
					{
						try
						{
							CCore::settings.reconnectAttempts = boost::lexical_cast<unsigned int>(value[6]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[7] != NULL)
					{
						try
						{
							CCore::settings.reconnectDelay = boost::lexical_cast<unsigned int>(value[7]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
					if (value[8] != NULL)
					{
						try
						{
							CCore::settings.enableLogging = boost::lexical_cast<bool>(value[8]);
						}
						catch (boost::bad_lexical_cast &) {}
					}
				}
			}
			else
			{
				std::wofstream
					fileOut(filePath.c_str(), std::wofstream::out);
				fileOut.close();
				CSimpleIniW
					ini(true, false, true);
				SI_Error
					error = ini.LoadFile(filePath.c_str());
				if (!error)
				{
					try
					{
						ini.SetValue(L"settings", L"playback_volume", boost::lexical_cast<std::wstring>(CCore::program.volume).c_str());
						ini.SetValue(L"settings", L"automatically_reconnect", boost::lexical_cast<std::wstring>(CCore::settings.autoReconnect).c_str());
						ini.SetValue(L"settings", L"mute_playback_when_minimized", boost::lexical_cast<std::wstring>(CCore::settings.mutePlayback).c_str());
						ini.SetValue(L"settings", L"transfer_files_from_server", boost::lexical_cast<std::wstring>(CCore::settings.transferFiles).c_str());
						ini.SetValue(L"settings", L"stream_files_from_internet", boost::lexical_cast<std::wstring>(CCore::settings.streamFiles).c_str());
						ini.SetValue(L"settings", L"extract_files_from_game", boost::lexical_cast<std::wstring>(CCore::settings.extractFiles).c_str());
						ini.SetValue(L"settings", L"reconnect_attempts", boost::lexical_cast<std::wstring>(CCore::settings.reconnectAttempts).c_str());
						ini.SetValue(L"settings", L"reconnect_delay", boost::lexical_cast<std::wstring>(CCore::settings.reconnectDelay).c_str());
						ini.SetValue(L"settings", L"enable_logging", boost::lexical_cast<std::wstring>(CCore::settings.enableLogging).c_str());
					}
					catch (boost::bad_lexical_cast &) {}
					ini.SaveFile(filePath.c_str());
				}
			}
			BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, CCore::program.volume * 100);
			CCore::program.initialized = true;
			while (true)
			{
				if (* (unsigned int *)0xB7CD98 != NULL)
				{
					boost::this_thread::sleep(boost::posix_time::seconds(10));
					boost::thread
						initiateConnectionThread(CNetwork::initiateConnection);
					break;
				}
				boost::this_thread::sleep(boost::posix_time::seconds(1));
			}
		}
		else
		{
			CProgram::logText(boost::str(boost::wformat(L"Error reading command line: %1%") % commandLine));
		}
	}
}

BOOL WINAPI
	DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpvReserved)
{
	switch (fdwReason)
	{
		case DLL_PROCESS_ATTACH:
		{
			DisableThreadLibraryCalls(hinstDLL);
			boost::thread
				initializeThread(Initialize);
		}
		break;
		case DLL_PROCESS_DETACH:
		{
			if (CCore::program.initialized)
			{
				CProgram::logText(L"SA-MP Audio Plugin unloaded");
				TerminateProcess(CCore::gui.shellInfo.hProcess, 0);
				BASS_SetEAXParameters(-1, -1, -1, -1);
				if (lpvReserved == NULL)
				{
					BASS_Free();
					WSACleanup();
				}
			}
		}
		break;
	}
	return TRUE;
}
