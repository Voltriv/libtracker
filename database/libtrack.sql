-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 31, 2025 at 03:00 AM
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
(2, 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', 'esperanzagabrieljose@gmail.com', '2025-02-01 12:49:31', 630831, '2025-03-05 11:18:08');

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
(252, '03-2324-032803', 'March 27, 2025, 2:25 pm', 'Thursday', 'CITE'),
(253, '03-2324-031781', 'March 27, 2025, 2:26 pm', 'Thursday', 'CITE'),
(254, '03-2425-082563', 'March 27, 2025, 4:01 pm', 'Thursday', 'CMA'),
(255, '03-2324-032803', 'March 28, 2025, 1:58 pm', 'Friday', 'CITE'),
(256, '03-2324-032803', 'March 28, 2025, 1:58 pm', 'Friday', 'CITE'),
(257, '03-2324-032803', 'March 28, 2025, 1:58 pm', 'Friday', 'CITE'),
(258, '03-2324-032803', 'March 28, 2025, 1:59 pm', 'Friday', 'CITE'),
(259, '03-2324-032803', 'March 28, 2025, 1:59 pm', 'Friday', 'CITE'),
(260, '03-2324-032803', 'March 28, 2025, 2:00 pm', 'Friday', 'CITE'),
(261, '03-2324-032803', 'March 28, 2025, 2:01 pm', 'Friday', 'CITE'),
(262, '03-2324-032803', 'March 28, 2025, 2:01 pm', 'Friday', 'CITE'),
(263, '03-2324-032803', 'March 28, 2025, 2:02 pm', 'Friday', 'CITE'),
(264, '03-2324-032803', 'March 28, 2025, 2:02 pm', 'Friday', 'CITE'),
(265, '03-2324-032803', 'March 28, 2025, 2:02 pm', 'Friday', 'CITE'),
(266, '03-2324-031781', 'March 28, 2025, 2:06 pm', 'Friday', 'CITE'),
(267, '03-2324-031781', 'March 28, 2025, 2:06 pm', 'Friday', 'CITE'),
(268, '03-2324-031781', 'March 28, 2025, 2:07 pm', 'Friday', 'CITE'),
(269, '03-2324-031781', 'March 28, 2025, 2:09 pm', 'Friday', 'CITE'),
(270, '03-2324-031781', 'March 28, 2025, 2:10 pm', 'Friday', 'CITE'),
(271, '03-2324-031781', 'March 28, 2025, 2:11 pm', 'Friday', 'CITE'),
(272, '03-2324-032803', 'March 28, 2025, 2:28 pm', 'Friday', 'CITE'),
(273, '03-2324-031781', 'March 28, 2025, 2:29 pm', 'Friday', 'CITE'),
(274, '03-2425-082563', 'March 28, 2025, 2:32 pm', 'Friday', 'CMA'),
(275, '03-2324-032803', 'March 30, 2025, 3:11 pm', 'Sunday', 'CITE');

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
(1, 'Abnormal Psychology (8th Edition)', 'Susan Nolen-Hoeksema', '', 'CAHS-001', 3, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 1.png', '', '2025-03-25 07:47:40'),
(2, 'Abnormal Psychology (11th Edition)', 'Ronald J. Comer and Jonathan S. Comer', '', 'CAHS-002', 2, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 2.png', '', '2025-03-25 07:47:40'),
(3, 'Abnormal Psychology (9th Edition)', 'Susan Krauss Whitbourne', '', 'CAHS-003', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 3.png', '', '2025-03-25 07:47:40'),
(4, 'Abnormal Psychology (6th Edition)', 'David J. A. Dozois', '', 'CAHS-004', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 4.png', '', '2025-03-25 07:47:40'),
(5, 'Case Analyses for Abnormal Psychology (2nd Edition)', 'Randall E. Osborne, Joan Esterline Lafuze, and David V. Perkins', '', 'CAHS-005', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 5.png', '', '2025-03-25 07:47:40'),
(6, 'Abnormal Psychology and Life (3rd Edition)', 'Christopher A. Kearney and Timothy J. Trull', '', 'CAHS-006', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 6.png', '', '2025-03-25 07:47:40'),
(7, 'DSM-5-TR', 'Carman S. Gill, Stephanie F. Dailey, Shannon L. Karl, and Casey A. Barrio Minton', '', 'CAHS-007', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 7.png', '', '2025-03-25 07:47:40'),
(8, 'Case Studies in Abnormal Psychology (2nd Edition)', 'Ethan E. Gorenstein and Ronald J. Comer', '', 'CAHS-008', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 9.png', '', '2025-03-25 07:47:40'),
(14, 'Human Biochemistry (2nd Edition)', 'Gerald Litwack', '', 'CAHS-014', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 14.png', '', '2025-03-25 07:48:51'),
(15, 'Key Concepts in Biochemistry', 'Abeer Iqbal', '', 'CAHS-015', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 15.png', '', '2025-03-25 07:48:51'),
(16, 'An Introduction to Applied Behavioral Neuroscience', 'Laura A. Freberg', '', 'CAHS-016', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 16.png', '', '2025-03-25 07:48:51'),
(17, 'Biological Psychology (2nd Edition)', 'Suzanne Higgs, Alison Cooper, and Jonathan Lee', '', 'CAHS-017', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 17.png', '', '2025-03-25 07:48:51'),
(18, 'Biological Psychology', 'Kelly Lambert', '', 'CAHS-018', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 18.png', '', '2025-03-25 07:48:51'),
(19, 'Brain & Behavior: An Introduction to Biological Psychology (4th Edition)', 'Bob Garrett', '', 'CAHS-019', 7, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 19.png', '', '2025-03-25 07:48:51'),
(20, 'Discovering Behavioral Neuroscience: An Introduction to Biological Psychology', 'Laura A. Freberg', '', 'CAHS-020', 5, 5, 'CAHS', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 20.png', '', '2025-03-25 07:48:51'),
(81, 'Nolen-hoeksema\'s Abnormal Psychology', 'Heather Jennings', '', 'CAHS-009', 5, 5, '', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 9.png', '', '2025-03-26 14:07:52'),
(82, 'Biochemistry (7th Edition)', 'Reginald H. Garrett And Charles M. Grisham', '', 'CAHS-010', 5, 5, '', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 10.png', '', '2025-03-26 14:14:52'),
(83, 'Biochemistry: Fundamentals And Bioenergetics', 'Meera Yadav And Hardeo Singh Yadav', '', 'CAHS-011', 5, 5, '', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 11.png', '', '2025-03-26 14:30:52'),
(84, 'Biochemistry And Its Application', 'Papita H. Gourkhede', '', 'CAHS-012', 5, 5, '', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 12.png', '', '2025-03-26 14:31:26'),
(85, 'Harper\'s Illustrated Biochemistry (32nd Edition)', 'Peter J. Kennelly, Kathleen M. Botham, Owen Mcguinness, Victor W. Rodwell, And P. Anthony Weil', '', 'CAHS-013', 5, 5, '', 'Psychology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Copy of 13.png', '', '2025-03-26 14:32:00'),
(86, 'Between Theory And Practice In Architectural Design: Imagination And Interdisciplinary In The Art Of Building', 'Alexander Tsigkas', '', 'CEA-126', 5, 5, '', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/126.png', 'http://192.168.23.209/LibTrack/libtracker/book_pdf/Alexander Tsigkas - Between Theory and Practice in Architectural Design_ Imagination and Interdisciplinarity in the Art of Building (Routledge Rese (2024, Routledge) - libgen.li.pdf', '2025-03-26 14:34:31'),
(87, 'The Contested Territory Of Architectural Theory', 'Elie G. Haddad', '', 'CEA-127', 5, 5, '', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/127.png', '', '2025-03-26 14:36:22'),
(88, 'Philosophical Difference And Advance Computation In Architectural Theory: From Less To More', 'Jefferson Ellinger', '', 'CEA-128', 5, 5, '', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/128.png', '', '2025-03-26 14:37:00'),
(89, 'Between Theory and Practice in Architectural Design: Imagination and Interdisciplinary in the Art of Building', 'Alexander Tsigkas', '', 'CEA-126', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/126.png', '', '2025-03-26 14:40:18'),
(90, 'The Contested Territory of Architectural Theory', 'Elie G. Haddad', '', 'CEA-127', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/127.png', '', '2025-03-26 14:40:18'),
(91, 'Philosophical Difference and Advance Computation in Architectural Theory: From Less to More', 'Jefferson Ellinger', '', 'CEA-128', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/128.png', '', '2025-03-26 14:40:18'),
(92, 'Building Materials: Material Theory and the Architectural Specification', 'Katie Lloyd Thomas', '', 'CEA-129', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/129.png', '', '2025-03-26 14:40:18'),
(93, 'Introducing Architectural Theory: Expanding the Disciplinary Debate', 'Korydon Smith and Miguel Guitart', '', 'CEA-130', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/130.png', '', '2025-03-26 14:40:18'),
(94, 'A Theory of Architecture', 'Nikos A. Salingaros', '', 'CEA-131', 5, 5, 'CEA', 'Architecture', 'http://192.168.23.209/LibTrack/libtracker/book_images/131.png', '', '2025-03-26 14:40:18'),
(95, 'Construction Estimating & Bidding: Theory-Principles-Process', 'AGC of America', '', 'CEA-132', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/132.png', '', '2025-03-26 14:40:18'),
(96, 'Construction Methods and Management', 'Stephens W. Nunnally', '', 'CEA-133', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/133.png', '', '2025-03-26 14:40:18'),
(97, 'Effective Project Management: Guidance and Checklists', 'Garth G.F. Ward', '', 'CEA-134', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/134.png', '', '2025-03-26 14:40:18'),
(98, 'Fundamentals of Construction Estimating', 'David J. Pratt', '', 'CEA-135', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/135.png', '', '2025-03-26 14:40:18'),
(99, 'Handbook for Construction Planning and Scheduling', 'Andrew Baldwin and David Bordoli', '', 'CEA-136', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/136.png', '', '2025-03-26 14:55:12'),
(100, 'Introduction to Estimating, Plan Reading and Construction Techniques', 'Gary Anglin', '', 'CEA-137', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/137.png', '', '2025-03-26 14:55:12'),
(101, 'Construction Cost Estimating', 'Len Holm and John E. Schaufelberger', '', 'CEA-138', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/138.png', '', '2025-03-26 14:55:12'),
(102, 'Construction Auditing: Planning-Implementation-Use', 'Peter Wotschke and Gregor Kindermann', '', 'CEA-139', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/139.png', '', '2025-03-26 14:55:12'),
(103, 'Project Management for Engineering and Technology', 'David L. Goetsch', '', 'CEA-140', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/140.png', '', '2025-03-26 14:55:12'),
(104, 'Project Management for Engineering, Business and Technology', 'John M. Nicholas and Herman Steyn', '', 'CEA-141', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/141.png', '', '2025-03-26 14:55:12'),
(105, 'The Engineer’s Manual of Construction Site Planning', 'Juri Sutt, Irene Lill, and Olev Müürsepp', '', 'CEA-142', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/142.png', 'http://192.168.23.209/LibTrack/libtracker/book_pdf/The Engineer_s Manual of Construction Site Planning.pdf', '2025-03-26 14:55:12'),
(106, 'The Latest Methods of Construction Design', 'Vojtech Dynybyl, Ondrej Berka, Karel Petr, Frantisek Lopot, and Martin Dub', '', 'CEA-143', 5, 5, 'CEA', 'Engineering', 'http://192.168.23.209/LibTrack/libtracker/book_images/143.png', 'http://192.168.23.209/LibTrack/libtracker/book_pdf/The Latest Methods of Construction Design.pdf', '2025-03-26 14:55:12'),
(107, 'A Companion to Children’s Literature', 'Karen Coats, Deborah Stevenson, and Vivian Yenika-Agbaw', '', 'CELA-144', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/144.png', '', '2025-03-26 14:58:13'),
(108, 'Children’s Literature and Intergenerational Relationships: Encounters of the Playful Kind', 'Justyna Deszcz-Tryhubczak and Irena Barbara Kalla', '', 'CELA-145', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/145.png', '', '2025-03-26 14:58:13'),
(109, 'Constructing the Adolescent Reader in Contemporary Young Adult Fiction', 'Elisabeth Rose Gruner', '', 'CELA-146', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/146.png', '', '2025-03-26 14:58:13'),
(110, 'Contemporary Children’s and Young Adult Literature: Writing Back to History and Oppression', 'Charlotte Beyer', '', 'CELA-147', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/147.png', '', '2025-03-26 14:58:13'),
(111, 'Critical Content Analysis of Children’s and Young Adult Literature: Reframing Perspective', 'Holly Johnson, Janelle Mathis, and Kathy G. Short', '', 'CELA-148', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/148.png', '', '2025-03-26 14:58:13'),
(112, 'Reading Children’s Literature: A Critical Introduction', 'Carrie Hints and Eric L. Tribunella', '', 'CELA-149', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/149.png', '', '2025-03-26 14:58:13'),
(113, 'Teaching Multicultural Children’s Literature in a Diverse Society: From a Historical Perspective to Instructional Practice', 'Annmarie Alberton Gunn and Susan V. Bennett', '', 'CELA-150', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/150.png', '', '2025-03-26 14:58:13'),
(114, 'Theory for Beginners: Children’s Literature as Critical Thought', 'Kenneth B. Kidd', '', 'CELA-151', 5, 5, 'CELA', 'Education', 'http://192.168.23.209/LibTrack/libtracker/book_images/151.png', '', '2025-03-26 14:58:13'),
(115, 'Banking Associations: Their Role and Impact in a Time of Market Change', 'Sladjana Sredojevic and Milan Brkovic', '', 'CMA-152', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/152.png', '', '2025-03-26 14:59:23'),
(116, 'Banking Business Models: Definition, Analytical Framework and Financial Stability Assessment', 'Rym Ayadi', '', 'CMA-153', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/153.png', '', '2025-03-26 14:59:23'),
(117, 'Banking Matters: An Essential Guide to Commercial Banking in an Age of Disruption', 'Duncan Knowles', '', 'CMA-154', 4, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/154.png', '', '2025-03-26 14:59:23'),
(118, 'Corporate and Investment Banking: A Hands-On Approach', 'Stefano Caselli, Gimede Gigante, and Andrea Tortoroglio', '', 'CMA-155', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/155.png', '', '2025-03-26 14:59:23'),
(119, 'Frontier Topics in Banking: Investigating New Trends and Recent Developments in the Financial Industry', 'Elisabetta Gualandri, Valeria Venturelli, and Alex Sclipp', '', 'CMA-156', 4, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/156.png', '', '2025-03-26 14:59:23'),
(120, 'Introduction to Banking (3rd Edition)', 'Barbara Casu, Claudia Girardone, and Philip Molyneux', '', 'CMA-157', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/157.png', '', '2025-03-26 14:59:23'),
(121, 'Investment Banking Workbook', 'Joshua Rosenbaum, Joshua Pearl, and Joseph Gasparro', '', 'CMA-158', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/158.png', '', '2025-03-26 14:59:23'),
(122, 'Money, Credit, and Crises: Understanding the Modern Banking System', 'Nektarios Michail', '', 'CMA-159', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/159.png', '', '2025-03-26 14:59:23'),
(123, 'The Business of Banking: Models, Risk and Regulation', 'Giusy Chesini, Elisa Giaretta, and Andrea Paltrinieri', '', 'CMA-160', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/160.png', '', '2025-03-26 14:59:23'),
(124, 'The Economics of Banking', 'Jin Cao', '', 'CMA-161', 5, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/161.png', '', '2025-03-26 14:59:23'),
(125, 'The Principles of Banking', 'Moorad Choudhry', '', 'CMA-162', 4, 5, 'CMA', 'Business', 'http://192.168.23.209/LibTrack/libtracker/book_images/162.png', '', '2025-03-26 14:59:23'),
(126, 'Philippine Information Technology Journal (Volume 11 Number 1)', 'Computing Society Of The Philippines', '', 'CITE-163', 5, 5, '', 'Technology', 'http://192.168.23.209/LibTrack/libtracker/book_images/485991736_2012052109303892_2877013390124295908_n.jpg', '', '2025-03-27 06:36:31'),
(127, 'Philippine Information Technology Journal (Volume 11 Number 2)', 'Computing Society Of The Philippines', '', 'CITE-164', 4, 5, '', 'Technology', 'http://192.168.23.209/LibTrack/libtracker/book_images/Cream Brown Illustrated War History Book Cover.png', '', '2025-03-27 06:39:27'),
(128, 'Philippine Criminology Journal Vol. I, Issue 1, 2020', 'Chapterhouse Publishing Incorporated', '', 'CCJE-1', 5, 5, '', 'Law', 'http://192.168.23.209/LibTrack/libtracker/book_images/485479698_1050293600269585_4865553517335049672_n.jpg', '', '2025-03-27 07:29:35'),
(129, 'Philippine Criminology Journal Vol. 2, Issue 2, 2021', 'Chapterhouse Publishing Incorporated', '', 'CCJE-2', 5, 5, '', 'Law', 'http://192.168.23.209/LibTrack/libtracker/book_images/485094418_4133042030298245_2088769854701929854_n.jpg', '', '2025-03-27 07:31:04'),
(130, 'Philippine Criminology Journal Vol. 2, Issue 1, 2021', 'Chapterhouse Publishing Incorporated', '', 'CCJE-3', 5, 5, '', 'Law', 'http://192.168.23.209/LibTrack/libtracker/book_images/485487733_1293434408409710_3119606214173965331_n.jpg', '', '2025-03-27 07:31:43'),
(131, 'Philippine Criminology Journal Vol. 1, Issue 2, 2020', 'Chapterhouse Publishing Incorporated', '', 'CCJE-4', 5, 5, '', 'Law', 'http://192.168.23.209/LibTrack/libtracker/book_images/486450857_1033747415239298_7044280817127819768_n.jpg', '', '2025-03-27 07:32:25');

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
  `return_date` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `server_time` varchar(255) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrow`
--

INSERT INTO `borrow` (`transaction_id`, `student_id`, `book_code`, `title`, `borrowed_date`, `due_date`, `return_date`, `status`, `server_time`) VALUES
(142, '03-2324-032803', 'CAHS-002', 'Abnormal Psychology (11th Edition)', '2025-03-27 23:12:27', '2025-04-03 23:12:27', 'March 27, 2025 04:18 PM', 'Returned', '2025-03-27 23:12:31'),
(143, '03-2324-032803', 'CAHS-001', 'Abnormal Psychology (8th Edition)', 'March 27, 2025 11:13 PM', 'April 3, 2025 11:13 PM', '2025-03-27 16:14:56', 'Returned', '2025-03-27 23:13:35'),
(144, '03-2324-032803', 'CAHS-003', 'Abnormal Psychology (9th Edition)', 'March 27, 2025 11:19 PM', 'April 3, 2025 11:19 PM', 'March 27, 2025 04:19 PM', 'Returned', '2025-03-27 23:19:43'),
(145, '03-2324-032803', 'CMA-156', 'Frontier Topics in Banking: Investigating New Trends and Recent Developments in the Financial Industry', 'March 27, 2025 11:23 PM', 'April 3, 2025 11:23 PM', '', 'Borrowed', '2025-03-27 23:23:26'),
(146, '03-2324-032803', 'CMA-162', 'The Principles of Banking', 'March 30, 2025 03:09 PM', 'April 6, 2025 03:09 PM', 'March 30, 2025 09:09 AM', 'Returned', '2025-03-30 15:09:18'),
(147, '03-2324-032803', 'CMA-162', 'The Principles of Banking', 'March 30, 2025 03:09 PM', 'April 6, 2025 03:09 PM', '', 'Borrowed', '2025-03-30 15:10:05');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `status` enum('unread','read') DEFAULT 'unread',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `book_id`, `message`, `status`, `created_at`) VALUES
(3, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:11:32'),
(4, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:12:17'),
(5, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:15:34'),
(6, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:22:06'),
(7, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:25:14'),
(12, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:28:42'),
(14, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'test1\'', 'read', '2025-03-25 05:32:05'),
(15, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:34:57'),
(16, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:36:01'),
(17, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:37:08'),
(18, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'test1\'', 'read', '2025-03-25 05:37:51'),
(19, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:38:11'),
(20, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:40:36'),
(21, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:45:29'),
(22, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:46:26'),
(23, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:48:41'),
(24, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:50:33'),
(25, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:52:47'),
(26, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:55:54'),
(27, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'test1\'', 'read', '2025-03-25 05:57:45'),
(28, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 05:58:32'),
(29, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'okp\'', 'read', '2025-03-25 05:59:06'),
(30, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 05:59:16'),
(31, 0, 0, 'Dayanara Lopez borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 06:58:19'),
(32, 0, 0, 'Dayanara Lopez borrowed a book titled \'test1\'', 'read', '2025-03-25 06:58:51'),
(33, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology\'', 'read', '2025-03-25 07:00:29'),
(34, 0, 0, 'Dayanara Lopez borrowed a book titled \'Case  Analyses For Abnormal Psychology\'', 'read', '2025-03-25 07:05:52'),
(35, 0, 0, 'Dayanara Lopez borrowed a book titled \'okp\'', 'read', '2025-03-25 07:05:58'),
(36, 0, 0, 'Dayanara Lopez borrowed a book titled \'test1\'', 'read', '2025-03-25 07:06:01'),
(37, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-25 08:00:30'),
(38, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (9th Edition)\'', 'read', '2025-03-25 08:07:34'),
(39, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-25 12:04:38'),
(40, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (9th Edition)\'', 'read', '2025-03-25 12:14:50'),
(41, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology and Life (3rd Edition)\'', 'read', '2025-03-25 12:17:26'),
(42, 0, 0, 'Dayanara Lopez borrowed a book titled \'DSM-5-TR\'', 'read', '2025-03-25 12:22:52'),
(43, 0, 0, 'Dayanara Lopez borrowed a book titled \'Human Biochemistry (2nd Edition)\'', 'read', '2025-03-25 12:28:54'),
(44, 0, 0, 'Dayanara Lopez borrowed a book titled \'Case Studies in Abnormal Psychology (2nd Edition)\'', 'read', '2025-03-25 12:31:56'),
(45, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-25 12:42:06'),
(46, 0, 0, 'Dayanara Lopez borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-25 12:43:14'),
(47, 0, 0, 'Dayanaraaa Lopez borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-26 05:44:29'),
(48, 0, 0, 'Dayanaraaa Lopez borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-26 05:44:51'),
(49, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:07:09'),
(50, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:07:10'),
(51, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:07:25'),
(52, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:07:29'),
(53, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:07:50'),
(54, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:09:03'),
(55, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:09:06'),
(56, 0, 0, 'Joshuaaaaa Ud has an overdue book titled \'\'.', 'read', '2025-03-26 07:12:58'),
(57, 0, 0, 'Nicka Ok has an overdue book titled \'dsfsdfsfsdfsfsfsf\'.', 'read', '2025-03-26 07:15:27'),
(58, 0, 0, 'Dayanaraaa Lopez borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-26 07:18:56'),
(59, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-27 06:03:06'),
(60, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (9th Edition)\'', 'read', '2025-03-27 06:03:37'),
(61, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (6th Edition)\'', 'read', '2025-03-27 06:09:03'),
(62, 0, 0, 'Dayanaraaa Lopez borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-27 06:26:33'),
(63, 0, 0, 'Dayanaraaa Lopez borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-27 06:26:51'),
(64, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Philippine Information Technology Journal (Volume 11 Number 2)\'', 'read', '2025-03-27 07:24:47'),
(65, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-27 07:25:17'),
(66, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (6th Edition)\'', 'read', '2025-03-27 07:54:56'),
(67, 0, 0, 'Alyza Yu borrowed a book titled \'Banking Matters: An Essential Guide to Commercial Banking in an Age of Disruption\'', 'read', '2025-03-27 08:05:10'),
(68, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-27 15:07:59'),
(69, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (11th Edition)\'', 'read', '2025-03-27 15:12:31'),
(70, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (8th Edition)\'', 'read', '2025-03-27 15:13:35'),
(71, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Abnormal Psychology (9th Edition)\'', 'read', '2025-03-27 15:19:43'),
(72, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'Frontier Topics in Banking: Investigating New Trends and Recent Developments in the Financial Industry\'', 'read', '2025-03-27 15:23:26'),
(73, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'The Principles of Banking\'', 'read', '2025-03-30 07:09:18'),
(74, 0, 0, 'Gabriel Jose Esperanza borrowed a book titled \'The Principles of Banking\'', 'read', '2025-03-30 07:10:05');

-- --------------------------------------------------------

--
-- Table structure for table `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `otp` varchar(6) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `staff_idNum` int(11) NOT NULL,
  `staff_first_name` varchar(255) NOT NULL,
  `staff_last_name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `phinmaed_email` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `staff_idNum`, `staff_first_name`, `staff_last_name`, `position`, `phinmaed_email`, `department`, `status`) VALUES
(13, 12334, 'Test12', 'Test1', 'Librarian - Periodical Section', 'test1@gmail.com', '', 1),
(14, 12345, 'Test2', 'Tyest2', 'Librarian - Periodical Section', 'test2@gmail.com', '', 1),
(15, 1233, '123', '123', 'Librarian - Periodical Section', '123@gmial.com', '', 1),
(16, 123456, 'Test', 'Test', 'Librarian - Periodical Section', 'test1@gmail.com', '', 1);

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
(21, '03-2324-031781', 'Dayanaraaa', 'Lopez', '$2y$10$hUtemP4XFWePGuuOq./uS.ipHmMNuNfexwWC4HwQwhsd/yhtoKIja', 'BS Information Technology', 'jode.velasco.up@phinmaed.com', 'Sophomore (2nd Year)', 'CITE', '2025-03-27 06:55:54', 9924566597, 1),
(22, '03-2324-032803', 'Gabriel Jose', 'Esperanza', '$2y$10$jg5G5TsT5NZkuAiNtyDVHerxR0bCJFY0kdrOPChOQN5py4oUO7Xha', 'BS Information Technology', 'gajo.esperanza.up@phinmaed.com', 'Sophomore (2nd Year)', 'CITE', '2025-03-27 07:19:56', 9705095844, 1),
(23, '03-2425-082563', 'Alyza', 'Yu', '$2y$10$vSokxWDVQPMkX0c4A5QqtucDqf1tOAiJe4P59kHPE49SoJitVbvru', 'BS Accountancy', 'adsupanga.up@phinmaed.com', 'Freshman (1st Year)', 'CMA', '2025-03-27 07:59:03', 9467286586, 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=276;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for each book.', AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `borrow`
--
ALTER TABLE `borrow`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Unique ID for each user.', AUTO_INCREMENT=24;

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
