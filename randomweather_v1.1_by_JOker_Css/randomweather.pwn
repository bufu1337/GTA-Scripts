#include <a_samp>

forward WeatherTimer();
forward SetRandomWeather();

enum weather_info
{
	wt_id,
	wt_text[255]
};

new gRandomWeatherIDs[][weather_info] =
{
	{0,"Blue Sky"},
	{1,"Blue Sky"},
	{2,"Blue Sky"},
	{3,"Blue Sky"},
	{4,"Blue Sky"},
	{5,"Blue Sky"},
	{6,"Blue Sky"},
	{7,"Blue Sky"},
	{08,"Stormy"},
	{09,"Cloudy and Foggy"},
	{10,"Clear Blue Sky"},
 	{11,"Heatwave"},
    {17,"Heatwave"},
    {18,"Heatwave"},
	{12,"Dull, Colourless"},
    {13,"Dull, Colourless"},
    {14,"Dull, Colourless"},
    {15,"Dull, Colourless"},
	{16,"Dull, Cloudy, Rainy"},
	{19,"Sandstorm"},
	{20,"Foggy, Greenish"},
	{21,"Very Dark, Gradiented Skyline, Purple"},
    {22,"Very Dark, Gradiented Skyline, Purple"},
	{23,"Pale Orange"},
    {24,"Pale Orange"},
    {25,"Pale Orange"},
    {26,"Pale Orange"},
	{27,"Fresh Blue"},
    {28,"Fresh Blue"},
    {29,"Fresh Blue"},
	{30,"Dark, Cloudy, Teal"},
    {31,"Dark, Cloudy, Teal"},
    {32,"Dark, Cloudy, Teal"},
	{33,"Dark, Cloudy, Brown"},
	{34,"Blue/Purple, Regular"},
	{35,"Dull Brown"},
	{36,"Bright, Foggy, Orange"},
	{37,"Bright, Foggy, Orange"},
	{38,"Bright, Foggy, Orange"},
	{39,"Very Bright"},
	{40,"Blue/Purple, Cloudy"},
	{41,"Blue/Purple, Cloudy"},
	{42,"Blue/Purple, Cloudy"},
	{43,"Toxic Clouds"},
	{44,"Black/White Sky"},
	{700,"Stormy with Pink Sky and Crystal Water"},
	{150,"Darkest Weather Ever"}
};

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Random Weather Filterscript by JOker_CSS V1.1 ");
	print("--------------------------------------\n");
	SetTimer("SetRandomWeather", 300000, 1);
	return 1;
}

public SetRandomWeather()
{
	new rand = random(sizeof(gRandomWeatherIDs));
	new strout[256];
	format(strout, sizeof(strout), "Weather changed to %s", gRandomWeatherIDs[rand][wt_text]);
	SetWeather(gRandomWeatherIDs[rand][wt_id]);
	SendClientMessageToAll(0xAA3333AA,strout);
	print(strout);
}

public OnFilterScriptExit()
{
	return 1;
}
