# **MODELO DE BASE DE DATOS**
## **Entidades principales (núcleo del negocio)**
Son los objetos que representan actores o recursos básicos y que tienen sentido por sí mismos:

- Clientes: personas que hacen pedidos y cotizaciones.
- Usuarios: personal del negocio que usa el sistema (dueño, vendedor, instalador, etc.).
- Productos: catálogo general: cortinas, velos, mosquiteros, persianas, soportes.
- Telas: materia prima (con color, ancho, precio por metro).
- Proveedores: quienes suministran persianas o materiales externos.
- Inventario: control del stock actual de productos y materias primas.
## **Entidades de procesos / transacciones**
Son tablas que registran operaciones del negocio y siempre dependen de las entidades principales:

- Cotizaciones: documento inicial con precios y condiciones.
- DetalleCotizacion: lista de ítems dentro de una cotización (qué producto, cuánta cantidad, medidas).
- Pedidos: confirmación de una cotización aceptada, da inicio a la producción o compra.
- Ventas: registros de pagos y cierre de la transacción con el cliente.
- Pagos: desglose de abonos, anticipos o pagos finales ligados a un pedido/venta.
- ComprasProveedor: pedidos que se hacen al proveedor (por ejemplo, persianas).
## **Entidades de producción**
Estas permiten llevar el control del proceso de fabricar productos terminados (cortinas, toldillos):

- OrdenesProduccion: instrucciones de fabricar un producto con ciertas medidas y cantidades.
- ConsumoMaterial: cuánto stock de tela o insumos se gastó en cada orden.
- ProductosFabricados (si se maneja como tabla separada): productos terminados que entran al inventario.
## **Relaciones clave**
Representan cómo se conectan las entidades:

- Cliente – Cotización: un cliente puede tener muchas cotizaciones.
- Cotización – DetalleCotización – Producto: una cotización puede incluir muchos productos.
- Cotización – Pedido: una cotización aceptada se convierte en pedido.
- Pedido – OrdenProducción – ConsumoMaterial: un pedido puede generar producción que descuenta materiales.
- Pedido – CompraProveedor: algunos pedidos generan compras externas.
- Pedido – Venta – Pagos: todo pedido termina en una venta, que se liquida con pagos.
- Producto – Inventario: cada producto tiene su registro de stock.

Usuario – Cotización/Pedido/Venta: un usuario es quien crea o gestiona estas operaciones.
