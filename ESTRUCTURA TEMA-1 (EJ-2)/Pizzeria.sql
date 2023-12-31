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
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` INT NOT NULL,
  `Localidad` VARCHAR(45) NOT NULL,
  `Provicnia` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
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
-- Table `mydb`.`Comanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comanda` (
  `Id_comanda` INT NOT NULL AUTO_INCREMENT,
  `Fecha_pedido` DATE NOT NULL,
  `tipo_venta` ENUM('reparto', 'recoger') NOT NULL,
  `Cantidad_productos` INT NOT NULL,
  `Precio` INT NOT NULL,
  `iId_cliente` INT NOT NULL,
  `Id_botiga` INT NOT NULL,
  PRIMARY KEY (`Id_comanda`),
  INDEX `fk_Comanda_Client1_idx` (`iId_cliente` ASC) VISIBLE,
  INDEX `fk_Comanda_Botiga1_idx` (`Id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_Comanda_Client1`
    FOREIGN KEY (`iId_cliente`)
    REFERENCES `mydb`.`Client` (`Id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comanda_Botiga1`
    FOREIGN KEY (`Id_botiga`)
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
  `Id_categoria` INT NOT NULL,
  PRIMARY KEY (`ID_Producte`, `Descripcion`),
  INDEX `fk_Producte_Categoria1_idx` (`Id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Producte_Categoria1`
    FOREIGN KEY (`Id_categoria`)
    REFERENCES `mydb`.`Categoria` (`Id_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `id_entrega` INT NOT NULL,
  `id_empleado` INT NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `id_comanda` INT NOT NULL,
  PRIMARY KEY (`id_entrega`),
  INDEX `fk_Entrega_Comanda1_idx` (`id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Comanda1`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `mydb`.`Comanda` (`Id_comanda`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empleat` (
  `Id_empleat` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido_1` VARCHAR(45) NULL,
  `Apellido_2` VARCHAR(45) NULL,
  `Nif` INT NULL,
  `Telefon` INT NULL,
  `Tipus` ENUM('cuiner', 'repartidor') NULL,
  `id_entrega` INT NOT NULL,
  `Id_botiga` INT NOT NULL,
  PRIMARY KEY (`Id_empleat`),
  INDEX `fk_Empleat_Entrega1_idx` (`id_entrega` ASC) VISIBLE,
  INDEX `fk_Empleat_Botiga1_idx` (`Id_botiga` ASC) VISIBLE,
  CONSTRAINT `fk_Empleat_Entrega1`
    FOREIGN KEY (`id_entrega`)
    REFERENCES `mydb`.`Entrega` (`id_entrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empleat_Botiga1`
    FOREIGN KEY (`Id_botiga`)
    REFERENCES `mydb`.`Botiga` (`Id_botiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TicketComanda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TicketComanda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_Producte` INT NOT NULL,
  `Id_comanda` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_InfoPedido_Producte1_idx` (`id_Producte` ASC) VISIBLE,
  INDEX `fk_InfoPedido_Comanda1_idx` (`Id_comanda` ASC) VISIBLE,
  CONSTRAINT `fk_InfoPedido_Producte1`
    FOREIGN KEY (`id_Producte`)
    REFERENCES `mydb`.`Producte` (`ID_Producte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_InfoPedido_Comanda1`
    FOREIGN KEY (`Id_comanda`)
    REFERENCES `mydb`.`Comanda` (`Id_comanda`)
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
-- Data for table `mydb`.`Comanda`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha_pedido`, `tipo_venta`, `Cantidad_productos`, `Precio`, `iId_cliente`, `Id_botiga`) VALUES (1, '2022-06-12', 'reparto', 3, 30, DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha_pedido`, `tipo_venta`, `Cantidad_productos`, `Precio`, `iId_cliente`, `Id_botiga`) VALUES (2, '2021-08-05', 'recoger', 4, 25, DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Comanda` (`Id_comanda`, `Fecha_pedido`, `tipo_venta`, `Cantidad_productos`, `Precio`, `iId_cliente`, `Id_botiga`) VALUES (3, '2020-11-23', 'recoger', 1, 20, DEFAULT, DEFAULT);

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
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Id_categoria`) VALUES (1, 'hawaiana', 'pizza de jamon y piña', NULL, 20, 'pìzza', DEFAULT);
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Id_categoria`) VALUES (2, 'completa', 'hamburguesa con todo', NULL, 12, 'hamburguesa', DEFAULT);
INSERT INTO `mydb`.`Producte` (`ID_Producte`, `Nombre`, `Descripcion`, `Imagen`, `Precio`, `Tipo`, `Id_categoria`) VALUES (3, 'con gas', 'bebida con gas', NULL, 2, 'beguda', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Empleat`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `Nif`, `Telefon`, `Tipus`, `id_entrega`, `Id_botiga`) VALUES (1, 'Luis', 'Garcia', 'Perez', 12312312A, 9301010101010, 'cuiner', DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `Nif`, `Telefon`, `Tipus`, `id_entrega`, `Id_botiga`) VALUES (2, 'Pedro', 'Marquez', 'Lopez', 52453456B, 9312312343, 'repartidor', DEFAULT, DEFAULT);
INSERT INTO `mydb`.`Empleat` (`Id_empleat`, `Nombre`, `Apellido_1`, `Apellido_2`, `Nif`, `Telefon`, `Tipus`, `id_entrega`, `Id_botiga`) VALUES (3, 'Maria', 'Galindo', 'Fernandez', 12312312E, 9312312333, 'cuiner', DEFAULT, DEFAULT);

COMMIT;

