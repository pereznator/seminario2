SELECT 
    dp.nationality,
    FORMAT(df.departureDate, 'MM-yyyy') AS MonthYear,
    COUNT(*) AS FlightCount
FROM 
    factFlight ff
    JOIN dimPassenger dp ON dp.id = ff.idPassenger
    JOIN dimFlight df ON df.id = ff.idFlight
GROUP BY 
    dp.nationality,
    FORMAT(df.departureDate, 'MM-yyyy')
ORDER BY 
    dp.nationality,
    MonthYear;
