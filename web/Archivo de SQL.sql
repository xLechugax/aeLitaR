DROP TABLE area_departamento;
DROP TABLE estado;
DROP TABLE tarea;
DROP TABLE usuario;

CREATE TABLE `area_departamento` (
	`idAreaDepartamento` INT(11) NOT NULL AUTO_INCREMENT,
	`nombreAreaDepartamento` VARCHAR(50) NULL DEFAULT '0',
	PRIMARY KEY (`idAreaDepartamento`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=4
;
CREATE TABLE `estado` (
	`idEstado` INT(11) NOT NULL AUTO_INCREMENT,
	`nombreEstado` VARCHAR(50) NULL DEFAULT NULL,
	`detalleEstado` LONGTEXT NULL DEFAULT NULL,
	PRIMARY KEY (`idEstado`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=20
;
CREATE TABLE `tarea` (
	`idTarea` INT(11) NOT NULL AUTO_INCREMENT,
	`nombreTarea` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`detalleTarea` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	PRIMARY KEY (`idTarea`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=9
;
CREATE TABLE `usuario` (
	`idUsuario` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
	`nombre` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`apellido` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`nombreUsuario` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`email` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`telefono_m` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`telefono_f` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`area_departamento` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`direccion` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`tipoCuenta` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`clave` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	`activo` CHAR(1) NOT NULL DEFAULT '0' COLLATE 'utf8_spanish2_ci',
	PRIMARY KEY (`idUsuario`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=30
;
INSERT INTO usuario (nombre,apellido,nombreUsuario,email,telefono,area_departamento,direccion,tipoCuenta,clave,activo) VALUES
('Patricio','Contreras','PATRICIO.CONTRERAS','patricio.a.contreras@clarochile.cl','225811562','MANTENCION','Fanor Verlasco #50','A','Teleco123','S'),
('Alvaro','Soto','ALVARO.SOTO','alvaro.soto@clarochile.cl','225811559','MANTENCION','Alfonso Vial #1079','A','Teleco123','N');






-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.3.7-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para aelita
CREATE DATABASE IF NOT EXISTS `aelita` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `aelita`;

-- Volcando estructura para tabla aelita.archivo
CREATE TABLE IF NOT EXISTS `archivo` (
  `idArchivo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idAvance` int(11) DEFAULT NULL,
  `idTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `archivo` mediumblob DEFAULT NULL,
  `detalleArchivo` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idArchivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.area_departamento
CREATE TABLE IF NOT EXISTS `area_departamento` (
  `idAreaDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombreAreaDepartamento` varchar(50) DEFAULT 'SIN ASIGNAR',
  `detalleAreaDepartamento` varchar(121) DEFAULT 'SIN ASIGNAR',
  PRIMARY KEY (`idAreaDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.avance
CREATE TABLE IF NOT EXISTS `avance` (
  `idAvance` int(11) DEFAULT NULL,
  `idTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `comentario` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.contacto
CREATE TABLE IF NOT EXISTS `contacto` (
  `idContacto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `asunto` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `mensaje` longtext DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idContacto`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEstado` varchar(50) DEFAULT NULL,
  `detalleEstado` longtext DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.orden_trabajo
CREATE TABLE IF NOT EXISTS `orden_trabajo` (
  `idOrdenTrabajo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `importancia` varchar(50) DEFAULT NULL,
  `supervisor` int(11) DEFAULT 0,
  `nombreOrdenTrabajo` varchar(50) DEFAULT NULL,
  `fecha_inicio` timestamp NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idOrdenTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.tarea
CREATE TABLE IF NOT EXISTS `tarea` (
  `idTarea` int(11) DEFAULT NULL,
  `idTipoTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `ejecutor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.tipo_tarea
CREATE TABLE IF NOT EXISTS `tipo_tarea` (
  `idTipoTarea` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoTarea` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `detalleTipoTarea` longtext CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`idTipoTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
-- Volcando estructura para tabla aelita.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `apellido` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `nombreUsuario` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `telefono_m` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `telefono_f` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `area_departamento` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `direccion` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `tipoCuenta` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `clave` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  `activo` char(1) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

-- La exportación de datos fue deseleccionada.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
