--CREATE DATABASE semi2proyecto;

USE semi2proyecto;

CREATE TABLE temporalCompras (
	Fecha NVARCHAR(MAX),
	CodProveedor NVARCHAR(MAX),
	NombreProveedor NVARCHAR(MAX),
	DireccionProveedor NVARCHAR(MAX),
	NumeroProveedor NVARCHAR(MAX),
	WebProveedor NVARCHAR(MAX),
	CodProducto NVARCHAR(MAX),
	NombreProducto NVARCHAR(MAX),
	MarcaProducto NVARCHAR(MAX),
	Categoria NVARCHAR(MAX),
	SodSucursal NVARCHAR(MAX),
	NombreSucursal NVARCHAR(MAX),
	DireccionSucursal NVARCHAR(MAX),
	Region NVARCHAR(MAX),
	Departamento NVARCHAR(MAX),
	Unidades NVARCHAR(MAX),
	CostoU NVARCHAR(MAX)
);

SELECT * FROM temporalCompras;
--DROP TABLE #temporalCompras;

CREATE TABLE temporalVentas (
	Fecha NVARCHAR(MAX),
	CodigoCliente NVARCHAR(MAX),
	NombreCliente NVARCHAR(MAX),
	TipoCliente NVARCHAR(MAX),
	DireccionCliente NVARCHAR(MAX),
	NumeroCliente NVARCHAR(MAX),
	CodVendedor NVARCHAR(MAX),
	NombreVendedor NVARCHAR(MAX),
	Vacacionista NVARCHAR(MAX),
	CodProducto NVARCHAR(MAX),
	NombreProducto NVARCHAR(MAX),
	MarcaProducto NVARCHAR(MAX),
	Categoria NVARCHAR(MAX),
	SodSucursal NVARCHAR(MAX),
	NombreSucursal NVARCHAR(MAX),
	DireccionSucursal NVARCHAR(MAX),
	Region NVARCHAR(MAX),
	Departamento NVARCHAR(MAX),
	Unidades NVARCHAR(MAX),
	PrecioUnitario NVARCHAR(MAX),
);

SELECT COUNT(*) FROM temporalVentas;
--DROP TABLE #temporalVentas;



