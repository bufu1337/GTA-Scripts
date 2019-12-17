//-------------------------------------------------------------------------------
stock FindTag(name[],tag[]) //by Pixels^
{
    if(strfind(name, tag, true) == 0) return 1;
    else return 0;
}
native FindTag(name[],tag[]);
//-------------------------------------------------------------------------------
stock ToggleBlipVisibilty(playerid, bool:visible) //by Simon
{
    new tmpcolor = GetPlayerColor(playerid);
	if(visible == true) tmpcolor &= 0xFFFFFF00;
	else tmpcolor |= 0x000000FF;
	SetPlayerColor(playerid, tmpcolor);
}
native ToggleBlipVisibilty(playerid, bool:visible);
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
stock IsPlayerPassenger(playerid) //By Sacky (Edited by Smugller)
{
 if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
 {
  return 1;
 }
 return 0;
}
native IsPlayerPassenger(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerOnBike(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 448:return 1;
   case 461:return 1;
   case 462:return 1;
   case 463:return 1;
   case 468:return 1;
   case 521:return 1;
   case 522:return 1;
   case 523:return 1;
   case 581:return 1;
   case 586:return 1;
  }
 }
 return 0;
}
native IsPlayerOnBike(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerOnBicycle(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 481:return 1;
   case 509:return 1;
   case 510:return 1;
  }
 }
 return 0;
}
native IsPlayerOnBicycle(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerInBoat(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 430:return 1;
   case 446:return 1;
   case 452:return 1;
   case 453:return 1;
   case 454:return 1;
   case 472:return 1;
   case 473:return 1;
   case 484:return 1;
   case 493:return 1;
   case 595:return 1;
  }
 }
 return 0;
}
native IsPlayerInBoat(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerInHelicopter(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 417:return 1;
   case 425:return 1;
   case 447:return 1;
   case 465:return 1;
   case 469:return 1;
   case 487:return 1;
   case 488:return 1;
   case 497:return 1;
   case 501:return 1;
   case 548:return 1;
   case 563:return 1;
  }
 }
 return 0;
}
native IsPlayerInHelicopter(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerInMonsterTruck(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 406:return 1;
   case 444:return 1;
   case 556:return 1;
   case 557:return 1;
   case 573:return 1;
  }
 }
 return 0;
}
native IsPlayerInMonsterTruck(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerInPlane(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 460:return 1;
   case 464:return 1;
   case 476:return 1;
   case 511:return 1;
   case 512:return 1;
   case 513:return 1;
   case 519:return 1;
   case 520:return 1;
   case 539:return 1;
   case 553:return 1;
   case 577:return 1;
   case 592:return 1;
   case 593:return 1;
  }
 }
 return 0;
}
native IsPlayerInPlane(playerid);
//-------------------------------------------------------------------------------
stock IsPlayerInQuad(playerid) //By Sacky (Edited by Smugller)
{
 if(IsPlayerInAnyVehicle(playerid))
 {
  new vehicleclass = GetVehicleModel(GetPlayerVehicleID(playerid));
  switch(vehicleclass)
  {
   case 471:return 1;
  }
 }
 return 0;
}
native IsPlayerInQuad(playerid);
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------