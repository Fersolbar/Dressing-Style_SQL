<h1>Proyecto Tienda online Dressing Style 📊⁣ </h1>

<h2>📋Contexto de la emrpesa </h2> 
Dressing Style, una vibrante tienda de ropa online, ha experimentado un crecimiento notable en los últimos años. 
Con una base de clientes en constante expansión y un catálogo de productos cada vez más diverso,
la empresa se enfrenta al desafío de comprender a fondo el comportamiento de sus clientes y las tendencias de ventas para impulsar su éxito continuo. 

<h3>🎯El objetivo/desafio del proyecto </h3> 
Hasta ahora, Dressing Style ha confiado en informes manuales y análisis básicos para obtener información sobre sus ventas. 
Sin embargo, este enfoque se ha vuelto insostenible a medida que el volumen de datos ha crecido. 
La empresa necesita una solución que le permita analizar sus datos de ventas de manera eficiente y extraer conocimientos accionables en tiempo real.

<h3> La solución </h3>

Nuestro proyecto consiste en desarrollar un sistema de análisis de ventas integral que aproveche el poder de los datos de Dressing Style. 
Al construir un modelo de datos sólido y implementar consultas SQL avanzadas, proporcionaremos a la empresa las herramientas necesarias para:

Comprender el comportamiento de los clientes: Identificar patrones de compra, segmentar clientes y personalizar la experiencia de compra.
Optimizar el inventario: Analizar la demanda de productos, identificar artículos de bajo rendimiento y tomar decisiones de compra informadas.
Maximizar las ventas: Descubrir oportunidades de venta cruzada y venta adicional, y lanzar campañas de marketing dirigidas.
Evaluar el rendimiento general: Realizar un seguimiento de las métricas clave de ventas, como ingresos, ganancias y valor promedio de los pedidos.

<h4>📝Base de datos </h4> 
- Tabla de Productos:`productos` (id_producto, nombre, precio, categoría, stock, coste)
- Tabla de empleados:`empleados` (id_empleado, nombre, apellido, fecha de contratacion)
- Tabla de ventas:`ventas` (id_venta, id_liente, id_producto, id_empleado, fecha_venta, cantidad)
- Tabla de Clientes: `clientes` (id_cliente, nombre, apellido, email, telefono, direccion)
- Tabla de Pedidos: `pedidos` (id_pedido, id_cliente, fecha_pedido, fecha_entrega, estado_pedido)
- Tabla de Detalles de Pedido: `detalles_pedido` (id_detalle, id_pedido, id_producto, cantidad, precio_unitario)

<h5> Modelo Relacional: </h5>

![Modelo Relacional](https://github.com/Fersolbar/Dressing-Style_SQL/blob/main/modelo%20relacional%20de%20base%20de%20datos%20de%20dressing_style.png)


<h6> 🛠️Herramientas a utilizar  </h6>  En este proyecto utilizaremos lenguaje de SQL y el gestor de base de datos MYSQL 🗃️ Base de datos .sql

# 💡Desarrollo | Ejecución

Análisis de modelo relación
Análisis exploratorio de las tablas
Análisis de economico-financiero de la la evolución de la empresa desde 2022 y de su situación actual.

# Análisis financiero 💸

# Preguntas sobre Ingresos y Ventas:

¿Cuál ha sido la evolución de los ingresos mensuales desde 2022 hasta hoy?

¿Cuáles son los meses con mayores y menores ingresos?

¿Cuál es el producto más vendido en términos de cantidad y en términos de ingresos?

¿Cuáles son las categorías de productos que generan más ingresos?

¿Cuál es el valor promedio de un pedido?

¿Cual es el empleado con mayores ventas? ¿Que porcentaje representa sobre las ventas totales de le tienda?

# Preguntas sobre Clientes:

¿Cuantos clientes únicos hay?

¿Cuántos clientes nuevos se han adquirido cada mes?

¿Cuál es el valor de vida del cliente (CLTV) promedio?

¿Cuáles son los 20 clientes que más gastan? posible acción de marketing sobre esta pregunta.

¿Cuál es la tasa de retención de clientes?

¿Cuánto tiempo tarda un cliente en realizar una segunda compra?

# Preguntas sobre Rentabilidad:

¿Cuáles son los productos más rentables?

¿Cuáles son los clientes más rentables?

¿Cuál es el costo de adquisición de clientes (CAC)?

¿Cual fue el beneficio total del año 2022 en comparación con 2023 y cuanto se deberia de vender de medai por mes para igualar el año con mayor beneficio?

# Preguntas sobre Tendencias:

¿Cuáles son los productos más populares en cada temporada?

¿Cuáles son las ventas totales por mes o trimestre en 2022 y 2023?

¿Cuáles son las tendencias de ventas por temporada?

¿Qué productos han experimentado un aumento o disminución significativa en las ventas?

Preguntas sobre el Comportamiento de Compra:

¿Cuáles son los productos que se suelen comprar juntos?

¿Cuál es el tiempo promedio entre pedidos de un mismo cliente?

¿Qué categorías de productos son más populares entre diferentes grupos demográficos de clientes?









