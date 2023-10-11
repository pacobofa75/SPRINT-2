-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `Id_cliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `codigo_postal` INT NULL,
  `Localidad` VARCHAR(45) NULL,
  `Provicnia` VARCHAR(45) NULL,
  `Telefono` INT NULL,
  PRIMARY KEY (`Id_cliente`))
ENGINE = InnoDB
COMMENT = '					';


-- -----------------------------------------------------
-- Table `mydb`.`Botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Botiga` (
  `Id_botiga` INT NOT NULL AUTO_INCREMENT,
  `Direccion` VARCHAR(45) NULL,
  `Codigo_postal` INT NULL,
  `Localitat` VARCHAR(45) NULL,
  `Provincia` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_botiga`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleat` (
  `Id_empleat` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido_1` VARCHAR(45) NULL,
  `Apellido_2` VARCHAR(45) NULL,
  `NIF` INT NULL,
  `Telefon` INT NULL,
  `Tipus` ENUM('cuiner', 'repartidor') NULL,
  `Botiga_Id_botiga` INT NOT NULL,
  PRIMARY KEY (`Id_empleat`, `Botiga_Id_botiga`),
  INDEX `fk_Empleat_Botiga1_idx` (`Botiga_Id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_Empleat_Botiga1`
    FOREIGN KEY (`Botiga_Id_botiga`)
    REFERENCES `mydb`.`Botiga` (`Id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Categoria` (
  `Id_categoria` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producte` (
  `ID_Producte` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  `Imagen` VARCHAR(45) NULL,
  `Precio` INT NULL,
  `Tipo` ENUM('pizza', 'hamburguesa', 'beguda') NULL,
  `Categoria_Id_categoria` INT NOT NULL,
  PRIMARY KEY (`ID_Producte`, `Descripcion`),
  INDEX `fk_Producte_Categoria1_idx` (`Categoria_Id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producte_Categoria1`
    FOREIGN KEY (`Categoria_Id_categoria`)
    REFERENCES `mydb`.`Categoria` (`Id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comanda` (
  `Id_comanda` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATE NULL,
  `tipo_venta` ENUM('reparto', 'recoger') NULL,
  `Cantidad_productos` INT NULL,
  `Precio` INT NULL,
  `Id_cliente` INT NULL,
  `Tipo_Productos` ENUM('pizza', 'hamburguesa', 'beguda') NULL,
  `Client_Id_cliente` INT NOT NULL,
  `Botiga_Id_botiga` INT NOT NULL,
  `Empleat_Id_empleat` INT NOT NULL,
  `Empleat_Botiga_Id_botiga` INT NOT NULL,
  `Producte_ID_Producte` INT NOT NULL,
  `Producte_Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_comanda`),
  INDEX `fk_Comanda_Client1_idx` (`Client_Id_cliente` ASC) VISIBLE,
  INDEX `fk_Comanda_Botiga1_idx` (`Botiga_Id_botiga` ASC) VISIBLE,
  INDEX `fk_Comanda_Empleat1_idx` (`Empleat_Id_empleat` ASC, `Empleat_Botiga_Id_botiga` ASC) VISIBLE,
  INDEX `fk_Comanda_Producte1_idx` (`Producte_ID_Producte` ASC, `Producte_Descripcion` ASC) VISIBLE,
  CONSTRAINT `fk_Comanda_Client1`
    FOREIGN KEY (`Client_Id_cliente`)
    REFERENCES `mydb`.`Client` (`Id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Botiga1`
    FOREIGN KEY (`Botiga_Id_botiga`)
    REFERENCES `mydb`.`Botiga` (`Id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Empleat1`
    FOREIGN KEY (`Empleat_Id_empleat` , `Empleat_Botiga_Id_botiga`)
    REFERENCES `mydb`.`Empleat` (`Id_empleat` , `Botiga_Id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Producte1`
    FOREIGN KEY (`Producte_ID_Producte` , `Producte_Descripcion`)
    REFERENCES `mydb`.`Producte` (`ID_Producte` , `Descripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Client`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Client` (`Id_cliente`, `Nombre`, `Apellido`, `Direccion`, `codigo_postal`, `Localidad`, `Provicnia`, `Telefono`) VALUES (DEFAULT, 'Paco', 'Bofa', 'Calle 1', 08001, 'Barcelona', 'Barcelona', 111111111);
INSERT INTO `mydb`.`Client` (`Id_cliente`, `Nombre`, `Apellido`, `Direccion`, `codigo_postal`, `Localidad`, `Provicnia`, `Telefono`) VALUES (DEFAULT, 'Luis', 'Garcia ', 'Calle 2', 08002, 'Barcelona', 'Barcelona', 222222222);
INSERT INTO `mydb`.`Client` (`Id_cliente`, `Nombre`, `Apellido`, `Direccion`, `codigo_postal`, `Localidad`, `Provicnia`, `Telefono`) VALUES (DEFAULT, 'Marco', 'Martin', 'Calle 3', 08003, 'Girona', 'Girona', 333333333);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Botiga`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Botiga` (`Id_botiga`, `Direccion`, `Codigo_postal`, `Localitat`, `Provincia`) VALUES (1, 'Calle 21', 08001, 'Barcelona', 'Barcelona');
INSERT INTO `mydb`.`Botiga` (`Id_botiga`, `Direccion`, `Codigo_postal`, `Localitat`, `Provincia`) VALUES (2, 'Calle 32', 08002, 'Girona', 'Girona');
INSERT INTO `mydb`.`Botiga` (`Id_botiga`, `Direccion`, `Codigo_postal`, `Localitat`, `Provincia`) VALUES (3, 'Calle 43', 08001, 'Barcelona', 'Barcelona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Empleat`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `NIF`, `Telefon`, `Tipus`, `Botiga_Id_botiga`) VALUES (1, 'Luis', 'Garcia', 'Perez', 12312312A, 9301010101010, 'cuiner', DEFAULT);
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `NIF`, `Telefon`, `Tipus`, `Botiga_Id_botiga`) VALUES (2, 'Pedro', 'Marquez', 'Lopez', 52453456B, 9312312343, 'repartidor', DEFAULT);
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `NIF`, `Telefon`, `Tipus`, `Botiga_Id_botiga`) VALUES (3, 'Maria', 'Galindo', 'Fernandez', 12312312E, 9312312333, 'cuiner', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Categoria`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Categoria` (`Id_categoria`, `Nombre`) VALUES (1, 'Primavera');
INSERT INTO `mydb`.`Categoria` (`Id_categoria`, `Nombre`) VALUES (2, 'Verano');
INSERT INTO `mydb`.`Categoria` (`Id_categoria`, `Nombre`) VALUES (3, 'Otoño');
INSERT INTO `mydb`.`Categoria` (`Id_categoria`, `Nombre`) VALUES (4, 'Invierno');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Producte`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Categoria_Id_categoria`) VALUES (1, 'hawaiana', 'pizza de jamon y piña', NULL, 20, 'pìzza', DEFAULT);
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Categoria_Id_categoria`) VALUES (2, 'completa', 'hamburguesa con todo', NULL, 12, 'hamburguesa', DEFAULT);
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Categoria_Id_categoria`) VALUES (3, 'con gas', 'bebida con gas', NULL, 2, 'beguda', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Comanda`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha`, `tipo_venta`, `Cantidad_productos`, `Precio`, `Id_cliente`, `Tipo_Productos`, `Client_Id_cliente`, `Botiga_Id_botiga`, `Empleat_Id_empleat`, `Empleat_Botiga_Id_botiga`, `Producte_ID_Producte`, `Producte_Descripcion`) VALUES (1, '2022-06-12', 'reparto', 3, 30, 2, 'pizza', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha`, `tipo_venta`, `Cantidad_productos`, `Precio`, `Id_cliente`, `Tipo_Productos`, `Client_Id_cliente`, `Botiga_Id_botiga`, `Empleat_Id_empleat`, `Empleat_Botiga_Id_botiga`, `Producte_ID_Producte`, `Producte_Descripcion`) VALUES (2, '2021-08-05', 'recoger', 4, 25, 1, 'hamburguesa', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha`, `tipo_venta`, `Cantidad_productos`, `Precio`, `Id_cliente`, `Tipo_Productos`, `Client_Id_cliente`, `Botiga_Id_botiga`, `Empleat_Id_empleat`, `Empleat_Botiga_Id_botiga`, `Producte_ID_Producte`, `Producte_Descripcion`) VALUES (3, '2020-11-23', 'recoger', 1, 20, 3, 'beguda', DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

COMMIT;

