SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `food` ;
CREATE SCHEMA IF NOT EXISTS `food` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `food` ;

-- -----------------------------------------------------
-- Table `food`.`tbl_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_user` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `prefecture_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_region`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_region` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `descript` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_prefecture`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_prefecture` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_prefecture` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `region_id` INT NULL,
  `descript` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_prefecture_1_idx` (`region_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_recipe` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_recipe` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `intro` VARCHAR(45) NULL,
  `instruction` VARCHAR(45) NULL,
  `image` VARCHAR(256) NULL,
  `prefecture_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_recipe_1_idx` (`prefecture_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_ingredient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_ingredient` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_ingredient` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `unit` VARCHAR(45) NULL,
  `IU` FLOAT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_available`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_available` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_available` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amount` FLOAT NULL,
  `ingredient_id` INT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_available_1_idx` (`ingredient_id` ASC),
  INDEX `fk_tbl_available_2_idx` (`user_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_meta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_meta` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_meta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `IF` FLOAT NULL,
  `MA` FLOAT NULL,
  `FI` FLOAT NULL,
  `ingredient_id` INT NULL,
  `prefecture_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tbl_meta_1_idx` (`ingredient_id` ASC),
  INDEX `fk_tbl_meta_2_idx` (`prefecture_id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `food`.`tbl_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `food`.`tbl_content` ;

CREATE TABLE IF NOT EXISTS `food`.`tbl_content` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `recipe_id` INT NULL,
  `ingredient_id` INT NULL,
  `amount` FLOAT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_content_1_idx` (`ingredient_id` ASC),
  INDEX `fk_content_2_idx` (`recipe_id` ASC))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
