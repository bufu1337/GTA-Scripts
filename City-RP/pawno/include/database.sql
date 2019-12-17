/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `bans` (
  `id` int(11) NOT NULL auto_increment,
  `type` tinyint(2) NOT NULL,
  `player` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `amount` bigint(20) NOT NULL default '0',
  `ip` varchar(16) NOT NULL,
  `inactive` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `logins` (
  `id` int(11) NOT NULL auto_increment,
  `time` int(11) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `userid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `players` (
  `id` int(11) NOT NULL auto_increment,
  `Name` varchar(50) collate latin1_general_ci NOT NULL,
  `Password` varchar(50) character set latin1 collate latin1_bin NOT NULL,
  `PlayerLevel` int(11) NOT NULL default '1',
  `AdminLevel` int(11) NOT NULL default '0',
  `DonateRank` int(11) NOT NULL default '0',
  `UpgradePoints` int(11) NOT NULL default '0',
  `ConnectedTime` int(11) NOT NULL default '0',
  `Registered` int(11) NOT NULL default '0',
  `Sex` int(11) NOT NULL default '1',
  `Age` int(11) NOT NULL default '0',
  `Origin` int(11) NOT NULL default '255',
  `CK` int(11) NOT NULL default '0',
  `Muted` int(11) NOT NULL default '0',
  `Respect` int(11) NOT NULL default '0',
  `Money` bigint(20) NOT NULL default '500',
  `Bank` int(11) NOT NULL default '1000',
  `Crimes` int(11) NOT NULL default '0',
  `Kills` int(11) NOT NULL default '0',
  `Deaths` int(11) NOT NULL default '0',
  `Arrested` int(11) NOT NULL default '0',
  `WantedDeaths` int(11) NOT NULL default '0',
  `Phonebook` int(11) NOT NULL default '0',
  `LottoNr` int(11) NOT NULL default '0',
  `Fishes` int(11) NOT NULL default '0',
  `BiggestFish` int(11) NOT NULL default '0',
  `Job` int(11) NOT NULL default '0',
  `Paycheck` int(11) NOT NULL default '0',
  `HeadValue` int(11) NOT NULL default '0',
  `Jailed` int(11) NOT NULL default '0',
  `JailTime` int(11) NOT NULL default '0',
  `Materials` int(11) NOT NULL default '0',
  `Drugs` int(11) NOT NULL default '0',
  `Leader` int(11) NOT NULL default '0',
  `Member` int(11) NOT NULL default '0',
  `FMember` int(11) NOT NULL default '255',
  `Rank` int(11) NOT NULL default '0',
  `Chara` int(11) NOT NULL default '0',
  `ContractTime` int(11) NOT NULL default '0',
  `DetSkill` int(11) NOT NULL default '0',
  `SexSkill` int(11) NOT NULL default '0',
  `BoxSkill` int(11) NOT NULL default '0',
  `LawSkill` int(11) NOT NULL default '0',
  `MechSkill` int(11) NOT NULL default '0',
  `JackSkill` int(11) NOT NULL default '0',
  `CarSkill` int(11) NOT NULL default '0',
  `NewsSkill` int(11) NOT NULL default '0',
  `DrugsSkill` int(11) NOT NULL default '0',
  `CookSkill` int(11) NOT NULL default '0',
  `FishSkill` int(11) NOT NULL default '0',
  `pSHealth` varchar(16) collate latin1_general_ci NOT NULL default '50.0',
  `pHealth` varchar(16) collate latin1_general_ci NOT NULL default '50.0',
  `Inte` int(11) NOT NULL default '0',
  `Local` int(11) NOT NULL default '255',
  `Team` int(11) NOT NULL default '3',
  `Model` int(11) NOT NULL default '264',
  `PhoneNr` int(11) NOT NULL default '0',
  `House` int(11) NOT NULL default '255',
  `Car` int(11) NOT NULL default '255',
  `Appt` int(11) NOT NULL default '255',
  `Bizz` int(11) NOT NULL default '255',
  `Pos_x` varchar(16) collate latin1_general_ci NOT NULL default '1684.9',
  `Pos_y` varchar(16) collate latin1_general_ci NOT NULL default '-2244.5',
  `Pos_z` varchar(16) collate latin1_general_ci NOT NULL default '13.5',
  `CarLic` int(11) NOT NULL default '0',
  `FlyLic` int(11) NOT NULL default '0',
  `BoatLic` int(11) NOT NULL default '0',
  `FishLic` int(11) NOT NULL default '0',
  `GunLic` int(11) NOT NULL default '0',
  `Gun1` int(11) NOT NULL default '0',
  `Gun2` int(11) NOT NULL default '0',
  `Gun3` int(11) NOT NULL default '0',
  `Gun4` int(11) NOT NULL default '0',
  `Ammo1` int(11) NOT NULL default '0',
  `Ammo2` int(11) NOT NULL default '0',
  `Ammo3` int(11) NOT NULL default '0',
  `Ammo4` int(11) NOT NULL default '0',
  `CarTime` int(11) NOT NULL default '0',
  `PayDay` int(11) NOT NULL default '0',
  `PayDayHad` int(11) NOT NULL default '0',
  `CDPlayer` int(11) NOT NULL default '0',
  `Wins` int(11) NOT NULL default '0',
  `Loses` int(11) NOT NULL default '0',
  `AlcoholPerk` int(11) NOT NULL default '0',
  `DrugPerk` int(11) NOT NULL default '0',
  `MiserPerk` int(11) NOT NULL default '0',
  `PainPerk` int(11) NOT NULL default '0',
  `TraderPerk` int(11) NOT NULL default '0',
  `Tutorial` int(11) NOT NULL default '0',
  `Mission` int(11) NOT NULL default '0',
  `Warnings` int(11) NOT NULL default '0',
  `Adjustable` int(11) NOT NULL default '0',
  `Fuel` int(11) NOT NULL default '0',
  `Married` int(11) NOT NULL default '0',
  `MarriedTo` varchar(50) collate latin1_general_ci NOT NULL default 'No-one',
  `Locked` tinyint(1) NOT NULL default '0',
  `Linked` int(11) NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
SET character_set_client = @saved_cs_client;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;