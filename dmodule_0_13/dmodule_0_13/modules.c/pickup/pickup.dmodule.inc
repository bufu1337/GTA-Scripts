native AddStaticPickup(model,type,Float:X,Float:Y,Float:Z);
native CreatePickup(model, type, Float:X, Float:Y, Float:Z);
native DestroyPickup(pickup);
forward OnPlayerPickUpPickup(playerid, pickupid);
public OnPlayerPickUpPickup(playerid, pickupid) _PickUpPickup(playerid, pickupid);
