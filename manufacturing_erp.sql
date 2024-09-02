-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 02, 2024 at 07:22 AM
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
-- Database: `manufacturing_erp`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_no` varchar(255) DEFAULT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `technician_id` varchar(255) DEFAULT NULL,
  `quantity` double(50,2) NOT NULL DEFAULT 0.00,
  `delivery_quantity` int(11) NOT NULL DEFAULT 0,
  `cancel_quantity` int(11) DEFAULT 0,
  `total_amount` double(20,2) NOT NULL DEFAULT 0.00,
  `advance_amount` double(50,2) NOT NULL,
  `date` date NOT NULL,
  `delivery_date` date DEFAULT NULL,
  `warning_date` date DEFAULT NULL,
  `remake_request` int(11) DEFAULT 0,
  `note` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT 'Customer = 1, Supplier = 2',
  `name` varchar(255) NOT NULL,
  `id_no` varchar(255) NOT NULL,
  `designation` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) NOT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `opening_due` double(20,2) NOT NULL DEFAULT 0.00,
  `opening_paid` double(20,2) NOT NULL DEFAULT 0.00,
  `advance_amount` double(20,2) NOT NULL DEFAULT 0.00,
  `is_opening_show` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: edit possible 0: Not possible',
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `type`, `name`, `id_no`, `designation`, `mobile`, `owner_name`, `email`, `address`, `date_of_birth`, `opening_due`, `opening_paid`, `advance_amount`, `is_opening_show`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'Supplier 2', '101', NULL, '01765456543', 'S1 Limited', 'supplier@gmail.com', 'Rampura, Dhaka', NULL, 0.00, 0.00, 0.00, 1, 1, '2024-08-29 11:40:22', '2024-09-01 08:38:14'),
(2, 2, 'Supplier 2', '102', NULL, '01765434543', 'AT limited', 'at@gmail.com', 'Mouchak,Dhaka', NULL, 0.00, 0.00, 0.00, 1, 1, '2024-08-29 11:41:05', '2024-08-29 11:41:05'),
(3, 1, 'Asif Talukdar', '103', NULL, '01765434343', NULL, 'at@gmail.com', 'Mouchak, Dhaka', NULL, 0.00, 0.00, 0.00, 1, 1, '2024-08-29 12:28:47', '2024-08-29 12:28:47'),
(4, 2, 'Test', '104', NULL, '01765434343', 'TL Limited', NULL, 'Hjaqs', NULL, 0.00, 0.00, 0.00, 1, 1, '2024-09-01 06:48:04', '2024-09-01 06:48:04'),
(5, 2, 'Test', '105', NULL, '01765434343', 'TL Limited', NULL, 'Rampura', NULL, 100.00, 0.00, 0.00, 1, 1, '2024-09-01 06:49:03', '2024-09-01 06:50:09'),
(6, 2, 'Test', '106', NULL, '01765434345', 'wdawsa', NULL, 'dcsdfds', NULL, 0.00, 0.00, 0.00, 1, 1, '2024-09-01 08:38:04', '2024-09-01 08:38:04');

-- --------------------------------------------------------

--
-- Table structure for table `config_products`
--

CREATE TABLE `config_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `extra_cost` double(20,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `config_products`
--

INSERT INTO `config_products` (`id`, `product_id`, `extra_cost`, `created_at`, `updated_at`) VALUES
(1, 3, 0.00, '2024-08-30 06:10:01', '2024-09-01 07:29:53'),
(2, 4, 0.00, '2024-09-01 07:30:26', '2024-09-01 07:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `config_product_details`
--

CREATE TABLE `config_product_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `config_product_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `loss_quantity_percent` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `config_product_details`
--

INSERT INTO `config_product_details` (`id`, `config_product_id`, `product_id`, `quantity`, `loss_quantity_percent`, `created_at`, `updated_at`) VALUES
(2, 1, 8, 10.00, 10.00, '2024-09-01 07:29:53', '2024-09-01 07:29:53'),
(5, 2, 8, 20.00, 0.00, '2024-09-02 05:02:03', '2024-09-02 05:02:03');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finished_goods`
--

CREATE TABLE `finished_goods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `config_product_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double(50,2) NOT NULL,
  `total` double(20,2) NOT NULL DEFAULT 0.00,
  `extra_cost` double(20,2) NOT NULL,
  `unit_price` double(50,2) NOT NULL,
  `selling_price` double(50,2) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finished_goods`
--

INSERT INTO `finished_goods` (`id`, `name`, `config_product_id`, `product_id`, `quantity`, `total`, `extra_cost`, `unit_price`, `selling_price`, `date`, `created_at`, `updated_at`) VALUES
(1, 'Product 1', 1, 1, 10.00, 20000.00, 0.00, 2000.00, 150.00, '2024-08-30', '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(2, 'Product 2', 1, 2, 1.00, 2000.00, 0.00, 2000.00, 300.00, '2024-09-01', '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(3, 'Product 1', 2, 1, 2.00, 4000.00, 0.00, 2000.00, 300.00, '2024-09-01', '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(4, 'Product 1', 1, 1, 2.00, 4000.00, 0.00, 2000.00, 300.00, '2024-09-01', '2024-09-01 08:43:49', '2024-09-01 08:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `finished_goods_row_materials`
--

CREATE TABLE `finished_goods_row_materials` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `finished_goods_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `inventory_id` bigint(20) UNSIGNED NOT NULL,
  `per_unit_quantity` double(50,2) NOT NULL,
  `consumption_quantity` double(50,2) NOT NULL,
  `consumption_unit_price` double(50,2) NOT NULL,
  `remain_quantity` double(50,2) NOT NULL,
  `consumption_loss_quantity_percent` double(10,2) NOT NULL,
  `consumption_loss_quantity` double(10,2) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finished_goods_row_materials`
--

INSERT INTO `finished_goods_row_materials` (`id`, `finished_goods_id`, `product_id`, `inventory_id`, `per_unit_quantity`, `consumption_quantity`, `consumption_unit_price`, `remain_quantity`, `consumption_loss_quantity_percent`, `consumption_loss_quantity`, `date`, `created_at`, `updated_at`) VALUES
(1, 1, 8, 2, 10.00, 100.00, 200.00, 220.00, 10.00, 10.00, '2024-08-30', '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(2, 2, 8, 2, 10.00, 10.00, 200.00, 120.00, 10.00, 1.00, '2024-09-01', '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(3, 3, 8, 2, 10.00, 20.00, 200.00, 110.00, 0.00, 0.00, '2024-09-01', '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(4, 4, 8, 2, 10.00, 20.00, 200.00, 90.00, 10.00, 2.00, '2024-09-01', '2024-09-01 08:43:49', '2024-09-01 08:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `finish_goods_id` int(11) DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL COMMENT '1=Finish Goods, 2= Row Material',
  `serial` varchar(255) DEFAULT NULL,
  `quantity` double(8,2) NOT NULL,
  `unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `avg_unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `selling_price` double(20,2) NOT NULL DEFAULT 0.00,
  `total` double(20,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventories`
--

INSERT INTO `inventories` (`id`, `product_category_id`, `product_id`, `finish_goods_id`, `product_type`, `serial`, `quantity`, `unit_price`, `avg_unit_price`, `selling_price`, `total`, `created_at`, `updated_at`) VALUES
(1, NULL, 10, NULL, 2, '00000001', 378.00, 100.00, 0.00, 0.00, 0.00, '2024-08-29 11:42:31', '2024-09-01 07:20:08'),
(2, NULL, 8, NULL, 2, '00000002', 70.00, 200.00, 0.00, 0.00, 0.00, '2024-08-29 11:42:31', '2024-09-01 08:43:49'),
(3, NULL, 9, NULL, 2, '00000003', 170.00, 150.00, 0.00, 0.00, 0.00, '2024-08-29 11:53:32', '2024-09-01 08:38:38'),
(4, NULL, 1, 1, 1, '00000004', 14.00, 2000.00, 2000.00, 300.00, 28000.00, '2024-08-30 06:10:41', '2024-09-01 08:43:49'),
(5, 1, 1, 1, 3, '10001', 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:11:10'),
(6, 1, 1, 1, 3, '1002', 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:11:28'),
(7, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(8, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(9, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(10, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(11, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(12, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(13, 1, 1, 1, 3, NULL, 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(14, 1, 1, 1, 3, '3002', 1.00, 2000.00, 2000.00, 150.00, 2000.00, '2024-08-30 06:10:41', '2024-09-01 08:45:08'),
(15, NULL, 2, 2, 1, '00000015', 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(16, 1, 2, 2, 3, NULL, 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(17, 1, 1, 3, 3, '1001', 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 07:41:52', '2024-09-01 07:42:07'),
(18, 1, 1, 3, 3, NULL, 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(19, 1, 1, 4, 3, '200', 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 08:43:49', '2024-09-01 08:44:08'),
(20, 1, 1, 4, 3, NULL, 1.00, 2000.00, 2000.00, 300.00, 2000.00, '2024-09-01 08:43:49', '2024-09-01 08:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_logs`
--

CREATE TABLE `inventory_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `product_category_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_type` tinyint(4) DEFAULT NULL,
  `finished_goods_id` int(11) DEFAULT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `finished_goods_row_material_id` int(11) DEFAULT NULL,
  `type` int(11) NOT NULL COMMENT '1=In; 2=Out,Pur Return=3,Sale Return=4',
  `date` date NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `consumption_loss_quantity` double(20,2) NOT NULL DEFAULT 0.00,
  `unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `avg_unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `selling_price` double(20,2) NOT NULL DEFAULT 0.00,
  `sale_total` double(20,2) NOT NULL DEFAULT 0.00,
  `total` double(20,2) NOT NULL DEFAULT 0.00,
  `client_id` int(10) UNSIGNED DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED DEFAULT NULL,
  `sales_order_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_order_id` int(10) UNSIGNED DEFAULT NULL,
  `purchase_return_order_id` int(11) DEFAULT NULL,
  `sale_product_return_order_id` int(11) DEFAULT NULL,
  `inventory_id` int(10) UNSIGNED DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `sales_order_no` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_logs`
--

INSERT INTO `inventory_logs` (`id`, `serial`, `product_category_id`, `product_id`, `product_type`, `finished_goods_id`, `serial_no`, `finished_goods_row_material_id`, `type`, `date`, `quantity`, `consumption_loss_quantity`, `unit_price`, `avg_unit_price`, `selling_price`, `sale_total`, `total`, `client_id`, `supplier_id`, `sales_order_id`, `purchase_order_id`, `purchase_return_order_id`, `sale_product_return_order_id`, `inventory_id`, `note`, `sales_order_no`, `created_at`, `updated_at`) VALUES
(1, '00000001', NULL, 10, NULL, NULL, NULL, NULL, 1, '2024-08-29', 10.00, 0.00, 100.00, 0.00, 0.00, 0.00, 1000.00, NULL, 1, NULL, 1, NULL, NULL, 1, 'Purchase Product', NULL, '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(2, '00000002', NULL, 8, NULL, NULL, NULL, NULL, 1, '2024-08-29', 20.00, 0.00, 200.00, 0.00, 0.00, 0.00, 4000.00, NULL, 1, NULL, 1, NULL, NULL, 2, 'Purchase Product', NULL, '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(3, '00000002', NULL, 8, NULL, NULL, NULL, NULL, 1, '2024-08-29', 200.00, 0.00, 200.00, 0.00, 0.00, 0.00, 40000.00, NULL, 2, NULL, 2, NULL, NULL, 2, 'Purchase Product', NULL, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(4, '00000001', NULL, 10, NULL, NULL, NULL, NULL, 1, '2024-08-29', 249.00, 0.00, 100.00, 0.00, 0.00, 0.00, 24900.00, NULL, 2, NULL, 2, NULL, NULL, 1, 'Purchase Product', NULL, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(5, '00000003', NULL, 9, NULL, NULL, NULL, NULL, 1, '2024-08-29', 150.00, 0.00, 150.00, 0.00, 0.00, 0.00, 22500.00, NULL, 2, NULL, 2, NULL, NULL, 3, 'Purchase Product', NULL, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(6, '00000002', 2, 8, 1, 1, NULL, 1, 4, '2024-08-30', 100.00, 10.00, 200.00, 0.00, 0.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Manufacturer Row Material Consumption', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(7, '00000004', NULL, 1, 1, 1, NULL, NULL, 3, '2024-08-30', 10.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 20000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Finished Goods Product', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(8, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(9, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(10, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(11, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(12, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(13, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(14, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(15, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(16, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(17, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-08-30', 1.00, 0.00, 2000.00, 0.00, 150.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(18, '00000001', NULL, 10, NULL, NULL, NULL, NULL, 1, '2024-09-01', 100.00, 0.00, 100.00, 0.00, 0.00, 0.00, 10000.00, NULL, 4, NULL, 3, NULL, NULL, 1, 'Purchase Product', NULL, '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(19, '00000001', NULL, 10, NULL, NULL, NULL, NULL, 1, '2024-09-01', 19.00, 0.00, 100.00, 0.00, 0.00, 0.00, 1900.00, NULL, 4, NULL, 4, NULL, NULL, 1, 'Purchase Product', NULL, '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(20, '00000002', 2, 8, 1, 2, NULL, 2, 4, '2024-09-01', 10.00, 1.00, 200.00, 0.00, 0.00, 0.00, 200.00, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Manufacturer Row Material Consumption', NULL, '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(21, '00000015', NULL, 2, 1, 2, NULL, NULL, 3, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 15, 'Finished Goods Product', NULL, '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(22, '00000015', NULL, 2, 3, NULL, NULL, NULL, 1, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 15, 'Ready for Sale', NULL, '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(23, '00000002', 2, 8, 1, 3, NULL, 3, 4, '2024-09-01', 20.00, 0.00, 200.00, 0.00, 0.00, 0.00, 400.00, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Manufacturer Row Material Consumption', NULL, '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(24, '00000004', NULL, 1, 1, 1, NULL, NULL, 3, '2024-09-01', 2.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 4000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Finished Goods Product', NULL, '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(25, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(26, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(27, '00000003', NULL, 9, NULL, NULL, NULL, NULL, 1, '2024-09-01', 20.00, 0.00, 150.00, 0.00, 0.00, 0.00, 3000.00, NULL, 2, NULL, 5, NULL, NULL, 3, 'Purchase Product', NULL, '2024-09-01 08:38:38', '2024-09-01 08:38:38'),
(28, '00000002', 2, 8, 1, 4, NULL, 4, 4, '2024-09-01', 20.00, 2.00, 200.00, 0.00, 0.00, 0.00, 400.00, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'Manufacturer Row Material Consumption', NULL, '2024-09-01 08:43:49', '2024-09-01 08:43:49'),
(29, '00000004', NULL, 1, 1, 1, NULL, NULL, 3, '2024-09-01', 2.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 4000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Finished Goods Product', NULL, '2024-09-01 08:43:49', '2024-09-01 08:43:49'),
(30, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-09-01 08:43:49', '2024-09-01 08:43:49'),
(31, '00000004', NULL, 1, 3, NULL, NULL, NULL, 1, '2024-09-01', 1.00, 0.00, 2000.00, 0.00, 300.00, 0.00, 2000.00, NULL, NULL, NULL, NULL, NULL, NULL, 4, 'Ready for Sale', NULL, '2024-09-01 08:43:49', '2024-09-01 08:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `models`
--

CREATE TABLE `models` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_code` varchar(255) NOT NULL,
  `model_name` varchar(255) NOT NULL,
  `model_description` text NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `unit_id` int(11) DEFAULT NULL,
  `product_type` tinyint(4) NOT NULL COMMENT '1=Finish Goods, 2= Row Material',
  `unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `quantity` double(20,2) NOT NULL DEFAULT 0.00,
  `purchase_order_id` int(11) DEFAULT NULL,
  `warranty` varchar(255) DEFAULT NULL,
  `warning_quantity` int(11) NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `unit_id`, `product_type`, `unit_price`, `quantity`, `purchase_order_id`, `warranty`, `warning_quantity`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Product 1', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(2, 1, 'Product 2', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(3, 1, 'Product 3', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(4, 1, 'Product 4', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(5, 1, 'Product 5', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(6, 1, 'Product 6', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-08-28 20:36:41'),
(7, 1, 'Product 7', 1, 1, 0.00, 0.00, NULL, '1-year', 0, NULL, 1, '2023-09-20 00:42:11', '2023-09-20 00:42:11'),
(8, 2, 'Raw Product 8', 1, 2, 200.00, 70.00, 1, '1-year', 0, NULL, 1, '2024-08-28 20:36:41', '2024-09-01 08:43:49'),
(9, NULL, 'Raw Product 9', 1, 2, 1800.00, -134.00, 22, NULL, 15, NULL, 1, '2024-08-28 20:36:41', '2024-08-29 11:33:39'),
(10, NULL, 'Raw Product 10', 1, 2, 2500.00, -25.00, 45, NULL, 10, NULL, 1, '2024-08-28 20:36:41', '2024-08-29 11:33:20'),
(153, 2, 'Test', 3, 1, 0.00, 0.00, NULL, '1', 10, 'Test', 0, '2024-09-01 06:39:11', '2024-09-01 06:39:34'),
(154, NULL, 'ewedw', 1, 2, 0.00, 0.00, NULL, '1', 10, 'cdsfcds', 1, '2024-09-01 08:37:22', '2024-09-01 08:37:22'),
(155, 2, 'dededfew', 3, 1, 0.00, 0.00, NULL, '2', 20, 'Test', 1, '2024-09-01 08:37:43', '2024-09-01 08:37:43');

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_type` tinyint(4) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`id`, `category_type`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'IPS', 1, '2024-08-29 11:55:17', '2024-08-29 11:55:17'),
(2, NULL, 'ERD', 1, '2024-08-29 11:55:26', '2024-08-29 11:55:26'),
(3, NULL, 'test1', 0, '2024-09-01 06:37:19', '2024-09-01 06:37:32'),
(4, NULL, 'Test 2', 1, '2024-09-01 08:37:02', '2024-09-01 08:37:02');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_no` varchar(255) DEFAULT NULL,
  `supplier_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `sub_total` double(20,2) NOT NULL DEFAULT 0.00,
  `total` double(20,2) NOT NULL DEFAULT 0.00,
  `paid` double(20,2) NOT NULL DEFAULT 0.00,
  `transport_cost` double(20,2) NOT NULL DEFAULT 0.00,
  `vat` double(20,2) DEFAULT 0.00,
  `vat_percentage` double(20,2) DEFAULT 0.00,
  `discount` double(20,2) DEFAULT 0.00,
  `discount_percentage` double(20,2) DEFAULT 0.00,
  `due` double(50,2) NOT NULL DEFAULT 0.00,
  `refund` double(50,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`id`, `order_no`, `supplier_id`, `brand_id`, `date`, `sub_total`, `total`, `paid`, `transport_cost`, `vat`, `vat_percentage`, `discount`, `discount_percentage`, `due`, `refund`, `created_at`, `updated_at`) VALUES
(1, 'PO00000001', 1, NULL, '2024-08-29', 5000.00, 5000.00, 3200.00, 0.00, 0.00, NULL, 0.00, 0.00, 1800.00, 0.00, '2024-08-29 11:42:31', '2024-08-29 11:43:35'),
(2, 'PO00000002', 2, NULL, '2024-08-29', 87400.00, 87400.00, 7400.00, 0.00, 0.00, NULL, 0.00, 0.00, 80000.00, 0.00, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(3, 'PO00000003', 4, NULL, '2024-09-01', 10000.00, 9500.00, 8000.00, 0.00, 0.00, NULL, 500.00, 0.00, 1500.00, 0.00, '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(4, 'PO00000004', 4, NULL, '2024-09-01', 1900.00, 1900.00, 1000.00, 0.00, 0.00, NULL, 0.00, 0.00, 900.00, 0.00, '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(5, 'PO00000005', 2, NULL, '2024-09-01', 3000.00, 2990.00, 200.00, 0.00, 0.00, NULL, 10.00, 0.00, 2790.00, 0.00, '2024-09-01 08:38:38', '2024-09-01 08:38:38');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_products`
--

CREATE TABLE `purchase_order_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `purchase_order_id` int(10) UNSIGNED NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_category_id` int(1) DEFAULT NULL,
  `purchase_inventory_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `serial` varchar(255) DEFAULT NULL,
  `quantity` double(8,2) NOT NULL,
  `unit_price` double(20,2) NOT NULL DEFAULT 0.00,
  `selling_price` double(20,2) DEFAULT 0.00,
  `total` double(20,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_order_products`
--

INSERT INTO `purchase_order_products` (`id`, `purchase_order_id`, `supplier_id`, `product_id`, `product_category_id`, `purchase_inventory_id`, `name`, `serial`, `quantity`, `unit_price`, `selling_price`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 10, NULL, 1, 'Raw Product 10', '00000001', 10.00, 100.00, 0.00, 1000.00, '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(2, 1, 1, 8, NULL, 2, 'Raw Product 8', '00000002', 20.00, 200.00, 0.00, 4000.00, '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(3, 2, 2, 8, NULL, 2, 'Raw Product 8', '00000002', 200.00, 200.00, 0.00, 40000.00, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(4, 2, 2, 10, NULL, 1, 'Raw Product 10', '00000001', 249.00, 100.00, 0.00, 24900.00, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(5, 2, 2, 9, NULL, 3, 'Raw Product 9', '00000003', 150.00, 150.00, 0.00, 22500.00, '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(6, 3, 4, 10, NULL, 1, 'Raw Product 10', '00000001', 100.00, 100.00, 0.00, 10000.00, '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(7, 4, 4, 10, NULL, 1, 'Raw Product 10', '00000001', 19.00, 100.00, 0.00, 1900.00, '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(8, 5, 2, 9, NULL, 3, 'Raw Product 9', '00000003', 20.00, 150.00, 0.00, 3000.00, '2024-09-01 08:38:38', '2024-09-01 08:38:38');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_logs`
--

CREATE TABLE `transaction_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date DEFAULT NULL,
  `transaction_type` int(11) DEFAULT NULL,
  `amount` double(100,2) NOT NULL DEFAULT 0.00,
  `other_head` int(11) NOT NULL DEFAULT 0,
  `account_head_id` bigint(20) UNSIGNED DEFAULT NULL,
  `receipt_payment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `receipt_payment_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `balance_transfer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `journal_voucher_id` bigint(20) UNSIGNED DEFAULT NULL,
  `journal_voucher_detail_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payee_depositor_account_head_id` bigint(20) UNSIGNED DEFAULT NULL,
  `tax_section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `payment_account_head_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `payment_type` int(11) DEFAULT NULL COMMENT '1=Bank,2=Cash',
  `reconciliation` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=checked,0=unchecked',
  `financial_year` varchar(255) DEFAULT NULL,
  `receipt_payment_sl` bigint(20) DEFAULT NULL,
  `receipt_payment_no` varchar(255) DEFAULT NULL,
  `jv_type` int(11) DEFAULT NULL COMMENT '1=debit,2-credit',
  `jv_no` varchar(255) DEFAULT NULL,
  `cheque_no` varchar(255) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `payout` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'vat and ait,salary payout =1,0=not payout',
  `payout_start_date` date DEFAULT NULL,
  `payout_end_date` date DEFAULT NULL,
  `salary_group_no` varchar(255) DEFAULT NULL,
  `salary_challan_date` date DEFAULT NULL,
  `salary_challan_no` varchar(255) DEFAULT NULL,
  `salary_challan_link` varchar(255) DEFAULT NULL,
  `salary_challan_copy` varchar(255) DEFAULT NULL,
  `vat_group_no` varchar(255) DEFAULT NULL,
  `vat_challan_no` varchar(255) DEFAULT NULL,
  `vat_challan_date` date DEFAULT NULL,
  `vat_challan_link` varchar(255) DEFAULT NULL,
  `vat_challan_copy` varchar(255) DEFAULT NULL,
  `ait_group_no` varchar(255) DEFAULT NULL,
  `ait_challan_no` varchar(255) DEFAULT NULL,
  `ait_challan_date` date DEFAULT NULL,
  `ait_challan_link` varchar(255) DEFAULT NULL,
  `ait_challan_copy` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_logs`
--

INSERT INTO `transaction_logs` (`id`, `date`, `transaction_type`, `amount`, `other_head`, `account_head_id`, `receipt_payment_id`, `project_id`, `receipt_payment_detail_id`, `balance_transfer_id`, `journal_voucher_id`, `journal_voucher_detail_id`, `payee_depositor_account_head_id`, `tax_section_id`, `payment_account_head_id`, `client_id`, `payment_type`, `reconciliation`, `financial_year`, `receipt_payment_sl`, `receipt_payment_no`, `jv_type`, `jv_no`, `cheque_no`, `cheque_date`, `payout`, `payout_start_date`, `payout_end_date`, `salary_group_no`, `salary_challan_date`, `salary_challan_no`, `salary_challan_link`, `salary_challan_copy`, `vat_group_no`, `vat_challan_no`, `vat_challan_date`, `vat_challan_link`, `vat_challan_copy`, `ait_group_no`, `ait_challan_no`, `ait_challan_date`, `ait_challan_link`, `ait_challan_copy`, `notes`, `created_at`, `updated_at`) VALUES
(1, '2024-08-29', 8, 5000.00, 0, 91, NULL, NULL, NULL, NULL, 1, 1, 156, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-1', 1, 'JV-1', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(2, '2024-08-29', 9, 5000.00, 0, 156, NULL, NULL, NULL, NULL, 1, 2, 156, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-1', 2, 'JV-1', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(3, '2024-08-29', 12, 3000.00, 0, 1, 1, NULL, NULL, NULL, NULL, NULL, 156, NULL, 1, NULL, 2, 0, '2024-2025', 1, 'CV-1-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(4, '2024-08-29', 2, 3000.00, 0, 156, 1, NULL, 1, NULL, NULL, NULL, 156, NULL, 1, NULL, 2, 0, '2024-2025', 1, 'CV-1-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:42:31', '2024-08-29 11:42:31'),
(5, '2024-08-29', 12, 200.00, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, 156, NULL, 1, NULL, 2, 0, '2024-2025', 2, 'CV-2-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-08-29 11:43:35', '2024-08-29 11:43:35'),
(6, '2024-08-29', 2, 200.00, 0, 156, 2, NULL, 2, NULL, NULL, NULL, 156, NULL, 1, NULL, 2, 0, '2024-2025', 2, 'CV-2-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-08-29 11:43:35', '2024-08-29 11:43:35'),
(7, '2024-08-29', 8, 87400.00, 0, 91, NULL, NULL, NULL, NULL, 2, 3, 157, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-2', 1, 'JV-2', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(8, '2024-08-29', 9, 87400.00, 0, 157, NULL, NULL, NULL, NULL, 2, 4, 157, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-2', 2, 'JV-2', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(9, '2024-08-29', 12, 7400.00, 0, 1, 3, NULL, NULL, NULL, NULL, NULL, 157, NULL, 1, NULL, 2, 0, '2024-2025', 3, 'CV-3-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(10, '2024-08-29', 2, 7400.00, 0, 157, 3, NULL, 3, NULL, NULL, NULL, 157, NULL, 1, NULL, 2, 0, '2024-2025', 3, 'CV-3-10001', NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test Note', '2024-08-29 11:53:32', '2024-08-29 11:53:32'),
(11, '2024-08-30', 8, 20000.00, 0, 92, NULL, NULL, NULL, NULL, 3, 5, 92, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-3', 1, 'JV-3', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Finished Goods', '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(12, '2024-08-30', 9, 20000.00, 0, 91, NULL, NULL, NULL, NULL, 3, 6, 92, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, 'JV-3', 2, 'JV-3', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Row Material Consumption', '2024-08-30 06:10:41', '2024-08-30 06:10:41'),
(13, '2024-09-01', 9, 9500.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(14, '2024-09-01', 9, 500.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, NULL, 2, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(15, NULL, 12, 8000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(16, '2024-09-01', 2, 8000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-09-01 07:07:45', '2024-09-01 07:07:45'),
(17, '2024-09-01', NULL, 1900.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(18, NULL, NULL, 1000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(19, '2024-09-01', 2, 1000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Test', '2024-09-01 07:20:08', '2024-09-01 07:20:08'),
(20, '2024-09-01', NULL, 2000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Finished Goods', '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(21, '2024-09-01', 9, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Raw Material Consumption', '2024-09-01 07:41:07', '2024-09-01 07:41:07'),
(22, '2024-09-01', NULL, 4000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Finished Goods', '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(23, '2024-09-01', 9, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Raw Material Consumption', '2024-09-01 07:41:52', '2024-09-01 07:41:52'),
(24, '2024-09-01', NULL, 2990.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 08:38:38', '2024-09-01 08:38:38'),
(25, '2024-09-01', NULL, 10.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 08:38:38', '2024-09-01 08:38:38'),
(26, NULL, NULL, 200.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 08:38:38', '2024-09-01 08:38:38'),
(27, '2024-09-01', 2, 200.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 0, '2024-2025', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2024-09-01 08:38:38', '2024-09-01 08:38:38'),
(28, '2024-09-01', NULL, 4000.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, 1, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Finished Goods', '2024-09-01 08:43:49', '2024-09-01 08:43:49'),
(29, '2024-09-01', NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Raw Material Consumption', '2024-09-01 08:43:49', '2024-09-01 08:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'PCS', '1', '2023-06-14 03:31:26', '2023-06-14 03:31:26'),
(2, 'Inch\"', '1', '2023-06-14 03:33:06', '2023-06-14 03:33:06'),
(3, 'SET', '1', '2023-06-22 16:40:12', '2023-06-22 16:40:12'),
(4, 'm.m', '1', '2023-06-22 17:44:43', '2023-09-21 23:35:11'),
(5, 'test', '0', '2024-09-01 06:36:41', '2024-09-01 06:37:05'),
(6, 'Testing', '0', '2024-09-01 08:36:35', '2024-09-01 08:36:48');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` tinyint(4) DEFAULT 1 COMMENT '1=Admin,2=Technician ',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `employee_id`, `name`, `username`, `email`, `role`, `email_verified_at`, `password`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Manufacturing Erp Admin', 'Safety Mark', 'admin@gmail.com', 1, NULL, '$2y$10$oBDQ28J5yrzzJB9qL/4PSOlI5mMpJS9ecsF7LcEhYiV8k0.0R9v1C', 1, 'WXAVOhgHAneXeR1hrksx1YIkWvuRx7mxgDArSosDQiuNhat383IomWKjj2mO', '2022-04-21 05:45:37', '2023-01-31 14:45:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `config_products`
--
ALTER TABLE `config_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `config_product_details`
--
ALTER TABLE `config_product_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `finished_goods`
--
ALTER TABLE `finished_goods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `finished_goods_row_materials`
--
ALTER TABLE `finished_goods_row_materials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory_logs`
--
ALTER TABLE `inventory_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `models`
--
ALTER TABLE `models`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_order_products`
--
ALTER TABLE `purchase_order_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_logs`
--
ALTER TABLE `transaction_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `config_products`
--
ALTER TABLE `config_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `config_product_details`
--
ALTER TABLE `config_product_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finished_goods`
--
ALTER TABLE `finished_goods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `finished_goods_row_materials`
--
ALTER TABLE `finished_goods_row_materials`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inventories`
--
ALTER TABLE `inventories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `inventory_logs`
--
ALTER TABLE `inventory_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `models`
--
ALTER TABLE `models`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT for table `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchase_order_products`
--
ALTER TABLE `purchase_order_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `transaction_logs`
--
ALTER TABLE `transaction_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
