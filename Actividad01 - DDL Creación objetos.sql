
-- Creación de esquema
CREATE SCHEMA actividad01 AUTHORIZATION postgres;

-- Creación de tablas
-- CLIENTE
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

-- PRODUCTO
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

-- PEDIDO
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

-- PEDIDO DETALLE
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

