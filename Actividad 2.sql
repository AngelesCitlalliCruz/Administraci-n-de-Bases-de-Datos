USE [AkirasBoutiques]
GO

-- 1. Clientes del año 2021

SELECT DISTINCT
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    CAST(c.email AS VARCHAR(150)) AS email,
    f.fecha AS fecha_compra
FROM dbo.cliente c
INNER JOIN dbo.factura f ON c.id_cliente = f.id_cliente
WHERE YEAR(f.fecha) = 2021
ORDER BY f.fecha;
GO

-- 2. Clientes de 2022
SELECT DISTINCT
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    CAST(c.email AS VARCHAR(150)) AS email,
    f.fecha AS fecha_compra
FROM dbo.cliente c
INNER JOIN dbo.factura f ON c.id_cliente = f.id_cliente
WHERE YEAR(f.fecha) = 2022
ORDER BY f.fecha;
GO


-- 3. Clientes de diciembre 2021
SELECT DISTINCT
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    CAST(c.email AS VARCHAR(150)) AS email,
    f.fecha AS fecha_compra
FROM dbo.cliente c
INNER JOIN dbo.factura f ON c.id_cliente = f.id_cliente
WHERE YEAR(f.fecha) = 2021 AND MONTH(f.fecha) = 12
ORDER BY f.fecha;
GO

-- 4. Compras de clientes específicos
SELECT 
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    f.fecha AS fecha_compra,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    d.cantidad,
    d.precio AS precio_unitario,
    (d.cantidad * d.precio) AS total
FROM dbo.cliente c
INNER JOIN dbo.factura f ON c.id_cliente = f.id_cliente
INNER JOIN dbo.detalle d ON f.id_detalle = d.id_detalle
INNER JOIN dbo.producto p ON d.id_producto = p.id_producto
WHERE CONCAT(c.nombre, ' ', c.apellido) IN (
    'Valentina Anastasia Huerta Corral',
    'Zayra Manuela Gómez López ',
    'Ana Maribel  Cedillo Núñez '
)
ORDER BY CAST(c.apellido AS VARCHAR(150)), f.fecha;
GO


-- 5. Producto con más vendido
SELECT TOP 1
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    SUM(d.cantidad) AS total_vendido,
    COUNT(d.id_detalle) AS numero_ventas
FROM dbo.producto p
INNER JOIN dbo.detalle d ON p.id_producto = d.id_producto
GROUP BY CAST(p.nombre AS VARCHAR(150))
ORDER BY SUM(d.cantidad) DESC;
GO


-- 6. Producto con más cantidad en stock

SELECT TOP 1
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.stock,
    CAST(cat.nombre AS VARCHAR(100)) AS categoria
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
ORDER BY p.stock DESC;
GO


-- 7. Compras ordenadas de más antigua a más reciente

SELECT 
    f.id_factura,
    f.fecha,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    d.cantidad,
    (d.cantidad * d.precio) AS total
FROM dbo.factura f
INNER JOIN dbo.cliente c ON f.id_cliente = c.id_cliente
INNER JOIN dbo.detalle d ON f.id_detalle = d.id_detalle
INNER JOIN dbo.producto p ON d.id_producto = p.id_producto
ORDER BY f.fecha ASC;
GO

-- 8. Clientes ordenados alfabéticamente
SELECT 
    CONCAT(c.apellido, ' ', c.nombre) AS nombre_completo,
    CAST(c.email AS VARCHAR(150)) AS email,
    c.telefono
FROM dbo.cliente c
ORDER BY CAST(c.apellido AS VARCHAR(150)), CAST(c.nombre AS VARCHAR(150));
GO

-- 9. Productos por categoría específica
SELECT 
    'Falda' AS categoria,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.precio,
    p.stock
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
WHERE CAST(cat.nombre AS VARCHAR(100)) LIKE '%Falda%'
UNION ALL
SELECT 
    'Pantalón' AS categoria,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.precio,
    p.stock
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
WHERE CAST(cat.nombre AS VARCHAR(100)) LIKE '%Pantalón%'
UNION ALL
SELECT 
    'Chamarra' AS categoria,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.precio,
    p.stock
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
WHERE CAST(cat.nombre AS VARCHAR(100)) LIKE '%Chamarra%'
UNION ALL
SELECT 
    'Zapato' AS categoria,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.precio,
    p.stock
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
WHERE CAST(cat.nombre AS VARCHAR(100)) LIKE '%Zapato%'
UNION ALL
SELECT 
    'Accesorios' AS categoria,
    CAST(p.nombre AS VARCHAR(150)) AS producto,
    p.precio,
    p.stock
FROM dbo.producto p
INNER JOIN dbo.categoria cat ON p.id_categoria = cat.id_categoria
WHERE CAST(cat.nombre AS VARCHAR(100)) LIKE '%Accesorios%'
ORDER BY categoria, producto;
GO

-- 10. encargados de las sucursales de la tienda Akira’s Boutique 
SELECT 
    s.nombre_sucursal,
    s.ciudad,
    s.estado,
    e.nombre AS encargado,
    e.email,
    e.telefono
FROM dbo.sucursal s
INNER JOIN dbo.empleado e ON s.id_encargado = e.id_empleado
WHERE s.nombre_sucursal LIKE 'Akira%'  -- Filtro explícito
ORDER BY s.ciudad;  

-- 11. Empleados de la sucursal Constitución

SELECT 
    e.nombre AS empleado,
    e.edad,
    e.telefono,
    e.email,
    CASE WHEN e.es_encargado = 1 THEN 'Encargado' ELSE 'Empleado' END AS puesto
FROM dbo.empleado e
INNER JOIN dbo.sucursal s ON e.id_sucursal = s.id_sucursal
WHERE s.nombre_sucursal LIKE '%Constitución%'
ORDER BY e.es_encargado DESC, e.nombre;
GO


-- 12. Clientes mayores de 30 años

SELECT 
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    DATEDIFF(YEAR, c.fec_nac, GETDATE()) AS edad,
    c.fec_nac AS fecha_nacimiento,
    CAST(c.email AS VARCHAR(150)) AS email,
    c.telefono
FROM dbo.cliente c
WHERE DATEDIFF(YEAR, c.fec_nac, GETDATE()) > 30
ORDER BY DATEDIFF(YEAR, c.fec_nac, GETDATE()) DESC;
GO