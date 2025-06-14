/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `player_rank`.
--
DROP TABLE IF EXISTS `player_rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_rank` (
  `ckey` VARCHAR(32) NOT NULL,
  `rank` VARCHAR(12) NOT NULL,
  `admin_ckey` VARCHAR(32) NOT NULL,
  `date_added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`ckey`, `rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `player_rank_log`.
--
DROP TABLE IF EXISTS `player_rank_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_rank_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ckey` VARCHAR(32) NOT NULL,
  `rank` VARCHAR(12) NOT NULL,
  `admin_ckey` VARCHAR(32) NOT NULL,
  `action` ENUM('ADDED', 'REMOVED') NOT NULL DEFAULT 'ADDED',
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Trigger structure for trigger `log_player_rank_additions`.
--
DROP TRIGGER IF EXISTS `log_player_rank_additions`;
CREATE TRIGGER `log_player_rank_additions`
AFTER INSERT ON `player_rank`
FOR EACH ROW
INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'ADDED');


--
-- Trigger structure for trigger `log_player_rank_changes`.
--
DROP TRIGGER IF EXISTS `log_player_rank_changes`;
DELIMITER //
CREATE TRIGGER `log_player_rank_changes`
AFTER UPDATE ON `player_rank`
FOR EACH ROW
BEGIN
 IF NEW.deleted = 1 THEN
  INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'REMOVED');
 ELSE
  INSERT INTO player_rank_log (ckey, rank, admin_ckey, `action`) VALUES (NEW.ckey, NEW.rank, NEW.admin_ckey, 'ADDED');
 END IF;
END; //
DELIMITER ;


--
-- Table structure for table `donators`.
--
DROP TABLE IF EXISTS `donators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donators` (
  `email` VARCHAR(320) NOT NULL,
  `total_donated` DECIMAL(7,2) NOT NULL,
  `ckey` VARCHAR(32) NULL DEFAULT NULL,
  `donation_donator_slots` int(4) NOT NULL DEFAULT '0',
  `bonus_donator_slots` int(4) NOT NULL DEFAULT '0',
  `total_donator_slots` int(4) NOT NULL DEFAULT '0',
  `used_donator_slots` int(4) NOT NULL DEFAULT '0',
  `first_donation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_donation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `donations`.
--
DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donations` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `email` VARCHAR(320) NOT NULL,
  `donation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` DECIMAL(6,2) NOT NULL,
  `donation_type` ENUM('Donation', 'Subscription', 'Shop Order') NOT NULL DEFAULT 'Donation',
  INDEX(`email`),
  INDEX(`donation_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `donation_manipulation_log`.
--
DROP TABLE IF EXISTS `donation_manipulation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donation_manipulation_log` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `action` ENUM('USED SLOTS', 'LINKED CKEY', 'ADDED SLOTS') NOT NULL DEFAULT 'USED SLOTS',
  `admin_ckey` VARCHAR(32) NOT NULL,
  `donator_email` VARCHAR(320) NOT NULL,
  `donator_ckey` VARCHAR(32) NULL DEFAULT NULL,
  `amount` int(4) NULL DEFAULT NULL,
  `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Trigger structure for trigger `update_donator_from_donation`.
--
DROP TRIGGER IF EXISTS `update_donator_from_donation`;
DELIMITER //
CREATE TRIGGER `update_donator_from_donation`
AFTER INSERT ON `donations`
FOR EACH ROW
BEGIN
 INSERT INTO `donators` (email, total_donated, first_donation_date) VALUES (NEW.email, NEW.amount, NEW.donation_date)
 ON DUPLICATE KEY UPDATE total_donated = total_donated + NEW.amount, last_donation_date = NEW.donation_date;
 UPDATE `donators` SET donation_donator_slots = total_donated DIV 15, total_donator_slots = donation_donator_slots + bonus_donator_slots WHERE email = NEW.email;
END; //
DELIMITER ;


--
-- Table structure for table `whitelist`.
--
DROP TABLE IF EXISTS `whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `whitelist` (
  `ckey` VARCHAR(32) NOT NULL,
  `date_added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `revoked` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`ckey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Procedure to update player ckeys in the database.
--
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
DELIMITER $$
DROP PROCEDURE IF EXISTS `update_ckey`;
CREATE PROCEDURE `update_ckey`(
	IN `old_ckey` VARCHAR(32),
	IN `new_ckey` VARCHAR(32)
)
SQL SECURITY INVOKER
BEGIN
	UPDATE IGNORE `achievements` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `admin` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `ban` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `library` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `messages` SET targetckey = new_ckey WHERE targetckey= old_ckey;
	UPDATE IGNORE `player_rank` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `role_time` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `tutorial_completions` SET ckey = new_ckey WHERE ckey = old_ckey;
	UPDATE IGNORE `whitelist` SET ckey = new_ckey WHERE ckey = old_ckey;
END
$$

DELIMITER ;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
