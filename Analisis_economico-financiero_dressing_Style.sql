#//Preguntas sobre Ingresos y Ventas://

# ¿Cuál ha sido la evolución de los ingresos mensuales desde 2021 hasta hoy?

SELECT 
	ROUND(SUM(precio_unitario*cantidad), 2) as Ingresos, 
    monthname(fecha_pedido) as mes, 
    year(fecha_pedido) as años 
FROM detalles_pedido as d
INNER JOIN pedidos as pe ON d.id_pedido = pe.id_pedido
WHERE estado_pedido = 'Entregado'
GROUP BY mes, años
ORDER BY años ASC;

WITH ingresos_2021 AS (
    SELECT 
        ROUND(SUM(precio_unitario * cantidad), 2) AS ingresos_2021, 
        MONTHNAME(fecha_pedido) AS mes_2021
    FROM 
        detalles_pedido AS d
    INNER JOIN 
        pedidos AS pe ON d.id_pedido = pe.id_pedido
    WHERE 
        estado_pedido = 'Entregado' 
        AND YEAR(fecha_pedido) = 2021
    GROUP BY 
        mes_2021
),
ingresos_2022 AS (
    SELECT 
        ROUND(SUM(precio_unitario * cantidad), 2) AS ingresos_2022, 
        MONTHNAME(fecha_pedido) AS mes_2022
    FROM 
        detalles_pedido AS d
    INNER JOIN 
        pedidos AS pe ON d.id_pedido = pe.id_pedido
    WHERE 
        estado_pedido = 'Entregado' 
        AND YEAR(fecha_pedido) = 2022
    GROUP BY 
        mes_2022
),
ingresos_2023 AS (
    SELECT 
        ROUND(SUM(precio_unitario * cantidad), 2) AS ingresos_2023, 
        MONTHNAME(fecha_pedido) AS mes_2023
    FROM 
        detalles_pedido AS d
    INNER JOIN 
        pedidos AS pe ON d.id_pedido = pe.id_pedido
    WHERE 
        estado_pedido = 'Entregado' 
        AND YEAR(fecha_pedido) = 2023
    GROUP BY 
        mes_2023
),
ingresos_2024 AS (
    SELECT 
        ROUND(SUM(precio_unitario * cantidad), 2) AS ingresos_2024, 
        MONTHNAME(fecha_pedido) AS mes_2024
    FROM 
        detalles_pedido AS d
    INNER JOIN 
        pedidos AS pe ON d.id_pedido = pe.id_pedido
    WHERE 
        estado_pedido = 'Entregado' 
        AND YEAR(fecha_pedido) = 2024
    GROUP BY 
        mes_2024
)
SELECT 
    coalesce(ingresos_2021.mes_2021, ingresos_2022.mes_2022, ingresos_2023.mes_2023, ingresos_2024.mes_2024) AS mes,
    ingresos_2021.ingresos_2021,
    ingresos_2022.ingresos_2022,
    ingresos_2023.ingresos_2023,
    ingresos_2024.ingresos_2024
FROM 
    ingresos_2021
JOIN 
    ingresos_2022 ON ingresos_2021.mes_2021 = ingresos_2022.mes_2022
JOIN 
    ingresos_2023 ON ingresos_2021.mes_2021 = ingresos_2023.mes_2023
JOIN 
    ingresos_2024 ON ingresos_2021.mes_2021 = ingresos_2024.mes_2024
ORDER BY 
    FIELD(mes, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');



# ¿Cuáles son los meses con mayores y menores ingresos?

-- En esta consulta podemos comprobar como los meses con más ingresos son Junio, Febrero y Agosto, 
-- habiendo una diferencia notable entre los dos primeros con respecto al resto, mientras que los meses de menos ingresos fueron Enero y Abril.

SELECT 
monthname(fecha_pedido) as mes,
ROUND(SUM(precio_unitario*cantidad),2) as Ingresos
FROM detalles_pedido as d
INNER JOIN pedidos as pe ON d.id_pedido = pe.id_pedido
WHERE estado_pedido = 'Entregado'
GROUP BY mes
ORDER BY Ingresos DESC;

# ¿Cuál es el producto más vendido en términos de cantidad y en términos de ingresos?

-- Los productos "Calcetines de algodon", "Falda vaquera" y "Camiseta a rayas" destacan como los líderes en unidades vendidas, según el análisis realizado.

SELECT p.id_producto, p.nombre, SUM(v.cantidad) as cantidad_vendida 
FROM productos as p
INNER JOIN ventas as v ON p.id_producto = v.id_producto
INNER JOIN pedidos as pe ON pe.id_pedido = v.id_venta
WHERE estado_pedido = 'Entregado'
GROUP BY p.id_producto, p.nombre
ORDER BY cantidad_vendida DESC;

-- Los productos de mayor precio, como el abrigo de lana, los Zapatos Oxford y el abrigo impermeable, lideran en términos de ingresos generados.

SELECT p.id_producto, p.nombre, ROUND(SUM(p.precio*v.cantidad),2) as ingresos 
FROM productos as p
INNER JOIN ventas as v ON p.id_producto = v.id_producto
INNER JOIN pedidos as pe ON pe.id_pedido = v.id_venta
WHERE estado_pedido = 'Entregado'
GROUP BY p.id_producto, p.nombre
ORDER BY ingresos DESC;

# ¿Cuáles son las categorías de productos que generan más ingresos y las que han generado más unidades vendidas?

-- En base a las siguientes consultas, las categorias que más han facturado son: el Calzado y las chaquetas, mientras que en caso de la categorias que más unidades han vendido son: los accesorios y el calzado.
 
 
SELECT p.categoria, ROUND(SUM(p.precio*v.cantidad), 2) as ingresos 
FROM productos as p
INNER JOIN ventas as v ON p.id_producto = v.id_producto
INNER JOIN pedidos as pe ON pe.id_pedido = v.id_venta
WHERE estado_pedido = 'Entregado'
GROUP BY categoria
ORDER BY ingresos DESC;

SELECT p.categoria, SUM(v.cantidad) as unidades_vendidas 
FROM productos as p
INNER JOIN ventas as v ON p.id_producto = v.id_producto
INNER JOIN pedidos as pe ON pe.id_pedido = v.id_venta
WHERE estado_pedido = 'Entregado'
GROUP BY categoria
ORDER BY unidades_vendidas  DESC;

-- estas categorías generan márgenes de beneficio considerables, lo que se traduce en una rentabilidad elevada para la empresa. 
-- Este hallazgo subraya la importancia de mantener un enfoque estratégico en la gestión y promoción de estos productos para maximizar los ingresos.

SELECT 
	nombre, 
    categoria, 
    precio, ROUND(precio-coste, 2) as beneficio_por_producto, 
	ROUND(((precio-coste)/coste)*100, 2) as margen_beneficio 
FROM productos
GROUP BY nombre, categoria, precio, coste
ORDER BY precio DESC
LIMIT 10;


# ¿Cuál es el valor promedio de un pedido?

-- El análisis revela un ticket medio de 182,13€, indicando que los clientes tienden a realizar compras de valor considerable en la tienda online. 
-- La presencia de productos de importe alto, como chaquetas, abrigos o calzado, contribuye significativamente a este ticket medio elevado.

CREATE VIEW importe_por_pedido AS
SELECT dp.id_detalle, ROUND(SUM(dp.precio_unitario*dp.cantidad), 2) as importe_total_pedido
FROM detalles_pedido as dp
INNER JOIN pedidos as p ON dp.id_pedido = p.id_pedido
WHERE estado_pedido='Entregado'
GROUP BY dp.id_detalle;

CREATE VIEW ticket_medio as
SELECT ROUND(AVG(importe_total_pedido),2) as ticket_medio
FROM importe_por_pedido;

SELECT * FROM dressing_style.ticket_medio;

# ¿Cuál ha sido la evolución del ticket medio por pedido a lo largo de los años, desde 2021 hasta 2024?

-- Viendo la tabla, existe una bajada del ticket medio por compra considerable del 2021 a 2022 pero a partir del 2023 vuelve a subir aunque ligeramente. 
-- Una posible explicación para esta tendencia podría estar relacionada con varios factores económicos y de comportamiento del consumidor. 
-- La disminución del ticket medio en 2022 podría deberse a una combinación de factores como la inflación o cambios en el poder adquisitivo de los consumidores.

SELECT 
	YEAR(p.fecha_pedido) as años, 
	ROUND(AVG(ip.importe_total_pedido), 2) as ticket_medio_año 
FROM importe_por_pedido as ip
JOIN detalles_pedido as dp ON ip.id_detalle = dp.id_detalle
INNER JOIN pedidos as p ON dp.id_pedido = p.id_pedido
WHERE estado_pedido = 'Entregado'
GROUP BY años
ORDER BY años;

# ¿Cual es el empleado con mayores ventas? ¿Que porcentaje representa sobre las ventas totales de le tienda?

-- la empleada con un numero mayor de ventas es Theresa con id_empleado=3, la cual ha conseguido un total de 70 pedidos gestionados, suponiendo un 5,06% del total de pedidos en los 4 años.

SELECT 
	e.id_empleado, 
	e.nombre, 
	e.apellido, 
	COUNT(v.id_venta) as num_pedidos_gestionados, 
    ROUND(COUNT(v.id_venta)*100/(SELECT COUNT(*) FROM ventas), 2) 
    as porcentage_pedidos_gestionados_sobre_total 
FROM ventas as v
LEFT JOIN empleados as e ON v.id_empleado = e.id_empleado
LEFT JOIN pedidos as pe ON pe.id_pedido = v.id_venta
WHERE estado_pedido = 'Entregado'
GROUP BY e.id_empleado, e.nombre, e.apellido
ORDER BY num_pedidos_gestionados DESC;

# //PREGUNTAS SOBRE LA RENTABILIAD://

# Margen de beneficio por producto:

SELECT 
	p.id_producto, 
	p.nombre, 
	ROUND((((dp.precio_unitario*dp.cantidad)-(dp.cantidad*p.coste))
    /(dp.cantidad*p.coste))*100, 2) 
	as margen_de_beneficio 
FROM detalles_pedido as dp
LEFT JOIN productos as p ON dp.id_producto = p.id_producto
JOIN pedidos as pe ON dp.id_pedido = pe.id_pedido
WHERE estado_pedido = 'Entregado'
GROUP BY p.id_producto, p.nombre, margen_de_beneficio
ORDER BY margen_de_beneficio DESC;

# ¿Cuáles son los 5 productos más rentables?

-- Los productos más rentables son el sombrero de Fieltro, Los calcetines de algodón y tres tipos de camiseta como la camiseta a rayas, la camiseta con bordado y la camiseta de tirantes.
-- Con esta consulta se pued eapreciar que los productos de calcetines de algodón y las camisetas a rayas son dos de los productos con más unidades vendidas,
-- además se encuentran entre los 5 productos más rentables, debido a que ofrecen un buen margen de beneficio. Esto conlleva a que se muestren como los productos top para la empresa, con buen margen y alta rotación.
-- Por otr lado existen productos como el Sombrero de Fieltro, la bufanda de lana y la camisa de bordado que son productos rentables pero de baja rotación

WITH ventas_y_costes AS (
    SELECT 
        dp.id_producto, 
        pr.nombre, 
        SUM(dp.cantidad) as und_vendidas,
        SUM(dp.precio_unitario * dp.cantidad) AS total_ventas_producto, 
        SUM(pr.coste * dp.cantidad) AS total_costes_producto
    FROM 
        detalles_pedido AS dp
    LEFT JOIN 
        productos AS pr ON dp.id_producto = pr.id_producto
    INNER JOIN 
        pedidos AS pe ON dp.id_pedido = pe.id_pedido
    WHERE 
        pe.estado_pedido = 'Entregado'
    GROUP BY 
        dp.id_producto, pr.nombre
)
SELECT 
    id_producto, 
    nombre,
    und_vendidas,
    ROUND(total_ventas_producto, 2) AS total_ventas_producto, 
    ROUND(total_costes_producto, 2) AS total_costes_producto, 
    ROUND(total_ventas_producto - total_costes_producto, 2) AS beneficio, 
    ROUND(((total_ventas_producto - total_costes_producto) 
    / total_costes_producto)*100, 2) AS margen_beneficio
FROM 
    ventas_y_costes
GROUP BY 
    id_producto, nombre, total_ventas_producto, total_costes_producto
ORDER BY 
    margen_beneficio DESC
LIMIT 5;

# ¿Cuáles son las categorias más rentables?

WITH ventas_y_costes AS (
    SELECT 
        pr.categoria as categorias, 
        SUM(dp.cantidad) as und_vendidas,
        SUM(dp.precio_unitario * dp.cantidad) AS total_ventas_producto, 
        SUM(pr.coste * dp.cantidad) AS total_costes_producto
    FROM 
        detalles_pedido AS dp
    LEFT JOIN 
        productos AS pr ON dp.id_producto = pr.id_producto
    INNER JOIN 
        pedidos AS pe ON dp.id_pedido = pe.id_pedido
    WHERE 
        pe.estado_pedido = 'Entregado'
    GROUP BY 
        pr.categoria
)
SELECT 
    categorias,
    und_vendidas,
    ROUND(total_ventas_producto, 2) AS total_ventas_producto, 
    ROUND(total_costes_producto, 2) AS total_costes_producto, 
    ROUND(total_ventas_producto - total_costes_producto, 2) AS beneficio, 
    ROUND(((total_ventas_producto - total_costes_producto) 
    / total_costes_producto)*100, 2) AS margen_beneficio
FROM 
    ventas_y_costes
GROUP BY 
    categorias, total_ventas_producto, total_costes_producto
ORDER BY 
    beneficio DESC
LIMIT 5;


# ¿Cual fue el beneficio total del año 2021 en comparación con 2024? Teniendo en cuenta que 2024 todavia no ha finalizado y quedan 2 meses por delante, 
# ¿Cuanto se deberia de vender de media por mes para igualar los beneficios de 2021 (Año con mayores beneficios)?

-- La diferencia total entre ambos años fue de 21385,65€, por lo que faltando 2 meses para que finalice 2024 se deberian de obtener de media por mes unos 10692,83€ 

WITH ventas_y_costes AS (
    SELECT 
        YEAR(pe.fecha_pedido) AS años, 
        SUM(dp.precio_unitario * dp.cantidad) AS total_ventas, 
        SUM(pr.coste * dp.cantidad) AS total_costes
    FROM 
        detalles_pedido AS dp
    LEFT JOIN 
        productos AS pr ON dp.id_producto = pr.id_producto
    INNER JOIN 
        pedidos AS pe ON dp.id_pedido = pe.id_pedido
    WHERE 
        pe.estado_pedido = 'Entregado'
    GROUP BY 
        años
),
beneficios AS (
    SELECT 
        años, 
        total_ventas, 
        total_costes, 
        (total_ventas - total_costes) AS beneficio, 
        ((total_ventas - total_costes) / total_costes)
        * 100 AS margen_beneficio
    FROM 
        ventas_y_costes
)
SELECT 
    años, 
    ROUND(total_ventas, 2) AS total_ventas, 
    ROUND(total_costes, 2) AS total_costes, 
    ROUND(beneficio, 2) AS beneficio, 
    ROUND(margen_beneficio, 2) AS margen_beneficio
FROM 
    beneficios
ORDER BY 
    años;



WITH beneficios AS (
    SELECT 
        años, 
        total_ventas, 
        total_costes, 
        (total_ventas - total_costes) AS beneficio, 
        ((total_ventas - total_costes) / total_costes) * 100 AS margen_beneficio
    FROM (
        SELECT 
            YEAR(pe.fecha_pedido) AS años, 
            SUM(dp.precio_unitario * dp.cantidad) AS total_ventas, 
            SUM(pr.coste * dp.cantidad) AS total_costes
        FROM 
            detalles_pedido AS dp
        LEFT JOIN 
            productos AS pr ON dp.id_producto = pr.id_producto
        INNER JOIN 
            pedidos AS pe ON dp.id_pedido = pe.id_pedido
        WHERE 
            pe.estado_pedido = 'Entregado'
        GROUP BY 
            años
    ) AS ventas_y_costes
),
diferencia AS (
    SELECT 
        (SELECT beneficio FROM beneficios WHERE años = 2021) - 
        (SELECT beneficio FROM beneficios WHERE años = 2024) AS diferencia_beneficio
)
SELECT 
    ROUND(diferencia_beneficio, 2) as diferencia_benefico,
    ROUND(diferencia_beneficio / 2, 2) AS ventas_necesarias_por_mes
FROM 
    diferencia;


   

#//PREGUNTAS SOBRE CLIENTES://

# ¿Cuántos clientes nuevos se han adquirido cada mes?

-- Como podemos ver en la primera consulta se puede apreciar por cada mes de cada año el número de clientes que se registran como nuevos clientes en la tienda, realizando su primera compra.
 
SELECT 
	monthname(p.fecha_pedido) as Mes, 
	year(p.fecha_pedido) as Año, 
    count(distinct p.id_cliente) as Num_clientes_nuevos 
FROM pedidos as p
WHERE estado_pedido = 'Entregado'
GROUP BY Mes, Año
ORDER BY Año ASC; 

-- Si exponemos la tabla de manera paralela para comparar los años por columnas y los meses en filas, se puede ver como excepto Enero, Febrero y octubre (Meses que van a la baja en cuanto a aumento incremental de nuevos clientes), 
-- los demás meses sufren una desaceleración o un incremento menor en 2022, que posteriormento se recupera en 2023 pero vuelve a recaer en 2024.

SELECT 
    t2021.Mes AS Mes_2021, 
    t2021.Num_clientes_nuevos AS Num_clientes_nuevos_2021,
    t2022.Mes AS Mes_2022, 
    t2022.Num_clientes_nuevos AS Num_clientes_nuevos_2022,
    t2023.Mes AS Mes_2023, 
    t2023.Num_clientes_nuevos AS Num_clientes_nuevos_2023,
    t2024.Mes AS Mes_2024, 
    t2024.Num_clientes_nuevos AS Num_clientes_nuevos_2024
FROM 
    (SELECT monthname(p.fecha_pedido) as Mes, 
            count(distinct p.id_cliente) as Num_clientes_nuevos 
     FROM pedidos as p
     WHERE estado_pedido = 'Entregado' 
       AND year(p.fecha_pedido) = 2021
     GROUP BY Mes) as t2021
LEFT JOIN 
    (SELECT monthname(p.fecha_pedido) as Mes, 
            count(distinct p.id_cliente) as Num_clientes_nuevos 
     FROM pedidos as p
     WHERE estado_pedido = 'Entregado' 
       AND year(p.fecha_pedido) = 2022
     GROUP BY Mes) as t2022
ON t2021.Mes = t2022.Mes
LEFT JOIN 
	(SELECT monthname(p.fecha_pedido) as Mes, 
            count(distinct p.id_cliente) as Num_clientes_nuevos 
     FROM pedidos as p
     WHERE estado_pedido = 'Entregado' 
       AND year(p.fecha_pedido) = 2023
     GROUP BY Mes) as t2023
ON t2021.Mes = t2023.Mes
LEFT JOIN   
	(SELECT monthname(p.fecha_pedido) as Mes, 
            count(distinct p.id_cliente) as Num_clientes_nuevos 
     FROM pedidos as p
     WHERE estado_pedido = 'Entregado' 
       AND year(p.fecha_pedido) = 2024
     GROUP BY Mes) as t2024
ON t2021.Mes = t2024.Mes;
 
 -- Si extraemos los datos de diferencia incremental en cuanto a clientes nuevo por mes, podemos ver como existe una tendencia de picos, habiendo subidas y bajadas de un mes a otro,
 -- notandose la mayor diferencia en el mes de junio 2024 con respecto a Mayo y con respecto a las subidas de nuevos clientes en los meses de Junio de los años anteriores.

SELECT 
    month(p.fecha_pedido) as Mes, 
    year(p.fecha_pedido) as Año, 
    count(distinct p.id_cliente) as Num_clientes_nuevos,
    LAG(count(distinct p.id_cliente), 1, 0) OVER (ORDER BY year(p.fecha_pedido), month(p.fecha_pedido)) as Num_clientes_nuevos_mes_anterior,
    count(distinct p.id_cliente) - LAG(count(distinct p.id_cliente), 1, 0) OVER (ORDER BY year(p.fecha_pedido), month(p.fecha_pedido)) as Diferencia_incremental
FROM pedidos as p
WHERE estado_pedido = 'Entregado'
GROUP BY Mes, Año
ORDER BY Año ASC, month(p.fecha_pedido) ASC;

# ¿Hay algún patrón estacional o tendencia en la adquisición de nuevos clientes? ¿Hay meses donde se adquieren más clientes? ¿A qué se debe? (Ej: rebajas, campañas de marketing, eventos especiales).

-- Al analizar el crecimiento de nuestra base de datos de clientes, hemos observado un patrón interesante.  Agrupando los datos por meses, sin diferenciar entre años, se evidencia un pico de nuevas adquisiciones en enero y junio.
-- Este comportamiento podría estar relacionado con las campañas de rebajas que tradicionalmente se realizan en esos periodos, coincidiendo con el inicio del año y el comienzo del verano.  
-- Por otro lado, los meses de invierno muestran una tendencia a la baja en la incorporación de nuevos clientes.

SELECT 
   CASE month(p.fecha_pedido)
		WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
	END as Mes,
    count(distinct p.id_cliente) as Num_clientes_nuevos
FROM pedidos as p
WHERE estado_pedido = 'Entregado'
GROUP BY Mes
ORDER BY FIELD(Mes, 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre');

# Segmentación de clientes:

-- Mediante el análisis de segmentación de clientes, se ha identificado que el 53,80% del total de clientes son mujeres. 
-- En cuanto al país de origen, los clientes mayoritarios provienen de España y Alemania, seguidos por Italia y Reino Unido. 
-- Por último, al analizar los rangos de edad, se observa que más de la mitad de los clientes se encuentran en las categorías de edad adulta y mediana edad. 

SELECT 
	c.genero, 
	count(c.id_cliente) as num_clientes,  
	ROUND(COUNT(c.id_cliente) / (SELECT COUNT(*) FROM clientes) * 100, 2) as porcentaje_sobre_total 
FROM clientes as c
GROUP BY c.genero;

SELECT 
	c.genero, 
	count(c.id_cliente) as num_clientes,  
	ROUND(COUNT(c.id_cliente) / (SELECT COUNT(*) FROM clientes) * 100, 2) as porcentaje_sobre_total, 
	c.pais 
FROM clientes as c
GROUP BY c.genero, c.pais
ORDER BY c.pais;

SELECT 
	c.pais, 
	COUNT(c.pais) as num_clientes, 
	ROUND(COUNT(c.pais) / (SELECT COUNT(*) FROM clientes) * 100, 2) as porcentaje_sobre_total 
FROM clientes as c
GROUP BY c.pais;

SELECT 
	c.edad, 
	count(c.edad) as num_clientes 
FROM clientes as c
GROUP BY c.edad
ORDER BY num_clientes DESC;

SELECT 
	CASE 
		WHEN c.edad BETWEEN 18 AND 29 THEN 'jovenes' 
		WHEN c.edad BETWEEN 30 AND 45 THEN 'mediana edad'
		WHEN c.edad BETWEEN 46 AND 65 THEN 'edad adulta'
		ELSE 'edad avanzada'
    END AS rango_edad 
, count(c.edad) as num_clientes FROM clientes as c
GROUP BY rango_edad
ORDER BY num_clientes DESC;

-- Habiendo usado el condicional CASE, lo añadiremos como nueva columna para ayudarnos en posteriores consultas. 

ALTER TABLE clientes ADD COLUMN categoria_edad VARCHAR(30);

UPDATE clientes
SET categoria_edad = CASE 
    WHEN edad BETWEEN 18 AND 29 THEN 'jovenes' 
    WHEN edad BETWEEN 30 AND 45 THEN 'mediana edad'
    WHEN edad BETWEEN 46 AND 65 THEN 'edad adulta'
    ELSE 'edad avanzada'
END;

# ¿Hay algún segmento de clientes que esté creciendo más rápidamente?

-- Primero por cada categoria_edad extraemos la información de los clientes nuevos por mes y año, y posteriormente sacamos la diferencia que hay con respecto al mes anterior.

SELECT 
	c.categoria_edad,
    month(p.fecha_pedido) as Mes, 
    year(p.fecha_pedido) as Año, 
    count(distinct p.id_cliente) as Num_clientes_nuevos,
    LAG(count(distinct p.id_cliente), 1, 0) OVER (ORDER BY year(p.fecha_pedido), month(p.fecha_pedido)) as Num_clientes_nuevos_mes_anterior,
    count(distinct p.id_cliente) - LAG(count(distinct p.id_cliente), 1, 0) OVER (ORDER BY year(p.fecha_pedido), month(p.fecha_pedido)) as Diferencia
FROM pedidos as p
LEFT JOIN clientes as c ON P.id_cliente=c.id_cliente
WHERE estado_pedido = 'Entregado'
GROUP BY c.categoria_edad, Mes, Año
ORDER BY Año ASC, month(p.fecha_pedido) ASC;


-- Ahora para determinar que segmento de categoria_edad crece más rápido de manera exponencial en cuanto a nuevos clientes, realizamos esta nueva consulta con un CTE para calcular el promedio de crecimiento por categoria_edad
-- En lineas generales se puede apreciar un crecimiento mayor y exponencial mes a mes de los clientes de edad_adulta y jovenes con respecto al resto, teniendo los de edad_adulta menos picos de bajada que los jovenes.


WITH clientes_por_mes AS (
    SELECT 
        c.categoria_edad,
        month(p.fecha_pedido) as Mes, 
        year(p.fecha_pedido) as Año, 
        COUNT(DISTINCT p.id_cliente) as Num_clientes_nuevos
    FROM pedidos as p
    LEFT JOIN clientes as c ON p.id_cliente = c.id_cliente
    WHERE p.estado_pedido = 'Entregado'
    GROUP BY c.categoria_edad, Mes, Año
),
crecimiento_clientes AS (
    SELECT 
        categoria_edad,
        Mes,
        Año,
        Num_clientes_nuevos,
        LAG(Num_clientes_nuevos, 1, 0) OVER (PARTITION BY categoria_edad ORDER BY Año, Mes) as Num_clientes_nuevos_mes_anterior
    FROM clientes_por_mes
)
SELECT 
    categoria_edad,
    Mes,
    Año,
    Num_clientes_nuevos,
    Num_clientes_nuevos_mes_anterior,
    Num_clientes_nuevos - Num_clientes_nuevos_mes_anterior as Diferencia
FROM crecimiento_clientes
ORDER BY Año ASC, Mes ASC;

# ¿Cuál es el valor de vida del cliente (CLTV) promedio?

-- Teniendo en cuenta que el ticket medio es de 182,13€, el CLTV promedio es de 208,42€ y habiendo comprobado la frecuencia de compra de los clientes, tenemos datos más que considerables para decretar que existe un problema de fidelización.
-- Siendo en promedio la frecuencia de compra de los clientes aproximadamente de 1,14 compras por cliente de media, es decir muy pocos clientes vuelven a comprar.  

CREATE VIEW fecha_primer_pedido AS
SELECT v.id_cliente, min(v.fecha_venta) as primer_pedido
FROM ventas as v
GROUP BY id_cliente;

SELECT * FROM fecha_primer_pedido;

CREATE VIEW fecha_ultimo_pedido AS
SELECT v.id_cliente, max(v.fecha_venta) as ultimo_pedido
FROM ventas as v
GROUP BY id_cliente;

SELECT * FROM fecha_ultimo_pedido;

CREATE VIEW CLTV AS
SELECT round(AVG(CLTV), 2) as cltv_promedio
FROM (
    SELECT 
        v.id_cliente, 
        sum(dp.precio_unitario*dp.cantidad) * 
        (
            SELECT AVG(datediff(max_fecha, min_fecha)/(365*3+285)) 
            FROM (
                SELECT 
                    id_cliente, 
                    MAX(fecha_venta) as max_fecha, 
                    MIN(fecha_venta) as min_fecha
                FROM ventas
                GROUP BY id_cliente
            ) as fechas_cliente
        ) as CLTV
    FROM ventas as v
    INNER JOIN detalles_pedido as dp ON v.id_venta = dp.id_detalle
    GROUP BY v.id_cliente
) as cltv_por_cliente;

SELECT * FROM cltv;

# ¿Cual es el CLTV promedio por año? ¿Se percibe mejora?

-- Aunque el CLTV inicial en 2021 es más alto que el resto de años, se observa una tendencia ascendente de 2022 a 2024. 
-- Esto indica un incremento constante en el valor de vida del cliente año tras año, pero con mucha mejora por delante.

WITH cltv_año AS (
    SELECT 
        p.id_cliente, 
        sum(dp.precio_unitario*dp.cantidad) AS valor_de_vida, 
        YEAR(p.fecha_pedido) AS año
    FROM 
        pedidos as p
    INNER JOIN 
        detalles_pedido as dp ON p.id_pedido = dp.id_pedido
	INNER JOIN 
		ventas as v ON p.id_cliente = v.id_cliente
    GROUP BY 
        p.id_cliente, año
)
SELECT 
    año, 
    ROUND(AVG(valor_de_vida), 2) AS cltv_promedio_anual
FROM 
    cltv_año
GROUP BY 
    año
ORDER BY 
    año;

# ¿Cuáles son los segmentos de clientes que más gastan?.

SELECT 
	c.categoria_edad, 
    ROUND(SUM(precio_unitario*cantidad),2) as gasto_total_por_categoria_edad 
FROM clientes as c 
RIGHT JOIN pedidos as p ON c.id_cliente = p.id_cliente
INNER JOIN detalles_pedido as dp ON p.id_pedido = dp.id_pedido
WHERE estado_pedido = 'Entregado'
GROUP BY c.categoria_edad
ORDER BY gasto_total_por_categoria_edad DESC;

# ¿Qué categorías de productos son más populares entre diferentes grupos demográficos de clientes?

-- Por lo general las categorias más populares entre los diferntes segmentos de edad, son los accesorios y el calzado, teniendo los clientes de Edad avanzada y los de Mediana edad, los pantalones y las cahquetas como segunda opción respectivamente.

SELECT 
    c.categoria_edad,
    p.categoria,
    COUNT(dp.id_pedido) AS num_pedidos,
    SUM(dp.cantidad) AS total_cantidad
FROM 
    clientes AS c
INNER JOIN 
    pedidos AS pe ON c.id_cliente = pe.id_cliente
INNER JOIN 
    detalles_pedido AS dp ON pe.id_pedido = dp.id_pedido
INNER JOIN 
    productos AS p ON dp.id_producto = p.id_producto
GROUP BY 
    c.categoria_edad, p.categoria
ORDER BY 
    c.categoria_edad ASC, total_cantidad DESC;



# Analizar si ciertos grupos de clientes por segmento de edad tienen un CLTV más alto o más bajo.

-- De acuerdo con los resultados de la consulta, el segmento de clientes de edad avanzada, a pesar de representar un porcentaje menor del total de clientes, 
-- es el que genera los ingresos medios más altos para la empresa, destacándose como los que realizan un mayor gasto en sus compras.

WITH cltv_por_cliente AS (
    SELECT 
        c.id_cliente,
        c.categoria_edad,
        SUM(dp.precio_unitario * dp.cantidad) AS cltv
    FROM 
        clientes AS c
    INNER JOIN 
        pedidos AS p ON c.id_cliente = p.id_cliente
    INNER JOIN 
        detalles_pedido AS dp ON p.id_pedido = dp.id_pedido
    WHERE 
        p.estado_pedido = 'Entregado'
    GROUP BY 
        c.id_cliente, c.categoria_edad
)
SELECT 
    categoria_edad,
    ROUND(AVG(cltv), 2) AS cltv_promedio
FROM 
    cltv_por_cliente
GROUP BY 
    categoria_edad
ORDER BY 
    cltv_promedio DESC;



 # //ANALISIS DE LA FRECUENCIA DE COMPRA://
 
# ¿Cuánto tiempo promedio tardan los clientes en realizar su segunda compra?

-- En base a la consulta realizada el tiempo promedio de los clientes suelen ser 349 dias entre su primera compra y la segunda, lo cual supone una frecuencia muy baja de compra y largo periodo entre compras. 
-- Seria conveniente planificar una estrategia de fidelización si no hubiera y si la hubiera tratar de mejorarla o cambiarla ya que se necesita incentivar las compras en los clintes ya consolidados.

WITH primeras_compras AS (
    SELECT 
        id_cliente, 
        MIN(fecha_pedido) AS primera_compra
    FROM
        pedidos
    GROUP BY 
        id_cliente
),
segundas_compras AS (
    SELECT 
        p.id_cliente, 
        MIN(p.fecha_pedido) AS segunda_compra
    FROM
        pedidos p
    INNER JOIN 
        primeras_compras pc ON p.id_cliente = pc.id_cliente
    WHERE 
        p.fecha_pedido > pc.primera_compra
    GROUP BY 
        p.id_cliente
),
diferencia_tiempo AS (
    SELECT 
        sc.id_cliente,
        DATEDIFF(sc.segunda_compra, pc.primera_compra) AS dias_dif
    FROM
        segundas_compras sc
    INNER JOIN 
        primeras_compras pc ON sc.id_cliente = pc.id_cliente
)
SELECT 
    id_cliente,
    dias_dif,
    (SELECT ROUND(AVG(dias_dif)) FROM diferencia_tiempo WHERE dias_dif != 0) AS tiempo_promedio_por_clientes
FROM 
    diferencia_tiempo
WHERE 
    dias_dif != 0;


# ¿Qué porcentaje de clientes realiza más de una compra?

-- El 63,20% de los clientes del total de los 500 registrados en la base de datos ha realizado más de una compra.

WITH compras_mayores_1 AS (
    SELECT 
        id_cliente, 
        COUNT(id_pedido) AS num_compras
    FROM 
        pedidos AS pe
    WHERE 
        estado_pedido = 'Entregado'
    GROUP BY 
        id_cliente
    HAVING 
        num_compras >= 2
)
SELECT 
    ROUND((COUNT(id_cliente) * 100.0) / (SELECT COUNT(*) FROM clientes),2) AS porcentaje_clientes
FROM 
    compras_mayores_1;

    

# ¿Qué productos compran los clientes con mayor frecuencia? ¿Hay alguna forma de personalizar la experiencia de compra para aumentar el gasto?

-- Para obtener la frecuencia de compra de un producto, como cada cuánto tiempo los clientes suelen comprarlo de media, podemos calcular el tiempo promedio entre las compras de un producto.

WITH compras_producto AS (
    SELECT 
        v.id_producto, 
        pr.nombre, 
        v.fecha_venta,
        LAG(v.fecha_venta) OVER (PARTITION BY v.id_producto ORDER BY v.fecha_venta) AS compra_anterior
    FROM 
        ventas AS v
    LEFT JOIN 
        productos AS pr ON v.id_producto = pr.id_producto
    INNER JOIN 
        pedidos AS pe ON v.id_pedido = pe.id_pedido
    WHERE 
        pe.estado_pedido = 'Entregado'
)
SELECT 
    id_producto,
    nombre,
    ROUND(AVG(DATEDIFF(fecha_venta, compra_anterior))) AS frecuencia_compra_dias
FROM 
    compras_producto
WHERE 
    compra_anterior IS NOT NULL
GROUP BY 
    id_producto, nombre
ORDER BY 
    frecuencia_compra_dias ASC;
    


# ¿Con que frecuencia compran los clientes?¿Cuantos dias pasan entre una compra y otra por cliente?


WITH total_pedidos AS (
    SELECT COUNT(DISTINCT id_venta) AS total
    FROM ventas
),
total_pedidos_producto AS (
    SELECT id_producto, COUNT(DISTINCT id_venta) AS Frecuencia_de_compra
    FROM ventas
    GROUP BY id_producto
)
SELECT 
    tpp.id_producto, 
    tpp.Frecuencia_de_compra, 
    round((tpp.Frecuencia_de_compra * 100.0 / tp.total), 2) AS porcentaje_sobre_total
FROM 
    total_pedidos_producto tpp, 
    total_pedidos tp
ORDER BY 
    tpp.Frecuencia_de_compra DESC;



# ¿Existe alguna relación entre la categoria de producto y la frecuencia de compra?

-- La consulta nos muestra como las categorias de jerseys, Monos y camisetas, son las que mayor frecuencia de compra tienen, determinando de esta manera que son productos populares entre los clientes o que son percibidos por lo9s mismos como los productos de mayor calidad. 

WITH frecuencia_compras AS (
    SELECT 
        v.id_cliente,
        p.categoria,
        DATEDIFF(v.fecha_venta, LAG(v.fecha_venta) 
        OVER (PARTITION BY v.id_cliente, p.categoria ORDER BY v.fecha_venta)) 
        AS dias_entre_compras
    FROM 
        ventas AS v
    INNER JOIN 
        productos AS p ON v.id_producto = p.id_producto
)
SELECT 
    categoria,
    ROUND(AVG(dias_entre_compras),2) AS frecuencia_promedio_dias
FROM 
    frecuencia_compras
WHERE 
    dias_entre_compras IS NOT NULL
GROUP BY 
    categoria
ORDER BY 
    frecuencia_promedio_dias ASC;


# //PREGUNTAS SOBRE TENDENCIAS://

# ¿Cuáles son los productos más populares en cada temporada?

-- Subconsulta para cada temporada
WITH invierno AS (
    SELECT 
        pr.id_producto, 
        pr.nombre, 
        COUNT(v.id_pedido) AS num_pedidos_invierno 
    FROM 
        ventas AS v
    LEFT JOIN 
        productos AS pr ON v.id_producto = pr.id_producto
    WHERE 
        MONTHNAME(v.fecha_venta) IN ('January', 'December', 'February')
    GROUP BY 
        pr.id_producto, pr.nombre
),
primavera AS (
    SELECT 
        pr.id_producto, 
        pr.nombre, 
        COUNT(v.id_pedido) AS num_pedidos_primavera 
    FROM 
        ventas AS v
    LEFT JOIN 
        productos AS pr ON v.id_producto = pr.id_producto
    WHERE 
        MONTHNAME(v.fecha_venta) IN ('March', 'April', 'May')
    GROUP BY 
        pr.id_producto, pr.nombre
),
verano AS (
    SELECT 
        pr.id_producto, 
        pr.nombre, 
        COUNT(v.id_pedido) AS num_pedidos_verano 
    FROM 
        ventas AS v
    LEFT JOIN 
        productos AS pr ON v.id_producto = pr.id_producto
    WHERE 
        MONTHNAME(v.fecha_venta) IN ('June', 'July', 'August')
    GROUP BY 
        pr.id_producto, pr.nombre
),
otoño AS (
    SELECT 
        pr.id_producto, 
        pr.nombre, 
        COUNT(v.id_pedido) AS num_pedidos_otoño 
    FROM 
        ventas AS v
    LEFT JOIN 
        productos AS pr ON v.id_producto = pr.id_producto
    WHERE 
        MONTHNAME(v.fecha_venta) IN ('October', 'September', 'November')
    GROUP BY 
        pr.id_producto, pr.nombre
)
-- Simular FULL OUTER JOIN usando UNION ALL
SELECT 
    coalesce(invierno.id_producto, primavera.id_producto, verano.id_producto, otoño.id_producto) AS id_producto,
    coalesce(invierno.nombre, primavera.nombre, verano.nombre, otoño.nombre) AS nombre,
    num_pedidos_invierno,
    num_pedidos_primavera,
    num_pedidos_verano,
    num_pedidos_otoño
FROM 
    invierno
JOIN
    primavera ON invierno.id_producto = primavera.id_producto
JOIN
    verano ON invierno.id_producto = verano.id_producto
JOIN
    otoño ON invierno.id_producto = otoño.id_producto
ORDER BY 
    id_producto;

# ¿Qué cambios se observan en las preferencias de productos a lo largo de los últimos años?

-- Por lo general, la mayoria de productos reflejan una bajada en las unidades vendidas desde 2021 hasta 2023, siendo este un puento importante a considerar en la entrategia de venta de la empresa. 
-- 2022 fue un año desfavorable en términos de ventas. 2022 tiene los mayores porcentages negativos de diferencia de unidades vendidas en comparación con el año anterior.
-- En 2023 se observa que algunos productos muestran un ligero repunte en las ventas. Indicios de recuperación y mejoras en la estrategia.


WITH ventas_2021 AS (
    SELECT 
        id_producto, 
        SUM(cantidad) AS ventas_2021
    FROM 
        detalles_pedido
    INNER JOIN 
        pedidos ON detalles_pedido.id_pedido = pedidos.id_pedido
    WHERE 
        YEAR(fecha_pedido) = 2021 AND estado_pedido = 'Entregado'
    GROUP BY 
        id_producto
),
ventas_2022 AS (
    SELECT 
        id_producto, 
        SUM(cantidad) AS ventas_2022
    FROM 
        detalles_pedido
    INNER JOIN 
        pedidos ON detalles_pedido.id_pedido = pedidos.id_pedido
    WHERE 
        YEAR(fecha_pedido) = 2022 AND estado_pedido = 'Entregado'
    GROUP BY 
        id_producto
),
ventas_2023 AS (
    SELECT 
        id_producto, 
        SUM(cantidad) AS ventas_2023
    FROM 
        detalles_pedido
    INNER JOIN 
        pedidos ON detalles_pedido.id_pedido = pedidos.id_pedido
    WHERE 
        YEAR(fecha_pedido) = 2023 AND estado_pedido = 'Entregado'
    GROUP BY 
        id_producto
)
SELECT 
    p.nombre, 
    ventas_2023.id_producto, 
    ventas_2021.ventas_2021, 
    ventas_2022.ventas_2022, 
    ventas_2023.ventas_2023,
    (ventas_2023.ventas_2023 - ventas_2022.ventas_2022) AS cambio_ventas_2022_2023,
    ROUND(((ventas_2023.ventas_2023 - ventas_2022.ventas_2022) / ventas_2022.ventas_2022) * 100, 2) AS porcentaje_cambio_2022_2023,
    (ventas_2022.ventas_2022 - ventas_2021.ventas_2021) AS cambio_ventas_2021_2022,
    ROUND(((ventas_2022.ventas_2022 - ventas_2021.ventas_2021) / ventas_2021.ventas_2021) * 100, 2) AS porcentaje_cambio_2021_2022
FROM 
    ventas_2023
LEFT JOIN 
    ventas_2022 ON ventas_2023.id_producto = ventas_2022.id_producto
LEFT JOIN 
    ventas_2021 ON ventas_2022.id_producto = ventas_2021.id_producto
LEFT JOIN 
    productos p ON ventas_2023.id_producto = p.id_producto
ORDER BY 
    p.nombre ASC;



