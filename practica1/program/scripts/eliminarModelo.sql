IF OBJECT_ID('dbo.#Temporal', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Temporal;
END;
IF OBJECT_ID('dbo.factFlight', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.factFlight;
END;
IF OBJECT_ID('dbo.dimFlight', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dimFlight;
END;
IF OBJECT_ID('dbo.dimPassenger', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dimPassenger;
END;
IF OBJECT_ID('dbo.dimAirport', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.dimAirport;
END;
