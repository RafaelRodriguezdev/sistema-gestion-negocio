# **REQUISITOS DEL SISTEMA**
## **Objetivo del Sistema**
Desarrollar una aplicación web que permita gestionar integralmente el negocio de cortinas, persianas y accesorios, automatizando procesos desde la cotización hasta la entrega final.
## **Usuarios del Sistema**
Administrador: Propietario del negocio (acceso total)

Vendedor: Empleado de ventas (opcional para fases futuras)

Cliente: Consulta de pedidos (opcional para fases futuras)
## **Requisitos Funcionales**
### ***RF01 - Gestión de Clientes***
Registrar nuevos clientes, modificar datos de clientes existentes, consultar historial de pedidos por cliente, generar reportes de clientes
### ***RF02 - Gestión de Productos***
Mantener catálogo de telas (tipo, color, precio por metro), gestionar diseños de cortinas y velos, catálogo de persianas con proveedores, inventario de accesorios y soportes
### ***RF03 - Gestión de Pedidos***
Crear nuevos pedidos, registrar medidas de ventanas/espacios, calcular automáticamente precios, seguimiento de estados del pedido, programar fechas de entrega
### ***RF04 - Gestión de Inventario***
Control de stock de telas, control de stock de accesorios, alertas de stock mínimo, registro de entrada/salida de productos
### ***RF05 - Gestión Financiera***
Generación de cotizaciones, facturación, control de anticipos y pagos, cuentas por cobrar, reportes financieros
### ***RF06 - Gestión de Proveedores***
Registro de proveedores de persianas, gestión de órdenes de compra, control de precios por proveedor
### ***RF07 - Reportes y Estadísticas***
Ventas por período, productos más vendidos, rentabilidad por tipo de producto, clientes más frecuentes
## **Requisitos No Funcionales**
### ***RNF01 - Usabilidad***
Interfaz intuitiva y fácil de usar, tiempo de aprendizaje máximo: 2 horas, compatible con dispositivos móviles
### ***RNF02 - Rendimiento***
Tiempo de respuesta máximo: 3 segundos, soporte para hasta 100 usuarios concurrentes, disponibilidad 99% del tiempo
### ***RNF03 - Seguridad***
Autenticación de usuarios, encriptación de contraseñas, backup automático diario, control de acceso por roles
### ***RNF04 - Compatibilidad***
Compatible con navegadores modernos, responsive design, base de datos MySQL/PostgreSQL
# **CASOS DE USO PRINCIPALES**
## **CU01: Gestión de Pedido (cortina, velo, persiana)**
Descripción: Registrar un pedido personalizado de persiana, cortina o velo.

Flujo Principal: 

Buscar cotización o seleccionar “Nueva Cotización” (véase CU03 Generar Cotización) – Confirma medidas de ventanas, estilo (persianas) o tela y diseño – Confirma medidas y precio calculado automáticamente - Confirma pedido y registra anticipo - Sistema genera orden de producción
## **CU02: Gestionar Inventario**
Descripción: Controlar stock y alertas de inventario

Flujo Principal:

Administrador accede a inventario - Consulta stock actual por tipo de producto - Registra entrada de nuevas telas - Sistema actualiza cantidades disponibles - Sistema genera alertas automáticas de stock mínimo
## **CU03: Generar Cotización**
Descripción: Crear cotización para cliente

Flujo Principal:

Ingresa datos del cliente - Especifica tipo de producto requerido - Ingresa medidas preliminares - Sistema calcula precio estimado - Genera documento de cotización - Envía cotización al cliente, guardar o cambiar estado a generar pedido.

