-- Top 5 de edades divido por género que más viajan.
SELECT 
	dp.gender AS Gender,
	dp.age AS Age,
	COUNT(*) as People
FROM factFlight ff 
JOIN dimPassenger dp ON dp.id = ff.idPassenger 
GROUP BY dp.gender, dp.age 
ORDER BY People DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
