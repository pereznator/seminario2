CREATE DATABASE seminario2_201900810;

USE seminario2_201900810;

CREATE TABLE DimProveedor (
	ProveedorID INT IDENTITY(1,1) PRIMARY KEY,
	CodProveedor CHAR(5) UNIQUE,
	NombreProveedor NVARCHAR(MAX),
	DireccionProveedor NVARCHAR(MAX),
	NumeroProveedor CHAR(8),
	WebProveedor BIT
);


CREATE TABLE DimCliente (
	ClienteID INT IDENTITY(1,1) PRIMARY KEY,
	CodigoCliente CHAR(5) UNIQUE,
	NombreCliente NVARCHAR(MAX),
	TipoCliente NVARCHAR(9),
	DireccionCliente NVARCHAR(MAX),
	NumeroCliente CHAR(8)
);

CREATE TABLE DimVendedor (
	VendedorID INT IDENTITY(1,1) PRIMARY KEY,
	CodVendedor CHAR(5) UNIQUE,
	NombreVendedor NVARCHAR(MAX),
	Vacacionista BIT
);

CREATE TABLE DimCategoria(
	CategoriaID INT IDENTITY(1,1) PRIMARY KEY,
	NombreCategoria NVARCHAR(250) UNIQUE
);

CREATE TABLE DimProducto(
	ProductoID INT IDENTITY(1,1) PRIMARY KEY,
	CodProducto CHAR(8) UNIQUE,
	CategoriaID INT,
	NombreProducto NVARCHAR(MAX),
	MarcaProducto NVARCHAR(MAX),
	FOREIGN KEY (CategoriaID) REFERENCES DimCategoria(CategoriaID)
);


CREATE TABLE DimRegion (
	RegionID INT IDENTITY(1,1) PRIMARY KEY,
	NombreRegion NVARCHAR(250) UNIQUE,
);

CREATE TABLE DimDepartamento (
	DepartamentoID INT IDENTITY(1,1) PRIMARY KEY,
	RegionID INT,
	NombreDepartamento NVARCHAR(250) UNIQUE,
	FOREIGN KEY (RegionID) REFERENCES DimRegion(RegionID)
);

CREATE TABLE DimSucursal (
	SucursalID INT IDENTITY(1,1) PRIMARY KEY,
	DepartamentoID INT,
	SodSucursal CHAR(5) UNIQUE,
	NombreSucursal NVARCHAR(MAX),
	DireccionSucursal NVARCHAR(MAX),
	FOREIGN KEY (DepartamentoID) REFERENCES DimDepartamento(DepartamentoID)
);

CREATE TABLE DimTiempo (
	TiempoID INT IDENTITY(1,1) PRIMARY KEY,
	Fecha DATE UNIQUE
);


CREATE TABLE FactCompras (
	CompraID INT IDENTITY(1,1) PRIMARY KEY,
	Unidades INT,
	CostoU DECIMAL(18,2),
	ProveedorID INT,
	ProductoID INT,
	SucursalID INT,
	TiempoID INT,
	FOREIGN KEY (ProveedorID) REFERENCES DimProveedor(ProveedorID),
	FOREIGN KEY (ProductoID) REFERENCES DimProducto(ProductoID),
	FOREIGN KEY (SucursalID) REFERENCES DimSucursal(SucursalID),
	FOREIGN KEY (TiempoID) REFERENCES DimTiempo(TiempoID)
);

CREATE TABLE FactVentas (
	VentaID INT IDENTITY(1,1) PRIMARY KEY,
	Unidades INT,
	PrecioUnitario DECIMAL(18,2),
	ClienteID INT,
	VendedorID INT,
	ProductoID INT,
	SucursalID INT,
	TiempoID INT,
	FOREIGN KEY (ClienteID) REFERENCES DimCliente(ClienteID),
	FOREIGN KEY (VendedorID) REFERENCES DimVendedor(VendedorID),
	FOREIGN KEY (ProductoID) REFERENCES DimProducto(ProductoID),
	FOREIGN KEY (SucursalID) REFERENCES DimSucursal(SucursalID),
	FOREIGN KEY (TiempoID) REFERENCES DimTiempo(TiempoID)
);


SELECT * FROM DimProveedor dp ;
SELECT * FROM DimCliente dc ;
SELECT * FROM DimVendedor dv ;
SELECT * FROM DimRegion dr ;
SELECT * FROM DimCategoria dc ;
SELECT * FROM DimDepartamento dd ;
SELECT * FROM DimProducto dp;
SELECT * FROM DimSucursal ds ;

SELECT * FROM FactCompras fc ;
SELECT * FROM FactVentas fv ;

SELECT COUNT(*) FROM FactVentas;
SELECT COUNT(*) FROM FactCompras;