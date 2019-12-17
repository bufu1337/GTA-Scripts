#include <a_samp>

//14.09467
//28.18934

forward MegaRotate();

new Spokes1[20];
new Spokes2[20];
new Platforms[20];
new OtherObjects[5];

public OnFilterScriptInit()
{
	print("\n----------------------------------");
	print("|  Backwardsman97's Ferris Wheel |");
	print("----------------------------------\n");
	
	OtherObjects[0] = CreateObject(11495,1936.170043,1543.748046,11.463454,-11.500000,0.000000,0.000000);
	OtherObjects[1] = CreateObject(11495,1936.170043,1521.971679,13.853022,1.000000,0.000000,-180.000000);
	OtherObjects[2] = CreateObject(11495,1936.170043,1500.135498,12.144302,10.000000,0.000000,-359.899902);
	OtherObjects[3] = CreateObject(11495,1936.209960,1478.264038,9.722596,2.500000,0.000000,-359.899902);
	OtherObjects[4] = CreateObject(1391,1948.728149,1526.686645,31.447168,0.000000,0.000000,0.000000);

	new Float:y,Float:z,Float:dis,Float:Rot;
	Spokes1[0] = CreateObject(3398,1943.8535,1526.9259,55.33241,0,Rot,270);
	for(new i=1; i<19; i++)
	{
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition((Rot -= 18.9),y,z,14.09467);
		dis = floatsqroot(((1526.9259 - y) * (1526.9259 - y)) + ((z - 55.33241) * (z - 55.33241)));
		Spokes1[i] = CreateObject(3398,1943.8535,y,z-dis,0,Rot,270);
	}
	Rot = 0;
	Spokes2[0] = CreateObject(3398,1940.8535,1526.9259,55.33241,0,Rot,270);
	Platforms[0] = CreateObject(3095,1941.8535,1526.9259,69.42708,0,0,0);
	for(new i=1; i<19; i++)
	{
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition((Rot -= 18.9),y,z,14.09467);
		dis = floatsqroot(((1526.9259 - y) * (1526.9259 - y)) + ((z - 55.33241) * (z - 55.33241)));
		Spokes2[i] = CreateObject(3398,1940.8535,y,z-dis,0,Rot,270);
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition(Rot,y,z,28.18934);
		Platforms[i] = CreateObject(3095,1941.8535,y,z-dis,0,0,0);
	}
	SetTimer("MegaRotate",50,1);
	return 1;
}

public OnFilterScriptExit()
{
	for(new i; i<20; i++)
	{
	    DestroyObject(Spokes1[i]);
	    DestroyObject(Spokes2[i]);
	    DestroyObject(Platforms[i]);
		DestroyObject(OtherObjects[i]);
	}
	return 1;
}

public MegaRotate()
{
	new Float:y,Float:y2,Float:z,Float:dis;
	for(new i=0; i<19; i++)
	{
	    GetObjectRot(Spokes1[i],y2,y2,z);
		SetObjectRot(Spokes1[i],0,y2-=0.25,270);
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition(y2,y,z,14.09467);
		dis = floatsqroot(((1526.9259 - y) * (1526.9259 - y)) + ((z - 55.33241) * (z - 55.33241)));
		SetObjectPos(Spokes1[i],1943.8535,y,z-dis);

	    GetObjectRot(Spokes2[i],y2,y2,z);
		SetObjectRot(Spokes2[i],0,y2-=0.25,270);
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition(y2,y,z,14.09467);
		dis = floatsqroot(((1526.9259 - y) * (1526.9259 - y)) + ((z - 55.33241) * (z - 55.33241)));
		SetObjectPos(Spokes2[i],1940.8535,y,z-dis);
		
		y=1526.9259; z=55.33241;
		GetXYInDirectionOfPosition(y2+0.2,y,z,28.18934);
		SetObjectPos(Platforms[i],1941.8535,y,z-dis);
	}
	return 1;
}

stock GetXYInDirectionOfPosition(Float:direction, &Float:x, &Float:y, Float:dist)
{
    x += (dist * floatsin(-direction, degrees));
    y += (dist * floatcos(-direction, degrees));
}

