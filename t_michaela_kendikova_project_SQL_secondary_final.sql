SELECT 
DISTINCT country  
FROM countries c
;

SELECT
DISTINCT country 
FROM economies e
;

CREATE OR REPLACE TABLE t_michaela_kendikova_project_SQL_secondary_final
SELECT
	e.`year` ,
	c.country,
	c.population,
	e.GDP ,
	e.gini
FROM countries c
LEFT JOIN economies e 
	ON c.country=e.country
WHERE e.GDP IS NOT NULL 
OR e.gini IS NOT NULL 
ORDER BY country, e.`year`
;

SELECT *
FROM t_michaela_kendikova_project_sql_secondary_final tmkpssf
;
