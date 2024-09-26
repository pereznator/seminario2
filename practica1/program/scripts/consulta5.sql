-- Top 5 aeropuertos con mayor número de pasajeros.

SELECT 
	da.airportName,
	COUNT(*) AS Passengers
FROM factFlight ff 
JOIN dimPassenger dp ON dp.id = ff.idPassenger 
JOIN dimFlight df ON df.id = ff.idFlight 
JOIN dimAirport da ON da.id= df.idAirport
GROUP BY da.airportName 
ORDER BY Passengers DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
