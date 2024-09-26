-- Count divido por estado de vuelo

SELECT
	df.flightStatus AS flightStatus,
	COUNT(*) AS "cuenta"
FROM factFlight ff 
JOIN dimFlight df ON ff.idFlight = df.id
GROUP BY df.flightStatus ;