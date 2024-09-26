-- Count de vuelos por país.
SELECT 
	da.countryName AS Country,
	COUNT(*) AS Flights 
FROM factFlight ff 
JOIN dimFlight df ON df.id = ff.idFlight 
JOIN dimAirport da ON da.id= df.idAirport
GROUP BY da.countryName;