/*==============================================================================
----------------------Automatic weather changer By Deadpool---------------------
==============================================================================*/

//Includes
#include <a_samp>

//defines
#define WEATHER_TIME 3 // 3 hrs

//new(s)
new CurrentWeather;

//Forward(s)
forward ChangeWeather();

//Stock(s)
stock GetWeatherName(weatherid)
{
	new WeatherNameString[100];

	switch(weatherid)
	{
		case 0: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 1: format(WeatherNameString, sizeof(WeatherNameString), "Sunny with high visibility and moderate clouds");
		case 2: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 3: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 4: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 5: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 6: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 7: format(WeatherNameString, sizeof(WeatherNameString), "Extra Sunny with high visibility and moderate clouds");
		case 8: format(WeatherNameString, sizeof(WeatherNameString), "Wet and Rainy with medium visibility and heavy clouds");
		case 9: format(WeatherNameString, sizeof(WeatherNameString), "Thick Foggy with low visibility and heavy clouds");
		case 10: format(WeatherNameString, sizeof(WeatherNameString), "Sunny with high visibility and moderate clouds");
		case 11: format(WeatherNameString, sizeof(WeatherNameString), "HeatWave with high visibility and moderate clouds");
		case 12: format(WeatherNameString, sizeof(WeatherNameString), "Hazy/Dull with moderate visibility and high clouds");
		case 13: format(WeatherNameString, sizeof(WeatherNameString), "Hazy/Dull with moderate visibility and high clouds");
		case 14: format(WeatherNameString, sizeof(WeatherNameString), "Hazy/Dull with moderate visibility and high clouds");
		case 15: format(WeatherNameString, sizeof(WeatherNameString), "Heavy RainStorm with low visibility and very thick clouds");
		case 16: format(WeatherNameString, sizeof(WeatherNameString), "Wet and Rainy with medium visibility and heavy clouds");
		case 17: format(WeatherNameString, sizeof(WeatherNameString), "Scorching Hot Bright with high visibility and low clouds");
		case 18: format(WeatherNameString, sizeof(WeatherNameString), "Scorching Hot Bright with high visibility and low clouds");
		case 19: format(WeatherNameString, sizeof(WeatherNameString), "Sand Storm with very low visibility and high clouds");
		case 20: format(WeatherNameString, sizeof(WeatherNameString), "Toxic Green Smog with low visibility and high clouds");
	}
	return WeatherNameString;
}

//Public(s)
public OnFilterScriptInit()
{
	print("\n---------------------------------------------");
	print(" Automatic Weather Changer By De4dpOol loaded!!");
	print("---------------------------------------------\n");

	SetTimer("ChangeWeather", WEATHER_TIME * 3600 * 1000, 1);

	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerWeather(playerid, CurrentWeather);
	return 1;
}

public ChangeWeather()
{
	new NewWeather, NEWS[120];
	NewWeather = random(20);

	SetWeather(NewWeather);
	CurrentWeather = NewWeather;

	format(NEWS, sizeof(NEWS), "[[WEATHER REPORT]] Today's weather will be %s.", GetWeatherName(NewWeather));
	SendClientMessageToAll(-1, NEWS);
}

/*==============================================================================
---------------------------------End of Script----------------------------------
==============================================================================*/