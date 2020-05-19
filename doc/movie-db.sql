-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: movie-db
-- ------------------------------------------------------
-- Server version	5.7.29-0ubuntu0.18.04.1

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
-- Table structure for table `award`
--

DROP TABLE IF EXISTS `award`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `award` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8A5B2EE78F93B6FC` (`movie_id`),
  CONSTRAINT `FK_8A5B2EE78F93B6FC` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `award`
--

LOCK TABLES `award` WRITE;
/*!40000 ALTER TABLE `award` DISABLE KEYS */;
INSERT INTO `award` VALUES (1,2,'Oscar du Meilleur film 1998'),(2,2,'Oscar du Meilleur réalisateur1998'),(3,2,'Oscar du Meilleur montage 1998'),(4,4,'Oscar des Meilleurs effets visuels 1980');
/*!40000 ALTER TABLE `award` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Science-fiction'),(2,'Aventure'),(3,'Documentaire'),(4,'Thriller'),(5,'Horreur');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `director_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `release_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_1D5EF26F899FB366` (`director_id`),
  CONSTRAINT `FK_1D5EF26F899FB366` FOREIGN KEY (`director_id`) REFERENCES `person` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,1,'Avatar','2010-09-01'),(2,1,'Titanic','1998-01-07'),(3,4,'Les gardiens de la Galaxie','2014-08-07'),(4,1,'Alien','1979-09-12');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_actor`
--

DROP TABLE IF EXISTS `movie_actor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_actor` (
  `movie_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `character_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3A374C658F93B6FC` (`movie_id`),
  KEY `IDX_3A374C65217BBB47` (`person_id`),
  CONSTRAINT `FK_3A374C65217BBB47` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`),
  CONSTRAINT `FK_3A374C658F93B6FC` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_actor`
--

LOCK TABLES `movie_actor` WRITE;
/*!40000 ALTER TABLE `movie_actor` DISABLE KEYS */;
INSERT INTO `movie_actor` VALUES (1,2,1,'Netiri'),(1,3,2,'Grace'),(2,6,3,'Jack'),(2,7,4,'Rose'),(3,2,5,'Gamora'),(3,5,6,'Star Lord'),(4,3,7,'Ellen');
/*!40000 ALTER TABLE `movie_actor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_category`
--

DROP TABLE IF EXISTS `movie_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_category` (
  `movie_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`category_id`),
  KEY `IDX_DABA824C8F93B6FC` (`movie_id`),
  KEY `IDX_DABA824C12469DE2` (`category_id`),
  CONSTRAINT `FK_DABA824C12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DABA824C8F93B6FC` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_category`
--

LOCK TABLES `movie_category` WRITE;
/*!40000 ALTER TABLE `movie_category` DISABLE KEYS */;
INSERT INTO `movie_category` VALUES (1,1),(1,2),(2,2),(3,1),(3,2),(4,1),(4,5);
/*!40000 ALTER TABLE `movie_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_writer`
--

DROP TABLE IF EXISTS `movie_writer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_writer` (
  `movie_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  PRIMARY KEY (`movie_id`,`person_id`),
  KEY `IDX_6E6745F78F93B6FC` (`movie_id`),
  KEY `IDX_6E6745F7217BBB47` (`person_id`),
  CONSTRAINT `FK_6E6745F7217BBB47` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_6E6745F78F93B6FC` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_writer`
--

LOCK TABLES `movie_writer` WRITE;
/*!40000 ALTER TABLE `movie_writer` DISABLE KEYS */;
INSERT INTO `movie_writer` VALUES (2,1),(3,4),(3,8);
/*!40000 ALTER TABLE `movie_writer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'James Cameron','1954-08-16'),(2,'Zoe Saldana','1978-06-19'),(3,'Sigourney Weaver','1949-10-08'),(4,'James Gunn','1970-08-05'),(5,'Chris Pratt','1979-06-21'),(6,'Leonardo DiCaprio','1974-11-11'),(7,'Kate Winslet','1975-10-05'),(8,'Dan Abnett','1965-10-12');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (1,'Meillleur film de SF !','Lorem ipsum dolor, sit amet consectetur adipisicing elit. Itaque ducimus magni laborum reprehenderit, quisquam dolor repellat nam ipsa ullam, excepturi quod libero, deserunt doloribus corrupti vel maiores. Doloribus culpa ducimus hic cupiditate necessitatibus. Assumenda dolorem saepe earum, alias fuga veritatis nulla impedit quisquam id error incidunt! Neque aspernatur, fugit nemo laboriosam enim dignissimos facere labore laudantium officia itaque natus eligendi culpa quae possimus provident saepe odit, doloremque fugiat quos obcaecati quam vel. Necessitatibus dolorem laborum rerum delectus magni repudiandae commodi veritatis. Ut, maiores? Quisquam eligendi officia voluptates! Corporis eaque architecto, consectetur molestiae eos sint dolores, modi, voluptas mollitia officiis cumque a ratione atque! Eligendi quam voluptatibus modi perferendis distinctio ab necessitatibus similique in neque dolores ipsum eum incidunt vitae consectetur facilis, maiores dolore ullam aut odio aliquam aliquid voluptates. Numquam, dolorum vitae? Sint sunt harum odio neque fuga libero. Explicabo maiores magni, quaerat ad iusto eveniet neque exercitationem expedita commodi esse doloribus odio inventore voluptate dolore velit. Illum nostrum architecto, velit quo assumenda veniam tenetur quia laborum quos eos asperiores sunt beatae maiores quaerat facilis ipsa sapiente unde ducimus? Non repellat aliquid quos magni inventore molestiae cupiditate repellendus? Consequuntur accusantium quisquam labore soluta voluptates voluptas distinctio praesentium quo quae quasi.','2020-01-06 00:00:00'),(2,'Le réalisateur vedette  : James Cameron','Lorem ipsum dolor sit amet consectetur, adipisicing elit. Quisquam a minima, commodi nulla molestias, esse corrupti animi neque quis assumenda eveniet, ullam quae iste ducimus modi repudiandae distinctio eum dolorem natus quos tempora aperiam. Nobis aliquid dolorum, mollitia voluptatem quasi quidem quisquam odio. Aperiam nam delectus aspernatur quos ab debitis consectetur dolor quasi iure velit? Deserunt blanditiis ullam vel officiis alias, necessitatibus corporis quam vitae voluptatem voluptate saepe explicabo earum similique nisi repudiandae quos non labore quibusdam perferendis, quaerat a, nesciunt quasi. Tenetur, possimus dicta. Eveniet laudantium recusandae reiciendis nihil deleniti rem! Earum vel blanditiis explicabo odio ad illum quod ullam? Quasi, velit repellendus alias veritatis aperiam iste corporis reprehenderit dolorum, cupiditate aliquam et quas asperiores mollitia magni nihil odio eos ducimus vel porro, quod laboriosam quis deleniti accusantium. Sed suscipit odit, praesentium molestias non consequuntur magni. Ea, natus maiores. Cum nulla esse modi asperiores deserunt quos quae, quis accusantium nam a aliquid obcaecati dolorem incidunt praesentium saepe optio rem tempore harum eveniet ratione, laboriosam dolorum fugit? Necessitatibus veritatis repellat inventore, dolorum amet ut qui impedit, facilis odit incidunt accusantium rerum omnis. Nihil doloribus voluptatum esse. Officia sed mollitia soluta esse quia. At aliquam, vel quidem facilis ipsum recusandae temporibus quas sed inventore distinctio praesentium. Velit ratione perspiciatis quisquam consectetur ad recusandae aliquid quaerat aspernatur dicta dolorum perferendis odio adipisci nihil autem, neque sapiente sit eligendi corporis iusto officia. Odio rem veritatis commodi architecto facilis aspernatur, illum quidem quaerat numquam facere dolor eos ullam aperiam qui tenetur neque dolorum soluta dolorem modi saepe provident quas tempore. Voluptatibus qui explicabo tenetur fugit illum repudiandae maxime, sit consequatur commodi officia ex, provident natus praesentium molestiae vitae eveniet et deserunt sapiente numquam voluptatum velit ducimus. Dolore nesciunt similique vitae possimus a, ipsum iusto, voluptatum culpa, quaerat veniam illo quibusdam voluptatem quis eaque delectus.','2020-02-14 00:00:00');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_movie`
--

DROP TABLE IF EXISTS `post_movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_movie` (
  `post_id` int(11) NOT NULL,
  `movie_id` int(11) NOT NULL,
  PRIMARY KEY (`post_id`,`movie_id`),
  KEY `IDX_8A457E804B89032C` (`post_id`),
  KEY `IDX_8A457E808F93B6FC` (`movie_id`),
  CONSTRAINT `FK_8A457E804B89032C` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_8A457E808F93B6FC` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_movie`
--

LOCK TABLES `post_movie` WRITE;
/*!40000 ALTER TABLE `post_movie` DISABLE KEYS */;
INSERT INTO `post_movie` VALUES (1,4),(2,1),(2,2),(2,4);
/*!40000 ALTER TABLE `post_movie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-15  9:53:13
