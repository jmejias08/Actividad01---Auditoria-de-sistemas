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

1. Integridad de entidad. Aunque la clave primaria está definida, no se utiliza un mecanismo automático (como una secuencia o autoincremento) para generar los valores de id. Ya que depende de la intervención manual y la no nulidad y además no garantiza consistencia en la generación de claves primarias.
2. Integridad de Entidad y Claves. El correo electrónico debe ser único para cada cliente. Hace falta una restricción de unicidad.
3. Integridad de Dominio. El campo correo no tiene una restricción que valide el formato del correo electrónico 
4. la longitud es inadecuada, ya que el máximo para un correo electronico es de 320 caracteres, por lo que en este caso podría estar dejando a posibles usuarios sin poder ingresar.
5. Integridad de Dominio. El valor de fecha_creacion no está dentro del dominio válido (fechas pasadas o la fecha actual). Ya que hay fechas futuras y extremadamente antiguas

## Hallazgos:

### Hallazgo 1: Integridad de entidad

**Condición:** La clave primaria está definida, pero no se utiliza un mecanismo automático para generar los valores de id.

**Causa:** La generación de valores de id depende de la intervención manual.

**Efecto:** No se garantiza la consistencia en la generación de claves primarias.

**Criterio:** Las claves primarias deben ser generadas automáticamente para asegurar la unicidad y consistencia.

**Recomendación:** Implementar un mecanismo automático como una secuencia o autoincremento para la generación de valores de id.

**Solución técnica:**
```sql
CREATE SEQUENCE actividad01.cliente_id_seq;
ALTER TABLE actividad01.cliente ALTER COLUMN id SET DEFAULT nextval('actividad01.cliente_id_seq');
```

### Hallazgo 2: Integridad de Entidad y Claves

**Condición:** El correo electrónico no tiene una restricción de unicidad.

**Causa:** Falta de una restricción de unicidad en el campo correo.

**Efecto:** Posibilidad de tener múltiples clientes con el mismo correo electrónico.

**Criterio:** Cada cliente debe tener un correo electrónico único.

**Recomendación:** Agregar una restricción de unicidad al campo correo.

**Solución técnica:**
```sql
ALTER TABLE actividad01.cliente ADD CONSTRAINT uq_cliente_correo UNIQUE (correo);
```

### Hallazgo 3: Integridad de Dominio

**Condición:** El campo correo no tiene una restricción que valide el formato del correo electrónico.

**Causa:** Falta de validación del formato del correo electrónico.

**Efecto:** Posibilidad de almacenar correos electrónicos con formatos inválidos.

**Criterio:** El formato del correo electrónico debe ser validado para asegurar su validez.

**Recomendación:** Implementar una restricción que valide el formato del correo electrónico.

**Solución técnica:**
```sql
ALTER TABLE actividad01.cliente ADD CONSTRAINT ck_cliente_correo_formato CHECK (correo ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
```

### Hallazgo 4: Longitud inadecuada del campo correo

**Condición:** La longitud máxima del campo correo es de 100 caracteres.

**Causa:** Definición insuficiente de la longitud del campo correo.

**Efecto:** Posibles usuarios no podrán ingresar correos electrónicos largos.

**Criterio:** La longitud máxima para un correo electrónico es de 320 caracteres.

**Recomendación:** Aumentar la longitud del campo correo a 320 caracteres.

**Solución técnica:**
```sql
ALTER TABLE actividad01.cliente ALTER COLUMN correo TYPE VARCHAR(320);
```

### Hallazgo 5: Integridad de Dominio

**Condición:** El valor de fecha_creacion no está dentro del dominio válido.

**Causa:** Falta de restricción que impida fechas futuras y extremadamente antiguas.

**Efecto:** Posibilidad de almacenar fechas inválidas.

**Criterio:** Las fechas deben estar dentro de un rango válido (fechas pasadas o la fecha actual).

**Recomendación:** Implementar una restricción que valide el rango de fechas.

**Solución técnica:**
```sql
ALTER TABLE actividad01.cliente ADD CONSTRAINT ck_cliente_fecha_creacion CHECK (fecha_creacion <= CURRENT_DATE AND fecha_creacion >= '1900-01-01');
```

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

6. Integridad de Entidad y Claves. En la tabla producto no existe una restricción de clave primaria.
7. Integridad de Entidad y Clave. En la tabla producto en la columna código debería ser único para cada producto, ya que identifica productos específicos.
8. Integridad de Atributo. El campo nombre está definido como VARCHAR(100) y permite valores nulos. Esto es problemático, ya que el nombre de un producto es un dato esencial y no debería ser nulo.
9. Integridad de Dominio. El campo precio tiene un valor predeterminado de 0, pero no hay una restricción que impida que el precio sea negativo. Esto es problemático, ya que un precio negativo no tiene sentido en el contexto de un producto.
10. Integridad de Dominio. La descripción de los productos permite valores extremadamente largos (hasta 10,000 caracteres), lo cual es excesivo para los posibles valores del campo.
11. Integridad de Atributo. La columna descripción permite valores nulos o en blanco, lo que podría generar inconsistencias en la base de datos.

## Hallazgos:

### Hallazgo 6: Integridad de Entidad y Claves

**Condición:** No existe una restricción de clave primaria en la tabla producto.

**Causa:** Falta de definición de una clave primaria.

**Efecto:** No se garantiza la unicidad de los registros en la tabla producto.

**Criterio:** Cada tabla debe tener una clave primaria para asegurar la unicidad de los registros.

**Recomendación:** Definir una clave primaria en la tabla producto.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ADD CONSTRAINT pk_producto PRIMARY KEY (id);
```

### Hallazgo 7: Integridad de Entidad y Clave

**Condición:** El campo código no tiene una restricción de unicidad.

**Causa:** Falta de una restricción de unicidad en el campo código.

**Efecto:** Posibilidad de tener múltiples productos con el mismo código.

**Criterio:** Cada producto debe tener un código único.

**Recomendación:** Agregar una restricción de unicidad al campo código.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ADD CONSTRAINT uq_producto_codigo UNIQUE (codigo);
```

### Hallazgo 8: Integridad de Atributo

**Condición:** El campo nombre permite valores nulos.

**Causa:** Definición del campo nombre como nullable.

**Efecto:** Posibilidad de tener productos sin nombre.

**Criterio:** El nombre de un producto es un dato esencial y no debe ser nulo.

**Recomendación:** Modificar el campo nombre para que no permita valores nulos.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ALTER COLUMN nombre SET NOT NULL;
```

### Hallazgo 9: Integridad de Dominio

**Condición:** El campo precio no tiene una restricción que impida valores negativos.

**Causa:** Falta de una restricción que valide el valor del campo precio.

**Efecto:** Posibilidad de almacenar precios negativos.

**Criterio:** El precio de un producto debe ser un valor positivo.

**Recomendación:** Implementar una restricción que valide que el precio sea mayor o igual a cero.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ADD CONSTRAINT ck_producto_precio CHECK (precio >= 0);
```

### Hallazgo 10: Integridad de Dominio

**Condición:** El campo descripción permite valores extremadamente largos.

**Causa:** Definición excesiva de la longitud del campo descripción.

**Efecto:** Posibilidad de almacenar descripciones innecesariamente largas.

**Criterio:** La longitud del campo descripción debe ser razonable para los posibles valores.

**Recomendación:** Reducir la longitud máxima del campo descripción.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ALTER COLUMN descripcion TYPE VARCHAR(1000);
```

### Hallazgo 11: Integridad de Atributo

**Condición:** El campo descripción permite valores nulos o en blanco.

**Causa:** Definición del campo descripción como nullable.

**Efecto:** Posibilidad de tener productos sin descripción.

**Criterio:** La descripción de un producto es un dato importante y no debe ser nula.

**Recomendación:** Modificar el campo descripción para que no permita valores nulos o en blanco.

**Solución técnica:**
```sql
ALTER TABLE actividad01.producto ALTER COLUMN descripcion SET NOT NULL;
```

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

12. Integridad de Dominio. El monto total debe estar dentro de un dominio válido (valores positivos mayores que cero)
13. Integridad de Usuario o Negocio: No se valida que el monto_total de un pedido sea coherente con los subtotales de los detalles del pedido. Esto puede llevar a inconsistencias en la lógica de negocio. Y se puede solucionar implementando un trigger o procedimiento almacenado que calcule y valide el monto_total basado en los subtotales de los detalles del pedido.
14. Integridad de Dominio. El campo fecha tiene un valor predeterminado (now()), pero no hay una restricción que impida la inserción de fechas futuras. Esto es problemático, ya que un pedido no puede tener una fecha futura, ni una fecha menor a la creación de la empresa.

## Hallazgos:

### Hallazgo 12: Integridad de Dominio

**Condición:** El campo monto_total permite valores de cero o negativos.

**Causa:** Falta de una restricción que valide el valor del campo monto_total.

**Efecto:** Posibilidad de almacenar montos totales inválidos.

**Criterio:** El monto total de un pedido debe ser un valor positivo mayor que cero.

**Recomendación:** Implementar una restricción que valide que el monto_total sea mayor que cero.

**Solución técnica:**
```sql
ALTER TABLE actividad01.pedido ADD CONSTRAINT ck_pedido_monto_total CHECK (monto_total > 0);
```

### Hallazgo 13: Integridad de Usuario o Negocio

**Condición:** No se valida que el monto_total de un pedido sea coherente con los subtotales de los detalles del pedido.

**Causa:** Falta de validación de la coherencia entre el monto_total y los subtotales.

**Efecto:** Posibilidad de inconsistencias en la lógica de negocio.

**Criterio:** El monto_total debe ser la suma de los subtotales de los detalles del pedido.

**Recomendación:** Implementar un trigger o procedimiento almacenado que calcule y valide el monto_total basado en los subtotales de los detalles del pedido.

**Solución técnica:**
```sql
CREATE OR REPLACE FUNCTION validar_monto_total_pedido() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto_total <> (SELECT SUM(subtotal) FROM actividad01.pedido_detalle WHERE id_pedido = NEW.id) THEN
        RAISE EXCEPTION 'El monto total no coincide con la suma de los subtotales';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_monto_total_pedido
BEFORE INSERT OR UPDATE ON actividad01.pedido
FOR EACH ROW EXECUTE FUNCTION validar_monto_total_pedido();
```

### Hallazgo 14: Integridad de Dominio

**Condición:** El campo fecha permite la inserción de fechas futuras.

**Causa:** Falta de una restricción que impida fechas futuras.

**Efecto:** Posibilidad de almacenar fechas inválidas.

**Criterio:** La fecha de un pedido debe ser una fecha pasada o la fecha actual.

**Recomendación:** Implementar una restricción que valide el rango de fechas.

**Solución técnica:**
```sql
ALTER TABLE actividad01.pedido ADD CONSTRAINT ck_pedido_fecha CHECK (fecha <= CURRENT_DATE);
```

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

15. Integridad referencial. En la tabla pedido_detalle no establece una restriccion de llave foranea para hacer referencia a los productos.
16. Integridad de usuario o negocio. No existe una restricción que garantice que el 'subtotal' de cada línea de detalle sea coherente con la cantidad y el precio del producto.
17. Integridad de usuario o negocio. No exite algun proceso que valide la cantidad de unidades en stock antes de registar un pedido, ademas que haga el rebajo en la unidades.

## Hallazgos:

### Hallazgo 15: Integridad referencial

**Condición:** No existe una restricción de llave foránea para hacer referencia a los productos.

**Causa:** Falta de definición de una llave foránea en la tabla pedido_detalle.

**Efecto:** Posibilidad de inconsistencias referenciales entre pedidos y productos.

**Criterio:** Las tablas deben tener llaves foráneas para asegurar la integridad referencial.

**Recomendación:** Definir una llave foránea en la tabla pedido_detalle que haga referencia a la tabla producto.

**Solución técnica:**
```sql
ALTER TABLE actividad01.pedido_detalle
    ADD CONSTRAINT fk_pedido_detalle_producto FOREIGN KEY (id_producto)
    REFERENCES actividad01.producto (id);
```

### Hallazgo 16: Integridad de usuario o negocio

**Condición:** No existe una restricción que garantice que el subtotal de cada línea de detalle sea coherente con la cantidad y el precio del producto.

**Causa:** Falta de validación de la coherencia entre el subtotal, la cantidad y el precio del producto.

**Efecto:** Posibilidad de inconsistencias en la lógica de negocio.

**Criterio:** El subtotal debe ser el resultado de multiplicar la cantidad por el precio del producto.

**Recomendación:** Implementar un trigger o procedimiento almacenado que valide la coherencia del subtotal.

**Solución técnica:**
```sql
CREATE OR REPLACE FUNCTION validar_subtotal_pedido_detalle() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.subtotal <> (SELECT precio FROM actividad01.producto WHERE id = NEW.id_producto) * NEW.cantidad THEN
        RAISE EXCEPTION 'El subtotal no coincide con la cantidad y el precio del producto';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_subtotal_pedido_detalle
BEFORE INSERT OR UPDATE ON actividad01.pedido_detalle
FOR EACH ROW EXECUTE FUNCTION validar_subtotal_pedido_detalle();
```

### Hallazgo 17: Integridad de usuario o negocio

**Condición:** No existe un proceso que valide la cantidad de unidades en stock antes de registrar un pedido.

**Causa:** Falta de validación de la cantidad de unidades en stock.

**Efecto:** Posibilidad de registrar pedidos con cantidades de productos no disponibles en stock.

**Criterio:** La cantidad de unidades en stock debe ser validada antes de registrar un pedido.

**Recomendación:** Implementar un proceso que valide la cantidad de unidades en stock y realice el rebajo correspondiente al registrar un pedido.

**Solución técnica:**
```sql
CREATE OR REPLACE FUNCTION validar_stock_pedido_detalle() RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT existencia FROM actividad01.producto WHERE id = NEW.id_producto) < NEW.cantidad THEN
        RAISE EXCEPTION 'No hay suficiente stock para el producto';
    ELSE
        UPDATE actividad01.producto SET existencia = existencia - NEW.cantidad WHERE id = NEW.id_producto;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_stock_pedido_detalle
BEFORE INSERT OR UPDATE ON actividad01.pedido_detalle
FOR EACH ROW EXECUTE FUNCTION validar_stock_pedido_detalle();
```