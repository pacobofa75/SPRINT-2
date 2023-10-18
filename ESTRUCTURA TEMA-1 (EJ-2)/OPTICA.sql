-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OPTICA_CUL_DAMPOLLA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OPTICA_CUL_DAMPOLLA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OPTICA_CUL_DAMPOLLA` DEFAULT CHARACTER SET utf8 ;
USE `OPTICA_CUL_DAMPOLLA` ;

-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Proveedores` (
  `id_Proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` VARCHAR(45) NULL,
  `direccion_proveedor` VARCHAR(45) NULL,
  `telefono_proveedor` INT NULL,
  `fax_proveedor` INT NULL,
  `NIF_proveedor` VARCHAR(10) NULL,
  PRIMARY KEY (`id_Proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Marca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Marca` (
  `id_marca` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_Proveedor` INT NOT NULL,
  PRIMARY KEY (`id_marca`),
  INDEX `fk_Marca_Proveedores1_idx` (`id_Proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Proveedores1`
    FOREIGN KEY (`id_Proveedor`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Proveedores` (`id_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Gafas` (
  `id_gafas` INT NOT NULL AUTO_INCREMENT,
  `id_marca` INT NULL,
  `graduacion_dcha` DECIMAL NULL,
  `graduacion_izda` DECIMAL NULL,
  `tipo:montura` ENUM('flotante', ' pasta', 'metalica') NULL,
  `color_motura` VARCHAR(45) NULL,
  `color_cristales` VARCHAR(45) NULL,
  `precio` DECIMAL(2) NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `id_marca` () VISIBLE,
  INDEX `id_marca_idx` (`id_marca` ASC) VISIBLE,
  CONSTRAINT `id_marca`
    FOREIGN KEY (`id_marca`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Marca` (`id_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Clientes` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `Cliente _recomendado` INT NOT NULL,
  PRIMARY KEY (`id_cliente`),
  INDEX `Cliente_recomendado` (`Cliente _recomendado` ASC) INVISIBLE,
  CONSTRAINT `Cliente_recomendado`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Clientes` (`Cliente _recomendado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Empleados` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA_CUL_DAMPOLLA`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA_CUL_DAMPOLLA`.`Ventas` (
  `id_ventas` INT NOT NULL AUTO_INCREMENT,
  `fecha_venta` DATE NULL,
  `id_empleado` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `id_gafas` INT NOT NULL,
  PRIMARY KEY (`id_ventas`, `id_cliente`),
  INDEX `fk_Ventas_Empleados1_idx` (`id_empleado` ASC) VISIBLE,
  INDEX `fk_Ventas_Clientes1_idx` (`id_cliente` ASC) VISIBLE,
  INDEX `fk_Ventas_Gafas1_idx` (`id_gafas` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Empleados1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Empleados` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Clientes1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Clientes` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Gafas1`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `OPTICA_CUL_DAMPOLLA`.`Gafas` (`id_gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
