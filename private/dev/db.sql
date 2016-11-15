CREATE TABLE `categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_1_idx` (`category_id` ASC),
  CONSTRAINT `fk_products_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT);

CREATE TABLE `stocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `quantity` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_stock_1_idx` (`product_id` ASC),
  CONSTRAINT `fk_stock_1`
  FOREIGN KEY (`product_id`)
  REFERENCES `products` (`id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT);