# Identificación de debilidades

## CLIENTE:

### DDL
```sql
CREATE TABLE actividad01.cliente( 
	 id             INTEGER  NOT NULL , 
	 nombre         VARCHAR (100)  NOT NULL , 
	 correo         VARCHAR (100)  NOT NULL , 
	 fecha_creacion DATE DEFAULT now()  NOT NULL);

COMMENT ON COLUMN actividad01.cliente.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad01.cliente.nombre IS 'Nombre completo del cliente';
COMMENT ON COLUMN actividad01.cliente.correo IS 'Dirección de correo electrónico';
COMMENT ON COLUMN actividad01.cliente.fecha_creacion IS 'Fecha de creación del cliente';

ALTER TABLE actividad01.cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( id );
```

### DML
```sql
INSERT INTO actividad01.cliente (id,nombre, correo, fecha_creacion) 
VALUES
(218,'Harold Shipman', 'harold.shipman@correo.uk', '1946-01-14'),
(193,'Luis Alfredo Garavito', 'luis.alfredo.garavito@correo.co','1957-01-25'),
(125,'Thug Behram', 'thug.behram@correo.in','1765-01-01'),
(110,'Pedro Alonso López', 'pedro.alonso.lopez@correo.co','1948-10-08'),
(100,'Javed Iqbal', 'niels.högel@correo.de','1956-01-01'),
(85,'Niels Högel', 'niels.högel@correo.de','2025-02-26');
```
### Debilidades encontradas:

* 1. Integridad de entidad. Aunque la clave primaria está definida, no se utiliza un mecanismo automático (como una secuencia o autoincremento) para generar los valores de id.
* 2. Integridad de atributo. No se valida la estructura del correo electrónico en la columna correo.
* 3. Integridad de dominio?. Las fechas de creación deberían ser menores o iguales a la fecha actual para reflejar datos consistentes y * válidos en la lógica de negocio.
* 4. Integridad de dominio. Los valores de la columna correo no son únicos, ya que aparece duplicado en los registros con id 100 y 8.



## PRODUCTO: 

### DDL 
```sql
CREATE TABLE actividad01.producto ( 
	 id          SERIAL  NOT NULL , 
	 codigo      VARCHAR (25)  NOT NULL , 
	 nombre      VARCHAR (100)  , 
	 descripcion VARCHAR (10000)  , 
	 precio      NUMERIC (10,2) DEFAULT 0  NOT NULL , 
	 existencia  INTEGER DEFAULT 0  NOT NULL);

COMMENT ON COLUMN actividad01.producto.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad01.producto.codigo IS 'Código alfanumerico del producto';
COMMENT ON COLUMN actividad01.producto.nombre IS 'Nombre del producto';
COMMENT ON COLUMN actividad01.producto.descripcion IS 'Nombre descriptivo del producto';
COMMENT ON COLUMN actividad01.producto.precio IS 'Monto de venta del producto';
COMMENT ON COLUMN actividad01.producto.existencia IS 'Cantidad de unidades que hay en existencia del producto';

ALTER TABLE actividad01.producto ADD CONSTRAINT ck_producto_existencia CHECK (existencia > -1);
```

### DML
```sql
INSERT INTO actividad01.producto (id,codigo, nombre, descripcion, precio, existencia)
VALUES
(2,'PRD-0001', 'Coca Cola 2L', 'Co Cola en presentación de 2 Litros no retornable', 1800, 6),
(2,'PRD-0002', 'Chocholate Lindt ', 'Chocolate bombon 400 gramos marca Lindt', 4900.34, 0),
(3,'PRD-0004', 'Jabon de baño Dove', 'Jabón para baño marca Dove', 0, 10),
(10,'PRD-0002', 'Coca Cola 1L', 'Coca Cola en presentación de 1 Litro no retornable', 900, 5),
(11,'PRD-0001', '', 'Coca Cola en presentación de 2 Litroa retornable', 1600, 2),
(12,'PROD110', 'Laptop HP', 'Laptop de 14 pulgadas con procesador Intel Core i5', 750.50, 15),
(13,'PROD222', 'Mouse Logitech', 'Mouse inalámbrico con diseño ergonómico', 25.99, 50),
(14,'PROD003', 'Teclado Mecánico', 'Teclado mecánico con retroiluminación RGB', 89.90, 30),
(15,'PROD064', 'Monitor Samsung', 'Monitor LED de 24 pulgadas Full HD', 180.00, 20),
(16,'PROD005', 'Disco Duro Externo', 'Disco duro externo de 1TB con conexión USB 3.0', 65.00, 40),
(17,'PROD006', 'Memoria USB', 'Memoria USB de 64GB con alta velocidad de transferencia', 15.50, 100),
(18,'PROD007', 'Impresora Epson', 'Impresora multifuncional con conexión Wi-Fi', 120.00, 10),
(19,'PROD008', 'Auriculares Sony', 'Auriculares con cancelación de ruido y Bluetooth', 200.00, 25),
(20,'PROD009', 'Cámara Web', 'Cámara web Full HD con micrófono integrado', 55.00, 35),
(21,'PROD010', 'Micrófono Blue', 'Micrófono de condensador ideal para streaming', 130.99, 18),
(22,'PROD011', 'Cable HDMI', 'Cable HDMI 2.1 de alta velocidad y 2 metros de longitud', 10.00, 200),
(23,'PROD012', 'Altavoces Bose', 'Sistema de altavoces estéreo con subwoofer', 300.00, 5),
(24,'PROD013', 'Router TP-Link', 'Router inalámbrico con banda dual y 4 puertos Ethernet', 45.99, 40),
(25,'PROD014', 'SSD Kingston', 'Unidad de estado sólido de 500GB', 80.00, 50),
(26,'PROD015', 'Tableta Gráfica', 'Tableta gráfica con lápiz óptico para diseño digital', 110.00, 12),
(27,'PROD016', 'Smartphone Xiaomi', 'Smartphone con pantalla AMOLED y 128GB de almacenamiento', 320.00, 30),
(28,'PROD017', 'Adaptador USB-C', 'Adaptador multipuerto USB-C con HDMI, USB-A y lector de tarjetas', 35.99, 60),
(29,'PROD018', 'Power Bank', 'Batería externa de 20,000mAh con carga rápida', 25.00, 70),
(30,'PROD019', 'Soporte para Laptop', 'Soporte ajustable para laptops de hasta 17 pulgadas', 20.00, 45),
(31,'PROD020', 'Webcam Logitech', 'Webcam Full HD con autofoco y micrófono estéreo', 75.00, 15);
```

### Debilidades encontradas: 
* 5. Integridad de Entidad. En la tabla producto no existe una restricción de clave primaria.
* 6. Integridad de ¿?. En la tabla producto en la columna código debería ser único para cada producto, ya que identifica productos específicos.
* 7. Integridad de Atributo. La columna nombre debería tener un valor válido y no permitir valores vacíos, ya que es esencial para identificar y describir el producto.
* 8. Integridad de Dominio?. El registro con id 3 tiene un precio de 0, lo cual no es lógico para un producto en venta.
* 9. Integridad de Dominio. La descripción de los productos permite valores extremadamente largos (hasta 10,000 caracteres), lo que podría generar problemas de almacenamiento y rendimiento.
* 10. Integridad de Atributo. La descripción debería de tener una restricción para evitar valores nulos o en blanco.	
* 11. Integridad de Atributo. La columna existencias deberia tener una restriccion que evite tener valores negativos



## PEDIDO

### DDL:
```sql
CREATE TABLE actividad01.pedido ( 
 	id          SERIAL  NOT NULL , 
 	id_cliente  INTEGER  NOT NULL , 
 	fecha       DATE  DEFAULT now() NOT NULL , 
 	monto_total NUMERIC (10,2)  NOT NULL);

COMMENT ON COLUMN actividad01.pedido.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad01.pedido.id_cliente IS 'Id del cliente';
COMMENT ON COLUMN actividad01.pedido.fecha IS 'Fecha del pedido';
COMMENT ON COLUMN actividad01.pedido.monto_total IS 'Monto total que representa el pedido.';

ALTER TABLE actividad01.pedido ADD CONSTRAINT pk_pedido PRIMARY KEY ( id ) ;
```

### DML:
```sql
INSERT INTO actividad01.pedido (id, id_cliente, fecha, monto_total)
VALUES
(1, 193, '2025-01-15', 151),
(2, 85, '2025-01-12', 0),
(3, 193, '2025-02-13', 841.98),
(4, 218, '2025-01-15', 0),
(5, 110, '2025-01-13', 7600),
(6, 85, '2025-01-09', 3200),
(7, 85, '2025-01-01', 100);

SELECT * FROM actividad01.pedido p;
```

### Debilidades encontradas:
* 12. Integridad de Atributo. Existen pedido con un monto igual a 0, lo cual podría tener una restricción de tipo CHECK que valide que sea mayor a 0
* 13. Integridad de Usuario o Negocio:: No se valida que el monto_total de un pedido sea coherente con los subtotales de los detalles del pedido. Esto puede llevar a inconsistencias en la lógica de negocio. Y se puede solucionar implementando un trigger o procedimiento almacenado que calcule y valide el monto_total basado en los subtotales de los detalles del pedido.




## PEDIDO DETALLE

### DDL:
```sql
CREATE TABLE actividad01.pedido_detalle( 
	id          SERIAL  NOT NULL , 
 	id_pedido   INTEGER  NOT NULL , 
 	id_producto INTEGER  NOT NULL , 
 	cantidad    INTEGER  NOT NULL , 
 	subtotal    NUMERIC (10,2)  NOT NULL);

COMMENT ON COLUMN actividad01.pedido_detalle.id IS 'Id de la tabla';
COMMENT ON COLUMN actividad01.pedido_detalle.id_pedido IS 'Id de la tabla de pedidos';
COMMENT ON COLUMN actividad01.pedido_detalle.id_producto IS 'Id de la tabla de productos';
COMMENT ON COLUMN actividad01.pedido_detalle.cantidad IS 'Cantidad de producto';
COMMENT ON COLUMN actividad01.pedido_detalle.subtotal IS 'Monto subtotal que representa el precio del producto por la cantidad';

ALTER TABLE actividad01.pedido_detalle ADD CONSTRAINT pk_pedido_detalle PRIMARY KEY ( id );
ALTER TABLE actividad01.pedido_detalle ADD CONSTRAINT ck_pedido_detalle_cantidad CHECK (cantidad > 0);
ALTER TABLE actividad01.pedido_detalle ADD CONSTRAINT ck_pedido_detalle_subtotal CHECK (subtotal > 0);

-- Llaves foráneas
ALTER TABLE actividad01.pedido 
    ADD CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) 
    REFERENCES actividad01.cliente (id);

ALTER TABLE actividad01.pedido_detalle 
    ADD CONSTRAINT fk_pedido_detalle_pedido FOREIGN KEY (id_pedido) 
    REFERENCES actividad01.pedido (id);
```

### DML
```sql
INSERT INTO actividad01.pedido_detalle (id_pedido, id_producto, cantidad, subtotal)
VALUES
(1, 17, 2, 31),
(1, 29, 4, 100),
(1, 30, 1, 20),
(2, 16, 5, 325),
(2, 20, 1, 55),
(3, 24, 2, 91.98),
(3, 31, 10, 750),
(4, 21, 3, 261.98),
(6, 19, 2, 400),
(6, 10, 3, 2700),
(7, 6, 1, 100);
```

### Debilidades encontradas:
* 14. Integridad referencial. En la tabla pedido_detalle no establece una restriccion de llave foranea para hacer referencia a los productos.
* 15. Integridad de dominio. La columna cantidad permite valores negativos, lo cual no tiene sentido en la lógica de negocio. Se soluciona añadiendo una restricción CHECK para asegurar que la existencia sea mayor o igual a 0.


