-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Usuario` (
  `idUsuario` INT NOT NULL,
  `email` VARCHAR(20) NOT NULL,
  `password` VARCHAR(10) NOT NULL,
  `NombreUsuario` VARCHAR(10) NULL,
  `FechaNacimiento` DATE NULL,
  `Sexo` VARCHAR(1) NULL,
  `Pais` VARCHAR(15) NULL,
  `CodigoPostal` VARCHAR(8) NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `idUsuario_UNIQUE` (`idUsuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`EstadoVideo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`EstadoVideo` (
  `idEstadoVideo` INT NOT NULL,
  `Estado` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idEstadoVideo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Video` (
  `idVideo` INT NOT NULL,
  `Titulo` VARCHAR(45) NULL,
  `Descripcion` VARCHAR(115) NULL,
  `Grandaria` INT NULL,
  `NombreArchivo` VARCHAR(45) NULL,
  `DuracionVideo` INT NULL,
  `ThumbNail` VARCHAR(45) NULL,
  `NumeroReproducciones` INT NULL,
  `NumeroLikes` INT NULL,
  `NumeroDislikes` INT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `EstadoVideo_idEstadoVideo` INT NOT NULL,
  PRIMARY KEY (`idVideo`),
  UNIQUE INDEX `idVideo_UNIQUE` (`idVideo` ASC),
  INDEX `fk_Video_Usuario_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_Video_EstadoVideo1_idx` (`EstadoVideo_idEstadoVideo` ASC),
  CONSTRAINT `fk_Video_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_EstadoVideo1`
    FOREIGN KEY (`EstadoVideo_idEstadoVideo`)
    REFERENCES `youtube`.`EstadoVideo` (`idEstadoVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Etiqueta` (
  `idEtiqueta` INT NOT NULL,
  `NombreEtiqueta` VARCHAR(45) NOT NULL,
  `Fecha/Hora` DATETIME NOT NULL,
  PRIMARY KEY (`idEtiqueta`),
  UNIQUE INDEX `idEtiqueta_UNIQUE` (`idEtiqueta` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Canal` (
  `idCanal` INT NOT NULL,
  `NombreCanal` VARCHAR(25) NULL,
  `DescripcionCanal` VARCHAR(145) NULL,
  `FechaCreacionCanal` DATE NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idCanal`),
  UNIQUE INDEX `idCanal_UNIQUE` (`idCanal` ASC),
  INDEX `fk_Canal_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Canal_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`VideoEtiquetado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`VideoEtiquetado` (
  `idVideoEtiquetado` INT NOT NULL,
  `Etiqueta_idEtiqueta` INT NOT NULL,
  `Video_idVideo` INT NOT NULL,
  PRIMARY KEY (`idVideoEtiquetado`),
  UNIQUE INDEX `idVideoEtiquetado_UNIQUE` (`idVideoEtiquetado` ASC),
  INDEX `fk_VideoEtiquetado_Etiqueta1_idx` (`Etiqueta_idEtiqueta` ASC),
  INDEX `fk_VideoEtiquetado_Video1_idx` (`Video_idVideo` ASC),
  CONSTRAINT `fk_VideoEtiquetado_Etiqueta1`
    FOREIGN KEY (`Etiqueta_idEtiqueta`)
    REFERENCES `youtube`.`Etiqueta` (`idEtiqueta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VideoEtiquetado_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `youtube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`SuscripcionCanal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`SuscripcionCanal` (
  `idSuscripcionCanal` INT NOT NULL,
  `Canal_idCanal` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idSuscripcionCanal`),
  UNIQUE INDEX `idSuscripcionCanal_UNIQUE` (`idSuscripcionCanal` ASC),
  INDEX `fk_SuscripcionCanal_Canal1_idx` (`Canal_idCanal` ASC),
  INDEX `fk_SuscripcionCanal_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_SuscripcionCanal_Canal1`
    FOREIGN KEY (`Canal_idCanal`)
    REFERENCES `youtube`.`Canal` (`idCanal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SuscripcionCanal_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Likes` (
  `idLikes` INT NOT NULL,
  `Fecha/Hora` DATETIME(2) NULL,
  `CantidadLikes` INT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Video_idVideo` INT NOT NULL,
  PRIMARY KEY (`idLikes`),
  INDEX `fk_Likes_Usuario1_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_Likes_Video1_idx` (`Video_idVideo` ASC),
  CONSTRAINT `fk_Likes_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Likes_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `youtube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`dislikes` (
  `idDislikes` INT NOT NULL,
  `Fecha/Hora` DATETIME(2) NULL,
  `CantidadDislikes` INT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  `Video_idVideo` INT NOT NULL,
  PRIMARY KEY (`idDislikes`),
  INDEX `fk_dislikes_Usuario1_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_dislikes_Video1_idx` (`Video_idVideo` ASC),
  CONSTRAINT `fk_dislikes_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dislikes_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `youtube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`EstadoPlaylist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`EstadoPlaylist` (
  `idEstadoPlaylist` INT NOT NULL,
  `EstadoPlaylist` VARCHAR(15) NULL,
  PRIMARY KEY (`idEstadoPlaylist`),
  UNIQUE INDEX `idEstadoPlaylist_UNIQUE` (`idEstadoPlaylist` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`PlayList`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`PlayList` (
  `idPlayList` INT NOT NULL,
  `NombrePlayList` VARCHAR(45) NULL,
  `Fecha Creacion` DATE NOT NULL,
  `EstadoPlaylist_idEstadoPlaylist` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPlayList`),
  UNIQUE INDEX `idPlayList_UNIQUE` (`idPlayList` ASC),
  INDEX `fk_PlayList_EstadoPlaylist1_idx` (`EstadoPlaylist_idEstadoPlaylist` ASC),
  INDEX `fk_PlayList_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_PlayList_EstadoPlaylist1`
    FOREIGN KEY (`EstadoPlaylist_idEstadoPlaylist`)
    REFERENCES `youtube`.`EstadoPlaylist` (`idEstadoPlaylist`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayList_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Like/Dislike Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Like/Dislike Comentario` (
  `idLike/DislikeComentario` INT NOT NULL,
  `Like` INT NULL,
  `Dislike` INT NULL,
  `Fecha/Hora` DATETIME(2) NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idLike/DislikeComentario`),
  UNIQUE INDEX `idLike/DislikeComentario_UNIQUE` (`idLike/DislikeComentario` ASC),
  INDEX `fk_Like/Dislike Comentario_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Like/Dislike Comentario_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `youtube`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Comentario` (
  `idComentario` INT NOT NULL,
  `Comentario` VARCHAR(245) NULL,
  `Fecha/Hora` DATETIME(2) NOT NULL,
  `Video_idVideo` INT NOT NULL,
  `Like/Dislike Comentario_idLike/DislikeComentario` INT NOT NULL,
  PRIMARY KEY (`idComentario`),
  UNIQUE INDEX `idComentario_UNIQUE` (`idComentario` ASC),
  INDEX `fk_Comentario_Video1_idx` (`Video_idVideo` ASC),
  INDEX `fk_Comentario_Like/Dislike Comentario1_idx` (`Like/Dislike Comentario_idLike/DislikeComentario` ASC),
  CONSTRAINT `fk_Comentario_Video1`
    FOREIGN KEY (`Video_idVideo`)
    REFERENCES `youtube`.`Video` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentario_Like/Dislike Comentario1`
    FOREIGN KEY (`Like/Dislike Comentario_idLike/DislikeComentario`)
    REFERENCES `youtube`.`Like/Dislike Comentario` (`idLike/DislikeComentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
