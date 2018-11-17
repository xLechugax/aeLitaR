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

-- Volcando estructura para tabla aelita.actividad
CREATE TABLE IF NOT EXISTS `actividad` (
  `idActividad` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idProcedimiento` int(11) DEFAULT NULL,
  `idEmpresa` int(11) DEFAULT NULL,
  `nombreActividad` varchar(50) DEFAULT NULL,
  `detalleActividad` text DEFAULT NULL,
  PRIMARY KEY (`idActividad`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.actividad: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
REPLACE INTO `actividad` (`idActividad`, `idProcedimiento`, `idEmpresa`, `nombreActividad`, `detalleActividad`) VALUES
	(0000000009, 0, 1, 'Actividad 3 ', '949494');
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.archivo
CREATE TABLE IF NOT EXISTS `archivo` (
  `idArchivo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `idAvance` int(11) DEFAULT NULL,
  `idTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `idProcedimiento` int(11) DEFAULT NULL,
  `idPaso` int(11) DEFAULT NULL,
  `archivo` mediumblob DEFAULT NULL,
  `nombre` varchar(250) NOT NULL DEFAULT '',
  `type` char(20) NOT NULL DEFAULT '',
  `detalleArchivo` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `fechaCreacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idArchivo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.archivo: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `archivo` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.area_departamento
CREATE TABLE IF NOT EXISTS `area_departamento` (
  `idAreaDepartamento` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `nombreAreaDepartamento` varchar(50) DEFAULT 'SIN ASIGNAR',
  `detalleAreaDepartamento` varchar(121) DEFAULT 'SIN ASIGNAR',
  PRIMARY KEY (`idAreaDepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.area_departamento: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `area_departamento` DISABLE KEYS */;
REPLACE INTO `area_departamento` (`idAreaDepartamento`, `idEmpresa`, `nombreAreaDepartamento`, `detalleAreaDepartamento`) VALUES
	(00000000000, 0, 'SIN ASIGNAR', NULL),
	(00000000001, 1, 'MANTENCIÓN', 'Personal que realiza las reparaciones de los servicios. '),
	(00000000002, 1, 'FRONT', 'Área donde los colaboradores recepcionan llamados. '),
	(00000000003, 1, 'ATENCIONES TÉCNICAS', 'Personal que realiza la configuraciones de servicio.'),
	(00000000006, 1, 'MANUTENCIÓN DE DATOS', 'DETALLE DE MANUTENCIÓN DE DATOS'),
	(00000000012, 2, 'Gestión de combustible', '2');
/*!40000 ALTER TABLE `area_departamento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.attachment
CREATE TABLE IF NOT EXISTS `attachment` (
  `ID` bigint(20) NOT NULL,
  `FILE_NAME` varchar(50) NOT NULL,
  `FILE_DATA` blob NOT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.attachment: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `attachment` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.avance
CREATE TABLE IF NOT EXISTS `avance` (
  `idAvance` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `idTarea_fk` int(11) DEFAULT NULL,
  `idOrdenTrabajo_fk` int(11) DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `comentario` longtext DEFAULT NULL,
  `fecha_publicacion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idAvance`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.avance: ~63 rows (aproximadamente)
/*!40000 ALTER TABLE `avance` DISABLE KEYS */;
REPLACE INTO `avance` (`idAvance`, `idEmpresa`, `idTarea_fk`, `idOrdenTrabajo_fk`, `usuario`, `comentario`, `fecha_publicacion`) VALUES
	(00000000007, 1, NULL, 1, 40, 'armin, necesito que documentes', '2018-07-24 18:14:23'),
	(00000000008, 1, 1, 1, 26, 'bueno', '2018-07-24 18:14:39'),
	(00000000009, 1, NULL, 7, 16, 'Alonso, favor documentar....', '2018-07-24 18:20:03'),
	(00000000010, 1, 6, 7, 17, 'okey!', '2018-07-24 18:20:35'),
	(00000000011, 1, 6, 7, 17, 'wena', '2018-07-24 18:27:21'),
	(00000000012, 1, NULL, 8, 16, 'alonso, favor documentar...', '2018-08-13 20:55:52'),
	(00000000013, 1, 7, 8, 17, 'ok ningun problema.!!', '2018-08-13 20:56:22'),
	(00000000014, 1, NULL, 9, 16, 'oye patricio, documente plz.', '2018-08-14 11:13:59'),
	(00000000015, 1, 8, 9, 3, 'ok', '2018-08-14 11:14:29'),
	(00000000016, 1, NULL, 1, 40, 'ha pasado tiempo, son necesarios avances.\r\n', '2018-09-10 13:58:18'),
	(00000000017, 1, NULL, 11, 16, 'alonso, favor documentar...', '2018-09-20 21:11:58'),
	(00000000018, 1, 10, 11, 17, 'aahh yaa, esperamee', '2018-09-20 21:12:26'),
	(00000000020, 1, 1, 1, 26, 'Se procederá con el cierre de la tarea, no se realiza debido a que no se cuentan con las herramientas necesarias para llevar a cabo la tarea.', '2018-09-23 01:17:54'),
	(00000000021, 1, NULL, 1, 40, 'Armin, se genera nueva tarea y son asignados los recursos necesarios para la realización de esta. ', '2018-09-23 02:40:29'),
	(00000000022, 1, 11, 1, 26, 'las herramientas han llegado correctamente, comenzare a trabajar en lo solicitado...', '2018-09-23 02:42:08'),
	(00000000023, 1, NULL, 1, 40, 'Estarán ya terminadas las tareas solicitadas?', '2018-09-23 16:29:53'),
	(00000000024, 1, 11, 1, 26, 'Esta terminado, procederé con el cierre de la tarea. adjunto las pruebas\r\n\r\nC:\\Users\\Lechuga>ping 8.8.8.8\r\n\r\nHaciendo ping a 8.8.8.8 con 32 bytes de datos:\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=461ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=224ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=26ms TTL=118\r\nRespuesta desde 8.8.8.8: bytes=32 tiempo=27ms TTL=118\r\n\r\nEstadísticas de ping para 8.8.8.8:\r\n    Paquetes: enviados = 4, recibidos = 4, perdidos = 0\r\n    (0% perdidos),\r\nTiempos aproximados de ida y vuelta en milisegundos:\r\n    Mínimo = 26ms, Máximo = 461ms, Media = 184ms\r\n\r\nC:\\Users\\Lechuga>', '2018-09-23 16:30:50'),
	(00000000025, 1, NULL, 1, 40, 'Ivan, favor realizar monitoreo proactivo del enlace ya reparado por armin', '2018-09-23 16:56:49'),
	(00000000026, 1, 2, 1, 27, 'tarea en ejecución, sera monitoreado por 5 horas.', '2018-09-23 16:59:44'),
	(00000000027, 1, NULL, 1, 40, 'gracias, favor informarnos cualquier eventualidad', '2018-09-23 17:01:43'),
	(00000000028, 1, 2, 1, 27, 'servicio caido, favor reactivar tarea de armin', '2018-09-23 17:02:01'),
	(00000000029, 1, NULL, 1, 40, 'Gracias Ivan.', '2018-09-23 17:02:15'),
	(00000000030, 1, 1, 1, 40, 'Armin, favor gestionar nuevamente, servicio caido...', '2018-09-23 17:04:34'),
	(00000000031, 1, 1, 1, 26, 'okey, favor entregar las herramientas necesarias para poder llevar a cabo el trabajo. ', '2018-09-23 17:04:51'),
	(00000000032, 1, 1, 1, 26, 'aún no llegan los materiales...', '2018-09-23 17:16:50'),
	(00000000033, 1, NULL, 10, 16, 'Patricio, favor comenzar con lo solicitado', '2018-09-23 17:25:30'),
	(00000000034, 1, 9, 10, 3, 'trabajos serán informados en la medida que sean entregados los antecedentes por parte de Planta Externa que esta a mi cargo. ', '2018-09-23 17:26:35'),
	(00000000035, 1, NULL, 10, 16, 'muchas gracias.', '2018-09-23 17:26:48'),
	(00000000036, 1, NULL, 1, 40, 'están listos, favor reparar.', '2018-09-23 17:53:49'),
	(00000000037, 1, 1, 1, 26, 'queda reparado', '2018-09-23 17:54:02'),
	(00000000038, 1, NULL, 1, 40, 'no es necesario mas monitoreo, favor cerrar ambas tareas para proceder con el cierre de la ot\r\n', '2018-09-23 17:54:23'),
	(00000000039, 1, 1, 1, 26, 'ok', '2018-09-23 17:54:27'),
	(00000000040, 1, 2, 1, 27, 'okey', '2018-09-23 17:54:44'),
	(00000000041, 1, NULL, 2, 16, 'Armin favor configurar', '2018-09-23 21:01:49'),
	(00000000042, 1, 12, 2, 26, 'realizado, se procede con el cierre de la tarea', '2018-09-23 21:02:16'),
	(00000000043, 1, 13, 13, 16, 'Armin, favor documentar!', '2018-09-25 16:32:24'),
	(00000000044, 1, 13, 13, 26, 'okey', '2018-09-25 16:32:44'),
	(00000000045, 1, 13, 13, 26, 'termando, servicio reparado.', '2018-09-25 16:32:54'),
	(00000000046, 1, NULL, 13, 16, 'no armin, no quedo reparado. Se devuelve la tarea\r\n', '2018-09-25 16:33:43'),
	(00000000047, 1, 13, 13, 26, 'queda reparado.', '2018-09-25 16:34:47'),
	(00000000048, 1, 13, 13, 26, 'favor cerrar la tareea', '2018-09-26 17:39:13'),
	(00000000049, 1, 13, 13, 26, 'oka', '2018-10-03 00:19:24'),
	(00000000050, 1, 14, 14, 26, 'He comenzado la tarea', '2018-10-04 10:32:24'),
	(00000000051, 1, NULL, 14, 40, 'favor dar avances', '2018-10-04 10:32:43'),
	(00000000054, 1, 15, 14, 42, 'qwd', '2018-10-21 18:25:11'),
	(00000000055, 1, 15, 14, 42, 'QWE', '2018-10-31 20:27:24'),
	(00000000056, 2, NULL, 19, 40, 'qwe', '2018-11-01 22:41:59'),
	(00000000057, 2, NULL, 20, 40, '123', '2018-11-02 16:38:20'),
	(00000000058, 2, 21, 20, 17, 'Comienzo de la actividad', '2018-11-02 16:39:10'),
	(00000000059, 2, 21, 20, 17, 'Se cargan los combustible de acuerdo a lo solicitado. ', '2018-11-02 16:39:39'),
	(00000000060, 2, 21, 20, 17, '123', '2018-11-02 16:41:57'),
	(00000000061, 2, NULL, 19, 40, 'werwer', '2018-11-02 16:42:15'),
	(00000000062, NULL, NULL, 19, 40, '123', '2018-11-02 16:51:04'),
	(00000000063, NULL, NULL, 19, 40, '456', '2018-11-02 16:51:13'),
	(00000000064, NULL, NULL, 20, 40, '12123', '2018-11-02 16:52:21'),
	(00000000065, 2, 21, 20, 17, '456', '2018-11-02 16:53:16'),
	(00000000066, 2, 21, 20, 40, '789', '2018-11-02 16:53:49'),
	(00000000067, 2, 21, 20, 17, '101112', '2018-11-02 16:55:05'),
	(00000000068, NULL, NULL, 20, 40, '131415', '2018-11-02 16:55:17'),
	(00000000069, 1, 14, 14, 26, 'ahora yo tengo la tarea....', '2018-11-14 16:30:50'),
	(00000000070, 1, 14, 14, 26, 'sdfsdf', '2018-11-14 16:31:02'),
	(00000000071, 1, 14, 14, 26, 'ya pero no me critiquen, chanchos cochinos', '2018-11-15 00:42:06'),
	(00000000072, 1, 3, 4, 40, 'asd', '2018-11-15 23:38:46');
/*!40000 ALTER TABLE `avance` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.contacto
CREATE TABLE IF NOT EXISTS `contacto` (
  `idContacto` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `asunto` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `mensaje` longtext DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idContacto`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.contacto: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `contacto` DISABLE KEYS */;
REPLACE INTO `contacto` (`idContacto`, `idEmpresa`, `idUsuario`, `nombre`, `asunto`, `email`, `telefono`, `mensaje`, `fecha`) VALUES
	(00000000014, NULL, NULL, 'Mauricio Cortazar', 'Problemas en el registro', 'mauricio.cortazar@gmail.com', '569856325654', 'Me sale que la cuenta esta des-habilitada. Favor habilitar.', '2018-07-15 22:58:58'),
	(00000000017, NULL, NULL, 'Don Hernan', 'Ingreso a la web', 'hernan.coelo@gmail.com', '56986565987', 'Hola, buenas, tengo algunas dudas sobre el sitio, favor contactarme vía correo...', '2018-07-23 08:39:21'),
	(00000000018, NULL, NULL, 'Matias', 'Pregunta', 'matias@gmail.com', '56989865895', 'Necesito ingresar pero no puedo', '2018-07-23 09:25:00'),
	(00000000020, NULL, NULL, 'anonimo', 'IP de los nodos', 'jose.rios2@gmail.com', '2123', 'podrías agregar un documento con la IP de todos los nodos!!', '2018-09-21 17:42:18'),
	(00000000029, NULL, NULL, 'Juanelo', 'No puedo ingresar :(', 'juanelo@micarro.cl', '5698656', 'No puedo ingresar con la cuenta de JUANELO.CARAELO', '2018-11-03 15:23:37'),
	(00000000030, 1, 1, 'Fernando San Juan', 'Prueba', 'a@a.com', '12341234', 'Prueba\r\n', '2018-11-03 15:24:14'),
	(00000000031, NULL, NULL, 'werwer', 'werwer', 'asachileno@gmail.com', '3234324', 'ewefwef,l', '2018-11-14 01:33:40');
/*!40000 ALTER TABLE `contacto` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.empresa
CREATE TABLE IF NOT EXISTS `empresa` (
  `idEmpresa` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `rut` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.empresa: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
REPLACE INTO `empresa` (`idEmpresa`, `nombre`, `direccion`, `rut`, `telefono`) VALUES
	(00000000001, 'Claro S.A', 'Fanor Velasco 50', '70.750.500-K', '800 000 171'),
	(00000000002, 'ENEX LTDA', 'Chiu Chiu 2020', '81.555.656-5', '800 171 544');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT 0,
  `nombreEstado` varchar(50) DEFAULT NULL,
  `detalleEstado` longtext DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.estado: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
REPLACE INTO `estado` (`idEstado`, `idEmpresa`, `nombreEstado`, `detalleEstado`) VALUES
	(00000000001, 0, 'Generada', 'Actividad recién creada'),
	(00000000002, 0, 'Ejecución', 'Actividades en proceso'),
	(00000000003, 0, 'Suspensión', 'Actividades suspendidas'),
	(00000000004, 0, 'Ejecutada', 'Actividades realizadas'),
	(00000000005, 0, 'Cerrada', 'Actividad cerrada'),
	(00000000051, 1, 'Despachado', 'Despachado'),
	(00000000059, 2, 'Explotado', '2');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.orden_trabajo
CREATE TABLE IF NOT EXISTS `orden_trabajo` (
  `idOrdenTrabajo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `importancia` varchar(50) DEFAULT NULL,
  `supervisor` int(11) DEFAULT NULL,
  `idProcedimiento` int(11) DEFAULT 0,
  `nombreOrdenTrabajo` varchar(50) DEFAULT NULL,
  `detalleOrdenTrabajo` longtext DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_fin` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idOrdenTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.orden_trabajo: ~22 rows (aproximadamente)
/*!40000 ALTER TABLE `orden_trabajo` DISABLE KEYS */;
REPLACE INTO `orden_trabajo` (`idOrdenTrabajo`, `idEmpresa`, `importancia`, `supervisor`, `idProcedimiento`, `nombreOrdenTrabajo`, `detalleOrdenTrabajo`, `fecha_inicio`, `fecha_fin`, `estado`) VALUES
	(00000000001, 1, 'Alta', 40, 0, 'Generar informe de servicios', 'sdfsdf', '2018-07-23 15:54:11', NULL, 5),
	(00000000002, 1, 'Baja', 16, 0, 'Configuración de Servicio', 'Congiurar en PE 171 tabla de host', '2018-07-24 14:00:42', NULL, 5),
	(00000000003, 1, 'Media', 24, 0, 'Informe de Servicios', 'sdf', '2018-07-24 14:00:50', NULL, 1),
	(00000000004, 1, 'Baja', 40, 0, 'Informe de Datos', 'werwer', '2018-07-24 14:00:57', NULL, 1),
	(00000000005, 1, 'Alta', 40, 0, 'Convergencia de Int64', 'dfbdfb', '2018-07-24 14:01:06', NULL, 1),
	(00000000006, 1, 'Media', 40, 0, 'Coniguración entorno de Prueabas', 'fgdfg', '2018-07-24 14:01:14', NULL, 3),
	(00000000007, 1, 'Baja', 16, 0, 'Configuración de Equipos', 'LOJSDLKFJLKSDJFLKSDJF', '2018-07-24 18:19:02', NULL, 3),
	(00000000008, 1, 'Alta', 16, 0, 'Reparación', 'Reparar la wea', '2018-08-13 20:54:48', NULL, 1),
	(00000000009, 1, 'Media', 16, 0, 'Solicitud de Prueba', 'SE NECESITA QUE TODOS TERMINEN SUS TAREAS ', '2018-08-14 11:13:18', NULL, 1),
	(00000000010, 1, 'Alta', 16, 0, 'Tienda Kayser caida', 'Nombre de Quien Reporta: ALEJANDRO SANTIS \r\nProblema Reportado : Problema de internet y estamos presentando problemas con la gran mayoría de los anexos telefónicos del sector Espigon, estos quedan solicitando login y contraseña y luego de ser ingresados levantan pero a los 5 min vuelven a caer y solicitar login y contraseña nuevamente. Favor sus gestiones para solucionar este problema lo antes posible dado que dificulta la gestión de los usuarios al ser el teléfono una herramienta importante para sus labores diarios.\r\nPruebas realizadas por Cliente : ni\r\n', '2018-09-20 15:00:43', NULL, 11),
	(00000000011, 1, 'Alta', 16, 0, 'Servicio caido', 'jlaksjdlajslkdjalsdjklasjdlkasjdlksajd\r\n\r\nhacer la wea que pido jajaja', '2018-09-20 21:11:26', NULL, 1),
	(00000000012, 1, 'Alta', 16, 0, 'Gestión de Gastos', 'ghj', '2018-09-22 14:11:33', NULL, 2),
	(00000000013, 1, 'Alta', 16, 0, 'Reparar servicio de datos', 'favor completar las tareas solicitadas', '2018-09-25 16:31:55', NULL, 5),
	(00000000014, 1, 'Alta', 40, 0, 'Solicitud de Prueba', 'Detalle de Prueba', '2018-10-04 10:30:57', NULL, 1),
	(00000000015, 1, 'Alta', 16, 1, '123', '345', '2018-10-21 17:31:19', NULL, 1),
	(00000000016, 1, 'Media', 40, 0, 'OT ', '123', '2018-11-01 19:25:00', NULL, 1),
	(00000000019, 2, 'Alta', 40, 0, 'OT Prueba Empresa ENEX', 'Detalle', '2018-11-01 22:20:32', NULL, 5),
	(00000000020, 2, 'Media', 40, 0, 'OT Prueba', 'solas', '2018-11-02 01:28:05', NULL, 1),
	(00000000021, 2, 'Alta', 40, 1, 'Carga de Combustible ', 'Se requiere realizar la carga de combustible de A1 a A20', '2018-11-03 19:13:50', NULL, 1),
	(00000000023, 1, 'Alta', 40, 1, 'aasdasd', 'qweqweqwe', '2018-11-14 23:17:42', NULL, 1),
	(00000000024, 1, 'Alta', 40, 0, 'asdasd', 'asdasd', '2018-11-15 23:35:53', NULL, 1),
	(00000000025, 1, 'Alta', 40, 0, 'asdasd', 'asdasd', '2018-11-15 23:36:41', NULL, 1);
/*!40000 ALTER TABLE `orden_trabajo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.paso
CREATE TABLE IF NOT EXISTS `paso` (
  `idPaso` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
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
  `idProcedimiento` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `nombreProcedimiento` varchar(50) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `detalleProcedimiento` text DEFAULT NULL,
  PRIMARY KEY (`idProcedimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.procedimiento: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `procedimiento` DISABLE KEYS */;
REPLACE INTO `procedimiento` (`idProcedimiento`, `idEmpresa`, `nombreProcedimiento`, `fecha_creacion`, `detalleProcedimiento`) VALUES
	(00000000000, 1, 'Sin Asignar', '2018-11-14 23:22:18', NULL),
	(00000000001, 2, 'Carga de Combustible', '2018-11-03 17:05:17', 'Detallados en PDF'),
	(00000000002, 1, 'Reparación Servicio Datos', '2018-11-13 00:54:23', 'Procedimiento ante falla por caida de servicio de datos o degradación del servicio.');
/*!40000 ALTER TABLE `procedimiento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tarea
CREATE TABLE IF NOT EXISTS `tarea` (
  `idTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `idTipoTarea` int(11) DEFAULT NULL,
  `idOrdenTrabajo` int(11) DEFAULT NULL,
  `idProcedimiento` int(11) DEFAULT 0,
  `usuario` int(11) DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `estadoTarea` int(11) DEFAULT NULL,
  PRIMARY KEY (`idTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tarea: ~22 rows (aproximadamente)
/*!40000 ALTER TABLE `tarea` DISABLE KEYS */;
REPLACE INTO `tarea` (`idTarea`, `idEmpresa`, `idTipoTarea`, `idOrdenTrabajo`, `idProcedimiento`, `usuario`, `fecha_inicio`, `fecha_fin`, `estadoTarea`) VALUES
	(00000000001, 1, 1, 1, 0, 26, '2018-07-23 15:54:28', NULL, 5),
	(00000000002, 1, 3, 1, 0, 27, '2018-07-24 14:01:33', NULL, 5),
	(00000000003, 1, 3, 4, 0, 23, '2018-07-24 14:01:40', NULL, 1),
	(00000000004, 1, 2, 5, 0, 23, '2018-07-24 14:01:58', NULL, 1),
	(00000000005, 1, 7, 6, 0, 23, '2018-07-24 14:02:09', NULL, 1),
	(00000000006, 1, 2, 7, 0, 17, '2018-07-24 18:19:53', NULL, 2),
	(00000000007, 1, 1, 8, 0, 17, '2018-08-13 20:55:40', NULL, 5),
	(00000000008, 1, 1, 9, 0, 3, '2018-08-14 11:13:47', NULL, 1),
	(00000000009, 1, 9, 10, 0, 3, '2018-09-20 15:02:29', NULL, 2),
	(00000000010, 1, 1, 11, 0, 17, '2018-09-20 21:11:48', NULL, 5),
	(00000000011, 1, 1, 1, 0, 26, '2018-09-23 02:39:51', NULL, 5),
	(00000000012, 1, 2, 2, 0, 26, '2018-09-23 21:01:38', NULL, 5),
	(00000000013, 1, 1, 13, 0, 26, '2018-09-25 16:32:10', NULL, 5),
	(00000000014, 1, 1, 14, 0, 26, '2018-10-04 10:31:44', NULL, 1),
	(00000000015, 1, 1, 14, 0, 42, '2018-10-17 15:33:31', NULL, 2),
	(00000000016, 1, 1, 14, 0, 23, '2018-11-01 19:00:08', NULL, 5),
	(00000000019, 2, NULL, 19, 0, 27, '2018-11-01 22:37:07', NULL, 1),
	(00000000020, 1, 11, 16, 0, 23, '2018-11-01 22:41:20', NULL, 1),
	(00000000021, 2, 16, 20, 0, 17, '2018-11-02 16:38:31', NULL, 1),
	(00000000022, 2, 25, 20, 1, 17, '2018-11-03 16:39:24', NULL, 1),
	(00000000023, 1, 1, 23, 0, 26, '2018-11-14 23:17:59', NULL, 1),
	(00000000024, 2, 25, 21, 0, 17, '2018-11-15 23:43:51', NULL, 1);
/*!40000 ALTER TABLE `tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tipo_tarea
CREATE TABLE IF NOT EXISTS `tipo_tarea` (
  `idTipoTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `idProcedimiento` int(11) DEFAULT NULL,
  `nombreTipoTarea` varchar(50) DEFAULT NULL,
  `detalleTipoTarea` longtext DEFAULT NULL,
  PRIMARY KEY (`idTipoTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tipo_tarea: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_tarea` DISABLE KEYS */;
REPLACE INTO `tipo_tarea` (`idTipoTarea`, `idEmpresa`, `idProcedimiento`, `nombreTipoTarea`, `detalleTipoTarea`) VALUES
	(00000000001, 1, NULL, 'Reparación', 'Reparación para servicio de Datos, Telefonía o Internet. '),
	(00000000002, 1, NULL, 'Atención Técnica', 'Realizar configuraciones sobre servicios de Telefonía, Datos o Internet. '),
	(00000000003, 1, NULL, 'Monitoreo Proactivo', 'Monitorear enlaces solicitados. '),
	(00000000007, 1, NULL, 'Redactar Informe de Servicios', 'Redactar Informe de servicios'),
	(00000000009, 1, NULL, 'Reparación Mall', 'asdasd'),
	(00000000010, 1, NULL, 'Despacho', 'wefwef'),
	(00000000011, 1, NULL, 'Tarea de Prueba', 'asdasd'),
	(00000000016, 2, NULL, 'Descarga de Combustible', NULL),
	(00000000025, 2, NULL, 'Carga Combustible', '19');
/*!40000 ALTER TABLE `tipo_tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.trabaja
CREATE TABLE IF NOT EXISTS `trabaja` (
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `idUsuario` int(11) unsigned zerofill DEFAULT NULL,
  `activo` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.trabaja: ~17 rows (aproximadamente)
/*!40000 ALTER TABLE `trabaja` DISABLE KEYS */;
REPLACE INTO `trabaja` (`idEmpresa`, `idUsuario`, `activo`) VALUES
	(00000000001, 00000000016, 'S'),
	(00000000001, 00000000001, 'S'),
	(00000000001, 00000000023, 'S'),
	(00000000001, 00000000026, 'S'),
	(00000000002, 00000000027, 'S'),
	(00000000001, 00000000024, 'S'),
	(00000000001, 00000000032, 'S'),
	(00000000001, 00000000042, 'S'),
	(00000000001, 00000000003, 'S'),
	(00000000001, 00000000040, 'S'),
	(00000000002, 00000000017, 'S'),
	(00000000001, 00000000022, 'S'),
	(00000000002, 00000000042, 'S'),
	(00000000002, 00000000040, 'S'),
	(00000000002, 00000000001, 'S'),
	(00000000001, 00000000086, 'S'),
	(00000000002, 00000000087, 'S');
/*!40000 ALTER TABLE `trabaja` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `rut` varchar(10) DEFAULT NULL,
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
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.usuario: ~14 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
REPLACE INTO `usuario` (`idUsuario`, `rut`, `nombre`, `apellido`, `nombreUsuario`, `email`, `telefono_m`, `telefono_f`, `area_departamento`, `direccion`, `tipoCuenta`, `clave`) VALUES
	(0000000001, '15765734-8', 'Administrador', 'San Juan', 'ADMIN', 'adminitrador@aelitasoft.cl', '012341234', '12341234', '1', '0', 'Administrador', 'Teleco123'),
	(0000000003, '21624006-5', 'Patricio', 'Contreras', 'PATRICIO.CONTRERAS', 'patricio.a.contreras@clarochile.cl', '225811562', '12341234', '1', 'Fanor Verlasco #50', 'Ejecutor', 'Teleco123'),
	(0000000016, '23927700-4', 'Gisselle', 'San Martin', 'GISSELLE.SANMARTIN', 'gisselle.sanmartin@clarochile.cl', '+569258115', '+562258115', '0', 'Fanor Velasco 50', 'Supervisor', 'Teleco123'),
	(0000000017, '24707234-9', 'Alonso', 'Pineda', 'ALONSO.PINEDA', 'alonso.pineda@clarochile.cl', '1234', '1234', '00000000012', 'Fanor Velasco 50', 'Ejecutor', 'Teleco123'),
	(0000000022, '15410254-k', 'Nicolas', 'Medrano', 'NICOLAS.MEDRANO', 'nicolas.medrano@inacapmail.cl', '994013263', '225942131', '2', 'Fanor Velasco 200', 'Ejecutor', 'Teleco123'),
	(0000000023, '16976872-2', 'Josue', 'Cea', 'JOSUE.CEA', 'josue.cea@gmail.com', '56958980102', '0000000000', '0', 'Av. manuel antonio matta 0329, Quilicura', 'Ejecutor', 'Teleco123'),
	(0000000024, '19199563-5', 'Eduardo', 'Salinas', 'EDUARDO.SALINAS', 'eduardoinbrand@gmail.com', '0954458279', '0954458279', '0', 'Ignacio Carrera Pinto 67', 'Supervisor', 'Teleco123'),
	(0000000026, '20662537-6', 'Armin', 'Brün', 'ARMIN.BRUN', 'armin.brun@chancho.cl', '543857421', '5321158', '0', 'Almirante Barroso 76', 'Ejecutor', 'Teleco123'),
	(0000000027, '19360023-9', 'ivan', 'camote', 'IVAN.CAMOTE', 'ivan@gmail.com', '563256325', '5632563256', '00000000012', 'pn89', 'Ejecutor', 'Teleco123'),
	(0000000032, '24534111-3', 'DAVID', 'SANJUAN', 'DAVID.SANJUAN', 'davidsanjuan19938@gmail.com', '655656565', '56569569565', '0', 'El clavel poniente 2416', 'Supervisor', 'Teleco123'),
	(0000000040, '19162744-k', 'Fernando', 'San Juan', 'FERNANDO.SANJUAN', 'fernando.sanjuan@clarochile.cl', '1234', '1234', '00000000012', 'El clavel poniente 2416', 'Supervisor', 'Teleco123'),
	(0000000042, '21388781-5', 'José', 'Rios', 'JOSE.RIOS', 'jose.rios2@clarochile.cl', '967890728', '22123123', '00000000012', 'fanor 50', 'Ejecutor', 'Teleco123'),
	(0000000086, '11222333-4', 'wefwefwe', 'fwefwefwe', 'WEFWEFWE.FWEFWEFWE', 'a@a.com', '123123123', '123123123', '00000000002', '123123', 'Supervisor', '123123'),
	(0000000087, '22333444-5', 'Manuel', 'Lopez', 'MANUEL.LOPEZ', 'ml@gmail.com', '5693265454', '562456845', '00000000012', 'Javiera Carrera 2413', 'Ejecutor', 'Teleco123');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
