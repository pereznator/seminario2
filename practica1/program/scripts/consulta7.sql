-- Top 5 de los países más visitados
SELECT 
	da.countryName,
	COUNT(dp.id) AS visitas
FROM factFlight ff 
JOIN dimPassenger dp ON dp.id = ff.idPassenger 
JOIN dimFlight df ON df.id = ff.idFlight 
JOIN dimAirport da ON da.id = df.idAirport 
GROUP BY da.countryName 
ORDER BY visitas DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;