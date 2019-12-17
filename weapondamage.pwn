#include <a_samp>
#include <OPSP>

public OnPlayerShootPlayer(Shooter,Target,Float:HealthLost,Float:ArmourLost)
{
    new Float:health, Float:armour;
    GetPlayerHealth(Target,health);
    GetPlayerArmour(Target,armour);
    if(ArmourLost > 0.0) SetPlayerArmour(Target,floatadd(armour,ArmourLost));
    if(HealthLost > 0.0) SetPlayerHealth(Target,floatadd(health,HealthLost));
    new Damage;
    switch(GetPlayerWeapon(Shooter))
    {
            case 24: Damage = 20;//case [weaponid]: Damage = [damage];
        case 31,28: Damage = 25;//Tec9 & Micru-Uzi
        case 29: Damage = 30;
        case 0: Damage = 7;
        case 22: Damage = 25;
                case 23: Damage = 20;
                case 5,3,6,7,2: Damage = 10;
                case 4: Damage = 30;
                case 25: Damage = 60;
                case 30: Damage = 30;
                case 33,34: Damage = 95;
        }

    armour = armour - Damage;
    if(armour < 0.0)
    {
        health += armour;//Health will decrease because armour is negative. (a + (-b) = a - b)
        if(health <= 0.0)
        {
            health = 0.0;
        }
        armour = 0.0;
    }
    SetPlayerHealth(Target, health);
    SetPlayerArmour(Target, armour);
    new msg[128],name1[24],name2[24];
    format(msg,sizeof(msg)," * %s shot %s(Dmg: %f HP and %f Armour)!",name1,name2,HealthLost,ArmourLost);
    SendClientMessage(Target,0xFFFFFFFF,msg);
    SendClientMessage(Shooter,0xFFFFFFFF,msg);
        return 1;
}