-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-11-2024 a las 04:12:40
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clima`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas_clima`
--

CREATE TABLE `consultas_clima` (
  `id` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `ciudad` varchar(100) NOT NULL,
  `fecha_consulta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `consultas_clima`
--

INSERT INTO `consultas_clima` (`id`, `id_usuario`, `ciudad`, `fecha_consulta`) VALUES
(1, 1, 'Lima', '2024-11-27 14:17:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `creado_en` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre_usuario`, `correo`, `contrasena`, `creado_en`) VALUES
(1, 'usuario1', 'usuario1@example.com', 'contraseña_encriptada', '2024-11-27 14:17:21'),
(2, 'crsitian ', 'a@gmail.com', '$2b$10$eV/3wurvtyJ7OR3syp6CueWVbi6hNY0qsWDg6NIGVSITNQj.u5nVS', '2024-11-27 14:26:01'),
(3, 'cristian', 'crisvi072@gmail.com', '$2b$10$2R6FzxSo7Sms53xTi/Cq1.maUBnAhgWWjYUdMMAzXNkrYvxtt7sjO', '2024-11-27 14:28:01'),
(4, 'b', '', '$2b$10$Hgaub6X66AS0s9YtEJNDLuHYTlO2pufhk5xm0.dXzSZ0SgYGXSyJC', '2024-11-28 02:31:34'),
(6, 'ab', 'ab@gmail.com', '$2b$10$9N4IfWotJIkd9ZcL5Kl27Om9Z8IhnVO0rrPeCBKGhoVdNSET/.mhG', '2024-11-28 02:33:42'),
(7, 'jose', 'jose@gmail.com', '$2b$10$T9wPL/rYE70Sabbr7gSZgOcZgDLwv6SLXqF0ujwhdX/oKcyUoYUo6', '2024-11-28 03:02:44');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `consultas_clima`
--
ALTER TABLE `consultas_clima`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre_usuario` (`nombre_usuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `consultas_clima`
--
ALTER TABLE `consultas_clima`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `consultas_clima`
--
ALTER TABLE `consultas_clima`
  ADD CONSTRAINT `consultas_clima_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
