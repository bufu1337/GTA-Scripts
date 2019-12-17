/*
	Ship And Dock v1 - By Kwarde
	With this filterscript, you can let a ship move (back) and (un)sink.
	It also contains a dock, where the ship is in the begin.
	Use /shiphelp ingame to see the commands

	Changelog:
	    v1.0
	        - Dock created
	        - Ship frame added
		v1.0.1
		    - Ship details added
		    - Script created
		v1.2
		    - Added to ship: "Chill place"
		v1.3
		    - Added to FS: Use streamer (true / false)
		v1.3.1
		    - Added to ship: Two rooms
		v1.4
		    - Added to ship: Control room

		v2.0
		    - Filterscript rebuilded
		    - Restart/Reload objects

	Idea's, will be done on another time:
	    - Control the script yourself


	Enjoy the script
*/

#define USE_STREAMER    false //Change from to true if you wanna use Incognito's streamer
#define RCON_ONLY       true //Change to false if everyone may use the commands

#include <a_samp>
#include <zcmd>

#if USE_STREAMER != false
	#include <streamer>
#endif

#define COLOR_WHITE     0xFFFFFFAA
#define COLOR_RED       0xFF0000AA
#define COLOR_GREEN     0x00FF00AA
#define COLOR_GRAY      0xAFAFAFAA

new ShipObj[85], Dock[40];

public OnFilterScriptInit()
{
	SetupShip();
	SetupDock();
	return 1;
}

public OnFilterScriptExit()
{
	for(new i = 0; i < sizeof(ShipObj); i++)
	#if USE_STREAMER == false
	    DestroyObject(ShipObj[i]);
	#else
	    DestroyDynamicObject(ShipObj[i]);
	#endif

	for(new i = 0; i < sizeof(Dock); i++)
	#if USE_STREAMER == false
	    DestroyObject(Dock[i]);
	#else
	    DestroyDynamicObject(Dock[i]);
	#endif
	return 1;
}

stock SetupShip()
{
	new Float:ObjPos[3];

	#if USE_STREAMER == false
	ShipObj[0] = CreateObject(9585, 43.483898162842, -1850.40625, 4.5250005722046, 0, 0, 276);
    ShipObj[1] = CreateObject(9586, 43.2470703125, -1848.03125, 14.643371582031, 0, 0, 275.99853515625);
    ShipObj[2] = CreateObject(9584, 35.628719329834, -1775.3720703125, 23.071884155273, 0, 0, 276);
    ShipObj[3] = CreateObject(9590, 43.883964538574, -1856.6527099609, 6.4613246917725, 0, 0, 275.75);
    ShipObj[4] = CreateObject(9698, 35.653831481934, -1786.9564208984, 25.958005905151, 0, 0, 276.25);
    ShipObj[5] = CreateObject(9761, 43.283760070801, -1848.7287597656, 24.188587188721, 0, 359.75, 276);
    ShipObj[6] = CreateObject(9818, 37.201538085938, -1790.1665039063, 30.725940704346, 0, 0, 276);
    ShipObj[7] = CreateObject(9819, 43.296676635742, -1789.5061035156, 29.960704803467, 0, 0, 275.5);
    ShipObj[8] = CreateObject(9822, 42.975723266602, -1789.1489257813, 29.780256271362, 0, 0, 275.75);
    ShipObj[9] = CreateObject(2780, 31.821399688721, -1770.7666015625, 35.409591674805, 0, 0, 0);
    ShipObj[10] = CreateObject(2780, 38.315055847168, -1769.9385986328, 35.410572052002, 0, 0, 0);
    ShipObj[11] = CreateObject(8661, 47.418716430664, -1875.1500244141, 0.050000000745058, 0, 0, 276);
    ShipObj[12] = CreateObject(8661, 43.334167480469, -1835.3726806641, 0.050000000745058, 0, 0, 275.99853515625);
    ShipObj[13] = CreateObject(8661, 41.87427520752, -1875.7666015625, 0.050000000745058, 0, 0, 275.99853515625);
    ShipObj[14] = CreateObject(8661, 37.272842407227, -1838.5076904297, 0.025000004097819, 0, 0, 275.99853515625);
    ShipObj[15] = CreateObject(3361, 32.275650024414, -1823.0256347656, 11.748504638672, 0, 0, 6.9930419921875);
    ShipObj[16] = CreateObject(3361, 38.254776000977, -1822.2946777344, 7.7488770484924, 0, 0, 6.9927978515625);
    ShipObj[17] = CreateObject(3361, 44.21236038208, -1821.5419921875, 3.7238759994507, 0, 0, 6.9927978515625);
    ShipObj[18] = CreateObject(3361, 48.862804412842, -1824.7498779297, -0.34112682938576, 0, 0, 274.99279785156);
    ShipObj[19] = CreateObject(3361, 29.396572113037, -1798.8150634766, 17.448501586914, 0, 0, 275.74304199219);
    ShipObj[20] = CreateObject(3361, 29.738637924194, -1802.4256591797, 15.048461914063, 0, 0, 275.74035644531);
    ShipObj[21] = CreateObject(1494, 40.787311553955, -1857.9372558594, 13.932260513306, 0, 0, 189.25);
    ShipObj[22] = CreateObject(2957, 37.067981719971, -1858.5174560547, 15.552045822144, 0, 0, 8);
    ShipObj[23] = CreateObject(2957, 43.002605438232, -1857.5762939453, 15.544406890869, 0, 0, 7.748046875);
    ShipObj[24] = CreateObject(2957, 47.403442382813, -1856.9685058594, 15.544406890869, 0, 0, 7.75);
    ShipObj[25] = CreateObject(2957, 49.966709136963, -1858.8060302734, 15.544406890869, 0, 0, 277.75);
    ShipObj[26] = CreateObject(2957, 50.5114402771, -1863.2119140625, 15.544406890869, 0, 0, 276.24536132813);
    ShipObj[27] = CreateObject(2957, 48.578559875488, -1865.8278808594, 15.544406890869, 0, 0, 7.490234375);
    ShipObj[28] = CreateObject(1494, 46.350337982178, -1866.1070556641, 13.924621582031, 0, 0, 187.24499511719);
    ShipObj[29] = CreateObject(2957, 42.566467285156, -1866.7683105469, 15.544406890869, 0, 0, 7.4871826171875);
    ShipObj[30] = CreateObject(2957, 38.195976257324, -1867.4030761719, 15.544406890869, 0, 0, 7.4871826171875);
    ShipObj[31] = CreateObject(2957, 35.161327362061, -1861.0772705078, 15.552045822144, 0, 0, 276.5);
    ShipObj[32] = CreateObject(2957, 35.697372436523, -1865.3625488281, 15.494407653809, 0, 0, 277.74841308594);
    ShipObj[33] = CreateObject(8615, 39.986820220947, -1865.9940185547, 15.29932975769, 0, 0, 7.25);
    ShipObj[34] = CreateObject(2957, 35.157749176025, -1861.0670166016, 18.534536361694, 0, 0, 276.49841308594);
    ShipObj[35] = CreateObject(2957, 35.693088531494, -1865.2985839844, 18.494415283203, 0, 0, 277.74536132813);
    ShipObj[36] = CreateObject(2957, 38.164653778076, -1867.2338867188, 18.468807220459, 0, 0, 7.4871826171875);
    ShipObj[37] = CreateObject(2957, 42.529594421387, -1866.6649169922, 18.497608184814, 0, 0, 6.4871826171875);
    ShipObj[38] = CreateObject(2957, 48.576370239258, -1865.8072509766, 18.419736862183, 0, 0, 7.4871826171875);
    ShipObj[39] = CreateObject(2957, 50.535251617432, -1863.2862548828, 18.446695327759, 0, 0, 276.240234375);
    ShipObj[40] = CreateObject(2957, 49.997470855713, -1858.7940673828, 18.447904586792, 0, 0, 277.74536132813);
    ShipObj[41] = CreateObject(3095, 45.771366119385, -1861.6817626953, 16.424621582031, 0, 0, 7.75);
    ShipObj[42] = CreateObject(2957, 47.424850463867, -1856.9786376953, 18.42373085022, 0, 0, 7.745361328125);
    ShipObj[43] = CreateObject(2957, 43.004455566406, -1857.5855712891, 18.499773025513, 0, 0, 7.745361328125);
    ShipObj[44] = CreateObject(2957, 37.030506134033, -1858.5275878906, 18.487871170044, 0, 0, 7.998046875);
    ShipObj[45] = CreateObject(3095, 45.81600189209, -1861.6077880859, 20.079965591431, 0, 0.5, 6.745361328125);
    ShipObj[46] = CreateObject(3095, 39.770530700684, -1862.5007324219, 20.147932052612, 0, 0.4998779296875, 7.4901123046875);
    ShipObj[47] = CreateObject(9241, 50.821025848389, -1905.9147949219, 15.583526611328, 0, 0, 278);
    ShipObj[48] = CreateObject(983, 41.119911193848, -1861.3629150391, 17.663539886475, 0, 358.25, 8.25);
    ShipObj[49] = CreateObject(991, 41.145748138428, -1857.9453125, 18.847486495972, 0, 0, 9.75);
    ShipObj[50] = CreateObject(991, 47.576030731201, -1865.9973144531, 18.170227050781, 0, 0, 8);
    ShipObj[51] = CreateObject(1432, 46.840042114258, -1859.0361328125, 13.924621582031, 0, 0, 0);
    ShipObj[52] = CreateObject(1432, 47.805969238281, -1862.5476074219, 13.924621582031, 0, 0, 0);
    ShipObj[53] = CreateObject(1432, 43.791053771973, -1861.0028076172, 13.924621582031, 0, 0, 52.5);
    ShipObj[54] = CreateObject(16782, 35.837787628174, -1863.0460205078, 18.379728317261, 0, 0, 8.75);
    ShipObj[55] = CreateObject(1256, 47.185543060303, -1858.9666748047, 17.639442443848, 0, 0, 7.75);
    ShipObj[56] = CreateObject(1256, 47.866458892822, -1862.2260742188, 17.639442443848, 0, 0, 0);
    ShipObj[57] = CreateObject(3055, 39.299251556396, -1885.0667724609, 2.2481195926666, 0, 0, 8.75);
    ShipObj[58] = CreateObject(1491, 44.704555511475, -1884.3295898438, 0.050000000745058, 0, 0, 189);
    ShipObj[59] = CreateObject(3055, 48.569339752197, -1883.7635498047, 2.2481195926666, 0, 0, 8.7451171875);
    ShipObj[60] = CreateObject(1491, 53.976253509521, -1882.9841308594, 0.050000000745058, 0, 0, 188.99780273438);
    ShipObj[61] = CreateObject(3055, 57.785675048828, -1882.3334960938, 2.2481195926666, 0, 0, 8.7451171875);
    ShipObj[62] = CreateObject(3055, 49.248294830322, -1887.8892822266, 2.1981194019318, 0, 0, 96.7451171875);
    ShipObj[63] = CreateObject(3095, 55.624660491943, -1887.2305908203, 5.0322999954224, 0, 0, 9);
    ShipObj[64] = CreateObject(3095, 46.781917572021, -1888.6334228516, 5.0351295471191, 0, 0, 8.997802734375);
    ShipObj[65] = CreateObject(3095, 38.617237091064, -1889.8363037109, 5.0499992370605, 0, 0, 8.997802734375);
    ShipObj[66] = CreateObject(3095, 56.496437072754, -1894.8913574219, 5.0376634597778, 0, 0, 8.997802734375);
    ShipObj[67] = CreateObject(3095, 47.579879760742, -1895.3758544922, 5.0152535438538, 0, 0, 8.997802734375);
    ShipObj[68] = CreateObject(3095, 38.912551879883, -1893.3049316406, 5.0303626060486, 0, 0, 8.997802734375);
    ShipObj[69] = CreateObject(3062, 43.203227996826, -1884.6644287109, 3.8920805454254, 0, 359.75, 8.75);
    ShipObj[70] = CreateObject(3062, 52.47233581543, -1883.1804199219, 3.8943710327148, 0, 359.74731445313, 8.7451171875);
    ShipObj[71] = CreateObject(3055, 50.086460113525, -1895.2823486328, 2.1981194019318, 0, 0, 95.990112304688);
    ShipObj[72] = CreateObject(2297, 37.358871459961, -1895.4787597656, 0.050000000745058, 0, 359.75, 100);
    ShipObj[73] = CreateObject(2575, 35.574024200439, -1888.2697753906, 0.43224477767944, 0, 0, 6.5);
    ShipObj[74] = CreateObject(1726, 38.720645904541, -1891.5716552734, 0.050000000745058, 0, 0, 319.75);
    ShipObj[75] = CreateObject(1738, 35.751216888428, -1890.7237548828, 0.67963063716888, 0, 0, 274.5);
    ShipObj[76] = CreateObject(14384, 46.3278465271, -1891.6834716797, 1.5425968170166, 0, 0, 277.50006103516);
    ShipObj[77] = CreateObject(2863, 48.230175018311, -1888.1566162109, 1.1750000715256, 0, 0, 0);
    ShipObj[78] = CreateObject(2297, 58.923896789551, -1892.2702636719, 0.050000060349703, 0, 359.74731445313, 183.74755859375);
    ShipObj[79] = CreateObject(1726, 55.580635070801, -1891.3629150391, 0.3430290222168, 0, 0, 45.74609375);
    ShipObj[80] = CreateObject(1738, 58.407581329346, -1887.0886230469, 0.70463061332703, 0, 0, 274.49890136719);
    ShipObj[81] = CreateObject(2575, 55.216018676758, -1885.3802490234, 0.43224477767944, 0, 0, 7.9984130859375);
    ShipObj[82] = CreateObject(14384, 53.041675567627, -1890.3740234375, 1.5425968170166, 0, 0, 96.5);
    ShipObj[83] = CreateObject(2863, 51.232322692871, -1893.1806640625, 0.050000000745058, 0, 0, 0);
    #else
 	ShipObj[0] = CreateDynamicObject(9585, 43.483898162842, -1850.40625, 4.5250005722046, 0, 0, 276);
    ShipObj[1] = CreateDynamicObject(9586, 43.2470703125, -1848.03125, 14.643371582031, 0, 0, 275.99853515625);
    ShipObj[2] = CreateDynamicObject(9584, 35.628719329834, -1775.3720703125, 23.071884155273, 0, 0, 276);
    ShipObj[3] = CreateDynamicObject(9590, 43.883964538574, -1856.6527099609, 6.4613246917725, 0, 0, 275.75);
    ShipObj[4] = CreateDynamicObject(9698, 35.653831481934, -1786.9564208984, 25.958005905151, 0, 0, 276.25);
    ShipObj[5] = CreateDynamicObject(9761, 43.283760070801, -1848.7287597656, 24.188587188721, 0, 359.75, 276);
    ShipObj[6] = CreateDynamicObject(9818, 37.201538085938, -1790.1665039063, 30.725940704346, 0, 0, 276);
    ShipObj[7] = CreateDynamicObject(9819, 43.296676635742, -1789.5061035156, 29.960704803467, 0, 0, 275.5);
    ShipObj[8] = CreateDynamicObject(9822, 42.975723266602, -1789.1489257813, 29.780256271362, 0, 0, 275.75);
    ShipObj[9] = CreateDynamicObject(2780, 31.821399688721, -1770.7666015625, 35.409591674805, 0, 0, 0);
    ShipObj[10] = CreateDynamicObject(2780, 38.315055847168, -1769.9385986328, 35.410572052002, 0, 0, 0);
    ShipObj[11] = CreateDynamicObject(8661, 47.418716430664, -1875.1500244141, 0.050000000745058, 0, 0, 276);
    ShipObj[12] = CreateDynamicObject(8661, 43.334167480469, -1835.3726806641, 0.050000000745058, 0, 0, 275.99853515625);
    ShipObj[13] = CreateDynamicObject(8661, 41.87427520752, -1875.7666015625, 0.050000000745058, 0, 0, 275.99853515625);
    ShipObj[14] = CreateDynamicObject(8661, 37.272842407227, -1838.5076904297, 0.025000004097819, 0, 0, 275.99853515625);
    ShipObj[15] = CreateDynamicObject(3361, 32.275650024414, -1823.0256347656, 11.748504638672, 0, 0, 6.9930419921875);
    ShipObj[16] = CreateDynamicObject(3361, 38.254776000977, -1822.2946777344, 7.7488770484924, 0, 0, 6.9927978515625);
    ShipObj[17] = CreateDynamicObject(3361, 44.21236038208, -1821.5419921875, 3.7238759994507, 0, 0, 6.9927978515625);
    ShipObj[18] = CreateDynamicObject(3361, 48.862804412842, -1824.7498779297, -0.34112682938576, 0, 0, 274.99279785156);
    ShipObj[19] = CreateDynamicObject(3361, 29.396572113037, -1798.8150634766, 17.448501586914, 0, 0, 275.74304199219);
    ShipObj[20] = CreateDynamicObject(3361, 29.738637924194, -1802.4256591797, 15.048461914063, 0, 0, 275.74035644531);
    ShipObj[21] = CreateDynamicObject(1494, 40.787311553955, -1857.9372558594, 13.932260513306, 0, 0, 189.25);
    ShipObj[22] = CreateDynamicObject(2957, 37.067981719971, -1858.5174560547, 15.552045822144, 0, 0, 8);
    ShipObj[23] = CreateDynamicObject(2957, 43.002605438232, -1857.5762939453, 15.544406890869, 0, 0, 7.748046875);
    ShipObj[24] = CreateDynamicObject(2957, 47.403442382813, -1856.9685058594, 15.544406890869, 0, 0, 7.75);
    ShipObj[25] = CreateDynamicObject(2957, 49.966709136963, -1858.8060302734, 15.544406890869, 0, 0, 277.75);
    ShipObj[26] = CreateDynamicObject(2957, 50.5114402771, -1863.2119140625, 15.544406890869, 0, 0, 276.24536132813);
    ShipObj[27] = CreateDynamicObject(2957, 48.578559875488, -1865.8278808594, 15.544406890869, 0, 0, 7.490234375);
    ShipObj[28] = CreateDynamicObject(1494, 46.350337982178, -1866.1070556641, 13.924621582031, 0, 0, 187.24499511719);
    ShipObj[29] = CreateDynamicObject(2957, 42.566467285156, -1866.7683105469, 15.544406890869, 0, 0, 7.4871826171875);
    ShipObj[30] = CreateDynamicObject(2957, 38.195976257324, -1867.4030761719, 15.544406890869, 0, 0, 7.4871826171875);
    ShipObj[31] = CreateDynamicObject(2957, 35.161327362061, -1861.0772705078, 15.552045822144, 0, 0, 276.5);
    ShipObj[32] = CreateDynamicObject(2957, 35.697372436523, -1865.3625488281, 15.494407653809, 0, 0, 277.74841308594);
    ShipObj[33] = CreateDynamicObject(8615, 39.986820220947, -1865.9940185547, 15.29932975769, 0, 0, 7.25);
    ShipObj[34] = CreateDynamicObject(2957, 35.157749176025, -1861.0670166016, 18.534536361694, 0, 0, 276.49841308594);
    ShipObj[35] = CreateDynamicObject(2957, 35.693088531494, -1865.2985839844, 18.494415283203, 0, 0, 277.74536132813);
    ShipObj[36] = CreateDynamicObject(2957, 38.164653778076, -1867.2338867188, 18.468807220459, 0, 0, 7.4871826171875);
    ShipObj[37] = CreateDynamicObject(2957, 42.529594421387, -1866.6649169922, 18.497608184814, 0, 0, 6.4871826171875);
    ShipObj[38] = CreateDynamicObject(2957, 48.576370239258, -1865.8072509766, 18.419736862183, 0, 0, 7.4871826171875);
    ShipObj[39] = CreateDynamicObject(2957, 50.535251617432, -1863.2862548828, 18.446695327759, 0, 0, 276.240234375);
    ShipObj[40] = CreateDynamicObject(2957, 49.997470855713, -1858.7940673828, 18.447904586792, 0, 0, 277.74536132813);
    ShipObj[41] = CreateDynamicObject(3095, 45.771366119385, -1861.6817626953, 16.424621582031, 0, 0, 7.75);
    ShipObj[42] = CreateDynamicObject(2957, 47.424850463867, -1856.9786376953, 18.42373085022, 0, 0, 7.745361328125);
    ShipObj[43] = CreateDynamicObject(2957, 43.004455566406, -1857.5855712891, 18.499773025513, 0, 0, 7.745361328125);
    ShipObj[44] = CreateDynamicObject(2957, 37.030506134033, -1858.5275878906, 18.487871170044, 0, 0, 7.998046875);
    ShipObj[45] = CreateDynamicObject(3095, 45.81600189209, -1861.6077880859, 20.079965591431, 0, 0.5, 6.745361328125);
    ShipObj[46] = CreateDynamicObject(3095, 39.770530700684, -1862.5007324219, 20.147932052612, 0, 0.4998779296875, 7.4901123046875);
    ShipObj[47] = CreateDynamicObject(9241, 50.821025848389, -1905.9147949219, 15.583526611328, 0, 0, 278);
    ShipObj[48] = CreateDynamicObject(983, 41.119911193848, -1861.3629150391, 17.663539886475, 0, 358.25, 8.25);
    ShipObj[49] = CreateDynamicObject(991, 41.145748138428, -1857.9453125, 18.847486495972, 0, 0, 9.75);
    ShipObj[50] = CreateDynamicObject(991, 47.576030731201, -1865.9973144531, 18.170227050781, 0, 0, 8);
    ShipObj[51] = CreateDynamicObject(1432, 46.840042114258, -1859.0361328125, 13.924621582031, 0, 0, 0);
    ShipObj[52] = CreateDynamicObject(1432, 47.805969238281, -1862.5476074219, 13.924621582031, 0, 0, 0);
    ShipObj[53] = CreateDynamicObject(1432, 43.791053771973, -1861.0028076172, 13.924621582031, 0, 0, 52.5);
    ShipObj[54] = CreateDynamicObject(16782, 35.837787628174, -1863.0460205078, 18.379728317261, 0, 0, 8.75);
    ShipObj[55] = CreateDynamicObject(1256, 47.185543060303, -1858.9666748047, 17.639442443848, 0, 0, 7.75);
    ShipObj[56] = CreateDynamicObject(1256, 47.866458892822, -1862.2260742188, 17.639442443848, 0, 0, 0);
    ShipObj[57] = CreateDynamicObject(3055, 39.299251556396, -1885.0667724609, 2.2481195926666, 0, 0, 8.75);
    ShipObj[58] = CreateDynamicObject(1491, 44.704555511475, -1884.3295898438, 0.050000000745058, 0, 0, 189);
    ShipObj[59] = CreateDynamicObject(3055, 48.569339752197, -1883.7635498047, 2.2481195926666, 0, 0, 8.7451171875);
    ShipObj[60] = CreateDynamicObject(1491, 53.976253509521, -1882.9841308594, 0.050000000745058, 0, 0, 188.99780273438);
    ShipObj[61] = CreateDynamicObject(3055, 57.785675048828, -1882.3334960938, 2.2481195926666, 0, 0, 8.7451171875);
    ShipObj[62] = CreateDynamicObject(3055, 49.248294830322, -1887.8892822266, 2.1981194019318, 0, 0, 96.7451171875);
    ShipObj[63] = CreateDynamicObject(3095, 55.624660491943, -1887.2305908203, 5.0322999954224, 0, 0, 9);
    ShipObj[64] = CreateDynamicObject(3095, 46.781917572021, -1888.6334228516, 5.0351295471191, 0, 0, 8.997802734375);
    ShipObj[65] = CreateDynamicObject(3095, 38.617237091064, -1889.8363037109, 5.0499992370605, 0, 0, 8.997802734375);
    ShipObj[66] = CreateDynamicObject(3095, 56.496437072754, -1894.8913574219, 5.0376634597778, 0, 0, 8.997802734375);
    ShipObj[67] = CreateDynamicObject(3095, 47.579879760742, -1895.3758544922, 5.0152535438538, 0, 0, 8.997802734375);
    ShipObj[68] = CreateDynamicObject(3095, 38.912551879883, -1893.3049316406, 5.0303626060486, 0, 0, 8.997802734375);
    ShipObj[69] = CreateDynamicObject(3062, 43.203227996826, -1884.6644287109, 3.8920805454254, 0, 359.75, 8.75);
    ShipObj[70] = CreateDynamicObject(3062, 52.47233581543, -1883.1804199219, 3.8943710327148, 0, 359.74731445313, 8.7451171875);
    ShipObj[71] = CreateDynamicObject(3055, 50.086460113525, -1895.2823486328, 2.1981194019318, 0, 0, 95.990112304688);
    ShipObj[72] = CreateDynamicObject(2297, 37.358871459961, -1895.4787597656, 0.050000000745058, 0, 359.75, 100);
    ShipObj[73] = CreateDynamicObject(2575, 35.574024200439, -1888.2697753906, 0.43224477767944, 0, 0, 6.5);
    ShipObj[74] = CreateDynamicObject(1726, 38.720645904541, -1891.5716552734, 0.050000000745058, 0, 0, 319.75);
    ShipObj[75] = CreateDynamicObject(1738, 35.751216888428, -1890.7237548828, 0.67963063716888, 0, 0, 274.5);
    ShipObj[76] = CreateDynamicObject(14384, 46.3278465271, -1891.6834716797, 1.5425968170166, 0, 0, 277.50006103516);
    ShipObj[77] = CreateDynamicObject(2863, 48.230175018311, -1888.1566162109, 1.1750000715256, 0, 0, 0);
    ShipObj[78] = CreateDynamicObject(2297, 58.923896789551, -1892.2702636719, 0.050000060349703, 0, 359.74731445313, 183.74755859375);
    ShipObj[79] = CreateDynamicObject(1726, 55.580635070801, -1891.3629150391, 0.3430290222168, 0, 0, 45.74609375);
    ShipObj[80] = CreateDynamicObject(1738, 58.407581329346, -1887.0886230469, 0.70463061332703, 0, 0, 274.49890136719);
    ShipObj[81] = CreateDynamicObject(2575, 55.216018676758, -1885.3802490234, 0.43224477767944, 0, 0, 7.9984130859375);
    ShipObj[82] = CreateDynamicObject(14384, 53.041675567627, -1890.3740234375, 1.5425968170166, 0, 0, 96.5);
    ShipObj[83] = CreateDynamicObject(2863, 51.232322692871, -1893.1806640625, 0.050000000745058, 0, 0, 0);
    #endif

    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        GetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
        SetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]+0.75); //In due of water in the room's
	#else
	    GetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
	    SetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[3]);
	#endif
	}
    return 1;
}

stock SetupDock()
{
    #if USE_STREAMER == false
 	Dock[0] = CreateObject(18483, 81.011100769043, -1705.0255126953, 11.200012207031, 1.495361328125, 4.5015258789063, 13.88232421875);
    Dock[1] = CreateObject(8661, 35.742343902588, -1705.5147705078, 14.490695953369, 358.50054931641, 1.5005187988281, 281.53930664063);
    Dock[2] = CreateObject(9245, 49.311943054199, -1692.9489746094, 26.189413070679, 0, 1.25, 279.5);
    Dock[3] = CreateObject(3330, 69.275344848633, -1706.9719238281, 1.6515100002289, 358.5, 0.25009155273438, 276.00653076172);
    Dock[4] = CreateObject(3331, 78.24976348877, -1714.0494384766, 20.879306793213, 4.25, 0, 103.25);
    Dock[5] = CreateObject(8661, 16.132955551147, -1709.3427734375, 14.961807250977, 358.75036621094, 1.5003662109375, 281.53277587891);
    Dock[6] = CreateObject(8661, 6.3799548149109, -1711.2147216797, 5.25, 87.498291015625, 36.830352783203, 244.69311523438);
    Dock[7] = CreateObject(8661, 29.507394790649, -1726.8186035156, 4.25, 88.725433349609, 78.560729980469, 293.18920898438);
    Dock[8] = CreateObject(8661, 22.143238067627, -1687.8956298828, 5.2499952316284, 88.483032226563, 279.63690185547, 271.85113525391);
    Dock[9] = CreateObject(8661, 45.091869354248, -1703.5845947266, 2.9749979972839, 87.697448730469, 257.60583496094, 201.89678955078);
    Dock[10] = CreateObject(3530, 52.674251556396, -1682.6840820313, 8.75, 0, 0.75, 6.25);
    Dock[11] = CreateObject(3530, 52.728771209717, -1682.6732177734, -1.3749996423721, 0, 0, 6.5);
    Dock[12] = CreateObject(3530, 55.491794586182, -1700.7764892578, 8.5, 0, 0, 9.25);
    Dock[13] = CreateObject(3530, 55.489055633545, -1700.73046875, -1.6499998569489, 0, 0, 9.25);
    Dock[14] = CreateObject(3095, 49.328594207764, -1687.2121582031, 13.900001525879, 0, 0, 11);
    Dock[15] = CreateObject(3095, 50.955303192139, -1695.9719238281, 13.851438522339, 0, 0, 10.75);
    Dock[16] = CreateObject(3753, 0.51476269960403, -1721.1441650391, 5.6000051498413, 0.25, 0, 102.75);
    Dock[17] = CreateObject(980, -6.3578171730042, -1696.7789306641, 7.5381851196289, 0, 0, 13.75);
    Dock[18] = CreateObject(980, -10.796052932739, -1703.7828369141, 7.562961101532, 0, 0, 282);
    Dock[19] = CreateObject(980, -8.3204469680786, -1714.9696044922, 7.3631806373596, 0, 0, 282.25);
    Dock[20] = CreateObject(980, -5.8992915153503, -1726.1544189453, 7.5653076171875, 0, 0, 282);
    Dock[21] = CreateObject(980, -3.1206941604614, -1737.1689453125, 7.5641913414001, 0, 0, 284);
    Dock[22] = CreateObject(980, -1.5833661556244, -1743.7879638672, 7.3541932106018, 0, 0, 283.25);
    Dock[23] = CreateObject(3406, 3.652453660965, -1751.9141845703, 2.6749978065491, 0, 0, 103.5);
    Dock[24] = CreateObject(3406, 5.854483127594, -1752.4516601563, 2.6749978065491, 0, 0, 283.5);
    Dock[25] = CreateObject(8661, 11.136465072632, -1727.1043701172, 5.6250014305115, 88.720062255859, 78.557861328125, 24.686492919922);
    Dock[26] = CreateObject(8661, 9.4770307540894, -1727.1508789063, 4.7218337059021, 88.714569091797, 78.557769775391, 204.68627929688);
    Dock[27] = CreateObject(3406, 5.7636137008667, -1760.3895263672, 2.6750016212463, 0, 0, 104.49667358398);
    Dock[28] = CreateObject(3406, 7.7189345359802, -1759.8511962891, 2.675000667572, 0, 0, 104.99645996094);
    Dock[29] = CreateObject(3406, 9.1619424819946, -1768.2302246094, 2.8000011444092, 0, 2, 92.996307373047);
    Dock[30] = CreateObject(3406, 7.1650805473328, -1768.3065185547, 2.7750029563904, 0, 1.99951171875, 92.993774414063);
    Dock[31] = CreateObject(3361, 9.5523824691772, -1776.3304443359, 7, 0, 0, 93);
    Dock[32] = CreateObject(3361, 7.5218114852905, -1776.4283447266, 6.9750018119812, 0, 0, 92.999267578125);
    Dock[33] = CreateObject(3406, 9.9795188903809, -1782.9996337891, 7.1249995231628, 0, 1.99951171875, 94.243774414063);
    Dock[34] = CreateObject(3406, 7.9783802032471, -1783.1278076172, 7.1481318473816, 0, 1.99951171875, 94.24072265625);
    Dock[35] = CreateObject(3406, 10.668048858643, -1791.1636962891, 7.4500045776367, 0, 1.99951171875, 95.74072265625);
    Dock[36] = CreateObject(3406, 8.7157106399536, -1791.3649902344, 7.4347991943359, 0, 1.99951171875, 95.740356445313);
    Dock[37] = CreateObject(3361, 13.329012870789, -1796.8387451172, 11.581379890442, 0, 0, 185.24926757813);
    Dock[38] = CreateObject(3361, 15.439829826355, -1796.6345214844, 12.981380462646, 0, 0, 185.99597167969);
    Dock[39] = CreateObject(3406, 8.9293298721313, -1793.5124511719, 7.4884948730469, 0, 1.99951171875, 95.740356445313);
    #else
 	Dock[0] = CreateDynamicObject(18483, 81.011100769043, -1705.0255126953, 11.200012207031, 1.495361328125, 4.5015258789063, 13.88232421875);
    Dock[1] = CreateDynamicObject(8661, 35.742343902588, -1705.5147705078, 14.490695953369, 358.50054931641, 1.5005187988281, 281.53930664063);
    Dock[2] = CreateDynamicObject(9245, 49.311943054199, -1692.9489746094, 26.189413070679, 0, 1.25, 279.5);
    Dock[3] = CreateDynamicObject(3330, 69.275344848633, -1706.9719238281, 1.6515100002289, 358.5, 0.25009155273438, 276.00653076172);
    Dock[4] = CreateDynamicObject(3331, 78.24976348877, -1714.0494384766, 20.879306793213, 4.25, 0, 103.25);
    Dock[5] = CreateDynamicObject(8661, 16.132955551147, -1709.3427734375, 14.961807250977, 358.75036621094, 1.5003662109375, 281.53277587891);
    Dock[6] = CreateDynamicObject(8661, 6.3799548149109, -1711.2147216797, 5.25, 87.498291015625, 36.830352783203, 244.69311523438);
    Dock[7] = CreateDynamicObject(8661, 29.507394790649, -1726.8186035156, 4.25, 88.725433349609, 78.560729980469, 293.18920898438);
    Dock[8] = CreateDynamicObject(8661, 22.143238067627, -1687.8956298828, 5.2499952316284, 88.483032226563, 279.63690185547, 271.85113525391);
    Dock[9] = CreateDynamicObject(8661, 45.091869354248, -1703.5845947266, 2.9749979972839, 87.697448730469, 257.60583496094, 201.89678955078);
    Dock[10] = CreateDynamicObject(3530, 52.674251556396, -1682.6840820313, 8.75, 0, 0.75, 6.25);
    Dock[11] = CreateDynamicObject(3530, 52.728771209717, -1682.6732177734, -1.3749996423721, 0, 0, 6.5);
    Dock[12] = CreateDynamicObject(3530, 55.491794586182, -1700.7764892578, 8.5, 0, 0, 9.25);
    Dock[13] = CreateDynamicObject(3530, 55.489055633545, -1700.73046875, -1.6499998569489, 0, 0, 9.25);
    Dock[14] = CreateDynamicObject(3095, 49.328594207764, -1687.2121582031, 13.900001525879, 0, 0, 11);
    Dock[15] = CreateDynamicObject(3095, 50.955303192139, -1695.9719238281, 13.851438522339, 0, 0, 10.75);
    Dock[16] = CreateDynamicObject(3753, 0.51476269960403, -1721.1441650391, 5.6000051498413, 0.25, 0, 102.75);
    Dock[17] = CreateDynamicObject(980, -6.3578171730042, -1696.7789306641, 7.5381851196289, 0, 0, 13.75);
    Dock[18] = CreateDynamicObject(980, -10.796052932739, -1703.7828369141, 7.562961101532, 0, 0, 282);
    Dock[19] = CreateDynamicObject(980, -8.3204469680786, -1714.9696044922, 7.3631806373596, 0, 0, 282.25);
    Dock[20] = CreateDynamicObject(980, -5.8992915153503, -1726.1544189453, 7.5653076171875, 0, 0, 282);
    Dock[21] = CreateDynamicObject(980, -3.1206941604614, -1737.1689453125, 7.5641913414001, 0, 0, 284);
    Dock[22] = CreateDynamicObject(980, -1.5833661556244, -1743.7879638672, 7.3541932106018, 0, 0, 283.25);
    Dock[23] = CreateDynamicObject(3406, 3.652453660965, -1751.9141845703, 2.6749978065491, 0, 0, 103.5);
    Dock[24] = CreateDynamicObject(3406, 5.854483127594, -1752.4516601563, 2.6749978065491, 0, 0, 283.5);
    Dock[25] = CreateDynamicObject(8661, 11.136465072632, -1727.1043701172, 5.6250014305115, 88.720062255859, 78.557861328125, 24.686492919922);
    Dock[26] = CreateDynamicObject(8661, 9.4770307540894, -1727.1508789063, 4.7218337059021, 88.714569091797, 78.557769775391, 204.68627929688);
    Dock[27] = CreateDynamicObject(3406, 5.7636137008667, -1760.3895263672, 2.6750016212463, 0, 0, 104.49667358398);
    Dock[28] = CreateDynamicObject(3406, 7.7189345359802, -1759.8511962891, 2.675000667572, 0, 0, 104.99645996094);
    Dock[29] = CreateDynamicObject(3406, 9.1619424819946, -1768.2302246094, 2.8000011444092, 0, 2, 92.996307373047);
    Dock[30] = CreateDynamicObject(3406, 7.1650805473328, -1768.3065185547, 2.7750029563904, 0, 1.99951171875, 92.993774414063);
    Dock[31] = CreateDynamicObject(3361, 9.5523824691772, -1776.3304443359, 7, 0, 0, 93);
    Dock[32] = CreateDynamicObject(3361, 7.5218114852905, -1776.4283447266, 6.9750018119812, 0, 0, 92.999267578125);
    Dock[33] = CreateDynamicObject(3406, 9.9795188903809, -1782.9996337891, 7.1249995231628, 0, 1.99951171875, 94.243774414063);
    Dock[34] = CreateDynamicObject(3406, 7.9783802032471, -1783.1278076172, 7.1481318473816, 0, 1.99951171875, 94.24072265625);
    Dock[35] = CreateDynamicObject(3406, 10.668048858643, -1791.1636962891, 7.4500045776367, 0, 1.99951171875, 95.74072265625);
    Dock[36] = CreateDynamicObject(3406, 8.7157106399536, -1791.3649902344, 7.4347991943359, 0, 1.99951171875, 95.740356445313);
    Dock[37] = CreateDynamicObject(3361, 13.329012870789, -1796.8387451172, 11.581379890442, 0, 0, 185.24926757813);
    Dock[38] = CreateDynamicObject(3361, 15.439829826355, -1796.6345214844, 12.981380462646, 0, 0, 185.99597167969);
    Dock[39] = CreateDynamicObject(3406, 8.9293298721313, -1793.5124511719, 7.4884948730469, 0, 1.99951171875, 95.740356445313);
    #endif
    return 1;
}

stock ResetShip()
{
    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        DestroyObject(ShipObj[i]);
	#else
	    DestroyDynamicObject(ShipObj[i]);
	#endif
	    ShipObj[i] = (-1);
	}
	SetupShip();
	return 1;
}

stock MoveShipForward(Float:speed = 2.5)
{
	new Float:ObjPos[3];
    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        GetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
        MoveObject(ShipObj[i], ObjPos[0], ObjPos[1]-1000, ObjPos[2], speed); //It'll go in the land after a little while. Ignore it and continue on.
	#else
	    GetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
	    MoveDynamicObject(ShipObj[i], ObjPos[0], ObjPos[1]-1000, ObjPos[2], speed);
	#endif
	}
	return 1;
}

stock MoveShipBackwards(Float:speed = 1.8)
{
	new Float:ObjPos[3];
    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        GetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
        MoveObject(ShipObj[i], ObjPos[0], ObjPos[1]+1000, ObjPos[2], speed); //It'll go in the land after a little while. Ignore it and continue on.
	#else
	    GetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
	    MoveDynamicObject(ShipObj[i], ObjPos[0], ObjPos[1]+1000, ObjPos[2], speed);
	#endif
	}
	return 1;
}

stock SinkShip(Float:speed = 0.05)
{
	new Float:ObjPos[3];
    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        GetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
        MoveObject(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]-50, speed); //It'll go in the land after a little while. Ignore it and continue on.
	#else
	    GetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
	    MoveDynamicObject(ShipObj[i], ObjPos[0], ObjPos[1]-50, ObjPos[2], speed);
	#endif
	}
	return 1;
}

stock RaiseShip(Float:speed = 2.0)
{
	new Float:ObjPos[3];
    for(new i = 0; i < sizeof(ShipObj); i++){
    #if USE_STREAMER == false
        GetObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
        MoveObject(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]+50, speed); //It'll go in the land after a little while. Ignore it and continue on.
	#else
	    GetDynamicObjectPos(ShipObj[i], ObjPos[0], ObjPos[1], ObjPos[2]);
	    MoveDynamicObject(ShipObj[i], ObjPos[0], ObjPos[1]+50, ObjPos[2], speed);
	#endif
	}
	return 1;
}

stock StopShip()
{
	for(new i = 0; i < sizeof(ShipObj); i++)
	#if USE_STREAMER == false
	    StopObject(ShipObj[i]);
	#else
	    StopDynamicObject(ShipObj[i]);
	#endif
	return 1;
}

CMD:gotoship(playerid, params[])
{
	new vehicleid;
	if(GetPlayerState(playerid) != 2){
		SetPlayerPos(playerid, 106.719367, -1691.593017, 10.183582);
		SetPlayerFacingAngle(playerid, 108.967033);
	}
	else{
	    vehicleid = GetPlayerVehicleID(playerid);
	    SetVehiclePos(vehicleid, 109.382492, -1695.005371, 9.514464);
	    SetVehicleZAngle(vehicleid, 103.027679);
	    PutPlayerInVehicle(playerid, vehicleid, 0);
	}
	SendClientMessage(playerid, COLOR_GREEN, "* You've been teleported near the ship!");
	return 1;
}

CMD:shiphelp(playerid, params[])
{
	SendClientMessage(playerid, COLOR_WHITE, "|----- Ship And Dock: Help -----|");
	SendClientMessage(playerid, COLOR_GREEN, "To go near the ship (at the docks): /gotoship");
	#if RCON_ONLY == true
	if(IsPlayerAdmin(playerid))
		SendClientMessage(playerid, COLOR_GREEN, "/moveship(back)(ex) /(un)sinkship(ex) /stopship /resetship");
	else
	    SendClientMessage(playerid, COLOR_GRAY, "Ask an RCON admin to handle the ship");
	#else
	SendClientMessage(playerid, COLOR_GREEN, "/moveship(back)(ex) /(un)sinkship(ex) /stopship /resetship");
	SendClientMessage(playerid, COLOR_RED, "***** Scripted and mapped by Kwarde");
	SendClientMessage(playerid, COLOR_WHITE, "|--------------------------------|");
	#endif
	return 1;
}

CMD:moveship(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	MoveShipForward();
	SendClientMessage(playerid, COLOR_GREEN, "* The ship is now moving forward with the default speed");
	return 1;
}

CMD:moveshipex(playerid, params[])
{
	new str[60];
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	if(floatstr(params[0]) > 100 || floatstr(params[0]) <= 0) return SendClientMessage(playerid, COLOR_RED, "ERROR: Speed must be 0-100");
	MoveShipForward(floatstr(params[0]));
	format(str, 60, "* The ship is now moving forward with the speed %f", floatstr(params[0]));
	SendClientMessage(playerid, COLOR_GREEN, str);
	return 1;
}

CMD:moveshipback(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	MoveShipBackwards();
	SendClientMessage(playerid, COLOR_GREEN, "* The ship is now moving backwards with the default speed");
	return 1;
}

CMD:moveshipbackex(playerid, params[])
{
	new str[60];
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	if(floatstr(params[0]) > 100 || floatstr(params[0]) <= 0) return SendClientMessage(playerid, COLOR_RED, "ERROR: Speed must be 0-100");
	MoveShipBackwards(floatstr(params[0]));
	format(str, 60, "* The ship is now moving back with the speed %f", floatstr(params[0]));
	SendClientMessage(playerid, COLOR_GREEN, str);
	return 1;
}

CMD:sinkship(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	SinkShip();
	SendClientMessage(playerid, COLOR_GREEN, "ALERT: The ship's sinking!");
	return 1;
}

CMD:sinkshipex(playerid, params[])
{
	new str[60];
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	if(floatstr(params[0]) > 100 || floatstr(params[0]) <= 0) return SendClientMessage(playerid, COLOR_RED, "ERROR: Speed must be 0-100");
	SinkShip(floatstr(params[0]));
	format(str, 60, "ALERT: The ship's sinking on custom speed %f!", floatstr(params[0]));
	SendClientMessage(playerid, COLOR_GREEN, str);
	return 1;
}

CMD:unsinkship(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	RaiseShip();
	SendClientMessage(playerid, COLOR_GREEN, "ROFL the ship's raising... It's unsinking or... it's gonna fly :O");
	return 1;
}

CMD:unsinkshipex(playerid, params[])
{
	new str[100];
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	if(floatstr(params[0]) > 100 || floatstr(params[0]) <= 0) return SendClientMessage(playerid, COLOR_RED, "ERROR: Speed must be 0-100");
	RaiseShip(floatstr(params[0]));
	format(str, 100, "ROFL the ship's raising... It's unsinking or... it's gonna fly :O on custom speed %f", floatstr(params[0]));
	SendClientMessage(playerid, COLOR_GREEN, str);
	return 1;
}

CMD:stopship(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may handle the ship!");
	#endif
	StopShip();
	SendClientMessage(playerid, COLOR_GREEN, "* The ship has stopped moving");
	return 1;
}

CMD:resetship(playerid, params[])
{
	#if RCON_ONLY == true
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "Sorry, only RCON admins may reset the ship!");
	#endif
	ResetShip();
	SendClientMessage(playerid, COLOR_GREEN, "* Ship has been resetted");
	return 1;
}

CMD:text(playerid, params[])
	return GameTextForPlayer(playerid, params[0], 5000, 3);