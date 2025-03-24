-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 23, 2025 at 02:40 PM
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
-- Database: `libtrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `verification_code` int(6) DEFAULT NULL,
  `verification_code_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `username`, `password`, `email`, `created_at`, `verification_code`, `verification_code_expiry`) VALUES
(2, 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'esperanzagabrieljose@gmail.com', '2025-02-01 12:49:31', 101573, '2025-03-18 20:18:31');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `entry_time` varchar(50) NOT NULL,
  `day` varchar(10) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `student_id`, `entry_time`, `day`, `department`) VALUES
(227, '03-2324-012345', 'March 8, 2025, 9:52 pm', 'Saturday', 'CAHS'),
(228, '03-2324-032803', 'March 18, 2025, 6:59 pm', 'Tuesday', 'College of Information Technology Education (CITE)'),
(229, '03-2324-032803', 'March 18, 2025, 6:59 pm', 'Tuesday', 'College of Information Technology Education (CITE)'),
(230, '03-2324-032803', 'March 19, 2025, 8:59 pm', 'Wednesday', 'CITE'),
(231, '03-2324-032803', 'March 20, 2025, 3:01 pm', 'Thursday', 'CITE'),
(232, '03-2324-032803', 'March 20, 2025, 3:01 pm', 'Thursday', 'CITE'),
(233, '03-2324-032803', 'March 20, 2025, 3:01 pm', 'Thursday', 'CITE'),
(234, '03-2324-032803', 'March 20, 2025, 3:01 pm', 'Thursday', 'CITE'),
(235, '03-2324-032803', 'March 20, 2025, 3:02 pm', 'Thursday', 'CITE'),
(236, '03-2324-032803', 'March 20, 2025, 3:36 pm', 'Thursday', 'CITE'),
(237, '03-2324-032803', 'March 20, 2025, 3:36 pm', 'Thursday', 'CITE'),
(238, '03-2324-032803', 'March 21, 2025, 2:16 pm', 'Friday', 'CITE'),
(239, '03-2324-032803', 'March 21, 2025, 9:18 pm', 'Friday', 'CITE'),
(240, '03-2324-032803', 'March 21, 2025, 9:18 pm', 'Friday', 'CITE'),
(241, '03-2324-032803', 'March 21, 2025, 9:18 pm', 'Friday', 'CITE'),
(242, '03-2324-032803', 'March 21, 2025, 9:38 pm', 'Friday', 'CITE'),
(243, '03-2324-032803', 'March 21, 2025, 9:38 pm', 'Friday', 'CITE'),
(244, '03-2324-032803', 'March 21, 2025, 9:38 pm', 'Friday', 'CITE'),
(245, '03-2324-032803', 'March 21, 2025, 9:38 pm', 'Friday', 'CITE'),
(246, '03-2324-032803', 'March 21, 2025, 9:45 pm', 'Friday', 'CITE'),
(247, '03-2324-032803', 'March 21, 2025, 9:45 pm', 'Friday', 'CITE'),
(248, '03-2324-032803', 'March 21, 2025, 9:45 pm', 'Friday', 'CITE'),
(249, '03-2324-032803', 'March 21, 2025, 9:45 pm', 'Friday', 'CITE'),
(250, '03-2324-032803', 'March 21, 2025, 9:45 pm', 'Friday', 'CITE'),
(251, '03-2324-032803', 'March 21, 2025, 9:46 pm', 'Friday', 'CITE'),
(252, '03-2324-036622', 'March 21, 2025, 9:48 pm', 'Friday', 'CCJE'),
(253, '03-2324-036622', 'March 21, 2025, 9:48 pm', 'Friday', 'CCJE'),
(254, '03-2324-036622', 'March 21, 2025, 9:49 pm', 'Friday', 'CCJE'),
(255, '03-2324-036622', 'March 21, 2025, 9:52 pm', 'Friday', 'CCJE'),
(256, '03-2324-036622', 'March 21, 2025, 9:56 pm', 'Friday', 'CCJE');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL COMMENT 'Unique ID for each book.',
  `title` varchar(255) NOT NULL COMMENT 'Title of the book.',
  `author` varchar(255) NOT NULL COMMENT 'Author of the book.',
  `description` varchar(255) NOT NULL,
  `book_code` varchar(99) NOT NULL COMMENT 'ISBN number of the book',
  `copies_available` int(11) NOT NULL COMMENT 'Number of available copies.',
  `total_copies` int(11) NOT NULL COMMENT 'Total number of copies.',
  `department` varchar(255) NOT NULL COMMENT 'Department where it belong',
  `category` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `pdf_url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Date book was added.'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_id`, `title`, `author`, `description`, `book_code`, `copies_available`, `total_copies`, `department`, `category`, `image_url`, `pdf_url`, `created_at`) VALUES
(1, 'Abnormal Psychology (8th Edition)', 'Susan Nolen-Hoeksema', '', 'PSY-001', 3, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/1.png', '', '2025-03-18 05:01:27'),
(2, 'Abnormal Psychology (11th Edition)', 'Ronald J. Comer and Jonathan S. Comer', '', 'PSY-002', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/2.png', '', '2025-03-18 05:01:27'),
(3, 'Abnormal Psychology (9th Edition)', 'Susan Krauss Whitbourne', '', 'PSY-003', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/3.png', '', '2025-03-18 05:01:27'),
(4, 'Abnormal Psychology (6th Edition)', 'David J. A. Dozois', '', 'PSY-004', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/4.png', '', '2025-03-18 05:01:27'),
(5, 'Case Analyses for Abnormal Psychology (2nd Edition)', 'Randall E. Osborne, Joan Esterline Lafuze, and David V. Perkins', '', 'PSY-005', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/5.png', '', '2025-03-18 05:01:27'),
(6, 'Abnormal Psychology and Life (3rd Edition)', 'Christopher A. Kearney and Timothy J. Trull', '', 'PSY-006', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/6.png', '', '2025-03-18 05:01:27'),
(7, 'DSM-5-TR', 'Carman S. Gill, Stephanie F. Dailey, Shannon L. Karl, and Casey A. Barrio Minton', '', 'PSY-007', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/7.png', '', '2025-03-18 05:01:27'),
(8, 'Case Studies in Abnormal Psychology (2nd Edition)', 'Ethan E. Gorenstein and Ronald J. Comer', '', 'PSY-008', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/8.png', '', '2025-03-18 05:01:27'),
(9, 'Nolen-Hoeksema\'s Abnormal Psychology', 'Heather Jennings', '', 'PSY-009', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/9.png', '', '2025-03-18 05:01:27'),
(10, 'Biochemistry (7th Edition)', 'Reginald H. Garrett and Charles M. Grisham', '', 'BIO-001', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/10.png', '', '2025-03-18 05:02:51'),
(11, 'Biochemistry: Fundamentals and Bioenergetics', 'Meera Yadav and Hardeo Singh Yadav', '', 'BIO-002', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/11.png', '', '2025-03-18 05:02:51'),
(12, 'Biochemistry and its Application', 'Papita H. Gourkhede', '', 'BIO-003', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/12.png', '', '2025-03-18 05:02:51'),
(13, 'Harper\'s Illustrated Biochemistry (32nd Edition)', 'Peter J. Kennelly, Kathleen M. Botham, Owen McGuinness, Victor W. Rodwell, and P. Anthony Weil', '', 'BIO-004', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/13.png', '', '2025-03-18 05:02:51'),
(14, 'Human Biochemistry (2nd Edition)', 'Gerald Litwack', '', 'BIO-005', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/14.png', '', '2025-03-18 05:02:51'),
(15, 'Key Concepts in Biochemistry', 'Abeer Iqbal', '', 'BIO-006', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/15.png', '', '2025-03-18 05:02:51'),
(16, 'An Introduction to Applied Behavioral Neuroscience', 'Laura A. Freberg', '', 'PSY-010', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/16.png', '', '2025-03-18 05:08:49'),
(17, 'Biological Psychology (2nd Edition)', 'Suzanne Higgs, Alison Cooper, and Jonathan Lee', '', 'PSY-011', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/17.png', '', '2025-03-18 05:08:49'),
(18, 'Biological Psychology', 'Kelly Lambert', '', 'PSY-012', 5, 10, 'CAHS', 'Psychology', 'http://192.168.1.248/LibTrack/libtracker/book_images/18.png', '', '2025-03-18 05:08:49'),
(19, 'Brain & Behavior: An Introduction to Biological Psychology (4th Edition)', 'Bob Garrett', '', 'PSY-013', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:08:49'),
(20, 'Discovering Behavioral Neuroscience: An Introduction to Biological Psychology', 'Laura A. Freberg', '', 'PSY-014', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:08:49'),
(21, 'Clinical Psychology: A Modern Health Profession', 'Wolfgang Linden and Paul L. Hewitt', '', 'PSY-015', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42'),
(22, 'Clinical Psychology and Cognitive Behavioral Psychotherapy', 'Stavroula Rakitzi', '', 'PSY-016', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42'),
(23, 'Clinical Psychology for Trainees (3rd Edition)', 'Andrew C. Page, Werner G. K. Stritzke, and Peter M. McEvoy', '', 'PSY-017', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42'),
(24, 'Clinical Psychology: Science, Practice, and Diversity', 'Andrew M. Pomerantz', '', 'PSY-018', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42'),
(25, 'Introduction to Clinical Psychology: Bridging Science and Practice (9th Edition)', 'Douglas A. Bernstein, Bethany A. Teachman, Bunmi O. Olatunji, and Scott O. Lilienfeld', '', 'PSY-019', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42'),
(26, 'Introduction to Clinical Psychology (4th Canadian Edition)', 'Catherine M. Lee and John Hunsley', '', 'PSY-020', 5, 10, 'CAHS', 'Psychology', '', '', '2025-03-18 05:09:42');

-- --------------------------------------------------------

--
-- Table structure for table `borrow`
--

CREATE TABLE `borrow` (
  `transaction_id` int(11) NOT NULL,
  `student_id` varchar(255) NOT NULL,
  `book_code` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `borrowed_date` varchar(255) NOT NULL,
  `due_date` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `server_time` varchar(255) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrow`
--

INSERT INTO `borrow` (`transaction_id`, `student_id`, `book_code`, `title`, `borrowed_date`, `due_date`, `status`, `server_time`) VALUES
(60, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '18 Mar 2025, 13:25:58', '25 Mar 2025, 13:25:58', 'Returned', '2025-03-18 13:26:21'),
(64, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '19 Mar 2025, 15:48:57', '26 Mar 2025, 15:48:57', 'Returned', '2025-03-19 15:49:23'),
(65, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '19 Mar 2025, 15:56:41', '26 Mar 2025, 15:56:41', 'Returned', '2025-03-19 15:57:07'),
(66, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '19 Mar 2025, 16:11:27', '26 Mar 2025, 16:11:27', 'Returned', '2025-03-19 16:11:53'),
(67, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '19 Mar 2025, 16:12:36', '26 Mar 2025, 16:12:36', 'Returned', '2025-03-19 16:13:02'),
(68, '03-2324-032803', 'PSY-002', 'Abnormal Psychology (11th Edition)', '19 Mar 2025, 16:20:20', '26 Mar 2025, 16:20:20', 'Returned', '2025-03-19 16:20:45'),
(69, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '19 Mar 2025, 16:24:00', '26 Mar 2025, 16:24:00', 'Returned', '2025-03-19 16:24:26'),
(70, '03-2324-032803', 'PSY-009', 'Nolen-Hoeksema\'s Abnormal Psychology', '19 Mar 2025, 16:24:49', '26 Mar 2025, 16:24:49', 'Returned', '2025-03-19 16:25:15'),
(71, '03-2324-032803', 'PSY-007', 'DSM-5-TR', '19 Mar 2025, 16:44:53', '26 Mar 2025, 16:44:53', 'Returned', '2025-03-19 16:45:18'),
(72, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '19 Mar 2025, 21:03:30', '26 Mar 2025, 21:03:30', 'Returned', '2025-03-19 21:03:56'),
(73, '03-2324-032803', 'PSY-002', 'Abnormal Psychology (11th Edition)', '19 Mar 2025, 21:03:36', '26 Mar 2025, 21:03:36', 'Returned', '2025-03-19 21:04:04'),
(74, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '19 Mar 2025, 21:09:47', '26 Mar 2025, 21:09:47', 'Returned', '2025-03-19 21:10:14'),
(75, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '20 Mar 2025, 13:59:30', '27 Mar 2025, 13:59:30', 'Returned', '2025-03-20 13:59:59'),
(76, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '20 Mar 2025, 14:00:03', '27 Mar 2025, 14:00:03', 'Returned', '2025-03-20 14:00:33'),
(77, '03-2324-032803', 'PSY-008', 'Case Studies in Abnormal Psychology (2nd Edition)', '20 Mar 2025, 14:00:22', '27 Mar 2025, 14:00:22', 'Returned', '2025-03-20 14:01:31'),
(78, '03-2324-032803', 'PSY-002', 'Abnormal Psychology (11th Edition)', '20 Mar 2025, 14:02:20', '27 Mar 2025, 14:02:20', 'Returned', '2025-03-20 14:02:47'),
(79, '03-2324-032803', 'PSY-003', 'Abnormal Psychology (9th Edition)', '20 Mar 2025, 14:02:43', '27 Mar 2025, 14:02:43', 'Returned', '2025-03-20 14:03:10'),
(80, '03-2324-032803', 'PSY-006', 'Abnormal Psychology and Life (3rd Edition)', '20 Mar 2025, 15:07:06', '27 Mar 2025, 15:07:06', 'Returned', '2025-03-20 15:07:39'),
(81, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '20 Mar 2025, 15:11:47', '27 Mar 2025, 15:11:47', 'Returned', '2025-03-20 15:12:17'),
(82, '03-2324-032803', 'PSY-002', 'Abnormal Psychology (11th Edition)', '20 Mar 2025, 15:11:55', '27 Mar 2025, 15:11:55', 'Returned', '2025-03-20 15:12:23'),
(83, '03-2324-123123', 'PSY-001', 'Abnormal Psychology (8th Edition)', '20 Mar 2025, 15:36:22', '27 Mar 2025, 15:36:22', 'Returned', '2025-03-20 15:36:52'),
(84, '03-2324-123123', 'PSY-001', 'Abnormal Psychology (8th Edition)', '20 Mar 2025, 15:57:56', '27 Mar 2025, 15:57:56', 'Returned', '2025-03-20 15:58:35'),
(85, '03-2324-123123', 'PSY-002', 'Abnormal Psychology (11th Edition)', '20 Mar 2025, 15:58:40', '27 Mar 2025, 15:58:40', 'Returned', '2025-03-20 15:59:08'),
(86, '03-2324-032803', 'PSY-001', 'Abnormal Psychology (8th Edition)', '21 Mar 2025, 21:20:31', '28 Mar 2025, 21:20:31', 'Borrowed', '2025-03-21 21:21:01'),
(87, '03-2324-036622', 'PSY-001', 'Abnormal Psychology (8th Edition)', '21 Mar 2025, 21:47:27', '28 Mar 2025, 21:47:27', 'Borrowed', '2025-03-21 21:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `status` enum('unread','read') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `staff_idNum` varchar(255) NOT NULL,
  `staff_first_name` varchar(255) NOT NULL,
  `staff_last_name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `phinmaed_email` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_idNum`, `staff_first_name`, `staff_last_name`, `position`, `phinmaed_email`, `status`) VALUES
(1, '0', 'John', 'Doe', 'Library Assistant - Technical Section', 'john.doe@example.com', 1),
(2, '0', 'Jane', 'Smith', 'Librarian - Law Library', 'jane.smith@example.com', 1),
(3, '0', 'sdf', 'sdf', 'Librarian - Periodical Section', 'alice.johnson@example.com', 1),
(4, '03-2325', '123', '123', 'Librarian - Periodical Section', 'bob.brown@example.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL COMMENT 'Unique ID for each user.',
  `student_id` varchar(255) NOT NULL COMMENT 'Student ID "03-2324-xxxxxx"',
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `program` varchar(255) NOT NULL,
  `phinmaed_email` varchar(255) NOT NULL COMMENT 'PHINMA EMAIL',
  `year_level` varchar(255) NOT NULL,
  `department` varchar(100) NOT NULL COMMENT 'Course',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Registration date',
  `contact_number` bigint(15) NOT NULL COMMENT 'contact number',
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `student_id`, `first_name`, `last_name`, `password`, `program`, `phinmaed_email`, `year_level`, `department`, `created_at`, `contact_number`, `status`) VALUES
(7, '03-2324-032903', 'Kirsteen', 'Orduna', 'Gabriel12345', '', 'kisa.orduna.up@phinmaed.com', 'Sophomore (2nd Year)', 'CAHS', '2025-03-05 07:14:56', 9959824437, 1),
(8, '03-2324-012345', 'Joshua', 'Velasco', 'Joshua123456', '', 'joshuavelasco@gmail.com', 'Sophomore (2nd Year)', 'CAHS', '2025-03-05 07:14:51', 9123456789, 1),
(9, '2425-049858', 'Elijah', 'Vinluan', 'Vinluan12345', '', 'elca.vinluan.up@phinmaed.com', 'Sophomore (2nd Year)', 'CITE', '2025-03-12 14:09:17', 9123456789, 1),
(11, '03-2324-123456', 'Juan', 'Dela Cruz', '000000000000', '', 'juan.delacruz.up@phinmaed.com', 'Senior (4th Year)', 'CITE', '2025-03-12 14:09:41', 9951234567, 1),
(12, '03-2122-123456', 'Dayaranaa', 'Vinluan', 'user123456789', '', 'sample@gmail.com', 'Junior (3rd Year)', 'CITE', '2025-03-19 11:59:42', 9123556487, 1),
(13, '03-2324-036622', 'Nicka', 'Ok', 'password12345', '', 'ok@gmail.com', 'Sophomore (2nd Year)', 'CCJE', '2025-03-13 13:40:56', 9619968015, 1),
(14, '03-2425-123', 'Joshua', 'Dacasin', '@Dmin1234567890', '', 'joshua.dacasin@gmail.com', 'Freshmen (1st Year)', 'CITE', '2025-03-19 11:26:55', 9123453789, 1),
(16, '03-2324-032803', 'Gabriel Jose', 'Esperanza', 'Kirsteen12345', '', 'gajo.esperanza.up@phinmaed.com', 'Sophomore (2nd Year)', 'CITE', '2025-03-20 03:15:19', 9705095844, 1),
(17, '64694355---595', 'Jdjsbcu', 'Hisbsuds', 'pppppppp', 'BS Accounting Information System', '.up@phinmaed.com', 'Sophomore (2nd Year)', 'CMA', '2025-03-18 11:52:00', 643798, 1),
(18, '359538--6434', 'Jdbd', 'Gdud', '00000000', 'BA Political Science', '.up@phinmaed.com', 'Sophomore (2nd Year)', 'CELA', '2025-03-19 12:08:15', 986595, 1),
(19, '03-2324-03', 'Joshuaa', 'Ud', '00000000', 'BA Political Science', '.up@phinmaed.com', 'Freshmen (1st Year)', 'CITE', '2025-03-20 03:27:36', 9123456789, 1),
(20, '03-2324-123123', 'Joshua', 'Dacasin', 'admin123', 'Associate in Computer Technology', 'jedacasin.up@phinmaed.com', 'Freshmen (1st Year)', 'CCJE', '2025-03-21 07:47:38', 9123156486, 1),
(21, '03-2324-123124', 'Joshuaa', 'Dacasin', 'admin123', 'Associate in Computer Technology', 'jedacasin.up@phinmaed.com', 'Freshmen (1st Year)', 'CITE', '2025-03-21 08:15:28', 9123156489, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `book_code` (`book_code`);

--
-- Indexes for table `borrow`
--
ALTER TABLE `borrow`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `book_code` (`book_code`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=257;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for each book.', AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `borrow`
--
ALTER TABLE `borrow`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for each user.', AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `user` (`student_id`) ON DELETE CASCADE;

--
-- Constraints for table `borrow`
--
ALTER TABLE `borrow`
  ADD CONSTRAINT `books` FOREIGN KEY (`book_code`) REFERENCES `books` (`book_code`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user` FOREIGN KEY (`student_id`) REFERENCES `user` (`student_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
