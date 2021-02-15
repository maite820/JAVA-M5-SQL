-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema OPTICA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OPTICA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OPTICA` DEFAULT CHARACTER SET utf8 ;
USE `OPTICA` ;

-- -----------------------------------------------------
-- Table `OPTICA`.`direccion_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`direccion_usuario` (
  `iddireccion_usuario` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(45) NULL,
  `numero` INT NULL,
  `piso` INT NULL,
  `puerta` INT NULL,
  `ciudad` VARCHAR(25) NULL,
  `codigo postal` INT NULL,
  `pais` VARCHAR(15) NULL,
  PRIMARY KEY (`iddireccion_usuario`),
  UNIQUE INDEX `iddireccion_usuario_UNIQUE` (`iddireccion_usuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Proveedor` (
  `idProveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NOT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  `direccion_usuario_iddireccion_usuario` INT NOT NULL,
  PRIMARY KEY (`idProveedor`),
  UNIQUE INDEX `idProveedor_UNIQUE` (`idProveedor` ASC),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC),
  INDEX `fk_Proveedor_direccion_usuario1_idx` (`direccion_usuario_iddireccion_usuario` ASC),
  CONSTRAINT `fk_Proveedor_direccion_usuario1`
    FOREIGN KEY (`direccion_usuario_iddireccion_usuario`)
    REFERENCES `OPTICA`.`direccion_usuario` (`iddireccion_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Clientes` (
  `idClientes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre_cliente` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `email` VARCHAR(25) NULL,
  `fecha_inicio` DATE NOT NULL,
  `id_clienterecomendado` INT NULL,
  `direccion_usuario_iddireccion_usuario` INT NOT NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `idClientes_UNIQUE` (`idClientes` ASC),
  INDEX `fk_Clientes_direccion_usuario1_idx` (`direccion_usuario_iddireccion_usuario` ASC),
  CONSTRAINT `fk_Clientes_direccion_usuario1`
    FOREIGN KEY (`direccion_usuario_iddireccion_usuario`)
    REFERENCES `OPTICA`.`direccion_usuario` (`iddireccion_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Pedido_venta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Pedido_venta` (
  `idPedido_venta` INT NOT NULL AUTO_INCREMENT,
  `fecha_pedido` DATE NULL,
  `cantidad` INT NULL,
  `total` FLOAT NULL,
  `Clientes_idClientes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPedido_venta`),
  UNIQUE INDEX `idPedido_venta_UNIQUE` (`idPedido_venta` ASC),
  INDEX `fk_Pedido_venta_Clientes1_idx` (`Clientes_idClientes` ASC),
  CONSTRAINT `fk_Pedido_venta_Clientes1`
    FOREIGN KEY (`Clientes_idClientes`)
    REFERENCES `OPTICA`.`Clientes` (`idClientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Colores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Colores` (
  `idColores` INT NOT NULL AUTO_INCREMENT,
  `nombre_color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idColores`),
  UNIQUE INDEX `idColores_UNIQUE` (`idColores` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Color_vidrio1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Color_vidrio1` (
  `idColor_vidrio1` INT NOT NULL AUTO_INCREMENT,
  `Colores_idColores` INT NOT NULL,
  PRIMARY KEY (`idColor_vidrio1`),
  UNIQUE INDEX `idColor_vidrio1_UNIQUE` (`idColor_vidrio1` ASC),
  INDEX `fk_Color_vidrio1_Colores1_idx` (`Colores_idColores` ASC),
  CONSTRAINT `fk_Color_vidrio1_Colores1`
    FOREIGN KEY (`Colores_idColores`)
    REFERENCES `OPTICA`.`Colores` (`idColores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Color_vidrio2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Color_vidrio2` (
  `idColor_vidrio2` INT NOT NULL AUTO_INCREMENT,
  `Colores_idColores` INT NOT NULL,
  PRIMARY KEY (`idColor_vidrio2`),
  UNIQUE INDEX `idColor_vidrio2_UNIQUE` (`idColor_vidrio2` ASC),
  INDEX `fk_Color_vidrio2_Colores1_idx` (`Colores_idColores` ASC),
  CONSTRAINT `fk_Color_vidrio2_Colores1`
    FOREIGN KEY (`Colores_idColores`)
    REFERENCES `OPTICA`.`Colores` (`idColores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Color_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Color_montura` (
  `idColor_montura` INT NOT NULL AUTO_INCREMENT,
  `Colores_idColores` INT NOT NULL,
  PRIMARY KEY (`idColor_montura`),
  UNIQUE INDEX `idColor_montura_UNIQUE` (`idColor_montura` ASC),
  INDEX `fk_Color_montura_Colores1_idx` (`Colores_idColores` ASC),
  CONSTRAINT `fk_Color_montura_Colores1`
    FOREIGN KEY (`Colores_idColores`)
    REFERENCES `OPTICA`.`Colores` (`idColores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Tipo_montura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Tipo_montura` (
  `idTipo_montura` INT NOT NULL AUTO_INCREMENT,
  `Tipo_monturacol` VARCHAR(15) NULL,
  PRIMARY KEY (`idTipo_montura`),
  UNIQUE INDEX `idTipo_montura_UNIQUE` (`idTipo_montura` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Gafas` (
  `idGafas` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(25) NULL,
  `graduacion_vidrios` VARCHAR(45) NULL,
  `precio` FLOAT NULL,
  `Proveedor_idProveedor` INT NOT NULL,
  `Pedido_venta_idPedido_venta` INT NOT NULL,
  `Color_vidrio1_idColor_vidrio1` INT NOT NULL,
  `Color_vidrio2_idColor_vidrio2` INT NOT NULL,
  `Color_montura_idColor_montura` INT NOT NULL,
  `Tipo_montura_idTipo_montura` INT NOT NULL,
  PRIMARY KEY (`idGafas`),
  UNIQUE INDEX `idGafas_UNIQUE` (`idGafas` ASC),
  INDEX `fk_Gafas_Proveedor1_idx` (`Proveedor_idProveedor` ASC),
  INDEX `fk_Gafas_Pedido_venta1_idx` (`Pedido_venta_idPedido_venta` ASC),
  INDEX `fk_Gafas_Color_vidrio11_idx` (`Color_vidrio1_idColor_vidrio1` ASC),
  INDEX `fk_Gafas_Color_vidrio21_idx` (`Color_vidrio2_idColor_vidrio2` ASC),
  INDEX `fk_Gafas_Color_montura1_idx` (`Color_montura_idColor_montura` ASC),
  INDEX `fk_Gafas_Tipo_montura1_idx` (`Tipo_montura_idTipo_montura` ASC),
  CONSTRAINT `fk_Gafas_Proveedor1`
    FOREIGN KEY (`Proveedor_idProveedor`)
    REFERENCES `OPTICA`.`Proveedor` (`idProveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Pedido_venta1`
    FOREIGN KEY (`Pedido_venta_idPedido_venta`)
    REFERENCES `OPTICA`.`Pedido_venta` (`idPedido_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Color_vidrio11`
    FOREIGN KEY (`Color_vidrio1_idColor_vidrio1`)
    REFERENCES `OPTICA`.`Color_vidrio1` (`idColor_vidrio1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Color_vidrio21`
    FOREIGN KEY (`Color_vidrio2_idColor_vidrio2`)
    REFERENCES `OPTICA`.`Color_vidrio2` (`idColor_vidrio2`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Color_montura1`
    FOREIGN KEY (`Color_montura_idColor_montura`)
    REFERENCES `OPTICA`.`Color_montura` (`idColor_montura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gafas_Tipo_montura1`
    FOREIGN KEY (`Tipo_montura_idTipo_montura`)
    REFERENCES `OPTICA`.`Tipo_montura` (`idTipo_montura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `OPTICA`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OPTICA`.`Empleado` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Pedido_venta_idPedido_venta` INT NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  UNIQUE INDEX `idEmpleado_UNIQUE` (`idEmpleado` ASC),
  INDEX `fk_Empleado_Pedido_venta1_idx` (`Pedido_venta_idPedido_venta` ASC),
  CONSTRAINT `fk_Empleado_Pedido_venta1`
    FOREIGN KEY (`Pedido_venta_idPedido_venta`)
    REFERENCES `OPTICA`.`Pedido_venta` (`idPedido_venta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
