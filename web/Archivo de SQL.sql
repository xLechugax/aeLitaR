CREATE TABLE `usuario` (
	`idUsuario` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
	`nombre` VARCHAR(50) NOT NULL DEFAULT '0',
	`apellido` VARCHAR(50) NOT NULL DEFAULT '0',
	`nombreUsuario` VARCHAR(50) NOT NULL DEFAULT '0',
	`sexo` CHAR(1) NOT NULL DEFAULT '0',
	`email` VARCHAR(50) NOT NULL DEFAULT '0',
	`telefono` INT(11) NOT NULL DEFAULT '0',
	`area_departamento` VARCHAR(50) NOT NULL DEFAULT '0',
	`direccion` VARCHAR(50) NOT NULL DEFAULT '0',
	`tipoCuenta` CHAR(50) NOT NULL DEFAULT '0',
	`clave` VARCHAR(50) NOT NULL DEFAULT '0',
	`activo` CHAR(1) NOT NULL DEFAULT '0',
	PRIMARY KEY (`idUsuario`)
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=3
;
DROP TABLE USUARIO
SELECT * FROM USUARIO usuario
INSERT INTO usuario (nombre,apellido,nombreUsuario,sexo,email,telefono,area_departamento,direccion,tipoCuenta,clave,activo) VALUES
('Patricio','Contreras','PATRICIO.CONTRERAS','M','patricio.a.contreras@clarochile.cl','225811562','MANTENCION','Fanor Verlasco #50','A','Teleco123','S'),
('Alvaro','Soto','ALVARO.SOTO','M','alvaro.soto@clarochile.cl','225811559','MANTENCION','Alfonso Vial #1079','A','Teleco123','N');