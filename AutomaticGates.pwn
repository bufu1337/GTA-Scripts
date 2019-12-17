//Gate Locations by Splitx
//Gates Made Automatic by MoNeYPiMp -=Moneypimp2@hotmail.com=-
new pdgateLS;
new pdngateLS;
new pdgateLV;
new pdngateLV;
new pdngate2LV;
new pdgateSF;
new pdngateSF;
new HasPGP[MAX_PLAYERS];

public OnGameModeInit()
{
        pdgateLS = CreateObject(976, 1549.284668, -1626.937744, 12.544723, 0.0000, 0.0000, 90.0000);
        pdngateLS = CreateObject(976, 1549.304565, -1636.401001, 12.544723, 0.0000, 0.0000, 90.0000);
        pdgateLV = CreateObject(969, 2237.188965, 2448.813232, 9.845795, 0.0000, 0.0000, 90.0000);
        pdngateLV = CreateObject(976, 2320.069092, 2449.282471, 2.435347, 0.0000, 0.0000, 270.0000);
        pdngate2LV = CreateObject(976, 2320.052979, 2458.126953, 2.435347, 0.0000, 0.0000, 270.0000);
        pdgateSF =  CreateObject(969, -1701.770020, 679.915344, 24.057503, 0.0000, 0.0000, 90.0000);
        CreateObject(969, -1700.105591, 688.051575, 24.057503, 0.0000, 0.0000, 0.0000);
        pdngateSF = CreateObject(969, -1571.713013, 665.608154, 6.336499, 0.0000, 0.0000, 270.0000);

        SetTimer("NearGatesf", 500, true);
        SetTimer("NearGatesfn", 500, true);
        SetTimer("NearGatelv", 500, true);
        SetTimer("NearGatelvn", 500, true);
        SetTimer("NearGatelv2", 500, true);
        SetTimer("NearGatels", 500, true);
        SetTimer("NearGatelsn", 500, true);
        return 1;
}

public OnPlayerSpawn(playerid)
{
        if(IsPlayerAdmin(playerid) >0) {
                HasPGP[playerid] = 1;
        }
        if(gTeam(playerid) = TEAM_COP) {
                HasPGP[playerid] = 1;
        }
        //for each class that can open the gate simply add "HasPGP[playerid] = 1;" without the quotes
        return 1;
}
//===============================Auto Gate Stuff================================
forward NearGatels();
forward NearGatelsn();
forward NearGatelv();
forward NearGatelvn();
forward NearGatelv2();
forward NearGatesf();
forward NearGatesfn();
forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);

public NearGatels()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, 1549.284668, -1626.937744, 12.544723) && HasPGP[i] == 1)
                        {
                                MoveObject(pdgateLS, 1549.270508, -1617.565308, 12.544723, 3.5);
                        }else{
                                MoveObject(pdgateLS, 1549.284668, -1626.937744, 12.544723, 3.5);
                        }
                }
        }
}
public NearGatelsn()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, 1549.304565, -1636.401001, 12.544723) && HasPGP[i] == 1)
                        {
                                MoveObject(pdngateLS, 1549.314697, -1645.918091, 12.517562, 3.5);
                        }else{
                                MoveObject(pdngateLS, 1549.304565, -1636.401001, 12.544723, 3.5);
                        }
                }
        }
}
public NearGatelv()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, 2237.188965, 2448.813232, 9.845795) && HasPGP[i] == 1)
                        {
                        MoveObject(pdgateLV, 2237.127930, 2458.059570, 9.840160, 3.5);
                        }else{
                                MoveObject(pdgateLV, 2237.188965, 2448.813232, 9.845795, 3.5);
                        }
                }
        }
}
public NearGatelvn()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, 2320.069092, 2449.282471, 2.435347) && HasPGP[i] == 1)
                        {
                        MoveObject(pdngateLV, 2319.847656, 2461.079102, 2.435347, 3.5);
                        }else{
                                MoveObject(pdngateLV, 2320.069092, 2449.282471, 2.435347, 3.5);
                        }
                }
        }
}
public NearGatelv2()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, 2320.052979, 2458.126953, 2.435347) && HasPGP[i] == 1)
                        {
                                MoveObject(pdngate2LV, 2319.847656, 2461.079102, 2.435347, 3.5);
                        }else{
                                MoveObject(pdngate2LV, 2320.052979, 2458.126953, 2.435347, 3.5);
                        }
                }
        }
}
public NearGatesf()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, -1701.770020, 679.915344, 24.057503) && HasPGP[i] == 1)
                        {
                                MoveObject(pdgateSF, -1701.773193, 670.980530, 24.041584, 3.5);
                        }else{
                                MoveObject(pdgateSF, -1701.770020, 679.915344, 24.057503, 3.5);
                        }
                }
        }
}
public NearGatesfn()
{
        for(new i=0; i<MAX_PLAYERS; i++) {
                if(IsPlayerConnected(i)) {
                        if(PlayerToPoint(10.0, i, -1571.713013, 665.608154, 6.336499) && HasPGP[i] == 1)
                        {
                                MoveObject(pdngateSF, -1571.828735, 656.457214, 6.354377, 3.5);
                        }
                        else {
                                MoveObject(pdngateSF, -1571.713013, 665.608154, 6.336499, 3.5);
                        }
                }
        }
}

public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        tempposx = (oldposx -x);
        tempposy = (oldposy -y);
        tempposz = (oldposz -z);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
        {
                return 1;
        }
        return 0;
}
