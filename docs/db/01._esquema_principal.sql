-- Creacion de base de datos
CREATE DATABASE IF NOT EXISTS decoracionesjg;
USE decoracionesjg;

-- TABLAS ENTIDADES PRINCIPALES
-- Tabla: Clientes
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
telefono VARCHAR(20) not null,
email VARCHAR(100),
direccion TEXT,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
notas TEXT,
activo BOOLEAN DEFAULT TRUE,
INDEX idx_nombre (nombre, apellido),
INDEX idx_telefono (telefono)
)ENGINE=InnoDB;

-- Tabla: Categorias de productos
CREATE TABLE categorias_productos (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL UNIQUE,
descripcion TEXT,
activo BOOLEAN DEFAULT TRUE
)ENGINE=InnoDB;

-- Tabla: Poductos
CREATE TABLE productos (
id_producto INT AUTO_INCREMENT PRIMARY KEY,
id_categoria INT NOT NULL,
codigo VARCHAR(50) UNIQUE,
nombre VARCHAR(150) NOT NULL,
tipo ENUM('cortina', 'velo', 'persiana', 'toldillo', 'accesorio') NOT NULL,
precio_venta DECIMAL(10,2) NOT NULL DEFAULT 0,
unidad_medida ENUM('unidad', 'metro', 'par') DEFAULT 'unidad',
stock_actual DECIMAL(10,2) DEFAULT 0,
stock_minimo DECIMAL(10,2) DEFAULT 0,
fabricable BOOLEAN DEFAULT FALSE,
requiere_medidas BOOLEAN DEFAULT FALSE,
color VARCHAR(50),
descripcion TEXT,
activo BOOLEAN DEFAULT TRUE,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_categoria) REFERENCES categorias_productos(id_categoria),
INDEX idx_tipo (tipo),
INDEX idx_codigo (codigo)
)ENGINE=InnoDB;

-- Tabla: Telas
CREATE TABLE telas (
id_tela INT AUTO_INCREMENT PRIMARY KEY,
codigo VARCHAR(50) UNIQUE NOT NULL,
nombre VARCHAR(100) NOT NULL,
color VARCHAR(50) NOT NULL,
precio_metro DECIMAL(10,2) NOT NULL,
stock_metros DECIMAL(10,2) NOT NULL,
stock_minimo DECIMAL(10,2) DEFAULT 10,
proveedor VARCHAR(150),
observaciones TEXT,
activo BOOLEAN DEFAULT TRUE,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
INDEX idx_codigo (codigo),
INDEX idx_stock (stock_metros)
)ENGINE=InnoDB;

-- Tabla: Proveedores
CREATE TABLE proveedores (
id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(150) NOT NULL,
contacto VARCHAR(100),
telefono VARCHAR(20) NOT NULL,
email VARCHAR(100),
direccion TEXT,
tipo ENUM('persianas', 'telas', 'accesorios', 'general'),
activo BOOLEAN DEFAULT TRUE,
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
INDEX idx_tipo (tipo)
)ENGINE=InnoDB;

-- Tabla: Usuarios (para autenticación)
CREATE TABLE usuarios (
id_usuarios INT AUTO_INCREMENT PRIMARY KEY,
nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
nombre_completo VARCHAR(150) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
password VARCHAR(255) NOT NULL,
rol ENUM ('administrador', 'vendedor', 'instalador') DEFAULT 'administrador',
activo BOOLEAN DEFAULT TRUE,
ultimo_acceso TIMESTAMP NULL,
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
INDEX idx_usuario (nombre_usuario)
) ENGINE=InnoDB;

-- TABLAS ENTIDADES DE PROCESOS/TRANSACCIONES
-- Tabla: Cotizaciones
CREATE TABLE cotizaciones (
id_cotizacion INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
fecha_cotizacion DATE NOT NULL,
estado ENUM('pendiente', 'aceptada', 'rechazada', 'vencida') DEFAULT 'pendiente',
subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
descuento DECIMAL(10,2) NOT NULL DEFAULT 0,
total DECIMAL(10,2) NOT NULL DEFAULT 0,
fecha_valida_hasta DATE,
observaciones TEXT,
creado_por VARCHAR(100),
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
INDEX idx_estado (estado),
INDEX idx_fecha (fecha_cotizacion)
)ENGINE=InnoDB;

-- Tabla: Detalle cotizacion
CREATE TABLE detalle_cotizacion (
id_detalle_cotizacion INT AUTO_INCREMENT PRIMARY KEY,
id_cotizacion INT NOT NULL,
id_producto INT,
id_tela INT,
descripcion TEXT,
cantidad DECIMAL(10,2) DEFAULT 1,
ancho DECIMAL(10,2) COMMENT 'Medida en metros',
alto DECIMAL(10,2) COMMENT 'Medida en metros',
precio_unitario DECIMAL(10,2) NOT NULL,
subtotal DECIMAL(10,2) NOT NULL,
especificaciones TEXT COMMENT 'Diseño, tipo de confeccion, etc)',
FOREIGN KEY (id_cotizacion) REFERENCES cotizaciones(id_cotizacion) ON DELETE CASCADE,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE,
FOREIGN KEY (id_tela) REFERENCES telas(id_tela) ON DELETE CASCADE,
INDEX idx_cotizacion (id_cotizacion)
)ENGINE=InnoDB;

-- Tabla: Pedidos
CREATE TABLE pedidos (
id_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT NOT NULL,
id_cotizacion INT COMMENT 'NULL si el pedido no viene de cotizacion',
fecha_pedido DATE NOT NULL,
estado ENUM('pendiente', 'en_produccion', 'listo', 'entregado', 'cancelado') DEFAULT 'pendiente',
tipo_pedido ENUM('cortina', 'velo', 'persiana', 'toldillo', 'mixto') NOT NULL,
subtotal DECIMAL(20,2) NOT NULL DEFAULT 0,
descuento DECIMAL(10,2) DEFAULT 0,
total DECIMAL(10,2) NOT NULL DEFAULT 0,
anticipo DECIMAL(10,2) DEFAULT 0,
saldo DECIMAL(10,2) GENERATED ALWAYS AS (total - anticipo) STORED,
fecha_entrega_estimada DATE,
fecha_entrega_real DATE,
observaciones TEXT,
creado_por VARCHAR(100),
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
FOREIGN KEY (id_cotizacion) REFERENCES cotizaciones(id_cotizacion),
INDEX idx_estado (estado),
INDEX idx_fecha (fecha_pedido),
INDEX idx_cliente (id_cliente)
)ENGINE=InnoDB;

-- Tabla: Detalle pedido
CREATE TABLE detalle_pedido (
id_detalle_pedido INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_producto INT,
id_tela INT,
descripcion TEXT,
cantidad DECIMAL(10,2) DEFAULT 1,
ancho DECIMAL(10,2),
alto DECIMAL(10,2),
precio_unitario DECIMAL(10,2) NOT NULL,
subtotal DECIMAL (10,2) NOT NULL,
estado_produccion ENUM('pendiente', 'en corte', 'en confeccion', 'terminado', 'instalado') DEFAULT 'pendiente',
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
FOREIGN KEY (id_tela) REFERENCES telas(id_tela),
INDEX idx_pedido (id_pedido),
INDEX idx_estado (estado_produccion)
)ENGINE=InnoDB;

-- Tabla: Ordenes de produccion
CREATE TABLE ordenes_produccion (
id_orden_produccion INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
id_detalle_pedido INT,
fecha_creacion DATE NOT NULL,
fecha_inicio DATE,
fecha_finalizacion DATE,
estado ENUM('pendiente', 'en proceso', 'finalizada', 'cancelada') DEFAULT 'pendiente',
responsable VARCHAR(100),
instrucciones TEXT,
observaciones TEXT,
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
FOREIGN KEY (id_detalle_pedido) REFERENCES detalle_pedido(id_detalle_pedido),
INDEX idx_estado (estado),
INDEX idx_pedido (id_pedido)
)ENGINE=InnoDB;

-- Tabla: Orden de materiales
CREATE TABLE materiales_orden (
id_material_orden INT AUTO_INCREMENT PRIMARY KEY,
id_orden_produccion INT NOT NULL,
id_tela INT,
id_producto INT COMMENT 'Para accesorios usados en fabricacion',
cantidad_requerida DECIMAL(10,2) NOT NULL,
cantidad_utilizada DECIMAL(10,2) DEFAULT 0,
unidad ENUM('metros', 'unidades') DEFAULT 'metros',
observaciones TEXT,
FOREIGN KEY (id_orden_produccion) REFERENCES ordenes_produccion(id_orden_produccion) ON DELETE CASCADE,
FOREIGN KEY (id_tela) REFERENCES telas(id_tela),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
INDEX idx_orden (id_orden_produccion)
)ENGINE=InnoDB;

-- Tabla: Ordenes de compra
CREATE TABLE ordenes_compra (
id_orden_compra INT AUTO_INCREMENT PRIMARY KEY,
id_proveedor INT NOT NULL,
id_pedido INT COMMENT 'Pedido del cliente que origina la compra',
fecha_orden DATE NOT NULL,
fecha_recepcion DATE,
estado ENUM('pendiente', 'enviada', 'recibida', 'cancelada') DEFAULT 'pendiente',
total DECIMAL(10,2) NOT NULL DEFAULT 0,
observaciones TEXT,
creado_por VARCHAR(100),
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor),
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
INDEX idx_estado (estado),
INDEX idx_proveedor (id_proveedor)
)ENGINE=InnoDB;

-- Tabla: Detalle de ordenes de compra
CREATE TABLE detalle_orden_compra (
id_detalle_compra INT AUTO_INCREMENT PRIMARY KEY,
id_orden_compra INT NOT NULL,
id_producto INT,
descripcion TEXT NOT NULL,
cantidad DECIMAL(10,2) DEFAULT 1,
ancho DECIMAL(10,2),
alto DECIMAL(10,2),
precio_unitario DECIMAL(10,2) NOT NULL,
subtotal DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_orden_compra) REFERENCES ordenes_compra(id_orden_compra) ON DELETE CASCADE,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
INDEX idx_orden_compra (id_orden_compra)
)ENGINE=InnoDB;

-- Tabla: Ventas directas
CREATE TABLE ventas_directas (
id_venta INT AUTO_INCREMENT PRIMARY KEY,
id_cliente INT,
fecha_venta DATE NOT NULL,
total DECIMAL(10,2) NOT NULL DEFAULT 0,
metodo_pago ENUM('efectivo', 'transferencia', 'tarjeta') NOT NULL,
estado ENUM('completada', 'cancelada') DEFAULT 'completada',
observaciones TEXT,
vendedor VARCHAR(100),
fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
INDEX idx_fecha (fecha_venta),
INDEX idx_metodo_pago (metodo_pago)
)ENGINE=InnoDB;

-- Tabla: Detalle de venta directa
CREATE TABLE detalle_venta_directa (
id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
id_venta INT NOT NULL,
id_producto INT NOT NULL,
cantidad DECIMAL(10,2) DEFAULT 1,
precio_unitario DECIMAL(10,2) NOT NULL,
subtotal DECIMAL (10,2) NOT NULL,
FOREIGN KEY (id_venta) REFERENCES ventas_directas(id_venta) ON DELETE CASCADE,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
INDEX idx_venta (id_venta)
)ENGINE=InnoDB;

-- TABLAS DE CONTROL
-- Tabla: movimientos de inventario
CREATE TABLE movimientos_inventario (
id_movimiento INT AUTO_INCREMENT PRIMARY KEY,
id_producto INT COMMENT 'para productos terminados',
id_tela INT COMMENT 'para telas',
tipo_movimiento ENUM ('entrada_compra', 'salida_produccion', 'entrada_fabricacion', 'salida_venta', 'ajuste_positivo', 'ajuste_negativo') NOT NULL,
cantidad DECIMAL (10,2) NOT NULL,
unidad ENUM ('metros', 'unidades') NOT NULL,
fecha_movimiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
referencia VARCHAR(100) COMMENT 'Numero de orden/pedido que origino',
id_orden_produccion INT,
id_pedido INT,
id_venta INT,
observaciones TEXT,
usuario VARCHAR(100),
FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
FOREIGN KEY (id_tela) REFERENCES telas(id_tela),
FOREIGN KEY (id_orden_produccion) REFERENCES ordenes_produccion(id_orden_produccion),
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
FOREIGN KEY (id_venta) REFERENCES ventas_directas(id_venta),
INDEX idx_fecha (fecha_movimiento),
INDEX idx_tipo (tipo_movimiento),
INDEX idx_producto (id_producto),
INDEX idx_tela (id_tela)
)ENGINE=InnoDB;

-- Tabla: Pagos
CREATE TABLE pagos (
id_pagos INT AUTO_INCREMENT PRIMARY KEY,
id_pedido INT NOT NULL,
fecha_pago DATE NOT NULL,
monto DECIMAL(10,2) NOT NULL,
metodo_pago ENUM('efectivo', 'transferencia', 'tarjeta') NOT NULL,
tipo_pago ENUM('anticipo', 'pago final') NOT NULL,
comprobante VARCHAR(100),
observaciones TEXT,
registrado_por VARCHAR(100),
fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
INDEX idx_pedido (id_pedido),
INDEX idx_fecha (fecha_pago)
)ENGINE=InnoDB;

-- -- -- TRIGERS PARA AUTOMATIZACIÓN
-- Trigger: Actualizar total de cotizacion al insertar detalle
DELIMITER //
CREATE TRIGGER trg_after_insert_detalle_cotizacion
AFTER INSERT ON detalle_cotizacion
FOR EACH ROW
BEGIN
	UPDATE cotizaciones
	SET subtotal = (
		SELECT SUM(subtotal) FROM detalle_cotizacion
        WHERE id_cotizacion = NEW.id_cotizacion
	),
    total = subtotal - IFNULL(descuento, 0)
    WHERE id_cotizacion = NEW.id_cotizacion;
END//
DELIMITER ;

-- Trigger: Actualizar total de cotizacion al actualizar detalle
DELIMITER //
CREATE TRIGGER trg_after_update_detalle_cotizacion
AFTER UPDATE ON detalle_cotizacion
FOR EACH ROW
BEGIN
	UPDATE cotizaciones
    SET subtotal = (
		SELECT SUM(subtotal) FROM detalle_cotizacion
		WHERE id_cotizacion = NEW.id_cotizacion
	),
    total = subtotal - IFNULL(descuento,0)
    WHERE id_cotizacion = NEW.id_cotizacion;
END//
DELIMITER ;

-- Trigger: Actualizar total de pedido al insertar detalle
DELIMITER //
CREATE TRIGGER trg_after_insert_detalle_pedido
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN 
    UPDATE pedidos
    SET subtotal = (
		SELECT SUM(subtotal) FROM detalle_pedido
        WHERE id_pedido = NEW.id_pedido
	),
    total = subtotal - IFNULL(descuento, 0)
    WHERE id_pedido = NEW.id_pedido;
END//
DELIMITER ;

-- trigger: Actualizar stock de tela cuando se registra movimiento
DELIMITER //
CREATE TRIGGER trg_after_insert_movimiento_tela
AFTER INSERT ON movimientos_inventario
FOR EACH ROW
BEGIN
	IF NEW.id_tela IS NOT NULL THEN
		IF NEW.tipo_movimiento IN ('entrada_compra', 'ajuste_positivo') THEN
			UPDATE telas
            SET stock_metros = stock_metros + NEW.cantidad
            WHERE id_tela = NEW.id_tela;
		ELSEIF NEW.tipo_movimiento IN ('salida_produccion', 'ajuste_negativo') THEN
			UPDATE telas
            SET stock_metros = stock_metros - NEW.cantidad
            WHERE id_tela = NEW.id_tela;
		END IF;
	END IF;
END//
DELIMITER ;

-- Trigger: Actualizar stock de producto cuando se regidtra movimiento
DELIMITER //
CREATE TRIGGER trg_after_insert_movimiento_producto
AFTER INSERT ON movimientos_inventario
FOR EACH ROW
BEGIN
	IF NEW.id_producto IS NOT NULL THEN
		IF NEW.tipo_movimiento IN ('entrada_compra', 'entrada_fabricacion', 'ajuste_positivo') THEN
			UPDATE productos
            SET stock_actual = stock_actual + NEW.cantidad
            WHERE id_producto = NEW.id_producto;
		ELSEIF NEW.tipo_movimiento IN ('salida_venta', 'salida_produccion', 'ajuste_negativo') THEN
			UPDATE productos
            SET stock_actual = stock_actual - NEW.cantidad
            WHERE id_producto = NEW.id_producto;
		END IF;
	END IF;
END//
DELIMITER ;

-- Trigger: Actualizar anticipo al registrar pago
DELIMITER //
CREATE TRIGGER trg_after_insert_pago
AFTER INSERT ON pagos
FOR EACH ROW
BEGIN
	UPDATE pedidos
    SET anticipo = (
		SELECT SUM(monto) FROM pagos
        WHERE id_pedido = NEW.id_pedido
	)
    WHERE id_pedido = NEW.id_pedido;
END//
DELIMITER ;
        