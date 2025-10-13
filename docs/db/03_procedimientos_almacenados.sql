
-- PROCEDIMIENTO: CONVERTIR COTIZACIÓN A PEDIDO
DELIMITER //
CREATE PROCEDURE sp_convertir_cotizacion_a_pedido(
    IN p_id_cotizacion INT,
    IN p_anticipo DECIMAL(10,2),
    IN p_fecha_entrega_estimada DATE,
    IN p_usuario VARCHAR(100)
)
BEGIN
    DECLARE v_id_pedido INT;
    DECLARE v_id_cliente INT;
    DECLARE v_total DECIMAL(10,2);
	
    -- Se obtienen datos de la cotización
    SELECT id_cliente, total INTO v_id_cliente, v_total
    FROM cotizaciones
    WHERE id_cotizacion = p_id_cotizacion AND estado = 'aceptada';
    
    -- Creacion del pedido
    IF v_id_cliente IS NOT NULL THEN
    INSERT INTO pedidos (
            id_cliente, 
            id_cotizacion, 
            fecha_pedido, 
            estado, 
            tipo_pedido,
            subtotal,
            descuento,
            total, 
            anticipo,
            fecha_entrega_estimada,
            creado_por
        )
        SELECT 
            id_cliente,
            id_cotizacion,
            CURDATE(),
            'pendiente',
            'mixto',
            subtotal,
            descuento,
            total,
            p_anticipo,
            p_fecha_entrega_estimada,
            p_usuario
        FROM cotizaciones
        WHERE id_cotizacion = p_id_cotizacion;
        
        SET v_id_pedido = LAST_INSERT_ID();
        
        -- Pasar detalles de la cotización a pedido
        INSERT INTO detalle_pedido (
            id_pedido,
            id_producto,
            id_tela,
            descripcion,
            cantidad,
            ancho,
            alto,
            precio_unitario,
            subtotal
        )
        SELECT 
            v_id_pedido,
            id_producto,
            id_tela,
            descripcion,
            cantidad,
            ancho,
            alto,
            precio_unitario,
            subtotal
        FROM detalle_cotizacion
        WHERE id_cotizacion = p_id_cotizacion;
        
        -- Se registra anticipo como parte de pago
        IF p_anticipo > 0 THEN
            INSERT INTO pagos (
                id_pedido,
                fecha_pago,
                monto,
                metodo_pago,
                tipo_pago,
                registrado_por
            ) VALUES (
                v_id_pedido,
                CURDATE(),
                p_anticipo,
                'efectivo',
                'anticipo',
                p_usuario
            );
        END IF;
        
        SELECT v_id_pedido as id_pedido;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cotización no encontrada o no está aceptada';
    END IF;
END//
DELIMITER ;

-- PROCEDIMIENTO: REGISTRAR VENTA DIRECTA
DELIMITER //
CREATE PROCEDURE sp_registrar_venta_directa(
    IN p_id_cliente INT,
    IN p_metodo_pago VARCHAR(20),
    IN p_vendedor VARCHAR(100),
    IN p_productos JSON
)
BEGIN
    DECLARE v_id_venta INT;
    DECLARE v_total DECIMAL(10,2) DEFAULT 0;
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_count INT;
    DECLARE v_id_producto INT;
    DECLARE v_cantidad DECIMAL(10,2);
    DECLARE v_precio DECIMAL(10,2);
    DECLARE v_subtotal DECIMAL(10,2);
    
    -- Crear la venta
    INSERT INTO ventas_directas (
        id_cliente,
        fecha_venta,
        metodo_pago,
        vendedor
    ) VALUES (
        p_id_cliente,
        CURDATE(),
        p_metodo_pago,
        p_vendedor
    );
    SET v_id_venta = LAST_INSERT_ID();
    SET v_count = JSON_LENGTH(p_productos);
    
    -- Procesar cada producto
    WHILE v_i < v_count DO
        SET v_id_producto = JSON_EXTRACT(p_productos, CONCAT('$[', v_i, '].id_producto'));
        SET v_cantidad = JSON_EXTRACT(p_productos, CONCAT('$[', v_i, '].cantidad'));
        SET v_precio = JSON_EXTRACT(p_productos, CONCAT('$[', v_i, '].precio'));
        SET v_subtotal = v_cantidad * v_precio;
        SET v_total = v_total + v_subtotal;
        
        -- Insertar datos en detalles de venta
        INSERT INTO detalle_venta_directa (
            id_venta,
            id_producto,
            cantidad,
            precio_unitario,
            subtotal
        ) VALUES (
            v_id_venta,
            v_id_producto,
            v_cantidad,
            v_precio,
            v_subtotal
        );
        
        -- Registrar el movimiento en el inventario
        INSERT INTO movimientos_inventario (
            id_producto,
            tipo_movimiento,
            cantidad,
            unidad,
            referencia,
            id_venta,
            usuario
        ) VALUES (
            v_id_producto,
            'salida_venta',
            v_cantidad,
            'unidades',
            CONCAT('VENTA-', v_id_venta),
            v_id_venta,
            p_vendedor
        );
         SET v_i = v_i + 1;
    END WHILE;
    
    -- Actualizar el total de las ventas
    UPDATE ventas_directas 
    SET total = v_total
    WHERE id_venta = v_id_venta;
    
    SELECT v_id_venta as id_venta, v_total as total;
END//
DELIMITER ;

-- PROCEDIMIENTO: REPORTE COMPLETO O GENERAL
DELIMITER //
CREATE PROCEDURE sp_reporte_inventario_completo()
BEGIN
    -- Resumen general
    SELECT '-- VALORIZACIÓN TOTAL --' as seccion;
    SELECT * FROM v_valorizacion_inventario;
    
    SELECT '' as separador;
    SELECT '-- RESUMEN POR CATEGORÍA --' as seccion;
    SELECT * FROM v_resumen_inventario_categorias;
    
    SELECT '' as separador;
    SELECT '-- ALERTAS DE REORDEN --' as seccion;
    SELECT * FROM v_alertas_reorden;
    
    SELECT '' as separador;
    SELECT '-- INVENTARIO DE TELAS --' as seccion;
    SELECT * FROM v_inventario_telas;
    
    SELECT '' as separador;
    SELECT '-- INVENTARIO DE PRODUCTOS --' as seccion;
    SELECT * FROM v_inventario_productos;
END//
DELIMITER ;