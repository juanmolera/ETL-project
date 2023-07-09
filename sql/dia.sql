-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dia
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dia` DEFAULT CHARACTER SET utf8 ;
USE `dia` ;

-- -----------------------------------------------------
-- Table `dia`.`supermarket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dia`.`supermarket` (
  `idsupermarket` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idsupermarket`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dia`.`category` (
  `idcategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia`.`history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dia`.`history` (
  `idhistory` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idhistory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dia`.`product` (
  `idproduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `price` FLOAT NULL,
  `reference_price` FLOAT NULL,
  `reference_unit` VARCHAR(45) NULL,
  `supermarket_idsupermarket` INT NOT NULL,
  `category_idcategory` INT NOT NULL,
  `history_idhistory` INT NOT NULL,
  PRIMARY KEY (`idproduct`),
  INDEX `fk_product_supermarket_idx` (`supermarket_idsupermarket` ASC) VISIBLE,
  INDEX `fk_product_category1_idx` (`category_idcategory` ASC) VISIBLE,
  INDEX `fk_product_history1_idx` (`history_idhistory` ASC) VISIBLE,
  CONSTRAINT `fk_product_supermarket`
    FOREIGN KEY (`supermarket_idsupermarket`)
    REFERENCES `dia`.`supermarket` (`idsupermarket`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_idcategory`)
    REFERENCES `dia`.`category` (`idcategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_history1`
    FOREIGN KEY (`history_idhistory`)
    REFERENCES `dia`.`history` (`idhistory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dia`.`url_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dia`.`url_product` (
  `idurl_product` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(200) NOT NULL,
  `product_idproduct` INT NOT NULL,
  PRIMARY KEY (`idurl_product`),
  INDEX `fk_url_product_product1_idx` (`product_idproduct` ASC) VISIBLE,
  CONSTRAINT `fk_url_product_product1`
    FOREIGN KEY (`product_idproduct`)
    REFERENCES `dia`.`product` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
