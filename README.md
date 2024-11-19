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
  
- Tabla de empleados:`empleados` (id_empleado, nombre, apellido, fecha_de_contratación)
  
- Tabla de ventas:`ventas` (id_venta, id_pedido, id_cliente, id_producto, id_empleado, fecha_venta, cantidad)
  
- Tabla de Clientes: `clientes` (id_cliente, nombre, apellido, email, pais, edad, genero)
  
- Tabla de Pedidos: `pedidos` (id_pedido, id_cliente, fecha_pedido, estado_pedido)
  
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

¿Cuál ha sido la evolución de los ingresos mensuales desde 2021 hasta hoy?

¿Cuáles son los meses con mayores y menores ingresos?

¿Cuál es el producto más vendido en términos de cantidad y en términos de ingresos?

¿Cuáles son las categorías de productos que generan más ingresos?

¿Cuál es el valor promedio de un pedido?

¿Cuál ha sido la evolución del ticket medio por pedido a lo largo de los años, desde 2021 hasta 2024?

¿Cuál es el empleado con mayores ventas? ¿Qué porcentaje representa sobre las ventas totales de le tienda?

# Preguntas sobre Rentabilidad:

Margen de beneficio por producto:

¿Cuáles son los 5 productos más rentables?

¿Cuáles son las categorías más rentables?

¿Cuál fue el beneficio total del año 2021 en comparación con 2024? Teniendo en cuenta que 2024 todavía no ha finalizado y quedan 2 meses por delante, ¿Cuánto se debería de vender de media por mes para igualar los beneficios de 2021 (Año con mayores beneficios)?

# Preguntas sobre Clientes:

¿Cuántos clientes nuevos se han adquirido cada mes?

¿Hay algún patrón estacional o tendencia en la adquisición de nuevos clientes? ¿Hay meses donde se adquieren más clientes? ¿A qué se debe? 

Segmentación de clientes:

¿Hay algún segmento de clientes que esté creciendo más rápidamente?

¿Cuál es el valor de vida del cliente (CLTV) promedio?

¿Cuál es el CLTV promedio por año? ¿Se percibe mejora?

¿Cuáles son los segmentos de clientes que más gastan? 

¿Qué categorías de productos son más populares entre diferentes grupos demográficos de clientes?
Analizar si ciertos grupos de clientes por segmento de edad tienen un CLTV más alto o más bajo.

# Análisis de la frecuencia de compra:

¿Cuánto tiempo promedio tardan los clientes en realizar su segunda compra?

¿Con que frecuencia compran los clientes? ¿Cuántos días pasan entre una compra y otra por cliente?

¿Qué porcentaje de clientes realiza más de una compra?

¿Cuál es el porcentaje de clientes que repite compra dentro del primer mes, trimestre, año?

¿Qué productos compran los clientes con mayor frecuencia? ¿Hay alguna forma de personalizar la experiencia de compra para aumentar el gasto?

¿Existe alguna relación entre la categoría de producto y la frecuencia de compra?

# Preguntas sobre Tendencias:

¿Cuáles son los productos más populares en cada temporada?

¿Qué cambios se observan en las preferencias de productos a lo largo de los últimos años?

# Informe detallado:

![Economic-financial analysis of e-commerce Dressing Style ]()

# Dashboard:

El proyecto contiene un Dashboard de ventas dinámico para monitorizar el funcionamiento de la empresa y comprobar de un solo vistazo las métricas relevantes para el negocio.

[Haz clic aquí para descargar el Dashboard de ventas](Dassboard_Dressing_Style.pbix)

# Contacto:

- Linkedin: https://www.linkedin.com/in/fernandosolerbarrera/

- Correo: solerbarrerafernando@gmail.com









