-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: movie
-- ------------------------------------------------------
-- Server version	5.5.5-10.10.2-MariaDB-1:10.10.2+maria~ubu2204

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
-- Table structure for table `aktor`
--

DROP TABLE IF EXISTS `aktor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aktor` (
  `aktor_id` int(11) NOT NULL AUTO_INCREMENT,
  `aktor_nama_depan` varchar(20) DEFAULT NULL,
  `aktor_nama_belakang` varchar(20) DEFAULT NULL,
  `aktor_jenis_kelamin` enum('Laki-laki','Perempuan') DEFAULT NULL,
  PRIMARY KEY (`aktor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktor`
--

LOCK TABLES `aktor` WRITE;
/*!40000 ALTER TABLE `aktor` DISABLE KEYS */;
INSERT INTO `aktor` VALUES (101,'James','Stewart','Laki-laki'),(102,'Deborah','Kerr','Perempuan'),(103,'Peter','OToole','Laki-laki'),(104,'Robert','De Niro','Laki-laki'),(105,'F. Murray','Abraham','Laki-laki'),(106,'Harrison','Ford','Laki-laki'),(107,'Nicole','Kidman','Perempuan'),(108,'Stephen','Baldwin','Laki-laki'),(109,'Jack','Nicholson','Laki-laki'),(110,'Mark','Wahlberg','Laki-laki'),(111,'Woody','Allen','Laki-laki'),(112,'Claire','Danes','Perempuan'),(113,'Tim','Robbins','Laki-laki'),(114,'Kevin','Spacey','Laki-laki'),(115,'Kate','Winslet','Perempuan'),(116,'Robin','Williams','Laki-laki'),(117,'Jon','Voight','Laki-laki'),(118,'Ewan','McGregor','Laki-laki'),(119,'Christian','Bale','Laki-laki'),(120,'Maggie','Gyllenhaal','Perempuan'),(121,'Dev','Patel','Laki-laki'),(122,'Sigourney','Weaver','Perempuan'),(123,'David','Aston','Laki-laki'),(124,'Ali','Astin','Perempuan');
/*!40000 ALTER TABLE `aktor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `film` (
  `film_id` int(11) NOT NULL AUTO_INCREMENT,
  `film_judul` varchar(50) DEFAULT NULL,
  `film_tahun` year(4) DEFAULT NULL,
  `film_durasi` int(11) DEFAULT NULL,
  `film_bahasa` varchar(50) DEFAULT NULL,
  `film_tanggal_rilis` date DEFAULT NULL,
  `film_negara_rilis` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`film_id`)
) ENGINE=InnoDB AUTO_INCREMENT=929 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `film`
--

LOCK TABLES `film` WRITE;
/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` VALUES (901,'Vertigo',1958,128,'English','1958-08-24','UK'),(902,'The Innocents',1961,100,'English','1962-02-19','SW'),(903,'Lawrence of Arabia',1962,216,'English','1962-12-11','UK'),(904,'The Deer Hunter',1978,183,'English','1979-03-08','UK'),(905,'Amadeus',1984,160,'English','1985-01-07','UK'),(906,'Blade Runner',1982,117,'English','1982-09-09','UK'),(907,'Eyes Wide Shut',1999,159,'English',NULL,'UK'),(908,'The Usual Suspects',1995,106,'English','1995-08-25','UK'),(909,'Chinatown',1974,130,'English','1974-08-09','UK'),(910,'Boogie Nights',1997,155,'English','1998-02-16','UK'),(911,'Annie Hall',1977,93,'English','1977-04-20','USA'),(912,'Princess Mononoke',1997,134,'Japanese','2001-10-19','UK'),(913,'The Shawshank Redemption',1994,142,'English','1995-02-17','UK'),(914,'American Beauty',1999,122,'English',NULL,'UK'),(915,'Titanic',1997,194,'English','1998-01-23','UK'),(916,'Good Will Hunting',1997,126,'English','1998-06-03','UK'),(917,'Deliverance',1972,109,'English','1982-10-05','UK'),(918,'Trainspotting',1996,94,'English','1996-02-23','UK'),(919,'The Prestige',2006,130,'English','2006-11-10','UK'),(920,'Donnie Darko',2001,113,'English',NULL,'UK'),(921,'Slumdog Millionaire',2008,120,'English','2009-01-09','UK'),(922,'Aliens',1986,137,'English','1986-08-29','UK'),(923,'Beyond the Sea',2004,118,'English','2004-11-26','UK'),(924,'Avatar',2009,162,'English','2009-12-17','UK'),(925,'Braveheart',1995,178,'English','1995-09-08','UK'),(926,'Seven Samurai',1954,207,'Japanese','1954-04-26','JP'),(927,'Spirited Away',2001,125,'Japanese','2003-09-12','UK'),(928,'Back to the Future',1985,116,'English','1985-12-04','UK');
/*!40000 ALTER TABLE `film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int(11) NOT NULL AUTO_INCREMENT,
  `genre_judul` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1001,'Action'),(1002,'Adventure'),(1003,'Animation'),(1004,'Biography'),(1005,'Comedy'),(1006,'Crime'),(1007,'Drama'),(1008,'Horror'),(1009,'Music'),(1010,'Mystery'),(1011,'Romance'),(1012,'Thriller'),(1013,'War');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_film`
--

DROP TABLE IF EXISTS `genre_film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre_film` (
  `genre_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  PRIMARY KEY (`genre_id`,`film_id`),
  KEY `fk_genre_film_genre_idx` (`genre_id`),
  KEY `fk_genre_film_film1_idx` (`film_id`),
  CONSTRAINT `fk_genre_film_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_genre_film_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_film`
--

LOCK TABLES `genre_film` WRITE;
/*!40000 ALTER TABLE `genre_film` DISABLE KEYS */;
INSERT INTO `genre_film` VALUES (1001,922),(1002,903),(1002,917),(1003,912),(1005,911),(1006,908),(1006,913),(1007,918),(1007,921),(1007,926),(1007,928),(1008,902),(1009,923),(1010,901),(1010,907),(1010,927),(1011,914),(1012,906),(1013,904);
/*!40000 ALTER TABLE `genre_film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pemeran_film`
--

DROP TABLE IF EXISTS `pemeran_film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pemeran_film` (
  `aktor_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  `pemeran_film_peran` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`aktor_id`,`film_id`),
  KEY `fk_pemeran_film_film1_idx` (`film_id`),
  CONSTRAINT `fk_pemeran_film_aktor1` FOREIGN KEY (`aktor_id`) REFERENCES `aktor` (`aktor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pemeran_film_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pemeran_film`
--

LOCK TABLES `pemeran_film` WRITE;
/*!40000 ALTER TABLE `pemeran_film` DISABLE KEYS */;
INSERT INTO `pemeran_film` VALUES (101,901,'John Scottie Ferguson'),(102,902,'Miss Giddens'),(103,903,'T.E. Lawrence'),(104,904,'Michael'),(105,905,'Antonio Salieri'),(106,906,'Rick Deckard'),(107,907,'Alice Harford'),(108,908,'McManus'),(109,909,'J.J. Gittes'),(110,910,'Eddie Adams'),(111,911,'Alvy Singer'),(112,912,'San'),(113,913,'Andy Dufresne'),(114,914,'Lester Burnham'),(114,923,'Bobby Darin'),(115,915,'Rose DeWitt Bukater'),(116,916,'Sean Maguire'),(117,917,'Ed'),(118,918,'Renton'),(119,919,'Alfred Borden'),(120,920,'Elizabeth Darko'),(121,921,'Older Jamal'),(122,922,'Ripley');
/*!40000 ALTER TABLE `pemeran_film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `film_id` int(11) NOT NULL,
  `reviewer_id` int(11) NOT NULL,
  `rating_nilai` tinyint(1) DEFAULT NULL,
  `rating_total` int(11) DEFAULT NULL,
  PRIMARY KEY (`film_id`,`reviewer_id`),
  KEY `fk_rating_reviewer1_idx` (`reviewer_id`),
  CONSTRAINT `fk_rating_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_reviewer1` FOREIGN KEY (`reviewer_id`) REFERENCES `reviewer` (`reviewer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (901,9001,8,263575),(902,9002,8,20207),(903,9003,8,202778),(906,9005,8,484746),(908,9007,9,779489),(909,9008,NULL,227235),(910,9009,3,195961),(911,9010,8,203875),(912,9011,8,NULL),(914,9013,7,862618),(915,9001,8,830095),(916,9014,4,642132),(918,9016,NULL,580301),(920,9017,8,609451),(921,9018,8,667758),(922,9019,8,511613),(923,9020,7,13091),(924,9006,7,NULL),(925,9015,8,81328);
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewer`
--

DROP TABLE IF EXISTS `reviewer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewer` (
  `reviewer_id` int(11) NOT NULL AUTO_INCREMENT,
  `reviewer_nama` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`reviewer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9021 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewer`
--

LOCK TABLES `reviewer` WRITE;
/*!40000 ALTER TABLE `reviewer` DISABLE KEYS */;
INSERT INTO `reviewer` VALUES (9001,'Righty Sock'),(9002,'Jack Malvern'),(9003,'Flagrant Baronessa'),(9004,'Alec Shaw'),(9005,NULL),(9006,'Victor Woeltjen'),(9007,'Simon Wright'),(9008,'Neal Wruck'),(9009,'Paul Monks'),(9010,'Mike Salvati'),(9011,NULL),(9012,'Wesley S. Walker'),(9013,'Sasha Goldshtein'),(9014,'Josh Cates'),(9015,'Krug Stillo'),(9016,'Scott LeBrun'),(9017,'Hannah Steele'),(9018,'Vincent Cadena'),(9019,'Brandt Sponseller'),(9020,'Richard Adams');
/*!40000 ALTER TABLE `reviewer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sutradara`
--

DROP TABLE IF EXISTS `sutradara`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sutradara` (
  `sutradara_id` int(11) NOT NULL AUTO_INCREMENT,
  `sutradara_nama_depan` varchar(20) DEFAULT NULL,
  `sutradara_nama_belakang` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`sutradara_id`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sutradara`
--

LOCK TABLES `sutradara` WRITE;
/*!40000 ALTER TABLE `sutradara` DISABLE KEYS */;
INSERT INTO `sutradara` VALUES (201,'Alfred','Hitchcock'),(202,'Jack','Clayton'),(203,'David','Lean'),(204,'Michael','Cimino'),(205,'Milos','Forman'),(206,'Ridley','Scott'),(207,'Stanley','Kubrick'),(208,'Bryan','Singer'),(209,'Roman','Polanski'),(210,'Paul','Thomas Anderson'),(211,'Woody','Allen'),(212,'Hayao','Miyazaki'),(213,'Frank','Darabont'),(214,'Sam','Mendes'),(215,'James','Cameron'),(216,'Gus','Van Sant'),(217,'John','Boorman'),(218,'Danny','Boyle'),(219,'Christopher','Nolan'),(220,'Richard','Kelly'),(221,'Kevin','Spacey'),(222,'Andrei','Tarkovsky'),(223,'Peter','Jackson');
/*!40000 ALTER TABLE `sutradara` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sutradara_film`
--

DROP TABLE IF EXISTS `sutradara_film`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sutradara_film` (
  `sutradara_id` int(11) NOT NULL,
  `film_id` int(11) NOT NULL,
  PRIMARY KEY (`sutradara_id`,`film_id`),
  KEY `fk_sutradara_film_film1_idx` (`film_id`),
  CONSTRAINT `fk_sutradara_film_film1` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_sutradara_film_sutradara1` FOREIGN KEY (`sutradara_id`) REFERENCES `sutradara` (`sutradara_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sutradara_film`
--

LOCK TABLES `sutradara_film` WRITE;
/*!40000 ALTER TABLE `sutradara_film` DISABLE KEYS */;
INSERT INTO `sutradara_film` VALUES (201,901),(202,902),(203,903),(204,904),(205,905),(206,906),(207,907),(208,908),(209,909),(210,910),(211,911),(212,912),(213,913),(214,914),(215,915),(215,922),(216,916),(217,917),(218,918),(218,921),(219,919),(220,920),(221,923);
/*!40000 ALTER TABLE `sutradara_film` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'movie'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-02 15:57:41
