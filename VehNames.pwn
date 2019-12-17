/*
First, I'd like to thank Francis[French] for inspiring me into making this. He showed an example and so I enchanted it and completed it. I
decided to release it in public due to alot of people needing it. Feel free to edit the text since I think I have have added too much info
XD

Vehicle ID: Server's vehicle ID.(Ex. First scripted car will be ID 1 - Useful for commands that can teleport you or teleport the vehicle to you.
Model ID: The real vehicle's ID.
And well the last one is the vehicle name.
	Enjoy~!
*/
#include <a_samp>

#include <core>

#include <float>
#pragma tabsize 0

public OnFilterScriptInit()
{
	print("¤|------------|>FilterScript<|------------|¤");
	print(" Vehicle Names Display Filterscript by Seif[CC] AKA Michael_Taylor");
	print(" Don't claim as yo' own, busta!   Have fun~");
	print("¤|------------|>Filterscript<|------------|¤");
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
new str[256];
switch(GetVehicleModel(vehicleid))
{
case 400:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~landstal",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 401:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~bravura",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 402:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~buffalo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 403:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~linerun",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 404:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~peren",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 405:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~sentinel",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 406:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~dumper",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 407:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Firetruck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 408:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Trash",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 409:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Limousine",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 410:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Manana",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 411:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Infernus",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 412:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Voodoo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 413:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Pony",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 414:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Mule",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 415:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Cheetah",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 416:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Ambulance",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 417:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Leviathan",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 418:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Moonbeam",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 419:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Esperant",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 420:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Taxi",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 421:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Washington",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 422:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bobcat",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 423:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Mr. Whoopee",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 424:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~BF Injection",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 425:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hunter",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 426:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Premier",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 427:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Enforcer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 428:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Securica",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 429:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Banshee",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 430:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Predator",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 431:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bus",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 432:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Rhino",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 433:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Barracks",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 434:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hotknife",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 435:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Artict1",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 436:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~previon",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 437:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~coach",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 438:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~cabbie",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 439:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~stallion",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 440:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~rumpo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 441:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Bandit",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 442:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Romero",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 443:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Packer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 444:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~monster",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 445:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~admiral",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 446:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~squalo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 447:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sea Sparrow",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 448:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Pizza Boy",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 449:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tram",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 450:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~artict2",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 451:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~turismo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 452:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~speeder",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 453:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~reefer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 454:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~tropic",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 455:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~flatbed",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 456:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~yankee",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 457:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~caddy",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 458:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~solair",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 459:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Van",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 460:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Skimmer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 461:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~PCJ-600",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 462:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Faggio",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 463:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Freeway",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 464:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Baron",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 465:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Raider",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 466:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Glendale",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 467:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Oceanic",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 468:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sanchez",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 469:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sparrow",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 470:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Patriot",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 471:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Quadbike",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 472:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Coastguard",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 473:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Dinghy",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 474:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hermes",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 475:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sabre",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 476:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Rustler",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 477:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~ZR3 50",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 478:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Walton",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 479:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Regina",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 480:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Comet",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 481:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~BMX",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 482:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Burrito",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 483:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Camper",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 484:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Marquis",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 485:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Baggage",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 486:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Dozer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 487:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Maverick",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 488:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~News Chopper",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 489:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Rancher",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 490:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~FBI Rancher",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 491:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Virgo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 492:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Greenwood",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 493:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Jetmax",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 494:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hotring",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 495:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sandking",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 496:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Blista Compact",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 497:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~SAMPD Maverick",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 498:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Boxville",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 499:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Benson",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 500:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Mesa",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 501:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Goblin",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 502:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hotring Racer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 503:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hotring Racer2",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 504:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bloodring Banger",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 505:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Rancher",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 506:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Super GT",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 507:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Elegant",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 508:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Journey",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 509:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bike",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 510:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Mountain Bike",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 511:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Beagle",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 512:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Cropdust",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 513:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Stunt",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 514:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tanker",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 515:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RoadTrain",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 516:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Nebula",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 517:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Majestic",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 518:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Buccaneer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 519:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Shamal",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 520:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hydra",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 521:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~FCR-900",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 522:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~NRG-500",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 523:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~HPV1000",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 524:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Cement Truck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 525:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tow Truck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 526:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Fortune",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 527:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Cadrona",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 528:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~FBI Truck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 529:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Willard",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 530:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Forklift",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 531:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tractor",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 532:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Combine",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 533:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Feltzer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 534:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Remington",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 535:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Slamvan",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 536:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Blade",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 537:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Freight",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 538:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Streak",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 539:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Vortex",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 540:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Vincent",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 541:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bullet",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 542:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Clover",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 543:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sadler",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 544:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Firetruck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 545:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hustler",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 546:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Intruder",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 547:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Primo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 548:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Cargobob",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 549:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tampa",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 550:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sunrise",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 551:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Merit",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 552:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Utility",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 553:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Nevada",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 554:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Yosemite",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 555:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Windsor",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 556:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Monster",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 557:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Monster",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 558:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Uranus",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 559:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Jester",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 560:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sultan",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 561:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Stratum",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 562:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Elegy",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 563:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Raindance",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 564:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Tiger",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 565:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Flash",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 566:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tahoma",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 567:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Savanna",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 568:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Bandito",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 569:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Freight",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 570:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 571:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Go Kart",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 572:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Mower",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 573:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Duneride",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 574:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sweeper",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 575:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Broadway",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 576:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tornado",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 577:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~AT-400",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 578:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~DFT-30",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 579:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Huntley",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 580:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Stafford",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 581:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~BF-400",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 582:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~News Van",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 583:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Tug",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 584:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 585:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Emperor",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 586:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Wayfarer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 587:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Euros",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 588:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Hotdog",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 589:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Club",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 590:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 591:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 592:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Andromada",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 593:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Dodo",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 594:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~RC Cam",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 595:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Launch",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 596:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~LSPD Police Car",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 597:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~SFPD Police Car",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 598:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~LVPD Police Car",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 599:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Police Ranger",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 600:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Picador",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 601:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~S.W.A.T. Truck",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 602:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Alpha",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 603:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Phoenix",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 604:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Glenshit",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 605:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Sadler",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 606:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Luggage Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 607:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Luggage Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 608:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Stair Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 609:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Boxville",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 610:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Farm Plow",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
case 611:{format(str,255,"~y~Vehicle ID: %d ~n~ ~r~Model ID: %d ~n~ ~g~Utility Trailer",vehicleid,GetVehicleModel(vehicleid));GameTextForPlayer(playerid,str,5000,1); return 1;}
}
return 0;
}
