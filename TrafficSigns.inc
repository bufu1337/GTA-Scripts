/*
 *        				'aTraffic.inc'
 *                                                                       LIMITED VERSION!
 * Traffic  Signs
 * Include made by adri1
 * Do not remove credits
 *
 * Streamer version
 * ** Include exclusive for eXtreme Role Play **
 *
 * Functions:
    CreateTrafficSign_Stop(Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_Yield(Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_Prohibited(Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_Prohibited2(Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_CrossWalk(Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_MaxVelocity(max[], Float:x, Float:y, Float:z, Float:rz)
    CreateTrafficSign_MinVelocity(min[], Float:x, Float:y, Float:z, Float:rz)
 *
 * Callbacks
    None...
 */

stock CreateTrafficSign_Stop(Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, rx, ry, rz);
	SetDynamicObjectMaterial(trafficsign_id, 0, 967, "cj_barr_set_1", "Stop2_64");
	SetDynamicObjectMaterial(trafficsign_id, 1, 967, "cj_barr_set_1", "Stop2_64", 0xFFCCCCCC);
	return trafficsign_id;
}

stock CreateTrafficSign_Yield(Float:x, Float:y, Float:z, Float:rz)
{
    new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0, 0, rz);
    new Float:p[9];
    aTraffic_Position(trafficsign_id, -0.525, -0.05, 0.95, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, -0.5215, -0.055, 0.98, p[3], p[4], p[5]);
    aTraffic_Position(trafficsign_id, -0.525, -0.025, 0.95, p[6], p[7], p[8]);
    
    CreateDynamicObject(2986, p[0], p[1], p[2], -90.0000, 90.0000, rz-90);
    CreateDynamicObject(2986, p[3], p[4], p[5], -90.0000, 90.0000, rz-90);
    CreateDynamicObject(2986, p[6], p[7], p[8], -90.0000, 90.0000, rz-90);
    SetDynamicObjectMaterial(trafficsign_id, 0, 0, "null", "null");
    SetDynamicObjectMaterial(trafficsign_id, 1, 0, "null", "null");
	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "5", 50, "Webdings", 100, 0, -65536, 0, 1);
	SetDynamicObjectMaterialText(trafficsign_id+2, 0, "5", 50, "Webdings", 70, 0, 0xFFFFFFFF, 0, 1);
	SetDynamicObjectMaterialText(trafficsign_id+3, 0, "5", 50, "Webdings", 100, 0, 0xFFCCCCCC, 0, 1);
	return trafficsign_id;
}

stock CreateTrafficSign_Prohibited(Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0.0, 0.0, rz);
    new Float:p[6];
    aTraffic_Position(trafficsign_id, -0.03, -0.03, 0.45, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, 0.48, -0.055, 0.835, p[3], p[4], p[5]);

	CreateDynamicObject(2986, p[0], p[1], p[2], 0.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[3], p[4], p[5], -90.0000, -90.0000, rz-90);
 	SetDynamicObjectMaterial(trafficsign_id, 0, 0, "null", "null");
 	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "l", 60, "Wingdings", 120, 0, -65536, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+2, 0, "-", 60, "Arial", 200, 0, -1, 0, 1);
	return trafficsign_id;
}

stock CreateTrafficSign_Prohibited2(Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0.0, 0.0, rz);
	new Float:p[9];
    aTraffic_Position(trafficsign_id, -0.03, -0.03, 0.45, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, -0.025, -0.04, 0.455, p[3], p[4], p[5]);
    aTraffic_Position(trafficsign_id, 0.45, -0.045, 1.15, p[6], p[7], p[8]);
    
	CreateDynamicObject(2986, p[0], p[1], p[2], 0.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[3], p[4], p[5], 0.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[6], p[7], p[8], 115.5, 90.0000, rz-90);
 	SetDynamicObjectMaterial(trafficsign_id, 0, 0, "null", "null");
 	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "l", 60, "Wingdings", 120, 0, -65536, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+2, 0, "l", 60, "Wingdings", 90, 0, 0xFFFFFFFF, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+3, 0, "\\", 60, "Arial", 95, 1, -65536, 0, 1);
	return trafficsign_id;
}

stock CreateTrafficSign_CrossWalk(Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0.0, 0.0, rz);
	new Float:p[9];
    aTraffic_Position(trafficsign_id, -0.52, -0.04, 0.9, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, -0.49, -0.06, 0.835, p[3], p[4], p[5]);
    aTraffic_Position(trafficsign_id, -0.5, -0.06, 0.95, p[6], p[7], p[8]);
	
	CreateDynamicObject(2986, p[0], p[1], p[2], -90.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[3], p[4], p[5], -90.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[6], p[7], p[8], 90.0000, -90.0000, rz-90);
 	SetDynamicObjectMaterial(trafficsign_id, 0, 18646, "matcolours", "lightblue", 0xFF00CCFF);
 	SetDynamicObjectMaterial(trafficsign_id, 1, 18646, "matcolours", "grey");
 	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "6", 50, "Webdings", 90, 0, 0xFFFFFFFF, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+2, 0, "||||||||", 60, "Arial", 20, 1, -16777216, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+3, 0, "m", 60, "Webdings", 45, 0, -16777216, 0, 1);
	return trafficsign_id;
}

stock CreateTrafficSign_MaxVelocity(max[], Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0.0, 0.0, rz);
	new Float:p[9];
    aTraffic_Position(trafficsign_id, -0.03, -0.05, 0.45, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, -0.025, -0.055, 0.455, p[3], p[4], p[5]);
    aTraffic_Position(trafficsign_id, 0.48, -0.065, 0.95, p[6], p[7], p[8]);
    
	CreateDynamicObject(2986, p[0], p[1], p[2], 0.0000, 90.0000, rz-90);
	CreateDynamicObject(2986, p[3], p[4], p[5], 0.0000, 90.0000, rz-90);
 	CreateDynamicObject(2986, p[6], p[7], p[8], 90.0000, 90.0000, rz-90);
 	SetDynamicObjectMaterial(trafficsign_id, 0, 0, "null", "null");
 	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "l", 60, "Wingdings", 120, 0, -65536, 0, 1);
 	SetDynamicObjectMaterialText(trafficsign_id+2, 0, "l", 60, "Wingdings", 90, 0, 0xFFFFFFFF, 0, 1);
  	SetDynamicObjectMaterialText(trafficsign_id+3, 0, max, 60, "Arial", 30, 1, 0xFF000000, 0, 1);
	return trafficsign_id;
}

stock CreateTrafficSign_MinVelocity(min[], Float:x, Float:y, Float:z, Float:rz)
{
	new trafficsign_id = CreateDynamicObject(8548, x, y, z, 0.0, 0.0, rz);
	new Float:p[6];
    aTraffic_Position(trafficsign_id, -0.03, -0.05, 0.45, p[0], p[1], p[2]);
    aTraffic_Position(trafficsign_id, 0.5, -0.06, 0.95, p[3], p[4], p[5]);
    
	CreateDynamicObject(2986, p[0], p[1], p[2], 0, 90, rz-90);
 	CreateDynamicObject(2986, p[3], p[4], p[5], 90, 90, rz-90);
 	SetDynamicObjectMaterial(trafficsign_id, 0, 0, "null", "null");
 	SetDynamicObjectMaterialText(trafficsign_id+1, 0, "l", 60, "Wingdings", 120, 0, 0xFF00CCFF, 0, 1);
  	SetDynamicObjectMaterialText(trafficsign_id+2, 0, min, 60, "Arial", 30, 1, 0xFFFFFFFF, 0, 1);
	return trafficsign_id;
}


stock aTraffic_Position(objectid, Float:offset_x, Float:offset_y, Float:offset_z, &Float:x, &Float:y, &Float:z)
{
    new Float:object_px,
        Float:object_py,
        Float:object_pz,
        Float:object_rx,
        Float:object_ry,
        Float:object_rz;
    GetDynamicObjectPos(objectid, object_px, object_py, object_pz);
    GetDynamicObjectRot(objectid, object_rx, object_ry, object_rz);
    new Float:cos_x = floatcos(object_rx, degrees),
        Float:cos_y = floatcos(object_ry, degrees),
        Float:cos_z = floatcos(object_rz, degrees),
        Float:sin_x = floatsin(object_rx, degrees),
        Float:sin_y = floatsin(object_ry, degrees),
        Float:sin_z = floatsin(object_rz, degrees);
    x = object_px + offset_x * cos_y * cos_z - offset_x * sin_x * sin_y * sin_z - offset_y * cos_x * sin_z + offset_z * sin_y * cos_z + offset_z * sin_x * cos_y * sin_z;
    y = object_py + offset_x * cos_y * sin_z + offset_x * sin_x * sin_y * cos_z + offset_y * cos_x * cos_z + offset_z * sin_y * sin_z - offset_z * sin_x * cos_y * cos_z;
    z = object_pz - offset_x * cos_x * sin_y + offset_y * sin_x + offset_z * cos_x * cos_y;
}

