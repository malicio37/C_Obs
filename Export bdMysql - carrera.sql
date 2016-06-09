-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-06-2016 a las 04:34:59
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `carrera`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrera`
--

CREATE TABLE `carrera` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `descripcion` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `carrera`
--

INSERT INTO `carrera` (`id`, `nombre`, `estado`, `descripcion`) VALUES
(1, 'COSem12016', 1, 'Primera carrera de observación'),
(2, 'carreraPrueba', 0, 'carrera prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `carreraId` int(11) NOT NULL,
  `usuarioMail` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nodo`
--

CREATE TABLE `nodo` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(60) DEFAULT NULL,
  `codigo` varchar(60) NOT NULL,
  `ubicacion` varchar(60) NOT NULL,
  `pista` varchar(60) NOT NULL,
  `carreraId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `nodo`
--

INSERT INTO `nodo` (`id`, `nombre`, `descripcion`, `codigo`, `ubicacion`, `pista`, `carreraId`) VALUES
(1, 'BIBLIOTECA', 'BIBLIOTECA', 'www.autonoma.edu.co/biblioteca', '20,120', 'SILENCIO, ESPACIO Y CONOCIMIENTO ENCONTRARAS EN ESTE LUGAR', 1),
(2, 'CAJA', 'CAJA', 'www.autonoma.edu.co/caja', '20,120', 'AQUÍ TU SEMESTRE Y LIBROS HAS DE PAGAR', 1),
(3, 'REGISTRO ACADEMICO', 'REGISTRO ACADEMICO', 'www.autonoma.edu.co/registro_academico', '20,120', 'EN ESTE LUGAR EL PROCESO DE INSCRIPCION ACENTARAS', 1),
(4, 'MERCADEO', 'MERCADEO', 'www.autonoma.edu.co/mercadeo', '20,120', 'SUS ENCARGADOS LA OFERTA ACADEMICA Y AYUDA ADMINISTRATIVA TE', 1),
(5, 'RELACIONES INTERNACIONALES', 'RELACIONES INTERNACIONALES', 'www.autonoma.edu.co/relaciones_internacionales', '20,120', 'SI UN INTERCAMBIO QUIERES HACER A ESTE LUGAR DEBES LLEGAR', 1),
(6, 'CARTERA', 'CARTERA', 'www.autonoma.edu.co/cartera', '20,120', 'PLAZOS DE FINANCIAMIENTO Y OPCIONES A PROBLEMAS ECONOMICAS A', 1),
(7, 'DESARROLLO HUMANO', 'DESARROLLO HUMANO', 'www.autonoma.edu.co/desarrollo_humano', '20,120', 'SUS ENCARGADOS VELAN POR TU BIENESTAR MENTAL Y PSICOLOGICO, ', 1),
(8, 'SERVICIOS MEDICOS', 'SERVICIOS MEDICOS', 'www.autonoma.edu.co/servicios_medicos', '20,120', 'EN ESTE SITIO ENCONTRARAS UN MEDICO QUE TE PUEDE INDICAR QUE', 1),
(9, 'ATENCION PREHOSPITALARIA', 'ATENCION PREHOSPITALARIA', 'www.autonoma.edu.co/atencion_prehospitalaria', '20,120', 'SI TE SIENTES FISICAMENTE MAL EN ESTE LUGAR UNA PERSONA PROF', 1),
(10, 'LABORATORIO ELECTRONICA', 'LABORATORIO ELECTRONICA', 'www.autonoma.edu.co/laboratorio_electronica', '20,120', 'LOS MONTAJES ELECTRONICOS Y EXPERIMENTOS FISICOS EN ESTE LUG', 1),
(11, 'GIMNASIO', 'GIMNASIO', 'www.autonoma.edu.co/gimnasio', '20,120', 'ALLI EJERCICIO, JUGAR Y LIBERAR TENSION PUEDES REALIZAR', 1),
(12, 'GESTION DE TECNOLOGIA', 'GESTION DE TECNOLOGIA', 'www.autonoma.edu.co/laboratorio_de_ingles', '20,120', 'UNA FORMA DIFERENTE DE COMUNICARTE ALLI APRENDERAS', 1),
(13, 'DECANATURA INGENIERIA', 'DECANATURA INGENIERIA', 'www.autonoma.edu.co/gestion_de_tecnologia', '20,120', 'OLVIDO DE CONTRASEÑAS Y PROBLEMAS DE INGRESO A LOS SISTEMAS ', 1),
(14, 'SALA DE PROFESORES DE INGENIER', 'SALA DE PROFESORES DE INGENIERIA', 'www.autonoma.edu.co/decanatura_ingenieria', '20,120', 'LOS PROCESOS ACADEMICOS DESDE ALLÍ SE GOBERNARAN', 1),
(15, 'CENTRO DE INFORMATICA', 'CENTRO DE INFORMATICA', 'www.autonoma.edu.co/sala_de_profesores_de_ingenieria', '20,120', 'ASISTENCIA Y CONSULTARIA DE QUIENES TE ENSEÑAN EN ESTE LUGAR', 1),
(16, 'VICERRECTORIA ACADEMICA', 'VICERRECTORIA ACADEMICA', 'www.autonoma.edu.co/centro_de_informatica', '20,120', 'LAS HERRAMIENTAS COMPUTACIONES EN ESTE PISO ENTERO ENCONTRAR', 1),
(17, 'RECTORIA', 'RECTORIA', 'www.autonoma.edu.co/vicerrectoria_academica', '20,120', 'CUANDO PROBLEMAS ACADÉMICOS ENCUENTRES, ESTE ES EL MÁXIMO ES', 1),
(18, 'VICERRECTORIA ADMINISTRATIVA', 'VICERRECTORIA ADMINISTRATIVA', 'www.autonoma.edu.co/rectoria', '20,120', 'DESDE ALLÍ SE DIRIGE LA UAM', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nodo_descubierto`
--

CREATE TABLE `nodo_descubierto` (
  `id` int(11) NOT NULL,
  `nodoId` int(11) NOT NULL,
  `usuarioMail` varchar(60) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `fechaEstado1` datetime DEFAULT NULL,
  `fechaEstado2` datetime DEFAULT NULL,
  `fechaEstado3` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `id` int(11) NOT NULL,
  `enunciado` varchar(60) NOT NULL,
  `respuesta` varchar(60) NOT NULL,
  `nodoId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pregunta`
--

INSERT INTO `pregunta` (`id`, `enunciado`, `respuesta`, `nodoId`) VALUES
(1, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'WBEIMAR CANO RESTREPO', 1),
(2, '¿CUÁL ES EL NOMBRE DE LA ZONA EN QUE ENCONTRARÁS REVISTAS ES', 'HEMEROTECA', 1),
(3, '¿CUÁL ES EL NOMBRE DE LA SALA DE CONSULTA ELECTRÓNICA?', 'TELEMATICA', 1),
(4, '¿CUÁL ES EL NOMBRE DE LA SALA DONDE VIDEOS Y PELÍCULAS PUEDE', 'VIDEOTECA', 1),
(5, '¿QUÉ BASE DE DATOS PUEDES CONSULTAR SI DIRECTAMENTE ARTÍCULO', 'SCIENCE DIRECT', 1),
(6, '¿CUÁL ES EL NOMBRE DE LA PERSONA QUE SIEMPRE ENCUENTRAS EN E', 'JHON JAMES LOPEZ', 2),
(7, '¿ADEMÁS DE LA MATRÍCULA ESTOS ELEMENTOS DE ESTUDIO ACÁ PUEDE', 'LIBROS', 2),
(8, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'YHON HENRY BARRETO MIRANDA', 3),
(9, '¿QUÉ DOCUMENTO TE ENTREGARÁN EN ÉSTE LUGAR QUE TE SERVIRÁ PA', 'CARNET ESTUDIANTIL', 3),
(10, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'SONIA PATRICIA VILLAMIL RODRIGUEZ', 4),
(11, '¿INDICA CUAL ES EL CORREO GENERAL DE MERCADEO Y SERVICIO AL ', 'SERVICIOALCLIENTE@AUTONOMA.EDU.CO', 4),
(12, '¿CUÁL ES EL NOMBRE DEL PROGRAMA DE MOVILIDAD ACADEMICA ENTRE', 'MACA', 5),
(13, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'VIVIANA FERNANDA NIETO PADILLA', 5),
(14, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'CARMENZA GONZALEZ BURITICA', 6),
(15, 'DE ESTA INSTITUCIÓN GUBERNAMENTAL UN DELEGADO EN ESTA OFICIN', 'ICETEX', 6),
(16, '¿NOMBRA AL VICERRECTOR DE DESARROLLO HUMANO?', 'ALBERTO CARDONA AGUIRRE', 7),
(17, '¿ELLA ES LA ENCARGADA DE ASIGNARTE CITAS Y RECIBIRTE EN ESTE', 'IRENE MARULANDA SALGADO', 8),
(18, '¿ES UNO DE LOS ENCARGADOS Y SU PRIMER NOMBRE INICIA CON L Y ', 'LUIS CARLOS RIOS DIAZ', 9),
(19, '¿CUÁL ES EL NOMBRE DEL COORDINADOR DE ÉSTE LUGAR?', 'HISNEL FRANCO MARQUEZ', 10),
(20, '¿DI EL NOMBRE CON EL QUE SE CONOCE EL EDIFICIO EN QUE SE ENC', 'SACATIN', 11),
(21, '¿CUÁL ES EL CORRE DE ATENCIÓN GENERAL DE ESTE LUGAR?', 'GESTEC@AUTONOMA.EDU.CO', 12),
(22, '¿CUÁL ES EL NOMBRE DE LA COMUNITY MANAGER UAM?', 'MARGARITA BENAVIDES', 12),
(23, '¿CUÁL ES EL NOMBRE DE LA DECANO DE INGENIERIA?', 'ALBA PATRICIA ARIAS OSORIO', 13),
(24, '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIER', 'BEATRIZ ALVARAN DAVILA', 13),
(25, '¿CUAL ES EL NOMBRE DE LA AUXILIAR ADMINISTRATIVA DE INGENIER', 'INES ARGELIA LOAIZA GARZON', 13),
(26, '¿CUAL ES EL NOMBRE DE LA COORDINADORA DEL PROGRAMA DE INGENI', 'LINA MARIA LOPEZ URIBE', 14),
(27, '¿NOMBRA AL PROFESOR CUYO CORREO ES JIMEZAM?', 'JORGE IVAN MEZA MARTINEZ', 14),
(28, '¿INDICA EL NOMBRE DE LA ENCARGADA DEL CENTRO DE INFORMATICA?', 'MARTHA LILIA MORALES GONZALEZ', 15),
(29, '¿NOMBRA AL VICERRECTOR ACADEMICO DE LA UAM?', 'IVAN ESCOBAR ESCOBAR', 16),
(30, '¿NOMBRA AL RECTOR DE LA INSTITUCION?', 'GABRIEL CADENA GOMEZ', 17),
(31, '¿NOMBRA AL VICERRECTOR ADMINISTRATIVO DE LA UAM?', 'CARLOS EDUARDO JARAMILLO SANINT', 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `nombres` varchar(30) NOT NULL,
  `apellidos` varchar(30) NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `mail` varchar(60) NOT NULL,
  `color` varchar(60) NOT NULL,
  `genero` varchar(20) NOT NULL,
  `tipo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombres`, `apellidos`, `fechaNacimiento`, `mail`, `color`, `genero`, `tipo`) VALUES
(2, 'JORGE IVAN', 'MEZA MARTINEZ', '1978-04-14', 'jimezam@autonoma.edu.co', 'azul', 'hombre', 'usuario'),
(1, 'JULIAN MAURICIO', 'MEJIA CARDONA', '1984-01-28', 'jmmejia@autonoma.edu.co', 'verde', 'hombre', 'administrador');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrera`
--
ALTER TABLE `carrera`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`carreraId`,`usuarioMail`),
  ADD KEY `usuarioMail` (`usuarioMail`);

--
-- Indices de la tabla `nodo`
--
ALTER TABLE `nodo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carreraId` (`carreraId`);

--
-- Indices de la tabla `nodo_descubierto`
--
ALTER TABLE `nodo_descubierto`
  ADD PRIMARY KEY (`nodoId`,`usuarioMail`),
  ADD KEY `usuarioMail` (`usuarioMail`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`id`),
  ADD KEY `nodoId` (`nodoId`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`mail`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`carreraId`) REFERENCES `carrera` (`id`),
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`usuarioMail`) REFERENCES `usuario` (`mail`);

--
-- Filtros para la tabla `nodo`
--
ALTER TABLE `nodo`
  ADD CONSTRAINT `nodo_ibfk_1` FOREIGN KEY (`carreraId`) REFERENCES `carrera` (`id`);

--
-- Filtros para la tabla `nodo_descubierto`
--
ALTER TABLE `nodo_descubierto`
  ADD CONSTRAINT `nodo_descubierto_ibfk_1` FOREIGN KEY (`nodoId`) REFERENCES `nodo` (`id`),
  ADD CONSTRAINT `nodo_descubierto_ibfk_2` FOREIGN KEY (`usuarioMail`) REFERENCES `usuario` (`mail`);

--
-- Filtros para la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD CONSTRAINT `pregunta_ibfk_1` FOREIGN KEY (`nodoId`) REFERENCES `nodo` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
