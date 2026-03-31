-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 27, 2021 at 07:06 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `BD01_2122_1S_A`
--
DROP DATABASE IF EXISTS `BD01_2122_1S_A`;
CREATE DATABASE IF NOT EXISTS `BD01_2122_1S_A` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `BD01_2122_1S_A`;

-- --------------------------------------------------------

--
-- Table structure for table `contrat`
--

DROP TABLE IF EXISTS `contrat`;
CREATE TABLE `contrat` (
  `IdFilm` int(11) NOT NULL,
  `IdMetier` int(11) NOT NULL,
  `IdTechnicien` int(11) NOT NULL,
  `NbJours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contrat`
--

INSERT INTO `contrat` (`IdFilm`, `IdMetier`, `IdTechnicien`, `NbJours`) VALUES
(1, 1, 2, 5),
(1, 2, 1, 3),
(1, 2, 2, 2),
(2, 1, 4, 3),
(2, 2, 2, 2),
(2, 3, 2, 1),
(2, 4, 2, 1),
(2, 4, 3, 2),
(2, 6, 5, 2),
(3, 4, 2, 7),
(3, 6, 3, 10),
(4, 1, 2, 2),
(4, 2, 2, 3),
(4, 2, 4, 3);

-- --------------------------------------------------------

--
-- Table structure for table `film`
--

DROP TABLE IF EXISTS `film`;
CREATE TABLE `film` (
  `IdFilm` int(11) NOT NULL,
  `Titre` varchar(45) DEFAULT NULL,
  `AnneeProd` int(11) DEFAULT NULL,
  `Budget` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `film`
--

INSERT INTO `film` (`IdFilm`, `Titre`, `AnneeProd`, `Budget`) VALUES
(1, 'Petit Budget', 2016, 1000),
(2, 'Moyen Budget', 2019, 5000),
(3, 'Gros Budget', 2018, 15000),
(4, 'Court Métrage', 2017, 1500);

-- --------------------------------------------------------

--
-- Table structure for table `metier`
--

DROP TABLE IF EXISTS `metier`;
CREATE TABLE `metier` (
  `IdMetier` int(11) NOT NULL,
  `Nom` varchar(45) DEFAULT NULL,
  `PrixHeure` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `metier`
--

INSERT INTO `metier` (`IdMetier`, `Nom`, `PrixHeure`) VALUES
(1, 'Montage Son', 40),
(2, 'Prise Son', 30),
(3, 'Mixage Son', 40),
(4, 'Cameraman', 35),
(5, 'Assistant réalisateur', 50),
(6, 'Réalisateur', 60);

-- --------------------------------------------------------

--
-- Table structure for table `technicien`
--

DROP TABLE IF EXISTS `technicien`;
CREATE TABLE `technicien` (
  `IdTechnicien` int(11) NOT NULL,
  `Nom` varchar(45) DEFAULT NULL,
  `Nat` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `technicien`
--

INSERT INTO `technicien` (`IdTechnicien`, `Nom`, `Nat`) VALUES
(1, 'Alain', 'Fr'),
(2, 'Marina', 'Be'),
(3, 'Amid', 'Ma'),
(4, 'Ingrid', 'Be'),
(5, 'Steven', 'Us');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contrat`
--
ALTER TABLE `contrat`
  ADD PRIMARY KEY (`IdFilm`,`IdMetier`,`IdTechnicien`);

--
-- Indexes for table `film`
--
ALTER TABLE `film`
  ADD PRIMARY KEY (`IdFilm`);

--
-- Indexes for table `metier`
--
ALTER TABLE `metier`
  ADD PRIMARY KEY (`IdMetier`);

--
-- Indexes for table `technicien`
--
ALTER TABLE `technicien`
  ADD PRIMARY KEY (`IdTechnicien`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contrat`
--
ALTER TABLE `contrat`
  ADD CONSTRAINT `contrat_ibfk_1` FOREIGN KEY (`IdFilm`) REFERENCES `film` (`IdFilm`),
  ADD CONSTRAINT `contrat_ibfk_2` FOREIGN KEY (`IdMetier`) REFERENCES `metier` (`IdMetier`),
  ADD CONSTRAINT `contrat_ibfk_3` FOREIGN KEY (`IdTechnicien`) REFERENCES `technicien` (`IdTechnicien`);

create index contrat_ibfk_1
    on contrat (IdFilm);

COMMIT;

SET GLOBAL SQL_MODE = CONCAT(@@SQL_MODE, ',ONLY_FULL_GROUP_BY');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
