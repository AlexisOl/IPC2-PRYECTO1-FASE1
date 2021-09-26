CREATE USER 'AlexisOvalle'@'localhost' IDENTIFIED BY 'AlexisOl123!';
GRANT ALL PRIVILEGES ON *.* TO 'AlexisOl1'@'localhost';
FLUSH PRIVILEGES;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START transaction;
SET time_zone = "+00:00";

-- BASE DE DATOS: "db_revistasdigitales"
CREATE DATABASE IF NOT EXISTS `db_revistasdigitales` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `db_revistasdigitales`;

--
-- Estructuras de las tablas 
--

-- ESTRUCTURA PARA CREAR USUARIOS
CREATE TABLE `Usuario` (
	`id` int(11) NOT NULL,
    `username` varchar(45) NOT NULL,
    `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear suscriptores a las revistas
CREATE TABLE `Suscriptores` (
	`id` int(11) NOT NULL,
    `Fecha` datetime NOT NULL,
    `precio` int(11) NOT NULL,
    `tiempovigencia` int(11) NOT NULL,
    `id_revista` int(11) NOT NULL,
    `id_usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ESTRUCTURA PARA CREAR LA TABLA `editores`
CREATE TABLE `Editores` (
	`id` int(11) NOT NULL,
    `username` varchar(45) NOT NULL,
    `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- estructura para crear la tabla `Revistas`
CREATE TABLE `Revistas` (
	`id` int(11) NOT NULL,
    `nombre` varchar(45) NOT NULL,
    `numero` int(11) NOT NULL,
    `descripcion` varchar(100) NOT NULL,
    `cantidadinteracciones` int(11) NOT NULL,
    `modalidadpago` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- estructura para crear la tabla de `Ingresorevista`
CREATE TABLE `Ingreso_revista` (
	`id` int(11) NOT NULL,
    `id_editor` int(11) NOT NULL,
    `id_revista` int(11) NOT NULL,
    `fecha` datetime NOT NULL,
    `precio` int(11) NOT NULL,
    `formapago_gratuito` varchar(45) NOT NULL
) ENGINE= InnoDB DEFAULT CHARSET=utf8; 


-- estructura para crear la tabla anunciantes
CREATE TABLE `Anunciante` (
	`id` int(11) NOT NULL,
    `nombre` varchar(45) NOT NULL,
    `nombreempresa` varchar(45) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET = utf8;

-- estructura para crear la tabla anuncios
CREATE TABLE `Anuncio` (
	`id` int(11) NOT NULL,
    `Tipo` varchar(45) NOT NULL,
    `precio` int(11) NOT NULL
    ) ENGINE = InnoDB DEFAULT CHARSET= utf8;
-- estructura para crear la tabla `Anunciosunion`
CREATE TABLE `Anuncios_union` (
	`id` int(11) NOT NULL,
    `id_anunciante` int(11) NOT NULL,
    `id_anuncio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla de `Aceptacion_anuncio`
CREATE TABLE `Aceptacion_anuncio` (
	`id` int(11) NOT NULL,
	`id_anuncio_union` int(11) NOT NULL,
    `fecha_pago` datetime NOT NULL,
    `tiempo_visualizacion` int(11) NOT NULL,
    `pago` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

-- estructura para crear la tabla administradores
CREATE TABLE `Administrador` ( 
	`id` int(11) NOT NULL,
    `username` varchar(45) NOT NULL,
	`password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla etiquetas
CREATE TABLE `Etiquetas` (
	`id` int(11) NOT NULL,
	`nombre` int(11) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla categorias
CREATE TABLE `Categorias` (
	`id` int(11) NOT NULL,
    `nombre` varchar(45) NOT NULL
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla de `Categoriaunion`
CREATE TABLE `Categoria_union` (
	`id` int(11) NOT NULL,
	`id_categoria` int(11) NOT NULL,
    `id_etiqueta` int(11),
    `tipo_categoria` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla `Categoriarevista`
CREATE TABLE `Categoria_revista` ( 
	`id` int(11) NOT NULL,
	`id_revista` int(11) NOT NULL,
    `id_categoria_union` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla de `Administrador_suscriptor`
CREATE TABLE `Administrador_suscriptor` (
	`id` int(11) NOT NULL,
	`id_admin` int(11) NOT NULL,
    `id_suscriptor` int(11) NOT NULL,
    `precio` int(11) NOT NULL,
    `porcentaje` int(11) NOT NULL,
    `recargo` int(11) NOT NULL,
    `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- estructura para crear la tabla `Administrador_revista`
CREATE TABLE `Administrador_revista` ( 
	`id` int(11) NOT NULL,
	`id_admin` int(11) NOT NULL,
    `id_revista` int(11) NOT NULL,
    `id_editor` int(11) NOT NULL,
    `precio` int(11) NOT NULL,
    `pago_diario` int(11) NOT NULL,
    `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- estructura para crear la tabla `Interacciones`
CREATE TABLE `Interacciones` ( 
	`id` int(11) NOT NULL,
	`comentarios` varchar(100) NOT NULL,
    `Me_gusta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- estructura para crear la tabla `Revista_Interacciones`
CREATE TABLE `Revista_Interacciones` ( 
	`id` int(11) NOT NULL,
	`id_suscriptor` int(11) NOT NULL,
    `id_interacciones` int(11) NOT NULL,
    `id_revista` int(11) NOT NULL,
    `fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- INDICES de las tablas volcadas
--

-- Indicices Usuario
ALTER TABLE `Usuario` 
ADD PRIMARY KEY (`id`);

-- Indicices suscriptores
ALTER TABLE `Suscriptores` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_suscriptores_revistas_idx_revistas1` (`id_revista`),
ADD KEY `fk_suscriptores_usario_idx_usuario1` (`id_usuario`);

-- Indicices Editores
ALTER TABLE `Editores` 
ADD PRIMARY KEY (`id`);

-- Indicices Revistas
ALTER TABLE `Revistas` 
ADD PRIMARY KEY (`id`);

-- Indicices Ingreso_revista
ALTER TABLE `Ingreso_revista` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_ingreso_revista_editores_idx_editor1` (`id_editor`),
ADD KEY `fk_ingreso_revista_revistas_idx_revistas1` (`id_revista`);

-- Indicices Anunciante
ALTER TABLE `Anunciante` 
ADD PRIMARY KEY (`id`);

-- Indicices Anuncio
ALTER TABLE `Anuncio` 
ADD PRIMARY KEY (`id`);

-- Indicices Anuncios_union
ALTER TABLE `Anuncios_union` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_anuncios_union_anunciante_idx_anunciante1` (`id_anunciante`),
ADD KEY `fk_anuncios_union_anuncio_idx_anuncio1` (`id_anuncio`);

-- Indicices Aceptacion_anuncio
ALTER TABLE `Aceptacion_anuncio` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_aceptacion_anuncio_anuncios_union_idx_anuncio_union1` (`id_anuncio_union`);
    
-- Indicices Administrador
ALTER TABLE `Administrador` 
ADD PRIMARY KEY (`id`);

-- Indicices Etiquetas
ALTER TABLE `Etiquetas` 
ADD PRIMARY KEY (`id`);

-- Indicices Categorias
ALTER TABLE `Categorias` 
ADD PRIMARY KEY (`id`);

-- Indicices Categoria_union
ALTER TABLE `Categoria_union` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_categoria_union_categorias_idx_categoria1` (`id_categoria`),
ADD KEY `fk_categoria_union_etiquetas_idx_etiqueta1` (`id_etiqueta`);

-- Indicices Categoria_revista
ALTER TABLE `Categoria_revista` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_categoria_revista_revistas_idx_revista1` (`id_revista`),
ADD KEY `fk_categoria_revista_categoria_union_idx_categoria_union1` (`id_categoria_union`);

-- Indicices Administrador_suscriptor
ALTER TABLE `Administrador_suscriptor` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_administrador_suscriptor_administrador_idx_admin1` (`id_admin`),
ADD KEY `fk_administrador_suscriptor_suscriptores_idx_suscriptor1` (`id_suscriptor`);


-- Indicices Administrador_revista
ALTER TABLE `Administrador_revista` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_administrador_revista_administrador_idx_admin1` (`id_admin`),
ADD KEY `fk_administrador_revista_revistas_idx_revista1` (`id_revista`),
ADD KEY `fk_administrador_revista_editor_idx_editor1` (`id_editor`);


-- Indicices Interacciones
ALTER TABLE `Interacciones` 
ADD PRIMARY KEY (`id`);

-- Indicices Revista_Interacciones
ALTER TABLE `Revista_Interacciones` 
ADD PRIMARY KEY (`id`),
ADD KEY `fk_revista_interacciones_suscriptores_idx_suscriptor1` (`id_suscriptor`),
ADD KEY `fk_revista_interacciones_interacciones_idx_interacciones1` (`id_interacciones`),
ADD KEY `fk_revista_interacciones_revistas_idx_revista1` (`id_revista`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

-- AUTO_INCREMENT Usuario
ALTER TABLE `Usuario` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT suscriptores
ALTER TABLE `Suscriptores` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Editores
ALTER TABLE `Editores` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Revistas
ALTER TABLE `Revistas` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Ingreso_revista
ALTER TABLE `Ingreso_revista` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Anunciante
ALTER TABLE `Anunciante` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Anuncio
ALTER TABLE `Anuncio` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Anuncios_union
ALTER TABLE `Anuncios_union` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Aceptacion_anuncio
ALTER TABLE `Aceptacion_anuncio` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
    
-- AUTO_INCREMENT Administrador
ALTER TABLE `Administrador` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Etiquetas
ALTER TABLE `Etiquetas` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Categorias
ALTER TABLE `Categorias` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Categoria_union
ALTER TABLE `Categoria_union` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Categoria_revista
ALTER TABLE `Categoria_revista` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
-- AUTO_INCREMENT Administrador_suscriptor
ALTER TABLE `Administrador_suscriptor` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Administrador_revista
ALTER TABLE `Administrador_revista` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

-- AUTO_INCREMENT Interacciones
ALTER TABLE `Interacciones` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;


-- AUTO_INCREMENT Revista_Interacciones
ALTER TABLE `Revista_Interacciones` 
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Suscriptores`
--

ALTER TABLE `Suscriptores`
ADD CONSTRAINT `fk_suscriptores_revistas` FOREIGN KEY (`id_revista`) REFERENCES `Revistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_suscriptores_usario` FOREIGN KEY (`id_usuario`) REFERENCES `Usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Ingreso_revista`
--

ALTER TABLE `Ingreso_revista`
ADD CONSTRAINT `fk_ingreso_revista_editores` FOREIGN KEY (`id_editor`) REFERENCES `Editores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_ingreso_revista_revistas` FOREIGN KEY (`id_revista`) REFERENCES `Revistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Anuncios_union`
--

ALTER TABLE `Anuncios_union`
ADD CONSTRAINT `fk_anuncios_union_anunciante` FOREIGN KEY (`id_anunciante`) REFERENCES `Anunciante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_anuncios_union_anuncio` FOREIGN KEY (`id_anuncio`) REFERENCES `Anuncio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Filtros para la tabla `Aceptacion_anuncio`
--

ALTER TABLE `Aceptacion_anuncio`
ADD CONSTRAINT `fk_aceptacion_anuncio_anuncios_union` FOREIGN KEY (`id_anuncio_union`) REFERENCES `Anuncios_union` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Categoria_union`
--

ALTER TABLE `Categoria_union`
ADD CONSTRAINT `fk_categoria_union_categorias` FOREIGN KEY (`id_categoria`) REFERENCES `Categorias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_categoria_union_etiquetas` FOREIGN KEY (`id_etiqueta`) REFERENCES `Etiquetas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Filtros para la tabla `Categoria_revista`
--

ALTER TABLE `Categoria_revista`
ADD CONSTRAINT `fk_categoria_revista_revistas` FOREIGN KEY (`id_revista`) REFERENCES `Revistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_categoria_revista_categoria_union` FOREIGN KEY (`id_categoria_union`) REFERENCES `Categoria_union` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Administrador_suscriptor`
--

ALTER TABLE `Administrador_suscriptor`
ADD CONSTRAINT `fk_administrador_suscriptor_administrador` FOREIGN KEY (`id_admin`) REFERENCES `Administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_administrador_suscriptor_suscriptores` FOREIGN KEY (`id_suscriptor`) REFERENCES `Suscriptores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;


--
-- Filtros para la tabla `Administrador_revista`
--

ALTER TABLE `Administrador_revista`
ADD CONSTRAINT `fk_administrador_revista_administrador` FOREIGN KEY (`id_admin`) REFERENCES `Administrador` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_administrador_revista_revistas` FOREIGN KEY (`id_revista`) REFERENCES `Revistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_administrador_revista_editor` FOREIGN KEY (`id_editor`) REFERENCES `Editores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `Revista_Interacciones`
--

ALTER TABLE `Revista_Interacciones`
ADD CONSTRAINT `fk_revista_interacciones_suscriptores` FOREIGN KEY (`id_suscriptor`) REFERENCES `Suscriptores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_revista_interacciones_interacciones` FOREIGN KEY (`id_interacciones`) REFERENCES `Interacciones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_revista_interacciones_revistas_editor` FOREIGN KEY (`id_revista`) REFERENCES `Revistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
