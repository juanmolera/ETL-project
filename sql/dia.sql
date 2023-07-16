-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema supermarkets
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema supermarkets
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supermarkets` DEFAULT CHARACTER SET utf8 ;
USE `supermarkets` ;

-- -----------------------------------------------------
-- Table `supermarkets`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermarkets`.`category` (
  `idcategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idcategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarkets`.`url`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermarkets`.`url` (
  `idurl` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`idurl`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarkets`.`supermarket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermarkets`.`supermarket` (
  `idsupermarket` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idsupermarket`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supermarkets`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supermarkets`.`product` (
  `idproduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(300) NOT NULL,
  `price` FLOAT NULL,
  `reference_price` FLOAT NULL,
  `reference_unit` VARCHAR(45) NULL,
  `date` DATE NOT NULL,
  `category_idcategory` INT NOT NULL,
  `url_idurl` INT NOT NULL,
  `supermarket_idsupermarket` INT NOT NULL,
  PRIMARY KEY (`idproduct`),
  INDEX `fk_product_category_idx` (`category_idcategory` ASC) VISIBLE,
  INDEX `fk_product_url1_idx` (`url_idurl` ASC) VISIBLE,
  INDEX `fk_product_supermarket1_idx` (`supermarket_idsupermarket` ASC) VISIBLE,
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_idcategory`)
    REFERENCES `supermarkets`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_url1`
    FOREIGN KEY (`url_idurl`)
    REFERENCES `supermarkets`.`url` (`idurl`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_supermarket1`
    FOREIGN KEY (`supermarket_idsupermarket`)
    REFERENCES `supermarkets`.`supermarket` (`idsupermarket`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
