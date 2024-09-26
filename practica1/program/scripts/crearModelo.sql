CREATE TABLE dimPassenger (
  id CHAR(6) PRIMARY KEY,
  firstName NVARCHAR(100),
  lastName NVARCHAR(100),
  gender NVARCHAR(6),
  age INT,
  nationality NVARCHAR(100)
);

CREATE TABLE dimAirport (
  id INT IDENTITY(1,1) PRIMARY KEY,
  -- airportCode CHAR(3) PRIMARY KEY,
  airportName NVARCHAR(200),
  airportCountryCode CHAR(2),
  countryName NVARCHAR(200),
  airportContinent NVARCHAR(3),
  continents NVARCHAR(100)
);

CREATE TABLE dimFlight (
  id INT IDENTITY(1,1) PRIMARY KEY,
  idAirport INT,
  pilotName NVARCHAR(100),
  flightStatus NVARCHAR(15),
  departureDate DATE,
  arrivalAirport CHAR(3),
  FOREIGN KEY (idAirport) REFERENCES dimAirport(id)
);

CREATE TABLE factFlight (
  idPassenger CHAR(6),
  idFlight INT,
  PRIMARY KEY (idPassenger, idFlight),
  FOREIGN KEY (idPassenger) REFERENCES dimPassenger(id),
  FOREIGN KEY (idFlight) REFERENCES dimFlight(id)
);

