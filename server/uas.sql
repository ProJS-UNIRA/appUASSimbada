-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jan 11, 2023 at 03:51 AM
-- Server version: 10.10.2-MariaDB-1:10.10.2+maria~ubu2204
-- PHP Version: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `uas`
--

-- --------------------------------------------------------

--
-- Table structure for table `jawaban`
--

CREATE TABLE `jawaban` (
  `id` int(11) NOT NULL,
  `soal` int(11) DEFAULT NULL,
  `nim` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jawaban`
--

INSERT INTO `jawaban` (`id`, `soal`, `nim`) VALUES
(1, 1, '2022630035'),
(2, 1, '2021520033'),
(3, 2, '2021520033'),
(4, 3, '2021520033'),
(5, 4, '2021520033');

-- --------------------------------------------------------

--
-- Table structure for table `soal`
--

CREATE TABLE `soal` (
  `id` int(11) NOT NULL,
  `soal` text DEFAULT NULL,
  `jawaban` text DEFAULT NULL,
  `output` text DEFAULT NULL,
  `bobot` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soal`
--

INSERT INTO `soal` (`id`, `soal`, `jawaban`, `output`, `bobot`) VALUES
(1, 'BASIC::Tulis kueri SQL untuk mengetahui kapan film \'American Beauty\' dirilis. Kembalikan tahun rilis film', 'SELECT film_tahun FROM film WHERE film_judul = \'American Beauty\'', '[{\"film_tahun\":1999}]', 1),
(2, 'BASIC::Tulis kueri SQL untuk menemukan judul dan tahun film. Kembalikan judul film, tahun  film', 'SELECT film_judul, film_tahun FROM film', '[{\"film_judul\":\"Vertigo\",\"film_tahun\":1958},{\"film_judul\":\"The Innocents\",\"film_tahun\":1961},{\"film_judul\":\"Lawrence of Arabia\",\"film_tahun\":1962},{\"film_judul\":\"The Deer Hunter\",\"film_tahun\":1978},{\"film_judul\":\"Amadeus\",\"film_tahun\":1984},{\"film_judul\":\"Blade Runner\",\"film_tahun\":1982},{\"film_judul\":\"Eyes Wide Shut\",\"film_tahun\":1999},{\"film_judul\":\"The Usual Suspects\",\"film_tahun\":1995},{\"film_judul\":\"Chinatown\",\"film_tahun\":1974},{\"film_judul\":\"Boogie Nights\",\"film_tahun\":1997},{\"film_judul\":\"Annie Hall\",\"film_tahun\":1977},{\"film_judul\":\"Princess Mononoke\",\"film_tahun\":1997},{\"film_judul\":\"The Shawshank Redemption\",\"film_tahun\":1994},{\"film_judul\":\"American Beauty\",\"film_tahun\":1999},{\"film_judul\":\"Titanic\",\"film_tahun\":1997},{\"film_judul\":\"Good Will Hunting\",\"film_tahun\":1997},{\"film_judul\":\"Deliverance\",\"film_tahun\":1972},{\"film_judul\":\"Trainspotting\",\"film_tahun\":1996},{\"film_judul\":\"The Prestige\",\"film_tahun\":2006},{\"film_judul\":\"Donnie Darko\",\"film_tahun\":2001},{\"film_judul\":\"Slumdog Millionaire\",\"film_tahun\":2008},{\"film_judul\":\"Aliens\",\"film_tahun\":1986},{\"film_judul\":\"Beyond the Sea\",\"film_tahun\":2004},{\"film_judul\":\"Avatar\",\"film_tahun\":2009},{\"film_judul\":\"Braveheart\",\"film_tahun\":1995},{\"film_judul\":\"Seven Samurai\",\"film_tahun\":1954},{\"film_judul\":\"Spirited Away\",\"film_tahun\":2001},{\"film_judul\":\"Back to the Future\",\"film_tahun\":1985}]', 1),
(3, 'BASIC::Tulis kueri SQL untuk menemukan film yang dirilis pada tahun 1999. Kembalikan judul film', 'SELECT film_judul FROM film WHERE film_tahun = 1999', '[{\"film_judul\":\"Eyes Wide Shut\"},{\"film_judul\":\"American Beauty\"}]', 1),
(4, 'BASIC::Tulis kueri SQL untuk menemukan film yang dirilis sebelum tahun 1998. Kembalikan judul film', 'SELECT film_judul FROM film WHERE film_tahun < 1998', '[{\"film_judul\":\"Vertigo\"},{\"film_judul\":\"The Innocents\"},{\"film_judul\":\"Lawrence of Arabia\"},{\"film_judul\":\"The Deer Hunter\"},{\"film_judul\":\"Amadeus\"},{\"film_judul\":\"Blade Runner\"},{\"film_judul\":\"The Usual Suspects\"},{\"film_judul\":\"Chinatown\"},{\"film_judul\":\"Boogie Nights\"},{\"film_judul\":\"Annie Hall\"},{\"film_judul\":\"Princess Mononoke\"},{\"film_judul\":\"The Shawshank Redemption\"},{\"film_judul\":\"Titanic\"},{\"film_judul\":\"Good Will Hunting\"},{\"film_judul\":\"Deliverance\"},{\"film_judul\":\"Trainspotting\"},{\"film_judul\":\"Aliens\"},{\"film_judul\":\"Braveheart\"},{\"film_judul\":\"Seven Samurai\"},{\"film_judul\":\"Back to the Future\"}]', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jawaban`
--
ALTER TABLE `jawaban`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jawaban_FK` (`soal`);

--
-- Indexes for table `soal`
--
ALTER TABLE `soal`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `jawaban`
--
ALTER TABLE `jawaban`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `soal`
--
ALTER TABLE `soal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jawaban`
--
ALTER TABLE `jawaban`
  ADD CONSTRAINT `jawaban_FK` FOREIGN KEY (`soal`) REFERENCES `soal` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
