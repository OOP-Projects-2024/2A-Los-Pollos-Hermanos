-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 21, 2024 at 05:00 PM
-- Server version: 8.0.36
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blogapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(250) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `category`) VALUES
(1, 'Entertainment'),
(2, 'Gaming'),
(3, 'Education'),
(4, 'Travel'),
(5, 'Meme'),
(6, 'Foods and Recipes'),
(7, 'Health and Wellness'),
(8, 'Marketing'),
(9, 'Gadgets'),
(10, 'Art & Design'),
(11, 'Music'),
(12, 'Fashion'),
(13, 'Comic Books'),
(14, 'Sports'),
(15, 'Books and Literature'),
(16, 'DIY and Crafts'),
(17, 'Beauty and Skincare'),
(18, 'Personal Finance'),
(19, 'Mental Health'),
(20, 'Pop Culture'),
(21, 'Social Media Trends'),
(22, 'Parenting'),
(23, 'Lifestyle'),
(24, 'Politics'),
(25, 'Home Decor'),
(26, 'Music'),
(27, 'Music'),
(28, 'Music');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `comment_username` varchar(250) NOT NULL,
  `content` varchar(250) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `isdeleted` tinyint(1) DEFAULT '0',
  `user_user_id` int NOT NULL,
  `post_post_id` int NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `userId_ibfk_3` (`user_user_id`),
  KEY `post_ibfk_3` (`post_post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`comment_id`, `comment_username`, `content`, `created_at`, `updated_at`, `isdeleted`, `user_user_id`, `post_post_id`) VALUES
(1, 'BatmanForever2006', 'Can\'t Wait!!!', '2024-12-20 19:26:13', '2024-12-20 22:57:23', NULL, 2, 6),
(2, 'SuperGuy', 'I hope he is a fantastical Batman!', '2024-12-20 23:01:05', NULL, NULL, 3, 7),
(3, 'MoonGuy', 'It is about time', '2024-12-21 02:33:41', '2024-12-21 20:48:44', NULL, 22, 8),
(4, 'ShoutingLady', 'Virtual classrooms are the future. Revolutionary idea!', '2024-12-21 02:34:42', NULL, NULL, 10, 9),
(5, 'SpiderGuy', 'I love discovering hidden gems! Adding these to my list.', '2024-12-21 02:35:15', NULL, NULL, 19, 10),
(6, 'LanternGuy', 'That meme is hilarious! It really took over my feed.', '2024-12-21 02:36:10', NULL, NULL, 6, 11),
(7, 'DeadGuy', 'Quick recipes are a lifesaver! Thanks for sharing.', '2024-12-21 02:37:04', NULL, NULL, 25, 12),
(8, 'ClawGuy', '10 tips I’ll definitely be trying. Great advice!', '2024-12-21 02:37:44', NULL, NULL, 21, 13),
(9, 'HalfRobGuy', 'Digital marketing is evolving so fast. Love this breakdown!', '2024-12-21 02:38:15', NULL, NULL, 12, 14),
(10, 'WonderGal', 'These gadgets are incredible. Can’t wait to try them!', '2024-12-21 02:38:58', NULL, NULL, 7, 15),
(11, 'HammerGuy', 'The art exhibit sounds groundbreaking. Definitely visiting!', '2024-12-21 02:39:54', '2024-12-21 22:16:52', 1, 18, 16),
(12, 'HawkGal', 'Vinyl is back! Nostalgia at its finest.', '2024-12-21 02:40:32', '2024-12-21 22:21:15', 1, 14, 17),
(13, 'BatmanForever2006', 'Bold colors and futuristic vibes—loving the 2024 trends!', '2024-12-21 02:41:14', '2024-12-21 22:25:51', 1, 2, 18),
(14, 'GreenAlien', 'Indie comics are redefining storytelling. Can’t wait to read more!', '2024-12-21 02:41:52', NULL, NULL, 9, 19),
(15, 'TinMan', 'That upset in the championship finals was epic!', '2024-12-21 02:42:21', '2024-12-21 22:33:28', 1, 24, 20),
(16, 'MetalMan', 'Adding these must-read books to my reading list.', '2024-12-21 02:42:54', NULL, NULL, 16, 21),
(17, 'WaterGuy', 'DIY projects are so fulfilling. Thanks for the ideas!', '2024-12-21 02:43:18', NULL, NULL, 8, 22),
(18, 'AcrobatGuy', 'Skincare secrets I can’t wait to try for a radiant glow!', '2024-12-21 02:43:51', NULL, NULL, 15, 23),
(19, 'AcrobatGuy', 'Those social media trends are so relevant. Thanks for the update!', '2024-12-21 02:45:41', NULL, NULL, 15, 27),
(20, 'ArrowGuy', 'Mental health is key. Love these innovative approaches!', '2024-12-21 02:46:22', NULL, NULL, 11, 25),
(21, 'WidowGal', '2024’s pop culture moments have been unforgettable!', '2024-12-21 02:47:02', NULL, NULL, 23, 26),
(22, 'TornadoGuy', 'Those social media trends are so relevant. Thanks for the update!', '2024-12-21 02:47:45', NULL, NULL, 13, 27),
(23, 'FastGuy', 'Parenting hacks are always welcome. Great post!', '2024-12-21 02:48:29', NULL, NULL, 5, 28),
(24, 'SuperGuy', 'Redefining lifestyle is so crucial for modern living.', '2024-12-21 02:49:11', NULL, NULL, 3, 29),
(25, 'WidowGal', 'Bit skeptical will watch nonetheless', '2024-12-21 02:51:21', NULL, NULL, 23, 6),
(26, 'Vince', 'It is time!!', '2024-12-21 03:42:42', NULL, NULL, 26, 6);

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `content` varchar(250) NOT NULL,
  `image` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `views` int NOT NULL DEFAULT '0',
  `isdeleted` tinyint(1) DEFAULT NULL,
  `user_user_id` int NOT NULL,
  `category_category_id` int NOT NULL,
  PRIMARY KEY (`post_id`),
  KEY `userId_ibfk_2` (`user_user_id`),
  KEY `categoryid_ibfk_1` (`category_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `post`
--

INSERT INTO `post` (`post_id`, `title`, `content`, `image`, `created_at`, `updated_at`, `views`, `isdeleted`, `user_user_id`, `category_category_id`) VALUES
(6, 'Look UP', 'As we prepare for the first ever movie in the new DC universe, a trailer for the new film Superman has just landed', 'uploads/superman-logo-james-gunn.jpg', '2024-12-20 01:43:11', '2024-12-22 00:58:33', 12, 0, 1, 1),
(7, 'Batman in the new DCU', 'In the recent episode of Creature Commandos set in the new James Gunn DC cinematic universe we just got a glimpsed of the cape crusader himself', 'uploads/dcu-batman-creature-commandos-2.jpg', '2024-12-20 22:27:58', '2024-12-22 00:58:33', 12, 0, 2, 13),
(8, 'TEKKEN 8 won Fighting Game of the Year', 'Despite its issues TEKKEN 8 still fought and won Fighting game of the Year', 'uploads/TEKKEN8_Header_mobile_2.jpg', '2024-12-21 01:44:06', '2024-12-22 00:58:33', 12, 0, 4, 2),
(9, 'Revolutionizing Online Learning in 2024', 'Virtual reality classrooms are set to redefine how students engage with education globally.', 'uploads/Online-Learning.jpg', '2024-12-21 01:50:43', '2024-12-22 00:23:50', 0, 1, 5, 3),
(10, 'Hidden Gems: Top Underrated Travel Spots', 'Discover these breathtaking locations that have managed to stay under the radar of most tourists.', NULL, '2024-12-21 01:52:16', '2024-12-21 21:48:08', 0, 1, 6, 4),
(11, 'The Meme That Took Over the Internet', 'A single hilarious moment has turned into a viral sensation, dominating social media feeds.', NULL, '2024-12-21 01:53:11', '2024-12-21 22:06:45', 0, 1, 7, 5),
(12, '5-Minute Recipes for Busy Professionals', 'Quick and delicious meals to make your workdays a little easier and tastier.', NULL, '2024-12-21 01:54:18', '2024-12-22 00:58:33', 12, 0, 8, 6),
(13, '10 Tips for a Healthier Lifestyle', 'Transform your daily habits with these simple and effective health tips.', NULL, '2024-12-21 01:55:24', '2024-12-22 00:58:33', 12, 0, 9, 7),
(14, 'The Future of Digital Marketing', 'AI and automation are shaping the next era of marketing strategies and consumer engagement.', NULL, '2024-12-21 01:56:26', '2024-12-22 00:58:33', 12, 0, 10, 8),
(15, 'Top Gadgets You Need in 2024', 'Stay ahead of the curve with these innovative devices that are changing the tech world.', NULL, '2024-12-21 01:57:24', '2024-12-22 00:58:33', 12, 0, 11, 9),
(16, 'The Art Exhibit Everyone’s Talking About', 'This groundbreaking collection has captivated both critics and audiences alike.', NULL, '2024-12-21 01:58:37', '2024-12-21 22:05:31', 0, 0, 12, 10),
(17, 'The Comeback of Vinyl Records in 2024', 'Music enthusiasts are embracing the nostalgic charm of vinyl, sparking a new wave of record sales.', NULL, '2024-12-21 02:00:36', '2024-12-21 22:05:31', 0, 0, 13, 11),
(18, '2024’s Boldest Fashion Trends Revealed', 'Get ready for vibrant colors and futuristic designs to dominate the runway this year.', NULL, '2024-12-21 02:02:17', '2024-12-21 22:05:31', 0, 0, 14, 12),
(19, 'The Rise of Indie Comic Books', 'Indie creators are redefining storytelling with bold, original comic series gaining global attention.', NULL, '2024-12-21 02:02:54', '2024-12-22 00:58:33', 12, 0, 15, 13),
(20, 'Shocking Upset in the Championship Finals', 'An underdog team has made history by defeating the reigning champions in a stunning match.', NULL, '2024-12-21 02:03:42', '2024-12-21 22:05:31', 0, 0, 16, 14),
(21, 'The Top 10 Must-Read Books of the Year', 'Dive into these gripping stories that are making waves in the literary world.', NULL, '2024-12-21 02:04:19', '2024-12-22 00:58:33', 12, 0, 17, 15),
(22, 'DIY Home Projects to Transform Your Space', 'These easy and affordable projects will bring fresh energy to your living area.', NULL, '2024-12-21 02:04:59', '2024-12-22 00:58:33', 12, 0, 18, 16),
(23, 'Skincare Tips for a Radiant Glow', 'Discover the secrets to flawless skin with these dermatologist-recommended techniques.', NULL, '2024-12-21 02:05:38', '2024-12-22 00:58:33', 12, 0, 19, 17),
(24, 'Mastering Personal Finance in 2024', 'Learn the key strategies for saving, investing, and growing your wealth this year.', NULL, '2024-12-21 02:06:19', '2024-12-21 22:05:31', 0, 0, 20, 18),
(25, 'The Mental Health Revolution', 'Innovative approaches are making mental health care more accessible and effective.', NULL, '2024-12-21 02:07:24', '2024-12-22 00:58:33', 12, 0, 21, 19),
(26, 'Pop Culture Moments That Defined 2024', 'These unforgettable events have left a lasting impact on the world of entertainment.', NULL, '2024-12-21 02:08:18', '2024-12-22 00:58:33', 12, 0, 22, 20),
(27, 'The Social Media Trends You Can\'t Ignore', 'Stay ahead of the curve with these viral trends dominating online platforms.', NULL, '2024-12-21 02:09:47', '2024-12-22 00:58:33', 12, 0, 23, 21),
(28, 'Parenting Hacks for Modern Families', 'Discover practical tips to navigate the challenges of parenting in the digital age.', NULL, '2024-12-21 02:10:28', '2024-12-22 00:58:33', 12, 0, 24, 22),
(29, 'Redefining Lifestyle in 2024', 'Explore how minimalism and sustainability are shaping the way we live.', NULL, '2024-12-21 02:10:57', '2024-12-22 00:58:33', 12, 0, 25, 23),
(30, 'The new Superman Trailer', 'The new trailer to the new Superman movie is out and fans are mixed about it', NULL, '2024-12-21 03:17:06', '2024-12-22 00:59:40', 12, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `role` int NOT NULL,
  `username` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `password` varchar(250) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `role`, `username`, `email`, `password`, `created_at`, `token`) VALUES
(1, 1, 'EdupsGamingYT', 'tedbatallones2004@gmail.com', '$2y$10$KWY2zsFQgOvct78jRDCL2eczU7uHrKl56VE6.OqjEzRTdaGZihJmu', '2024-12-20 01:25:12', 'OThkYTE0YjcxNTY4ZGUxMDJkNTk4ODlkZjRkMzMwMDc5YzhmOWVlZDhjMzVkYmViYTc0NWFkMmQ1MWE1MjVjOQ=='),
(2, 1, 'BatmanForever2006', 'tdk2004@gmail.com', '$2y$10$DdJysIGYXlJsVV9APV4AL.c2I.ZkOnSAFH4oF5JOgkz/a0WB7qMq2', '2024-12-20 19:21:45', 'NWNmZjk4OGI5OTkwMDI4YmM1ZTc1YzllMTBiM2JhOTc2NjkyOTcwYWZhNGRlNTQ0MjY2YTMzMzljM2FhOTVjMw=='),
(3, 1, 'SuperGuy', 'TheDailyMan@gmail.com', '$2y$10$diwDUa3ZgSDNP7if7P.p9OPPzcErjikwCYjRS2UJMjlTjdM7iiy/O', '2024-12-20 22:58:50', 'MmJkMjRhMzlkMjcyMWYzMGY4OTA2MTVmZjc5NjU0OTE5ZTc1NWI2MzM4YjRlNDFiMTFiNzFhZjAxNmY2OWUwMw=='),
(4, 1, 'Vincent', 'BloodTalon@gmail.com', '$2y$10$OEHUk5zLLKDj6Kd8EQyr3.9yMWeRLYY3j.J0o6K6R7NJU1Mcm8JkO', '2024-12-21 00:49:06', 'NWMzMWU2YjBkOWI2OWU2NDQ2OTJkMDI4MzM0NjI3YmZkNWJhZGUyMDNjODdkYjQwNjE5M2M2MjJmNjhiNzdjNA=='),
(5, 0, 'FastGuy', 'FastestGuy@gmail.com', '$2y$10$1jR6bi/Ztvd9dasJJbuyKOkpIdYJHjU2SDFaGzD7.8pVaoElxUjKC', '2024-12-21 01:12:14', 'ZDczODRlODk3ZDlmMzczNmI1YjAwMGE5OTNlYzIyMzI4YzI3NWQzNzc0MDczNmI1NzE3Yzg4NDFmMDUwODQyMA=='),
(6, 0, 'LanternGuy', 'LanternGuy@gmail.com', '$2y$10$QvNLT.EGLqb97nwWiEB3nes3bHRZ3UqH2XegvfrlkfQ8uXBhwg7cO', '2024-12-21 01:13:09', 'ZmQ2YTBmYzJmM2E5YTcxYTQ2YzQxZmE0OGJlNzMxYmVlYzgxMTlkMmI3MTUwZGY4ZGI3NGRlY2NjNjI2MGYxZA=='),
(7, 0, 'WonderGal', 'WonderGal@gmail.com', '$2y$10$6siK8TvBWtc0qCcNQ6vSRuf6XQnMcfZpwUC41xHOY/aQU.d4tj50.', '2024-12-21 01:13:46', 'ODkxMjdhNTk2YWVjNzVlY2FmZTM5YWJmY2E1M2E3MTg0MWFmNDkxYzcxNGExMzEyNDcxZmM3NzhkYzFlMDc0YQ=='),
(8, 0, 'WaterGuy', 'AquaGuy@gmail.com', '$2y$10$CHqq4SYq6tg4uqdG5Y9R7uwV4rRYHd/yZ6KjJhN9GKxVwZi3GaNo2', '2024-12-21 01:16:10', 'MTA5Y2Q0YmRiZmIwYzhhYzRlYmM5Mzk4OTc0MWViZWVjMjY1YzdjZGY2ZTNhZDExYThjNzEyYmRlNzJlYzIzZA=='),
(9, 0, 'GreenAlien', 'GreenMartian@gmail.com', '$2y$10$gwmHucSayK2pxkpo3mN/a.prFXcuUeqCyiNFo9S9IRkCgf3lyeaDe', '2024-12-21 01:18:33', 'NDQ2MDNkZDA1NjYxYjc3MjM5MDJjMTBjYzRkYzEwMTUwZjdjOWFjZWNhMTk1YmM5YTlhYjYwYjE4YTY0ODcxMQ=='),
(10, 0, 'ShoutingLady', 'ShoutingCanary@gmail.com', '$2y$10$wkZeuWWK4dx.LXCseh4crOEf65vXHch4qmTNCGvjdeSRJkClfzzXq', '2024-12-21 01:20:15', 'NDIzYWY3MGNmNTBjNmM1NTU2ZGE3NjY3ZGFlNTk0NDE3ZGFlMzg2NjRjMzVhNDgzMDU2Y2EzODRlZjkzOTBiOA=='),
(11, 0, 'ArrowGuy', 'ArrowGreen@gmail.com', '$2y$10$IK5bOL8huSbXIsMYhEF8t.9HU9pScnmTbC6pOi.rACyaU1A4dgdMa', '2024-12-21 01:21:00', 'OWU5YTRlYTJjN2U5ZDQyMDZhMDhmODE1ZTJkNGJlMDc0YjgzZDE2YjJhZGMzZTc1MzhhYWRhYzk2YTc5ZDMzOA=='),
(12, 0, 'HalfRobGuy', 'ManAndRobot@gmail.com', '$2y$10$ffjDsBU6XLSHRkbX76rdUeKxqqOz6a1/ejPboJcF8lHytAN7qdJqO', '2024-12-21 01:24:00', 'YjkwMGQyNGU1YjM3NGNlZDFkZGM1NzMxODk4OTE4MTU3YWQyN2M1YTkwNzlkMjQ5YzllOTY3ZWIyZGY2YWRiMw=='),
(13, 0, 'TornadoGuy', 'MaroonTornado@gmail.com', '$2y$10$y/uzEAo0v5Prb9DAqIO/qOFNoh4ruCmZGyqgNEhfdKQRBp3OTTveC', '2024-12-21 01:24:56', 'YjViNzliZWMzM2QwNzVlNzZkMzQwYzcwOTBjMDUyZDRhMjYyN2IyNjAwOTIyZmUxNjc1ZTM0YzU5ODQ4YmI2Zg=='),
(14, 0, 'HawkGal', 'HawkWoman@gmail.com', '$2y$10$MLrTv8Y28nZ2SsLsDDc1xOgEhN63OAX/3035aSPPpdgyVeWp7mNh6', '2024-12-21 01:26:00', 'NDgzYmVlNzdhYjA1ZWRmMGNhZmRkMTkyYzY1YjUyNDEwNjFmOWJlOGQwMzFmMGZhMTA4NDIyZjIwNGYxMGJjOQ=='),
(15, 0, 'AcrobatGuy', 'DayWing@gmail.com', '$2y$10$qTX24avSS3/D0zQSOUn8D.LyKfC91f3/JHQD0a69i5kPNPou/wqMy', '2024-12-21 01:27:17', 'MTY2Y2U3ZDE3YTA4Mjk0ZmU2MWU3MmEzNTM0N2JiODQ2YTY2YjQzMTg2YzgwNTkzMmQ3M2JlMDgxNjgzOTYxZQ=='),
(16, 0, 'MetalMan', 'RichMan@gmail.com', '$2y$10$OJtv4.4/20TEiBgOLaQs5OgdimeupyzJ3F5bM3RH1nsgRhHOuCQja', '2024-12-21 01:30:33', 'NzRlNGNjNDVlNGM1ZTEwMDYxODFiYWEyNjBjMGY3NTYyOGRhYjkzZGNhZDMyZGYwZWJhN2FjNzAyNzliYTVmOQ=='),
(17, 0, 'FlagGuy', 'America@gmail.com', '$2y$10$m5EMKxfvzNJk5m38w8d65umFhCuB4pwNL7.5kVMOwAXH0TVS4J4bC', '2024-12-21 01:31:14', 'MzEyNmE3YWU0MDFhZjIyOTVhOWRhNmM4OTFjN2VkODM1ZDkzM2E4MmJjNWM3N2Y5OTljYzIzNWI5ZDRkYWM0NA=='),
(18, 0, 'HammerGuy', 'GodOfHammers@gmail.com', '$2y$10$CgLcdjCziw.woxv5jRlE0evE6DYgqdPEqMgfQTnUIdTo6RQfxMofq', '2024-12-21 01:32:06', 'NThiMDdlMmEwN2M0ZDQwYWI4ZjNlMzA3ZDZiYjg3ZWUzMTdiMzYyMDlhYWY0MjE0MWE5M2ExMjdhYmVkY2EzZA=='),
(19, 0, 'SpiderGuy', 'WebbyGuy@gmail.com', '$2y$10$9dE1mJZO12EUwIP9x4KYO.7SI7rKGDwzyQ/TvuQI1.Bh9Jz8ug1Ja', '2024-12-21 01:32:36', 'YzYwM2VmMmY0MWVmYzUzMTZhODQ1ODI2YTVkOThiZmE0ZTFhN2JkMmFlYzM4ZDNkOWNjM2NmNjE4YzczN2Y5Mw=='),
(20, 0, 'AngryGuy', 'JollyGreenGiant@gmail.com', '$2y$10$cDQo1o0wInf87C1GJ/82jubYOHj/q9w6U8yIiZQzTesCwHcqgTZtC', '2024-12-21 01:34:11', 'NzNkMDcxOWM4NTNlY2Q5YjU1MmU1ODFmMjIyMzAwNjYwYTdjNDU0YTJiZDQyZTJmYjlhYmVmMjVkMzM5YTRiYQ=='),
(21, 0, 'ClawGuy', 'Bub@gmail.com', '$2y$10$NUlAGqlwEbZBatMgqgL64uPY0JkkWcgrT5gsQlMjJasMo3vsPuZ/S', '2024-12-21 01:34:55', 'ZmMzM2YxMmY2NjA5ZmIyOWU1NDJlYWJhMWQ1YzNjNTJiN2NlMGI0ZjlkOTg2ZTU5ODg2OTNlODkwYzVhOWJlNw=='),
(22, 0, 'MoonGuy', 'KnightGuy@gmail.com', '$2y$10$SBI.g3VfBnE3I3/vtvsPn.lS2chHKrY/Kw.wlqCj54cdUC12SEFQ6', '2024-12-21 01:35:29', 'M2RhNjcxZDExZTc2NzZhNzhmN2MzYWM5NTUyZGE2Yjc3MzZlZTY2YWI1MzhlZThkZDQ4MGY1MDU5N2U1MWQ3Mg=='),
(23, 0, 'WidowGal', 'SpyGal@gmail.com', '$2y$10$17nSJdhAq.WvGX5lwu/4HO2qlFZAlH81UfROmtGInl8YLUdGJi87C', '2024-12-21 01:35:55', 'OWU1N2VhZjI5ZTZlNGYxMmEyZjk4YjFlNDA0ZDI1NTRmNmY4OTU5MGIyNmQyNDFlOWQ4NzlkYzU1ZDg4YmNkNQ=='),
(24, 0, 'TinMan', 'ChhersTinMan@gmail.com', '$2y$10$7GMVceSr.7qIfHglSxiGLOmKXgk7rlH4tr4IYusovPkZJ6whYdBky', '2024-12-21 01:36:30', 'NThmMTBiNzEyNmNjNGQ0OWNiNDBhNjRlY2Q2Zjc1NGVhNGNmY2NjODU5Zjk0MzBkYzc4NmI2YjAwMGVmYmI1OQ=='),
(25, 0, 'DeadGuy', 'MercMouth@gmail.com', '$2y$10$lld957a8A/CAsYf5Lj9iOuB2sLNUYGtrO8lF6dbtFuiCpG.Pv8Tu2', '2024-12-21 01:37:30', 'NGZmMWE2ZTRkMzYwNzNhMTMxMWI3ODg5YjI5YjUwYTFmZTIyMGU4NzU4NTIyNDBiY2MwYmFiYWU2YzYxM2U5Nw=='),
(26, 0, 'Vince', 'tedbatallones2004@gmail.com', '$2y$10$0fMriClc91MxPInmdGt9VOBhc2Lh4JzwKNXZephvG40mLx2HKi0va', '2024-12-21 02:58:32', 'MjhhZWI3YjQxOTc2NTYxMDIzMDIyZDc1YmI0NDcwOGRjMzZmZGZhZGFiNzBhYzFiYzdiODZhMjM1ZjRiZjU2Mw=='),
(27, 0, 'Vince', 'tedbatallones2004@gmail.com', '$2y$10$rxtUuOgo9UoaPpVZ2xSJxePaS/Z7SAL.c5FT1wHnDI2UYyEz2Lk4e', '2024-12-21 03:03:15', 'MjhhZWI3YjQxOTc2NTYxMDIzMDIyZDc1YmI0NDcwOGRjMzZmZGZhZGFiNzBhYzFiYzdiODZhMjM1ZjRiZjU2Mw==');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `post_ibfk_3` FOREIGN KEY (`post_post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `userId_ibfk_3` FOREIGN KEY (`user_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
