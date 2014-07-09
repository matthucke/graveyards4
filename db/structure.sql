-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: graveyards4_development
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.12.04.1

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
-- Table structure for table `book_chapters`
--

DROP TABLE IF EXISTS `book_chapters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_chapters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qr_code` varchar(30) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '99999',
  `graveyard_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `main_content` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `counties`
--

DROP TABLE IF EXISTS `counties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `counties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `full_path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `boundary` text,
  `type_name` varchar(255) DEFAULT 'County',
  `main_photo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_counties_on_state_id` (`state_id`),
  KEY `index_counties_on_main_photo_id` (`main_photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_sites`
--

DROP TABLE IF EXISTS `featured_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featured_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `section` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `graveyard_id` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `headline` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_featured_sites_on_graveyard_id` (`graveyard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `graveyards`
--

DROP TABLE IF EXISTS `graveyards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graveyards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feature_type` int(11) DEFAULT '0',
  `county_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `lat` decimal(10,6) DEFAULT NULL,
  `lng` decimal(10,6) DEFAULT NULL,
  `year_started` int(11) DEFAULT NULL,
  `usgs_id` int(11) DEFAULT NULL,
  `usgs_map` varchar(255) DEFAULT NULL,
  `homepage` varchar(255) DEFAULT NULL,
  `full_path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `main_photo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_graveyards_on_county_id` (`county_id`),
  KEY `index_graveyards_on_main_photo_id` (`main_photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11598 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `identities`
--

DROP TABLE IF EXISTS `identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `identities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `provider_text` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_identities_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `og1`
--

DROP TABLE IF EXISTS `og1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `og1` (
  `id` int(11) NOT NULL DEFAULT '0',
  `name` varchar(80) CHARACTER SET latin1 NOT NULL,
  `latitude_dms` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `longitude_dms` varchar(8) CHARACTER SET latin1 DEFAULT NULL,
  `usgsmap` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `county_name` varchar(20) CHARACTER SET latin1 DEFAULT NULL,
  `state` varchar(2) CHARACTER SET latin1 NOT NULL DEFAULT 'IL',
  `rating` int(11) DEFAULT '0',
  `denomination` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  `yearstarted` int(11) DEFAULT '0',
  `visited` int(11) DEFAULT '0',
  `visitdate` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `note` varchar(120) CHARACTER SET latin1 DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `address` varchar(60) CHARACTER SET latin1 DEFAULT '',
  `city` varchar(30) CHARACTER SET latin1 DEFAULT NULL,
  `phone` varchar(12) CHARACTER SET latin1 DEFAULT NULL,
  `zip` varchar(5) CHARACTER SET latin1 DEFAULT NULL,
  `contributor_name` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `imagename` varchar(40) CHARACTER SET latin1 DEFAULT '',
  `feature_url` varchar(100) CHARACTER SET latin1 DEFAULT NULL,
  `usgsid` bigint(20) DEFAULT '0',
  `parentid` int(11) DEFAULT '0',
  `latitude` decimal(8,6) DEFAULT NULL,
  `longitude` decimal(8,6) DEFAULT NULL,
  `flags` varchar(10) CHARACTER SET latin1 DEFAULT '',
  `source` varchar(12) CHARACTER SET latin1 DEFAULT '',
  `contributor2_name` varchar(40) CHARACTER SET latin1 DEFAULT NULL,
  `homepage` varchar(80) CHARACTER SET latin1 DEFAULT '',
  `feature_type` char(1) CHARACTER SET latin1 DEFAULT 'G',
  `county_id` int(11) DEFAULT '0',
  `shortname` varchar(60) CHARACTER SET latin1 DEFAULT '',
  `contributor_id` int(11) DEFAULT '0',
  `contributor2_id` int(11) DEFAULT '0',
  `book_code` varchar(10) CHARACTER SET latin1 DEFAULT '',
  `book_section` varchar(5) CHARACTER SET latin1 DEFAULT '',
  `url` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `main_photo_id` int(11) DEFAULT NULL,
  `photos_count` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `photo_migrations`
--

DROP TABLE IF EXISTS `photo_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `county_id` int(11) DEFAULT NULL,
  `graveyard_id` int(11) DEFAULT NULL,
  `contributor_id` int(11) DEFAULT NULL,
  `contributor_name` varchar(255) DEFAULT NULL,
  `old_path` varchar(255) DEFAULT NULL,
  `graveyard_name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8030 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `approver_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `votes` int(11) DEFAULT '0',
  `graveyard_id` int(11) DEFAULT NULL,
  `plot_id` int(11) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `story_id` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `flags` varchar(10) DEFAULT '',
  `title` varchar(100) DEFAULT '',
  `location` varchar(100) DEFAULT '',
  `caption` text,
  `format` varchar(3) DEFAULT 'jpg',
  `upload` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `md5sum` char(32) DEFAULT NULL,
  `migration_notes` text,
  `migration_id` int(11) DEFAULT NULL,
  `old_path` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8031 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `states`
--

DROP TABLE IF EXISTS `states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state_code` varchar(20) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `security_level` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary table structure for view `visit_migrations`
--

DROP TABLE IF EXISTS `visit_migrations`;
/*!50001 DROP VIEW IF EXISTS `visit_migrations`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `visit_migrations` (
  `id` tinyint NOT NULL,
  `graveyard_id` tinyint NOT NULL,
  `visited` tinyint NOT NULL,
  `visitdate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `graveyard_id` int(11) DEFAULT NULL,
  `visited_at` date DEFAULT NULL,
  `visit_type` int(11) DEFAULT NULL,
  `notes` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_visits_on_user_id` (`user_id`),
  KEY `index_visits_on_graveyard_id` (`graveyard_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1156 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `visit_migrations`
--

/*!50001 DROP TABLE IF EXISTS `visit_migrations`*/;
/*!50001 DROP VIEW IF EXISTS `visit_migrations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`hucke`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `visit_migrations` AS select `graveyards_com`.`graveyards`.`id` AS `id`,`graveyards_com`.`graveyards`.`id` AS `graveyard_id`,`graveyards_com`.`graveyards`.`visited` AS `visited`,`graveyards_com`.`graveyards`.`visitdate` AS `visitdate` from `graveyards_com`.`graveyards` where (`graveyards_com`.`graveyards`.`visited` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-08 20:56:58
INSERT INTO schema_migrations (version) VALUES ('20140413154006');

INSERT INTO schema_migrations (version) VALUES ('20140413200123');

INSERT INTO schema_migrations (version) VALUES ('20140413202014');

INSERT INTO schema_migrations (version) VALUES ('20140413212334');

INSERT INTO schema_migrations (version) VALUES ('20140413223837');

INSERT INTO schema_migrations (version) VALUES ('20140417020008');

INSERT INTO schema_migrations (version) VALUES ('20140417020135');

INSERT INTO schema_migrations (version) VALUES ('20140510222402');

INSERT INTO schema_migrations (version) VALUES ('20140511012758');

INSERT INTO schema_migrations (version) VALUES ('20140512001906');

INSERT INTO schema_migrations (version) VALUES ('20140512001914');

INSERT INTO schema_migrations (version) VALUES ('20140526005730');

INSERT INTO schema_migrations (version) VALUES ('20140601164929');

INSERT INTO schema_migrations (version) VALUES ('20140706221001');

