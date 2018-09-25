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
  `idProcedimiento` int(11) DEFAULT NULL,
  `idPaso` int(11) DEFAULT NULL,
  `archivo` mediumblob DEFAULT NULL,
  `detalleArchivo` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `fechaCreacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idArchivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.archivo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.area_departamento
CREATE TABLE IF NOT EXISTS `area_departamento` (
  `idAreaDepartamento` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nombreAreaDepartamento` varchar(50) DEFAULT 'SIN ASIGNAR',
  `detalleAreaDepartamento` varchar(121) DEFAULT 'SIN ASIGNAR',
  PRIMARY KEY (`idAreaDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.area_departamento: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `area_departamento` DISABLE KEYS */;
REPLACE INTO `area_departamento` (`idAreaDepartamento`, `nombreAreaDepartamento`, `detalleAreaDepartamento`) VALUES
	(00000000000, 'SIN ASIGNAR', NULL),
	(00000000001, 'MANTENCIÓN', 'Personal que realiza las reparaciones de los servicios. '),
	(00000000002, 'FRONT', 'Área donde los colaboradores recepcionan llamados. '),
	(00000000003, 'ATENCIONES TÉCNICAS', 'Personal que realiza la configuraciones de servicio.'),
	(00000000006, 'MANUTENCIÓN DE DATOS', 'DETALLE DE MANUTENCIÓN DE DATOS');
/*!40000 ALTER TABLE `area_departamento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.avance
CREATE TABLE IF NOT EXISTS `avance` (
  `idAvance` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idTarea_fk` int(11) DEFAULT NULL,
  `idOrdenTrabajo_fk` int(11) DEFAULT NULL,
  `comentario` longtext DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idAvance`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.avance: ~42 rows (aproximadamente)
/*!40000 ALTER TABLE `avance` DISABLE KEYS */;
REPLACE INTO `avance` (`idAvance`, `idTarea_fk`, `idOrdenTrabajo_fk`, `comentario`, `usuario`, `fecha_publicacion`) VALUES
	(00000000001, NULL, 1, '1', 40, '2018-07-24 14:31:49'),
	(00000000002, NULL, 1, '2', 40, '2018-07-24 14:31:51'),
	(00000000003, NULL, 1, '3', 40, '2018-07-24 14:31:56'),
	(00000000004, NULL, 1, '4', 40, '2018-07-24 14:31:59'),
	(00000000005, 1, NULL, '5', 26, '2018-07-24 14:47:54'),
	(00000000006, 1, 1, 'wef', 26, '2018-07-24 18:10:46'),
	(00000000007, NULL, 1, 'armin, necesito que documentes', 40, '2018-07-24 18:14:23'),
	(00000000008, 1, 1, 'bueno', 26, '2018-07-24 18:14:39'),
	(00000000009, NULL, 7, 'Alonso, favor documentar....', 16, '2018-07-24 18:20:03'),
	(00000000010, 6, 7, 'okey!', 17, '2018-07-24 18:20:35'),
	(00000000011, 6, 7, 'wena', 17, '2018-07-24 18:27:21'),
	(00000000012, NULL, 8, 'alonso, favor documentar...', 16, '2018-08-13 20:55:52'),
	(00000000013, 7, 8, 'ok ningun problema.!!', 17, '2018-08-13 20:56:22'),
	(00000000014, NULL, 9, 'oye patricio, documente plz.', 16, '2018-08-14 11:13:59'),
	(00000000015, 8, 9, 'ok', 3, '2018-08-14 11:14:29'),
	(00000000016, NULL, 1, 'ha pasado tiempo, son necesarios avances.\r\n', 40, '2018-09-10 13:58:18'),
	(00000000017, NULL, 11, 'alonso, favor documentar...', 16, '2018-09-20 21:11:58'),
	(00000000018, 10, 11, 'aahh yaa, esperamee', 17, '2018-09-20 21:12:26'),
	(00000000019, NULL, 1, 'a', 1, '2018-09-22 14:18:13'),
	(00000000020, 1, 1, 'Se procederá con el cierre de la tarea, no se realiza debido a que no se cuentan con las herramientas necesarias para llevar a cabo la tarea.', 26, '2018-09-23 01:17:54'),
	(00000000021, NULL, 1, 'Armin, se genera nueva tarea y son asignados los recursos necesarios para la realización de esta. ', 40, '2018-09-23 02:40:29'),
	(00000000022, 11, 1, 'las herramientas han llegado correctamente, comenzare a trabajar en lo solicitado...', 26, '2018-09-23 02:42:08'),
	(00000000023, NULL, 1, 'Estarán ya terminadas las tareas solicitadas?', 40, '2018-09-23 16:29:53'),
	(00000000024, 11, 1, 'Esta terminado, procederé con el cierre de la tarea. adjunto las pruebas\r\n\r\nC:\\Users\\Lechuga>ping 8.8.8.8\r\n\r\nHaciendo ping a 8.8.8.8 con 32 bytes de datos:\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=461ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=224ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=26ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=27ms TTL=118\r\n\r\nEstadísticas de ping para 8.8.8.8:\r\n    Paquetes: enviados = 4, recibidos = 4, perdidos = 0\r\n    (0% perdidos),\r\nTiempos aproximados de ida y vuelta en milisegundos:\r\n    Mínimo = 26ms, Máximo = 461ms, Media = 184ms\r\n\r\nC:\\Users\\Lechuga>', 26, '2018-09-23 16:30:50'),
	(00000000025, NULL, 1, 'Ivan, favor realizar monitoreo proactivo del enlace ya reparado por armin', 40, '2018-09-23 16:56:49'),
	(00000000026, 2, 1, 'tarea en ejecución, sera monitoreado por 5 horas.', 27, '2018-09-23 16:59:44'),
	(00000000027, NULL, 1, 'gracias, favor informarnos cualquier eventualidad', 40, '2018-09-23 17:01:43'),
	(00000000028, 2, 1, 'servicio caido, favor reactivar tarea de armin', 27, '2018-09-23 17:02:01'),
	(00000000029, NULL, 1, 'Gracias Ivan.', 40, '2018-09-23 17:02:15'),
	(00000000030, 1, 1, 'Armin, favor gestionar nuevamente, servicio caido...', 40, '2018-09-23 17:04:34'),
	(00000000031, 1, 1, 'okey, favor entregar las herramientas necesarias para poder llevar a cabo el trabajo. ', 26, '2018-09-23 17:04:51'),
	(00000000032, 1, 1, 'aún no llegan los materiales...', 26, '2018-09-23 17:16:50'),
	(00000000033, NULL, 10, 'Patricio, favor comenzar con lo solicitado', 16, '2018-09-23 17:25:30'),
	(00000000034, 9, 10, 'trabajos serán informados en la medida que sean entregados los antecedentes por parte de Planta Externa que esta a mi cargo. ', 3, '2018-09-23 17:26:35'),
	(00000000035, NULL, 10, 'muchas gracias.', 16, '2018-09-23 17:26:48'),
	(00000000036, NULL, 1, 'están listos, favor reparar.', 40, '2018-09-23 17:53:49'),
	(00000000037, 1, 1, 'queda reparado', 26, '2018-09-23 17:54:02'),
	(00000000038, NULL, 1, 'no es necesario mas monitoreo, favor cerrar ambas tareas para proceder con el cierre de la ot\r\n', 40, '2018-09-23 17:54:23'),
	(00000000039, 1, 1, 'ok', 26, '2018-09-23 17:54:27'),
	(00000000040, 2, 1, 'okey', 27, '2018-09-23 17:54:44'),
	(00000000041, NULL, 2, 'Armin favor configurar', 16, '2018-09-23 21:01:49'),
	(00000000042, 12, 2, 'realizado, se procede con el cierre de la tarea', 26, '2018-09-23 21:02:16');
/*!40000 ALTER TABLE `avance` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.contacto
CREATE TABLE IF NOT EXISTS `contacto` (
  `idContacto` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `asunto` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `mensaje` longtext DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idContacto`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.contacto: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `contacto` DISABLE KEYS */;
REPLACE INTO `contacto` (`idContacto`, `nombre`, `asunto`, `email`, `telefono`, `mensaje`, `fecha`) VALUES
	(00000000014, 'Mauricio Cortazar', 'Problemas en el registro', 'mauricio.cortazar@gmail.com', '569856325654', 'Me sale que la cuenta esta des-habilitada. Favor habilitar.', '2018-07-15 22:58:58'),
	(00000000017, 'Don Hernan', 'Ingreso a la web', 'hernan.coelo@gmail.com', '56986565987', 'Hola, buenas, tengo algunas dudas sobre el sitio, favor contactarme vía correo...', '2018-07-23 08:39:21'),
	(00000000018, 'Matias', 'Pregunta', 'matias@gmail.com', '56989865895', 'Necesito ingresar pero no puedo', '2018-07-23 09:25:00'),
	(00000000019, 'Camilo', 'no gunciona la weaita', 'akskdljalskdjlkasjdl@camilo.com', '564654654654', 'esta wea no funciona', '2018-08-13 20:57:47'),
	(00000000020, 'anonimo', 'IP de los nodos', 'jose.rios2@gmail.com', '2123', 'podrías agregar un documento con la IP de todos los nodos!!', '2018-09-21 17:42:18');
/*!40000 ALTER TABLE `contacto` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nombreEstado` varchar(50) DEFAULT NULL,
  `detalleEstado` longtext DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.estado: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
REPLACE INTO `estado` (`idEstado`, `nombreEstado`, `detalleEstado`) VALUES
	(00000000001, 'Generada', 'Actividad recién creada'),
	(00000000002, 'Ejecución', 'Actividades en proceso'),
	(00000000003, 'Suspensión', 'Actividades suspendidas'),
	(00000000004, 'Ejecutada', 'Actividades realizadas'),
	(00000000005, 'Cerrada', 'Actividad cerrada'),
	(00000000051, 'Despachado', 'Despachado');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.orden_trabajo
CREATE TABLE IF NOT EXISTS `orden_trabajo` (
  `idOrdenTrabajo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `importancia` varchar(50) DEFAULT NULL,
  `supervisor` int(11) DEFAULT NULL,
  `nombreOrdenTrabajo` varchar(50) DEFAULT NULL,
  `detalleOrdenTrabajo` longtext DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_fin` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idOrdenTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.orden_trabajo: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `orden_trabajo` DISABLE KEYS */;
REPLACE INTO `orden_trabajo` (`idOrdenTrabajo`, `importancia`, `supervisor`, `nombreOrdenTrabajo`, `detalleOrdenTrabajo`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(00000000001, 'Alta', 40, 'Generar informe de servicios', 'sdfsdf', '2018-07-23 15:54:11', NULL, 5),
	(00000000002, 'Baja', 16, 'Configuración de Servicio', 'Congiurar en PE 171 tabla de host', '2018-07-24 14:00:42', NULL, 5),
	(00000000003, 'Media', 24, 'Informe de Servicios', 'sdf', '2018-07-24 14:00:50', NULL, 1),
	(00000000004, 'Baja', 40, 'Informe de Datos', 'werwer', '2018-07-24 14:00:57', NULL, 1),
	(00000000005, 'Alta', 40, 'Convergencia de Int64', 'dfbdfb', '2018-07-24 14:01:06', NULL, 1),
	(00000000006, 'Media', 40, 'Coniguración entorno de Prueabas', 'fgdfg', '2018-07-24 14:01:14', NULL, 3),
	(00000000007, 'Baja', 16, 'Configuración de Equipos', 'LOJSDLKFJLKSDJFLKSDJF', '2018-07-24 18:19:02', NULL, 3),
	(00000000008, 'Alta', 16, 'Reparación', 'Reparar la wea', '2018-08-13 20:54:48', NULL, 1),
	(00000000009, 'Media', 16, 'Solicitud de Prueba', 'SE NECESITA QUE TODOS TERMINEN SUS TAREAS ', '2018-08-14 11:13:18', NULL, 1),
	(00000000010, 'Alta', 16, 'Tienda Kayser caida', 'Nombre de Quien Reporta: ALEJANDRO SANTIS \r\nProblema Reportado : Problema de internet y estamos presentando problemas con la gran mayoría de los anexos telefónicos del sector Espigon, estos quedan solicitando login y contraseña y luego de ser ingresados levantan pero a los 5 min vuelven a caer y solicitar login y contraseña nuevamente. Favor sus gestiones para solucionar este problema lo antes posible dado que dificulta la gestión de los usuarios al ser el teléfono una herramienta importante para sus labores diarios.\r\nPruebas realizadas por Cliente : ni\r\n', '2018-09-20 15:00:43', NULL, 11),
	(00000000011, 'Alta', 16, 'Servicio caido', 'jlaksjdlajslkdjalsdjklasjdlkasjdlksajd\r\n\r\nhacer la wea que pido jajaja', '2018-09-20 21:11:26', NULL, 1),
	(00000000012, 'Alta', 16, 'Gestión de Gastos', 'ghj', '2018-09-22 14:11:33', NULL, 2);
/*!40000 ALTER TABLE `orden_trabajo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.paso
CREATE TABLE IF NOT EXISTS `paso` (
  `idPaso` int(11) NOT NULL AUTO_INCREMENT,
  `idProcedimiento` int(11) DEFAULT NULL,
  `idTipoTarea` int(11) DEFAULT NULL,
  `nombrePaso` varchar(50) DEFAULT NULL,
  `detallePaso` text DEFAULT NULL,
  `pasoNumero` int(11) DEFAULT NULL,
  PRIMARY KEY (`idPaso`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.paso: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `paso` DISABLE KEYS */;
/*!40000 ALTER TABLE `paso` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.procedimiento
CREATE TABLE IF NOT EXISTS `procedimiento` (
  `idProcedimiento` int(11) NOT NULL AUTO_INCREMENT,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `idTarea` int(11) DEFAULT NULL,
  `nombreProcedimiento` varchar(50) DEFAULT NULL,
  `detalleProcedimiento` text DEFAULT NULL,
  PRIMARY KEY (`idProcedimiento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.procedimiento: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `procedimiento` DISABLE KEYS */;
/*!40000 ALTER TABLE `procedimiento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tarea
CREATE TABLE IF NOT EXISTS `tarea` (
  `idTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idTipoTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `estadoTarea` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tarea: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `tarea` DISABLE KEYS */;
REPLACE INTO `tarea` (`idTarea`, `idTipoTarea`, `idOrdenTrabajo`, `usuario`, `fecha_inicio`, `fecha_fin`, `estadoTarea`) VALUES
	(00000000001, 1, 1, 26, '2018-07-23 15:54:28', NULL, 5),
	(00000000002, 3, 1, 27, '2018-07-24 14:01:33', NULL, 5),
	(00000000003, 3, 4, 23, '2018-07-24 14:01:40', NULL, 1),
	(00000000004, 2, 5, 23, '2018-07-24 14:01:58', NULL, 1),
	(00000000005, 7, 6, 23, '2018-07-24 14:02:09', NULL, 1),
	(00000000006, 2, 7, 17, '2018-07-24 18:19:53', NULL, 2),
	(00000000007, 1, 8, 17, '2018-08-13 20:55:40', NULL, 5),
	(00000000008, 1, 9, 3, '2018-08-14 11:13:47', NULL, 1),
	(00000000009, 9, 10, 3, '2018-09-20 15:02:29', NULL, 2),
	(00000000010, 1, 11, 17, '2018-09-20 21:11:48', NULL, 5),
	(00000000011, 1, 1, 26, '2018-09-23 02:39:51', NULL, 5),
	(00000000012, 2, 2, 26, '2018-09-23 21:01:38', NULL, 5);
/*!40000 ALTER TABLE `tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tipo_tarea
CREATE TABLE IF NOT EXISTS `tipo_tarea` (
  `idTipoTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idProcedimiento` int(11) DEFAULT NULL,
  `nombreTipoTarea` varchar(50) DEFAULT NULL,
  `detalleTipoTarea` longtext DEFAULT NULL,
  PRIMARY KEY (`idTipoTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tipo_tarea: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_tarea` DISABLE KEYS */;
REPLACE INTO `tipo_tarea` (`idTipoTarea`, `idProcedimiento`, `nombreTipoTarea`, `detalleTipoTarea`) VALUES
	(00000000001, NULL, 'Reparación', 'Reparación para servicio de Datos, Telefonía o Internet. '),
	(00000000002, NULL, 'Atención Técnica', 'Realizar configuraciones sobre servicios de Telefonía, Datos o Internet. '),
	(00000000003, NULL, 'Monitoreo Proactivo', 'Monitorear enlaces solicitados. '),
	(00000000007, NULL, 'Redactar Informe de Servicios', 'Redactar Informe de servicios'),
	(00000000009, NULL, 'Reparación Mall', 'asdasd'),
	(00000000010, NULL, 'Despacho', 'wefwef');
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1;

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
	(0000000026, 'Armin', 'Brün', 'ARMIN.BRUN', 'armin.brun@chancho.cl', '543857421', '5321158', '0', 'Almirante Barroso 76', 'Ejecutor', 'Teleco123', 'S'),
	(0000000027, 'ivan', 'camote', 'IVAN.CAMOTE', 'ivan@gmail.com', '563256325', '5632563256', '0', 'pn89', 'Ejecutor', 'Teleco123', 'S'),
	(0000000032, 'DAVID', 'SANJUAN', 'DAVID.SANJUAN', 'davidsanjuan19938@gmail.com', '655656565', '56569569565', '0', 'El clavel poniente 2416', 'Administrador', 'Teleco123', 'S'),
	(0000000040, 'Fernando', 'San Juan', 'FERNANDO.SANJUAN', 'fernando.sanjuan@clarochile.cl', '1234', '1234', '1', 'El clavel poniente 2416', 'Supervisor', 'Teleco123', 'S'),
	(0000000042, 'José', 'Rios', 'JOSE.RIOS', 'jose.rios2@clarochile.cl', '967890728', '22123123', '00000000001', 'fanor 50', 'Ejecutor', 'Teleco123', 'S');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
