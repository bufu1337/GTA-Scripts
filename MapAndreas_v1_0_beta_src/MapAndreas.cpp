//----------------------------------------------------------
//
//   SA-MP Multiplayer Modification For GTA:SA
//   Copyright 2004-2010 SA-MP Team
//
//   Author: Kye 10 Jan 2010
//
//----------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>

#include "MapAndreas.h"

//----------------------------------------------------------

CMapAndreas::CMapAndreas()
{
	m_iOperatingMode = MAP_ANDREAS_MODE_NONE;
	m_pPointData = NULL;
}

//----------------------------------------------------------

CMapAndreas::~CMapAndreas()
{
	m_iOperatingMode = MAP_ANDREAS_MODE_NONE;
    if(m_pPointData) free(m_pPointData);
	m_pPointData = NULL;
}

//----------------------------------------------------------

int CMapAndreas::Init(int iMode)
{
	// check if already inited
	if(m_iOperatingMode != MAP_ANDREAS_MODE_NONE) 
		return MAP_ANDREAS_ERROR_SUCCESS;

	if(iMode == MAP_ANDREAS_MODE_FULL)
	{
        // allocate the memory we need
		m_pPointData = (unsigned short *)calloc(MAP_ANDREAS_POINTS_FULL,sizeof(unsigned short));
		if(NULL == m_pPointData) return MAP_ANDREAS_ERROR_MEMORY;

		//printf("MapAndreas: allocated %u bytes of memory\n",MAP_ANDREAS_POINTS_FULL*sizeof(unsigned short));
		
		// load the file contents in to our point data buffer
		FILE *fileInput = fopen(MAP_ANDREAS_HMAP_FILE_FULL,"rb");
		if(NULL == fileInput) return MAP_ANDREAS_ERROR_DATA_FILES;
		
		for(int x=0;x<MAP_ANDREAS_POINTS_FULL;x++) {
            fread(&m_pPointData[x],1,sizeof(unsigned short),fileInput);
		}

		fclose(fileInput);

		//printf("MapAndreas: file %s read in to memory\n",MAP_ANDREAS_HMAP_FILE_FULL);

        m_iOperatingMode = MAP_ANDREAS_MODE_FULL;
		return MAP_ANDREAS_ERROR_SUCCESS;
	}
	
	return MAP_ANDREAS_ERROR_FAILURE;
}

//----------------------------------------------------------

float CMapAndreas::FindZ_For2DCoord(float X, float Y)
{
	// check for a co-ord outside the map
	if(X < -3000.0f || X > 3000.0f || Y > 3000.0f || Y < -3000.0f) return 0.0f;

	// get row/col on 6000x6000 grid
	int iGridX = ((int)X) + 3000;
	int iGridY = (((int)Y) - 3000) * -1;
	int iDataPos;
   
	if(m_iOperatingMode == MAP_ANDREAS_MODE_FULL)
	{
		iDataPos = (iGridY * 6000) + iGridX; // for every Y, increment by the number of cols, add the col index.
		return (float)m_pPointData[iDataPos] / 100.0f; // the data is a float stored as ushort * 100
	}

	return 0.0f;
}

//----------------------------------------------------------