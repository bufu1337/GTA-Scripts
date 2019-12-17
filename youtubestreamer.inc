//==============================================================================
//                         Youtube Streamer Include by Usrb1n !
//                     http://forum.sa-mp.com/member.php?u=122322
//==============================================================================
#include <a_http>
forward U2BStream(playerid, response_code, data[]);
new YoutubeID[32];

stock YoutubeStream(playerid, vlink[])
{
	new videoid[128], YoutubeString[128];
	strmid(videoid,vlink,31,44,strlen(vlink));
	format(YoutubeString,sizeof(YoutubeString),"www.youtube-mp3.org/api/itemInfo/?video_id=%s",videoid);
	strmid(YoutubeID, videoid, 0, 12);
    HTTP(playerid,HTTP_GET,YoutubeString,videoid,"U2BStream");
}

public U2BStream(playerid, response_code, data[])
{
	if(response_code == 200)
	{

	    new result[33], u2bstr[33]; new streamedurl[128];
		new crypted = strfind(data, "\"h\"", true, -1);
		strmid(result,data,crypted+7,crypted+39,strlen(data));
		format(u2bstr,sizeof(u2bstr), "%s", result);
		format(streamedurl, sizeof(streamedurl), "http://www.youtube-mp3.org/get?video_id=%s&h=%s",YoutubeID, u2bstr);
		PlayAudioStreamForPlayer(playerid, streamedurl);
  	}
  	else
    {
		SendClientMessage(playerid, 0xAA3333AA, "Invalid Youtube URL, please try again with other video.");
    }
  	return 1;
}

stock YoutubeStopStream(playerid)
{
	PlayAudioStreamForPlayer(playerid, "Youtube streaming was stoped.");
}
