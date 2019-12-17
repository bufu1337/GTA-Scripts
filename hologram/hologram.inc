#include <a_samp>

#define MAX_HOLOGRAMS 5
#define MAX_HOLOWH 1024

new Text3D:Holograms[MAX_HOLOGRAMS][MAX_HOLOWH/2];
new Hologram_SlotCount[MAX_HOLOGRAMS];
new Hologram_USlots = 0;

stock CreateHologram( HoloPack[], Float:PosX, Float:PosY, Float:PosZ, Float:DisplacementW = 0.04, Float:DisplacementH = 0.04, Vertical = 1, Horisontal = 0, Float:MaxDrawDistance = 200.0, VirtualWorld = 0, TestLOS = 1 )
{
	new HoloPixel;
	new Float:HX=PosX, Float:HY=PosY, Float:HZ=PosZ;
	for( new HoloID; HoloID<MAX_HOLOWH; HoloID++ )
	{
		HoloPixel = HoloPack[HoloID];
		if( HoloPixel == -1 )
		{
			HX = PosX;
			if( Horisontal ) HY -= DisplacementH;
			if( Vertical ) 	 HZ -= DisplacementH;
		}
		else
		{
			Holograms[Hologram_USlots][HoloID] = Create3DTextLabel( "#", HoloPixel, HX, HY, HZ, MaxDrawDistance, VirtualWorld, TestLOS);
			HX -= DisplacementW;
		}
	}
	Hologram_SlotCount[Hologram_USlots] = MAX_HOLOWH/2;
	Hologram_USlots++;
	return Hologram_USlots-1;
}

stock DeleteHologram( HologramID )
{
	for( new i; i<Hologram_SlotCount[HologramID]; i++ )
	{
		Delete3DTextLabel( Holograms[HologramID][i] );
	}
}

stock DestroyHologram( HologramID )
{
	DeleteHologram( HologramID );
}