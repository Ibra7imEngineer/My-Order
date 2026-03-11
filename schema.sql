-- My Order - MySQL schema
USE `myorder`;

CREATE TABLE IF NOT EXISTS `orders` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(60) NOT NULL,
  `customer_name` VARCHAR(191) NOT NULL,
  `customer_phone` VARCHAR(32) NOT NULL,
  `customer_address` TEXT,
  `items` LONGTEXT NOT NULL,
  `subtotal` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `shipping` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `status` VARCHAR(50) NOT NULL DEFAULT 'جديد',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `activity_logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `activity_type` VARCHAR(100) NOT NULL,
  `user_type` VARCHAR(50) NOT NULL DEFAULT 'customer',
  `user_id` VARCHAR(191),
  `user_name` VARCHAR(191),
  `user_ip` VARCHAR(45),
  `item_id` VARCHAR(191),
  `item_name` TEXT,
  `action` VARCHAR(500) NOT NULL,
  `old_value` LONGTEXT,
  `new_value` LONGTEXT,
  `status` VARCHAR(50),
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_activity_type` (`activity_type`),
  KEY `idx_created_at` (`created_at`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `user_sessions` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_type` VARCHAR(50) NOT NULL DEFAULT 'customer',
  `user_id` VARCHAR(191),
  `user_name` VARCHAR(191),
  `session_token` VARCHAR(255),
  `user_ip` VARCHAR(45),
  `user_agent` TEXT,
  `action` VARCHAR(100) NOT NULL DEFAULT 'login',
  `status` VARCHAR(50),
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ended_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  KEY `idx_session_token` (`session_token`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `order_history` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(60) NOT NULL,
  `action` VARCHAR(100) NOT NULL,
  `old_status` VARCHAR(50),
  `new_status` VARCHAR(50),
  `changed_by` VARCHAR(191),
  `change_reason` TEXT,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `sales_log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` VARCHAR(60) NOT NULL,
  `product_id` VARCHAR(191),
  `product_name` VARCHAR(191),
  `quantity` INT DEFAULT 1,
  `unit_price` DECIMAL(10,2),
  `total_price` DECIMAL(10,2),
  `customer_name` VARCHAR(191),
  `payment_method` VARCHAR(100),
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- سجل رسائل نموذج "تواصل معنا"
CREATE TABLE IF NOT EXISTS `contact_messages` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(191) NOT NULL,
  `email` VARCHAR(191) NOT NULL,
  `phone` VARCHAR(45) NULL,
  `subject` VARCHAR(255) DEFAULT NULL,
  `message` LONGTEXT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

