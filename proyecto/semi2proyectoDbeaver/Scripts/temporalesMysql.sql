USE semi2proyecto;


CREATE TABLE temporalCompras (
    Fecha VARCHAR(255),
    CodProveedor VARCHAR(255),
    NombreProveedor VARCHAR(255),
    DireccionProveedor VARCHAR(255),
    NumeroProveedor VARCHAR(255),
    WebProveedor VARCHAR(255),
    CodProducto VARCHAR(255),
    NombreProducto VARCHAR(255),
    MarcaProducto VARCHAR(255),
    Categoria VARCHAR(255),
    SodSucursal VARCHAR(255),
    NombreSucursal VARCHAR(255),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(255),
    Departamento VARCHAR(255),
    Unidades VARCHAR(255),
    CostoU VARCHAR(255)
);
-- drop table temporalcompras;

SELECT * FROM temporalCompras;
-- DROP TEMPORARY TABLE IF EXISTS temporalCompras;

CREATE TABLE temporalVentas (
    Fecha VARCHAR(255),
    CodigoCliente VARCHAR(255),
    NombreCliente VARCHAR(255),
    TipoCliente VARCHAR(255),
    DireccionCliente VARCHAR(255),
    NumeroCliente VARCHAR(255),
    CodVendedor VARCHAR(255),
    NombreVendedor VARCHAR(255),
    Vacacionista VARCHAR(255),
    CodProducto VARCHAR(255),
    NombreProducto VARCHAR(255),
    MarcaProducto VARCHAR(255),
    Categoria VARCHAR(255),
    SodSucursal VARCHAR(255),
    NombreSucursal VARCHAR(255),
    DireccionSucursal VARCHAR(255),
    Region VARCHAR(255),
    Departamento VARCHAR(255),
    Unidades VARCHAR(255),
    PrecioUnitario VARCHAR(255)
);

select * from temporalVentas;

-- drop table temporalVentas;
