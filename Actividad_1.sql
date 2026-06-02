USE [AkirasBoutiques]
GO

CREATE TABLE [dbo].[sucursal](
    [id_sucursal] INT NOT NULL,
    [nombre_sucursal] VARCHAR(100) NOT NULL,
    [direccion] VARCHAR(250) NOT NULL,
    [telefono] VARCHAR(20) NOT NULL,
    [ciudad] VARCHAR(100) NOT NULL,
    [estado] VARCHAR(100) NOT NULL,
    [id_encargado] INT NULL, -- Referencia al empleado encargado
    PRIMARY KEY CLUSTERED ([id_sucursal] ASC)
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[empleado](
    [id_empleado] INT IDENTITY(1,1) NOT NULL,
    [nombre] VARCHAR(150) NOT NULL,
    [direccion] VARCHAR(250) NOT NULL,
    [telefono] VARCHAR(20) NOT NULL,
    [edad] INT NOT NULL,
    [id_sucursal] INT NOT NULL,
    [email] VARCHAR(150) NOT NULL,
    [contrasena] VARCHAR(255) NOT NULL,
    [es_encargado] BIT DEFAULT 0, -- Indica si es encargado
    PRIMARY KEY CLUSTERED ([id_empleado] ASC)
) ON [PRIMARY]
GO


SET IDENTITY_INSERT [dbo].[empleado] ON
GO

INSERT INTO [dbo].[empleado] 
    ([id_empleado], [nombre], [direccion], [telefono], [edad], [id_sucursal], [email], [contrasena], [es_encargado])
VALUES
    (1, N'Sonia Alejandra Fernández Moreno', N'Calle Roble #507 Fracc. Las Mercedes', N'444 783 1225', 35, 1, N'sonia.fernandez@akiras.com', N'Pass123*', 1),
    (2, N'Fernando Calderón Ayala', N'Calle Dr. Jesús Díaz de León #438 col. Obraje', N'449 378 0921', 38, 2, N'fernando.calderon@akiras.com', N'Pass123*', 1),
    (3, N'Daniela Fernanda Díaz Ordaz', N'Av. de la Marina #6204, Marina', N'669 293 2059', 32, 3, N'daniela.diaz@akiras.com', N'Pass123*', 1),
    (4, N'Mario Alberto Jiménez Salcido', N'Av. Manuel J. Clouthier 525 col. Benito Juárez', N'333 784 1230', 40, 4, N'mario.jimenez@akiras.com', N'Pass123*', 1),
    (5, N'Yesenia Guadalupe Campos Rojo', N'Av. Melchor Ocampo #2528 Zona Centro', N'614 390 6721', 36, 5, N'yesenia.campos@akiras.com', N'Pass123*', 1),
    (6, N'Tamara Alejandra Bernal Ramos', N'Calle Constitución #106 Zona Centro', N'618 196 2954', 34, 6, N'tamara.bernal@akiras.com', N'Pass123*', 1),
    (7, N'Samuel Enrique Barrios Enciso', N'Av. Hidalgo #338 Zacatecas Centro', N'492 930 1250', 37, 7, N'samuel.barrios@akiras.com', N'Pass123*', 1)
GO

SET IDENTITY_INSERT [dbo].[empleado] OFF
GO


INSERT INTO [dbo].[sucursal] 
    ([id_sucursal], [nombre_sucursal], [direccion], [telefono], [ciudad], [estado], [id_encargado])
VALUES
    (1, N'Akira''s Boutique: Las Mercedes', N'Calle Roble #507 Fracc. Las Mercedes', N'444 783 1225', N'San Luis Potosí', N'San Luis Potosí', 1),
    (2, N'Akira''s Boutique: Obraje', N'Calle Dr. Jesús Díaz de León #438 col. Obraje', N'449 378 0921', N'Aguascalientes', N'Aguascalientes', 2),
    (3, N'Akira''s Boutique: Galerías Mazatlán', N'Av. de la Marina #6204, Marina, local 35', N'669 293 2059', N'Mazatlán', N'Sinaloa', 3),
    (4, N'Akira''s Boutique: Zapopan', N'Av. Manuel J. Clouthier 525 col. Benito Juárez', N'333 784 1230', N'Zapopan', N'Jalisco', 4),
    (5, N'Akira''s Boutique: Melchor', N'Av. Melchor Ocampo #2528 Zona Centro', N'614 390 6721', N'Chihuahua', N'Chihuahua', 5),
    (6, N'Akira''s Boutique: Constitución', N'Calle Constitución #106 Zona Centro', N'618 196 2954', N'Durango', N'Durango', 6),
    (7, N'Akira''s Boutique: Centro', N'Av. Hidalgo #338 Zacatecas Centro', N'492 930 1250', N'Zacatecas', N'Zacatecas', 7)
GO


ALTER TABLE [dbo].[empleado] 
    WITH CHECK ADD CONSTRAINT [FK_empleado_sucursal] 
    FOREIGN KEY([id_sucursal])
    REFERENCES [dbo].[sucursal] ([id_sucursal])
GO

ALTER TABLE [dbo].[sucursal] 
    WITH CHECK ADD CONSTRAINT [FK_sucursal_encargado] 
    FOREIGN KEY([id_encargado])
    REFERENCES [dbo].[empleado] ([id_empleado])
GO

INSERT INTO [dbo].[empleado] 
    ([nombre], [direccion], [telefono], [edad], [id_sucursal], [email], [contrasena], [es_encargado])
VALUES
    -- Sucursal 1: Las Mercedes (5 empleados)
    (N'Ana María López García', N'Calle Pino #123', N'444 111 2233', 28, 1, N'ana.lopez@akiras.com', N'Pass123*', 0),
    (N'Carlos Ruiz Mendoza', N'Av. Libertad #456', N'444 222 3344', 25, 1, N'carlos.ruiz@akiras.com', N'Pass123*', 0),
    (N'Laura Patricia Soto', N'Calle Cedro #789', N'444 333 4455', 30, 1, N'laura.soto@akiras.com', N'Pass123*', 0),
    (N'Roberto Hernández Cruz', N'Fracc. Los Pinos #234', N'444 444 5566', 27, 1, N'roberto.hernandez@akiras.com', N'Pass123*', 0),
    (N'Gabriela Martínez Flores', N'Col. Jardines #567', N'444 555 6677', 29, 1, N'gabriela.martinez@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 2: Obraje (5 empleados)
    (N'Pedro Sánchez Ramírez', N'Calle Morelos #321', N'449 666 7788', 26, 2, N'pedro.sanchez@akiras.com', N'Pass123*', 0),
    (N'Diana Torres López', N'Av. Juárez #654', N'449 777 8899', 31, 2, N'diana.torres@akiras.com', N'Pass123*', 0),
    (N'Miguel Ángel Reyes', N'Col. Centro #987', N'449 888 9900', 24, 2, N'miguel.reyes@akiras.com', N'Pass123*', 0),
    (N'Patricia Gómez Silva', N'Calle Hidalgo #147', N'449 999 0011', 33, 2, N'patricia.gomez@akiras.com', N'Pass123*', 0),
    (N'Jorge Luis Navarro', N'Fracc. La Paz #258', N'449 101 1122', 28, 2, N'jorge.navarro@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 3: Galerías Mazatlán (5 empleados)
    (N'María José Morales', N'Av. Marina #369', N'669 202 2233', 27, 3, N'maria.morales@akiras.com', N'Pass123*', 0),
    (N'Andrés Castro Pérez', N'Col. Playas #741', N'669 303 3344', 29, 3, N'andres.castro@akiras.com', N'Pass123*', 0),
    (N'Sofía Ramírez Ortiz', N'Zona Dorada #852', N'669 404 4455', 25, 3, N'sofia.ramirez@akiras.com', N'Pass123*', 0),
    (N'Ricardo Vargas Medina', N'Av. del Mar #963', N'669 505 5566', 32, 3, N'ricardo.vargas@akiras.com', N'Pass123*', 0),
    (N'Claudia Rojas Luna', N'Fracc. Gaviotas #159', N'669 606 6677', 26, 3, N'claudia.rojas@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 4: Zapopan (5 empleados)
    (N'Francisco Delgado Ríos', N'Col. Providencia #357', N'333 707 7788', 30, 4, N'francisco.delgado@akiras.com', N'Pass123*', 0),
    (N'Verónica Campos Santos', N'Av. Patria #468', N'333 808 8899', 28, 4, N'veronica.campos@akiras.com', N'Pass123*', 0),
    (N'Alberto Guzmán Ramos', N'Fracc. Real #579', N'333 909 9900', 34, 4, N'alberto.guzman@akiras.com', N'Pass123*', 0),
    (N'Elena Paredes Vega', N'Col. Chapalita #681', N'333 111 0011', 27, 4, N'elena.paredes@akiras.com', N'Pass123*', 0),
    (N'Javier Núñez Castillo', N'Av. Américas #792', N'333 222 1122', 31, 4, N'javier.nunez@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 5: Melchor (5 empleados)
    (N'Rosa Elena Durán', N'Calle Victoria #135', N'614 333 2233', 29, 5, N'rosa.duran@akiras.com', N'Pass123*', 0),
    (N'Héctor Molina Cortés', N'Av. División del Norte #246', N'614 444 3344', 26, 5, N'hector.molina@akiras.com', N'Pass123*', 0),
    (N'Lucía Aguilar Fuentes', N'Col. Nombre de Dios #357', N'614 555 4455', 32, 5, N'lucia.aguilar@akiras.com', N'Pass123*', 0),
    (N'Sergio Pacheco Mora', N'Fracc. Quintas #468', N'614 666 5566', 28, 5, N'sergio.pacheco@akiras.com', N'Pass123*', 0),
    (N'Beatriz Salazar Peña', N'Calle Aldama #579', N'614 777 6677', 30, 5, N'beatriz.salazar@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 6: Constitución (5 empleados)
    (N'Ernesto Vázquez Ibarra', N'Av. 20 de Noviembre #681', N'618 888 7788', 27, 6, N'ernesto.vazquez@akiras.com', N'Pass123*', 0),
    (N'Mónica Escobar Zavala', N'Col. Real del Mezquital #792', N'618 999 8899', 33, 6, N'monica.escobar@akiras.com', N'Pass123*', 0),
    (N'Daniel Mejía Arellano', N'Calle Negrete #159', N'618 101 9900', 25, 6, N'daniel.mejia@akiras.com', N'Pass123*', 0),
    (N'Carolina Bustos Cárdenas', N'Fracc. Los Remedios #246', N'618 202 0011', 29, 6, N'carolina.bustos@akiras.com', N'Pass123*', 0),
    (N'Luis Fernando Tovar', N'Av. Hidalgo #357', N'618 303 1122', 31, 6, N'luis.tovar@akiras.com', N'Pass123*', 0),
    
    -- Sucursal 7: Centro (5 empleados)
    (N'Adriana Ponce Alvarado', N'Calle Tacuba #468', N'492 404 2233', 26, 7, N'adriana.ponce@akiras.com', N'Pass123*', 0),
    (N'Raúl Ortega Montes', N'Av. González Ortega #579', N'492 505 3344', 28, 7, N'raul.ortega@akiras.com', N'Pass123*', 0),
    (N'Silvia Contreras Gil', N'Col. Tierra y Libertad #681', N'492 606 4455', 32, 7, N'silvia.contreras@akiras.com', N'Pass123*', 0),
    (N'Gustavo Mendoza Lara', N'Fracc. La Encantada #792', N'492 707 5566', 30, 7, N'gustavo.mendoza@akiras.com', N'Pass123*', 0),
    (N'Irene Figueroa Rosales', N'Calle Allende #159', N'492 808 6677', 27, 7, N'irene.figueroa@akiras.com', N'Pass123*', 0)
GO

SELECT 
    e.id_empleado,
    e.nombre,
    e.edad,
    e.telefono,
    e.email,
    s.nombre_sucursal AS sucursal,
    s.ciudad,
    CASE WHEN e.es_encargado = 1 THEN 'Encargado' ELSE 'Empleado' END AS puesto
FROM dbo.empleado e
INNER JOIN dbo.sucursal s ON e.id_sucursal = s.id_sucursal
ORDER BY s.id_sucursal, e.es_encargado DESC, e.nombre
GO

SELECT 
    s.id_sucursal,
    s.nombre_sucursal,
    s.ciudad,
    s.estado,
    e.nombre AS encargado,
    e.email AS email_encargado
FROM dbo.sucursal s
INNER JOIN dbo.empleado e ON s.id_encargado = e.id_empleado
ORDER BY s.id_sucursal
GO

SELECT 
    s.nombre_sucursal,
    s.ciudad,
    COUNT(e.id_empleado) AS total_empleados,
    SUM(CASE WHEN e.es_encargado = 1 THEN 1 ELSE 0 END) AS encargados,
    SUM(CASE WHEN e.es_encargado = 0 THEN 1 ELSE 0 END) AS empleados_regulares
FROM dbo.sucursal s
LEFT JOIN dbo.empleado e ON s.id_sucursal = e.id_sucursal
GROUP BY s.nombre_sucursal, s.ciudad
ORDER BY total_empleados DESC
GO

SELECT 
    e.id_empleado,
    e.nombre,
    e.edad,
    e.telefono,
    e.email,
    CASE WHEN e.es_encargado = 1 THEN 'Encargado' ELSE 'Empleado' END AS puesto
FROM dbo.empleado e
INNER JOIN dbo.sucursal s ON e.id_sucursal = s.id_sucursal
WHERE s.nombre_sucursal LIKE '%Zapopan%'
ORDER BY e.es_encargado DESC, e.nombre
GO


SELECT 
    e.id_empleado,
    e.nombre AS nombre_empleado,
    e.edad,
    e.telefono AS tel_empleado,
    e.email,
    CASE WHEN e.es_encargado = 1 THEN 'Encargado' ELSE 'Empleado' END AS puesto,
    s.nombre_sucursal,
    s.ciudad,
    s.estado,
    s.telefono AS tel_sucursal,
    encargado.nombre AS nombre_encargado
FROM dbo.empleado e
INNER JOIN dbo.sucursal s ON e.id_sucursal = s.id_sucursal
LEFT JOIN dbo.empleado encargado ON s.id_encargado = encargado.id_empleado
ORDER BY s.ciudad, e.es_encargado DESC, e.nombre;
