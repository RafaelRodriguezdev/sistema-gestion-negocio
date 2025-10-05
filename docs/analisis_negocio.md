# **ANÁLISIS DEL NEGOCIO**
## **Descripción del Negocio**
El negocio se dedica a:

- Elaboración y venta de velos y cortinas bajo pedido: Cliente elige tela y diseño, se toman medidas, se compra material y se fabrica.
- Venta de persianas bajo pedido: Cliente selecciona persiana, se toman medidas el negocio la solicita a fábrica.
- Confección y venta de toldillos/mosquiteros: Fabricación propia
- Venta de soportes y accesorios: Productos para instalación
## **Procesos Identificados**
### ***Proceso 1: Venta de Cortinas/Velos Personalizados***
Consulta cliente - Visita para tomar medidas - Cliente elige tela y diseño - Cálculo de precio y generación de cotización - Confirmación del pedido y anticipo - Compra de materiales - Fabricación - Entrega e instalación - Cobro final 
### ***Proceso 2: Venta de Persianas***
Consulta cliente - Toma de medidas – Cliente elige tipo y diseño - Cotización con proveedor - Confirmación de pedido - Pedido a fábrica - Recepción de persiana – Instalación - Cobro
### ***Proceso 3: Venta de Toldillo/Mosquitero***
Consulta cliente – Cliente elige tipo y color - Verificación de stock – Venta directa – Cobro inmediato
### ***Proceso 4: Venta de Accesorios***
Consulta cliente - Verificación de stock - Venta directa - Cobro inmediato
## **Solicitudes Hechas Por Administrador (Backlog)**
- *“Quiero registrar datos de un cliente (nombre, contacto, dirección), para poder asociar sus pedidos y cotizaciones.” **- Gestión de clientes -***
- *“Quiero crear y editar productos (telas, persianas, mosquiteros, soportes), para mantener actualizado el catálogo.” **- Gestión de productos -***
- *“Quiero registrar el stock de materiales (telas por color, accesorios, soportes), para controlar lo disponible y evitar faltantes.” **- Gestión de inventario -***
- *“Quiero ingresar medidas de una ventana y seleccionar tela/diseño, para generar una cotización con precio detallado.” **- Cotizaciones -***
- *“Quiero exportar la cotización a PDF, para enviarla al cliente o imprimirla.” **-Generar cotizaciones –***
- *“Quiero transformar una cotización aceptada en pedido, para iniciar producción o compra.” **- Convertir cotización a pedido –***
- *“Quiero ver las órdenes de producción con medidas y materiales necesarios, para fabricar el producto.” **- Ordenes de producción -***
- *“Quiero generar una orden de compra de persianas a proveedor, para gestionar las ventas de este tipo de producto.” **- Pedidos a proveedor -***   
- *“Quiero registrar las ventas y los pagos (efectivo o transferencia), para poder cuadrar caja al final del día.” - Registro de ventas -*
- *“Quiero ver un reporte de productos más vendidos y utilidades, para tomar decisiones del negocio.” **- Reportes –***
## **Problemas Encontrados Y Soluciones**
### ***Problema 1: Complejidad en el cálculo de precios***
` `Los precios varían según tipo de tela, diseño, medidas y accesorios.

Solución: Crear sistema de fórmulas configurables por tipo de producto
### ***Problema 2: Gestión de múltiples proveedores de persianas***
Cada proveedor tiene diferentes productos y precios

Solución: Tabla de relación Proveedor-Producto con precios específicos
### ***Problema 3: Control de stock complejo***
Las telas se miden por metros, accesorios por unidades

Solución: Campo "unidad-medida" en tabla productos y cálculos diferenciados

