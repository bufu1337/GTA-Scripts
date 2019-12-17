/*
	Filterscript:
		Rubik's Cube (Incomplete)
	Author:
		Simon_Italy
		forum.lifeofsf.org
	
	Release Date:
		May 2014
*/

#define FILTERSCRIPT

#include <a_samp>

#define SetInvisibleTexture(%0,%1) \
	SetObjectMaterial(%0, %1, 19341, "none", "none", 0x00FFFFFF)

#define SetObjectColour(%0,%1,%2) \
	SetObjectMaterial(%0, %1, 18646, "matcolours", "white", %2)

//

static const Float:HEIGHT_1 = 10.0;

#define		HEIGHT_2 		(HEIGHT_1 + 3.5)
#define		HEIGHT_3 		(HEIGHT_1 + 7.0)

#define    	HEIGHT_UP		(HEIGHT_1 + 8.78)
#define     	HEIGHT_DOWN		(HEIGHT_1 - 1.73)

enum eRubik1
{
	rUp,
	rFront,
	rBehind,
	rLeft,
	rRight,
	rDown
};

enum eRubik2
{
	rOriz,
	rVert,
	rLate
};

new stock
	rubikObject[6][9],
    	rubikRotate[3][3],
	rubikColour[6][9],
	rubikRotateStep[3][3];

new selectedRow;

//

stock AttachObjectsForRotation(idx)
{
	switch(idx)
	{
	    case rOriz:
	    {
			AttachObjectToObject(rubikObject[rUp][0], rubikRotate[rOriz][2], -2.821000, 2.9, 1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][1], rubikRotate[rOriz][2],  -0.081000, 2.9, 1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][2], rubikRotate[rOriz][2],  2.688999, 2.9, 1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][3], rubikRotate[rOriz][2], 2.688999, 0, 1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][4], rubikRotate[rOriz][2],  -0.081000, 0, 1.729-0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][5], rubikRotate[rOriz][2],  -2.821000, 0, 1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][6], rubikRotate[rOriz][2], -2.821000, -2.9, 1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][7], rubikRotate[rOriz][2],  -0.081000, -2.9, 1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rUp][8], rubikRotate[rOriz][2],  2.688999, -2.9, 1.729+0.001, 0, 90, 0);

			AttachObjectToObject(rubikObject[rDown][0], rubikRotate[rOriz][0], -2.821000, 2.9, -1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][1], rubikRotate[rOriz][0],  -0.081000, 2.9, -1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][2], rubikRotate[rOriz][0],  2.688999, 2.9, -1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][3], rubikRotate[rOriz][0], 2.688999, 0, -1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][4], rubikRotate[rOriz][0],  -0.081000, 0, -1.729-0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][5], rubikRotate[rOriz][0],  -2.821000, 0, -1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][6], rubikRotate[rOriz][0], -2.821000, -2.9, -1.729+0.001, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][7], rubikRotate[rOriz][0],  -0.081000, -2.9, -1.729, 0, 90, 0);
			AttachObjectToObject(rubikObject[rDown][8], rubikRotate[rOriz][0],  2.688999, -2.9, -1.729+0.001, 0, 90, 0);

            		AttachObjectToObject(rubikObject[rRight][0], rubikRotate[rOriz][2],  4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][1], rubikRotate[rOriz][2],  4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][2], rubikRotate[rOriz][2],  4.509, 2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][3], rubikRotate[rOriz][1],  4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][4], rubikRotate[rOriz][1],  4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][5], rubikRotate[rOriz][1],  4.509, 2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][6], rubikRotate[rOriz][0],  4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][7], rubikRotate[rOriz][0],  4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rRight][8], rubikRotate[rOriz][0],  4.509, 2.9, 0, 0, 0, 0);

            		AttachObjectToObject(rubikObject[rBehind][0], rubikRotate[rOriz][2], -2.9, -4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][1], rubikRotate[rOriz][2],    0,   -4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][2], rubikRotate[rOriz][2],  2.9, -4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][3], rubikRotate[rOriz][1], -2.9, -4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][4], rubikRotate[rOriz][1],    0,   -4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][5], rubikRotate[rOriz][1],  2.9, -4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][6], rubikRotate[rOriz][0], -2.9, -4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][7], rubikRotate[rOriz][0],    0,   -4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rBehind][8], rubikRotate[rOriz][0],  2.9, -4.509, 0, 0, 0, 90);

			AttachObjectToObject(rubikObject[rFront][0], rubikRotate[rOriz][2], -2.9, 4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][1], rubikRotate[rOriz][2],    0,    4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][2], rubikRotate[rOriz][2],  2.9, 4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][3], rubikRotate[rOriz][1], -2.9, 4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][4], rubikRotate[rOriz][1],    0,    4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][5], rubikRotate[rOriz][1],  2.9, 4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][6], rubikRotate[rOriz][0], -2.9, 4.509, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][7], rubikRotate[rOriz][0],    0,    4.5, 0, 0, 0, 90);
			AttachObjectToObject(rubikObject[rFront][8], rubikRotate[rOriz][0],  2.9, 4.509, 0, 0, 0, 90);

            		AttachObjectToObject(rubikObject[rLeft][0], rubikRotate[rOriz][2], -4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][1], rubikRotate[rOriz][2],  -4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][2], rubikRotate[rOriz][2],  -4.509, 2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][3], rubikRotate[rOriz][1], -4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][4], rubikRotate[rOriz][1],  -4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][5], rubikRotate[rOriz][1],  -4.509, 2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][6], rubikRotate[rOriz][0], -4.509, -2.9, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][7], rubikRotate[rOriz][0],  -4.5, 0, 0, 0, 0, 0);
			AttachObjectToObject(rubikObject[rLeft][8], rubikRotate[rOriz][0],  -4.509, 2.9, 0, 0, 0, 0);
	    }
	    case rVert:
	    {
	        //Missing feature
	    }
	    case rLate:
	    {
	        //Missing feature
	    }
	}
}

public OnFilterScriptInit()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a

	//Internal Parts
	//rOriz

	rubikRotate[rOriz][0] = CreateObject(3095, 0, 0, HEIGHT_1, 0, 0, 0);
	rubikRotate[rOriz][1] = CreateObject(3095, 0, 0, HEIGHT_2, 0, 0, 0);
	rubikRotate[rOriz][2] = CreateObject(3095, 0, 0, HEIGHT_3, 0, 0, 0);
	SetInvisibleTexture(rubikRotate[rOriz][0], 0);
	SetInvisibleTexture(rubikRotate[rOriz][1], 0);
	SetInvisibleTexture(rubikRotate[rOriz][2], 0);
	SetInvisibleTexture(rubikRotate[rOriz][0], 1);
	SetInvisibleTexture(rubikRotate[rOriz][1], 1);
	SetInvisibleTexture(rubikRotate[rOriz][2], 1);
	
	//rVert
	
	rubikRotate[rVert][0] = CreateObject(3095, -2.7, 0, HEIGHT_2, 0, 90, 0);
	rubikRotate[rVert][1] = CreateObject(3095, 0, 0, HEIGHT_2, 0, 90, 0);
	rubikRotate[rVert][2] = CreateObject(3095, 2.7, 0, HEIGHT_2, 0, 90, 0);
	SetInvisibleTexture(rubikRotate[rVert][0], 0);
	SetInvisibleTexture(rubikRotate[rVert][1], 0);
	SetInvisibleTexture(rubikRotate[rVert][2], 0);
	SetInvisibleTexture(rubikRotate[rVert][0], 1);
	SetInvisibleTexture(rubikRotate[rVert][1], 1);
	SetInvisibleTexture(rubikRotate[rVert][2], 1);

	//rLate

	rubikRotate[rLate][0] = CreateObject(3095, 0, 0, HEIGHT_2, 0, 90, 90);
	rubikRotate[rLate][1] = CreateObject(3095, 0, 2.7, HEIGHT_2, 0, 90, 90);
	rubikRotate[rLate][2] = CreateObject(3095, 0, -2.7, HEIGHT_2, 0, 90, 90);
    	SetInvisibleTexture(rubikRotate[rLate][0], 0);
	SetInvisibleTexture(rubikRotate[rLate][1], 0);
	SetInvisibleTexture(rubikRotate[rLate][2], 0);
	SetInvisibleTexture(rubikRotate[rLate][0], 1);
	SetInvisibleTexture(rubikRotate[rLate][1], 1);
	SetInvisibleTexture(rubikRotate[rLate][2], 1);
	
	//Faces
	//rUp

	rubikObject[rUp][0] = CreateObject(19355, -2.821000, 2.9, HEIGHT_UP+0.001, 0.000000, 90.000000, 0.000000);
    	rubikObject[rUp][1] = CreateObject(19355, -0.081000, 2.9, HEIGHT_UP, 0.000000, 90.000000, 0.000000);
    	rubikObject[rUp][2] = CreateObject(19355, 2.688999, 2.9, HEIGHT_UP+0.001, 0, 90, 0);
	
    	rubikObject[rUp][3] = CreateObject(19355, 2.688999, 0, HEIGHT_UP, 0, 90, 0);
    	rubikObject[rUp][4] = CreateObject(19355, -0.081000, 0, HEIGHT_UP-0.001, 0.000000, 90.000000, 0.000000);
    	rubikObject[rUp][5] = CreateObject(19355, -2.821000, 0, HEIGHT_UP, 0.000000, 90.000000, 0.000000);

	rubikObject[rUp][6] = CreateObject(19355, -2.821000, -2.9, HEIGHT_UP+0.001, 0.000000, 90.000000, 0.000000);
	rubikObject[rUp][7] = CreateObject(19355, -0.081000, -2.9, HEIGHT_UP, 0.000000, 90.000000, 0.000000);
	rubikObject[rUp][8] = CreateObject(19355, 2.688999, -2.9, HEIGHT_UP+0.001, 0, 90, 0);

	//rDown
	
	rubikObject[rDown][0] = CreateObject(19355, -2.821000, 2.9, HEIGHT_DOWN+0.001, 0.000000, 90.000000, 0.000000);
    	rubikObject[rDown][1] = CreateObject(19355, -0.081000, 2.9, HEIGHT_DOWN, 0.000000, 90.000000, 0.000000);
    	rubikObject[rDown][2] = CreateObject(19355, 2.688999, 2.9, HEIGHT_DOWN+0.001, 0, 90, 0);

    	rubikObject[rDown][3] = CreateObject(19355, 2.688999, 0, HEIGHT_DOWN, 0, 90, 0);
   	rubikObject[rDown][4] = CreateObject(19355, -0.081000, 0, HEIGHT_DOWN-0.001, 0.000000, 90.000000, 0.000000);
    	rubikObject[rDown][5] = CreateObject(19355, -2.821000, 0, HEIGHT_DOWN, 0.000000, 90.000000, 0.000000);
	
	rubikObject[rDown][6] = CreateObject(19355, -2.821000, -2.9, HEIGHT_DOWN+0.001, 0.000000, 90.000000, 0.000000);
	rubikObject[rDown][7] = CreateObject(19355, -0.081000, -2.9, HEIGHT_DOWN, 0.000000, 90.000000, 0.000000);
	rubikObject[rDown][8] = CreateObject(19355, 2.688999, -2.9, HEIGHT_DOWN+0.001, 0, 90, 0);

	//rRight

	rubikObject[rRight][0] = CreateObject(19355, 4.509, -2.9, HEIGHT_3, 0, 0, 0);
	rubikObject[rRight][1] = CreateObject(19355, 4.5, 0, HEIGHT_3, 0, 0, 0);
	rubikObject[rRight][2] = CreateObject(19355, 4.509, 2.9, HEIGHT_3, 0, 0, 0);
	
    	rubikObject[rRight][3] = CreateObject(19355, 4.509, -2.9, HEIGHT_2, 0, 0, 0);
	rubikObject[rRight][4] = CreateObject(19355, 4.5, 0, HEIGHT_2, 0, 0, 0);
	rubikObject[rRight][5] = CreateObject(19355, 4.509, 2.9, HEIGHT_2, 0, 0, 0);
	
	rubikObject[rRight][6] = CreateObject(19355, 4.509, -2.9, HEIGHT_1, 0, 0, 0);
	rubikObject[rRight][7] = CreateObject(19355, 4.5, 0, HEIGHT_1, 0, 0, 0);
	rubikObject[rRight][8] = CreateObject(19355, 4.509, 2.9, HEIGHT_1, 0, 0, 0);
	
	//rLeft

	rubikObject[rLeft][0] = CreateObject(19355, -4.509, -2.9, HEIGHT_3, 0, 0, 0);
	rubikObject[rLeft][1] = CreateObject(19355, -4.5, 0, HEIGHT_3, 0, 0, 0);
	rubikObject[rLeft][2] = CreateObject(19355, -4.509, 2.9, HEIGHT_3, 0, 0, 0);

	rubikObject[rLeft][3] = CreateObject(19355, -4.509, -2.9, HEIGHT_2, 0, 0, 0);
	rubikObject[rLeft][4] = CreateObject(19355, -4.5, 0, HEIGHT_2, 0, 0, 0);
	rubikObject[rLeft][5] = CreateObject(19355, -4.509, 2.9, HEIGHT_2, 0, 0, 0);
	
	rubikObject[rLeft][6] = CreateObject(19355, -4.509, -2.9, HEIGHT_1, 0, 0, 0);
	rubikObject[rLeft][7] = CreateObject(19355, -4.5, 0, HEIGHT_1, 0, 0, 0);
	rubikObject[rLeft][8] = CreateObject(19355, -4.509, 2.9, HEIGHT_1, 0, 0, 0);

	//rFront

	rubikObject[rFront][0] = CreateObject(19355, -2.9, 4.509, HEIGHT_3, 0, 0, 90);
	rubikObject[rFront][1] = CreateObject(19355, 0,    4.5, HEIGHT_3, 0, 0, 90);
	rubikObject[rFront][2] = CreateObject(19355,  2.9, 4.509, HEIGHT_3, 0, 0, 90);
	
	rubikObject[rFront][3] = CreateObject(19355, -2.9, 4.509, HEIGHT_2, 0, 0, 90);
	rubikObject[rFront][4] = CreateObject(19355, 0,    4.5, HEIGHT_2, 0, 0, 90);
	rubikObject[rFront][5] = CreateObject(19355,  2.9, 4.509, HEIGHT_2, 0, 0, 90);
	
	rubikObject[rFront][6] = CreateObject(19355, -2.9, 4.509, HEIGHT_1, 0, 0, 90);
	rubikObject[rFront][7] = CreateObject(19355, 0,    4.5, HEIGHT_1, 0, 0, 90);
	rubikObject[rFront][8] = CreateObject(19355,  2.9, 4.509, HEIGHT_1, 0, 0, 90);

	//rBehind

	rubikObject[rBehind][0] = CreateObject(19355, -2.9, -4.509, HEIGHT_3, 0, 0, 90);
	rubikObject[rBehind][1] = CreateObject(19355, 0,    -4.5, HEIGHT_3, 0, 0, 90);
	rubikObject[rBehind][2] = CreateObject(19355,  2.9, -4.509, HEIGHT_3, 0, 0, 90);
	
	rubikObject[rBehind][3] = CreateObject(19355, -2.9, -4.509, HEIGHT_2, 0, 0, 90);
	rubikObject[rBehind][4] = CreateObject(19355, 0,    -4.5, HEIGHT_2, 0, 0, 90);
	rubikObject[rBehind][5] = CreateObject(19355,  2.9, -4.509, HEIGHT_2, 0, 0, 90);
	
	rubikObject[rBehind][6] = CreateObject(19355, -2.9, -4.509, HEIGHT_1, 0, 0, 90);
	rubikObject[rBehind][7] = CreateObject(19355, 0,    -4.5, HEIGHT_1, 0, 0, 90);
	rubikObject[rBehind][8] = CreateObject(19355,  2.9, -4.509, HEIGHT_1, 0, 0, 90);

	//Init

    	AttachObjectsForRotation(rOriz);
    	RandomizeCube();

	return 1;
}

stock RandomizeCube()
{
    static const rubikHex[6] = {
        0xFFFF0000, //Red
        0xFF00FF00, //Blue
        0xFF0000FF, //Green
        0xFFFFFF00, //Yellow
        0xFFFFA500, //Orange
        0xFFFFFFFF, //White
    };
    new canAssign[6] = { 9, ... };

    for(new i, j, rnd; i < 6; i++)
    {
        for(j = 0; j < 9; j++)
        {
			rnd = random(6);
            if(canAssign[rnd])
            {
                canAssign[rnd]--;
                rubikColour[i][j] = rubikHex[rnd];
                SetObjectColour(rubikObject[i][j], 0, rubikColour[i][j]);
            }
            else j--;
        }
    }
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_YES)
	{
	    selectedRow++;
	    if(selectedRow > 2)
	    {
	        selectedRow = 0;
	    }
	}
	else if(newkeys & KEY_NO)
	{
	    selectedRow--;
	    if(selectedRow < 0)
	    {
	        selectedRow = 2;
	    }
	}
	else if(newkeys & KEY_ANALOG_RIGHT)
	{
	    rOriz_RotateRight();
	}
	else if(newkeys & KEY_ANALOG_LEFT)
	{
	    rOriz_RotateLeft();
	}
	return 1;
}

//

stock rOriz_RotateRight()
{
	new Float:gHeights[3];
	gHeights[0] = HEIGHT_1;
	gHeights[1] = HEIGHT_2;
	gHeights[2] = HEIGHT_3;
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rOriz][selectedRow], temp, temp, rot);
	rubikRotateStep[rOriz][selectedRow] = !(rubikRotateStep[rOriz][selectedRow]);
    	MoveObject(rubikRotate[rOriz][selectedRow], 0, 0, gHeights[selectedRow] + 0.001*(-1 * rubikRotateStep[rOriz][selectedRow]), 0.0006, 0, 0, rot-90);
}

stock rOriz_RotateLeft()
{
    new Float:gHeights[3];
	gHeights[0] = HEIGHT_1;
	gHeights[1] = HEIGHT_2;
	gHeights[2] = HEIGHT_3;
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rOriz][selectedRow], temp, temp, rot);
	rubikRotateStep[rOriz][selectedRow] = !(rubikRotateStep[rOriz][selectedRow]);
    	MoveObject(rubikRotate[rOriz][selectedRow], 0, 0, gHeights[selectedRow] + 0.001*(-1 * rubikRotateStep[rOriz][selectedRow]), 0.0006, 0, 0, rot+90);
}

//

stock rVert_RotateRight()
{
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rVert][selectedRow], rot, temp, temp);
	rubikRotateStep[rVert][0] = !(rubikRotateStep[rVert][0]);
   	MoveObject(rubikRotate[rVert][selectedRow], 0, 0, HEIGHT_2 + 0.001*(-1 * rubikRotateStep[rVert][selectedRow]), 0.0006, rot+90, 90, 0);
}

stock rVert_RotateLeft()
{
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rVert][selectedRow], rot, temp, temp);
	rubikRotateStep[rVert][selectedRow] = !(rubikRotateStep[rVert][selectedRow]);
    	MoveObject(rubikRotate[rVert][selectedRow], 0, 0, HEIGHT_2 + 0.001*(-1 * rubikRotateStep[rVert][selectedRow]), 0.0006, rot-90, 90, 0);
}

//

stock rLate_RotateRight()
{
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rLate][selectedRow], temp, rot, temp);
	rubikRotateStep[rLate][0] = !(rubikRotateStep[rLate][0]);
    	MoveObject(rubikRotate[rLate][selectedRow], 0, 0, HEIGHT_2 + 0.001*(-1 * rubikRotateStep[rLate][selectedRow]), 0.0006, 0, rot+90, 90);
}

stock rLate_RotateLeft()
{
    	new Float:temp, Float:rot;
	GetObjectRot(rubikRotate[rLate][selectedRow], temp, rot, temp);
	rubikRotateStep[rLate][selectedRow] = !(rubikRotateStep[rLate][selectedRow]);
    	MoveObject(rubikRotate[rLate][selectedRow], 0, 0, HEIGHT_2 + 0.001*(-1 * rubikRotateStep[rLate][selectedRow]), 0.0006, 0, rot-90, 90);
}

//

public OnFilterScriptExit()
{
    for(new i, j; i < 6; i++)
        for(j = 0; j < 9; j++)
            DestroyObject(rubikObject[i][j]);
            
    for(new i, j; i < 3; i++)
        for(j = 0; j < 3; j++)
            DestroyObject(rubikRotate[i][j]);

	return 1;
}