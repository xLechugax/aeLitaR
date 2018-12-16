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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.actividad: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
REPLACE INTO `actividad` (`idActividad`, `idProcedimiento`, `idEmpresa`, `nombreActividad`, `detalleActividad`) VALUES
	(0000000012, 4, 9, 'Solicitar Artículos ', 'Se solicitan los artículos '),
	(0000000013, 4, 9, 'Cotizar', 'Cotizar los artículos involucrados '),
	(0000000014, 4, 9, 'Compra ', 'Compra de los artículos '),
	(0000000015, 4, 9, 'Despacho/Envío', 'Despacho/Envío'),
	(0000000016, 4, 9, 'Venta', 'Venta'),
	(0000000017, 5, 9, 'Actividad 1', 'detalle actividad 1'),
	(0000000018, 5, 9, 'Actividad 2 ', 'Actividad 2 '),
	(0000000019, 6, 14, 'qweqweqwe', 'qweqweqwe'),
	(0000000020, 6, 14, '4534543', '5345345345'),
	(0000000021, 6, 14, '234234', '234234'),
	(0000000022, 7, 16, 'Actividad 1', 'detalle'),
	(0000000023, 7, 16, 'Actividad 2 ', 'detalle');
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.archivo
CREATE TABLE IF NOT EXISTS `archivo` (
  `idArchivo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `idAvance` int(11) unsigned zerofill DEFAULT NULL,
  `idTarea` int(11) unsigned zerofill DEFAULT NULL,
  `idOrdenTrabajo` int(11) unsigned zerofill DEFAULT NULL,
  `idProcedimiento` int(11) unsigned zerofill DEFAULT NULL,
  `idPaso` int(11) unsigned zerofill DEFAULT NULL,
  `archivo` mediumblob DEFAULT NULL,
  `nombre` varchar(250) NOT NULL DEFAULT '',
  `type` char(20) NOT NULL DEFAULT '',
  `detalleArchivo` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `fechaCreacion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idArchivo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.area_departamento: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `area_departamento` DISABLE KEYS */;
REPLACE INTO `area_departamento` (`idAreaDepartamento`, `idEmpresa`, `nombreAreaDepartamento`, `detalleAreaDepartamento`) VALUES
	(00000000000, 0, 'SIN ASIGNAR', NULL),
	(00000000001, 1, 'MANTENCIÓN', 'Personal que realiza las reparaciones de los servicios. '),
	(00000000002, 1, 'FRONT', 'Área donde los colaboradores recepcionan llamados. '),
	(00000000003, 1, 'ATENCIONES TÉCNICAS', 'Personal que realiza la configuraciones de servicio.'),
	(00000000006, 1, 'MANUTENCIÓN DE DATOS', 'DETALLE DE MANUTENCIÓN DE DATOS'),
	(00000000012, 2, 'Gestión de combustible', 'Gestión de combustible'),
	(00000000017, 6, 'Gestión de Flota', 'Gestión de Flota'),
	(00000000018, 9, 'Gerencia', 'Gerencia de empresa JACK CUSTO LTDA'),
	(00000000019, 9, 'Venta', 'Área de venta de la empresa JACK CUSTO LTDA'),
	(00000000020, 9, 'Logística ', 'Área de logística de empresa JACK CUSTO LTDA '),
	(00000000021, 9, 'Administración', 'Administración'),
	(00000000022, 9, 'Gestión de Combustible', 'Gestión de Combustible'),
	(00000000023, 14, 'Gestión de Hambre', 'Gestión de Hambre'),
	(00000000024, 16, 'Gerencia', 'Gerencia');
/*!40000 ALTER TABLE `area_departamento` ENABLE KEYS */;

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
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.avance: ~61 rows (aproximadamente)
/*!40000 ALTER TABLE `avance` DISABLE KEYS */;
REPLACE INTO `avance` (`idAvance`, `idEmpresa`, `idTarea_fk`, `idOrdenTrabajo_fk`, `usuario`, `comentario`, `fecha_publicacion`) VALUES
	(00000000007, 1, NULL, 1, 40, 'armin, necesito que documentes', '2018-07-24 18:14:23'),
	(00000000008, 1, 1, 1, 26, 'bueno', '2018-07-24 18:14:39'),
	(00000000009, 1, NULL, 7, 16, 'Alonso, favor documentar....', '2018-07-24 18:20:03'),
	(00000000010, 1, 6, 7, 17, 'okey!', '2018-07-24 18:20:35'),
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
	(00000000058, 2, 21, 20, 17, 'Comienzo de la actividad', '2018-11-02 16:39:10'),
	(00000000059, 2, 21, 20, 17, 'Se cargan los combustible de acuerdo a lo solicitado. ', '2018-11-02 16:39:39'),
	(00000000069, 1, 14, 14, 26, 'ahora yo tengo la tarea....', '2018-11-14 16:30:50'),
	(00000000071, 1, 14, 14, 26, 'ya pero no me apuren', '2018-11-15 00:42:06'),
	(00000000073, 1, 14, 14, 26, 'voy a cerraaaar la tareaa!', '2018-11-19 19:22:07'),
	(00000000074, 1, 23, 23, 26, 'Hola', '2018-11-19 20:21:47'),
	(00000000075, 1, 23, 23, 26, 'no puede ser', '2018-11-19 20:21:53'),
	(00000000076, 1, 23, 23, 26, 'Este comentario debe ser realizado por ellos,\r\nEntiendo lo que ocurre\r\n', '2018-11-19 20:22:14'),
	(00000000077, 1, 23, 23, 26, 'se procederá con el cierre de la tarea.', '2018-11-19 20:39:08'),
	(00000000078, 1, 28, 32, 40, 'armin! documenta!!', '2018-11-21 18:30:10'),
	(00000000079, 1, 28, 32, 26, 'okeeey!', '2018-11-21 18:30:42'),
	(00000000080, NULL, NULL, 33, 26, 'Marisol, como te va con lo de la mina?', '2018-11-22 05:39:57'),
	(00000000081, 6, 29, 33, 90, 'bien, estoy comenzando de a poco', '2018-11-22 05:53:51'),
	(00000000082, NULL, NULL, 33, 26, 'ok, necesito que me informes cada vez que avances 300 metros, saludos.', '2018-11-22 05:54:30'),
	(00000000083, NULL, NULL, 33, 26, 'recuerda cambiar el estado de tu tarea', '2018-11-22 05:55:04'),
	(00000000085, NULL, NULL, 37, 92, 'Por favor comprar los artículos solicitados, para su posterior envío.', '2018-12-12 16:22:37'),
	(00000000086, 9, 33, 37, 94, 'Ok, iré ahora.', '2018-12-12 16:40:25'),
	(00000000087, 9, 34, 39, 94, 'asdasd', '2018-12-12 17:10:39'),
	(00000000088, 9, 34, 39, 94, 'comentario', '2018-12-12 17:36:58'),
	(00000000089, NULL, NULL, 41, 93, 'Manuel, favor comenzar actividades.', '2018-12-13 13:08:50'),
	(00000000090, 9, 36, 41, 95, 'No se tienen materiales para comenzar ', '2018-12-13 13:09:55'),
	(00000000091, NULL, NULL, 44, 98, 'Barbara favor documentar la tarea asignada.', '2018-12-14 15:51:13'),
	(00000000092, 16, 37, 44, 99, 'okey', '2018-12-14 15:54:32'),
	(00000000093, NULL, NULL, 41, 93, 'Avances porfavor', '2018-12-15 12:38:06'),
	(00000000094, 9, 34, 39, 94, 'comentario', '2018-12-15 12:41:21');
/*!40000 ALTER TABLE `avance` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.cambio_estado
CREATE TABLE IF NOT EXISTS `cambio_estado` (
  `idCambioEstado` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idOrdenTrabajo` int(10) unsigned zerofill DEFAULT NULL,
  `idTarea` int(10) unsigned zerofill DEFAULT NULL,
  `idEmpresa` int(10) unsigned zerofill DEFAULT NULL,
  `motivo` tinytext DEFAULT NULL,
  `fecha_realizacion` timestamp NULL DEFAULT current_timestamp(),
  `fecha_fin` timestamp NULL DEFAULT NULL,
  `suspension` char(1) DEFAULT 'N',
  `identidad` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`idCambioEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.cambio_estado: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `cambio_estado` DISABLE KEYS */;
REPLACE INTO `cambio_estado` (`idCambioEstado`, `idOrdenTrabajo`, `idTarea`, `idEmpresa`, `motivo`, `fecha_realizacion`, `fecha_fin`, `suspension`, `identidad`) VALUES
	(0000000010, NULL, 0000000014, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Ejecución', '2018-11-18 21:13:36', NULL, 'N', NULL),
	(0000000011, NULL, 0000000014, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Despachado', '2018-11-18 21:17:21', NULL, 'N', NULL),
	(0000000012, NULL, 0000000014, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Ejecución', '2018-11-18 21:17:25', NULL, 'N', NULL),
	(0000000013, NULL, 0000000014, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Despachado', '2018-11-18 21:42:45', NULL, 'N', NULL),
	(0000000014, NULL, 0000000023, 0000000001, 'FERNANDO.SANJUAN cambió la tarea al estado Despachado', '2018-11-18 21:51:17', NULL, 'N', NULL),
	(0000000036, NULL, 0000000023, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Ejecución', '2018-11-19 14:53:12', NULL, 'N', NULL),
	(0000000061, 0000000014, 0000000014, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-19 15:41:00', NULL, 'N', NULL),
	(0000000063, 0000000014, 0000000014, 0000000001, 'Suspendida: Sin materiales', '2018-11-19 17:09:28', '2018-11-19 17:15:00', 'S', '6497767928819155'),
	(0000000064, 0000000014, 0000000014, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-19 17:15:00', NULL, 'N', NULL),
	(0000000065, 0000000014, 0000000014, 0000000001, 'Suspendida: a modo de prueba..', '2018-11-19 18:07:49', '2018-11-19 18:10:00', 'S', '2734562376419969'),
	(0000000066, 0000000014, 0000000014, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-19 18:29:07', NULL, 'N', NULL),
	(0000000067, 0000000023, 0000000023, 0000000001, 'Suspendida: Sin contacto con interesado.', '2018-11-19 19:02:56', '2018-11-19 20:00:00', 'S', '8377914087902508'),
	(0000000069, 0000000014, 0000000014, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-19 19:34:28', NULL, 'N', NULL),
	(0000000070, 0000000023, 0000000023, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-19 20:00:00', NULL, 'N', NULL),
	(0000000071, 0000000023, 0000000023, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-19 20:39:13', NULL, 'N', NULL),
	(0000000072, 0000000025, 0000000026, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-19 20:49:36', NULL, 'N', NULL),
	(0000000073, NULL, 0000000002, NULL, 'FERNANDO.SANJUAN ha regenerado la tarea.', '2018-11-19 21:25:21', NULL, 'N', NULL),
	(0000000074, 0000000001, 0000000001, 0000000001, 'Suspendida: sin pagos realizados para gestionar.', '2018-11-19 21:41:56', '2018-11-19 22:00:00', 'S', '09090210452749237'),
	(0000000075, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:50:05', NULL, 'N', NULL),
	(0000000076, NULL, 0000000002, NULL, 'FERNANDO.SANJUAN ha regenerado la tarea.', '2018-11-19 21:54:56', NULL, 'N', NULL),
	(0000000077, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:55:59', NULL, 'N', NULL),
	(0000000078, NULL, 0000000002, NULL, 'FERNANDO.SANJUAN ha regenerado la tarea.', '2018-11-19 21:56:04', NULL, 'N', NULL),
	(0000000079, NULL, 0000000002, NULL, 'FERNANDO.SANJUAN ha regenerado la tarea.', '2018-11-19 21:56:53', NULL, 'N', NULL),
	(0000000080, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:57:34', NULL, 'N', NULL),
	(0000000081, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN ha regenerado la tarea.', '2018-11-19 21:57:37', NULL, 'N', NULL),
	(0000000082, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:58:04', NULL, 'N', NULL),
	(0000000083, 0000000001, 0000000002, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-19 21:58:08', NULL, 'N', NULL),
	(0000000084, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:58:35', NULL, 'N', NULL),
	(0000000085, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-19 21:58:39', NULL, 'N', NULL),
	(0000000086, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:58:49', NULL, 'N', NULL),
	(0000000087, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-19 21:59:26', NULL, 'N', NULL),
	(0000000088, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 21:59:31', NULL, 'N', NULL),
	(0000000089, 0000000001, 0000000001, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-19 22:00:00', NULL, 'N', NULL),
	(0000000090, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-19 22:01:07', NULL, 'N', NULL),
	(0000000091, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 22:03:12', NULL, 'N', NULL),
	(0000000092, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-19 22:03:23', NULL, 'N', NULL),
	(0000000093, 0000000025, 0000000025, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-19 22:03:29', NULL, 'N', NULL),
	(0000000095, 0000000023, 0000000023, 0000000001, 'Suspendida: Sin contacto con interesado.', '2018-11-17 19:02:56', '2018-11-18 20:00:00', 'S', '8377914087902508'),
	(0000000096, 0000000001, 0000000001, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-19 23:30:50', NULL, 'N', NULL),
	(0000000097, 0000000014, 0000000014, 0000000001, 'Suspendida: a modo de prueba..', '2018-11-19 09:07:49', '2018-11-19 12:10:00', 'S', '2734562376419969'),
	(0000000098, 0000000014, 0000000014, 0000000001, 'Suspendida: pa mostrar a brahiam', '2018-11-20 14:10:59', '2018-11-20 14:12:00', 'S', '4355151253933319'),
	(0000000099, 0000000014, 0000000014, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-20 14:12:00', NULL, 'N', NULL),
	(0000000100, NULL, 0000000014, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Despachado', '2018-11-20 14:47:03', NULL, 'N', NULL),
	(0000000101, 0000000014, 0000000014, 0000000001, 'Suspendida: pa mostrar a cristian', '2018-11-20 14:47:30', '2018-11-20 14:48:00', 'S', '2658369766873959'),
	(0000000102, 0000000014, 0000000014, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-20 14:48:00', NULL, 'N', NULL),
	(0000000103, 0000000014, 0000000014, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-20 14:48:24', NULL, 'N', NULL),
	(0000000104, 0000000001, 0000000001, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-20 14:49:20', NULL, 'N', NULL),
	(0000000105, NULL, 0000000029, 0000000006, 'MARISOL.URRUTIA cambió la tarea al estado Ejecución', '2018-11-22 05:56:02', NULL, 'N', NULL),
	(0000000106, 0000000033, 0000000029, 0000000006, 'Suspendida: No se tienen materiales para minar.', '2018-11-22 05:56:26', '2018-11-22 08:00:00', 'S', '5776389691052198'),
	(0000000107, NULL, 0000000030, 0000000006, 'ARMIN.BRUN cambió la tarea al estado Ejecución', '2018-11-22 13:39:20', NULL, 'N', NULL),
	(0000000108, 0000000033, 0000000030, 0000000006, 'ADMIN cerró la tarea.', '2018-11-22 14:13:56', NULL, 'N', NULL),
	(0000000109, NULL, 0000000001, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Despachado', '2018-11-22 14:58:50', NULL, 'N', NULL),
	(0000000110, 0000000001, 0000000001, 0000000001, 'Suspendida: prueba', '2018-11-22 14:59:26', '2018-11-22 15:00:00', 'S', '15469495149515222'),
	(0000000111, 0000000033, 0000000029, 0000000006, 'Cambio de estado automatico luego de Suspención', '2018-11-22 14:59:26', NULL, 'N', NULL),
	(0000000112, 0000000001, 0000000001, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-22 15:00:00', NULL, 'N', NULL),
	(0000000113, 0000000001, 0000000001, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-11-22 15:00:22', NULL, 'N', NULL),
	(0000000114, NULL, 0000000027, 0000000001, 'ARMIN.BRUN cambió la tarea al estado Despachado', '2018-11-23 13:47:49', NULL, 'N', NULL),
	(0000000115, 0000000025, 0000000027, 0000000001, 'Suspendida: No se tienen materiales para minar.', '2018-11-23 13:48:12', '2018-11-24 10:00:00', 'S', '7823576553682482'),
	(0000000116, 0000000025, 0000000027, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-25 15:34:42', NULL, 'N', NULL),
	(0000000121, 0000000035, NULL, 0000000001, 'Suspendida: prueba', '2018-11-25 18:03:23', '2018-11-25 18:04:00', 'S', '021608666427994083'),
	(0000000122, 0000000035, NULL, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-11-25 18:04:00', NULL, 'N', NULL),
	(0000000123, 0000000035, NULL, 0000000001, 'FERNANDO.SANJUAN cambió la Orden de Trabajo al estado En ejecución', '2018-11-25 18:09:38', NULL, 'N', NULL),
	(0000000124, 0000000035, NULL, 0000000001, 'Suspendida: Prueba', '2018-11-25 18:13:17', '2018-11-25 18:14:00', 'S', '918588708421034'),
	(0000000125, 0000000035, NULL, 0000000001, 'Cambio de estado automatico luego de  periodo en suspención', '2018-11-25 18:14:00', NULL, 'N', NULL),
	(0000000126, 0000000035, NULL, 0000000001, 'Suspendida: prueba', '2018-11-25 18:18:10', '2018-11-25 18:19:00', 'S', '8548387328411239'),
	(0000000127, 0000000035, NULL, 0000000001, 'Cambio de estado automatico luego de  periodo en suspención', '2018-11-25 18:19:00', NULL, 'N', NULL),
	(0000000128, 0000000035, NULL, 0000000001, 'Suspendida: para editar código', '2018-11-25 18:21:00', '2018-11-25 19:00:00', 'S', '8567761492567367'),
	(0000000129, 0000000035, 0000000031, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 18:59:16', NULL, 'N', NULL),
	(0000000130, 0000000035, 0000000032, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 18:59:31', NULL, 'N', NULL),
	(0000000131, 0000000035, NULL, 0000000001, 'Cambio de estado automatico luego de  periodo en suspención', '2018-11-25 19:00:00', NULL, 'N', NULL),
	(0000000132, 0000000035, 0000000031, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-25 22:13:09', NULL, 'N', NULL),
	(0000000133, 0000000035, 0000000031, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 22:13:15', NULL, 'N', NULL),
	(0000000134, 0000000035, 0000000032, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-25 22:14:41', NULL, 'N', NULL),
	(0000000135, 0000000035, 0000000032, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 22:14:54', NULL, 'N', NULL),
	(0000000136, NULL, NULL, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 22:17:44', NULL, 'N', NULL),
	(0000000137, 0000000035, NULL, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 22:18:42', NULL, 'N', NULL),
	(0000000138, NULL, NULL, NULL, 'ADMIN regeneró la tarea.', '2018-11-25 22:34:06', NULL, 'N', NULL),
	(0000000139, 0000000035, NULL, NULL, 'ADMIN regeneró la tarea.', '2018-11-25 22:34:48', NULL, 'N', NULL),
	(0000000140, 0000000035, NULL, NULL, 'ADMIN regeneró la tarea.', '2018-11-25 22:34:56', NULL, 'N', NULL),
	(0000000141, 0000000035, NULL, 0000000001, 'ADMIN regeneró la orden de trabajo.', '2018-11-25 22:35:42', NULL, 'N', NULL),
	(0000000142, 0000000035, NULL, 0000000001, 'ADMIN cerró la tarea.', '2018-11-25 22:36:03', NULL, 'N', NULL),
	(0000000143, 0000000034, NULL, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 23:18:34', NULL, 'N', NULL),
	(0000000144, 0000000032, 0000000028, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-11-25 23:35:08', NULL, 'N', NULL),
	(0000000145, 0000000032, 0000000028, 0000000001, 'FERNANDO.SANJUAN regeneró la tarea.', '2018-11-25 23:43:39', NULL, 'N', NULL),
	(0000000146, 0000000035, NULL, 0000000001, 'ADMIN regeneró la orden de trabajo.', '2018-11-25 23:44:18', NULL, 'N', NULL),
	(0000000147, 0000000035, NULL, 0000000001, 'ADMIN cerró la tarea.', '2018-11-25 23:44:23', NULL, 'N', NULL),
	(0000000148, 0000000036, NULL, 0000000001, 'ADMIN cerró la tarea.', '2018-12-05 16:59:16', NULL, 'N', NULL),
	(0000000149, 0000000032, 0000000028, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-12-05 17:18:53', NULL, 'N', NULL),
	(0000000150, 0000000032, NULL, 0000000001, 'FERNANDO.SANJUAN cerró la tarea.', '2018-12-05 17:19:01', NULL, 'N', NULL),
	(0000000151, 0000000037, 0000000033, 0000000009, 'ÁNGEL.GONZÁLEZ cerró la tarea.', '2018-12-12 16:40:38', NULL, 'N', NULL),
	(0000000152, 0000000037, NULL, 0000000009, 'CUSTODIO.GONZÁLEZ cerró la tarea.', '2018-12-12 16:43:42', NULL, 'N', NULL),
	(0000000153, NULL, 0000000034, 0000000009, 'ÁNGEL.GONZÁLEZ cambió la tarea al estado En ejecución', '2018-12-12 17:11:01', NULL, 'N', NULL),
	(0000000154, 0000000039, 0000000034, 0000000009, 'Suspendida: prueba', '2018-12-12 17:11:23', '2018-12-12 17:12:00', 'S', '230547797223157'),
	(0000000155, 0000000039, 0000000034, 0000000009, 'Cambio de estado automatico luego de Suspención', '2018-12-12 17:12:00', NULL, 'N', NULL),
	(0000000156, 0000000040, NULL, 0000000009, 'LEONARDO.GONZÁLEZ cambió la Orden de Trabajo al estado En ejecución', '2018-12-13 12:27:05', NULL, 'N', NULL),
	(0000000157, 0000000040, NULL, 0000000009, 'Suspendida: prueba', '2018-12-13 12:27:26', '2018-12-13 12:28:00', 'S', '7895283874810012'),
	(0000000158, 0000000040, NULL, 0000000009, 'Cambio de estado automatico luego de  periodo en suspención', '2018-12-13 12:28:00', NULL, 'N', NULL),
	(0000000159, 0000000041, NULL, 0000000009, 'LEONARDO.GONZÁLEZ cambió la Orden de Trabajo al estado En ejecución', '2018-12-13 13:06:58', NULL, 'N', NULL),
	(0000000160, 0000000041, NULL, 0000000009, 'Suspendida: prueba', '2018-12-13 13:07:20', '2018-12-13 13:08:00', 'S', '6187385261858371'),
	(0000000161, 0000000041, NULL, 0000000009, 'Cambio de estado automatico luego de  periodo en suspención', '2018-12-13 13:08:00', NULL, 'N', NULL),
	(0000000162, NULL, 0000000036, 0000000009, 'MANUEL.GARATE cambió la tarea al estado En ejecución', '2018-12-13 13:09:34', NULL, 'N', NULL),
	(0000000163, 0000000041, 0000000036, 0000000009, 'MANUEL.GARATE cerró la tarea.', '2018-12-13 13:09:59', NULL, 'N', NULL),
	(0000000164, 0000000001, 0000000002, 0000000001, 'ADMIN cerró la tarea.', '2018-12-14 14:00:22', NULL, 'N', NULL),
	(0000000165, 0000000001, NULL, 0000000001, 'ADMIN cerró la tarea.', '2018-12-14 14:00:37', NULL, 'N', NULL),
	(0000000166, 0000000044, NULL, 0000000016, 'DANIEL.LEIVA cambió la Orden de Trabajo al estado En ejecución', '2018-12-14 15:51:40', NULL, 'N', NULL),
	(0000000167, 0000000044, NULL, 0000000016, 'Suspendida: prueba', '2018-12-14 15:52:31', '2018-12-14 15:53:00', 'S', '4959918792397823'),
	(0000000168, 0000000044, NULL, 0000000016, 'Cambio de estado automatico luego de  periodo en suspención', '2018-12-14 15:53:00', NULL, 'N', NULL),
	(0000000169, NULL, 0000000037, 0000000016, 'BARBARA.ARAYA cambió la tarea al estado En ejecución', '2018-12-14 15:55:53', NULL, 'N', NULL),
	(0000000170, 0000000031, NULL, 0000000001, 'ADMIN cambió la Orden de Trabajo al estado Despachado', '2018-12-14 16:05:28', NULL, 'N', NULL),
	(0000000171, 0000000044, 0000000038, 0000000016, 'ADMIN cerró la tarea.', '2018-12-14 19:35:13', NULL, 'N', NULL),
	(0000000172, 0000000044, 0000000037, 0000000016, 'ADMIN cerró la tarea.', '2018-12-14 19:35:27', NULL, 'N', NULL),
	(0000000173, 0000000041, NULL, 0000000009, 'Suspendida: prueba', '2018-12-15 12:36:31', '2018-12-15 12:37:00', 'S', '505657835033748'),
	(0000000174, 0000000041, NULL, 0000000009, 'Cambio de estado automatico luego de  periodo en suspención', '2018-12-15 12:37:00', NULL, 'N', NULL),
	(0000000175, NULL, 0000000034, 0000000009, 'ÁNGEL.GONZÁLEZ cambió la tarea al estado Despachado', '2018-12-15 12:42:29', NULL, 'N', NULL),
	(0000000176, 0000000039, 0000000034, 0000000009, 'ÁNGEL.GONZÁLEZ cerró la tarea.', '2018-12-15 12:42:40', NULL, 'N', NULL),
	(0000000177, 0000000031, NULL, 0000000001, 'Suspendida: prueba', '2018-12-15 13:05:09', '2018-12-15 13:06:00', 'S', '7772876905298087'),
	(0000000178, 0000000031, NULL, 0000000001, 'Cambio de estado automatico luego de  periodo en suspención', '2018-12-15 13:06:00', NULL, 'N', NULL),
	(0000000179, NULL, 0000000027, NULL, 'ARMIN.BRUN a cambiado el usuario de la tarea Reparación asignando al Ejecutor ARMIN.BRUN', '2018-12-15 23:40:33', NULL, 'N', NULL),
	(0000000180, 0000000025, 0000000027, 0000000001, 'ARMIN.BRUN cambió el usuario de la tarea Reparación asignando al Ejecutor ARMIN.BRUN', '2018-12-15 23:45:24', NULL, 'N', NULL),
	(0000000181, 0000000030, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Resolutor Incidentes asignando al Supervisor 00000000016', '2018-12-16 00:32:10', NULL, 'N', NULL),
	(0000000182, 0000000030, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Resolutor Incidentes asignando al Supervisor GISSELLE.SANMARTIN', '2018-12-16 00:34:46', NULL, 'N', NULL),
	(0000000183, 0000000030, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo <b>Resolutor Incidentes</b> asignando al Supervisor FERNANDO.SANJUAN', '2018-12-16 00:35:34', NULL, 'N', NULL),
	(0000000185, 0000000025, 0000000027, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-12-16 00:45:00', NULL, 'N', NULL),
	(0000000187, 0000000025, 0000000027, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-12-16 00:46:00', NULL, 'N', NULL),
	(0000000188, 0000000025, 0000000027, 0000000001, '<b>ARMIN.BRUN suspendió la tarea Reparación con el motivo:</b><br/> A modo de prueba', '2018-12-16 00:52:58', '2018-12-16 00:53:00', 'S', '06146030480251197'),
	(0000000189, 0000000025, 0000000027, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-12-16 00:53:00', NULL, 'N', NULL),
	(0000000191, 0000000025, 0000000027, 0000000001, 'Cambio de estado automatico luego de Suspención', '2018-12-16 00:55:00', NULL, 'N', NULL),
	(0000000192, NULL, 0000000027, 0000000001, 'ARMIN.BRUN cambió la tarea al estado En ejecución', '2018-12-16 00:55:33', NULL, 'N', NULL),
	(0000000193, NULL, 0000000027, 0000000001, 'ARMIN.BRUN cambió la tarea al estado En ejecución', '2018-12-16 00:55:45', NULL, 'N', NULL),
	(0000000195, 0000000025, 0000000027, 0000000001, 'ARMIN.BRUN cerró la tarea.', '2018-12-16 00:58:58', NULL, 'N', NULL),
	(0000000196, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió la Orden de Trabajo al estado En ejecución', '2018-12-16 01:00:13', NULL, 'N', NULL),
	(0000000197, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió la Orden de Trabajo al estado En ejecución', '2018-12-16 01:03:36', NULL, 'N', NULL),
	(0000000203, 0000000021, 0000000024, 0000000002, 'IVAN.CAMOTE cambió el usuario de la tarea Carga Combustible asignando al Ejecutor IVAN.CAMOTE', '2018-12-16 01:21:21', NULL, 'N', NULL),
	(0000000204, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Gestión de Alta Ocupación asignando al Supervisor FERNANDO.SANJUAN', '2018-12-16 01:29:45', NULL, 'N', NULL),
	(0000000205, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Gestión de Alta Ocupación asignando al Supervisor GISSELLE.SANMARTIN', '2018-12-16 01:30:12', NULL, 'N', NULL),
	(0000000206, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Gestión de Alta Ocupación asignando al Supervisor GISSELLE.SANMARTIN', '2018-12-16 01:30:21', NULL, 'N', NULL),
	(0000000207, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió el usuario de la Orden de trabajo Gestión de Alta Ocupación asignando al Supervisor FERNANDO.SANJUAN', '2018-12-16 01:30:32', NULL, 'N', NULL),
	(0000000208, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN cambió la Orden de Trabajo al estado En ejecución', '2018-12-16 01:31:07', NULL, 'N', NULL),
	(0000000209, 0000000029, NULL, 0000000001, 'Suspendida: prueba', '2018-12-16 01:32:15', '2018-12-16 01:33:00', 'S', '75487336004583'),
	(0000000210, 0000000029, NULL, 0000000001, 'Cambio de estado automático luego de  periodo en suspención', '2018-12-16 01:33:00', NULL, 'N', NULL),
	(0000000211, 0000000029, NULL, 0000000001, 'FERNANDO.SANJUAN suspendió la OT con el motivo: prueba', '2018-12-16 01:36:28', '2018-12-17 01:37:00', 'S', '2903805921611837');
/*!40000 ALTER TABLE `cambio_estado` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.contacto
CREATE TABLE IF NOT EXISTS `contacto` (
  `idContacto` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `idUsuario` int(11) unsigned zerofill DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `asunto` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `mensaje` longtext DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`idContacto`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.contacto: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `contacto` DISABLE KEYS */;
REPLACE INTO `contacto` (`idContacto`, `idEmpresa`, `idUsuario`, `nombre`, `asunto`, `email`, `telefono`, `mensaje`, `fecha`) VALUES
	(00000000014, NULL, NULL, 'Mauricio Cortazar', 'Problemas en el registro', 'mauricio.cortazar@gmail.com', '569856325654', 'Me sale que la cuenta esta des-habilitada. Favor habilitar.', '2018-07-15 22:58:58'),
	(00000000017, NULL, NULL, 'Don Hernan', 'Ingreso a la web', 'hernan.coelo@gmail.com', '56986565987', 'Hola, buenas, tengo algunas dudas sobre el sitio, favor contactarme vía correo...', '2018-07-23 08:39:21'),
	(00000000018, NULL, NULL, 'Matias', 'Pregunta', 'matias@gmail.com', '56989865895', 'Necesito ingresar pero no puedo', '2018-07-23 09:25:00'),
	(00000000029, NULL, NULL, 'Juanelo', 'No puedo ingresar :(', 'juanelo@micarro.cl', '5698656', 'No puedo ingresar con la cuenta de JUANELO.CARAELO', '2018-11-03 15:23:37');
/*!40000 ALTER TABLE `contacto` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.empresa
CREATE TABLE IF NOT EXISTS `empresa` (
  `idEmpresa` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idSuscripcion` int(11) unsigned zerofill DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `correo` varchar(50) DEFAULT NULL,
  `rut` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.empresa: ~15 rows (aproximadamente)
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
REPLACE INTO `empresa` (`idEmpresa`, `idSuscripcion`, `nombre`, `direccion`, `correo`, `rut`, `telefono`, `fecha_creacion`) VALUES
	(00000000001, 00000000001, 'Claro S.A', 'Fanor Velasco 50', 'mantenimientoprimernivel@clarochile.cl', '96.799.250-K', '800 000 171', '2018-12-14 19:27:02'),
	(00000000002, 00000000002, 'ENEX LTDA', 'Chiu Chiu 2020', 'administracion@enex.cl', '92.011.000-2', '800 171 544', '2018-12-14 19:27:02'),
	(00000000005, 00000000007, 'Telmex LTDA', 'Velasco Fanor 2020', 'administracion@telmex.cl', '12.938.912-5', '56922258456', '2018-12-14 19:27:02'),
	(00000000006, 00000000008, 'CODELCO LTA', 'Minera Escondida', 'minera@claseCorop.com', '90.666.666-8', '562532514', '2018-12-14 19:27:02'),
	(00000000007, 00000000009, 'SACHICAS MONTINA S.A', 'El Salchichon 2323', 'salchicha@chicas.cl', '10.885.915-6', '5692598959', '2018-12-14 19:27:02'),
	(00000000008, 00000000010, 'GOOGLE SA', 'Juan Santander 50', 'a@a.cl', '11.557.037-4', '56989595', '2018-12-14 19:27:02'),
	(00000000009, 00000000011, 'JACK CUSTO LTDA', 'Juan Santander 50', 'a@a.cl', '20.120.898-k', '5626292959', '2018-12-14 19:27:02'),
	(00000000010, 00000000012, 'EMPRESA LT', 'FANOR 50', 'A@A.CL', '14.622.462-8', '56959595959', '2018-12-14 19:27:02'),
	(00000000011, 00000000013, 'KURISTIAN SRHIANTASH LTDA', 'Clavel Poniente 2416', 'kakashisensei@gmail.com', '14.559.690-4', '56926565326', '2018-12-14 19:27:02'),
	(00000000012, 00000000014, 'ADERITOS LTDA', 'Panela 2020', 'cabezagigantecafe@gmail.com', '6.969.182-k', '56953265656', '2018-12-14 19:27:02'),
	(00000000013, 00000000015, 'JORGE SALGADO EIRL', 'Los halcones 1065 - quilicura', 'jorge.salgado.ch@gmail.com', '15.971.438-1', '5696496189', '2018-12-14 19:27:02'),
	(00000000014, 00000000016, 'EMPRESA DE PRUEBA', 'Pedro Lira 9084', 'a@a.cl', '14.044.316-6', '569526595982', '2018-12-14 19:27:02'),
	(00000000015, 00000000017, 'HP LTDA', 'Pedro Lira 9084', 'hp@andina.cl', '14.044.316-6', '562262949818', '2018-12-14 19:27:02'),
	(00000000016, 00000000018, 'Empresa Pruba Presentación', 'Pedro Lira 9084', 'a@a.cl', '7.704.532-5', '56325698958', '2018-12-14 19:27:02');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `idEstado` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT 0,
  `nombreEstado` varchar(50) DEFAULT NULL,
  `detalleEstado` longtext DEFAULT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.estado: ~11 rows (aproximadamente)
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
REPLACE INTO `estado` (`idEstado`, `idEmpresa`, `nombreEstado`, `detalleEstado`) VALUES
	(00000000001, 0, 'Generada', 'Actividad recién creada'),
	(00000000002, 0, 'En ejecución', 'Actividades en proceso'),
	(00000000003, 0, 'Suspensión', 'Actividades suspendidas'),
	(00000000004, 0, 'Ejecutada', 'Actividades realizadas'),
	(00000000005, 0, 'Cerrada', 'Actividad cerrada'),
	(00000000051, 1, 'Despachado', 'Despachado'),
	(00000000059, 2, 'Explotado', 'Explotado'),
	(00000000060, 6, 'Minando', 'Minando Mina'),
	(00000000061, 9, 'Despachado', 'Despacho de artículo.'),
	(00000000062, 9, 'Entregado', 'Tareas'),
	(00000000063, 9, 'Despachado2', 'Despachado2'),
	(00000000064, 16, 'Despachado', 'Despachado');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;

-- Volcando estructura para función aelita.FN_DEVOLVERTIEMPO
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `FN_DEVOLVERTIEMPO`(
	`TOTALSEG` BIGINT

) RETURNS longtext CHARSET latin1
    READS SQL DATA
BEGIN
    DECLARE TIEMPO CHAR(255);
    DECLARE DIA FLOAT DEFAULT 0;
    DECLARE HORA FLOAT DEFAULT 0;
    DECLARE MINUTO FLOAT DEFAULT 0;
    DECLARE SEGUNDO FLOAT DEFAULT 0;
    SET DIA= TOTALSEG DIV 86400;
    SET TOTALSEG = TOTALSEG % 86400;
    SET HORA= TOTALSEG DIV 3600;
    SET TOTALSEG = TOTALSEG % 3600;
    SET MINUTO = TOTALSEG DIV 60;
    SET SEGUNDO= TOTALSEG % 60;
    SET TIEMPO=CONCAT(DIA, ' días ', HORA, ' horas ', MINUTO,' min. ', SEGUNDO,' seg.');
    RETURN TIEMPO;
END//
DELIMITER ;

-- Volcando estructura para tabla aelita.orden_trabajo
CREATE TABLE IF NOT EXISTS `orden_trabajo` (
  `idOrdenTrabajo` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `supervisor` int(11) unsigned zerofill DEFAULT NULL,
  `idProcedimiento` int(11) unsigned zerofill DEFAULT 00000000000,
  `estado` int(11) unsigned zerofill DEFAULT NULL,
  `importancia` varchar(50) DEFAULT NULL,
  `nombreOrdenTrabajo` varchar(50) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_compromiso` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `detalleOrdenTrabajo` text DEFAULT NULL,
  PRIMARY KEY (`idOrdenTrabajo`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.orden_trabajo: ~36 rows (aproximadamente)
/*!40000 ALTER TABLE `orden_trabajo` DISABLE KEYS */;
REPLACE INTO `orden_trabajo` (`idOrdenTrabajo`, `idEmpresa`, `supervisor`, `idProcedimiento`, `estado`, `importancia`, `nombreOrdenTrabajo`, `fecha_inicio`, `fecha_compromiso`, `fecha_fin`, `detalleOrdenTrabajo`) VALUES
	(00000000001, 00000000001, 00000000040, 00000000000, 00000000005, 'Alta', 'Generar informe de servicios', '2018-07-23 15:54:11', '2018-11-27 12:00:00', '2018-12-14 14:00:37', 'Detalle'),
	(00000000002, 00000000001, 00000000016, 00000000000, 00000000005, 'Baja', 'Configuración de Servicio', '2018-07-24 14:00:42', '2018-11-27 12:00:00', '2018-11-27 12:00:00', 'Congiurar en PE 171 tabla de host'),
	(00000000003, 00000000001, 00000000024, 00000000000, 00000000001, 'Media', 'Informe de Servicios', '2018-07-24 14:00:50', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000004, 00000000001, 00000000040, 00000000000, 00000000001, 'Baja', 'Informe de Datos', '2018-07-24 14:00:57', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000005, 00000000001, 00000000040, 00000000000, 00000000001, 'Alta', 'Convergencia de Int64', '2018-07-24 14:01:06', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000006, 00000000001, 00000000040, 00000000000, 00000000003, 'Media', 'Coniguración entorno de Prueabas', '2018-07-24 14:01:14', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000007, 00000000001, 00000000016, 00000000000, 00000000003, 'Baja', 'Configuración de Equipos', '2018-07-24 18:19:02', '2018-11-27 12:00:00', NULL, ' '),
	(00000000008, 00000000001, 00000000016, 00000000000, 00000000001, 'Alta', 'Reparación', '2018-08-13 20:54:48', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000009, 00000000001, 00000000016, 00000000000, 00000000001, 'Media', 'Solicitud de Prueba', '2018-08-14 11:13:18', '2018-11-27 12:00:00', NULL, 'SE NECESITA QUE TODOS TERMINEN SUS TAREAS '),
	(00000000010, 00000000001, 00000000016, 00000000000, 00000000001, 'Alta', 'Tienda Kayser caida', '2018-09-20 15:00:43', '2018-11-27 12:00:00', NULL, 'Nombre de Quien Reporta: ALEJANDRO SANTIS \r\nProblema Reportado : Problema de internet y estamos presentando problemas con la gran mayoría de los anexos telefónicos del sector Espigon, estos quedan solicitando login y contraseña y luego de ser ingresados levantan pero a los 5 min vuelven a caer y solicitar login y contraseña nuevamente. Favor sus gestiones para solucionar este problema lo antes posible dado que dificulta la gestión de los usuarios al ser el teléfono una herramienta importante para sus labores diarios.\r\nPruebas realizadas por Cliente : ni\r\n'),
	(00000000011, 00000000001, 00000000016, 00000000000, 00000000001, 'Alta', 'Servicio caido', '2018-09-20 21:11:26', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000012, 00000000001, 00000000016, 00000000000, 00000000002, 'Alta', 'Gestión de Gastos', '2018-09-22 14:11:33', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000013, 00000000001, 00000000016, 00000000000, 00000000005, 'Alta', 'Reparar servicio de datos', '2018-09-25 16:31:55', '2018-11-27 12:00:00', '2018-11-27 12:00:00', 'favor completar las tareas solicitadas'),
	(00000000014, 00000000001, 00000000040, 00000000000, 00000000001, 'Alta', 'Solicitud de Prueba', '2018-10-04 10:30:57', '2018-11-27 12:00:00', NULL, 'Detalle de Prueba'),
	(00000000015, 00000000001, 00000000016, 00000000001, 00000000001, 'Alta', 'Generación de Staff Internet', '2018-10-21 17:31:19', '2018-12-07 12:00:00', NULL, 'Detalle'),
	(00000000016, 00000000001, 00000000040, 00000000000, 00000000001, 'Media', 'OT Prueba PPT', '2018-11-01 19:25:00', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000019, 00000000002, 00000000040, 00000000000, 00000000001, 'Alta', 'OT Prueba Empresa ENEX', '2018-11-01 22:20:32', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000020, 00000000002, 00000000040, 00000000000, 00000000001, 'Media', 'OT Prueba Informe', '2018-11-02 01:28:05', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000021, 00000000002, 00000000040, 00000000001, 00000000001, 'Alta', 'Carga de Combustible ', '2018-11-03 19:13:50', '2018-12-11 15:30:00', NULL, 'Se requiere realizar la carga de combustible de A1 a A20'),
	(00000000023, 00000000001, 00000000040, 00000000001, 00000000001, 'Alta', 'Reparar Servicio de Internet', '2018-11-14 23:17:42', '2018-12-08 12:00:00', NULL, 'Detalle'),
	(00000000024, 00000000001, 00000000040, 00000000000, 00000000001, 'Alta', 'Reparar Servicio de HFC', '2018-11-15 23:35:53', '2018-12-09 12:00:00', NULL, 'Detalle'),
	(00000000025, 00000000001, 00000000040, 00000000000, 00000000001, 'Alta', 'Reparar Servicio de Datos', '2018-11-15 23:36:41', '2018-12-10 15:00:00', NULL, 'Detalle'),
	(00000000026, 00000000001, 00000000040, 00000000002, 00000000001, 'Alta', 'Prueba 20-11-2018', '2018-11-20 01:15:50', '2018-11-27 12:00:00', NULL, 'Se realiza con motivos de estudio. '),
	(00000000029, 00000000001, 00000000040, 00000000000, 00000000003, 'Baja', 'Gestión de Alta Ocupación', '2018-11-20 01:52:51', '2018-12-27 12:00:00', NULL, 'Detalle'),
	(00000000030, 00000000001, 00000000016, 00000000002, 00000000001, 'Alta', 'Resolutor Incidentes', '2018-11-20 01:56:03', '2018-12-06 11:00:00', NULL, 'Detalle'),
	(00000000031, 00000000001, 00000000086, 00000000002, 00000000002, 'Media', 'Reparar Servicio de DTH', '2018-11-20 14:13:24', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000032, 00000000001, 00000000040, 00000000002, 00000000005, 'Media', 'Reparación Datos e Internet', '2018-11-21 18:29:29', '2018-11-27 12:00:00', '2018-12-05 17:19:01', 'Detalle'),
	(00000000033, 00000000006, 00000000026, 00000000000, 00000000001, 'Alta', 'Solicitud de Prueba', '2018-11-22 05:37:55', '2018-11-27 12:00:00', NULL, 'Detalle'),
	(00000000034, 00000000001, 00000000040, 00000000002, 00000000005, 'Alta', 'Prueba', '2018-11-22 07:59:23', '2018-11-27 12:00:00', '2018-11-25 23:18:34', 'Detalle'),
	(00000000035, 00000000001, 00000000040, 00000000002, 00000000005, 'Media', 'PRUEBA DIA 22', '2018-11-22 15:02:52', '2018-11-23 15:00:00', '2018-11-25 23:44:23', 'Detalle'),
	(00000000036, 00000000001, 00000000040, 00000000002, 00000000005, 'Alta', 'Solicitud Prueba Para Manual de Usuario', '2018-12-04 17:40:35', '2018-12-05 15:00:00', '2018-12-05 16:59:16', 'Detalle'),
	(00000000037, 00000000009, 00000000093, 00000000004, 00000000005, 'Alta', 'Compra de artículo en SODIMAC', '2018-12-12 16:19:58', '2018-12-30 23:00:00', '2018-12-12 16:43:42', 'Se solicita realizar la siguiente orden de trabajo, compra en SODIMAC.\r\n                        1. Comprar 20 llaves ALLEN 10pc\r\n                        2. Comprar 3 palas \r\n                        3. Madera 23x203'),
	(00000000039, 00000000009, 00000000093, 00000000004, 00000000001, 'Alta', 'Gestión de Artículos ', '2018-12-12 17:09:30', '2018-12-30 15:00:00', NULL, 'detalle '),
	(00000000040, 00000000009, 00000000093, 00000000004, 00000000002, 'Alta', 'Gestión de Ejemplo', '2018-12-13 12:25:44', '2018-12-30 10:00:00', NULL, 'Detalle de la soliciutd'),
	(00000000041, 00000000009, 00000000093, 00000000005, 00000000002, 'Media', 'Compra Artículos ', '2018-12-13 13:06:37', '2019-01-15 21:30:00', NULL, 'Detalles'),
	(00000000042, 00000000014, 00000000023, 00000000006, 00000000001, 'Alta', 'qweqwe', '2018-12-14 14:11:49', '2018-12-14 20:00:00', NULL, 'asdasd'),
	(00000000043, 00000000014, 00000000023, 00000000006, 00000000001, 'Alta', 'WEFWEF', '2018-12-14 14:12:50', '2018-12-14 20:00:00', NULL, 'WEFWEF'),
	(00000000044, 00000000016, 00000000098, 00000000007, 00000000002, 'Media', 'Solicitud de Prueba', '2018-12-14 15:49:41', '2018-12-16 21:30:00', NULL, 'detalle'),
	(00000000045, 00000000009, 00000000093, 00000000004, 00000000001, 'Alta', 'Solicitud de compra y gestión de articularlos ', '2018-12-15 12:38:51', '2018-12-23 10:00:00', NULL, 'detalle');
/*!40000 ALTER TABLE `orden_trabajo` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.procedimiento
CREATE TABLE IF NOT EXISTS `procedimiento` (
  `idProcedimiento` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `nombreProcedimiento` varchar(50) DEFAULT NULL,
  `detalleProcedimiento` text DEFAULT NULL,
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idProcedimiento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.procedimiento: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `procedimiento` DISABLE KEYS */;
REPLACE INTO `procedimiento` (`idProcedimiento`, `idEmpresa`, `nombreProcedimiento`, `detalleProcedimiento`, `fecha_creacion`) VALUES
	(00000000000, 0, 'Sin Asignar', NULL, '2018-11-14 23:22:18'),
	(00000000001, 2, 'Carga de Combustible', 'Detallados en PDF', '2018-11-03 17:05:17'),
	(00000000002, 1, 'Reparación Servicio Datos', 'Procedimiento ante falla por caida de servicio de datos o degradación del servicio.', '2018-11-13 00:54:23'),
	(00000000004, 9, 'Gestión de Artículos ', 'Se gestionan los artículos solicitados por un cliente. ', '2018-12-12 16:07:12'),
	(00000000005, 9, 'Gestión de Prueba', 'Gestión de Prueba', '2018-12-13 13:00:52'),
	(00000000006, 14, 'asdasdasd', 'asdasdasd', '2018-12-14 14:10:44'),
	(00000000007, 16, 'Procedimiento de Prueba', 'Procedimiento de Prueba', '2018-12-14 15:45:58');
/*!40000 ALTER TABLE `procedimiento` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.suscripcion
CREATE TABLE IF NOT EXISTS `suscripcion` (
  `idSuscripcion` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `nomreSuscripcion` char(50) DEFAULT NULL,
  `detalleSuscripcion` varchar(50) DEFAULT NULL,
  `cantidadUsuarios` int(11) unsigned zerofill DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT current_timestamp(),
  `fecha_fin` datetime DEFAULT NULL,
  `activo` char(1) DEFAULT NULL,
  PRIMARY KEY (`idSuscripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.suscripcion: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `suscripcion` DISABLE KEYS */;
REPLACE INTO `suscripcion` (`idSuscripcion`, `idEmpresa`, `nomreSuscripcion`, `detalleSuscripcion`, `cantidadUsuarios`, `fecha_inicio`, `fecha_fin`, `activo`) VALUES
	(00000000001, 00000000001, 'ClaroX200UsuariosSemestral', 'Claro200', 00000000200, '2018-06-01 08:00:00', '2020-02-01 08:00:00', 'S'),
	(00000000002, 00000000002, 'Enex50Usuarios', 'Enex50', 00000000066, '2018-11-01 08:00:00', '2020-01-01 08:00:00', 'S'),
	(00000000007, 00000000005, 'TelmexLTDA500User', 'detalleEmpresa', 00000000500, '2018-11-22 03:22:43', '2021-05-22 03:22:00', 'S'),
	(00000000008, 00000000006, 'Codelco5000Usuario', 'Gran5000Usuarios', 00000005000, '2018-11-22 03:28:29', '2020-07-17 20:00:00', 'S'),
	(00000000009, 00000000007, 'Salchicas650Semestral', '650 usuarios', 00000000650, '2018-11-22 08:32:50', '2019-01-05 08:32:00', 'S'),
	(00000000010, 00000000008, 'TelmexLTDA500User', 'detalleEmpresa', 00000034234, '2018-11-22 08:51:03', '2019-05-15 01:00:00', 'S'),
	(00000000011, 00000000009, 'JACK50USUARIOS', '50USUARIOS ANUAL', 00000000050, '2018-11-22 08:53:20', '2020-11-22 20:00:00', 'S'),
	(00000000012, 00000000010, 'EMPRESA', 'SEMESTRAL', 00000000500, '2018-11-22 13:36:17', '2018-12-15 13:36:00', 'S'),
	(00000000013, 00000000011, 'Suscripcin', 'Detalle', 00000000050, '2018-11-22 14:17:42', '2019-05-22 10:00:00', 'S'),
	(00000000014, 00000000012, 'Ederitos', 'SusSemestral', 00000000500, '2018-11-22 14:55:57', '2019-05-22 14:55:00', 'S'),
	(00000000015, 00000000013, '15', '15', 00000000015, '2018-11-23 19:16:22', '2019-05-23 19:16:00', 'S'),
	(00000000016, 00000000014, 'SuscripcinpRUEBA', '500Usuarios', 00000000500, '2018-12-13 12:35:24', '2019-01-30 10:00:00', 'S'),
	(00000000017, 00000000015, 'HP600', '600Uusuarios1Ao', 00000000600, '2018-12-13 13:13:23', '2019-12-13 10:00:00', 'S'),
	(00000000018, 00000000016, 'EmpresaPRueba', '500Usuarios', 00000000500, '2018-12-14 15:42:39', '2019-12-14 10:10:00', 'S');
/*!40000 ALTER TABLE `suscripcion` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tarea
CREATE TABLE IF NOT EXISTS `tarea` (
  `idTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `idTipoTarea` int(11) unsigned zerofill DEFAULT NULL,
  `idOrdenTrabajo` int(11) unsigned zerofill DEFAULT NULL,
  `idProcedimiento` int(11) unsigned zerofill DEFAULT 00000000000,
  `usuario` int(11) unsigned zerofill DEFAULT NULL,
  `estadoTarea` int(11) unsigned zerofill DEFAULT NULL,
  `fecha_inicio` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_compromiso` datetime DEFAULT NULL,
  `fecha_fin` datetime DEFAULT NULL,
  `aprobado` char(1) DEFAULT NULL,
  PRIMARY KEY (`idTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tarea: ~37 rows (aproximadamente)
/*!40000 ALTER TABLE `tarea` DISABLE KEYS */;
REPLACE INTO `tarea` (`idTarea`, `idEmpresa`, `idTipoTarea`, `idOrdenTrabajo`, `idProcedimiento`, `usuario`, `estadoTarea`, `fecha_inicio`, `fecha_compromiso`, `fecha_fin`, `aprobado`) VALUES
	(00000000001, 00000000001, 00000000001, 00000000001, 00000000000, 00000000026, 00000000005, '2018-07-23 15:54:28', '2018-12-08 10:55:09', '2018-11-22 15:00:22', NULL),
	(00000000002, 00000000001, 00000000003, 00000000001, 00000000002, 00000000026, 00000000005, '2018-07-24 14:01:33', '2018-12-07 10:55:09', '2018-12-14 14:00:22', NULL),
	(00000000003, 00000000001, 00000000003, 00000000004, 00000000000, 00000000023, 00000000001, '2018-07-24 14:01:40', '2018-12-05 10:55:09', NULL, NULL),
	(00000000004, 00000000001, 00000000002, 00000000005, 00000000000, 00000000023, 00000000001, '2018-07-24 14:01:58', '2018-12-04 10:55:09', NULL, NULL),
	(00000000005, 00000000001, 00000000007, 00000000006, 00000000000, 00000000023, 00000000001, '2018-07-24 14:02:09', '2018-12-03 10:55:09', NULL, NULL),
	(00000000006, 00000000001, 00000000002, 00000000007, 00000000000, 00000000017, 00000000002, '2018-07-24 18:19:53', '2018-12-02 10:55:09', NULL, NULL),
	(00000000007, 00000000001, 00000000001, 00000000008, 00000000000, 00000000017, 00000000005, '2018-08-13 20:55:40', '2018-12-01 10:55:09', '2018-11-18 19:03:32', NULL),
	(00000000008, 00000000001, 00000000001, 00000000009, 00000000000, 00000000003, 00000000001, '2018-08-14 11:13:47', '2019-12-05 10:55:09', NULL, NULL),
	(00000000009, 00000000001, 00000000009, 00000000010, 00000000000, 00000000003, 00000000002, '2018-09-20 15:02:29', '2018-12-01 10:55:09', NULL, NULL),
	(00000000010, 00000000001, 00000000001, 00000000011, 00000000000, 00000000017, 00000000005, '2018-09-20 21:11:48', '2019-11-22 10:55:09', '2018-11-18 19:03:31', NULL),
	(00000000011, 00000000001, 00000000001, 00000000001, 00000000000, 00000000026, 00000000005, '2018-09-23 02:39:51', '2018-12-09 10:55:09', '2018-11-18 19:03:30', NULL),
	(00000000012, 00000000001, 00000000002, 00000000002, 00000000000, 00000000026, 00000000005, '2018-09-23 21:01:38', '2018-12-06 10:55:09', '2018-11-18 19:03:29', NULL),
	(00000000013, 00000000001, 00000000001, 00000000013, 00000000000, 00000000026, 00000000005, '2018-09-25 16:32:10', '2019-11-22 10:55:09', '2018-11-18 19:03:28', NULL),
	(00000000014, 00000000001, 00000000001, 00000000014, 00000000000, 00000000026, 00000000005, '2018-10-04 10:31:44', '2019-09-22 10:55:09', '2018-11-20 14:48:24', NULL),
	(00000000015, 00000000001, 00000000001, 00000000014, 00000000000, 00000000042, 00000000002, '2018-10-17 15:33:31', '2019-07-22 10:55:09', NULL, NULL),
	(00000000016, 00000000001, 00000000001, 00000000014, 00000000000, 00000000023, 00000000005, '2018-11-01 19:00:08', '2019-08-22 10:55:09', '2018-11-18 19:03:27', NULL),
	(00000000019, 00000000002, NULL, 00000000019, 00000000000, 00000000027, 00000000001, '2018-11-01 22:37:07', '2019-04-22 10:55:09', NULL, NULL),
	(00000000020, 00000000001, 00000000011, 00000000016, 00000000000, 00000000023, 00000000001, '2018-11-01 22:41:20', '2019-05-22 10:55:09', NULL, NULL),
	(00000000021, 00000000002, 00000000016, 00000000020, 00000000000, 00000000017, 00000000001, '2018-11-02 16:38:31', '2018-02-22 10:55:09', NULL, NULL),
	(00000000022, 00000000002, 00000000025, 00000000020, 00000000001, 00000000017, 00000000001, '2018-11-03 16:39:24', '2019-03-22 10:55:09', NULL, NULL),
	(00000000023, 00000000001, 00000000001, 00000000023, 00000000000, 00000000026, 00000000005, '2018-11-14 23:17:59', '2018-06-22 10:55:09', '2018-11-19 20:49:10', NULL),
	(00000000024, 00000000002, 00000000025, 00000000021, 00000000000, 00000000017, 00000000001, '2018-11-15 23:43:51', '2019-01-22 10:55:09', NULL, NULL),
	(00000000025, 00000000001, 00000000001, 00000000025, 00000000000, 00000000023, 00000000005, '2018-11-18 21:37:26', '2018-10-30 10:55:09', '2018-11-19 22:03:29', NULL),
	(00000000027, 00000000001, 00000000001, 00000000025, 00000000000, 00000000026, 00000000005, '2018-11-19 20:51:09', '2018-12-22 10:55:41', '2018-12-16 00:58:58', NULL),
	(00000000028, 00000000001, 00000000001, 00000000032, 00000000000, 00000000026, 00000000005, '2018-11-21 18:29:59', '2019-01-12 11:02:02', '2018-12-05 17:18:53', NULL),
	(00000000029, 00000000006, 00000000026, 00000000033, 00000000000, 00000000090, 00000000002, '2018-11-22 05:39:25', '2019-11-22 10:55:09', NULL, NULL),
	(00000000030, 00000000006, 00000000026, 00000000033, 00000000000, 00000000090, 00000000005, '2018-11-22 13:38:53', NULL, '2018-11-22 14:13:56', NULL),
	(00000000031, 00000000001, 00000000001, 00000000035, 00000000000, 00000000026, 00000000005, '2018-11-25 16:58:39', '2018-11-25 00:00:00', '2018-11-25 22:13:15', NULL),
	(00000000032, 00000000001, 00000000002, 00000000035, 00000000000, 00000000026, 00000000005, '2018-11-25 18:55:57', '2018-11-30 10:00:00', '2018-11-25 22:14:54', NULL),
	(00000000033, 00000000009, 00000000029, 00000000037, 00000000000, 00000000094, 00000000005, '2018-12-12 16:21:59', '2018-10-30 23:00:00', '2018-12-12 16:40:38', NULL),
	(00000000034, 00000000009, 00000000027, 00000000039, 00000000000, 00000000094, 00000000005, '2018-12-12 17:10:12', '2018-12-15 10:00:00', '2018-12-15 12:42:40', NULL),
	(00000000035, 00000000009, 00000000032, 00000000040, 00000000000, 00000000095, 00000000001, '2018-12-13 12:26:42', '2018-12-30 10:00:00', NULL, NULL),
	(00000000036, 00000000009, 00000000033, 00000000041, 00000000000, 00000000095, 00000000005, '2018-12-13 13:08:36', '2018-12-14 10:00:00', '2018-12-13 13:09:59', NULL),
	(00000000037, 00000000016, 00000000034, 00000000044, 00000000000, 00000000099, 00000000005, '2018-12-14 15:50:58', '2018-12-15 10:00:00', '2018-12-14 19:35:27', NULL),
	(00000000038, 00000000016, 00000000034, 00000000044, 00000000000, 00000000099, 00000000005, '2018-12-14 19:30:04', '2018-12-25 10:00:00', '2018-12-14 19:35:13', NULL),
	(00000000039, 00000000016, 00000000034, 00000000044, 00000000007, 00000000099, 00000000001, '2018-12-14 19:36:35', '2018-12-20 10:00:00', NULL, NULL),
	(00000000040, 00000000009, 00000000029, 00000000041, 00000000004, 00000000017, 00000000001, '2018-12-15 12:37:05', '2018-12-20 10:00:00', NULL, NULL);
/*!40000 ALTER TABLE `tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.tipo_tarea
CREATE TABLE IF NOT EXISTS `tipo_tarea` (
  `idTipoTarea` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) DEFAULT NULL,
  `nombreTipoTarea` varchar(50) DEFAULT NULL,
  `detalleTipoTarea` longtext DEFAULT NULL,
  PRIMARY KEY (`idTipoTarea`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.tipo_tarea: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `tipo_tarea` DISABLE KEYS */;
REPLACE INTO `tipo_tarea` (`idTipoTarea`, `idEmpresa`, `nombreTipoTarea`, `detalleTipoTarea`) VALUES
	(00000000001, 1, 'Reparación', 'Reparación'),
	(00000000002, 1, 'Atención Técnica', 'Realizar configuraciones sobre servicios de Telefonía, Datos o Internet. '),
	(00000000003, 1, 'Monitoreo Proactivo', 'Monitorear enlaces solicitados. '),
	(00000000007, 1, 'Redactar Informe de Servicios', 'Redactar Informe de servicios'),
	(00000000009, 1, 'Reparación Mall', 'asdasd'),
	(00000000010, 1, 'Despacho', 'wefwef'),
	(00000000011, 1, 'Reparación DTH', 'Reparación DTH'),
	(00000000016, 2, 'Descarga de Combustible', NULL),
	(00000000025, 2, 'Carga Combustible', '19'),
	(00000000026, 6, 'Minar Mina', 'Tarea Para Minar una Mina'),
	(00000000027, 9, 'Solicitud de Artículos ', 'Solicitud de Artículos '),
	(00000000028, 9, 'Cotización de Artículos ', 'Cotización de Artículos '),
	(00000000029, 9, 'Compra de Artículos ', 'Compra de Artículos '),
	(00000000030, 9, 'Venta de Artículos', 'Venta de Artículos'),
	(00000000031, 9, 'Envío/Despacho de Artículos', 'Envío/Despacho de Artículos'),
	(00000000032, 9, 'Prueba', 'Prueba'),
	(00000000033, 9, 'Prueba2', 'Prueba2'),
	(00000000034, 16, 'Tarea de Refuerzo', 'Tarea de Refuerzo');
/*!40000 ALTER TABLE `tipo_tarea` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.trabaja
CREATE TABLE IF NOT EXISTS `trabaja` (
  `idEmpresa` int(11) unsigned zerofill DEFAULT NULL,
  `idUsuario` int(11) unsigned zerofill DEFAULT NULL,
  `activo` char(1) DEFAULT NULL,
  `tipoCuenta` varchar(50) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT current_timestamp(),
  `area_departamento` int(11) unsigned zerofill DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Volcando datos para la tabla aelita.trabaja: ~49 rows (aproximadamente)
/*!40000 ALTER TABLE `trabaja` DISABLE KEYS */;
REPLACE INTO `trabaja` (`idEmpresa`, `idUsuario`, `activo`, `tipoCuenta`, `fecha_ingreso`, `area_departamento`) VALUES
	(00000000001, 00000000016, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000001, 'S', 'Administrador', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000023, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000026, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000027, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000024, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000032, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000042, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000003, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000040, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000017, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000022, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000042, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000040, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000001, 'S', 'Administrador', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000086, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000087, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000001, 00000000088, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000002, 00000000089, 'N', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000005, 00000000001, 'S', 'Administrador', '2018-11-22 05:28:38', 00000000000),
	(00000000006, 00000000001, 'S', 'Administrador', '2018-11-22 05:28:38', 00000000000),
	(00000000006, 00000000090, 'S', 'Ejecutor', '2018-11-22 05:28:38', 00000000000),
	(00000000006, 00000000026, 'S', 'Supervisor', '2018-11-22 05:28:38', 00000000000),
	(00000000007, 00000000001, 'S', 'Administrador', '2018-11-22 08:32:50', 00000000000),
	(00000000008, 00000000001, 'S', 'Administrador', '2018-11-22 08:51:03', 00000000000),
	(00000000009, 00000000001, 'S', 'Administrador', '2018-11-22 08:53:20', 00000000000),
	(00000000010, 00000000001, 'S', 'Administrador', '2018-11-22 13:36:17', 00000000000),
	(00000000011, 00000000001, 'S', 'Administrador', '2018-11-22 14:17:42', 00000000000),
	(00000000012, 00000000001, 'S', 'Administrador', '2018-11-22 14:55:57', 00000000000),
	(00000000013, 00000000001, 'S', 'Administrador', '2018-11-23 19:16:22', 00000000000),
	(00000000001, 00000000091, 'N', 'Administrador', '2018-11-29 10:35:15', 00000000000),
	(00000000009, 00000000092, 'S', 'Administrador', '2018-12-12 16:11:01', 00000000000),
	(00000000009, 00000000093, 'S', 'Supervisor', '2018-12-12 16:13:09', 00000000000),
	(00000000009, 00000000094, 'S', 'Ejecutor', '2018-12-12 16:14:15', 00000000000),
	(00000000009, 00000000095, 'S', 'Ejecutor', '2018-12-13 12:22:43', 00000000000),
	(00000000009, 00000000017, 'S', 'Ejecutor', '2018-12-13 12:23:40', 00000000000),
	(00000000014, 00000000001, 'S', 'Administrador', '2018-12-13 12:35:24', 00000000000),
	(00000000014, 00000000023, 'S', 'Supervisor', '2018-12-13 12:36:14', 00000000000),
	(00000000009, 00000000096, 'S', 'Ejecutor', '2018-12-13 13:03:16', 00000000000),
	(00000000015, 00000000001, 'S', 'Administrador', '2018-12-13 13:13:23', 00000000000),
	(00000000014, 00000000042, 'S', 'Ejecutor', '2018-12-14 14:13:22', 00000000000),
	(00000000014, 00000000026, 'S', 'Supervisor', '2018-12-14 14:19:54', 00000000000),
	(00000000014, 00000000016, 'S', 'Ejecutor', '2018-12-14 14:31:59', 00000000000),
	(00000000014, 00000000097, 'S', 'Supervisor', '2018-12-14 14:36:15', 00000000000),
	(00000000016, 00000000001, 'S', 'Administrador', '2018-12-14 15:42:39', NULL),
	(00000000016, 00000000032, 'S', 'Administrador', '2018-12-14 15:43:35', 00000000000),
	(00000000016, 00000000098, 'S', 'Supervisor', '2018-12-14 15:47:45', NULL),
	(00000000016, 00000000099, 'S', 'Ejecutor', '2018-12-14 15:48:25', NULL),
	(00000000009, 00000000100, 'N', 'Ejecutor', '2018-12-15 12:34:23', NULL);
/*!40000 ALTER TABLE `trabaja` ENABLE KEYS */;

-- Volcando estructura para tabla aelita.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(10) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `rut` varchar(12) DEFAULT NULL,
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
  `fecha_ingreso` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1 COMMENT='19.117.491-7';

-- Volcando datos para la tabla aelita.usuario: ~27 rows (aproximadamente)
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
REPLACE INTO `usuario` (`idUsuario`, `rut`, `nombre`, `apellido`, `nombreUsuario`, `email`, `telefono_m`, `telefono_f`, `area_departamento`, `direccion`, `tipoCuenta`, `clave`, `fecha_ingreso`) VALUES
	(0000000001, '15.765.734-8', 'Administrador', 'San Juan', 'ADMIN', 'asachileno@gmail.com', '012341234', '12341234', '1', '0', 'Administrador', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000003, '21.624.006-5', 'Patricio', 'Contreras', 'PATRICIO.CONTRERAS', 'patricio.a.contreras@clarochile.cl', '225811562', '12341234', '1', 'Fanor Verlasco #50', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000016, '23.927.700-4', 'Gisselle', 'San Martin', 'GISSELLE.SANMARTIN', 'gisselle.sanmartin@clarochile.cl', '+569258115', '+562258115', '0', 'Fanor Velasco 50', 'Supervisor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000017, '24.707.234-9', 'Alonso', 'Pineda', 'ALONSO.PINEDA', 'alonso.pineda@clarochile.cl', '1234', '1234', '00000000012', 'Fanor Velasco 50', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000022, '15.410.254-k', 'Nicolas', 'Medrano', 'NICOLAS.MEDRANO', 'nicolas.medrano@inacapmail.cl', '994013263', '225942131', '2', 'Fanor Velasco 200', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000023, '16.976.872-2', 'Josue', 'Cea', 'JOSUE.CEA', 'josue.cea@gmail.com', '56958980102', '0000000000', '0', 'Av. manuel antonio matta 0329, Quilicura', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000024, '19.199.563-5', 'Eduardo', 'Salinas', 'EDUARDO.SALINAS', 'eduardoinbrand@gmail.com', '0954458279', '0954458279', '0', 'Ignacio Carrera Pinto 67', 'Supervisor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000026, '20.662.537-6', 'Armin', 'Brün', 'ARMIN.BRUN', 'armin.brun@chancho.cl', '543857421', '5321158', '00000000000', 'Almirante Barroso 76', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000027, '19.360.023-9', 'ivan', 'camote', 'IVAN.CAMOTE', 'ivan@gmail.com', '563256325', '5632563256', '00000000012', 'pn89', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000032, '24.534.111-3', 'DAVID', 'SANJUAN', 'DAVID.SANJUAN', 'davidsanjuan19938@gmail.com', '655656565', '56569569565', '0', 'El clavel poniente 2416', 'Supervisor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000040, '19.162.744-k', 'Fernando', 'San Juan', 'FERNANDO.SANJUAN', 'fernando.sanjuan@clarochile.cl', '1234', '1234', '00000000012', 'El clavel poniente 2416', 'Supervisor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000042, '21.388.781-5', 'José', 'Rios', 'JOSE.RIOS', 'jose.rios2@clarochile.cl', '967890728', '22123123', '00000000000', 'fanor 50', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000086, '11.222.333-4', 'Rafael', 'Araneda', 'RAFAEL.ARANEDA', 'a@a.com', '123123123', '123123123', '00000000002', '123123', 'Supervisor', '123123', '2018-11-22 03:32:27'),
	(0000000087, '22.333.444-5', 'Manuel', 'Lopez', 'MANUEL.LOPEZ', 'ml@gmail.com', '5693265454', '562456845', '00000000012', 'Javiera Carrera 2413', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000088, '19.111.555-4', 'Mauricio', 'Pinilla', 'MAURICIO.PINILLA', 'a@a.com', '123123', '123123', '00000000001', 'EL CALVEL PONIENTE 2416, FANOR VELASCO 50', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000089, '15.971.438-1', 'Jorge', 'Salgado', 'JORGE.SALGADO', 'jorge.salgado.ch@gmail.com', '56954532154', '56225811555', '00000000012', 'Fanor Velasco 56', 'Ejecutor', 'Teleco123', '2018-11-22 03:32:27'),
	(0000000090, '20.120.898-k', 'Marisol', 'Urrutia', 'MARISOL.URRUTIA', 'msol4@gmail.com', '5698654564', '565212465', '00000000017', 'Juan Santander 50', 'Ejecutor', 'Teleco123', '2018-11-22 04:01:40'),
	(0000000091, '11.882.747-3', 'Chancho', 'Chancho', 'CHANCHO.CHANCHO', 'chancho@chancho.cl', '56911111111', '562222222', '00000000001', 'asdasdasd', 'Administrador', '1234', '2018-11-29 10:35:15'),
	(0000000092, '8.605.077-3', 'Custodio', 'González', 'CUSTODIO.GONZÁLEZ', 'custodio_gonzalez@terra.cl', '56986245787', '5628716740', '00000000018', 'Pedro Lira 9084', '0', 'Teleco123', '2018-12-12 16:11:01'),
	(0000000093, '9.476.725-3', 'Leonardo', 'González', 'LEONARDO.GONZÁLEZ', 'ltoledog@gmail.com', '56966911795', '5628716748', '00000000019', 'Simón Yevenes 932', '0', 'Teleco123', '2018-12-12 16:13:09'),
	(0000000094, '8.601.427-0', 'Ángel ', 'González', 'ÁNGEL.GONZÁLEZ', 'angonzalezt@gmail.com', '56966911745', '5628716741', '00000000020', 'Mar Brava 1532', '0', 'Teleco123', '2018-12-12 16:14:15'),
	(0000000095, '12.531.801-0', 'Manuel ', 'Garate', 'MANUEL.GARATE', 'mgarate@gmail.com', '565965652521', '56258458568', '00000000021', 'Juan Santander 50', '0', 'Teleco123', '2018-12-13 12:22:43'),
	(0000000096, '14.044.316-6', 'asdasd', 'Chancho', 'ASDASD.CHANCHO', 'asachileno@gmail.com', '56959595959', '9591591951', '00000000021', 'asdasd', '0', 'Teleco123', '2018-12-13 13:03:16'),
	(0000000097, '6.373.514-0', 'Marion', 'Vera', 'MARION.VERA', 'mvera@gmail.com', '5695959595', '56926565656', '00000000023', 'sadasdasdasd', '0', 'Teleco123', '2018-12-14 14:36:15'),
	(0000000098, '7.220.005-5', 'Daniel', 'Leiva', 'DANIEL.LEIVA', 'dleiva@gmail.com', '56985656595', '56989958958', '00000000024', 'Simón Yevenes 932', '0', 'Teleco123', '2018-12-14 15:47:45'),
	(0000000099, '23.736.326-4', 'Barbara', 'Araya', 'BARBARA.ARAYA', 'baraya@gmail.com', '565989898', '5689895659', '00000000000', 'Mar Brava 1532', '0', 'Teleco123', '2018-12-14 15:48:25'),
	(0000000100, '9.212.761-3', 'Fabio', 'Gomez', 'FABIO.GOMEZ', 'fgomez@gmail.com', '5626454825', '5628565465', '00000000000', 'Simón Yevenes 932', '0', 'Teleco123', '2018-12-15 12:34:23');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
