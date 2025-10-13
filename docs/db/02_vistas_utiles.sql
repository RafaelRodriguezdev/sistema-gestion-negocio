-- VISTAS UTILES

-- Vista: Stock critico de telas
CREATE VIEW v_telas_stock_critico AS
SELECT
	t.id_tela,
    t.codigo,
    t.nombre,
    t.color,
    t.stock_metros,
    t.stock_minimo,
    CASE
		WHEN t.stock_metros < t.stock_minimo THEN 'Critico'
        WHEN t.stock_metros < (t.stock_minimo * 1.5) THEN 'Bajo'
        ELSE 'OK'
	END as estado_stock
FROM telas t
WHERE t.activo = TRUE
ORDER BY t.stock_metros ASC;

-- Vista: Productos con stock bajo
CREATE VIEW v_productos_stock_bajo AS
SELECT
	p.id_producto,
    p.codigo,
    p.nombre,
    p.tipo,
    p.stock_actual,
    p.stock_minimo,
    c.nombre as categoria
FROM productos p
JOIN categorias_productos c ON p.id_categoria = c.id_categoria
WHERE p.stock_actual < p.stock_minimo
	AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
    AND p.activo = TRUE;
    
-- Vista: Pedidos pendientes con saldo
CREATE VIEW v_pedidos_pendientes AS 
SELECT
	p.id_pedido,
    p.fecha_pedido,
    c.nombre as cliente_nombre,
    c.apellido as cliente_apellido,
    c.telefono as cliente_telefono,
    p.tipo_pedido,
    p.estado,
    p.total,
    p.anticipo,
    (p.total - IFNULL(p.anticipo, 0)) as saldo_pendiente,
    p.fecha_entrega_estimada
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.estado != 'cancelado'
	AND p.estado != 'entregado'
ORDER BY p.fecha_entrega_estimada ASC;

-- Vista: Ordenes de prodcucción activas
CREATE VIEW v_ordenes_produccion_activas AS 
SELECT
	op.id_orden_produccion,
    op.fecha_creacion,
    op.estado,
    p.id_pedido,
    c.nombre as cliente_nombre,
    c.apellido as cliente_apellido,
    dp.descripcion,
    op.responsable
FROM ordenes_produccion op
JOIN pedidos p ON op.id_pedido = p.id_pedido
JOIN clientes c ON p.id_cliente = c.id_cliente
LEFT JOIN detalle_pedido dp ON op.id_detalle_pedido = dp.id_detalle_pedido
WHERE op.estado IN ('pendiente', 'en_proceso')
ORDER BY op.fecha_creacion ASC;
    
-- Vista: Inventario de materia prima
CREATE VIEW v_inventario_telas AS
SELECT
	t.id_tela,
    t.codigo,
    t.nombre,
    t.color,
    CONCAT(t.nombre, '-', t.color) as descripcion_completa,
    t.precio_metro,
    t.stock_metros as stock_actual,
    t.stock_minimo,
    (t.stock_metros - t.stock_minimo) as diferencia,
    CASE
		WHEN t.stock_metros <= 0 THEN 'SIN STOCK'
        WHEN t.stock_metros < t.stock_minimo THEN 'CRITICO'
        WHEN t.stock_metros < (t.stock_minimo * 1.5) THEN 'BAJO'
        WHEN t.stock_metros < (t.stock_minimo * 2) THEN 'MODERADO'
        ELSE 'OPTIMO'
	END as estado_stock,
    CASE
		WHEN t.stock_metros <= 0 THEN 5
        WHEN t.stock_metros < t.stock_minimo THEN 4
        WHEN t.stock_metros < (t.stock_minimo * 1.5) THEN 3
        WHEN t.stock_metros < (t.stock_minimo * 2) THEN 2
        ELSE 1
	END as prioridad_reorden,
    (t.stock_metros * t.precio_metro) as valor_inventario,
    t.proveedor,
    t.activo
FROM telas t
WHERE t.activo = TRUE
ORDER BY prioridad_reorden DESC, t.stock_metros ASC;

-- Vista: Inventario de productos terminados
CREATE VIEW v_inventario_productos AS
SELECT
	p.id_producto,
    p.codigo,
    p.nombre,
    c.nombre as categoria,
    p.tipo,
    p.color,
    p.stock_actual,
    p.stock_minimo,
    p.unidad_medida,
    (p.stock_actual - p.stock_minimo) as diferencia,
    CASE
		WHEN p.stock_actual <= 0 THEN 'SIN STOCK'
        WHEN p.stock_actual < p.stock_minimo THEN 'CRITICO'
        WHEN p.stock_actual <(p.stock_minimo * 1.5) THEN 'BAJO'
        WHEN p.stock_actual < (p.stock_minimo * 2) THEN 'MODERADO'
        ELSE 'OPTIMO'
	END as estado_stock,
    CASE
		WHEN p.stock_actual <= 0 THEN '5'
        WHEN p.stock_actual < p.stock_minimo THEN '4'
        WHEN p.stock_actual < (p.stock_minimo * 1.5) THEN '3'
        WHEN p.stock_actual < (p.stock_minimo * 2) THEN '2'
        ELSE 1
	END as prioridad_reorden,
    p.precio_venta,
    (p.stock_actual * p.precio_venta) as valor_inventario,
    p.fabricable,
    p.requiere_medidas,
    p.activo,
    p.descripcion
FROM productos p
JOIN categorias_productos c ON p.id_categoria = c.id_categoria
WHERE p.activo = TRUE
	AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
ORDER BY prioridad_reorden DESC, p.stock_actual ASC;

-- Inventario consolidado general
CREATE VIEW v_inventario_general AS
SELECT
	'TELA' as tipo_item,
    t.codigo,
    CONCAT(t.nombre, '-', t.color) as descripcion,
    t.stock_metros as cantidad,
    'metros' as unidad,
    t.stock_minimo as minimo,
    CASE
		WHEN t.stock_metros <= 0 THEN 'SIN STOCK'
        WHEN t.stock_metros < t.stock_minimo THEN 'CRITICO'
        WHEN t.stock_metros < (t.stock_minimo * 1.5) then 'BAJO'
        ELSE 'OK'
	END as estado,
    (t.stock_metros * t.precio_metro) as valor_total,
    'Materia Prima' as categoria
FROM telas t
WHERE t.activo = TRUE

UNION ALL

SELECT
	'PRODUCTO' as tipo_item,
    p.codigo,
    p.nombre as descripcion,
    p.stock_actual as cantidad,
    p.unidad_medida as unidad,
    p.stock_minimo as minimo,
    CASE
		WHEN p.stock_actual <= 0 THEN 'SIN STOCK'
        WHEN p.stock_actual < p.stock_minimo THEN 'CRITICO'
        WHEN p.stock_actual < (p.stock_minimo * 1.5) THEN 'BAJO'
        ELSE 'OK'
	END as estado,
    (p.stock_actual * p.precio_venta) as valor_total,
    c.nombre as categoria
 FROM productos p
 JOIN categorias_productos c ON p.id_categoria = c.id_categoria
 WHERE p.activo = TRUE
	AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
ORDER BY estado DESC, tipo_item, descripcion;
    
-- Resumen de inventario por categoria
CREATE VIEW v_resumen_inventario_categorias AS
SELECT 
    c.nombre as categoria,
    COUNT(p.id_producto) as total_productos,
    SUM(p.stock_actual) as cantidad_total,
    SUM(CASE WHEN p.stock_actual < p.stock_minimo THEN 1 ELSE 0 END) as productos_criticos,
    SUM(CASE WHEN p.stock_actual > 0 THEN 1 ELSE 0 END) as productos_con_stock,
    SUM(CASE WHEN p.stock_actual = 0 THEN 1 ELSE 0 END) as productos_sin_stock,
    SUM(p.stock_actual * p.precio_venta) as valor_total_inventario
FROM categorias_productos c
LEFT JOIN productos p ON c.id_categoria = p.id_categoria 
    AND p.activo = TRUE 
    AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
GROUP BY c.id_categoria, c.nombre
ORDER BY valor_total_inventario DESC;

-- Vista: Alertas de orden
CREATE VIEW v_alertas_reorden AS
SELECT 
	'TELA' as tipo,
    t.codigo,
    CONCAT(t.nombre, ' - ', t.color) as item,
    t.stock_metros as stock_actual,
    'metros' as unidad,
    t.stock_minimo,
    (t.stock_minimo - t.stock_metros) as cantidad_sugerida_compra,
    CASE 
        WHEN t.stock_metros <= 0 THEN 'URGENTE'
        WHEN t.stock_metros < t.stock_minimo THEN 'ALTA'
        ELSE 'MEDIA'
    END as prioridad,
    t.proveedor,
    t.precio_metro as precio_unitario,
    ((t.stock_minimo * 2) - t.stock_metros) * t.precio_metro as costo_estimado_reorden
FROM telas t
WHERE t.activo = TRUE
    AND t.stock_metros < (t.stock_minimo * 1.5)

UNION ALL

SELECT 
    'PRODUCTO' as tipo,
    p.codigo,
    p.nombre as item,
    p.stock_actual,
    p.unidad_medida as unidad,
    p.stock_minimo,
    (p.stock_minimo * 2) - p.stock_actual as cantidad_sugerida_compra,
    CASE 
        WHEN p.stock_actual <= 0 THEN 'URGENTE'
        WHEN p.stock_actual < p.stock_minimo THEN 'ALTA'
        ELSE 'MEDIA'
    END as prioridad,
    'N/A' as proveedor,
    p.precio_venta as precio_unitario,
    ((p.stock_minimo * 2) - p.stock_actual) * p.precio_venta as costo_estimado_reorden
FROM productos p
WHERE p.activo = TRUE
    AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
    AND p.stock_actual < (p.stock_minimo * 1.5)

ORDER BY 
    CASE prioridad 
        WHEN 'URGENTE' THEN 1
        WHEN 'ALTA' THEN 2
        ELSE 3
    END,
    costo_estimado_reorden DESC;

-- Vista: Valoracion total de inventario
CREATE VIEW v_valorizacion_inventario AS
SELECT
	'Materia Prima (Telas)' as tipo_inventario,
    COUNT(*) as items_diferentes,
    SUM(stock_metros) as cantidad_total,
    'metros' as unidad,
    SUM(stock_metros * precio_metro) as valor_total
    FROM telas
WHERE activo = TRUE

UNION ALL

SELECT 
	CONCAT('Productos - ', c.nombre) as tipo_inventario,
    COUNT(p.id_producto) as items_diferentes,
    SUM(p.stock_actual) as cantidad_total,
    'unidades' as unidad,
    SUM(p.stock_actual * p.precio_venta) as valor_total
FROM productos p
JOIN categorias_productos c ON p.id_categoria = c.id_categoria
WHERE p.activo = TRUE
    AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
GROUP BY c.id_categoria, c.nombre

UNION ALL

SELECT 
    'TOTAL GENERAL' as tipo_inventario,
    NULL as items_diferentes,
    NULL as cantidad_total,
    'mixto' as unidad,
    (
        SELECT SUM(stock_metros * precio_metro) FROM telas WHERE activo = TRUE
    ) + (
        SELECT SUM(stock_actual * precio_venta) 
        FROM productos 
        WHERE activo = TRUE AND tipo IN ('toldillo', 'accesorio', 'soporte')
    ) as valor_total;
    
-- Vista: Movimientos recientes de inventario
CREATE VIEW v_movimientos_recientes AS
SELECT 
	m.id_movimiento,
    m.fecha_movimiento,
    m.tipo_movimiento,
    CASE 
        WHEN m.id_tela IS NOT NULL THEN 'TELA'
        WHEN m.id_producto IS NOT NULL THEN 'PRODUCTO'
    END as tipo_item,
    COALESCE(t.codigo, p.codigo) as codigo,
    COALESCE(
        CONCAT(t.nombre, ' - ', t.color),
        p.nombre
    ) as descripcion,
    m.cantidad,
    m.unidad,
    CASE m.tipo_movimiento
        WHEN 'entrada_compra' THEN '📥 Entrada Compra'
        WHEN 'salida_produccion' THEN '🏭 Salida Producción'
        WHEN 'entrada_fabricacion' THEN '✅ Entrada Fabricación'
        WHEN 'salida_venta' THEN '💰 Salida Venta'
        WHEN 'ajuste_positivo' THEN '➕ Ajuste +'
        WHEN 'ajuste_negativo' THEN '➖ Ajuste -'
    END as movimiento_descripcion,
    m.referencia,
    m.observaciones,
    m.usuario
FROM movimientos_inventario m
LEFT JOIN telas t ON m.id_tela = t.id_tela
LEFT JOIN productos p ON m.id_producto = p.id_producto
ORDER BY m.fecha_movimiento DESC, m.id_movimiento DESC;

-- Vista: Productos disponibles para venta inmediata
CREATE VIEW v_productos_venta_inmediata AS
SELECT 
	p.id_producto,
    p.codigo,
    p.nombre,
    p.tipo,
    p.color,
    c.nombre as categoria,
    p.stock_actual as disponible,
    p.unidad_medida,
    p.precio_venta,
    p.descripcion,
    CASE 
        WHEN p.stock_actual > p.stock_minimo THEN 'Disponible'
        WHEN p.stock_actual > 0 THEN 'Últimas unidades'
        ELSE 'Agotado'
    END as disponibilidad
    FROM productos p
JOIN categorias_productos c ON p.id_categoria = c.id_categoria
WHERE p.activo = TRUE
    AND p.tipo IN ('toldillo', 'accesorio', 'soporte')
    AND p.requiere_medidas = FALSE
ORDER BY p.tipo, p.nombre;
    