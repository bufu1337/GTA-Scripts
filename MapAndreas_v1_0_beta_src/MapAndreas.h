//----------------------------------------------------------
//
//   SA-MP Multiplayer Modification For GTA:SA
//   Copyright 2004-2009 SA-MP Team
//
//----------------------------------------------------------

#define MAP_ANDREAS_MODE_NONE			0
#define MAP_ANDREAS_MODE_MINIMAL		1 // for future use
#define MAP_ANDREAS_MODE_FULL			2

#define MAP_ANDREAS_MAP_SIZE			(6000*6000)
#define MAP_ANDREAS_POINTS_FULL			MAP_ANDREAS_MAP_SIZE
#define MAP_ANDREAS_POINTS_MINIMAL		(MAP_ANDREAS_MAP_SIZE / 9)

#define MAP_ANDREAS_HMAP_FILE_FULL		"scriptfiles/SAfull.hmap"
#define MAP_ANDREAS_HMAP_FILE_MINIMAL	"scriptfiles/SAmin.hmap"

#define MAP_ANDREAS_ERROR_SUCCESS		0
#define MAP_ANDREAS_ERROR_FAILURE		1
#define MAP_ANDREAS_ERROR_MEMORY		2
#define MAP_ANDREAS_ERROR_DATA_FILES	3

//----------------------------------------------------------

class CMapAndreas
{
private:
	int	m_iOperatingMode;
	unsigned short *m_pPointData;

public:
	CMapAndreas();
	~CMapAndreas();

	int		Init(int iMode);
	float	FindZ_For2DCoord(float X, float Y);
};


//----------------------------------------------------------