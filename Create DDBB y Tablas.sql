CREATE DATABASE dressing_style;

ALTER TABLE dressing_style.productos
CHANGE COLUMN ï»¿id_producto id_producto VARCHAR(5) PRIMARY KEY NOT NULL;

ALTER TABLE dressing_style.empleados
CHANGE COLUMN ï»¿id_empleado id_empleado VARCHAR(5) PRIMARY KEY NOT NULL;

ALTER TABLE dressing_style.pedidos
CHANGE COLUMN ï»¿id_pedido id_pedido VARCHAR(5) PRIMARY KEY NOT NULL;

ALTER TABLE dressing_style.detalles_pedido
CHANGE COLUMN ï»¿id_detalle id_detalle VARCHAR(5) PRIMARY KEY NOT NULL;

ALTER TABLE dressing_style.ventas
CHANGE COLUMN ï»¿id_venta id_venta VARCHAR(5) PRIMARY KEY NOT NULL;


ALTER TABLE dressing_style.productos
MODIFY COLUMN id_producto VARCHAR(5) PRIMARY KEY NOT NULL,
MODIFY COLUMN nombre VARCHAR(255) NOT NULL,
MODIFY COLUMN categoria VARCHAR(255) NOT NULL,
MODIFY COLUMN precio DECIMAL(10,2) NOT NULL;



CREATE TABLE dressing_style.Empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    fecha_contratacion DATE NOT NULL
);


CREATE TABLE dressing_style.Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    pais VARCHAR(50) NOT NULL
);

CREATE TABLE dressing_style.Ventas (
    id_venta INT PRIMARY KEY,
	id_cliente INT NOT NULL ,
    id_producto VARCHAR(5) NOT NULL,
    id_empleado INT NOT NULL,
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES dressing_style.productos(id_producto),
    FOREIGN KEY (id_empleado) REFERENCES dressing_style.Empleados(id_empleado),
	FOREIGN KEY (id_cliente) REFERENCES dressing_style.Clientes(id_cliente) 
	);

CREATE TABLE dressing_style.Pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha_pedido DATE NOT NULL,
    fecha_entrega DATE NOT NULL,
    estado_pedido VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES dressing_style.Clientes(id_cliente)
);

CREATE TABLE dressing_style.Detalles_Pedido (
    id_detalle INT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto VARCHAR(5) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES dressing_style.Pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES dressing_style.productos(id_producto)
);

ALTER TABLE productos
ADD COLUMN coste DECIMAL(10,2);

ALTER TABLE clientes
ADD COLUMN genero VARCHAR(10);

UPDATE clientes
SET pais = REPLACE(pais, 'EspaÃ±a', 'España')
WHERE pais = 'EspaÃ±a';









