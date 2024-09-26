-- Count de vuelos por MM-YYYY
SELECT 
	FORMAT(df.departureDate, 'MM-yyyy') AS MonthYear,
    COUNT(*) AS FlightCount
FROM factFlight ff 
JOIN dimFlight df ON df.id = ff.idFlight 
GROUP BY FORMAT(df.departureDate, 'MM-yyyy')
ORDER BY MonthYear;