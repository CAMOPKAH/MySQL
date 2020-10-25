-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: vk
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Индификатор',
  `NameCode` varchar(100) NOT NULL COMMENT 'Наименование роли для интерфейса',
  `ShortName` varchar(1000) NOT NULL COMMENT 'Код роли',
  `Note` varchar(2000) DEFAULT NULL COMMENT 'Описание',
  PRIMARY KEY (`ID`),
  KEY `user_roles_FK` (`NameCode`),
  CONSTRAINT `user_roles_FK` FOREIGN KEY (`NameCode`) REFERENCES `lang_name_dic` (`name_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Справочник ролей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lang_name_dic`
--

DROP TABLE IF EXISTS `lang_name_dic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lang_name_dic` (
  `id` bigint unsigned NOT NULL COMMENT 'Уникальный индификатор',
  `lang_code` varchar(1000) DEFAULT NULL COMMENT 'Международный код языка',
  `name_code` varchar(100) DEFAULT NULL COMMENT 'Цифробуквенный код наименования',
  `Text` varchar(2000) DEFAULT NULL COMMENT 'Текст наименования name_code в соответсвии с языком lang_code',
  `Created_by_user` bigint unsigned NOT NULL COMMENT 'Создавший пользователь',
  `Created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания записи',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lang_name_dic_un` (`name_code`),
  KEY `lang_name_dic_FK` (`Created_by_user`),
  CONSTRAINT `lang_name_dic_FK` FOREIGN KEY (`Created_by_user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Справочник наименований на разных языках';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `ID` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Уникальный индификатор',
  `created_by` bigint unsigned NOT NULL COMMENT 'Создавший запись пользователь',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата/время создания',
  `Title` varchar(1000) NOT NULL COMMENT 'Заголовок',
  `Note` varchar(4000) NOT NULL COMMENT 'Описание события',
  `DATE_START` datetime DEFAULT NULL COMMENT 'Дата начала события/событий',
  `DATE_END` datetime DEFAULT NULL COMMENT 'Дата кончания события/событий',
  `DATE_NEXT` datetime DEFAULT NULL COMMENT 'Следующая дата собыитя',
  `DATE_NEXT_SQL` varchar(4000) DEFAULT NULL COMMENT 'Скрипт SQL расчёта следующий даты при повторяющемся событии',
  PRIMARY KEY (`ID`),
  KEY `event_FK` (`created_by`),
  CONSTRAINT `event_FK` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_users`
--

DROP TABLE IF EXISTS `event_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT 'Индификатор',
  `event_id` bigint unsigned NOT NULL COMMENT 'Событие',
  `user_id` bigint unsigned NOT NULL COMMENT 'Участник события',
  `role_id` bigint unsigned NOT NULL COMMENT 'Роль участника встречи',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания(присоединения к группе)',
  PRIMARY KEY (`id`),
  KEY `event_users_FK` (`event_id`),
  KEY `event_users_FK_2` (`role_id`),
  KEY `event_users_FK_1` (`user_id`),
  CONSTRAINT `event_users_FK` FOREIGN KEY (`event_id`) REFERENCES `event` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `event_users_FK_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `event_users_FK_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Участники события';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-25 20:35:19
