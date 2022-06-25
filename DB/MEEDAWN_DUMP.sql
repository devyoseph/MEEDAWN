-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: 127.0.0.1    Database: meedawn
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `board` (
  `id` int NOT NULL,
  `subject` varchar(90) DEFAULT NULL,
  `content` longtext,
  `member_userid` varchar(45) NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `platform` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (0,'ssss','ssss','ssss','ssss','2022-06-14 23:35:22','site'),(1,'dsdsd','sdsdsd','n9SqacLJ5X31tXfPfZWCIG0O4hF9QfWlOrYOx5fqmNs','허준','2022-06-15 00:18:08','naver'),(2,'글을 씁니다','그렇습니다','ssss','ssss','2022-06-15 13:50:49','site'),(3,'이 홈페이지는 뭐하는 곳인가요??','궁금하네요','ssss','ssss','2022-06-15 13:51:03','site'),(4,'저만 글쓰는데 사실인가요?','그렇습니다','ssss','ssss','2022-06-15 13:51:16','site'),(5,'왜 소통이 없죠??','특이하네요','ssss','ssss','2022-06-15 13:51:28','site');
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member` (
  `userid` varchar(45) NOT NULL,
  `userpwd` varchar(45) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `exp` int DEFAULT NULL,
  `lv` int DEFAULT NULL,
  `joindate` datetime DEFAULT NULL,
  `enabled` int DEFAULT NULL,
  `platform` varchar(10) DEFAULT NULL,
  `refresh_token` varchar(900) DEFAULT NULL,
  `refresh_token_date` datetime DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES ('admin','admin','admin','M','admin@admin.com',0,0,'2022-06-20 14:48:01',0,'site',NULL,NULL),('dddd','dddd','dddd','M','ddddd@dddd.com',0,0,'2022-06-15 15:35:08',0,'site',NULL,NULL),('ssss','ssss','ssss','M','ssss@sss.com',0,0,'2022-06-14 23:35:02',0,'site',NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snapshot`
--

DROP TABLE IF EXISTS `snapshot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snapshot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `filename` varchar(45) DEFAULT NULL,
  `path` varchar(500) DEFAULT NULL,
  `host` varchar(10) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `order` int DEFAULT NULL,
  `member_userid` varchar(900) NOT NULL,
  `original_filename` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_snapshot_member_idx` (`member_userid`),
  CONSTRAINT `fk_snapshot_member` FOREIGN KEY (`member_userid`) REFERENCES `member` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snapshot`
--

LOCK TABLES `snapshot` WRITE;
/*!40000 ALTER TABLE `snapshot` DISABLE KEYS */;
INSERT INTO `snapshot` VALUES (1,'portfolio-1','resources/img/portfolio/basic/portfolio-1.jpg','admin','app',1,'admin',NULL),(2,'portfolio-2','resources/img/portfolio/basic/portfolio-2.jpg','admin','web',2,'admin',NULL),(3,'portfolio-3','resources/img/portfolio/basic/portfolio-3.jpg','admin','app',3,'admin',NULL),(4,'portfolio-4','resources/img/portfolio/basic/portfolio-4.jpg','admin','card',4,'admin',NULL),(5,'portfolio-5','resources/img/portfolio/basic/portfolio-5.jpg','admin','web',5,'admin',NULL),(6,'portfolio-6','resources/img/portfolio/basic/portfolio-6.jpg','admin','app',6,'admin',NULL),(7,'portfolio-7','resources/img/portfolio/basic/portfolio-7.jpg','admin','card',7,'admin',NULL),(8,'portfolio-8','resources/img/portfolio/basic/portfolio-8.jpg','admin','web',8,'admin',NULL),(9,'portfolio-9','resources/img/portfolio/basic/portfolio-9.jpg','admin','web',9,'admin',NULL),(18,'ssss','/Users/yang-yoseb/git/repository/MEEDAWN/src/main/webapp/resources/img/portfolio/user/ssss@sss.com/6f6dff2d-03b0-466a-8202-e87eddd91eca.png','user','ssss',0,'ssss',NULL);
/*!40000 ALTER TABLE `snapshot` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-24 14:30:08
