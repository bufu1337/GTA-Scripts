SA-MP Audio Plugin v0.4
Copyright © Incognito 2010

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

Preface
-------
This plugin creates a TCP server that can communicate with external
clients to transfer and play back audio files, stream audio files
from the Internet, and extract audio archives from the game. The
concept is based on hansen111's Sound Unlimited project. It has
several features, including:

* Seamless integration with San Andreas Multiplayer
* Audio playback with looping, pausing, resuming, and stopping,
  restarting, seeking, and volume adjusting
* San Andreas audio archive support—over 60,000 audio files available
  to use (after extraction) with no download required
* Internet audio file streaming that supports nearly all online
  stations, including SHOUTcast and Icecast
* Sequence system for gapless playback of multiple audio files
* Multiple audio streams per client assigned to handle IDs for easy
  manipulation
* Support for WAV, AIFF, MP3/MP2/MP1, OGG, WMA, FLAC, WV, SPX, MPC,
  AC3, AAC, ALAC, TTA, APE, and OFR formats
* In-game 3D sound support (dynamic volume adjustment)
* EAX environment settings and sound effects
* Audio pack system for organizing audio files and ensuring easy
  distribution among clients
* Local file transfers with CRC checks and remote file transfers with
  file size checks to ensure that files do not get re-downloaded
* Audio archive extraction with file count checks to ensure that
  audio archives do not get re-extracted
* Player indexing system for name and IP address authentication
* Function to obtain the player's TCP server connection status

Information
-----------
The Windows version is audio.dll (you will need the Microsoft .NET
Framework 3.5 SP1 or higher), and the Linux version is audio.so.

Two example audio packs have been included. Note that the files in
audio.ini do not exist—they are simply examples. Remember that local
files (those that are not prefixed with http:// or ftp://) must be
in the audiopacks folder in the server directory for CRC checks to
take place. Remote files use file size checks, and audio archives
use file count checks.

See the included filterscript for more detailed information on
how to use the natives, callbacks, and stock functions.

Tutorial
--------
Client:

Installation and use of the client plugin is simple—just run the
installer and extract the files to your GTA: San Andreas directory.
The ASI plugin detects when SA-MP is loaded and obtains your current
player name, server address, and server port automatically. It will
then attempt to connect to the TCP server (if there is one) some time
after the game has started. By default, there will be a total of five
retry attempts with a delay of twenty seconds each. To adjust these
numbers, along with a few other settings, you need to edit audio.ini.
To locate this file, go to Start, click Run, and type in the
following:

%APPDATA%\SA-MP Audio Plugin

An Explorer window should open. In this directory, you should see
your downloaded audiopacks, extracted audio files, audio.ini, and
audio.txt.

Server:

First, create a folder called plugins in your server directory if it
doesn't already exist. Place audio.dll in it if you're using Windows,
or audio.so if you're using Linux.

Add the following line to server.cfg so that the plugin will load the
next time the server starts: 

Windows:
plugins audio

Linux:
plugins audio.so

The server log should indicate that the plugin was loaded
successfully. The include file then needs to be put in a filterscript
or a gamemode (preferably a gamemode so that there will be no
conflicts):

#include <audio>

The server log should also indicate that the TCP server was created
successfully on the same port that the SA-MP sever is using.

Ensure that both the audiopacks folder and the audio.ini file are in
the root directory of the server. Open audio.ini and add a section
for your audio pack name. For demonstration purposes, this will be
called "default_pack":

[default_pack]

Navigate to your audiopacks directory and create a folder called
"default_pack" within it. This is where all of your local audio files
will go. Add an audio file to the "default_pack" folder. This will be
called "test.wav". Map it under the section you just created in
audio.ini:

[default_pack]
1 = test.wav

The number to the left of the file name (1) is the audio ID. It is an
arbitrary number, so it can be whatever you'd like. It can be used in
Audio_Play like this:

Audio_Play(playerid, 1, false, false, false);

You can also map remote files that don't need to be in your
audiopacks directory. They must start with http:// or ftp://. Here's
an example:

[default_pack]
1 = test.wav
2 = http://www.website.com/example.mp3

Audio archives can be mapped as well. These don't need to be present
anywhere but on the client's machine (more information on this is in
the section below):

[default_pack]
1 = test.wav
2 = http://www.website.com/example.mp3
archive = AMBIENCE

In your gamemode, make sure that these things are present:

public
	OnGameModeInit()
{
	// Set the audio pack when the gamemode loads
	Audio_SetPack("default_pack", true);
}

public
	Audio_OnClientConnect(playerid)
{
	// Transfer the audio pack when the player connects
	Audio_TransferPack(playerid);
}

public
	Audio_OnSetPack(audiopack[])
{
	for (new i = 0; i < MAX_PLAYERS; i++)
	{
		// Transfer the audio pack to all players when it is set
		Audio_TransferPack(i);
	}
	return 1;
}

That will ensure that audio packs are set and transferred correctly
(more information is available in the example filterscript).

Alternatively, you can just completely ignore audio.ini and use the
Audio_PlayStreamed native. The choice is yours.

Audio Archives
--------------
There are 63915 audio files from 25 archives that can be extracted.
Of these, 1922 are streams from 16 archives and 61993 are sound
effects from 9 archives. It is also worth noting that the streams
are OGG Vorbis files, and the sound effects are WAV files. The
following are valid archives that can be extracted:

Streams:

AA          Police radio messages (1001-1066)
ADVERTS     Advertisements for radio stations (1067-1135)
AMBIENCE    Background environment sounds (1136-1175)
BEATS       Beats and various other dance tracks (1176-1185)
CH          Playback FM (1186-1315)
CO          K-Rose (1316-1470)
CR          K-DST (1471-1626)
CUTSCENE    Mission cutscenes (1627-1767)
DS          Bounce FM (1768-1946)
HC          SF-UR (1947-2061)
MH          Radio Los Santos (2062-2213)
MR          Radio X (2214-2360)
NJ          CSR 103.9 (2361-2490)
RE          K-JAH (2491-2651)
RG          Master Sounds 98.3 (2652-2821)
TK          WCTR (2822-2922)

Sound effects:

FEET        Running and walking sounds (2923-2960)
GENRL       Vehicle and weapon sounds (2961-3612)
PAIN_A      Pain sounds from player (3613-4013)
SCRIPT      Scripted voice clips and other sounds (4014-10864)
SPC_EA      Emergency service speech (10865-14509)
SPC_FA      Girlfriend and clerk speech (14510-17250)
SPC_GA      Normal pedestrian speech (17251-48484)
SPC_NA      Gang member and special character speech (48485-60807)
SPC_PA      Non-mission speech from CJ (60808-64915)

Refer to saat\mappings.ini in the client package for a complete list
of reserved audio IDs. To see how streams are sequenced in the game,
refer to saat\metadata-full.ini.

Changelog
---------
v0.4:
- Ported the external client to an ASI plugin that loads
  automatically with SA-MP
- Fixed several bugs and optimized a lot of code in both the client
  plugin and the server plugin
- Added support for real 3D playback (Audio_Set3DPosition now accepts
  game world coordinates)
- Added support for downmixing so that Audio_SetFX, Audio_SetEAX, and
  Audio_Set3DOffsets will work with any audio stream
- Made the TCP server start automatically (using same port as the
  SA-MP server) when a script containing the include file is loaded
- Removed limitations on files, sequence IDs, and handle IDs

v0.3.4:
- Fixed crash on Linux that occurred when data was sent to a
  disconnected client
- Added support for automatic player indexing and deindexing
- Made some small optimizations to the client and updated a few of
  the libraries it uses (not required for the new plugin version)

v0.3.3:
- Removed poll timer necessity and improved internal queue
- Increased client limit to 500 for SA-MP 0.3 compatibility
- Increased global sequences limit to 128
- Added SPX support
- Fixed bug in the client that caused audio archives not to extract
  in Windows Vista/7
- Made an installer for the client

v0.3.2:
- Fixed bug related to stopping and starting audio files in
  the client; handle IDs and sequence IDs are now automatically
  assigned by the plugin
- Fixed bug in the client that caused some track changes in online
  stations to print incorrectly
- Made the text block in the client auto-clear after reaching a
  set limit (committed in v0.3.1, but lowered limit in v0.3.2)

v0.3.1:
- Added Audio_OnTrackChange callback that is triggered when a track
  change occurs in an online station
- Fixed connection logic error
- Changed second parameter of Audio_OnClientDisconnect from a string
  to an integer
- Put remote downloads in their own thread in the client
- Fixed possible problems related to connection throttling in the
  client and the server

v0.3:
- Overhauled string handling, making both the client and server
  more stable, more secure, and able to communicate more efficiently
- Added support for audio archive file extraction
- Made a reserved audioid space (1001-64915) for playing back mapped
  audio files extracted from the audio archives
- Extended file map limit to 1000
- Extended simultaneous audio streams limit to 32
- Created a sequence system for gapless playback of multiple mapped
  audio files
- Added an extra argument for Audio_Play (and all of its variants)
  for automatically pausing the audio stream before it begins playing
- Added support for FLAC, WV, MPC, AC3, AAC, ALAC, TTA, APE, and OFR
  formats
- Added an additional result to the Audio_OnTransferFile callback to
  indicate that an audio archive has sucessfully completed extraction
- Added illegal character checks to file names during local file
  transfers
- Added options to the client for enabling or disabling file transfer
  requests, Internet file streaming, and audio archive extraction
- Changed the icon that the client uses and expanded the text block

v0.2:
- Committed numerous security enhancements and bug fixes
- Added a text block for logging purposes to the client
- Added options to the client for automatically connecting when the
  game starts, reconnecting when the connection is lost, and muting
  playback when the game is minimized
- Removed the Audio_Disconnect native, the Audio_Pause callback, and
  Audio_Resume callback
- Switched from irrKlang to BASS
- Added support for multiple file playback, Internet file streaming,
  restarting, seeking, volume adjusting, 3D positioning, sound
  effects, and EAX environment settings
- Removed MOD music support
- Added support for only the following file types: WAV, AIFF,
  MP3/MP2/MP1, OGG, and WMA
- Made the Audio_Play and Audio_Stop callbacks trigger when audio
  files are actually played and stopped on the client
- Added a remote file downloading option to the audio pack system
- Added an additional result to the Audio_OnTransferFile callback to
  indicate that a file has successfully downloaded from a remote
  location

v0.1.1:
- Fixed Linux compatibility issues
- Improved socket handling
- Fixed possible buffer overflow vulnerabilities in the server
- Added automatic client version checking to the server during the
  connection process
- Removed the Audio_GetClientVersion native
- Made some small adjustments to the client

v0.1 Beta:
- Initial release

Natives
-------
* Audio_CreateTCPServer(port);
      o Creates the TCP server (done automatically—no need to use
        unless restarting); note that this must be on the same port
        that the SA-MP server is using

* Audio_DestroyTCPServer();
      o Destroys the TCP server (no need to use unless restarting)

* Audio_SetPack(const audiopack[], bool:transferable = true);
      o Maps audio files specified under the pack name in audio.ini
        and specifies whether the pack should be transferable (if it
        is not, then only CRC checks—or, if the files are remote,
        file size checks, and if it is an archive, file count checks—
        will take place)

* Audio_CreateSequence();
      o Creates a sequence (returns the sequenceid)

* Audio_DestroySequence(sequenceid);
      o Destroys a sequence

* Audio_AddToSequence(sequenceid, audioid);
      o Adds a mapped audio file to a sequence

* Audio_RemoveFromSequence(sequenceid, audioid);
      o Removes all instances of a mapped audio file from a sequence

* Audio_Play(playerid, audioid, bool:pause = false, bool:loop = false, bool:downmix = false);
      o Plays a mapped audio file for a client and specifies whether
        it should start paused, whether it should be looped, and
        whether the audio stream should be downmixed to mono (returns
        the handleid)

* Audio_PlaySequence(playerid, sequenceid, bool:pause = false, bool:loop = false, bool:downmix = false);
      o Plays a sequence for a client and specifies whether it should
        start paused, whether it should be looped, and whether the
        audio stream should be downmixed to mono (returns the
        handleid)

* Audio_PlayStreamed(playerid, const url[], bool:pause = false, bool:loop = false, bool:downmix = false);
      o Streams a URL for a client and specifies whether it should
        start paused, whether it should be looped, and whether the
        audio stream should be downmixed to mono (returns the
        handleid)

* Audio_Pause(playerid, handleid);
      o Pauses playback for an audio stream assigned to a player's
        handleid

* Audio_Resume(playerid, handleid);
      o Resumes playback for an audio stream assigned to a player's
        handleid

* Audio_Stop(playerid, handleid);
      o Stops playback for an audio stream assigned to a player's
        handleid

* Audio_Restart(playerid, handleid);
      o Restarts playback for an audio stream assigned to a player's
        handleid

* Audio_Seek(playerid, handleid, seconds);
      o Seeks playback in seconds for an audio stream assigned to a
        player's handleid

* Audio_SetVolume(playerid, handleid, volume);
      o Adjusts volume (0-100) for an audio stream assigned to a
        player's handleid

* Audio_Set3DPosition(playerid, handleid, Float:x, Float:y, Float:z, Float:distance);
      o Sets the 3D position (game world coordinates) of an audio
        stream assigned to a player's handleid

* Audio_Set3DOffsets(playerid, handleid, Float:x, Float:y, Float:z);
      o Sets the 3D offsets of an audio stream assigned to a player's
        handleid (audio stream must be downmixed or encoded in mono)

* Audio_SetFX(playerid, handleid, type);
      o Applies a sound effect an audio stream assigned to a player's
        handleid (audio stream must be downmixed or encoded in mono);
        valid values are as follows:
            + 0: Chorus
            + 1: Compression
            + 2: Distortion
            + 3: Echo
            + 4: Flanger
            + 5: Gargle
            + 6: I3DL2 Reverb
            + 7: Parametric Equalizer
            + 8: Reverb

* Audio_RemoveFX(playerid, handleid, type);
      o Removes a sound effect from an audio stream assigned to a
        player's handleid (audio stream must be downmixed or encoded
        in mono); valid values are listed above

* Audio_SetEAX(playerid, environment);
      o Sets the client's EAX environment for both all active audio
        streams (must be downmixed or encoded in mono) and the game
        itself; valid values are as follows (note: this setting will
        not work in Windows Vista or higher as Microsoft dropped
        support for DirectSound and DirectSound3D hardware
        acceleration):
            + 0: Generic
            + 1: Padded Cell
            + 2: Room
            + 3: Bathroom
            + 4: Living Room
            + 5: Stone Room
            + 6: Auditorium
            + 7: Concert Hall
            + 8: Cave
            + 9: Arena
            + 10: Hangar
            + 11: Carpeted Hallway
            + 12: Hallway
            + 13: Stone Corridor
            + 14: Alley
            + 15: Forest
            + 16: City
            + 17: Mountains
            + 18: Quarry
            + 19: Plain
            + 20: Parking Lot
            + 21: Sewer Pipe
            + 22: Underwater
            + 23: Drugged
            + 24: Dizzy
            + 25: Psychotic

* Audio_RemoveEAX(playerid);
      o Removes the EAX environment for the player

* Audio_IsClientConnected(playerid);
      o Returns the player's TCP server connection status

* Audio_TransferPack(playerid);
      o Transfers the currently set audio pack to a player

Callbacks
---------
* Audio_OnClientConnect(playerid);
      o Called when a player connects to the TCP server

* Audio_OnClientDisconnect(playerid);
      o Called when a player disconnects from the TCP server

* Audio_OnSetPack(audiopack[]);
      o Called when an audio pack is set

* Audio_OnTransferFile(playerid, file[], current, total, result);
      o Called when a player completes the transfer of a file; the
        result can be one of the following:
            + 0: Local file downloaded successfully
            + 1: Remote file downloaded successfully
            + 2: Archive extracted successfully
            + 3: File passed CRC check, file size check, or file
                 count check
            + 4: File could not be downloaded, file did not pass the
                 CRC or file size check, or archive could not be
                 extracted (if the audio pack is non-transferable)

* Audio_OnPlay(playerid, handleid);
      o Called when a player starts an audio file

* Audio_OnStop(playerid, handleid);
      o Called when a player stops an audio file (including when the
        finishes playing on its own)

* Audio_OnTrackChange(playerid, handleid, track[])
      o Called when a track change occurs in an online station

Thanks
------
- SA-MP team, past and present
- Developers of the various libraries I used for this project
- P.D. Escobar for SAAT (San Andreas Audio Toolkit)
- hansen111 for the original idea and many helpful suggestions
- Rebel and Wicko for testing and reporting bugs