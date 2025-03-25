-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 25, 2025 at 06:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` varchar(20) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `transaction_id` varchar(100) NOT NULL,
  `booking_status` enum('pending','confirmed','cancelled') NOT NULL DEFAULT 'pending',
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `schedule_id`, `total_amount`, `payment_method`, `transaction_id`, `booking_status`, `booking_date`, `user_id`) VALUES
('BK17427260422487', 22, 1800.00, '', '', 'cancelled', '2025-03-23 10:34:02', NULL),
('BK17427485976753', 22, 900.00, '', '', 'confirmed', '2025-03-23 16:49:57', NULL),
('BK17427496026071', 22, 900.00, '', '', 'confirmed', '2025-03-23 17:06:42', NULL),
('BK17427676135169', 22, 650.00, '', '', 'confirmed', '2025-03-23 22:06:53', NULL),
('BK17427953308107', 22, 650.00, '', '', 'confirmed', '2025-03-24 05:48:50', NULL),
('BK17428067891565', 22, 650.00, '', '', 'confirmed', '2025-03-24 08:59:49', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `buses`
--

CREATE TABLE `buses` (
  `id` int(11) NOT NULL,
  `bus_name` varchar(100) NOT NULL,
  `bus_number` varchar(20) NOT NULL,
  `bus_type` varchar(50) NOT NULL,
  `total_seats` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buses`
--

INSERT INTO `buses` (`id`, `bus_name`, `bus_number`, `bus_type`, `total_seats`) VALUES
(1, 'Chakra Travels', 'TN-01-AB-1234', 'AC Sleeper', 40),
(2, 'Sri Keerthana Travels', 'TN-02-CD-5678', 'AC Sleeper', 40),
(3, 'Rajalakshmi Travels', 'TN-03-EF-9012', 'Non-AC Seater', 50),
(4, 'chakra travels', 'TN-72-AB-1234', 'AC', 0),
(5, 'Srivalli Travels', 'TN-72-AB-1235', 'Non-AC', 0);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `name`, `rating`, `comment`, `created_at`) VALUES
(1, 'priya', 3, 'This website is very easy to book bus tickets even in the last minute.', '2025-03-23 16:19:11'),
(2, 'Govril', 5, 'i Love this website', '2025-03-23 17:07:33');

-- --------------------------------------------------------

--
-- Table structure for table `passenger_details`
--

CREATE TABLE `passenger_details` (
  `id` int(11) NOT NULL,
  `booking_id` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `seat_number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passenger_details`
--

INSERT INTO `passenger_details` (`id`, `booking_id`, `name`, `age`, `gender`, `seat_number`) VALUES
(1, 'BK17427260422487', 'priya', 20, 'female', 35),
(2, 'BK17427260422487', 'subra', 25, 'male', 36),
(3, 'BK17427485976753', 'priya', 20, 'female', 31),
(4, 'BK17427496026071', 'Govril', 20, 'male', 32),
(5, 'BK17427676135169', 'Riya', 20, 'female', 4),
(6, 'BK17427953308107', 'Priya', 20, 'female', 7),
(7, 'BK17428067891565', 'hariprakash', 20, 'male', 12);

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  `route_from` varchar(100) NOT NULL,
  `route_to` varchar(100) NOT NULL,
  `travel_date` date NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time NOT NULL,
  `sleeper_seats` int(11) NOT NULL DEFAULT 20,
  `seater_seats` int(11) NOT NULL DEFAULT 30,
  `available_sleeper` int(11) NOT NULL,
  `available_seater` int(11) NOT NULL,
  `sleeper_price` decimal(10,2) NOT NULL,
  `seater_price` decimal(10,2) NOT NULL,
  `status` enum('active','completed','cancelled') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `bus_id`, `route_from`, `route_to`, `travel_date`, `departure_time`, `arrival_time`, `sleeper_seats`, `seater_seats`, `available_sleeper`, `available_seater`, `sleeper_price`, `seater_price`, `status`) VALUES
(22, 4, 'Tirunelveli', 'Coimbatore', '2025-03-31', '22:00:00', '05:00:00', 20, 30, 0, 0, 900.00, 650.00, 'active'),
(23, 5, 'Tirunelveli', 'Coimbatore', '2025-04-01', '23:00:00', '06:00:00', 20, 30, 0, 0, 800.00, 650.00, 'active');

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `seat_number` varchar(10) NOT NULL,
  `status` enum('available','booked') DEFAULT 'available',
  `booking_id` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'priya', 'priya@gmail.com', '$2y$10$2EyJxxnTD89HIpx6Y2TtWe6k.VWzLWB25Oqfcq8I4a.MpRgWogWdm', '2025-03-23 09:38:55'),
(2, 'Govril', 'Govirl@gmail.com', '$2y$10$sRQ8bML/1ITPnox3cRF91eQBIQvlzCWgfw3Iqlv3zkV7yhZwJm8IO', '2025-03-23 17:05:32'),
(3, 'hari', 'hariprakash3131@gmail.com', '$2y$10$WSsyloMg228oIgDb4Tc0/us3qKr8mqIdPbtmSFUBU0a5rxGEUTk9O', '2025-03-24 08:56:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `schedule_id` (`schedule_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `passenger_details`
--
ALTER TABLE `passenger_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bus_id` (`bus_id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schedule_id` (`schedule_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `buses`
--
ALTER TABLE `buses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `passenger_details`
--
ALTER TABLE `passenger_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `passenger_details`
--
ALTER TABLE `passenger_details`
  ADD CONSTRAINT `passenger_details_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`) ON DELETE CASCADE;

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_ibfk_1` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`),
  ADD CONSTRAINT `seats_ibfk_2` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`booking_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
