-- Q1. Over the years, are wages rising in all industries, or falling in some?

CREATE OR REPLACE VIEW v_payroll_dev AS 
WITH selected_data as(
SELECT 
	`date` ,
	industry,
	round(avg(payroll),0) AS avg_payroll	
FROM t_michaela_kendikova_project_sql_primary_final tmkpspf
GROUP BY  industry, `date`
)
SELECT 
	sd.`date` AS `year`,
	sd2.`date` AS year_prev,
	sd.industry AS industry,
	sd.avg_payroll AS payroll_current,
	sd2.avg_payroll AS payroll_prev,
	CASE WHEN (sd.avg_payroll > sd2.avg_payroll) THEN 'Increasing'
		ELSE 'Decreasing'
	END AS payroll_develop
FROM selected_data sd
JOIN selected_data sd2
	ON sd.`date`=sd2.`date`+1
	AND sd.industry=sd2.industry
;

SELECT *
FROM v_payroll_dev
WHERE payroll_develop = 'Decreasing'
ORDER BY `year`
;
