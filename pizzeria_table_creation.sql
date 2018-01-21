CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `contact` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ;

CREATE TABLE `registered_customers` (
  `reg_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `DOB` varchar(20) DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`reg_id`),
  KEY `f11_idx` (`customer_id`),
  CONSTRAINT `f11` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `rating` decimal(4,2) DEFAULT NULL,
  `review` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  KEY `f8_idx` (`customer_id`),
  CONSTRAINT `f10` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `menu` (
  `item_id` varchar(45) NOT NULL,
  `item_name` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `availibility` tinyint(4) DEFAULT NULL,
  `small_price` decimal(6,2) DEFAULT NULL,
  `medium_price` decimal(6,2) DEFAULT NULL,
  `large_price` decimal(6,2) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
);

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `category` varchar(45) NOT NULL,
  `contact` varchar(45) NOT NULL,
  PRIMARY KEY (`staff_id`)
) ;



CREATE TABLE `customized_pizza` (
  `cp_id` varchar(45) NOT NULL,
  `item_id` varchar(45) NOT NULL,
  PRIMARY KEY (`cp_id`,`item_id`),
  KEY `f13_idx` (`item_id`),
  CONSTRAINT `f13` FOREIGN KEY (`item_id`) REFERENCES `menu` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'PENDING',
  `total_price` decimal(5,2) DEFAULT NULL,
  `order_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `f5_idx` (`customer_id`),
  CONSTRAINT `f5` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;

CREATE TABLE `order_details` (
  `od_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `item_id` varchar(45) DEFAULT NULL,
  `cp_id` varchar(45) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`od_id`),
  KEY `f8_idx` (`item_id`),
  KEY `f16_idx` (`cp_id`),
  KEY `f6_idx` (`order_id`),
  CONSTRAINT `f16` FOREIGN KEY (`cp_id`) REFERENCES `customized_pizza` (`cp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f6` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f8` FOREIGN KEY (`item_id`) REFERENCES `menu` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `cart` (
  `customer_id` int(11) NOT NULL,
  `cart_item_id` int(11) NOT NULL,
  `cp_id` varchar(45) DEFAULT NULL,
  `item_id` varchar(45) DEFAULT NULL,
  `size` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`cart_item_id`),
  KEY `f4_idx` (`item_id`),
  KEY `f15_idx` (`cp_id`),
  CONSTRAINT `f15` FOREIGN KEY (`cp_id`) REFERENCES `customized_pizza` (`cp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f4` FOREIGN KEY (`item_id`) REFERENCES `menu` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);