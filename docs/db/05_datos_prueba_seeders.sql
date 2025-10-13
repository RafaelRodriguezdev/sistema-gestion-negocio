
USE decoracionesjg;

-- 1. CLIENTES DE PRUEBA
INSERT INTO clientes (nombre, apellido, telefono, email, direccion) VALUES
('María', 'González', '3101234567', 'maria.gonzalez@email.com', 'Calle 15 #20-30, Yopal'),
('Carlos', 'Rodríguez', '3209876543', 'carlos.rodriguez@email.com', 'Carrera 40 #25-15, Yopal'),
('Ana', 'Martínez', '3156789012', 'ana.martinez@email.com', 'Avenida 30 #18-45, Yopal'),
('Luis', 'Pérez', '3187654321', 'luis.perez@email.com', 'Calle 22 #35-20, Yopal'),
('Sandra', 'López', '3145678901', NULL, 'Carrera 12 #8-15, Yopal');

-- 2. PROVEEDORES DE PRUEBA
INSERT INTO proveedores (nombre, contacto, telefono, email, tipo) VALUES
('Persianas del Sur', 'Jorge Ramírez', '3201112233', 'ventas@persianassur.com', 'persianas'),
('Textiles Colombia', 'Diana Castro', '3154445566', 'info@textilescol.com', 'telas'),
('Accesorios y Más', 'Pedro Sánchez', '3187778899', 'pedidos@accymas.com', 'accesorios'),
('Distribuidora Nacional', 'Laura Gómez', '3165554433', 'ventas@distnacional.com', 'general');

-- 3. TELAS DE PRUEBA
INSERT INTO telas (codigo, nombre, color, precio_metro, stock_metros, stock_minimo, proveedor) VALUES
('TL-001', 'Blackout Premium', 'Blanco', 25000, 50.00, 10.00, 'Textiles Colombia'),
('TL-002', 'Blackout Premium', 'Beige', 25000, 35.00, 10.00, 'Textiles Colombia'),
('TL-003', 'Blackout Premium', 'Gris', 25000, 45.00, 10.00, 'Textiles Colombia'),
('TL-004', 'Sheer Elegance', 'Blanco', 18000, 40.00, 10.00, 'Textiles Colombia'),
('TL-005', 'Sheer Elegance', 'Crema', 18000, 28.00, 10.00, 'Textiles Colombia'),
('TL-006', 'Lino Natural', 'Natural', 22000, 32.00, 8.00, 'Textiles Colombia'),
('TL-007', 'Lino Natural', 'Café', 22000, 25.00, 8.00, 'Textiles Colombia'),
('TL-008', 'Poliéster Decorativo', 'Azul', 15000, 55.00, 12.00, 'Textiles Colombia'),
('TL-009', 'Poliéster Decorativo', 'Verde', 15000, 48.00, 12.00, 'Textiles Colombia'),
('TL-010', 'Tela Toldillo', 'Gris', 8000, 60.00, 15.00, 'Distribuidora Nacional');

-- 4. PRODUCTOS DE PRUEBA
-- Cortinas (categoría 1)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas) VALUES
(1, 'COR-001', 'Cortina Blackout Personalizada', 'cortina', 0, 'unidad', 0, 0, TRUE, TRUE),
(1, 'COR-002', 'Cortina Sheer Personalizada', 'cortina', 0, 'unidad', 0, 0, TRUE, TRUE),
(1, 'COR-003', 'Cortina Lino Personalizada', 'cortina', 0, 'unidad', 0, 0, TRUE, TRUE);

-- Velos (categoría 2)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas) VALUES
(2, 'VEL-001', 'Velo Decorativo Personalizado', 'velo', 0, 'unidad', 0, 0, TRUE, TRUE),
(2, 'VEL-002', 'Velo Sheer Personalizado', 'velo', 0, 'unidad', 0, 0, TRUE, TRUE);

-- Persianas (categoría 3)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas, descripcion) VALUES
(3, 'PER-001', 'Persiana Enrollable Blackout', 'persiana', 120000, 'unidad', 0, 0, FALSE, TRUE, 'Persiana enrollable con tela blackout'),
(3, 'PER-002', 'Persiana Enrollable Screen', 'persiana', 95000, 'unidad', 0, 0, FALSE, TRUE, 'Persiana enrollable con tela screen'),
(3, 'PER-003', 'Persiana Horizontal Aluminio', 'persiana', 85000, 'unidad', 0, 0, FALSE, TRUE, 'Persiana horizontal de aluminio'),
(3, 'PER-004', 'Persiana Vertical PVC', 'persiana', 110000, 'unidad', 0, 0, FALSE, TRUE, 'Persiana vertical en PVC');

-- Toldillos (categoría 4)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas, color) VALUES
(4, 'TOL-001', 'Toldillo Hamaca', 'Toldillo', 45000, 'unidad', 15, 5, TRUE, FALSE, 'Blanco'),
(4, 'TOL-002', 'Toldillo Cuadrado', 'Toldillo', 65000, 'unidad', 10, 5, TRUE, FALSE, 'Rosado'),
(4, 'TOL-003', 'Toldillo Copa', 'Toldillo', 55000, 'unidad', 8, 3, TRUE, FALSE, 'Azul'),
(4, 'TOL-004', 'Toldillo Personalizado', 'Toldillo', 0, 'unidad', 0, 0, TRUE, TRUE, 'Morado');

-- Accesorios (categoría 5)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas) VALUES
(5, 'ACC-001', 'Ganchos Cortina (Set 10 unidades)', 'accesorio', 5000, 'unidad', 50, 10, FALSE, FALSE),
(5, 'ACC-002', 'Argollas Metálicas (Set 12 unidades)', 'accesorio', 8000, 'unidad', 40, 10, FALSE, FALSE),
(5, 'ACC-003', 'Cadena Control Persiana 1.5m', 'accesorio', 3500, 'unidad', 30, 8, FALSE, FALSE),
(5, 'ACC-004', 'Tapa Terminal Riel', 'accesorio', 2000, 'par', 25, 5, FALSE, FALSE);

-- Soportes (categoría 6)
INSERT INTO productos (id_categoria, codigo, nombre, tipo, precio_venta, unidad_medida, stock_actual, stock_minimo, fabricable, requiere_medidas) VALUES
(6, 'SOP-001', 'Soporte Pared Simple', 'accesorio', 6000, 'unidad', 35, 10, FALSE, FALSE),
(6, 'SOP-002', 'Soporte Pared Doble', 'accesorio', 9000, 'unidad', 28, 8, FALSE, FALSE),
(6, 'SOP-003', 'Riel Cortina 2 metros', 'accesorio', 25000, 'unidad', 15, 5, FALSE, FALSE),
(6, 'SOP-004', 'Riel Cortina 3 metros', 'accesorio', 35000, 'unidad', 12, 5, FALSE, FALSE),
(6, 'SOP-005', 'Soporte Techo Ajustable', 'accesorio', 12000, 'unidad', 20, 6, FALSE, FALSE);

-- 5. COTIZACIONES DE PRUEBA
-- Cotización 1: Cortinas para sala
INSERT INTO cotizaciones (id_cliente, fecha_cotizacion, estado, fecha_valida_hasta, observaciones, creado_por) VALUES
(1, '2024-09-15', 'aceptada', '2024-09-30', 'Cliente solicita cortinas blackout para sala', 'admin');

INSERT INTO detalle_cotizacion (id_cotizacion, id_producto, id_tela, descripcion, cantidad, ancho, alto, precio_unitario, subtotal, especificaciones) VALUES
(1, 1, 1, 'Cortina Blackout Blanco Ventana 1', 1, 2.50, 2.20, 180000, 180000, 'Diseño tradicional con pliegues'),
(1, 1, 1, 'Cortina Blackout Blanco Ventana 2', 1, 2.50, 2.20, 180000, 180000, 'Diseño tradicional con pliegues'),
(1, 19, NULL, 'Riel 3 metros', 2, NULL, NULL, 35000, 70000, 'Para ambas ventanas');

-- Cotización 2: Persianas para oficina
INSERT INTO cotizaciones (id_cliente, fecha_cotizacion, estado, fecha_valida_hasta, observaciones, creado_por) VALUES
(2, '2024-09-18', 'aceptada', '2024-10-05', 'Persianas enrollables para oficina', 'admin');

INSERT INTO detalle_cotizacion (id_cotizacion, id_producto, descripcion, cantidad, ancho, alto, precio_unitario, subtotal, especificaciones) VALUES
(2, 6, 'Persiana Enrollable Blackout', 3, 1.20, 1.80, 120000, 360000, 'Color gris corporativo'),
(2, 15, 'Cadena Control', 3, NULL, NULL, 3500, 10500, 'Cadenas adicionales');

-- Cotización 3: Velo decorativo
INSERT INTO cotizaciones (id_cliente, fecha_cotizacion, estado, fecha_valida_hasta, observaciones, creado_por) VALUES
(3, '2024-09-20', 'pendiente', '2024-10-10', 'Velo decorativo para habitación', 'admin');

INSERT INTO detalle_cotizacion (id_cotizacion, id_producto, id_tela, descripcion, cantidad, ancho, alto, precio_unitario, subtotal, especificaciones) VALUES
(3, 4, 4, 'Velo Decorativo Sheer Blanco', 1, 3.00, 2.40, 95000, 95000, 'Diseño con caída suelta');

-- 6. PEDIDOS DE PRUEBA
-- Pedido 1: Convertido de cotización 1
INSERT INTO pedidos (id_cliente, id_cotizacion, fecha_pedido, estado, tipo_pedido, subtotal, total, anticipo, fecha_entrega_estimada, creado_por) VALUES
(1, 1, '2024-09-16', 'en_produccion', 'cortina', 430000, 430000, 200000, '2024-09-30', 'admin');

INSERT INTO detalle_pedido (id_pedido, id_producto, id_tela, descripcion, cantidad, ancho, alto, precio_unitario, subtotal, estado_produccion) VALUES
(1, 1, 1, 'Cortina Blackout Blanco Ventana 1', 1, 2.50, 2.20, 180000, 180000, 'en confeccion'),
(1, 1, 1, 'Cortina Blackout Blanco Ventana 2', 1, 2.50, 2.20, 180000, 180000, 'en confeccion'),
(1, 19, NULL, 'Riel 3 metros', 2, NULL, NULL, 35000, 70000, 'terminado');

-- Pedido 2: Convertido de cotización 2
INSERT INTO pedidos (id_cliente, id_cotizacion, fecha_pedido, estado, tipo_pedido, subtotal, total, anticipo, fecha_entrega_estimada, creado_por) VALUES
(2, 2, '2024-09-19', 'pendiente', 'persiana', 370500, 370500, 150000, '2024-10-05', 'admin');

INSERT INTO detalle_pedido (id_pedido, id_producto, descripcion, cantidad, ancho, alto, precio_unitario, subtotal, estado_produccion) VALUES
(2, 6, 'Persiana Enrollable Blackout', 3, 1.20, 1.80, 120000, 360000, 'pendiente'),
(2, 15, 'Cadena Control', 3, NULL, NULL, 3500, 10500, 'pendiente');

-- Pedido 3: Venta directa de toldillos
INSERT INTO pedidos (id_cliente, fecha_pedido, estado, tipo_pedido, subtotal, total, anticipo, fecha_entrega_estimada, creado_por) VALUES
(4, '2024-09-22', 'entregado', 'toldillo', 110000, 110000, 110000, '2024-09-22', 'admin');

INSERT INTO detalle_pedido (id_pedido, id_producto, descripcion, cantidad, precio_unitario, subtotal, estado_produccion) VALUES
(3, 11, 'Toldillo Hamaca', 1, 45000, 45000, 'instalado'),
(3, 12, 'Toldillo Copa', 1, 65000, 65000, 'instalado');

-- 7. ÓRDENES DE PRODUCCIÓN
-- Orden de producción para pedido 1 - Cortina 1
INSERT INTO ordenes_produccion (id_pedido, id_detalle_pedido, fecha_creacion, fecha_inicio, estado, responsable, instrucciones) VALUES
(1, 1, '2024-09-16', '2024-09-17', 'en proceso', 'Juan Pérez', 'Cortina blackout blanco 2.50x2.20m con pliegues tradicionales');

-- Materiales necesarios para la orden 1
INSERT INTO materiales_orden (id_orden_produccion, id_tela, cantidad_requerida, cantidad_utilizada, unidad, observaciones) VALUES
(1, 1, 8.50, 0, 'metros', 'Incluye 3m adicionales para stock'),
(1, 1, 5.50, 0, 'metros', 'Metros calculados para la cortina según medidas');

-- Orden de producción para pedido 1 - Cortina 2
INSERT INTO ordenes_produccion (id_pedido, id_detalle_pedido, fecha_creacion, fecha_inicio, estado, responsable, instrucciones) VALUES
(1, 2, '2024-09-16', '2024-09-17', 'en proceso', 'Juan Pérez', 'Cortina blackout blanco 2.50x2.20m con pliegues tradicionales');

-- Materiales necesarios para la orden 2
INSERT INTO materiales_orden (id_orden_produccion, id_tela, cantidad_requerida, cantidad_utilizada, unidad, observaciones) VALUES
(2, 1, 8.50, 0, 'metros', 'Incluye 3m adicionales para stock'),
(2, 1, 5.50, 0, 'metros', 'Metros calculados para la cortina según medidas');

-- 8. ÓRDENES DE COMPRA A PROVEEDORES
-- Orden de compra para las persianas del pedido 2
INSERT INTO ordenes_compra (id_proveedor, id_pedido, fecha_orden, estado, total, observaciones, creado_por) VALUES
(1, 2, '2024-09-19', 'enviada', 360000, 'Persianas enrollables blackout 1.20x1.80m color gris', 'admin');

INSERT INTO detalle_orden_compra (id_orden_compra, id_producto, descripcion, cantidad, ancho, alto, precio_unitario, subtotal) VALUES
(1, 6, 'Persiana Enrollable Blackout 1.20x1.80m', 3, 1.20, 1.80, 120000, 360000);

-- 9. PAGOS REGISTRADOS
-- Anticipo pedido 1
INSERT INTO pagos (id_pedido, fecha_pago, monto, metodo_pago, tipo_pago, comprobante, registrado_por) VALUES
(1, '2024-09-16', 200000, 'transferencia', 'anticipo', 'TRANS-001234', 'admin');

-- Anticipo pedido 2
INSERT INTO pagos (id_pedido, fecha_pago, monto, metodo_pago, tipo_pago, comprobante, registrado_por) VALUES
(2, '2024-09-19', 150000, 'efectivo', 'anticipo', NULL, 'admin');

-- Pago completo pedido 3
INSERT INTO pagos (id_pedido, fecha_pago, monto, metodo_pago, tipo_pago, registrado_por) VALUES
(3, '2024-09-22', 110000, 'efectivo', 'pago final', 'admin');

-- 10. VENTAS DIRECTAS
-- Venta directa 1: Accesorios
INSERT INTO ventas_directas (id_cliente, fecha_venta, total, metodo_pago, estado, vendedor) VALUES
(5, '2024-09-23', 18000, 'efectivo', 'completada', 'admin');

INSERT INTO detalle_venta_directa (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 13, 2, 5000, 10000),
(1, 14, 1, 8000, 8000);

-- Venta directa 2: Mosquiteros y soportes
INSERT INTO ventas_directas (id_cliente, fecha_venta, total, metodo_pago, estado, vendedor) VALUES
(3, '2024-09-24', 56000, 'transferencia', 'completada', 'admin');

INSERT INTO detalle_venta_directa (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
(2, 11, 1, 45000, 45000),
(2, 17, 1, 6000, 6000),
(2, 13, 1, 5000, 5000);

-- 11. MOVIMIENTOS DE INVENTARIO
-- Entrada de tela (compra inicial)
INSERT INTO movimientos_inventario (id_tela, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, observaciones, usuario) VALUES
(1, 'entrada_compra', 50.00, 'metros', '2024-09-10', 'COMPRA-001', 'Compra inicial de inventario', 'admin'),
(2, 'entrada_compra', 35.00, 'metros', '2024-09-10', 'COMPRA-001', 'Compra inicial de inventario', 'admin'),
(3, 'entrada_compra', 45.00, 'metros', '2024-09-10', 'COMPRA-001', 'Compra inicial de inventario', 'admin'),
(4, 'entrada_compra', 40.00, 'metros', '2024-09-10', 'COMPRA-002', 'Compra inicial de inventario', 'admin'),
(10, 'entrada_compra', 60.00, 'metros', '2024-09-10', 'COMPRA-003', 'Tela para mosquiteros', 'admin');

-- Salida de tela para producción (pedido 1)
INSERT INTO movimientos_inventario (id_tela, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, id_orden_produccion, id_pedido, observaciones, usuario) VALUES
(1, 'salida_produccion', 14.00, 'metros', '2024-09-17', 'OP-001', 1, 1, 'Tela para cortina 1 ventana 1', 'admin'),
(1, 'salida_produccion', 14.00, 'metros', '2024-09-17', 'OP-002', 2, 1, 'Tela para cortina 1 ventana 2', 'admin');

-- Entrada de productos fabricados (mosquiteros)
INSERT INTO movimientos_inventario (id_producto, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, observaciones, usuario) VALUES
(11, 'entrada_fabricacion', 15, 'unidades', '2024-09-12', 'FAB-001', 'Fabricación mosquiteros individuales', 'admin'),
(12, 'entrada_fabricacion', 10, 'unidades', '2024-09-12', 'FAB-001', 'Fabricación mosquiteros dobles', 'admin'),
(13, 'entrada_fabricacion', 8, 'unidades', '2024-09-12', 'FAB-002', 'Fabricación mosquiteros premium', 'admin');

-- Salida de tela para fabricar mosquiteros
INSERT INTO movimientos_inventario (id_tela, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, observaciones, usuario) VALUES
(10, 'salida_produccion', 22.50, 'metros', '2024-09-11', 'FAB-001', 'Tela usada en fabricación de mosquiteros', 'admin'),
(10, 'salida_produccion', 12.00, 'metros', '2024-09-11', 'FAB-002', 'Tela usada en mosquiteros premium', 'admin');

-- Salidas por ventas directas
INSERT INTO movimientos_inventario (id_producto, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, id_venta, observaciones, usuario) VALUES
(13, 'salida_venta', 2, 'unidades', '2024-09-23', 'VENTA-1', 1, 'Venta directa ganchos', 'admin'),
(14, 'salida_venta', 1, 'unidades', '2024-09-23', 'VENTA-1', 1, 'Venta directa argollas', 'admin'),
(11, 'salida_venta', 1, 'unidades', '2024-09-24', 'VENTA-2', 2, 'Venta mosquitero individual', 'admin'),
(17, 'salida_venta', 1, 'unidades', '2024-09-24', 'VENTA-2', 2, 'Venta soporte pared', 'admin'),
(13, 'salida_venta', 1, 'unidades', '2024-09-24', 'VENTA-2', 2, 'Venta ganchos', 'admin');

-- Salida por pedido de mosquiteros (pedido 3)
INSERT INTO movimientos_inventario (id_producto, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, id_pedido, observaciones, usuario) VALUES
(11, 'salida_venta', 1, 'unidades', '2024-09-22', 'PEDIDO-3', 3, 'Mosquitero individual vendido', 'admin'),
(12, 'salida_venta', 1, 'unidades', '2024-09-22', 'PEDIDO-3', 3, 'Mosquitero doble vendido', 'admin');

-- Entrada de accesorios y soportes (compra inicial)
INSERT INTO movimientos_inventario (id_producto, tipo_movimiento, cantidad, unidad, fecha_movimiento, referencia, observaciones, usuario) VALUES
(13, 'entrada_compra', 50, 'unidades', '2024-09-08', 'COMPRA-ACC-001', 'Compra inicial accesorios', 'admin'),
(14, 'entrada_compra', 40, 'unidades', '2024-09-08', 'COMPRA-ACC-001', 'Compra inicial accesorios', 'admin'),
(15, 'entrada_compra', 30, 'unidades', '2024-09-08', 'COMPRA-ACC-002', 'Compra inicial accesorios', 'admin'),
(16, 'entrada_compra', 25, 'unidades', '2024-09-08', 'COMPRA-ACC-002', 'Compra inicial accesorios', 'admin'),
(17, 'entrada_compra', 35, 'unidades', '2024-09-08', 'COMPRA-SOP-001', 'Compra inicial soportes', 'admin'),
(18, 'entrada_compra', 28, 'unidades', '2024-09-08', 'COMPRA-SOP-001', 'Compra inicial soportes', 'admin'),
(19, 'entrada_compra', 15, 'unidades', '2024-09-08', 'COMPRA-SOP-002', 'Compra inicial rieles', 'admin'),
(20, 'entrada_compra', 12, 'unidades', '2024-09-08', 'COMPRA-SOP-002', 'Compra inicial rieles', 'admin'),
(21, 'entrada_compra', 20, 'unidades', '2024-09-08', 'COMPRA-SOP-003', 'Compra inicial soportes', 'admin');
