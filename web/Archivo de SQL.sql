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
  `detalleArchivo` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`idArchivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.archivo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.area_departamento
CREATE TABLE IF NOT EXISTS `area_departamento` (
  `idAreaDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombreAreaDepartamento` varchar(50) DEFAULT 'SIN ASIGNAR',
  `detalleAreaDepartamento` varchar(121) DEFAULT 'SIN ASIGNAR',
  PRIMARY KEY (`idAreaDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.area_departamento: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `area_departamento` DISABLE KEYS */;
REPLACE INTO `area_departamento` (`idAreaDepartamento`, `nombreAreaDepartamento`, `detalleAreaDepartamento`) VALUES
	(0, 'SIN ASIGNAR', NULL),
	(1, 'MANTENCIÓN', 'Personal que realiza las reparaciones de los servicios. '),
	(2, 'FRONT', 'Área donde los colaboradores recepcionan llamados. '),
	(3, 'ATENCIONES TÉCNICAS', 'Personal que realiza la configuraciones de servicio.'),
	(6, 'MANUTENCIÓN DE DATOS', 'DETALLE DE MANUTENCIÓN DE DATOS');
/*!40000 ALTER TABLE `area_departamento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.avance
CREATE TABLE IF NOT EXISTS `avance` (
  `idAvance` int(11) NOT NULL AUTO_INCREMENT,
  `idTarea_fk` int(11) DEFAULT NULL,
  `idOrdenTrabajo_fk` int(11) DEFAULT NULL,
  `comentario` longtext DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idAvance`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.avance: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `avance` DISABLE KEYS */;
REPLACE INTO `avance` (`idAvance`, `idTarea_fk`, `idOrdenTrabajo_fk`, `comentario`, `usuario`, `fecha_publicacion`) VALUES
	(1, NULL, 1, 'Hola Mundo!', 40, '2018-07-22 14:40:07'),
	(2, NULL, 4, 'okmkcmkclxmlkcxmvlkcxmv', 40, '2018-07-22 15:09:02'),
	(3, NULL, 3, 'Se solicita a los involucrados comenzar con las tareas asignadas. ', 40, '2018-07-22 16:23:47'),
	(4, NULL, 8, 'Armin, favor proceder con la tarea asignada...', 16, '2018-07-23 07:47:56'),
	(5, NULL, 10, 'Se solicita a armin comenzar con sus tareas.', 40, '2018-07-23 07:54:26'),
	(6, NULL, 11, 'kasjdklsajkldsj', 40, '2018-07-23 08:03:33'),
	(7, NULL, 12, 'Va todo bien', 16, '2018-07-23 08:13:19'),
	(8, NULL, 13, 'Se solicita a los involucrados comenzar con sus tareas', 16, '2018-07-23 08:34:27');
/*!40000 ALTER TABLE `avance` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.contacto: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `contacto` DISABLE KEYS */;
REPLACE INTO `contacto` (`idContacto`, `nombre`, `asunto`, `email`, `telefono`, `mensaje`, `fecha`) VALUES
	(14, 'Mauricio Cortazar', 'Problemas en el registro', 'mauricio.cortazar@gmail.com', '569856325654', 'Me sale que la cuenta esta des-habilitada. Favor habilitar.', '2018-07-15 21:58:58'),
	(17, 'Don Hernan', 'Ingreso a la web', 'hernan.coelo@gmail.com', '56986565987', 'Hola, buenas, tengo algunas dudas sobre el sitio, favor contactarme vía correo...', '2018-07-23 07:39:21'),
	(18, 'Matias', 'Pregunta', 'matias@gmail.com', '56989865895', 'Necesito ingresar pero no puedo', '2018-07-23 08:25:00');
/*!40000 ALTER TABLE `contacto` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) NOT NULL AUTO_INCREMENT,
  `nombreEstado` varchar(50) DEFAULT NULL,
  `detalleEstado` longtext DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.estado: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
REPLACE INTO `estado` (`idEstado`, `nombreEstado`, `detalleEstado`) VALUES
	(1, 'Aprobado', 'Recién generado.'),
	(2, 'En ejecución', 'En proceso de desarrollo'),
	(3, 'Suspensión', 'Trabajo suspendido.'),
	(4, 'Cerrada', 'Orden de Trabajo cerrada.');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.orden_trabajo
CREATE TABLE IF NOT EXISTS `orden_trabajo` (
  `idOrdenTrabajo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `importancia` varchar(50) DEFAULT NULL,
  `supervisor` int(11) DEFAULT 0,
  `nombreOrdenTrabajo` varchar(50) DEFAULT NULL,
  `detalleOrdenTrabajo` longtext DEFAULT NULL,
  `fecha_inicio` timestamp NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idOrdenTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.orden_trabajo: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `orden_trabajo` DISABLE KEYS */;
REPLACE INTO `orden_trabajo` (`idOrdenTrabajo`, `importancia`, `supervisor`, `nombreOrdenTrabajo`, `detalleOrdenTrabajo`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(00000000001, 'Baja', 40, 'Generar informe de servicios', 'Datos de informe de servicios', '2018-07-21 21:36:55', NULL, 3),
	(00000000002, 'Media', 16, 'Generar informe de compras', 'generar informe de compras', '2018-07-21 21:38:08', NULL, 3),
	(00000000003, 'Media', 40, 'Generar informe de servicios.', 'Todos los involucrados completen las tareas solicitadas.', '2018-07-21 23:23:24', NULL, 1),
	(00000000004, 'Alta', 40, 'Solicitud de prueba', 'ksofksdofmokdsmfokdsmf kdksmdfkmsdfge\r\nher\r\ng\r\ntrjrtjrth\r\nthrthrthrthrthprkthkhpfg,hfgh\r\nhtokhmrotkmhortkmhorktmhortkmorth,rotkhkomfhkomfgohfg\r\nrthijmrtijhmrtijhtrijm', '2018-07-22 15:06:03', NULL, 3),
	(00000000005, 'Baja', 24, 'Prescripción de eventualidades', 'Realizar xxxxxxxxxxxxxxxxxxxxxxxx\r\n\r\nRealizar xxxxxxxxxxxxxxxxxxxxxxxx\r\nRealizar xxxxxxxxxxxxxxxxxxxxxxxx\r\nRealizar xxxxxxxxxxxxxxxxxxxxxxxx\r\n\r\nRealizar xxxxxxxxxxxxxxxxxxxxxxxx', '2018-07-22 23:02:21', NULL, 2),
	(00000000006, 'Baja', 24, 'Atrapar poquemons', 'Atrapar a todos los pokemones de la siguiente lista, se encomienda a cada uno de los participantes cada pokemon para atrapar.', '2018-07-22 23:08:02', NULL, 1),
	(00000000007, 'Alta', 40, 'Configuración de MPLS ', 'Realizar la configuración de las etapas prolongadas para seguir escribiendo con palabras bonitas. Lo que esta pasando en realidad:\r\n\r\n-- Sesher las igTf0/15.12355\r\n-- Sesher las igTf0/15.125465\r\n-- Sesher las igTf0/15.125468\r\n-- Sesher las igTf0/15.1231566\r\n-- Sesher las igTf0/15.123554195\r\n', '2018-07-22 23:09:46', NULL, 2),
	(00000000008, 'Baja', 16, 'Gestión de Servicio', 'Gisse,\r\n\r\nTe encargo esta tarea para que involucres a las personas correctas.', '2018-07-23 07:46:37', NULL, 1),
	(00000000009, 'Baja', 40, 'Documentar procesos de ejecución', 'Fernando, cumpli con la asignación de la tarea y Armin ya esta al tanto. Favor proceder con la documentación de los procesos, favor involucrar a gente responsable en la ejecución de las tareas...', '2018-07-23 07:49:09', NULL, 1),
	(00000000010, 'Media', 40, 'Preparar informe de gestión de Servicios', 'Se solicita  a los involucrados bla bla bla....', '2018-07-23 07:52:32', NULL, 1),
	(00000000011, 'Baja', 40, 'Prueba', 'Se solicta a los ijasidjasiod{\r\ns\r\ndsñlksdñlfkñsdkf\r\nsdkf\r\nsdk\r\nfksd\r\nñfk\r\nsdkf', '2018-07-23 08:02:52', NULL, 1),
	(00000000012, 'Alta', 16, 'Tareita', 'Realizar tarea', '2018-07-23 08:11:15', NULL, 1),
	(00000000013, 'Media', 16, 'Reporte de estados', 'Se solicita a los involucrados proceder.', '2018-07-23 08:32:47', NULL, 1);
/*!40000 ALTER TABLE `orden_trabajo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tarea
CREATE TABLE IF NOT EXISTS `tarea` (
  `idTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idTipoTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `estadoTarea` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tarea: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `tarea` DISABLE KEYS */;
REPLACE INTO `tarea` (`idTarea`, `idTipoTarea`, `idOrdenTrabajo`, `usuario`, `fecha_inicio`, `fecha_fin`, `estadoTarea`) VALUES
	(00000000001, 1, 1, 26, '2018-07-22 14:41:22', '0000-00-00 00:00:00', 1),
	(00000000002, 3, 1, 27, '2018-07-22 14:41:30', '0000-00-00 00:00:00', 1),
	(00000000003, 2, 1, 17, '2018-07-22 14:41:42', '0000-00-00 00:00:00', 1),
	(00000000004, 2, 3, 3, '2018-07-22 14:41:57', '0000-00-00 00:00:00', 1),
	(00000000005, 1, 1, 26, '2018-07-22 14:42:56', '0000-00-00 00:00:00', 1),
	(00000000006, 1, 3, 23, '2018-07-22 14:47:00', '0000-00-00 00:00:00', 1),
	(00000000007, 2, 3, 23, '2018-07-22 14:47:14', '0000-00-00 00:00:00', 1),
	(00000000008, 2, 3, 26, '2018-07-22 14:56:08', '0000-00-00 00:00:00', 1),
	(00000000009, 2, 3, 17, '2018-07-22 14:56:13', '0000-00-00 00:00:00', 1),
	(00000000010, 3, 4, 22, '2018-07-22 15:08:13', '0000-00-00 00:00:00', 1),
	(00000000011, 2, 8, 26, '2018-07-23 07:47:38', '0000-00-00 00:00:00', 1),
	(00000000012, 2, 10, 26, '2018-07-23 07:53:12', '0000-00-00 00:00:00', 1),
	(00000000013, 2, 11, 26, '2018-07-23 08:03:09', '0000-00-00 00:00:00', 1),
	(00000000014, 3, 11, 27, '2018-07-23 08:03:24', '0000-00-00 00:00:00', 1),
	(00000000015, 2, 12, 26, '2018-07-23 08:12:41', '0000-00-00 00:00:00', 1),
	(00000000016, 7, 13, 22, '2018-07-23 08:33:58', '0000-00-00 00:00:00', 1);
/*!40000 ALTER TABLE `tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tipo_tarea
CREATE TABLE IF NOT EXISTS `tipo_tarea` (
  `idTipoTarea` int(11) NOT NULL AUTO_INCREMENT,
  `nombreTipoTarea` varchar(50) DEFAULT NULL,
  `detalleTipoTarea` longtext DEFAULT NULL,
  PRIMARY KEY (`idTipoTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tipo_tarea: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_tarea` DISABLE KEYS */;
REPLACE INTO `tipo_tarea` (`idTipoTarea`, `nombreTipoTarea`, `detalleTipoTarea`) VALUES
	(1, 'Reparación', 'Reparación para servicio de Datos, Telefonía o Internet. '),
	(2, 'Atención Técnica', 'Realizar configuraciones sobre servicios de Telefonía, Datos o Internet. '),
	(3, 'Monitoreo Proactivo', 'Monitorear enlaces solicitados. '),
	(7, 'Redactar Informe de Servicios', 'Redactar Informe de servicios');
/*!40000 ALTER TABLE `tipo_tarea` ENABLE KEYS */;

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

-- Volcando datos para la tabla aelita.usuario: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
REPLACE INTO `usuario` (`idUsuario`, `nombre`, `apellido`, `nombreUsuario`, `email`, `telefono_m`, `telefono_f`, `area_departamento`, `direccion`, `tipoCuenta`, `clave`, `activo`) VALUES
	(0000000001, 'Fernando', 'San Juan', 'ADMIN', 'a@a.com', '0', '0', '1', '0', 'Administrador', 'Teleco123', 'S'),
	(0000000003, 'Patricio', 'Contreras', 'PATRICIO.CONTRERAS', 'patricio.a.contreras@clarochile.cl', '225811562', '0', '1', 'Fanor Verlasco #50', 'Ejecutor', 'Teleco123', 'S'),
	(0000000016, 'Gisselle', 'San Martin', 'GISSELLE.SANMARTIN', 'gisselle.sanmartin@clarochile.cl', '123', '123', '0', 'Fanor Velasco 50', 'Supervisor', 'Teleco123', 'S'),
	(0000000017, 'Alonso', 'Pineda', 'ALONSO.PINEDA', 'alonso.pineda@clarochile.cl', '1234', '1234', '2', 'Fanor Velasco 50', 'Ejecutor', 'Teleco123', 'S'),
	(0000000022, 'Nicolas', 'Medrano', 'NICOLAS.MEDRANO', 'nicolas.medrano@inacapmail.cl', '994013263', '225942131', '2', 'Fanor Velasco 200', 'Ejecutor', 'Teleco123', 'S'),
	(0000000023, 'Josue', 'Cea', 'JOSUE.CEA', 'josue.cea@gmail.com', '56958980102', '0000000000', '0', 'Av. manuel antonio matta 0329, Quilicura', 'Ejecutor', 'josue2500', 'S'),
	(0000000024, 'Eduardo', 'Salinas', 'EDUARDO.SALINAS', 'eduardoinbrand@gmail.com', '0954458279', '0954458279', '0', 'Ignacio Carrera Pinto 67', 'Supervisor', 'kaka123', 'S'),
	(0000000026, 'Armin', 'Brun', 'ARMIN.BRUN', 'armin.brun@chancho.cl', '543857421', '5321158', '0', 'Almirante Barroso 76', 'Ejecutor', 'Teleco123', 'S'),
	(0000000027, 'ivan', 'camote', 'IVAN.CAMOTE', 'ivan@gmail.com', '563256325', '5632563256', '0', 'pn89', 'Ejecutor', 'hola', 'S'),
	(0000000032, 'DAVID', 'SANJUAN', 'DAVID.SANJUAN', 'davidsanjuan19938@gmail.com', '655656565', '56569569565', '0', 'El clavel poniente 2416', 'Administrador', 'Teleco123', 'S'),
	(0000000040, 'Fernando', 'San Juan', 'FERNANDO.SANJUAN', 'fernando.sanjuan@clarochile.cl', '1234', '1234', '1', 'El clavel poniente 2416', 'Supervisor', 'Teleco123', 'S');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
