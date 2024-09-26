SELECT 
	dp.gender AS Gender,
	(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dimPassenger)) AS Percentage
FROM factFlight ff
JOIN dimPassenger dp ON ff.idPassenger = dp.id
GROUP BY dp.gender;