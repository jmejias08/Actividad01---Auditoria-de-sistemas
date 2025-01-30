-- CLIENTE
INSERT INTO actividad01.cliente (id,nombre, correo, fecha_creacion) 
VALUES
(218,'Harold Shipman', 'harold.shipman@correo.uk', '1946-01-14'),
(193,'Luis Alfredo Garavito', 'luis.alfredo.garavito@correo.co','1957-01-25'),
(125,'Thug Behram', 'thug.behram@correo.in','1765-01-01'),
(110,'Pedro Alonso López', 'pedro.alonso.lopez@correo.co','1948-10-08'),
(100,'Javed Iqbal', 'niels.högel@correo.de','1956-01-01'),
(85,'Niels Högel', 'niels.högel@correo.de','2025-02-26');

-- PRODUCTO
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


-- PEDIDO
INSERT INTO actividad01.pedido (id, id_cliente, fecha, monto_total)
VALUES
(1, 193, '2025-01-15', 151),
(2, 85, '2025-01-12', 0),
(3, 193, '2025-02-13', 841.98),
(4, 218, '2025-01-15', 0),
(5, 110, '2025-01-13', 7600),
(6, 85, '2025-01-09', 3200),
(7, 85, '2025-01-01', 100);


-- PEDIDO DETALLE
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




;