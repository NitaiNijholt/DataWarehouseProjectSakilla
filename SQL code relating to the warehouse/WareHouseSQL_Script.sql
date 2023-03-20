-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sakila_warehouse
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sakila_warehouse` ;

-- -----------------------------------------------------
-- Schema sakila_warehouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sakila_warehouse` DEFAULT CHARACTER SET utf8 ;
USE `sakila_warehouse` ;

-- -----------------------------------------------------
-- Table `sakila_warehouse`.`Date_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila_warehouse`.`Date_table` ;

CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`Date_table` (
  `Date_key` INT NOT NULL AUTO_INCREMENT,
  `Day` DATE NOT NULL,
  `Month` VARCHAR(45) NOT NULL,
  `Year` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Date_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`Film_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila_warehouse`.`Film_table` ;

CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`Film_table` (
  `Film_key` INT NOT NULL AUTO_INCREMENT,
  `Film_name` VARCHAR(45) NOT NULL,
  `Category` VARCHAR(45) NOT NULL,
  `Language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Film_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`Store_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila_warehouse`.`Store_table` ;

CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`Store_table` (
  `Store_key` INT NOT NULL AUTO_INCREMENT,
  `Store` VARCHAR(45) NOT NULL,
  `Staff` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Store_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`Customer_table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila_warehouse`.`Customer_table` ;

CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`Customer_table` (
  `Customer_key` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Customer_Name` VARCHAR(45) NOT NULL,
  `Customer_Activity` INT NOT NULL,
  PRIMARY KEY (`Customer_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`Fact_Table`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila_warehouse`.`Fact_Table` ;

CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`Fact_Table` (
  `Payments` DECIMAL(5,2) NOT NULL,
  `Replacement_Cost` DECIMAL(5,2) NOT NULL,
  `Rental_duration` INT NOT NULL,
  `Date_key` INT NOT NULL,
  `Film_key` INT NOT NULL,
  `Store_key` INT NOT NULL,
  `Customer_key` INT NOT NULL,
  INDEX `fk_Fact_Table_Date_table_idx` (`Date_key` ASC) VISIBLE,
  INDEX `fk_Fact_Table_Film_table1_idx` (`Film_key` ASC) VISIBLE,
  INDEX `fk_Fact_Table_Store_table1_idx` (`Store_key` ASC) VISIBLE,
  INDEX `fk_Fact_Table_Customer_table1_idx` (`Customer_key` ASC) VISIBLE,
  PRIMARY KEY (`Film_key`, `Store_key`, `Customer_key`, `Date_key`),
  CONSTRAINT `fk_Fact_Table_Date_table`
    FOREIGN KEY (`Date_key`)
    REFERENCES `sakila_warehouse`.`Date_table` (`Date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Table_Film_table1`
    FOREIGN KEY (`Film_key`)
    REFERENCES `sakila_warehouse`.`Film_table` (`Film_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Table_Store_table1`
    FOREIGN KEY (`Store_key`)
    REFERENCES `sakila_warehouse`.`Store_table` (`Store_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fact_Table_Customer_table1`
    FOREIGN KEY (`Customer_key`)
    REFERENCES `sakila_warehouse`.`Customer_table` (`Customer_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


