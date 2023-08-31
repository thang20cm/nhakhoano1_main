-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2023 at 04:23 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flutter_app`
--

-- --------------------------------------------------------

--
-- Table structure for table `phieumaymoc`
--

CREATE TABLE `phieumaymoc` (
  `idPhieumaymoc` int(11) NOT NULL,
  `ngayNhapPhieu` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phieumaymoc`
--

INSERT INTO `phieumaymoc` (`idPhieumaymoc`, `ngayNhapPhieu`) VALUES
(2, '4/8/2023'),
(3, '4/8/2023'),
(4, '4/8/2023'),
(5, '4/8/2023'),
(6, '5/8/2023'),
(7, '4/8/2023');

-- --------------------------------------------------------

--
-- Table structure for table `sudungmaymoc`
--

CREATE TABLE `sudungmaymoc` (
  `idMayMoc` int(11) NOT NULL,
  `tenMayMoc` varchar(255) NOT NULL,
  `tinhTrang` varchar(255) NOT NULL,
  `tonDaungay` char(255) NOT NULL,
  `khachHangMaSo` varchar(255) NOT NULL,
  `soluongSudung` int(11) NOT NULL,
  `conlaiCuoiNgay` char(255) NOT NULL,
  `tinhtrangCuoiNgay` varchar(255) NOT NULL,
  `ngayNhapPhieu` varchar(255) NOT NULL,
  `idPhieumaymoc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sudungmaymoc`
--

INSERT INTO `sudungmaymoc` (`idMayMoc`, `tenMayMoc`, `tinhTrang`, `tonDaungay`, `khachHangMaSo`, `soluongSudung`, `conlaiCuoiNgay`, `tinhtrangCuoiNgay`, `ngayNhapPhieu`, `idPhieumaymoc`) VALUES
(10, 'ACER Nitro5', 'Binh thuong', '1', 'Thang-Pro', 1, '1', 'Binh thuong', '8/7/2023', 4);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `uid` int(11) NOT NULL,
  `uname` varchar(255) NOT NULL,
  `uemail` varchar(255) NOT NULL,
  `upassword` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`uid`, `uname`, `uemail`, `upassword`) VALUES
(2, 'DuongThang', 'a@gmail.com', 'a'),
(3, 'DuongThang1', 'b@gmail.com', 'a'),
(4, 'Duongthang3', 'c@gmail.com', 'a'),
(5, 'DuongThang4', 'd@gmail.com', 'a');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `phieumaymoc`
--
ALTER TABLE `phieumaymoc`
  ADD PRIMARY KEY (`idPhieumaymoc`);

--
-- Indexes for table `sudungmaymoc`
--
ALTER TABLE `sudungmaymoc`
  ADD PRIMARY KEY (`idMayMoc`),
  ADD KEY `sdf` (`idPhieumaymoc`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `phieumaymoc`
--
ALTER TABLE `phieumaymoc`
  MODIFY `idPhieumaymoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sudungmaymoc`
--
ALTER TABLE `sudungmaymoc`
  MODIFY `idMayMoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sudungmaymoc`
--
ALTER TABLE `sudungmaymoc`
  ADD CONSTRAINT `sdf` FOREIGN KEY (`idPhieumaymoc`) REFERENCES `phieumaymoc` (`idPhieumaymoc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
