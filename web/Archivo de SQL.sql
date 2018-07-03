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