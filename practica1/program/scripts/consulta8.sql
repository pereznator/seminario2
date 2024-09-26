-- Top 5 de los continentes más visitados.
SELECT 
	da.continents ,
	COUNT(dp.id) AS visitas
FROM factFlight ff 
JOIN dimPassenger dp ON dp.id = ff.idPassenger 
JOIN dimFlight df ON df.id = ff.idFlight 
JOIN dimAirport da ON da.id = df.idAirport 
GROUP BY da.continents 
ORDER BY visitas DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;